Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7287E757FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGROdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjGROcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:32:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E001BFB;
        Tue, 18 Jul 2023 07:32:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7mMK027462;
        Tue, 18 Jul 2023 14:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pLgJS/7XCewpCSZ5K3YHA+yeLj3wS8pdyKYKExN0qHY=;
 b=xwFSVsGhK2Wt0eD9cnoIp/zb+r39J5xzVJW/HzQPCJJSi3LyineTL0a5jXnh2/mAMrjQ
 SHPzCWxUnJ3gmzHkjGmYhQzwAYVqQ964ErMZmn8lEuIvhKRGk1BZA2qbHeq5nCin4E6p
 mWxVCkkl/PMzwfhe40D5UAi+VRWI/2Mz9kgR7LUWu34YF+MSO4NlAclc/oma2d6gJHue
 PAZIY36uEuj8wpDId6gyylGLANkIfZxeXfud8U2xMHCH3hGy5K8FjmIjqpH6G6/4rf8J
 FWLYoihhnR9F6WGBcuIC89dw/qXweY7kz0R+NU2TvWHv+wyMmk3kHejFoJTD0ZA1amHa /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7855xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:30:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IEB4ss000858;
        Tue, 18 Jul 2023 14:30:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw56dud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 14:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZO08mT2trdDBcrF3coTxUiGYEsxp7VtbEZdZjQpNJ+zj4BJBmaolyRNbpEmkjfiSulRuod6AQsfvFWca1c/URs8VY8V0LMI6VMgamGGNyHjQLLLHZLaXKjgnNsNvtNdrHDnsEmm6mDZvnQDotgMoqJ5Srvl3ug7dQ6KIPaOc9UYns4d/B14vgXdaiqiJjWOOJuE/B7dmnkQ2PsNslvy6qIIY772v04na5E0f34RADl0PL0du+iP2cUVic5KiZK2Td1sqWVkhWfelwb/6KRtqN1fQ4Hlm/OCQUVAoKZ21lf0uDYkfRrMDYTnnNBxkukqImVEEm/SkYbWMXol9JA7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLgJS/7XCewpCSZ5K3YHA+yeLj3wS8pdyKYKExN0qHY=;
 b=c+hRu3uvDtknBSmHG97WGOjk1SUxJ8jV0WEbn+iJJ9Ap4+CdXvDzm5wmNqj1me5XlCxCDjRYo6hy3h6d7iM6JLi7IYFp+q+lQfX5RrrA/At4WI0JAWSlkFsI8IgLJyF4OGLpydL3jt+7SfiMrPs77hcEqvapE7LbpwGyCPmoVdCim7VdgG+VGm8XDzXh7m/gO//c8ngechmOZ2gHwjANkO28HMuXAXOQdFHUgrbViI3J+KT29EIg6fIUkWRTXL6KFLS8EdCMgJLJX9wGODzPaLFAOIAIMnC8sYq8cNGlIjDcGY/TV66HyzC+Gk6+o4yRXDJwkC4YUOoPtdmFK/dEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLgJS/7XCewpCSZ5K3YHA+yeLj3wS8pdyKYKExN0qHY=;
 b=GlRDtRNpV4UnAhQ8ujfAoPQ1zCewgBIBv5tkRCy29GSyHfvmw0gi/MbQeXOhj6ET4BF+Yyfo/UwtVP9wwMflSFmZ9LgImTOoPLoaKAsY6Wyu9aROt8JfxTW/+XqqTBuuK9pCBNoUvkikCd/HFWGLgZIntJdK1W+Rh2xCfYaobpU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:30:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:30:27 +0000
