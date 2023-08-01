Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476276B843
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjHAPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjHAPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:11:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F410FE;
        Tue,  1 Aug 2023 08:11:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BAwXb005178;
        Tue, 1 Aug 2023 15:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2w4tiRPvVlxg/NcuSN5EU7sogzPG8IoKhWAs02OHQ/c=;
 b=Spglr1ZfvvffwYbo+kro6zJ9e1oVLuRIM8GplDs62Bwm+gIu0PAk7S0tre0iiIxJS8wl
 FOMFpRBULfvFHhu5U+HoEKsIgK6yOidA/l+owois8tCA/TbVLDqaceZunW00NoLc/MtK
 NvnA5vWKF4Wx6k65iEniPhyhidH5yIgHKMu3NpHX0rM4lnDEUDNjk+ft00KKOpiKCua4
 DDbAaXNhz1GI3G5NOg9h2a9A/fCwxKLmEAnsTd6RyVBw01QUxAyYtSTkmekrORGeYOw5
 3JV4gVaH035aWWFxPz/VkAWF4fswCbR/GZvtTfGD+Dg7s2MRkwd+1HtTXF6nmvVuaE20 Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauw4ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 15:10:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371EHv2s009608;
        Tue, 1 Aug 2023 15:10:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7d16s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 15:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0fZtwC/KtRZi4TOa6CL11lyEGLyMmyiJfwceqbfKjjzCJ6++lrZ8p6toJGmwpiz/dH6bliICZd6y4GX0nFdEqAP1gmAu9b7J3ZeegU0IexCrh2P0JPx9gTmBmij3ehQWetLc4a/lZDwmqFl8yWJgnPZ9CAqU8Oplw8cVWtIwTvF1Mg+Ufuzey0jKowpFkdUaZUcoh0KVW2HvQXOY0hf7a+H3FsTEOf3pb/JJea4676kccUjv9hphysCzOo8p2tMHdukjfkDvKvMagN6O1UiVG5hdUwGqYP0OElTg0U4qdYxBnHl8LeCl0bbz4chCRl5r3dV8fIWe/0I4RIoI/uP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w4tiRPvVlxg/NcuSN5EU7sogzPG8IoKhWAs02OHQ/c=;
 b=IKl2Ehb3Gnkrnk8+XP+vm7cn37EkcS8VXokiP/0yoVQozgT3CUiNTNldw6Y7gdBry1M1ciwMURhzC9+itamn8vJSm9e9SR+JVBWkI5RUXike4GdijLMdy44xtdy8kmMMAFjFDLV0epubU6ysgs0wZLPaakzDk32huFmhFWb27os89L8/fN7uZoV5cYidxiORTyYPqMmxzT+MxAVoZRd1Ud1ljL1ZBb08Zt0o47VN+NhIsSegOyzhjZNHyjZuhBAou1iis87KfrU49Vhg0rsgpLbyBwiSUNKhi5TaVgLgRDZCFKhjVEvu5qk6PhCidGWi4SirJEndpbNfq30VqYGhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w4tiRPvVlxg/NcuSN5EU7sogzPG8IoKhWAs02OHQ/c=;
 b=XPsoT1SNYoztSdhaGW0EzH7sQOz24Heub0Og+mLhL2RpBxKW7jbb6i+WWNQY6WWILDWbcL6f+hanhQrFPJqqBVOpjV6Xq+P/BcQazEc+LAYXbaieAdBXyH21HiHVtvRpT1qK3IrYHDveksNoYomvXSneN2T3DKv9MZPOcpunE84=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 15:10:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:10:49 +0000
