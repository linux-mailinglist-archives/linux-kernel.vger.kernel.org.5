Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51647C7EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJMHg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:36:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5CABD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:36:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7P4mB009503;
        Fri, 13 Oct 2023 07:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=H5Zoc5BuHZM/7ysKtcsrZK4oFvFhoVmYuUutNrZjDzjkPAiQiGqTbRs9ABYZVjX3vX9T
 4We/ZxnQfkTD6EJ+09NDpjtrD9HN48GnwMGMH3DS7c6rX6x+ELdrSy/7unZwzHuWljP0
 A1WJiPZy0huXTATj/wTvSr/6rI72YQUa7W7BGfAIYzRE/NsDK8iMKDD4/IUZ6wlJs87Z
 4cIoSZP06UzaOMlHMFTgQABN4jWoG1NXswy5PcaHn0dWPJSZQF0qF/pG/Fy/UUzIfm+C
 ewpeJPgkymmqzTv+jjfT+jqDMQvWots43f8U3aAZOZ3TiqxJvZK3FsipqCHk/c0vkCFe cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2cfhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:36:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39D60QcA021846;
        Fri, 13 Oct 2023 07:36:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tptary649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA1FXd3IAzhxX673FVztHzeQSc2L1Tl60RSdjBiwHBfiqWLD9eh6eDfaBE5xNm4om86Unagf52gt3z7j/3FEkxU3D+FUY957vGXML5tW51RXYoJ/0Yr5c/LjAMOZXAKQyiP3IGi4iWUdJwbqHyQzOOPfOwbmkin78atvwrUB6v3ymHXrnmJF89XYsdHFqoiqvtxNG35TsFbgdBJ8juhWMY3KRIJ+XPP/x4IRN1ID5RWR/y1Y1aCgEs9Oc9TARvwYfgAkdOhND9rOtDV77XHOXLmyuVZ3l631uZVk4BIbnoLjD235QVxTd3FKAEb0uF+SS5bGysuTopnq7TllBYZgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=DJCKR7pXaitstfRcbTL6g5qK2kzwTBabvAiMoCKektMUlEEWFd4XZIngfPNcRK7iOYzwR44iHqsM4j5fgRFcg8TegeUgQEoghkVrHcSjkQzG/E4lkge9yrybmoG62AW0juiVvkqRyfFQDgxJEHVdP/bukqtJx7hxxf+yPizkG3pAD3mEYQ25zmD6wlTfKZinQ19WZE0zgImIDnzk0mNHZYuuR4khEQXYAA7LAnGvS4jVSKbjj0zwaIY6AgSWEmhM3y1YL9fiYOEURgi5xb0o6ozczBZJTJT1a9sSbv6kcGztcWiYtNZoMtb4Wd7yoT6EaHU4aMFnK7vQ1U5unyeVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=g8reebuxo866j0bIeYg11CPBCl3FTfnDfS3fm2C6x5BLru6ic67pU2VoR4s0PMxiLtLuE0/Ko5t12WcsjOeukh5CQx6mS2yEua4WEebCJR150GU/fLQiq3XSMm/lN60I4mCZjQSF8O7YiPd0A/TAkhOAD/QasitxAJzLrPX2Zbo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 07:36:04 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:36:04 +0000