Message-ID: <6736667f-6456-34b5-1d1f-47219e499001@oracle.com>
Date:   Tue, 18 Jul 2023 07:30:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        stable@vger.kernel.org
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
 <20230718001409.GA751192@ik1-406-35019.vs.sakura.ne.jp>
 <20230718003956.GA762147@ik1-406-35019.vs.sakura.ne.jp>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230718003956.GA762147@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e446aef-b85a-4972-d7a5-08db879b87b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EGmqPjm0MzElYipoCA2zI3H1U/m60BKvxrNEiMD6PkGzxlcSs+9Bll1aMNDOfmpTdHVrlhiMPsAKwZkH8EP0wpPi4YGEMXfv19/7odWH+r9hCzPnxOpIqwbuo8hfXex7L2LV2q+iXK/dChfg4TW9A03m7wG4Afa8xalVOwXkfOM5fiajXzp1WELukAyM1imA1G5Q3SBP5+IHH+YGPTOyNNUH1eKij7bZdV+wUEbUdgtUlMfFQDPUim3BPhRdJqdL0cA9KLhfInNf9qPrCrnLRa92AqwsEv4cak4jStn4EpuQTXAVXxCDDHuMK/XO/EZjol73fYrk+gmU7NzP/owpRyu9mUDXW94HToJnPCP4rn0VGyrItXMzRjJi8tGXSg64kLWPNgFMLC6sw4B5mKYBe/k5CNiHVwLnAGfI/N0F2SVyGXLz84gGwwnSCSd33CSn1C+vzA1S4TLp0vMT7V9GXIo8lzjFNKNqi1wtBYj7KoDeI+Zd3aqT/RD0bsMdJz2dkFgNixacuJvylIGAf8IxCJXdBmGJUACWWl70xRVJ5LVUAqnyNZ69zI9KSvZ7GpMs1dOqx5l12ZdK2xwvU4kDJFI8zj79K6MJunpwiNpx7EYpAeQZqYc10MByjEBdr7PwUWxY4cZ80w10ZaE2My/gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(6486002)(53546011)(6506007)(966005)(38100700002)(36756003)(86362001)(2616005)(83380400001)(31696002)(186003)(6512007)(8676002)(8936002)(2906002)(41300700001)(478600001)(44832011)(4326008)(316002)(6916009)(66476007)(5660300002)(66946007)(66556008)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXl3cE9yeGVVRjJzemRyeUlzK0MyRDd1MG1lNEdsMHdHWWkwYnVVY2EzZnFR?=
 =?utf-8?B?ZzNmOGtlcDhrd1hKTWR2ZUlCWElHeEY4dFFqOVFwVENZNTRJdWZyQ3ZZbU1k?=
 =?utf-8?B?Z25iQ1dSN05jL1BLY21QOFVXTU1UaDhOd1YxdTFjZzV5S3czQit2MW1WQTZt?=
 =?utf-8?B?bkJGQ3Q0NnJXbEdVay9sVi9VcE5uaWMxdVEyN0RIOWtnODcxaC9LVk1NYUE4?=
 =?utf-8?B?dTdQUzNpRVVQay9wMktRdmg5NkFvSVBSSm1PUjRabnpXRE40MnZPRmVIMkNi?=
 =?utf-8?B?Uk5iejNxV3Urbmw4ODlYWkhxQUZOZXZMakE0eTYxekw3bi9aZWJVeU5YcHBC?=
 =?utf-8?B?Rkh6ODE3N3ZyTXdvaG5GbllXUE1iL05palkxOHQ3RloyRFUyTHlZQnU1NlZN?=
 =?utf-8?B?dnBBclZkdnM1UmY5Y0tiZUg2TWxMYzdmVVgwZGwrWXpNemNQRWZTb0NsbGdy?=
 =?utf-8?B?ZXVkUGgvRkdRZm5Ec0dNQ1gyUlVxbExUYVUyQ0VIUitnRE4xdVl1VnV6cDVN?=
 =?utf-8?B?R2VYeU5lSE93VDBUdnVSQStHbW1DNWpNR3kvZWxzKytjMVlUUWZqanVUOU1L?=
 =?utf-8?B?QWVIVTFKbi9LbUNBeDFoMXd3ZXNaUU5mNStUWWU1a3ZZaWhycGJEdm9NTVZo?=
 =?utf-8?B?QWMwN3Z1emlPbzhXYmxLN0txdU5yZElBd0s2cFRad1lhNDV4SnJZYTRSVGNm?=
 =?utf-8?B?bERXb1U3NFlZR2k5WlV1aE8wRnpONTJxcU94V0VIRy90QW81aEYwcVpsalcw?=
 =?utf-8?B?NGlTNzNsUlNjcUZRL3k5TUt5WEh6Z0tZTm9aZVRSWXNKNzdoZlRsVVhaUERL?=
 =?utf-8?B?Z2FXNU1rbnFZa1BDOXBuaC9XRGRwMmxTd1J4NzlYMHJJdGpQaEFaQng2WGNM?=
 =?utf-8?B?UXRhb1g1Wmc2enNZOCtrYnVpRWhSSkFGVHhacEpVS3gxNGVmdTJ1Y05VVE5O?=
 =?utf-8?B?VmdNSGlmczlrT0I1QnovU0R0cXlab2JhdElrUkF1bWMwRkxaek5aZm5hSXZZ?=
 =?utf-8?B?cUtIY0g4TFFYNHVRcnNMZ2MzSk5xRTRaazJySXBCRjVzU3ROUEpWdStHVi9h?=
 =?utf-8?B?QTRORVROckFrYmRpYllrWklCUno3Q2tiN0hlWGpOR3NRQ2FDVXFJR3N2b3pR?=
 =?utf-8?B?QjZnaUo4NDFMbFRwWUIzZzBYSXhVTHdPd1ZsRW01KzJqMDJ1TXRVUUsvRjI3?=
 =?utf-8?B?ZlBpdm9xeUpESmhWMFRuMjZkMEdNWml0dTlMOGlZbHdrcUQ4Q3ZRcmVPUVpq?=
 =?utf-8?B?OThpVHFzcy9YVzFmdmxWMjF0RFFVMnNmK1l4OEF5d1dFQnpwKzdFUFpRZEx1?=
 =?utf-8?B?dlIrWFcwNGR3cUtqbjFXLzBFL1BqOW4vdDVodWJMNTI5cndzQzZDdHIxTWgr?=
 =?utf-8?B?RnNoWTVFL051enZud1pibUZGbkpPUllrVW5PalNMR1llQ1M5UGhVVzk5U2hn?=
 =?utf-8?B?TWxUdW9WVWQzc0FpNXg4ZFBpV1pJb0FrY0FDZlZKS3Z2bm1yWFJ0ZzRkdzlr?=
 =?utf-8?B?VWpNeXVKc29lMG9TZ0g2MnlqbnlxM250Vjg3L3RkdWNNalUxSXhpV2RHeCs5?=
 =?utf-8?B?NHFPZmt0b2FjOTl1enhVaTZHWGZkUU80MzdiTjNhSEFjTDQ5L1lDSmpIM3Br?=
 =?utf-8?B?bFlMYTcvTnhUTjNmc3FZNjUzUGF0UXBsWVJOQTJ3b1BZdHJNdlBKQmdDQko3?=
 =?utf-8?B?MjluZ01Ec1RBSXEzWW9NbGhWZGFjUUxtTTRQOUs1bmE0UnV0Y1VRVkNHQWJi?=
 =?utf-8?B?U0hsQklaNXJYRTZvS3FJbHVtZEZkNWk0M21wenFkYVhQSXJHVFduWHJiUkVq?=
 =?utf-8?B?amFVR2FmZUxvZXdJVlRjakJmM3pFR3B5eXV6OVhYV3dUT0FYdEp2MDhrenNl?=
 =?utf-8?B?T3lEdi9nN2NaSVVQeU95bEpZT3NIKzFRS04vaUpOZXp6K0VoZ2p2Z016cHNt?=
 =?utf-8?B?VU9PSFNQNDFjZXNRSWJ2cm1FcGxaOUFmQXFrSGhTeUJnSmhBK1JJSkZJT2Nw?=
 =?utf-8?B?TWVFNTJ2b1pFUXNVd2JvNUN0OW1KUzJlTU1xSzlZeE93QjMzS1F4SkxYS0NB?=
 =?utf-8?B?QVdRd2JNT2NvM2pldXFFaXMzV0N2LysrVk1nOWdORERqd2pJUlJGRHBtMFdh?=
 =?utf-8?B?R3dDQW5hZ0Vxc3A2dm9LRzZvM1kxdm1EVE9BL2xaTDlTeUJCNTM3dytCR2dl?=
 =?utf-8?Q?yllXY70KJbWlC3pSLG9Dv6M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q2xJRHVDUjlaTkZQQll1Q1J0Wm4rNGVuMHFDV1VHTktJSDI1MzE5RXpsNU4x?=
 =?utf-8?B?ZzFCNVlTRzNkN1hablBVZWFOMllqNWt4L3FNUUcxalVWNHQrcWRuNEEwK1lG?=
 =?utf-8?B?dDZVTGxWYmFZUTN0UjI5VlcycWVGQW1CeVUwdnpPdlNtK1RnWmpIYzV0M1h5?=
 =?utf-8?B?ZFVGOWNtRnpNNjZSZXhIS1pPbmlFcEpQY2kwZUx0TlNHcTZoWTVCTFVuSG42?=
 =?utf-8?B?L3BaeTV5aStwQUxCNlBtNXYrOFFVbHQ0bWhNZ0VReVhCZUJGcTZGL3I4cEJR?=
 =?utf-8?B?Y1RwWWRVUHJLV3h6R3FvamNzSmpZUGZDZmxOU21BMlllOUYza2hiaFVINmZm?=
 =?utf-8?B?MVRFbDlBNkkwb0RLOTRjTEc4SkkyUCsrTy9aemRmcXg4U1Rac2lDd0tLMXc2?=
 =?utf-8?B?MkFLMUZwVmxVS0lRS2M1OEdZV2NwRUxyckhEMnlNN1ErcU9hZE1jMW1NVzhv?=
 =?utf-8?B?cHFnRmtTM3pqSGlNVHpka0xvRFVaU0FXZ0lxWElrbEJiZFpneXQrN1V3WEhY?=
 =?utf-8?B?VzV3TGoyUXh2bFoxNmpubFNkaWNkN3lxdGtJUjMzUUw2RjNZRzIvbWpWNStq?=
 =?utf-8?B?Q0lkRVFFcE1wT0lnWm5sSG92KzZhb3cxZkJrWjBXbEgwVVlVTUxYOXpWaWt6?=
 =?utf-8?B?cWlZOHlLTXVYb2dPZHhNbU1GWU1LdzVFSjhxWTdlK25aT3pGUHJWNHBMVkxn?=
 =?utf-8?B?QlVvM2xXZXNCR2V5d3dISTZvSDNyWEFRYUlsRzBQUmV3a0pXMVgxc2sveVhI?=
 =?utf-8?B?VlR6L2tsWUhsZjBVU0dZdHNsSDRTNGYxN3pYRGNOSnUzV2ZacVppczFlM0p5?=
 =?utf-8?B?Z2VSenBESjNlRWphdU51N1Rsd0NzVjFJMUxBM1orcTRKa0VtMEo4bmdGQjdj?=
 =?utf-8?B?a1o0cWRCSXBrR2ZQMXI5aUY5eis4UXc2NlM0c3ZtVnlmWlNxVDJLY3RQMEZQ?=
 =?utf-8?B?WkJKSi9YTW82T3NSK09BUUJLTWR1a0VJb0VyYkFVdGRSVW12M1VDVDJCajNK?=
 =?utf-8?B?bE1KUFFWbVpMQ3dCK0pxdW9OM2xCbmFueXVkSStuRnArUk5qbnRDb1daNDk2?=
 =?utf-8?B?cjErS0lGZlFTT3puVmhQMFZycVZJV0wwVEUrUm5kejhKMjRWU1NIOUJ4ODNG?=
 =?utf-8?B?SGxNM29OL2RrOW90RjRTbGFmVDhHNUk3L2xvN1l5dEVaaGp5R1A4R3JIbS9y?=
 =?utf-8?B?cWsyWG9qT0prMDAvMmE3c3dpa0MyWllnOHNxS3hFSVkxaWM2NDNZTkp2Tzdw?=
 =?utf-8?B?M3o4OFZVbk5WSVRKTmVFOFZteXp0OFhrWXpTTjVBRkJFRUNQQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e446aef-b85a-4972-d7a5-08db879b87b5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:30:27.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9t+8OscEhml/Otd5Zv1fvimePL+PdxyV7H934dOWPJbCDHPJ+ORRNrmrnbAaDB3BeVRmo5JKeHOU8NWvcoOWb+rvvKgQEIWx8QGmeh/5/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180133
