Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83577E634
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjHPQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbjHPQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:18:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535512704
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:18:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GG3uWd026267;
        Wed, 16 Aug 2023 16:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DktB8llpICxN8OPEpjBX10cLEHWIfbrGzXkgTajiUE4=;
 b=cNyZdlhq5OeitdW3XXnrWXhTYedS+WGqoo/faWwedGlSBmFRqU7se3G2wC7Z2XydQFNw
 RiztGx3lTsl+p88tuGlmrz5/oinXibpJ2ZKqlUCnHn9iwuLfC/MW9bbFrU8D1y+VcUbf
 v5AbgP1ovzfGmcYgEJGzlJv09QeMgRKUN7n59/kzgrwrnZemJZ/zwnPu8WPrlOW/+E+/
 p/Ds/gKCpCYMKVmPqbPYa0EJRBweiFFPd43aaVkVRuMZDs0/iHJ/FhzmbmvX5LsMRtfk
 Y4JMbak+Czg14dXhmZ3n8yCHtmcOtaDD0tQFpc3sbS9cg0uqNUEDT3gz6CC7Fst+VX+B nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2yghp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 16:18:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GG6J7r039417;
        Wed, 16 Aug 2023 16:18:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey71p7p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 16:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxs5ESGtj94RB6ek2bxLn9BG5v4gpv3kS8D6KIQILcgOD1cDm0mBuMiNwt1ocoNdklBdak6QyFXwjXQGwfABfT25jbopCoWUOPFqvSGEtmcWk66rHTNl/hHqj3MvjR+jSq2UHYMRmo6kTBygQ1gb53i7Od4Jk680dAeUEBiVUPwHBmqX3Tt1Tn76BFzJ7uiWCTKDWRmwgE5OWIkg4oYyUmoj/DbiAkJ4RHIxYHb7UdKy25NfF8QljjcF4W1py3TQ4CPATsLbPIryKQJuq86cA3O4VdvHFs8w5tuIdfWfh05OpeNvU09E4WfEQQ30N6zkoaH+hfqSlJz6LHambGP2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DktB8llpICxN8OPEpjBX10cLEHWIfbrGzXkgTajiUE4=;
 b=H7n06YPHpNUGtpY6SP/Z6J0Y+8GwCPtZtQCAtZs7LvEHdfN6fyebKWEFvK1Ppml2kFAV5dU0YaX3LXP5i+09dzTri4IQjWtGqL0NsBVIW2iO/eKis+Jxl5uqwilGJsHbllITuYYrSVmCXXDxVcfuc9dcnnyYCgmYoewgk+JYzNP9oxXOljCJ4hguiPA0rp3R3x8ihNwSIdWTsGdzWLXOzIJf2RFT2doLMpvCLkDciWv7aWV7ofsp1xjP8UQbP7Qge2Pf5Wc6ltDl8FZGKj0h7GxsUx0qBatCECG8bQSU/O5IrMlK5v7aSmqrUQU4CC+SDDF0FAlTIy2+ersew5Ow3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DktB8llpICxN8OPEpjBX10cLEHWIfbrGzXkgTajiUE4=;
 b=PcRpB43AmHoyiU4IrbIPW7llhCuAdn7TPxwFPodtlBw6VC33nuE8aQ/dtIvAdNSyl9BZegpCussYPznqmREEFDckKxmFFL1UKeXSlLD72sMgMe8exbqEcAT6xYtPU5MWVNllH78XiEcVK8Q/Qsv5ZtE2B3VFQO2aMHh5olAyxRM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:18:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 16:18:01 +0000