Message-ID: <5d69fa17-bf8c-cabe-3417-8bbd11c48b40@oracle.com>
Date:   Tue, 1 Aug 2023 16:10:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] perf test: Add pmu-event test for "Compat" and new
 event_field.
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
 <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
 <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
 <2dc21269-2fa0-ea39-454d-5f12a414bc13@linux.alibaba.com>
 <bbf54737-ed49-5be8-722d-85906c803410@oracle.com>
 <f863dcf3-d7a5-48f6-a07c-94f6f709c238@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f863dcf3-d7a5-48f6-a07c-94f6f709c238@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cfa152-5799-4b60-1a53-08db92a17d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9M1KSICbkna4KWcH1cLQLbmxFnTU5Y7eGe9+w8oKGjkesrlCS+Hge8RfwWjcgSczlc3wNmY7f5mW6DFmc2P8pvsIBHWHoZ0d6x73lUtN9CQZeiygCKcHUprJeIds8PZ1XdGT9LhqrwRyqbigDNxaNmzXpLU2kq1WkhaCAG+VISFLoHE3MFJxx0Z9jTuVqP4fQnmNHxXQIwwZzsNG1pERSMGeR3LuAQ99cKcF7O28qqPJXtXYdjAYZP+PLEdKfFqWwROpZeOIN1xV9sV7XgdUthjYOxdBE6oPg28rsG7xLv/4+nurs2CKnUlK6mHX/M6SMiJg7DW4Bp2iT7COgQnaAjIGP1Xpp9B2yLb2dSkIBOJnIziIWYXI8tyL5XRCk362tC9WpSoiuuzfJcNruBVJjZjhK/qJamtncAJUX7a/SudghPj7vsk6au6A4fBDTGwna+3YMxky1BNgLREUwzYhBt23CSexfsElpOV+2yTZsZG2nGcsbtG8e8k+RxIthHQRsNmxVkYYB+dGa5nZYBIvnsJaF3Wz4LjNhPpAnv3I+CJGOpToHDQo5eLHQhY7n3WHfsCW1P3tM3p6pS9nyaCDH0jq3iha5RmAyjSejpLRF2Mj2fqv0z9IZQjcZcBSEoFDSzzOxrMTjayKh8AAfhMfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(2616005)(5660300002)(6506007)(8936002)(8676002)(53546011)(186003)(41300700001)(7416002)(316002)(26005)(4326008)(478600001)(66556008)(66946007)(110136005)(54906003)(66476007)(6486002)(36916002)(86362001)(6512007)(6666004)(4744005)(36756003)(2906002)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW84NDR4V1lCaGptd2EwVzNVamR2TEJ5TmFNNFhsQUUrVThZa0hxc3VGemlD?=
 =?utf-8?B?S3JiWDFveXZoVll6c0lXWU0xc0pOaHhkd1ZTMVhIYlFpajBVbjRrTVMvbDcy?=
 =?utf-8?B?Y0NROVFNN1ZPNkZtM20yYVY0VUFnUG1hNXE2Y3ROcGp6S2pJazdndlhvNGdi?=
 =?utf-8?B?OGJvSXZ4VkVyTWszandnL1lxRzliMEM3MDdrdGVnaHdWTFdEelg0ZnhIR0tn?=
 =?utf-8?B?b29remhablFKR2ZETXJWMlpYUkQ1SktOMEZIOUl2WlN3VXV6bDEzQytNNStK?=
 =?utf-8?B?OVlQSzM1SDgvT3ZkMUNYSGhTK2hMMmxjVnN2ZlJwNEo2OUNBNGFINFpGU1RG?=
 =?utf-8?B?enVmaDJCUjJzMEltbWpPajBnNVpyeXZjRFdxRURzeDhEeHBXd2dUYVhNejd4?=
 =?utf-8?B?RHRHZ2ZOa3FVREMxRlBtb3dFOHlzUEJ1UGlQQ1JaR1Mxa20yZFl0SkNPVW5r?=
 =?utf-8?B?ZXpnYjJGNTBxcm96cDVaTEtjVmlhK0RrREVoVjM4Wm5QNEhVbVVvTGx3bmZB?=
 =?utf-8?B?NEtBN29raHhIQUtHNU94VmN1TzFpYzc1ZUxmejZzdkJLRDFqOEhNUDRiVXpU?=
 =?utf-8?B?NnRJT3I4Y2syZzZiRDlYSXFlZjY3UVkvWUtEME01SWJzM3BHMUp4TVVPU2J0?=
 =?utf-8?B?OC9TWDBwMElFVFYwSSsvRXdFb29QQW1aNi9uYlh6eEhvdHhsY3VaUEU1NlJu?=
 =?utf-8?B?NmtoUzk3QXdlc0F3QVdVeXFBQlNuUVU5MWpINlB4bEFaWmhIbGF0WldPb0xZ?=
 =?utf-8?B?OU1DVm1VcWxvNURKVmtVUUVOdW5XU3VZYUJtdFFRR3BxV2hKdkViMGRlZEU1?=
 =?utf-8?B?RU1JWEZ4a2FxbFlIeEx1QjJHZERMZzVtZ2E2VG9MVnZrZ3BNNm00TnV0N2VE?=
 =?utf-8?B?ZFZNWXk5OCt0YkY1N0V6c0dkVFIwK1I3Wlk5UmR6MnpKWlExQWtYZXc3Yk5v?=
 =?utf-8?B?MURaQnNIZmx4RUhnbFM2eWorNTZzcThWOFE4bWVibWtpcnhtL1ZOTkM5Ti9m?=
 =?utf-8?B?ZXdMM1JqZENhRys4S09uZ0lNN3RjZG5POXFxNGxOaTFZWSsyQmkrZmt4S2po?=
 =?utf-8?B?eG1qeHhpOFdxWU1NZ0hmN2VvMmZHNnJnRmJISjRtT29ITW5Xb3E4SGc4aVVm?=
 =?utf-8?B?bS9wNUtXUVoyWWlOZy9MbWo3bTZPTnZ2cTQ0NWZTQi8xanpPdFdWRW0rWXRX?=
 =?utf-8?B?OUpzbndzcDIreU9oOW51RFROeVNrSituc0drZStuZHREYmNoSEVlTStuSWZt?=
 =?utf-8?B?YVllSktjSTJRVm5XVU4rRHBQWnUzSG5MKy9PUW1Rd3QwWnM5aHI5WUxHVzdY?=
 =?utf-8?B?RGkyRkZpU3JMcThkak5KUkF1WmhMZU81dlVXSU1peGkxQWNkblc5dUFsTXAx?=
 =?utf-8?B?Ykl0N3BYeVNDN0YvYVowNDVwU0NYamdudTVPR21PbXYzREQrN0RVMEtBOXRM?=
 =?utf-8?B?K0pNSlBNYUJPc2RzZzNvdnFGL1BCVUFJNFRlVFFtSlh4SlFoVDJVanZzTGRV?=
 =?utf-8?B?cWZFUXhNN1F2WWRyd0FYMVB0dHUySDhCUjB1cUh2T3J5dm53b1Z0TE5xdzM3?=
 =?utf-8?B?UFM2MGJxSmloMG9oazlWb0Z4RVZIZGUwU1gwRzhBbkdXZFBOc0UzTDlrbmt2?=
 =?utf-8?B?ZmN4ait4NGRCSW5janpyVXU4TTUrVDVjd2ZnQXlkZTdHT2hCM0RRbC9UMGhG?=
 =?utf-8?B?NzF0QUFUdFlOazBXclFYWm9ORjVyVXkrZmF4UmhrdjFwWk02OEx1QWRwb3Fy?=
 =?utf-8?B?aHlNSFdBV0ZoOFBsbHpLbnVHVW5lUzZWd1JJRXpVb1B1ZmtIbGR0WHg3RHJr?=
 =?utf-8?B?cEZPb2pxdWVGNzl0c3ZjVENWWjlCNmVBQlR4TE5VSlZZTjNrM3daZFZ1ZjAw?=
 =?utf-8?B?SWlyeFRjNlcyZThBMWVneDJBcjQvVzYrc3IyU24zUlJDQUxlRkZPUlhMZ3pH?=
 =?utf-8?B?UWlJMlZjSGlkaU5zTmJmZTVFa2J3VEJocC9NdjFXbUt1YmZSdXp6SE15V3lP?=
 =?utf-8?B?UmFkMEE0N2ZaY21IdEsyb2twWmFXc0xpamx1NTAzdTZMV3pOQ3NZeFo3eEtq?=
 =?utf-8?B?Vk9hd3d5Z3NjNlVTbE52d0EyNE5YMXlEUnZBS2JCdVd1MTJSSG8zOUU5RmI3?=
 =?utf-8?Q?niTucX4m2LEWbPQ+1Mskq2qqA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L3RkMDdocGt2NjR4bjdOdWZUdE1ZRmlBL0dSRnJMSFJuenBnM0prNXcxVVZP?=
 =?utf-8?B?azloVm9XUTd5emdFdjUzblBqSXZNT2RBNDBWUTJyVjdvTmJmQkJqVFdScSs1?=
 =?utf-8?B?OGlTRWtCK3lCYXc5WVZNbjdBODE4cU44RmhXMzZvcjRLVEh4LzhiTnpOZ3Yv?=
 =?utf-8?B?NWx1aGJLZ25vUFZ2LzJZUmFVUUJ6dnBMdDNEYStOQjc1RXQ3ekpqcHdENERG?=
 =?utf-8?B?V0FvbDJnK0IwbEtxSHYxVFhVK053TTdGY04yZzgwNmRaYkVqb3JsV1pYUUc3?=
 =?utf-8?B?SmowczJ5WEhHc1VzS2lKa2EwUXMyV20vQU1TNnNhOVc2eW5FK1ptb21PdTFK?=
 =?utf-8?B?SDdia2FMc0pIS1Uyb2s0dWxkQTNmWUIyK0lkTXcrWkVmY2cxcGJBb0dpdHhR?=
 =?utf-8?B?MjBldHBMM2FrQXdqdmc2akphcHJaQnVETkFyd3hRaWY4Q0tXMmU1NDlGV0NJ?=
 =?utf-8?B?ZlRmZjEwdHREQzUrYm0zVzJydTJHaGRXVTFMM3RQRXllOTVoL1poUnZPOE5l?=
 =?utf-8?B?WGY1c3dYQWtyVjUvTDRCWFEva0NZZkJuZDI4VmhuTXFmeG9yMmZyVVR5R0ds?=
 =?utf-8?B?VkJML29tckRoWGJtWmdRSnFsb2pDU2VZU1B3M1QxTC9VWUN1NXB1NXY2MzJE?=
 =?utf-8?B?TE9GeENvWHhnQXpkL21jRzFmZEVmT0Q5U1FIQ3UzQ2Exc2RUNWIzblBUNUJi?=
 =?utf-8?B?dDN0VnRpY3dxOUx0M0tWK3Y0dGF0dmVZQ1JsTmcxeWQwcUdrSHozZmM1NmxF?=
 =?utf-8?B?Q0wvMzNha2JsUnZ3elVMR2V2aW1XbjV5K05BOGRiMU9sODllaFVFWXl0a3p5?=
 =?utf-8?B?R0FvK0QrNkNyaXFkSGpDNmxHei9IODZmQXc0bWQvTVBIVys3Skg4QUpsQ3N5?=
 =?utf-8?B?bVJZYnE3Q1BjYlBsSkdMS1MwV1ZpQ3dwdnYxdkZmcm1rYlNDMkkyRUtpeUdH?=
 =?utf-8?B?ZlE3enFuR1NKcUZLakJjeTRVaFZ2RHR5UjFVRkk1TW1NRmRJb21EQko4WVBZ?=
 =?utf-8?B?NjF0WExZbktIRzN6bjJBSkFnMkNMSGs4ZzRsZGc0V3E0VUg4bW1HVWhyZzEr?=
 =?utf-8?B?TCtVV2EzV2FsL1RkTlV5VDBjNTFnTHp4cWhkTnd0aFpUN1BYL2VqWC9DL01O?=
 =?utf-8?B?V1I2V3Z1dlNGeHpQaSt4MENHWVlDR01ldmRTZm1QaXVyek9uWGxIQ2I4UDBq?=
 =?utf-8?B?MEl0TkJyNllUUXc0d3JidnB1bEVSUVlSUnBwNHI0ZHplR2JxWjU0cE1mSjZz?=
 =?utf-8?B?b2tPbVlQV1dCQkJqNU1JRkJCSWRuUk9LOFBuZmozejR0dHd0b3N5ZTlZV2Qw?=
 =?utf-8?Q?92ELouPEyZvWqnxxumzcGx+e7l85zMshwx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cfa152-5799-4b60-1a53-08db92a17d5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:10:49.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pd3kiFHpAqsJKjUlnhB+8Rj5Fa61Gx1VKhu5O6dENua0pKJi/ox9wQV4Xpns//pEG/byB/20D8QlPfytaJsJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_11,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010136
X-Proofpoint-ORIG-GUID: ZMGjkmIDglt6h4pM_oyboSlZFQMqWF0Z
X-Proofpoint-GUID: ZMGjkmIDglt6h4pM_oyboSlZFQMqWF0Z
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 10:19, Jing Zhang wrote:
>>> I need to double check because I was testing against 6.3-rc2.
>> That 6.3-rc2, was for the the kernel? Or baseline for this series? See see maintainers for git/branch to base perf tool dev on.
>>
> I have now developed based on the latest perf tool, but I'm still confused.
> "matching_pmu" does not seem to have any effect. No matter what value matching_pmu
> is, it will not affect the final test result.

Yeah, that is what I was saying - matching_pmu is not used. Can you fix 
that up (to be used), please?

Thanks,
John