Message-ID: <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
Date:   Fri, 13 Oct 2023 00:36:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: b2617f11-29cc-47a1-0f75-08dbcbbf0e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6xc8MuOP08eJapsg4RyOoGj/CGXB4OLC04B1wU8zr1KEkJEgJnuizmrpSOp0SjULQqFnLyGKY5cPaaqQy4KjUH4qRSwd6it3UyqGmGOHWNO9Dtv2w92n9cfkV9jC9FRHY3RrbRNj8QgvvcdW/tZ1MqneYKd8hIMnQbelJk9iI4B4H15k69n5yairHbEdiop+DHbtnBPJr4kDALAuNnPpOabJ7I8ADe9savau1WMd5ExFMSaTVsJykhiMC1kjQZ4Kss580ODHLJhjDUMf1enyHrsGUP+Dzzvmf49Rl8C7IDxZdpwkCVqh+8oPnV1aL8+LV5JTbUiOP8WKcgK2Q3tD1sdkZw1K7e0KOOf6uyrxuxjzsPKkBUSSCWOOKXF7BkhtKtMPr2Lo29TbhOwbHPnBYT0U+xphMaSomQTYRekM4WY/hMFnSCErArqc7qDCQZeKlAT/BTm6JpsDlRtOh1dLwYyCmagvW2JEL8djyhj5/dFzz1uLk7TU08Rc5pzMtdduyjpsbfLMaDufzrijcjg9QO6NZJLT8fEQQTgEOfUXvdQTr3pnGgn3fxsgvNwit0M17HZTUC3frr1Xi6zCXQ9vhnD0GcvBjMl9i3ifZTwbpC0cHhGFtCMv2whRoZeWaUpGZshKi/xK0m39BOOiWgq5iwL0CHXCO9BveGZ3LtPltnFuV2mS77jUn7sDCzYXSX3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(6916009)(66556008)(66946007)(6486002)(5660300002)(4326008)(41300700001)(8936002)(66476007)(8676002)(31686004)(2906002)(83380400001)(2616005)(31696002)(36916002)(6512007)(86362001)(26005)(53546011)(38100700002)(6506007)(478600001)(36756003)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ArdkdTZXpGS3d0c0pYQWZGSW5IWFc0TXI2ZmZHRGRDMHRmYTllbjg5SGFr?=
 =?utf-8?B?Y0ZiaWhrcXRSRXZhdC9uVGFDMVJwa1FyNVlQeElNZlkreEl0aVpPaVBtWU9Q?=
 =?utf-8?B?eTkzZW1UWHRmdE1Rc0tkb2Z5QkplVld6Wk01RnlMdVR1aWxUZGNEaVNzMjNE?=
 =?utf-8?B?ZEZLaW14ZGtzQi9UeDUyTHNyUVkrc1pRVThaelNHOVRZMWlnZlZUVUZ6cVFB?=
 =?utf-8?B?TFR5RzVmUmxnc1EwcUZwK0VwSUwxTXdkRXZNd0Jncndna0dvWDJhOFNkMWt4?=
 =?utf-8?B?TG8rbWdqdS9XaGtWb3RwZml6dldnNWZhUXBZZVFHZWhWNG1RWENhZEFvd0lz?=
 =?utf-8?B?eXV3bWttRzQ2Mkg1bG9DQnJsL3VWVWlxMllmaFdhOFVMRExUV1VPMHloL2hx?=
 =?utf-8?B?VUJjeFhPUmMzVWgzTnRzOElYcllxbHE4eUU4MDdhOGdMVFVwV0tLbUMwYVhD?=
 =?utf-8?B?a3FBL0Z3QnVIWlZGYUF6VnMra3RkcmF0dFFxR0VyTkJWNnlPYmJWTkE0SEhL?=
 =?utf-8?B?ejJsbXJpYzZkbEJ4V0FaODJ2czVuM2luVU90NkI0em92NmxPTUpFZk5Zejkz?=
 =?utf-8?B?TkkxUmRVdytlbmlRZ2psVDB2S3RObENyNVhIV1RsbHpBTkorRCsvbHJLNWRs?=
 =?utf-8?B?aEQyRHRCQ1RvZU9XYTkxRTFuNm14MVdGdmMycmlHSERwMGtCZE4yQkRKOUcv?=
 =?utf-8?B?Q0JjUHlkNXFIdC9YTW4yaEdGZTNoTEI5SE1RZlJaeTBOQTBOZGF2NWZOemtz?=
 =?utf-8?B?MjYyZ2UwcmZNUVBoQTVtNDNyTVVHYkpKT1AzWmNzdExkem95c1hHZzZ0Z3ll?=
 =?utf-8?B?blMzOC9xMHlNdVVtSDZKdzBKRzJCN21yY0RFYUMwbjNld0FneDZTb3Q2dmVD?=
 =?utf-8?B?b2hVa0F1SUIvb29XN2xTcWh1bURLSmhMUXJrbkdmWGNBNkJTVUxqWm8vbzBW?=
 =?utf-8?B?SFVMdlBhaklKdDlCNGwxaDhmZkJaTEwzbVNBbDJLRW10NTErd2tXUlB6OGpn?=
 =?utf-8?B?RENteGZIa3FhV1lRS0xiYWdUdDh1TWQ1NC9pS01nUzNPdGZ3Y2RpSGp6cU1X?=
 =?utf-8?B?cC8vS2hNS0xUNmFpdzNXRUlSc0dTWWV1MkYxZ2ZhYnNaekpMQ2l2R3lXb2FX?=
 =?utf-8?B?aXd4OVpHdDAxNnhUZ1BZNnkxQjFDZldoRkVBWmt5eTNpaUNwWHBXb0FNYmww?=
 =?utf-8?B?QW1INHRzeGdrZHFmRVB5djlHSWIvcU5aYjNYMVJiaHVTVUJIcy9NS1J3U0Fw?=
 =?utf-8?B?WkwvbFhHVGYxVXhJNGVtZFZsN0JKRnp4UEJxTko5Ny9GWXJ1NDgySmJNY2tS?=
 =?utf-8?B?czVGN080SHhLMGJiRnZKNk9zTHRSNC8wMnpDUmZCaGtUVlBmMWp0ODNaMlIv?=
 =?utf-8?B?aGc2aWhXa2kyTkprUnA1dE9CV1RPU3A1RTJMWkNCQnJRNndsUkhoeHdPK1lw?=
 =?utf-8?B?dXJJN0Y3Q3Naa2lFSGRKV3JnZ0RMaHhKV1N0MSttQ1NId09IMG9iQ28zcERl?=
 =?utf-8?B?QTh3K1dPa3hzVHlCdXM5bTl0RFFITDRrL3UrM2FOclM2QVpIUVFrcHV6TSs3?=
 =?utf-8?B?SmhVUzhWVzBzRWZxeFlhVEZycGFNTlNnbEk4R1VrSVk4cWxUQ3VGa3BVZS9h?=
 =?utf-8?B?b1ZWbDhQcFNxV09PQUlYRVI2UEp0N1NCVzlRNWVhVzFGK1d3WGNiOTU4M2Mr?=
 =?utf-8?B?Y2JCUWFGQi9oQjJsMW9YV0pVMDU2MlMxUGw3YTIyQVJsaDIvUUJXdVJRU3JW?=
 =?utf-8?B?b2dqcXNnbnJTc3NSTFdsbEg4OXY1d0Y5SDhDWkVydC8zY085RjBYVjVnYlN5?=
 =?utf-8?B?WkJ4MHp3NjRML3MydG9aMG9lclRXOVhrQ3JkRzR6cG1VN3NpSUdjdnNULzFH?=
 =?utf-8?B?VU1RMGFKWms0ZHpaRHV3dnFURVVTakFpbFY2TUJuTlNtbWIrRVNxVTJScVFS?=
 =?utf-8?B?dWp6SWhXRlU2emErQWtxQjhPUk9ENVhvR0thMlcrbzV0eXQ1M0RSb2pXa1c3?=
 =?utf-8?B?blQ0ZUxhenFueXFYVFRnSkl1V0hSNjBuRWxyQi9zZjNFMkVLZXJ3bUtvckVL?=
 =?utf-8?B?VHQyU1B3SlVSc0M4UlZrT0xMd2pQMWV2R1RxM3F0MFZoRGhaUzRLdGk1WUZ5?=
 =?utf-8?Q?SjlN3JewscCdydxWxRctIH1p6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDhTdS9IMEpvV3ZyN3cyWTRlWTl2bWNHaDZhN2k0UlRmTzNOcGJCQTZVVmFG?=
 =?utf-8?B?R0cyMnhHUmkvNUloQzNKSG9mb0tQN3d3eVNpb1NzeEM4TERnYzhiV0lxVmw5?=
 =?utf-8?B?TldnQjFIcWx2WTJDdG9ZZCtIMGppQjFpaENFMTdtMEFZdHBmcFRYN29FZGhL?=
 =?utf-8?B?M2hnYzh1dzA2RW9POVV0ZHdWdnBZcWxhd3loZ1JTNXdmdHd3SE9ESnNkSDhK?=
 =?utf-8?B?R2dqVFJmM3dTV3lMNUExWWFjN0c4U3BmbDJQc090Zm14YUI2SnptQ3dMQVhp?=
 =?utf-8?B?ZXdDVEx4cnJDV2I3MzF5d2gvSSt6Yy9weVJlRUVsZ1E4S3A4VkZ6SGZaaFVC?=
 =?utf-8?B?MmVBOFZueDRzcklCd2JyWmhMQUFLYVVGK3FDVmlia3NLZXBxUERHZkJHc3E0?=
 =?utf-8?B?N25nMDdzZG1sdTdHTFJlTks1Slg1ZWdKa0JnQ0E4M01CT21DanhIN1oxV21w?=
 =?utf-8?B?QitSQ3NnSEpsTlpQK0RQZW9LbGx0bkduT1BFbGJvV0Z3cjJlMmtnNnlvUDFM?=
 =?utf-8?B?a1dQMm41aEFobmxYK0FFZjlzMGtUV1JsKzR2eThoV2dzdDF2TTh2N2JPMmxT?=
 =?utf-8?B?RlZUb2FuYTEyS0pNNzRXYjdCWHcveUpzeGpFQVlTMGZOSDAvTU1HcEVRSFZ2?=
 =?utf-8?B?UHVzZU5zeVpMTDhHMVo0SHI2SU0zVWlHSEh5bklHaHp0TXdGOFNLZkdQNVhu?=
 =?utf-8?B?cmRZOUVuanBGYzNpdEdmL0pXNksyelZ5RG1xazlvMjc2c1JIWnJWQjFzR1dl?=
 =?utf-8?B?WmVpRFI0YWNKTlJ0T1RoMUhmWkN1UWRhUzZuV1d6ZWkvRTA4ckRFWml5RXE1?=
 =?utf-8?B?blVlWVpBbnc2WlcyVjBodGo5ajV4SmlPWFR1SGp0NEZOVFVCVFZhQnBLNURm?=
 =?utf-8?B?Yzk3U0t3SWxLcFF6YjdFb0d0b2t3SlcvdXJDN0t2UzZtNWRManExL2wwZUZG?=
 =?utf-8?B?ZlVqOXlvVGUvdWZtM2dSbTRtY3JhSU8ydklMS05lWFBWQlJoSU00V3NiOExY?=
 =?utf-8?B?TkFRQytoT2ZhaitMcjZHTzVDb2ZJZEV0MG9SQkF4L0RUVWM2YWZ3UXZxdUxU?=
 =?utf-8?B?OFZMTGpuRThwc0tVdTloM0N2NmtXTDh3OEFaYjg4cCsvczhOMlRoalJLcndH?=
 =?utf-8?B?VGxrdm8yYVJEdmd6OTJoMWtFUUhuczd5NURsWU9JcnZVSjFHc3I3a2orN2VX?=
 =?utf-8?B?VThMZlFPM0dMZjhkOGRidEVIMmZCWVhSNjhpUnBlQzB5R05xdC8vSzllbENQ?=
 =?utf-8?Q?ya7sQ03UkraEoD3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2617f11-29cc-47a1-0f75-08dbcbbf0e84
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:36:04.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o86tbLhbt/2NAy+A3NtIYiSiYm8ingDkz5BEfpkEkaCh2A5roUveq/xXnMx8I9s1uA4V8dIbvLlQtEx41jhX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130062
X-Proofpoint-GUID: FxgMvvBZnoNbtJIn1WrpCWSbv6IqDVU2
X-Proofpoint-ORIG-GUID: FxgMvvBZnoNbtJIn1WrpCWSbv6IqDVU2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 7:49 PM, Jason Wang wrote:
> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Device specific IOMMU parent driver who wishes to see mapping to be
>> decoupled from virtio or vdpa device life cycle (device reset) can use
>> it to restore memory mapping in the device IOMMU to the initial or
>> default state. The reset of mapping is done per address space basis.
>>
>> The reason why a separate .reset_map op is introduced is because this
>> allows a simple on-chip IOMMU model without exposing too much device
>> implementation details to the upper vdpa layer. The .dma_map/unmap or
>> .set_map driver API is meant to be used to manipulate the IOTLB mappings,
>> and has been abstracted in a way similar to how a real IOMMU device maps
>> or unmaps pages for certain memory ranges. However, apart from this there
>> also exists other mapping needs, in which case 1:1 passthrough mapping
>> has to be used by other users (read virtio-vdpa). To ease parent/vendor
>> driver implementation and to avoid abusing DMA ops in an unexpacted way,
>> these on-chip IOMMU devices can start with 1:1 passthrough mapping mode
>> initially at the he time of creation. Then the .reset_map op can be used
>> to switch iotlb back to this initial state without having to expose a
>> complex two-dimensional IOMMU device model.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   include/linux/vdpa.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index d376309..26ae6ae 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -327,6 +327,15 @@ struct vdpa_map_file {
>>    *                             @iova: iova to be unmapped
>>    *                             @size: size of the area
>>    *                             Returns integer: success (0) or error (< 0)
>> + * @reset_map:                 Reset device memory mapping to the default
>> + *                             state (optional)
> I think we need to mention that this is a must for parents that use set_map()?
It's not a must IMO, some .set_map() user for e.g. VDUSE or vdpa-sim-blk 
can deliberately choose to implement .reset_map() depending on its own 
need. Those user_va software devices mostly don't care about mapping 
cost during reset, as they don't have to pin kernel memory in general. 
It's just whether or not they care about mapping being decoupled from 
device reset at all.

And the exact implementation requirement of this interface has been 
documented right below.

-Siwei
>
> Other than this:
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>> + *                             Needed for devices that are using device
>> + *                             specific DMA translation and prefer mapping
>> + *                             to be decoupled from the virtio life cycle,
>> + *                             i.e. device .reset op does not reset mapping
>> + *                             @vdev: vdpa device
>> + *                             @asid: address space identifier
>> + *                             Returns integer: success (0) or error (< 0)
>>    * @get_vq_dma_dev:            Get the dma device for a specific
>>    *                             virtqueue (optional)
>>    *                             @vdev: vdpa device
>> @@ -405,6 +414,7 @@ struct vdpa_config_ops {
>>                         u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
>>          int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>>                           u64 iova, u64 size);
>> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>>          int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
>>                                unsigned int asid);
>>          struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
>> --
>> 1.8.3.1
>>

