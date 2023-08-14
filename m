Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4CB77B95B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjHNNDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHNND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:03:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DCE7D;
        Mon, 14 Aug 2023 06:03:27 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiPUn019954;
        Mon, 14 Aug 2023 13:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wBOt2ROfqXbeX9OPPX0QFrnrg/Q/z8lccH3jUZFDrlw=;
 b=Q3ut55dc30d63Em+EzxN8nA3TFyT40FOCU/fP5as3/kkpGrmeGjFowyqnarkobO1QoCD
 n3oly7HBAg57PFjQVAUwdxsQMkKkRHKuZ+Tlwof8Mfb5FxZkAU0hUjv1ME23wfxqnRm2
 gw92gUuJDh8jGnxcs+Q32z7WkY2oRDkfMsipPkfDSQdCFnEJmuzcwBjnCtH4OP1pFcVa
 iKfRxYaSgHomqb2/SEtwEZtxdokfIZHZZiJyL5AiTtAKGzuVPhswlWX7VRGxpjJBobFc
 Mp5H8A62h5GJIL13ESRFT5K40IUPJlsjb07TUHTaARkYaa8OZk4UeAMpT61enESJOC9H Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30stj2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:02:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EBQ3uG005541;
        Mon, 14 Aug 2023 13:02:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2bur0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 13:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5mh4XZInUxq3+cdJrOviN7jLOApWS5QaUrr4K7mvM1zDRG8AmYIDHowFwwVdttYoXmqP1vMgKU39dLXXVXWLb9JDSES/08RpbhEBpMr6p8Y5/AbnE8CluavYGRBxfmySdgjc7pO++GYiSw/PKe8Tdi3JBIYMetXrmf94nop9redZrlWSmopKoZK0M/iqmauUefK2fDTATLx6mqYj/cT6+c2Af/D9mciZWg4b2SmjMaD7cNJEfwfoM/rvqoDTU74N59dp/GipbUMmX8ZxhcjoXfcjy6bPRZ8fS42qY2ZZEWMkN5ydSDVJleYWDMmY6NRQHCOZCfXuw44Yd0DmAIM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBOt2ROfqXbeX9OPPX0QFrnrg/Q/z8lccH3jUZFDrlw=;
 b=OaJAkwqpDBrh7PYWsdDFRdxj2mFrED8fGvgMO+DaJwWm/PM5vrC6LhB7ELN78IPXdX5HC+yhHwlPHeHzG51PPqFBM2AIlTL3qVrdq+H88sCY0Xjwynmla0ShiuCeeCvhYRVux4lebTt1PVHY1vodUT3dLuUm+iqt3F79Sd6H2Jp3sOsdTvpUc/s12pHKVvK0V9+h968HlKikNMjWH1RupCskzew/VCWX9myVOJh55MO4LI67F62tHQta4+bIU1qM7S1fZ2gh//+hnV9uUdET9I1RtWM7NjPYnLSTr0DeWIuX3OaFqiIff44nv6I1AONfwjSVV3iK5lCbjcVf8jfH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBOt2ROfqXbeX9OPPX0QFrnrg/Q/z8lccH3jUZFDrlw=;
 b=ENj4uncbG8H+2bQX9UbjycJOjNThVqk6HRgm+aFxNGAjQNhZy3CbotMITLmyEW5s309twanS3KKzEFgaE6Mdd44+EneBY+Ae0fAysFPZ5eA1V9f2FY1vN1mudIHR64uzTPP4xfOACEUBDst8zDQI48+v5YK9X5tO5nJRKSQBWZQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7022.namprd10.prod.outlook.com (2603:10b6:806:317::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:02:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 13:02:40 +0000
Message-ID: <8a4ebdbc-c2c9-9f61-329f-8fd235f5f65c@oracle.com>
Date:   Mon, 14 Aug 2023 14:02:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 5/6] perf vendor events arm64: Update stall_slot
 workaround for N2 r0p3
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-6-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811144017.491628-6-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: a120b2b1-8bb7-4340-0187-08db9cc6bdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkqnExx63L6+MWeUgryt5yq77r7RPS/8fpD5rMoYjd4jFmxsAkX94GjDQYyWBdnPiISYW529AteQapzfpgioONdKd/2XIE7olsk6iVBtfDD9WUIOQyXIzzNWcnEDukAVBkH97zgXm6Y/Tx+EUN4/3XqyGG0YzJ5OeLeNW9V6IPzuhKmvGY/4IhXwBINqFjAw8Vnh0qvGexEVN1gBC4bEhYQhYpB6hlj/UpI0NDHf1dac70WXVstqc7AzvFz6DlYoIs3wN4eihfeQkAAMVQWbmuL9YdYFge7N4S5nF664K8dq7+wf0kFmfL7ZT4uiA4EQwKUcHQ9xIZxqu12I2WAdgd92vEZWtUemwQIkdlh/GP7mJu2e09VfWSXRUV1NQqKqurxAGWtL/KpkvkVeVLhHGNJmpUnpHDtAxgIldNFl73QLy5PQLm7h22omOlaFxrjgwOI9XFG4Fm0wB3zMsCbTdthvQ/4mJlU2umDSLJfeLzVzD/VGxDcelRIWDT4CTDCoBMLc6ys6LL5UpCIHxXauJVtWyNd//cpauyY/E4TTOHBUhdHAZEQyCFyvDYxX2/xg7JiadpqywJ782P480YyAkG5vkXKQPgHydhuFgu52ABIvmSMhecUXh2iK4NT4cQ4MJX4/kUw9RpuSKxrkvvRQlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(4326008)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(36916002)(8676002)(66946007)(54906003)(41300700001)(66556008)(6666004)(66476007)(5660300002)(26005)(2616005)(31686004)(31696002)(36756003)(7416002)(83380400001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1N5dHRTckhNekNsdXN1azNiaWtvNjY5SXBncy8zdUdTalhXQXRyNGQ5dEFT?=
 =?utf-8?B?OTRQUmkvYU03a2tvVnhyd1NlUXJ2Z2gwZHlIME8zdUhsYXo3V2hXK3kwa0h1?=
 =?utf-8?B?akplUG1iemRPc3AraTF5bmhvNi9URXcyVUlPdGxFaFdGZ2J5UVB1bFNlZjRB?=
 =?utf-8?B?OUsyZjQyditUL3hvVCtWcFRhRCswdWJxSm1SOVZnOWFEVUV2aE5HSHA3TzZL?=
 =?utf-8?B?am5lSHE1cDY1SnRYc1RZNVZvLzV3bnFzcFd6a0NPVExpQnRGc2E0QkVLSXo5?=
 =?utf-8?B?V2lxM2toeTRPWTgzS0liOW8rajRxOG5JS0dtQ25laDVKM2JZaVVzcGw3MGw2?=
 =?utf-8?B?NFNEU0FPbFo3TzN0MVJiQ24rQWJTSEVUVkEvWGcyVWxjU1VaaTl1SWwrdGR0?=
 =?utf-8?B?SUo0TWlKWWJVT0ZJVW9rUUs3UEI5aGZnRkpYYlhXdzRSN2djQ3JNVnVGR1Zj?=
 =?utf-8?B?b1BIelV1RHpRcU84VVdXMUFYbkdIZ25hWmtlTEsxMVArOStDTUF6NGJTZnlz?=
 =?utf-8?B?TjZOYjVtRTY4QWU5SmliamY5S3FzRENOWWZndVB5cVdwRGtZeXZaQnQxMGto?=
 =?utf-8?B?aXl4WnBCZnprby92TE83elZjdFVXSTJYM0JYeUhoSFFibmZsb2tkZzJ4eVRt?=
 =?utf-8?B?eW1Ra1RycWE3TytGN1NjRkk2bXlIUTNBOW9jWDYwcmkyZGhNUkh2clRGZWR3?=
 =?utf-8?B?dVZlckR2dWRmcXdMMkg3UmVDUkFwc2x5WVo1ZitISUJ2bk1xUlcvNmF6U0tj?=
 =?utf-8?B?MzFka2xPbmI5L2JCRTMzY1B2bVY3N05EcnBvdHM5VkhCc1Z6ZnlIclpOcjNn?=
 =?utf-8?B?Q1pYajVkcEhpOWgvdjdBb0xjMC82YnpvWlVJUTdYaElHaFNVd25qcUlLY3lz?=
 =?utf-8?B?cTBkcmRXdU9BN25EM3NWZHMxTGtNeEgvWmxhTEoyNjFueHp5QWl1ZFpOSlI4?=
 =?utf-8?B?ZFdtUEZ0QUN4TmsxYytqUGJWVEN5SkNra2NsQ1RoODB2S1F2TEdsMGE5L212?=
 =?utf-8?B?ZDVyR1dacVBPbjQ1S0xvdHR4Tk5DVkcxNjZzby9abXc3dEh5Nk9CYXNrV1d6?=
 =?utf-8?B?ZzBoeWRoRlhzMVdHKytnL3JHamNHWXVUTm9wWGR4NlhxYmJxeUlZeVZMTHBV?=
 =?utf-8?B?QUk2N01HSC9nZjJUakJ6enlmRWdVRG9OamZrdjREeU8zS3k2VWNwS0N5TE5V?=
 =?utf-8?B?bkJKUXdKWVU4ZGR6T1VSbWZhSWJXQzF1S1BoMGpmQStmTUdmU2JrRXoxK3kx?=
 =?utf-8?B?bzlObktQRmw1STdNVHlIWEttU1UzR2RBcVR1YW51OEZnUkYyVkV5dFMxYlZm?=
 =?utf-8?B?Q3UySDN6Q2d3OXVXMFFXNHJtNFlEeTZUdGJ4SnptVjMzZVhPYVpuT0RmajJC?=
 =?utf-8?B?ZlZRQUo4MnRLZG5mYjdpaFdDZDVRdXd0eHUzclJxbnc4OW1PN3E1bTg4UHgr?=
 =?utf-8?B?bCsrMVZveHFOY0IvZ1drK3RyblVnaHFQMWRiRmVHYjFJZlBNWlB2WlRGVWl0?=
 =?utf-8?B?SkFxTHN6NFRlbVBHVGY5VmFlSGhzdnBWZzZVQjVONlVvQ0tHNlpEMkNXY1dD?=
 =?utf-8?B?VGFGUkhhc1FSR05rSFRmSmx0Y1R0d000L0xnS2hGZzdpaVI2S3dWbzEvUksx?=
 =?utf-8?B?emFRalFxblowT3F5UTJYTFYrQ1owM0dTSFp4VWZ3bGREQVlhSHZBWUc0UklZ?=
 =?utf-8?B?ZmxEcjRucm04am5acVNzN09qZVhqTWNNcmExclRBaFF3TWIrem9NUDJiSHJq?=
 =?utf-8?B?SUFTS2xuVmVrMHNXeG5sOXREWWtMTFZJaTMrQVVjRGZyS3lsSXVleXZSRTZL?=
 =?utf-8?B?OUt0QUxRZmRZMmdRNjYvTWcxNGlyZHlpMTlxRUNZSTRWTU1rVVVjZDBOK0xr?=
 =?utf-8?B?OVBVb0JTL3I4OTcvU01Rd28rbG1UZ2psaVpRTkYwM2lZMDZ5YmNZMFA3VUZ6?=
 =?utf-8?B?ZGwzdmlxcGFTVHBLV3U5cFJOUWFDdkNLYy9kUUVrd2o2eUR4RDBqSkx0MVll?=
 =?utf-8?B?Qy8wSVJNaDdFK24yUk91NGVvK2YvUEZjQWMrVFRiUjUwMXlRTk9lZ0w5MlNq?=
 =?utf-8?B?ai8rT3VMN0gzWmYzdTFiZjRWY0VzVE5Zejd0SC9Md29yT0ZMbXF3YTlPSVha?=
 =?utf-8?Q?lbeSOkFDFTH8+dbxGOguN1O+L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGFTTVNwdHM3R2xhbmFMeDQxbGhja1ZzZE5xL2xJSDA3eDYxdVdPYTVNYkFK?=
 =?utf-8?B?SFJJRCsvWmZWT3RyVGFrSGUrV3hIUjk5Zjk3czFnUE44Q3NiZVIva1RIZlRD?=
 =?utf-8?B?Um02RFgxYTBldDV5endEZHFSWHd1dnRJM0Nsa0YwWHNIYVdqdzBRNWhWUlVT?=
 =?utf-8?B?MzVzcXkrOWZYRitJWHE3VlVvS0Z6UFNLV0ZwZ0xsRkYraHF2OXo1bEYvNVBm?=
 =?utf-8?B?QmZCZkNSNEp3aDRwRk0rZUxJeDE2T2pwZExGTE5VN01TZWIzSDh4bEo1UkZy?=
 =?utf-8?B?L2h4UVZ3WE9EbndYbWI4KzJtRTBsMk5mbHhxNmk3dUtEeXRzd3RQODNkVDlq?=
 =?utf-8?B?V1BZRG42NHVLMFVRYzdkOVBCbXg3b1Jpd2toZHd3RjBGU3FmUEFLTnlxMDhv?=
 =?utf-8?B?a01md1NTaXU2dFM3U0s5K3pSSldKVHdSOUhvRWp1UHpCK3Y0M3FrZTRTTHFS?=
 =?utf-8?B?SVpUVEVENEdqdXZlN2Fwblg2cktIWjlBbE9SaVFPYkpmaFVVaHdCa0hsSU5J?=
 =?utf-8?B?QkJmcGlJK29UbTQzcnA0Ti9EQ3RGdUVmZmVDZ1VTbTBBaVFjWlNJcTJEaHVO?=
 =?utf-8?B?SmlZbGlLNW1uc1F1WXZjZE9JYlU4QUExMUVRanpzTHBBQ2xqUDA3OGJXekdS?=
 =?utf-8?B?aUdwZHhKQ2h1aE0zY0twdk5IQytNcUdrNmNqQTdTS0hJUk9ic1FWbmNHRGVH?=
 =?utf-8?B?SHBFY2xDTDJQaTVXWXRCL29aMjUrRWlxWmd3WExlYUVmZ1lkbW5oNllTcFdG?=
 =?utf-8?B?aXhoSVN5T2lmSXVkL0hVcGdZMDJ3dGZnSWprRDEzVmVSZkJ4MEVVcHF2bjdG?=
 =?utf-8?B?b1JlM0tpMEJ5WVY2aWRBVzBlUWw4cXlEdFloT3dXM0VONFY2YmZPaHlFN2ZD?=
 =?utf-8?B?SDZ0Yjk0WTc4enpUZEc1NklMYUI3SjVRV2pDL09DbTVWMHgxZk1zWWlXTGJv?=
 =?utf-8?B?ck96a1NMamZjSlNSZ0hJRTFUSDBBSEdjRkZOVG5SQlp5aVR0MVprSnEwbUxy?=
 =?utf-8?B?dXk2UzlqRzNHM3VYdDMwQVNCeUpVTXMxRzBPZ1R6K2tZakh1MHZaRGxtMFNj?=
 =?utf-8?B?YW4xYWNLYUpvemZrVDhESE82aGgwcFY1SjRicGs1YzVkMW5OV2dxcjNraThM?=
 =?utf-8?B?bXB2eXN1ck1hOCtGYk5qYUZUZTNjaHZPclRzcTRVajNzSkY3ZElQd2ZDbDNQ?=
 =?utf-8?B?R1IxUTI5bkFPRWI4WXoxTisxdG5nMWdkcWtZaEdPcExBV2QyNVVTeGxBbGxP?=
 =?utf-8?B?V24yUHZBbnZmZEpqZSt3MHZSMnl5K09jM2ZYWEk5UkxsdFBTSnVYL2J5NkFJ?=
 =?utf-8?B?Z3ZjcUpxdk1Od3ZiODRUYVlSTTV6RjVVQU5XNVdvNUtVUSt6WHVxaWVtcDJ3?=
 =?utf-8?B?Vm54TVNNbEtFdEplcnAwR3hSQ3RnMHoyQkVqYTFnNWlBZC9sRjF0azdOTERv?=
 =?utf-8?B?UjROakY3akY3akJBdm9kR1FTUjNCRlNzUDcvV05ObzFKTXM0NTNCYkxhZjgr?=
 =?utf-8?B?SnUvT0ZjVkxyUzVhSDlqVWZTa2RWeHFoRko0NmdFOUVqc0h6RUxyejlMK1Rk?=
 =?utf-8?B?QWVxcU0yTittdis0NkJMZ1hmQWMxV29TVlQ4emhFYThOazI0cTlrRzcxS2h2?=
 =?utf-8?B?V0JkRlc0K3BVV294ajBYdEpVbStZZVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a120b2b1-8bb7-4340-0187-08db9cc6bdba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:02:40.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnRcIK3z1jlpDN78NrdH5fvdqiuAFd7WgqOqBdqh+QIrO4CqdVuJtXWRce23t2W3eLT5XZeKyRsHkcgK2VwdEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140120
