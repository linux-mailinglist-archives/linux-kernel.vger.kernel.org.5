Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344697BAF87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjJFAUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:20:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2CD6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:20:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IhwaM026765;
        Fri, 6 Oct 2023 00:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=z6UxIauESzt53mpYYu6n8XSVVvq89jw4VQqjoLvnDDk=;
 b=YTxR961PngmqKBHnbwaqP6ckQuvEnSsli6PL0PWZBLFQYu3rRllwJuKYXC+MulFB7RcQ
 T4e/1f/lb6tRBBHmbScfd1DSBEkaU0NJineXD8559NBrBHHFXwfqBlyb+fyU1AKHcVIg
 mABsEmtAFVLGiOuPgy5D3JfD9NUDQw4R6CxVW51QytaVcjqoUKaYq9OzodsrRb3c1B9b
 WHv9hvQtpyojuqvVP/QCu+YG501IIpIGCGbMDsO9hEC6pjWi7r9ycux1nWWgXR52ynOD
 TlGHsyGFStoX5F1l0JAwLBz4M4ZtVsJL/q2/bsfzKxmKkS3HppAD0S0jEmsQbvUeDeNA WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ejte6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 00:19:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960AMEx005845;
        Fri, 6 Oct 2023 00:19:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49vrwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 00:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP3LVu/ufNZ6tqTDABAql7oaqE+3EFSuz4YfyMO6k25U6K+MFX7XA/dWGRroNOljaCo9HPmVSZOQB5PfPrHCqhlsMV9AkhmOr6Kx1yYe2iuULvZ0VDAOUoCocLyDNv3HCQEc0hdlMcTlhvkA+GmVh8Uz/R9o/XnG8HKKcCNiHEWZii4ayPWhKTAA/NLoFHATyIsEBCgTjXJCy87tZrII2ovOBtisIXyV3Ehc6cT7TE5twbLn3DcD/IdMllMzcSxjkfzuiDsfL5sXiI257tguohYmlVzlr7REQY3Fkl7cDfODcbopI4LO+hGtCI2NrW73oyLIKZ7j4efH7Od3r6y//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6UxIauESzt53mpYYu6n8XSVVvq89jw4VQqjoLvnDDk=;
 b=ZWdv434p0d49TsG4AonpSIp73YZsyEKx+p3JGddBRHkIFsVFNcIbyeW2TTOM59/HrJV6SyukuuIpwtHdUd9hVKJMSS1j9x2BgI8Bzt8h4EwQE30Tqtxaq2TEoZ4w5zuYq+hpIahPZL9orUC+r1W87JPyQriKNBISYR3uwql7RZqaIGvCMEiBAXVsb1QPZbFepBDSzF8ZoqvSMv4x+lln4u+IVW3lUbzE3Ki0JIMyPxbumt7Kc/yShEmL/CbB2d4uCjHejvUAZcG6qNZ5+R71bE+hg2zhWXoSIfX7Dl92dV2ho3WebaGro8iZv1PiN7TkHjvEc/rO80v2xs8wuvpe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6UxIauESzt53mpYYu6n8XSVVvq89jw4VQqjoLvnDDk=;
 b=OtXAJ4/brj/bnaEg7Hi/g3NmBV9xZr1rfx7TpYEMZrON1RKUXH0qR6pml0t/bLifgZPl4g8HKfPHSE0P1VOA2vp5CiN8NE7inV3O8jfeURePMdEGVp75jBeC161bhw/hf+irvV3XQCD1cZBOwupoGfUGyygaKfttpUD6CpvUwwk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 00:19:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 00:19:15 +0000
Date:   Thu, 5 Oct 2023 17:19:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 3/3] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
Message-ID: <20231006001912.GB86415@monkey>
References: <20231004032814.3108383-1-riel@surriel.com>
 <20231004032814.3108383-4-riel@surriel.com>
