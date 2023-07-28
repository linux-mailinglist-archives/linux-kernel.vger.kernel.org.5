Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8908D7666BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjG1IRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjG1IRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:17:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C31E0;
        Fri, 28 Jul 2023 01:17:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1jS1n020238;
        Fri, 28 Jul 2023 08:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MxSc0Jeox51bYuqMiGSKl2JxnEiv3qq5d6wWCXDQsLk=;
 b=H7OgWuRwM+5Fo6TByc+Z4NXqoDhyIT6yuksRiGEfIDuaHWXFv5U71ScnAZs49ZkDceEd
 D/i2oNFRu8Fi8xfQ2e2IU6y6HF+8W3eBkWOfZe6q7DvpQUfdu8FOTRCQGgHUCPjxdYGB
 lJ6cPMr+JrLt+MAnPRkcvLdDhECZCF5GU5YJdsEpBoFHnMUHqF0QupkCYZ9f0UEpNMKs
 wAdsyv6JBujCtfIbZy6ItIcbIHI7rBwk07fOlRWCTGBsnE2X1pTeMPI0Zv7J1krn7vXT
 W1jQ+7GZ1XPFcYoxMiG/DY/iBW9hTfPhNpbTTcqHa2CNHP4AI3Z72G5/9DfM4qAhY37+ qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3udsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:17:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S73fKH011782;
        Fri, 28 Jul 2023 08:17:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8yw1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfF19uWhY6YMHRgOrqVW67sCjlyLSnVcKpAmNu2kcqRK485Q+PSnrVchgxWsaVlueNu1cfpLdpDVscViT4Prs1ttddaUaH9BBS0iTBmm1iG+TdgE28pXVN8oVyfklrtdKepKv8pxYKkcf1dfWhEh2+llBv92snwdY3lTayp2RQ9Jb/IKbAQfccLXLSNUg04ILazqO8TnpoJQL467xCMZSevwMwwYV2NaXY6hGfg7swUQYgw9HtgguPj8cqWJxoDkYaZW+UbF/ZVX8LysCin9evM1ONDnoqt1VL+YIL4Ej0Tpi2x4MjgK/7CbgBcTiLKCc8pvwFXJ6nKaXUzN4H7BMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxSc0Jeox51bYuqMiGSKl2JxnEiv3qq5d6wWCXDQsLk=;
 b=Nz2uvYU0UHlTf8aNyPFUV0Shdyn3EZ58hrcN0UG+9jINUD4FoE9tFDh58nVe9dpZw4t+hS0PA3Lm6kFhEcwEHHfH/9HmdiFgrqARQLPyAo6RMrbA/6k0yeVFvFyRCpDn5aab1g3XzbRzOPNvxkB717FQG0LkTZ0jGgILNE3V9JPGUANxTVBBFgCD55eMq86g1rQvfDgZdRjXM37LkTgrtZGTHBdSfkimRhyABRA1ZydQ+qEpK8i+2840IiMw2+eV/o38ghr/yB34LWd5qKr4chUHQR80P6RStFxg51BWLhJcY4/VOn4FAWXs+qeLi0zWLwKu8ueRDhHqpbqdW92Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxSc0Jeox51bYuqMiGSKl2JxnEiv3qq5d6wWCXDQsLk=;
 b=pa+rygfGBBXQ0mXUtcJseolYsrTcDVzIpTAh4X4gwixZByOV6aqrT1GIvdLd8xzyg0MPO5Ruwv5giuIhwmCWf1XCB3RWJzkqdAMd3oTtEtuWOR9iwGjCRyDlzdGsySaO2r9ghTHZMg7OIRP0u/HZrgsmwnfTQ4Ko8pJbgRCIG7I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:17:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:17:18 +0000