Date:   Wed, 16 Aug 2023 12:17:58 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
Message-ID: <20230816161758.avedpxvqpwngzmut@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 91000eb2-8e66-4120-5f78-08db9e745c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9vTEMiaoAczedode9Eh3ZBmK86Y+t/HMMH9XgeoI7eSDZ2f4Gs1HNv5r1D7aY/0urtRApFbSSl4r4EFG7Ldtz68Ih5SR1UkRS7jyW/LnTtxYWGtvr0GA2g6a9n6xSzNHgRZx692LqOfcKzmBXJSHnxvhfRZNf3UN9odH6KmCSDBzKFU31m0YSFMPU7kc1qkra4kleEQX0w3LqwJsk9mDxA3SOiTh8qDrTjnSJaS+13/XpaeAJK5bW24J3bOlLzxwKB8Sw6mfqiUm4evKApepqjCwfgxdo+HKMzTvf997tyq42uTl6+BA0kMQ+47rsTAtB64ppC7Lxy8LJewTNOnkeFo6+4HpfoOZAUvmN23cOGxY2Zpnd+8j7qD0wNnTI8AXJb4ACW1feEuzHen0jbmMznsolOb0OQfWNtabNp9hr59DzJIxTN3NV0sUsSGcslm5CtKauNfbTapo0cVHJRnXmGLgBcGmi+PY4HuNLfWPc94qOTmcZKZoELX6Cw5reS3DXs5h/spIeCDo0+HDWjeZ9OglwcQ1zo0QainpSp43XY9TtrbtG4AH6zip4Wu8kSg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(83380400001)(26005)(478600001)(86362001)(3716004)(9686003)(6512007)(6506007)(6666004)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?blZiUtRIprAdk6ktZzwKLzbJmQBKZWRjKY5OlvToCiPHeqSv3jr6LwQmwuud?=
 =?us-ascii?Q?9crfWjjKC+sI9YgmuPWA3v/0pyMneSCHOL/uB+jEyq/iXUdm2mWVToxwgoVe?=
 =?us-ascii?Q?A7lRtIkzF9oP5Ui+UVCJzmHLSHAhoZs5uknho7JRsfkZ4VgiF/DzP1kxSI+Y?=
 =?us-ascii?Q?nnKcTm/tg7hAi/LXmNH7lQg+mYBU8wkKPgiy8+02og00iDGdpX8prXdgzwPX?=
 =?us-ascii?Q?8GfihNaUhU5xkCPcJnBPQ7rowGiHSK9mwNjt49N4ZPv50LOFRIvhhcyTT/8p?=
 =?us-ascii?Q?foEigq8DtMvOSXW0hG0e0HWy3Rc17ERsHxhxJ/eO/iOu4WsmPM6YpjqyvHVW?=
 =?us-ascii?Q?0meVmCoZq9RBGe1ZWrWU94o+ya2y7eVv5gSqiD8hdpBU4yL/WxHtsL3h0LYc?=
 =?us-ascii?Q?QIwwhb0zivZGdjL8hh5R3XRC6catZhKpmNLGYexx29OLbChttaStPmPPZrnJ?=
 =?us-ascii?Q?X4fDpAKbkDJIWDkYJUcRxfGdKOOTd5Vj048OvhJo8a98zdfxJ7ST/EjwViYQ?=
 =?us-ascii?Q?P6+RLIZjiOBpe3T54QxR7LZDuLyqzkkKkuBStSH/WcaNelzfbxGW1KKjetVr?=
 =?us-ascii?Q?JYE93hbg++QfAlkvF2/xzby1h3A52z/fOzsXAKF93warayf6asq9foQJK/dg?=
 =?us-ascii?Q?zlQFtxYHKXu70l6PVCmRbQBv073qbTtEqtOiCAgtWwh/ICkCMWAOcj9EWIEn?=
 =?us-ascii?Q?k3omzNf0CXp51Nvo3P7wOh7/1UGGu1AHeH0HCEVr7PJkcHAw7SgbaMYz4dr0?=
 =?us-ascii?Q?twGFfovrp/idOqMbU9oPy0cDeZxDJRtbTW57ITvdQYP9esRF0IbyENeWyEjF?=
 =?us-ascii?Q?xbFy8FaXo8u4dWaALmT1ei+8bnRHHMsIhyXXrauisGPowPwJNUD2Vg0lrvQM?=
 =?us-ascii?Q?NBSz5IuPgPAfcS88w84f2kT4ubRz3+mu4iJPCCOFlWvs28bsf0IuWBTpWOIN?=
 =?us-ascii?Q?G8a56wAuqWZuFzyz6+vODnhtLvoaLqmYJ6s2ErTP9UkYQT+A7vPsHK/iY/+l?=
 =?us-ascii?Q?BqoJLHq+FS8cC5IBJhmwhL8m/V9/UED8SOhDmcZatsrij7SeyeSx3DET00by?=
 =?us-ascii?Q?/mlYxc7r2JE2kqio+1ZjbGCQSHuj/Gmyw8+owAEwN9W+q+sfbnZ/J62bqsrY?=
 =?us-ascii?Q?hllkVHxb/0rhKgtq2liLYCaHh6a7zJfNxXqWoiuxvMbNtftO50HUZVTEdfRy?=
 =?us-ascii?Q?Ol4ZlARVlR/I4X4DtisQw1UIb10AxSMhukX7SCorP1iyf50a+xecYRh0Si9M?=
 =?us-ascii?Q?7Eez2XH9Wp5QbGgQ+Jb9psBB0gTZm1IIx5oDhCAsxuy4xvaZqc7DHkmj7sB5?=
 =?us-ascii?Q?5wBK0NGL6uCutcuClZISreAwTPPt+rf+5NtVah0hfqx+bxnplQH/A5Bj1TxI?=
 =?us-ascii?Q?OKnUOHgiWDDJIQGTUnN19Ydk35z8GH28CDF1Y27FLvs64w6tTvo8gp94TnuP?=
 =?us-ascii?Q?10NMCV4E+8fMy6klL7y4NRFpY6DHmhfkXtkScfRwidJi3OsWN2/uN+IjyGD0?=
 =?us-ascii?Q?7sp0xIK3e5Qgr/HPLEM2lHJRxaUcR0DwvlzRzTrXcjG5z0AAHgvUH+zvKKua?=
 =?us-ascii?Q?5RY8XpGM7WT+b2LmWztlXTFmkUFEKeLbNmzl/688?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7lMqIpA4BnYvD5ERJTGfA7JS9J576tPf6/TV29ZClpw/W2b6Uht+xXPVJZGQN75yrNMfz7yWU94rv9MtjMfHSskCN4ZZuzF8zl7zmfzZlGI2fG9naunTfAaBd1YRsq0BeKTOrccLrnhErla5YptaceBs5Z/xozau4NydVk7HvfvAttjpXNoLRxLorQFa/Go9dAvuV3WaXXKCGSXnxMG2b/F1mr49ICiQ3fp9PwS4z/HaNcUy0vW9ulW+TyYkI0LYP740JI5vy4HORQRDJGMqstl3to68BxDxHqRbmB3wsXJS3xb6Bza1pBE5eZTTDtBdHCe2R0PjmuW1rgj/ngSsXXbB0mpH8ZvKEPTQA3I2F7E4E9BqsV6faThfyQX7CY9lnAzUy8rOGubLYd2FaKBcG06HuPcYEHcDiVx2gyIl7KC6bVjDGTTrW4vTqvYKzTaxaaiTFkHfui7YQFuzgdk1MLoZ+/l8PcCShGrY9LRjg6UiEsCZApEDcnJKJ/2pn+Ya3waOofR8peA66XBVtfgey0KXGT7jn5JaaTnqMPkShheiFOSIVptdw3QclnajpiGJ/v88lNIyYkc3JNMU8S8/43JL946MY08gYDONPhj7+oyuT/wkH7WwYIgg1Cow8Zj+CkMaBWl4t3htWgRHKUKIOTJc9EFR+teEhlHxRkX54uphwS457hBIs6rSH55yjZe2FP8Vu1y2N/6hoFNTNgcq0PXgo5bDWVBbCXtFvkpoSOHrixAAOQNN616RSqoguwF3pOJ+ZcDASpC4FA1pgP0qVl7Tv+vkBBviFvq3xkU1O5xMn9EZicDLzP+k54TeL59Wrh/fUWTXSC8ILbR/hQFE+MbyVR0PYDe222yF+jsxEsz22yyfCK5YU6gOzhT8kgXE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91000eb2-8e66-4120-5f78-08db9e745c8c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:18:01.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0vNfWvrKlPwOBVvN32GwHpZK4wAlfAllQFbBMyvVTWLoW2ReWb9c4AcapnAXhE67LYIbSeOOmK40Hx+mooKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=478 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160142
