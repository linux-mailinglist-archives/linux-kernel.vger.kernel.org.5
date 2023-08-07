Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB277236C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjHGMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjHGMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:08:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22422116;
        Mon,  7 Aug 2023 05:08:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377AI9sb007762;
        Mon, 7 Aug 2023 12:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sh+40fZYLu3iswtvwOHv7AMHR2Q84DRLxfwCPNnjaPc=;
 b=Q4Y9z1+tQjstMOCx86KtTe20sdhVNZh9xf0d5ryKB77RRNaCK8arBuPobnjj5xKCuA4T
 1oUEAosVACEyIeIMwBNFbdmKjChDcEQr6JwYtxxxwcdjCrthcyzpgzBvVnl4lZC/ikHy
 uG67lx8EYyQIZD0KxaKv15fL3X9s6Z0ECUHm8XVrW5sBd581NV35V5GyTcV29/x0Au7t
 qrDsa3bmgIoTaeePJC83Q6Zw/Ul1aXtUaJmaqoJm96ciVoVR0KMRdjL7IJ82dk+WXByw
 0xUZGrus6ePvvJn4VQj6oNzy1izsN+yfhFh1/Z9QOYNKqqDIZoAfEXtTfDBL7i+k5FhT SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73amdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 12:07:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377BxSIx022921;
        Mon, 7 Aug 2023 12:07:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv4fmfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 12:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqEeW5ZvbHYgxtZlme+47E/fTJRtt4SuCk+bmIbNylkbTC/LEVfqfl4DEBEJqoK+7RhSXa1QalYDa9MQq9AziZuuC3Y/cNXrmq4wdOeVEb5YSHfsSr8oykTwbqxjubjqyv5CFpfCcCJ5cgS1W96pZJ6zt81OGfIsMPvMXJISSDEfh6rRutUl8TTRu/CMTZA6O3zjotxMYq77+7iTTRuepRdb+dKV1+At/fTPwOYfykf7dGLxouRfbdmKbNeYVHx60cHtKJioUt7JebTE2dT3s93e2mLw65aDDpBZrViBHe2ajjlsO4K7uPutlar5mR2XVpep7w8khrrTMeliitEO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh+40fZYLu3iswtvwOHv7AMHR2Q84DRLxfwCPNnjaPc=;
 b=JMoAqvaxw4WkadewTp8+rQqnQegXJUW9PWGx58v5kODBhr/D4jIR/iMU4BRp5yB3jnERiK6ubIpQhL/8GqwFi6prKFxwU9ODo0iO22D8DzfePu8A0Lfj6H7bnDAPiAUdPY4HJfkJ66FPEemyNi14KDO9zWfgJKiAySrse9cevAnqorR7RtbS1I2AMKGAWhhPuYN8yCn3OGrkOahS03gzr7mY5CSZySeJa1d8sc22sm6mqsXarHORZP135OrxwM66z2BIuBou+na5Uyl7dvGgLOaKNNGJ1Hq4Z4Jb7C/fy5v9FliZRtaLRmN/RQZ9ou5tRlD9un5BCDFHDVK/EDuvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh+40fZYLu3iswtvwOHv7AMHR2Q84DRLxfwCPNnjaPc=;
 b=NTf+04821Tc3O9jriCk3k6EbgbyjSg7cLzAgGQGEX+hWDXwx7HcVYHxRzsSIrb5bLMtHRdDkEJM53xRIQbMw5kvKvVtqKNf/Ukrd4tzuvSxTGsC1BgAl8ZWl0dkocbaqsZSN3UpdBuILSpbL4VDUbielmpJbrnercA9UMHPE11E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:07:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 12:07:55 +0000