X-Proofpoint-ORIG-GUID: QpJ2YtJleThNApTd8bszMPDyLrwatkK4
X-Proofpoint-GUID: QpJ2YtJleThNApTd8bszMPDyLrwatkK4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 5:39 PM, Naoya Horiguchi wrote:
> On Tue, Jul 18, 2023 at 09:14:09AM +0900, Naoya Horiguchi wrote:
>> On Mon, Jul 17, 2023 at 11:18:12AM -0700, Sidhartha Kumar wrote:
>>> It was pointed out[1] that using folio_test_hwpoison() is wrong
>>> as we need to check the indiviual page that has poison.
>>> folio_test_hwpoison() only checks the head page so go back to using
>>> PageHWPoison().
>>>
>>> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
>>> Cc: stable@vger.kernel.org #v6.4
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>
>>> [1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/
>>> ---
>>>   mm/memory-failure.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index 02b1d8f104d51..a114c8c3039cd 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2523,7 +2523,7 @@ int unpoison_memory(unsigned long pfn)
>>>   		goto unlock_mutex;
>>>   	}
>>>   
>>> -	if (!folio_test_hwpoison(folio)) {
>>> +	if (!PageHWPoison(p)) {
>>
>>
>> I don't think this works for hwpoisoned hugetlb pages that have PageHWPoison
>> set on the head page, rather than on the raw subpage. In the case of
>> hwpoisoned thps, PageHWPoison is set on the raw subpage, not on the head
>> pages.  (I believe this is not detected because no one considers the
>> scenario of unpoisoning hwpoisoned thps, which is a rare case).  Perhaps the
>> function is_page_hwpoison() would be useful for this purpose?
> 
> Sorry, I was wrong.  Checking PageHWPoison() is fine because the users of
> unpoison should know where the PageHWPoison is set via /proc/kpageflags.
> So this patch is OK to me after comments from other reviewers are resolved.
> 

Hi Naoya,

While taking a closer at the patch, later in unpoison_memory() there is 
also:

-               ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
+               ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;

I thought this folio conversion would be safe because page is the result 
of a compound_head() call but I'm wondering if the same issue exists 
here and we should be calling TestClearPageHWPoison() on the specific 
subpage by doing TestClearPageHWPoison(p).

Thanks,
Sidhartha Kumar

> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Thanks,
> Naoya Horiguchi
> 