X-Proofpoint-GUID: f74aFBR_0WfwMWHpNnXrVDT-Aw6zZxK2
X-Proofpoint-ORIG-GUID: f74aFBR_0WfwMWHpNnXrVDT-Aw6zZxK2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>     try:
>       parsed = ast.parse(py, mode='eval')
>     except SyntaxError as e:
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7410a165f68b..0985a3cbc6f9 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -13,6 +13,8 @@
>   #include <util/expr-bison.h>
>   #include <util/expr-flex.h>
>   #include "util/hashmap.h"
> +#include "util/header.h"
> +#include "util/pmu.h"
>   #include "smt.h"
>   #include "tsc.h"
>   #include <api/fs/fs.h>
> @@ -495,3 +497,19 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
>   	evlist__delete(tmp);
>   	return ret;
>   }
> +
> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_unused,
> +		       bool compute_ids __maybe_unused, const char *test_id)
> +{
> +	double ret;
> +	struct perf_pmu *pmu = pmu__find_core_pmu();
> +	char *cpuid = perf_pmu__getcpuid(pmu);
> +
> +	if (!cpuid)
> +		return NAN;
> +
> +	ret = !strcmp_cpuid_str(test_id, cpuid);

It seems that strcmp_cpuid_str() is only added in arm64 arch code - 
should there be a weak version for other archs?

> +
> +	free(cpuid);
> +	return ret;
> +}
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 3c1e49b3e35d..c0cec29ddc29 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -55,5 +55,6 @@ double expr_id_data__value(const struct expr_id_data *data);
>   double expr_id_data__source_count(const struct expr_id_data *data);
>   double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx);
>   double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
>   
>   #endif
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index dbb117414710..0feef0726c48 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -114,6 +114,7 @@ if		{ return IF; }
>   else		{ return ELSE; }
>   source_count	{ return SOURCE_COUNT; }
>   has_event	{ return HAS_EVENT; }
> +strcmp_cpuid_str	{ return STRCMP_CPUID_STR; }
>   {literal}	{ return literal(yyscanner, sctx); }
>   {number}	{ return value(yyscanner); }
>   {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 65d54a6f29ad..6c93b358cc2d 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -39,7 +39,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
>   	} ids;
>   }
>   
> -%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT EXPR_ERROR
> +%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT STRCMP_CPUID_STR EXPR_ERROR
>   %left MIN MAX IF
>   %left '|'
>   %left '^'
> @@ -207,6 +207,12 @@ expr: NUMBER
>   	$$.ids = NULL;
>   	free($3);
>   }
> +| STRCMP_CPUID_STR '(' ID ')'
> +{
> +	$$.val = expr__strcmp_cpuid_str(ctx, compute_ids, $3);
> +	$$.ids = NULL;
> +	free($3);
> +}
>   | expr '|' expr
>   {
>   	if (is_const($1.val) && is_const($3.val)) {
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b6654b9f55d2..b6948021fe29 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1779,3 +1779,20 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>   	zfree(&pmu->alias_name);
>   	free(pmu);
>   }
> +
> +struct perf_pmu *pmu__find_core_pmu(void)

Why was this relocated? I don't see anywhere changed which referenced 
pmu__find_core_pmu() in this patch

> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmus__scan_core(pmu))) {
> +		/*
> +		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
> +		 * not support some events or have different event IDs.
> +		 */
> +		if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
> +			return NULL;
> +
> +		return pmu;
> +	}
> +	return NULL;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 203b92860e3c..580b8d65bd65 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -288,5 +288,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
>   struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
>   struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
>   void perf_pmu__delete(struct perf_pmu *pmu);
> +struct perf_pmu *pmu__find_core_pmu(void);
>   
>   #endif /* __PMU_H */