Message-ID: <90c18a64-4de6-a251-13d2-e6671a04c398@oracle.com>
Date:   Mon, 7 Aug 2023 13:07:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-4-ilkka@os.amperecomputing.com>
 <ccce391b-da5e-584c-9c56-1de754df8362@oracle.com>
 <e5879193-515b-662c-8597-ca8ea8e3fb4@os.amperecomputing.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e5879193-515b-662c-8597-ca8ea8e3fb4@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af357b1-3676-46c2-ddfb-08db973eee8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mbwv/VZvrgxN/VJZ9FycJGEBXUyMpE+b2GXFzwmYTa+Gv/0mF/Yj6AwIg1+9BoCaIEYg1HYIn/eI5/84CwoqcPIQgOJVRaeHLRctUlE/HX/a7tTEyMVcmYEiloxsCX3Um9r5qHnK15VwS1rRlUkj0HjLYfPVQYOJ4z6ntbGjW1awL+5kIZHYwzHK06nZO4gnTZhnuiBP2PE77+5jMu7HxOwRPQi/xn4uAkKZI+FmET4VpyNt0M/Rys3/9Lu/M1DrmLOVq9/z+cOACJxteNbawLJgmXnOHQf0AdoukiYubYwdNsbEaTLpbkkLMUgvZGx8ACIMvhXzbgiQT+HT0zoWKUxf0U3OZGahLbx6kzAexpHhAJ2EqdumHgi7lyNIsayew4EQLhxcYvORcbwL7C8BDORgzE9pF2WJW+54VO9LoOM+fjGFZQjdtipUln8I0TfKQGvB6pH3fIA4PWxjsZ/UdyvuWhoaYgsg+g5D8YylH9v4E46TsHoHDcJTadcbrvoAQGbJRDP7Uesv7Y58nW+ggfH4Ag3r9t3uFsM4cDdc4wJbLWJn1G6inGmknB7B0pDyKiNxou3CBIUMQl6/8ioucc71YZj+iKr6qF3S7X6whLSYZRJo3so/NK9uAlD5ohrKKyUZ9waVZtyAj/GthAw1eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(41300700001)(26005)(107886003)(2906002)(5660300002)(31686004)(83380400001)(7416002)(8676002)(8936002)(2616005)(86362001)(316002)(31696002)(6506007)(53546011)(54906003)(110136005)(38100700002)(36916002)(6486002)(66556008)(66476007)(66946007)(6666004)(478600001)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWI1RWhVUlpCV1oyLzJlMVc0M2dsKzBxS1FPRlBzNEtob2lpb3ExQ3ZtVVRj?=
 =?utf-8?B?N3JCVEFQMi9ud3U2WVErNkFmR0V2WXJMZWdqOFcrM2xobGhJRHYwVDhONW5X?=
 =?utf-8?B?dUxZUHpGUVlrcVBibndwTnZxcmF1a21ubHJ2MEU2Y1RrajJBZlNLTFNrWTRu?=
 =?utf-8?B?SjdoN1ZDdk5SUElEZDlDQnlvemRRLzlFSzkzM1RrUlpMc3F1L3pHaXI1VFBw?=
 =?utf-8?B?RkpXRU1wYXk1eVRKaEQrRXh0bkJMVURNVnVBWWpPRmVvRm9SMkt3UWV2YkdC?=
 =?utf-8?B?K292NzVmMHZoUFZsaFlXelF5dlBXejFJcUFkWjE4K3ZLdHNkU3lYQXBDUlk2?=
 =?utf-8?B?QUtvYzJuNU9wQ1lWNHBvYmEyOTJLbFgvb1h3N3FPMGhodEYrQ042OEdYaldm?=
 =?utf-8?B?YzdadHNqcVNJbUszUjk0R3ArY09GSWJlbjNBUlZUY002WDdueGVPQ1dNNHBO?=
 =?utf-8?B?MUxtZHBEUkFxK2lsd1JkeTVxdkNzbk9iM3JLZlczeEo0Q210ZG93Zkw1QmRR?=
 =?utf-8?B?enBzMzJrQ3gvNjVuLzRHVk1pS2tHU1NiTXE2bFFQWjE5Vk1WZ25jSXBrYW1C?=
 =?utf-8?B?YWxxbCtvdGRDVDVsWXZTUVIvZlFiOFhCdy9vanNsZjBkc0I1NW9CUEVzaTdH?=
 =?utf-8?B?MjA4OHBDeDF3cVg1R3cvQTZBMXVPbzF1ZmFrekM2L25XdlRxNnd3SGMwMHcr?=
 =?utf-8?B?YmFESkgxRFZtSy9pckw3NXJrNFFtL3ZvSSswd3owRzVmZmNqRjNnQStHK25R?=
 =?utf-8?B?NklIZWV0NlNVVUdrODVidTRPbERTNmVmd25WVitSN3NqNEpWRStveU5tUXBi?=
 =?utf-8?B?U1BmR3BhWWNKY1E4cjFJU0p5N2ZVbE9lVTdmZ1dSc3N3VWdTL2JvcXdlME1T?=
 =?utf-8?B?K2RLTzhYM0YwV2R5SkdaMCtlZmp3WHYycWxnQnR4MEJpbjZWSHkrbEhOaU9E?=
 =?utf-8?B?QSt5enBIYWNQNXdocnhsZ3ZaQzRpbUdra1lzTDBLUWdSQ3NVSU1OWUNwbDNF?=
 =?utf-8?B?UHB6MmkvdGk1N2lnQ2Uwb3hkWDlQazQ5ZENPNFVBR1l2Q3NGbVM3T1plQ1hD?=
 =?utf-8?B?RXZpOXNmTWJGNndjVmNDVFFWTnFqRTJyZ2ExQkhQeEJDOVNrczFvT0lUbWhh?=
 =?utf-8?B?czNVMUtPK29aeTBxblFhMmxnRFBaRngzZ2doUTIxM05lelJNYVdVdWVnbUV5?=
 =?utf-8?B?U3EzS2VUQUZqN2FwODYvbU1QWWEvNnVRampkcWhqQlF5WlZqWVRJSDZ4R0g3?=
 =?utf-8?B?Yi92OGpUWUJPajhJdk5MYUF3SlQ0Nkw5Ni9USEpPQm5wWTNkL0x4T0NSZ3Z5?=
 =?utf-8?B?M2J5UFhpOS9OYTJTL1N5VHdXK2dUcWpRazVlZDdCTExiZmplbFB1TjdlSG1F?=
 =?utf-8?B?TEhRdlhGa0lIcDMreWpuQUVkdWlmeDljd1pZYUljd1V3UHU3eFptRktQOExa?=
 =?utf-8?B?cEtPL2RtUlhhaXFrTXRZcWpjNGxLc0ZLTStQVHB1SDRLdm1zLzFjR3Jaa0pI?=
 =?utf-8?B?SDkvL09OcjdtWWFpaUxPWUplMVZtTVNhbkhxL0RnSG04VGxaNVM0R2xTb1ll?=
 =?utf-8?B?QzUyRHZBV0xVOHRnajg3dHNSWHArQm84cEIvcDNmbU16Mm5TSjRqbWV3enlh?=
 =?utf-8?B?WE9yd3plRHhoblRySkV6ajE0QTFjQzI2RG9YTjZWQUIzbUovQXBrOUNsWmV5?=
 =?utf-8?B?bmpJcFI3MWZOaGdqUHBiTE8wclIydHRmMEFLOUU5NVduMG1YcGdac1l1Sm9o?=
 =?utf-8?B?Y2hyQWxFK2lJdDM3TjQ1ckxZR3orT0FiZEhUbFBZdFo4TUlIN0NNemw1MW9Z?=
 =?utf-8?B?TFZTNE9VeVZaMEZvTTBzcnVSdjZSWmFWZm5TNVRHa2RuWXc2VTFySXQ3UENF?=
 =?utf-8?B?bkpQcGFjY1NXNFcwZG1vUWVvZm9RK1FVT1Q2b0xONm9MNzVRL2RORnpPdkZz?=
 =?utf-8?B?aExsaHI1M3JZSmY2QlVHZmR5MjdXMXhLQ0lwR2w5SDhKTEdyUXl1L3Rsb1VQ?=
 =?utf-8?B?dmJWdjdjZDJzbmxOZk5kc29JbVVzRzhFM3V4cy9QNDFJc0orMlVOaDZXNEpj?=
 =?utf-8?B?dHFDK0ZlYWQweGI5NGpqVXV0cHlZVUNKejBFb3o0SytDQWlSYnlGTWl2elN6?=
 =?utf-8?Q?Bn6Rf17G2duLrjrX5Efym9VJM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUlhaCtLaUhnN0pGWDZmYXAwNC9qc04xdjhUMUk1eXVldnNiM0hmWkFHeldM?=
 =?utf-8?B?MjUxODVSdXRrSGlvRkw1NHZKcmpZVGMzS1RRUDJhejV3R3YrdlNnNVMzbHQy?=
 =?utf-8?B?bXlkc29qUHNkQnh4SFdzZkR3dG90RDNDS2NnTzhQWXpGNm9mSU1wbnpmci9W?=
 =?utf-8?B?cFZhQ1M2WDJXMlMvSGtMNUNCWU5MMmJhQWFKOHZFQis2bUYrcUVKVngvdkp4?=
 =?utf-8?B?QlBCSTFsNWZDZVArOTNmMVMwY3JxSWhNRjA1WEdHRFNBY1RrcFdMU0Z2S1hz?=
 =?utf-8?B?bUFFQS9aZlpTNjBVUHdXSnFwNUFNcnptUnhoVldVUEhoUTRDZzlRbHJTLy9H?=
 =?utf-8?B?d01aMTIwNmpjTkNlS0ZkdlFYZXJhVVhFN2NYMHBIS2JOaGFwNWdxc3Zpc1g3?=
 =?utf-8?B?aU1WNWd1bzdjVU1mN3pkK3pIYjZSKzd6Mk9wVk9OanM0UC9pWHhhVEFIb1Zk?=
 =?utf-8?B?a1pJTVNyODE0U3lxWWd6RDc1bDY3cVFobVc5RUUvLzhEbFZMYmJZbW9hdEJJ?=
 =?utf-8?B?bG9wTUh5a2NsNzdqZ0cwRE1WelpwMXBuanMvTFdOUEtVcTA4TE8wekJHcXBy?=
 =?utf-8?B?d2VrSE1kZmp6akJFdHNRN2RaSUZFSVIxZFZaV1BsVW0wWGJWeTk2UmxKS1p5?=
 =?utf-8?B?aTJVcE1XSHMwY2RtcDFaZ3duRUVHRHZTUHRVSUc1eDRlZzV4MEZ0ZDNyZ2lt?=
 =?utf-8?B?eThJY1JDWWw1ZWFNNjJ3TDhRY1ZLSUI3OXRubWtZQkE0U2xKSkV6cTVkWlM4?=
 =?utf-8?B?anpmdnlxTWxKNnBreUJNSEZtZUFaSFFXU3FEMnFhRXNEeDQ0N2lFMUltU3N0?=
 =?utf-8?B?ODAxcWJtWHk3MnczODZhZnpRblhQN1hGUXFMUTFCelRtSExIU0VxTVU4WU5h?=
 =?utf-8?B?NkJmTzlHNy9PREFtc2t3ZGdXU212YmkwSXhtT2dwWFpCd1dSY1hiWTJKNllu?=
 =?utf-8?B?bGJiMTlYNm0wM3poTTdjYkVweFJHaU9ZNHpQT1FsYVB5OWN6d0RpalBkQWVU?=
 =?utf-8?B?ZFdsTFUzVk1hZ1dQMXdoS21mSWV0OTM5ZldhWXZEOTBFWjRKU0JGclBYbzRh?=
 =?utf-8?B?Q3NwajNYNUZ4UWY3VjZRMllmVFNWaklwckdIdnFwUTVndzV6ZzA4b0VvSmdB?=
 =?utf-8?B?ajhZMDZTSDNPWm5acjlxZGRsOUo4QjRHTmJOSnJRSzNORkpRU20vdWdrdFV0?=
 =?utf-8?B?OHN6VUdDazhlTHdUZk9GSTZpMUxXSEpyMWRpRS9YMUxVL29seW5RQU01RVAv?=
 =?utf-8?B?MzlERTZGUUJzNVF0TEZaWmh4TUpmQUR6N0VVeDhVU2x4c1lKKzU0bWphZXVi?=
 =?utf-8?B?RENXZEtDdVFGUm0wUU5SNkozSGNidUU4NWRMSk9od09ncDQxczdjMXZGSUQ5?=
 =?utf-8?B?Q1hnbmd5Z0crODd0UG4xWEcwQXNPMVJEMGdzd2dvT1J3S09PdG1XQytrQUdi?=
 =?utf-8?B?QktNbU1iTmpiS3haS3AxaGNwcEREN1NGTWZhRDV4aHRRQ2Rjdm0wZlNkQUlP?=
 =?utf-8?Q?DtW/DlVJpSGxL7BdukggmLoVhB3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af357b1-3676-46c2-ddfb-08db973eee8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:07:55.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcup2SRwVhDY3YTXc+WX1MhrDnK8iRW2jDWBVtYLOUwYKWUAkDlkMIWaKlSDUaYEHgEYHLyVmHFknnBaNsJpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070112