X-Proofpoint-ORIG-GUID: YYDfftXtCj2NNLex6Ij03Gj6kqraFxp_
X-Proofpoint-GUID: YYDfftXtCj2NNLex6Ij03Gj6kqraFxp_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230815 15:37]:
> commit 18b098af2890 ("vma_merge: set vma iterator to correct
> position.") added a vma_prev(vmi) call to vma_merge() at a point where
> it's still possible to bail out. My understanding is that this moves
> the VMA iterator back by one VMA.
> 
> If you patch some extra logging into the kernel and inject a fake
> out-of-memory error at the vma_iter_prealloc() call in vma_split() (a
> real out-of-memory error there is very unlikely to happen in practice,
> I think - my understanding is that the kernel will basically kill
> every process on the system except for init before it starts failing
> GFP_KERNEL allocations that fit within a single slab, unless the
> allocation uses GFP_ACCOUNT or stuff like that, which the maple tree
> doesn't):
> 
> ```
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7cecd49e078b..a7be4d6a5db6 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1454,9 +1454,16 @@ static int userfaultfd_register(struct
> userfaultfd_ctx *ctx,
>                 prev = vma;
> 
>         ret = 0;
> +       if (strcmp(current->comm, "FAILME") == 0)
> +               pr_warn("%s: begin vma iteration\n", __func__);
>         for_each_vma_range(vmi, vma, end) {
>                 cond_resched();
> 
> +               if (strcmp(current->comm, "FAILME") == 0) {
> +                       pr_warn("%s: prev=%px, vma=%px (%016lx-%016lx)\n",
> +                               __func__, prev, vma, vma->vm_start,
> vma->vm_end);
> +               }
> +
>                 BUG_ON(!vma_can_userfault(vma, vm_flags));
>                 BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
>                        vma->vm_userfaultfd_ctx.ctx != ctx);
> @@ -1481,6 +1488,8 @@ static int userfaultfd_register(struct
> userfaultfd_ctx *ctx,
>                                  vma_policy(vma),
>                                  ((struct vm_userfaultfd_ctx){ ctx }),
>                                  anon_vma_name(vma));
> +               if (strcmp(current->comm, "FAILME") == 0)
> +                       pr_warn("%s: vma_merge returned %px\n", __func__, prev);
>                 if (prev) {
>                         /* vma_merge() invalidated the mas */
>                         vma = prev;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3937479d0e07..fd435c40c43d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -990,7 +990,7 @@ struct vm_area_struct *vma_merge(struct
> vma_iterator *vmi, struct mm_struct *mm,
>         if (err)
>                 return NULL;
> 
> -       if (vma_iter_prealloc(vmi))
> +       if (strcmp(current->comm, "FAILME")==0 || vma_iter_prealloc(vmi))
>                 return NULL;
> 
>         init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> ```
> 
> and then you run this reproducer:
> ```
> #define _GNU_SOURCE
> #include <err.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <sys/prctl.h>
> #include <sys/mman.h>
> #include <sys/ioctl.h>
> #include <linux/userfaultfd.h>
> 
> #ifndef UFFD_USER_MODE_ONLY
> #define UFFD_USER_MODE_ONLY 1
> #endif
> 
> #define SYSCHK(x) ({          \
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
> 
> int main(void) {
>   int uffd = SYSCHK(syscall(__NR_userfaultfd, UFFD_USER_MODE_ONLY));
> 
>   struct uffdio_api api = { .api = UFFD_API, .features = 0 };
>   SYSCHK(ioctl(uffd, UFFDIO_API, &api));
> 
>   /* create vma1 */
>   SYSCHK(mmap((void*)0x100000UL, 0x1000, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0));
> 
>   /* set uffd on vma1 */
>   struct uffdio_register reg1 = {
>     .range = { .start = 0x100000, .len = 0x1000 },
>     .mode = UFFDIO_REGISTER_MODE_MISSING
>   };
>   SYSCHK(ioctl(uffd, UFFDIO_REGISTER, &reg1));
> 
>   /* create vma2 */
>   SYSCHK(mmap((void*)0x101000UL, 0x1000, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0));
> 
>   /* tries to merge vma2 into vma1, with injected allocation failure
> causing merge failure */
>   SYSCHK(prctl(PR_SET_NAME, "FAILME"));
>   struct uffdio_register reg2 = {
>     .range = { .start = 0x101000, .len = 0x1000 },
>     .mode = UFFDIO_REGISTER_MODE_MISSING
>   };
>   SYSCHK(ioctl(uffd, UFFDIO_REGISTER, &reg2));
>   SYSCHK(prctl(PR_SET_NAME, "normal"));
> }
> ```
> 
> then you'll get this fun log output, showing that the same VMA
> (ffff88810c0b5e00) was visited by two iterations of the VMA iteration
> loop, and on the second iteration, prev==vma:
> 
> [  326.765586] userfaultfd_register: begin vma iteration
> [  326.766985] userfaultfd_register: prev=ffff88810c0b5ef0,
> vma=ffff88810c0b5e00 (0000000000101000-0000000000102000)
> [  326.768786] userfaultfd_register: vma_merge returned 0000000000000000
> [  326.769898] userfaultfd_register: prev=ffff88810c0b5e00,
> vma=ffff88810c0b5e00 (0000000000101000-0000000000102000)
> 
> I don't know if this can lead to anything bad but it seems pretty
> clearly unintended?

Yes, unintended.

So we are running out of memory, but since vma_merge() doesn't
differentiate between failure and 'nothing to merge', we end up in a
situation that we will revisit the same VMA.

I've been thinking about a way to work this into the interface and I
don't see a clean way because we (could) do different things before the
call depending on the situation.

I think we need to undo any vma iterator changes in the failure
scenarios if there is a chance of the iterator continuing to be used,
which is probably not limited to just this case.

I will audit these areas and CC you on the result.

Thanks,
Liam