Content-Type: multipart/mixed; boundary="UXrWRRA8gAsZ8Kt6"
Content-Disposition: inline
In-Reply-To: <20231004032814.3108383-4-riel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 3775fb75-97da-4d19-b650-08dbc601df5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhG3DsCqZ82gluV/YOd7Xn0GcSN7UQYMSQqw+7Ql0Wh0WBLaCIskT+mMOezCoX3vDzF+p8Asds2T/3tQHiV4dkQ3mHoJbB+6qoCgISyNmbgQXq3ePrUeTpY5FcA0zw6EqVB0LZlpDkeIPF92pls5bS0bq70thh/xnJPXYqfwaoLqXyVY7Rj7S/zaT07yIKwTxOqP+3tVg/c7gWIqT6gplEvxrQj9BqmJNjgX0gPDk/PIYLg1Sc1zyGVMohAnr42uCjYJ5HPi86EwiqWnqIygQwasMcyFL1bksi7AzAFZgFl2W20qkKyk8Cq12vNArQoUW9siTwlfwFTR1AqeKJki9YQKhtESBe9LfXFPSPc6heq2FMT/Ac3ccGgeLGdq1qwE+9XtEbQTVBb7bBkjckw4rUmKAuxvr6XaznF6iMS6D4Ir2KbAZChIhYxofqYbon4bVW+n46DJD6S3ymAM0LiakoOGxvlnGbEz9440xo9jyLdBtctCAXKtgkI6xn0jvtDamRYk1WZQxhuFe0CaeQSYBtHGssMeZ7XEsJ3+FPu7cj5yu9iAFN5D8t+spRgci7x0SoxyEFnu1xw30Fkqli0yGGD/aeLe8HM5//i5qXwruWZpAxAvvkjBeX8aOAj4e+0e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(44144004)(6506007)(6486002)(478600001)(9686003)(45080400002)(6512007)(53546011)(6666004)(83380400001)(316002)(1076003)(26005)(2906002)(235185007)(33716001)(6916009)(8936002)(5660300002)(8676002)(66476007)(66556008)(41300700001)(4326008)(44832011)(66946007)(86362001)(38100700002)(33656002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKhnLI3ck5T8J55aorg6wztdmnw29rgLrMQBH8wnAzZCWnMPJx12q6exh/xa?=
 =?us-ascii?Q?PVE/dfgVVz5ozb0kwFzd/lMKes9N/Q/txWXLuId0RBjWxwQa9NF2a10zeCEK?=
 =?us-ascii?Q?074BCBp8SaVAaXNqGnEP9SY4oJzF+99vxsPix7Pn+9lFk2/bjtsehb3Dj0yi?=
 =?us-ascii?Q?raWEy8dbm8PqwUcRRU4+o2c3jaMpAYBMXaOFDFZT0aiO2qVlAeaSiHe3bW6Z?=
 =?us-ascii?Q?BvY56Ki+UJDTfzWV0e3rBct8M4L/BWfD1utuZvE3650G3n18tUROaoBU2CRn?=
 =?us-ascii?Q?yXpZFBo8Cpnl071hmjcmP4U7Td3+QozQxqcXYZJXMJjyhmJUs2Oz1tpY0KbB?=
 =?us-ascii?Q?hJZiOfGce5v3akfPiTQO82duEhulWXwdXKGjazETUky/eBkH+wEzudyZJ22O?=
 =?us-ascii?Q?U1nHO85P8fFQkGnp+eGkP9/v6PnCKfAS/S+G0pONH7KNqFeHJ+euPMm7BMIF?=
 =?us-ascii?Q?ntXr+rYDRl6zmcaKNGPZEdVunX8l9qEfHpxsQS7JF3tgvewky5oP33PyNd/i?=
 =?us-ascii?Q?N8vaYvSGSi9NUeIj19uG9vM91QLMfnpcf+JZCLFO+S+xVjFgZ9e9XbHRCcvR?=
 =?us-ascii?Q?Z3MdqEFlbgCFEzawo2weIRfc7XzcFFDWW9Zrz1gQ4WTf4fZq//MPAYBOtqhR?=
 =?us-ascii?Q?OT1wTMpV1PIz2IIRZvslLwd/cR9AbRyMyQdT6cfFggpREuuNTCraSrUrNKSP?=
 =?us-ascii?Q?RrllK0GFspJX/WwTjpCv0lAJtRD7BSKX5qM1wMeuaoetmHsiAzJgyHTH3spM?=
 =?us-ascii?Q?p5x9kAm00Rn06qF0/T4FhXdxJgoHrFuGv5Ln0PbsH0394HVIs9WiwPgruk/z?=
 =?us-ascii?Q?0Iez5RxISRSfUQWIQzN1pe8Vs2gpvsmzMQyg1oqtDBoS+rc3SEJK5rg9n5i+?=
 =?us-ascii?Q?7//9Csh8ZHRPZq2MCKjygESoEPxJqETjRJKmukL9TbXhFcavhk1/w1hEJabU?=
 =?us-ascii?Q?9D+CALy1VPYDNn3CjdP0Iwix1LTU+u6HI0sn7TgBsV2ApS7X3uhao5usApQI?=
 =?us-ascii?Q?kUHOhArt50TpoRHFCZVW/xlatmgkuB0PUmFnF5symOSEi7Zkbf78TjqsQL8S?=
 =?us-ascii?Q?zkVhe252BSX/1zvRCv0duzISi2m0WhtFaeHVwLwTUtkHCOzAdzd2Vt3vFe3E?=
 =?us-ascii?Q?z2bX9YNwP/lQTH33jNRdaczDQwnUTarD2KvJd26Tbc0ToHph3YmFBE1hcfv4?=
 =?us-ascii?Q?3qi7gXEg3mpWmKyt+npHP2tVKtjOnswvIScun946JXNflzw6Nqm9mxWpY2nX?=
 =?us-ascii?Q?BBziwvBTz5ZJ1AAKP7lanvA4em/Y/ZmtPd6nQLowOQS1r9g0sfVxGUnuC5OY?=
 =?us-ascii?Q?gV6Y937PBBwUq+1Y83Dpq27bPVVJpvxjlaIwkIHlnZrW328WN3mt+z3bdt4N?=
 =?us-ascii?Q?cd7+wldtQvH0b7VFOXqWQv6/xCY1vtYpNzkCF9VRYeiAsA+WlhuXzBCX3kfd?=
 =?us-ascii?Q?zn1aytv2AeMwvy58reDND2Mdp6RG9tTP+ptBs+C2c1EptV+z1Shlnbf4/IA1?=
 =?us-ascii?Q?bJSK/eIEJgt+DSHBaPtj/UnNECh4bbVMKAGD3GNvkuwGyJ1+8DPDfLYtsxqj?=
 =?us-ascii?Q?U7zg1qj8kioS2a0pR68aD32Wnn46lEZmqQtBXyir?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?y+i+doZ5l0nuvuKuOwvax5EGIE5BM9XEk0/jvyj8i+/wf3q4Ffmp1pUQlhMc?=
 =?us-ascii?Q?Qm3kxn4JVPpqOwCFhUCaajQ6ndHgR5xV5/Ha3Xjxhid7BG5+zHg5rFVB7klc?=
 =?us-ascii?Q?B3sRHLd2ginZuexmMixgpaZzEMd0iNHrOo9m7rngC/lu4Ipp0yFxF4ENnMlD?=
 =?us-ascii?Q?Sr+Ew+jJnfG67zQBhwX4i5QJsxOHUHOF6SBlhhfXTZiQANbemWzqjV1OlZxx?=
 =?us-ascii?Q?uTj3BUCNSXKgPceaPlwxRKyg+r6/KuwzbUm1bl8a1BDlXRA2M+FZipxu2wuL?=
 =?us-ascii?Q?aJfB9NN7spKzsYkc4g42P4YXHWLMWr+pMlldOTekCM/cwJjYz0ik002ECIC4?=
 =?us-ascii?Q?GwlstR8Il4H6+9asNRJSuOFl3rMUTO7nPzuQq6BxbixaX2mYKdHRg5BAgp7M?=
 =?us-ascii?Q?ND+cpKhiz/R4e3Q4V+94u4OciDHfx07WTRU4Do9u+RQ3Db7tA9DcBvy3yAv7?=
 =?us-ascii?Q?KSa4jrl/f28XXjDdk9Gkd4kCawhgzA0xaZ927+dbZckut1o5tcKCsYv8h0Ji?=
 =?us-ascii?Q?B27mQY+5f1wjDEfaN3LCXOmRP1oK2cm7VR8g7RNZBDS8uJ1RVnbDzWFDAEoz?=
 =?us-ascii?Q?VNTPr7nZBKfx3HEVaSq3f3bj7Wn+nU3UhKk/OF/DFZ4tveCnWxt2Fn4AzmLH?=
 =?us-ascii?Q?1jZMJDsolela249ttOgw8lhMTiBAArR3bMsA9wjI23GStmPrSa0QyphUiBQT?=
 =?us-ascii?Q?kYOO+0SZwT8jyyEWiWc+mpHQH4xrlxtBa0wTSPRC6APfCwO8Rsdn41grAmtC?=
 =?us-ascii?Q?4Txne0dPQlTy9yIAOOz2hnEEylGRkXa0XSzwXbAvppU+TqD06A6wYOUScvvs?=
 =?us-ascii?Q?IbQMFOvR6vhnlEa5uw/kY8VHZjIlqWuBy738cntwvMXQVTkHoQbt9Sml1He2?=
 =?us-ascii?Q?2X5d/b3YMgtr39krTapSt7mtUmUsE7YhrD30kFStb0RpC/RkqvsBKIMaxR4P?=
 =?us-ascii?Q?kY/r2quB302HW8JxWIoydw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3775fb75-97da-4d19-b650-08dbc601df5e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 00:19:15.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+F4e7DG/a+eZ61J9TpNPSKQOjgGS5EN1+hXlVMCeSGbbJr6YMm2A96y6aetyYmqgxldsETuIMJHDBuovscIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=357 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060001