X-Proofpoint-GUID: HhH-060x_WchZPQjPmZrc1z7s6hl8PNv
X-Proofpoint-ORIG-GUID: HhH-060x_WchZPQjPmZrc1z7s6hl8PNv
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 20:59, Ilkka Koskinen wrote:
> 
> Hi John
> 
> On Fri, 4 Aug 2023, John Garry wrote:
>> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>>> This patch adds AmpereOne metrics. The metrics also work around
>>> the issue related to some of the events.

Would these events be any metrics added which are not a "Topdown"? I 
guess no, since there are many, but I just don't know.

>>
>> Just curious, are these events/metrics described in some 
>> publically-available document?
> 
> I quickly checked that and there are a spreadsheet and a document 
> available, which list the supported PMUs, their events and metrics in 
> the customer connect website but that requires registering.
> 

OK, thanks for the info. I ask is it always worthwhile mentioning a link 
in the changelog if publicly available.


Just a few minor comments:

On 03/08/2023 22:13, Ilkka Koskinen wrote:
 > This patch adds AmpereOne metrics. The metrics also work around
 > the issue related to some of the events.
 >
 > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
 > ---
 >   .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
 >   1 file changed, 362 insertions(+)
 >

...

 > +    {
 > +	"MetricExpr": "CRYPTO_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of crypto data processing operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "Crypto mix"
 > +    },
 > +    {
 > +	"MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
 > +	"BriefDescription": "Giga-floating point operations per second",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "GFLOPS_ISSUED"
 > +    },
 > +    {
 > +	"MetricExpr": "DP_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of integer data processing operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "Integer mix"
 > +    },
 > +    {
 > +	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
 > +	"BriefDescription": "Instructions per cycle",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "IPC"
 > +    },
 > +    {
 > +	"MetricExpr": "LD_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of load operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "Load mix"
 > +    },
 > +    {
 > +	"MetricExpr": "LDST_SPEC/ OP_SPEC",

mega nit: missing whitespace before '/'

 > +	"BriefDescription": "Proportion of load & store operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "Load-store mix"
 > +    },
 > +    {
 > +	"MetricExpr": "INST_RETIRED / (duration_time * 1000000)",

I think that we may use 1e6 here for shorthand - it helps avoid mistakes 
with too few or many '0's :)

 > +	"BriefDescription": "Millions of instructions per second",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "MIPS_RETIRED"
 > +    },
 > +    {
 > +	"MetricExpr": "INST_SPEC / (duration_time * 1000000)",
 > +	"BriefDescription": "Millions of instructions per second",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "MIPS_UTILIZATION"
 > +    },
 > +    {
 > +	"MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of software change of PC operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "PC write mix"
 > +    },
 > +    {
 > +	"MetricExpr": "ST_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of store operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "Store mix"
 > +    },
 > +    {
 > +	"MetricExpr": "VFP_SPEC / OP_SPEC",
 > +	"BriefDescription": "Proportion of FP operations",
 > +	"MetricGroup": "Instruction",
 > +	"MetricName": "VFP mix"
 > +    },
 > +    {
 > +	"MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
 > +	"BriefDescription": "Proportion of slots lost",
 > +	"MetricGroup": "Speculation / TDA",
 > +	"MetricName": "CPU lost"
 > +    },
 > +    {
 > +	"MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
 > +	"BriefDescription": "Proportion of slots retiring",
 > +	"MetricGroup": "Speculation / TDA",
 > +	"MetricName": "CPU utilization"
 > +    },
 > +    {
 > +	"MetricExpr": "OP_RETIRED - OP_SPEC",
 > +	"BriefDescription": "Operations lost due to misspeculation",
 > +	"MetricGroup": "Speculation / TDA",
 > +	"MetricName": "Operations lost"
 > +    },
 > +    {
 > +	"MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
 > +	"BriefDescription": "Proportion of operations lost",
 > +	"MetricGroup": "Speculation / TDA",
 > +	"MetricName": "Operations lost (ratio)"
 > +    },
 > +    {
 > +	"MetricExpr": "OP_RETIRED / OP_SPEC",
 > +	"BriefDescription": "Proportion of operations retired",
 > +	"MetricGroup": "Speculation / TDA",
 > +	"MetricName": "Operations retired"
 > +    },
 > +    {
 > +	"MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
 > +	"BriefDescription": "Proportion of cycles stalled and no operations 
issued to backend and cache miss",
 > +	"MetricGroup": "Stall",
 > +	"MetricName": "Stall backend cache cycles"
 > +    },
 > +    {
 > +	"MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
 > +	"BriefDescription": "Proportion of cycles stalled and no operations 
issued to backend and resource full",
 > +	"MetricGroup": "Stall",
 > +	"MetricName": "Stall backend resource cycles"
 > +    },
 > +    {
 > +	"MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
 > +	"BriefDescription": "Proportion of cycles stalled and no operations 
issued to backend and TLB miss",
 > +	"MetricGroup": "Stall",
 > +	"MetricName": "Stall backend tlb cycles"
 > +    },
 > +    {
 > +	"MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
 > +	"BriefDescription": "Proportion of cycles stalled and no ops 
delivered from frontend and cache miss",
 > +	"MetricGroup": "Stall",
 > +	"MetricName": "Stall frontend cache cycles"
 > +    },
 > +    {
 > +	"MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
 > +	"BriefDescription": "Proportion of cycles stalled and no ops 
delivered from frontend and TLB miss",
 > +	"MetricGroup": "Stall",
 > +	"MetricName": "Stall frontend tlb cycles"
 > +    },
 > +    {
 > +	"MetricExpr": "DTLB_WALK / L1D_TLB",
 > +	"BriefDescription": "D-side walk per d-side translation request",
 > +	"MetricGroup": "TLB",
 > +	"MetricName": "DTLB walks"
 > +    },
 > +    {
 > +	"MetricExpr": "ITLB_WALK / L1I_TLB",
 > +	"BriefDescription": "I-side walk per i-side translation request",
 > +	"MetricGroup": "TLB",
 > +	"MetricName": "ITLB walks"
 > +    },
 > +    {
 > +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
 > +        "BriefDescription": "Fraction of slots backend bound",
 > +        "MetricGroup": "TopDownL1",

@Ian, should this be "Default;TopDownL1"?

 > +        "MetricName": "backend"

How about use consistent names with other other archs and arm64 
platforms, like "backend_bound"? I did not check all names, but please 
consider this.

If 'perf topdown' is ever supported for arm64, we would prob rely on 
metricgroups, so would need use a fixed standard name here. Note that 
x86 uses custom kernel events for this instead.

 > +    },
 > +    {
 > +        "MetricExpr": "1 - (retiring + lost + backend)",
 > +        "BriefDescription": "Fraction of slots frontend bound",
 > +        "MetricGroup": "TopDownL1",
 > +        "MetricName": "frontend"

As above, it would be "frontend_bound"

 > +    },
 > +    {
 > +        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
 > +        "BriefDescription": "Fraction of slots lost due to 
misspeculation",
 > +        "MetricGroup": "TopDownL1",
 > +        "MetricName": "lost"
 > +    },
 > +    {