Message-ID: <01f793eb-6373-e6c0-a712-9e08ee3c91c8@oracle.com>
Date:   Fri, 28 Jul 2023 09:17:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 4/5] perf jevents: Add support for Arm CMN PMU aliasing
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-5-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690525040-77423-5-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 612f94f4-a7c3-4742-a657-08db8f430efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEo6+ZlwilCL5OMC7ZaAvqbZn61KpIbkIaxhGKQbPNMo0NdJ7vczF6J/jXwUI/mrdL1UzQY+wGOsBS/fdu0048Ihw0Lc+m5x/UiWrmLNh8ERaTzFHOB9NfDf+rQIQnwqc0zq+7Oi4NV+0FwkzR/BOl4tgtiMSTAUphmuCR8K9+gGNVt4OT2WFIM/QGOOEnFImvAPu1bDq+vIOg/g8cqi231cyM9QN9tHeN2dWyCS6nASBNAH32Vtm+CqR1JdVsY7NigpFGDL785PbMGRrbBkSFIz94+Td0lAKqHu6Vx1jt16IxQjQCQQ0cAKJ+6CUKqTDTX+cvsAzFFX8Y5//FuPxHU8YLuMKzNnoMcFL1BJ0IMlLzpnyNYPPYDBeBEqz7nLKSfYzXjLanV74/A6MjJFouTyR8xq7kTQAHAZ5+JVr5Mer88Hf+6qEHopSepJhiBvuV03BbG5PIJiERD46plq3P90arnjlnNvAUBbxvGmnbDWBsrmFHU85N8sC3i8JEp4X9yA5k/vtlp5WXb1BdkXh99+iLqSJ+VCwylUsFMHuE6rmt+IQKJDfzDKjh7r1TMfJUQyOmYyrH3wUldL+bn8Vx4dewW80JZDKwxSbqsTmJ1FUiOGqgEl3TSMslysrtMV8H7diKsZMEdzf32uiVWdRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(4744005)(54906003)(110136005)(6666004)(36916002)(38100700002)(2906002)(6486002)(478600001)(7416002)(316002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(4326008)(66476007)(66556008)(53546011)(66946007)(31696002)(186003)(86362001)(6506007)(26005)(2616005)(31686004)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c28zS0xwZ0g0RVJ4WUIxN3hTdVQ1a1JMQ0ppaUQ3Qk92QlE0UXRaMHFpb1pI?=
 =?utf-8?B?UlhDZVNHOUhTaGUrYkNVSTRuT2JNaVN2NldaWUIzV0E5cGlUdEV1L2hWcDBy?=
 =?utf-8?B?VVhiS3hqTGFuRjhYU0hxdFpMRzNiaUhLV0gwaDlzcmlMWk13WXNFUU5jMUZz?=
 =?utf-8?B?L21mMElRZnRIVS9zeU95bElBTHZTOXZYeDlIaXFCWk9IYUFhNHRxVkdrVVRp?=
 =?utf-8?B?L3pHRDRYemlHRUVwWmRyRzY3UWd5d25BTmdnWDVWTGI5TVdTNllVOTZQS2Nu?=
 =?utf-8?B?ZEhKbTdwUjdvSkxkOHZMMHhWdjR4TllNeStiRUZlbHpSYTFHTlpqVlFCVTgv?=
 =?utf-8?B?a0Jsc3RSTnFjREkyZ09ObmpjS2ZTdzc2MmJMTGJmRm5Jdkh3N1lxS0U0RFRk?=
 =?utf-8?B?SFFKeXdyRityOWl1dWlhUFBYbzRPV2tKODJTd0w4M0JFb3BSYTcwZTJqa2RR?=
 =?utf-8?B?QTBTb3pQb29MY0lWQW81ZWhlNXhDNVVHSTZ6VU9kRlNPWXI2dEFvUWlibFBa?=
 =?utf-8?B?bzk4SXhXL1RpT1NPZE43ZWEyQk0wcUJESVMvOUZJMlgvNDJKcXMySkVHaXFV?=
 =?utf-8?B?M1Iyclh5ZTJmTmRCZnQyaWh5ZHlHeExpOFNsUTVOK3pmc2VRSitTY0xHUmk3?=
 =?utf-8?B?UlRQRFpIV05rUXpmbUZtMUIvK0VPT0xJdGN3KzZUWit2U25BZWdYNzEwc2p6?=
 =?utf-8?B?RXM5NW9kckhIVlZCMUNHRkxzVmFIbnE3MFYzS0lvY1hZSUtmT0lxc2tGZnho?=
 =?utf-8?B?UDRSZGF5alFRTUYrZFhTQTcwNTJVdm9FaTlSOWM0MTRIK0Zid3pNazJOOVdo?=
 =?utf-8?B?Tk16Vy9pa2hZZzl4ay9zWTVFb0hMUGNNYlJocVVwYUhuSWFkRTk2SnF4OGNo?=
 =?utf-8?B?MVQ4MFh0UHVmM0I2R3hCMEEzZU9IVWlEVWpJTUM1dnlWL1dqd29ZTlZRWmc0?=
 =?utf-8?B?UUs3b3F5UVUyRDRkT1hJMElCRW1rQi9RVEFGck1GNjIweXRpN0h1a0NXMVpF?=
 =?utf-8?B?SXVCVWtBeS9uaklPMFlxUkZTcC9hSnVqbWV1TWhQaE9VYmRtNEwyYndVNHRY?=
 =?utf-8?B?MXVNaDFwTitITVhEdmRCYzgrdU1hZHNXaHBVSmlVZlBEbk1XbUM3RkNVbThl?=
 =?utf-8?B?Rm9WMDJVWWNZR1c3dSsrWGRObHR4a1YvRXZkaHFHMVRtdjA3ZEhydEZSQW94?=
 =?utf-8?B?bXNNUXBmN1duRHV2YzlJWTZFeEdubTVvRURhOEo1QXZoQTBUQlVPbGdyY0ZG?=
 =?utf-8?B?ajJaK3UyZi9KelZDZWpMTEw3b212Z0pXSExhWFV5YWFDRzQxVDZJK1ZSS3gx?=
 =?utf-8?B?N0xrNStYeGlXOE9vcWJLZ09vSERMZXVWd0NVOXQvZjNjWXVuYjFXM2NNTlZY?=
 =?utf-8?B?d0x4ejd1MjFMK0tURGhYV3hlMnMrM2ljZW9OWUNmUm91enRLN25NSUZFb2Zu?=
 =?utf-8?B?N1VSQXJhdTViVHFtN2dmeDJIZ1ZlZENhamR2TDlKVEdBa3U5Y3dWN1VYYk1l?=
 =?utf-8?B?eGpxZVdhM1FNOXpTeEZpTzR4cGlOMHZNT04zTElvY0F6M3VWZEorZ3kzRnhx?=
 =?utf-8?B?TnRWWUdLd0dMWEVPSWpKbkU3MzA5elE3b0NLWFRabHF1SHhPeHYrWHYxQnFw?=
 =?utf-8?B?ZU1qRnUvMkF0UWJIOXUySmtwTXlFMlZWQzZnUFFHRStpZm4zWjQwblZRYWJV?=
 =?utf-8?B?Y1ZLY09ycUxTMjBVYWJVTGp4VExpOUx0TGRxMGZ4NkZVNVAvRXpKU0R3bnRF?=
 =?utf-8?B?R1hKNUNXeXZGWHdKaFFNS0lsWEc1N3hJTFE5NDZqekpHYmhrVmZrTzZyQkd2?=
 =?utf-8?B?VUZBN0dQdXo3THVySHkycEF2VjhLbnZzdUlyWlVteHkveUk0OWptdEZBMlZt?=
 =?utf-8?B?MjVjWkc3eExTY0w1akFPTEJvQ3VyL2pGMzRDckk2Mk82VExmVTlmQVlHRHRJ?=
 =?utf-8?B?eVYwODZEWVpyb0k2YTN5WCtSNmFEc2x2TzFiOTdnSDNiUVEzeWpLSXA3U0c3?=
 =?utf-8?B?UzFyL3g3MnVDOTFjT01ObUo5MCt5TnZKTStBR0FadVFEdEVJbFNYVWpSWWY1?=
 =?utf-8?B?NVFSUFZUSDZHbC9Rd3RhMWVlb2g4OXg4NmlYV3gvTkFGck8rZXlKeUsvSnhV?=
 =?utf-8?Q?kD/MtT6t5iqOeZNTU2YatG0o1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N0tFckRXaTlBM0FWMVFONWtHb241MG5FK0MrclcwaDlEeVRxcXIrNkp6VDdU?=
 =?utf-8?B?UWw5R3pHSXRVVUJPa3FuaDVWSEMzN1YvcGJqZkZ0dytMbzNmWTdrYVVVbkJi?=
 =?utf-8?B?ZVZ3S25pc0ZUS0FZY3AyQ2JSazF4REVTRERNTnYwSTc2VytURW5qTXJPL3V0?=
 =?utf-8?B?cE5zU3FkQUhqaVNkRVJrSVEwajlIWlVNZ25ZazM2emYwa3Y4YjF3bm02Vm10?=
 =?utf-8?B?Q3Fub2RmcDg2Z1Rmcyt5OU9LQnVwL3UrbDNDVjJaSUg1eE9sNHZRalBESzNB?=
 =?utf-8?B?bEtDTFZXYll0UURhS1cybkdFRFRsS3hlQkh2bHQwVkJiZ203UzM1eVl1Ylor?=
 =?utf-8?B?cnpqU3JDVWFESTRaWDBkT0RacnVRQkExT0p4YXFEQzd5clJwZzVCVkFBT1lV?=
 =?utf-8?B?WElTNFJJT29qeG5KclBWd21nUUhxelZxeFFCa3B6c3BlM1p6Wkh1N2RWU3Rx?=
 =?utf-8?B?UzhheVFyWlBsK0dtQkZXSFBHMlpiMi9rdS9UbXRCQWJyd0N0N0lvK3hOaXp1?=
 =?utf-8?B?UmpjQXlqeVZSZjQxcmNENWxGZ2thMVEybTVjRUlYODgvajdVYk5jUzRndk9v?=
 =?utf-8?B?M0ZNT3VXZmxGUkFvNTlubFJkTmlMNzJ4ZnBCTFN3TUJmbmk2aVpJU1hUbTNr?=
 =?utf-8?B?bEVsTGh3dGVXZkRCWWhIRUpleklOMUNmMmdxQlE0NndnTmxqZjZ2SHdFTXNX?=
 =?utf-8?B?Z000Rm9oNDFqNzFpbFg0SVVnOHgxV1V0cWcvWkpKMi80eHo3cG95NUFLSnVy?=
 =?utf-8?B?TkwyV2thZU9rTGE2bHFrNCtUNlBOMERKRXMwVzZVZGlYLzMzMkpReXZObkw1?=
 =?utf-8?B?WjY2MTliN0VCaHVEUW9IMnVHcUx3K1UvVGVPK1NkaldiSVZqMEtlS1ZxT09h?=
 =?utf-8?B?ZElPSzB2UkozcklrTjJxSkEwUzZzUmdaU3p0ZlUxdDV4WVhTOTh1K0FsSXJt?=
 =?utf-8?B?TmplRUNOc3BUVUJWaENSNkpCV1VmcHU2REdYV25CWVcydXlMLzByWFNuN0xN?=
 =?utf-8?B?MXhma2JXOEdORVdVQ3Z4Zy9LZ3E5anpoaXN6Z2huRXFiNnpWS3pzSGs4T2lP?=
 =?utf-8?B?ZzE2Y2hPcEhhQllNRXNpYTlieDZlTHhaczBXMUplUUVFYkdZWjNMa0wrOXFN?=
 =?utf-8?B?OHBhU0xKMndOOElxSEp4cDErcEt2eUpjRjNEMWxGVmJpdE1pWC9PMU9OSGVR?=
 =?utf-8?B?dlFScERTREc0bElYUlh5RmdXSmRQYUtTVnBCZHVTT3lJa3VLMmNEWlJkbGFo?=
 =?utf-8?B?MS9WR3NvaG9NUkk3M3VzRUl1Q3hPaUh1MGpzNmU4b2hsVVZiNkoycllUS1Zm?=
 =?utf-8?Q?tdqsxzN29e74Fer+wS9EqsCp/6N0P7JP5C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612f94f4-a7c3-4742-a657-08db8f430efb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:17:18.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feHMNLX8GME0C7YJRWmEgFIjsS2ahFxm7N8F8pgO00zPdqO2ECGkXh3bIL+3Jgln0nwIN7xfnRkzGq9HoLGlPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280074
X-Proofpoint-GUID: kx19H3ZiBzmIjFgj5kP1EBCuiRMlWmeX
X-Proofpoint-ORIG-GUID: kx19H3ZiBzmIjFgj5kP1EBCuiRMlWmeX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 07:17, Jing Zhang wrote:
> Currently just add aliases for part of Arm CMN PMU events which are
> general and compatible for any SoC and CMN-ANY.
> 
> "Compat" value "434*;436*;43c*;43a*" means it is compatible with all

As mentioned in patch 1/5, a comma-separated list seems a better 
delimiter to me

> CMN600/CMN650/CMN700/Ci700.

It would be good if you could provide a link to where you got these 
events. I think that it is the publicly available CMN TRM document.

> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

Apart from comments, above:

Reviewed-by: John Garry <john.g.garry@oracle.com>