X-Proofpoint-ORIG-GUID: uo-Omkk2YsfQDC5INrFagk9_20lMktwZ
X-Proofpoint-GUID: uo-Omkk2YsfQDC5INrFagk9_20lMktwZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UXrWRRA8gAsZ8Kt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 10/03/23 23:25, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Replace the custom hugetlbfs VMA locking code with the recently
> introduced invalidate_lock. This greatly simplifies things.
> 
> However, this is a large enough change that it should probably go in
> separately from the other changes.
> 
> Another question is whether this simplification hurts scalability
> for certain workloads.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  fs/hugetlbfs/inode.c    |  70 ++----------
>  include/linux/fs.h      |   6 +
>  include/linux/hugetlb.h |  21 +---
>  mm/hugetlb.c            | 237 ++++------------------------------------

I have not gone through the patch, but it does produce the following:

[   49.783584] =====================================
[   49.784570] WARNING: bad unlock balance detected!
[   49.785589] 6.6.0-rc3-next-20230925+ #35 Not tainted
[   49.786644] -------------------------------------
[   49.787768] hfill2/938 is trying to release lock (mapping.invalidate_lock) at:
[   49.789387] [<ffffffff815212e5>] remove_inode_hugepages+0x405/0x4b0
[   49.790723] but there are no more locks to release!
[   49.791808] 
[   49.791808] other info that might help us debug this:
[   49.793274] 4 locks held by hfill2/938:
[   49.794190]  #0: ffff8881ff3213e8 (sb_writers#11){.+.+}-{0:0}, at: do_syscall_64+0x37/0x90
[   49.796165]  #1: ffff888181c99640 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: do_truncate+0x6f/0xd0
[   49.798188]  #2: ffff888301592f98 (&hugetlb_fault_mutex_table[i]){+.+.}-{3:3}, at: remove_inode_hugepages+0x144/0x4b0
[   49.800494]  #3: ffff888181c998b0 (&hugetlbfs_i_mmap_rwsem_key){++++}-{3:3}, at: remove_inode_hugepages+0x239/0x4b0
[   49.803599] 
[   49.803599] stack backtrace:
[   49.804817] CPU: 0 PID: 938 Comm: hfill2 Not tainted 6.6.0-rc3-next-20230925+ #35
[   49.806599] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   49.808551] Call Trace:
[   49.809232]  <TASK>
[   49.809843]  dump_stack_lvl+0x57/0x90
[   49.810775]  lock_release+0x1eb/0x290
[   49.811692]  up_write+0x17/0x1b0
[   49.812479]  remove_inode_hugepages+0x405/0x4b0
[   49.813757]  hugetlbfs_setattr+0x113/0x170
[   49.814699]  notify_change+0x228/0x4c0
[   49.815581]  ? do_truncate+0x7f/0xd0
[   49.816413]  do_truncate+0x7f/0xd0
[   49.817220]  do_sys_ftruncate+0x27d/0x2d0
[   49.818075]  do_syscall_64+0x37/0x90
[   49.818902]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   49.820038] RIP: 0033:0x7f0031dfc6ab
[   49.820870] Code: 77 05 c3 0f 1f 40 00 48 8b 15 c9 97 0c 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 4d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 99 97 0c 00 f7 d8
[   49.824752] RSP: 002b:00007fffc62dbc38 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
[   49.826447] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0031dfc6ab
[   49.827965] RDX: 000000007d000000 RSI: 0000000000200000 RDI: 0000000000000003
[   49.829715] RBP: 00007fffc62dbcd0 R08: 0000000000000003 R09: 0000000000000000
[   49.831517] R10: 0000000000400468 R11: 0000000000000202 R12: 00000000004007e0
[   49.834459] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   49.836231]  </TASK>
[   49.836999] ------------[ cut here ]------------
[   49.838264] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888181c99770, owner = 0x1, curr 0xffff888182c51ac0, list empty
[   49.843168] WARNING: CPU: 0 PID: 938 at kernel/locking/rwsem.c:1369 up_write+0x19a/0x1b0
[   49.845190] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq snd_seq_device snd_pcm 9p netfs joydev snd_timer snd virtio_balloon 9pnet_virtio soundcore 9pnet virtio_blk virtio_net net_failover failover virtio_console crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   49.854110] CPU: 0 PID: 938 Comm: hfill2 Not tainted 6.6.0-rc3-next-20230925+ #35
[   49.855858] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[   49.857752] RIP: 0010:up_write+0x19a/0x1b0
[   49.858731] Code: c6 c8 35 42 82 48 c7 c7 60 35 42 82 48 39 c2 48 c7 c2 be cc 46 82 48 c7 c0 08 35 42 82 48 0f 44 c2 48 8b 13 50 e8 26 6f f7 ff <0f> 0b 5a e9 b7 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[   49.862672] RSP: 0000:ffffc9000475bc80 EFLAGS: 00010282
[   49.865024] RAX: 0000000000000000 RBX: ffff888181c99770 RCX: 0000000000000000
[   49.866759] RDX: 0000000000000002 RSI: ffffffff8246ccbe RDI: 00000000ffffffff
[   49.868547] RBP: ffffea0008130000 R08: 0000000000009ffb R09: 00000000ffffdfff
[   49.870316] R10: 00000000ffffdfff R11: ffffffff82676120 R12: 0000000000200000
[   49.872040] R13: 0000000000000f30 R14: 0000000000000048 R15: 0000000000009000
[   49.873911] FS:  00007f0031ece540(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   49.876060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.877535] CR2: 00007fe0de200000 CR3: 00000001f83ae006 CR4: 0000000000370ef0
[   49.879401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   49.881217] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   49.883037] Call Trace:
[   49.883788]  <TASK>
[   49.884458]  ? up_write+0x19a/0x1b0
[   49.885497]  ? __warn+0x81/0x170
[   49.886433]  ? up_write+0x19a/0x1b0
[   49.887549]  ? report_bug+0x18d/0x1c0
[   49.888561]  ? tick_nohz_tick_stopped+0x12/0x30
[   49.889760]  ? handle_bug+0x41/0x70
[   49.890703]  ? exc_invalid_op+0x13/0x60
[   49.891740]  ? asm_exc_invalid_op+0x16/0x20
[   49.892799]  ? up_write+0x19a/0x1b0
[   49.893749]  remove_inode_hugepages+0x405/0x4b0
[   49.895893]  hugetlbfs_setattr+0x113/0x170
[   49.896931]  notify_change+0x228/0x4c0
[   49.897964]  ? do_truncate+0x7f/0xd0
[   49.898964]  do_truncate+0x7f/0xd0
[   49.899935]  do_sys_ftruncate+0x27d/0x2d0
[   49.900991]  do_syscall_64+0x37/0x90
[   49.902061]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   49.903909] RIP: 0033:0x7f0031dfc6ab
[   49.905041] Code: 77 05 c3 0f 1f 40 00 48 8b 15 c9 97 0c 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 4d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 99 97 0c 00 f7 d8
[   49.909584] RSP: 002b:00007fffc62dbc38 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
[   49.911572] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0031dfc6ab
[   49.913188] RDX: 000000007d000000 RSI: 0000000000200000 RDI: 0000000000000003
[   49.914836] RBP: 00007fffc62dbcd0 R08: 0000000000000003 R09: 0000000000000000
[   49.916489] R10: 0000000000400468 R11: 0000000000000202 R12: 00000000004007e0
[   49.918181] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   49.919813]  </TASK>
[   49.920497] irq event stamp: 15879
[   49.921388] hardirqs last  enabled at (15879): [<ffffffff81c7e560>] _raw_spin_unlock_irqrestore+0x30/0x60
[   49.923608] hardirqs last disabled at (15878): [<ffffffff81c7e27f>] _raw_spin_lock_irqsave+0x5f/0x70
[   49.926781] softirqs last  enabled at (15588): [<ffffffff810faed1>] __irq_exit_rcu+0x91/0x100
[   49.929092] softirqs last disabled at (15583): [<ffffffff810faed1>] __irq_exit_rcu+0x91/0x100
[   49.931140] ---[ end trace 0000000000000000 ]---

Attached is a simple and somewhat ugly test program generating races between
truncate and page faults.  Hopefully, this will allow you to recreate.  You
can ignore the user space errors, the important thing is to make sure the
kernel is stable.
-- 
Mike Kravetz

--UXrWRRA8gAsZ8Kt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hfill2.c"

/*
 * cc -o hfill2 hfill2.c
 */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#define __USE_GNU
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <time.h>
#include <string.h>

#define DIRPATH "/dev/hugepages/tdir"

#define USAGE "USAGE: %s num_hpages num_files\n"
#define H_PAGESIZE (2*1024*1024)


long long hpages, tpage;
char *del_hpage;


int main(int argc, char ** argv)
{
	char *f_name;
	char *sep;
	int fd, ret, sys_ret;
	int i, j;
	long retry_count;
	char *addr;
	int dontfill = 1;
	char fname[80];
	int nfile;
	int nfiles;
	pid_t p;

	if (argc < 3) {
		printf(USAGE, argv[0]);
		exit (1);
	}

	hpages = strtol(argv[1], &sep, 0);
	if (errno || hpages < 0) {
		printf("Invalid number hpages (%s)\n", argv[1]);
		printf(USAGE, argv[0]);
		exit (1);
	}

	nfiles = atoi(argv[2]);


	p = getpid();
	while (nfiles--) {
		sprintf(fname, "%s/nf%d", DIRPATH, nfiles);

//		fd = open(fname, O_CREAT | O_RDWR, 0755);
		fd = open(fname,  O_RDWR, 0755);
		if (fd < 0) {
			//perror("Open failed");
			//exit(1);
			continue;
		}
		//unlink(fname);


		// mmap and access
		addr = mmap(NULL, hpages * H_PAGESIZE, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, 0);
		if (addr == MAP_FAILED) {
			perror("mmap");
			exit(1);
		}

		for (i = 0; i < hpages  ; i++) {
			addr[i * H_PAGESIZE] = 1;
		}
		munmap(addr, hpages * H_PAGESIZE);
		ftruncate(fd, H_PAGESIZE);
		close(fd);
		//unlink(fname);
	}
	pause();
}

--UXrWRRA8gAsZ8Kt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rtst

#!/bin/bash
mkdir /dev/hugepages 2>/dev/null
rm -f /dev/hugepages/tdir/*
mkdir /dev/hugepages/tdir
while :
do
i=0
while [ $i -lt 2 ]
do
touch /dev/hugepages/tdir/nf$i
i=`expr $i + 1`
done
i=0
while [ $i -lt 1000 ]
do
./hfill2 1000 2&
i=`expr $i + 1`
done
rm -f /dev/hugepages/tdir/*
sleep 1
pkill hfill2
done

--UXrWRRA8gAsZ8Kt6--
