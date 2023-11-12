Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB14C7E916D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjKLP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:29:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576452699
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:29:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACE8ohw021747;
        Sun, 12 Nov 2023 15:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8S6Gi3USBU8qyYczBpsZgAKOjIm/7zYXxzAlGQk/Jgw=;
 b=O1wyip6IXyk2jmBPGcJWPHri6CKVg9uVNboaB4/kcJQVsW8hlJ4cHVCFKVnbFnaeULF1
 Ia0EhSS1B4/9+fMV6Och4fz+qQyn3iDt6+h88dWmTDmhWFo0D0ZFz3ingwRAUf2umWYL
 0TsrdA4QxQmByYU72+SIGMxkdM9uLxz7FlmGEAANElGCNNT7udXv/CBfQl6+qqJZwMJ7
 tAfcBwoQhKCePg37cY4bDDLapq3S6fU+ELWZJVhQbskQx6FHMUs9yNTJkhe96I/UjPoC
 rd2O4ZOQPXXc3mOaol5x3WA3cBHYUhVKL6kVCictBrhqosESIHcnjeRT58QNjDrHvOci xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdhjmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:29:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCFEBf009418;
        Sun, 12 Nov 2023 15:29:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhnjwfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:29:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkAAaSjxP/tWzY2a25GNUCC4+gacliYUQwVc7/w6a8sCAF7cYbsAKBj5j2akFrGOFYDaPk0poAHfVbHJrJThKdSQw63O3u26HM2EtSVFbjA3f9Ys7cZa9hbTZW134YisDBcs3IicG6iHaCY0mOSFRw8MvrFiFlOZURQRKNX+4W9LRxZxzFL6KUo0H1/HDteClPsgI/dv+gih1tQ5o7qk0FW2PzeM8N6V7LVebTX1a7ZSHKojZ61w38fv1Wv5KM+NLLT/2BII4hl79S79xr0tyJS3jyGsg3jF+jN/eI5k45VuUmftTfT9iWJt4OfBBHB4Z0RY8vZyeLPVuF0HR6kqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S6Gi3USBU8qyYczBpsZgAKOjIm/7zYXxzAlGQk/Jgw=;
 b=QtNUy1jcnA+JTD6EK4dqhaXjw/jw7b/DVU0wvzUkOq27007E/0dox+cvHGlXdLuxTQvDpHcwJGtvjkrvqa48PmDOL/OkH9yLLN/Q0mv8Oqz28eywMnyh3gSqqSYayfnhC4HrRG6wi6DBHvN6gKUogzXr8tVJnFFM34klPa1T28ozfqXVddGKzB//evas3w9oc8xb3JnptobpIodi1v0BNmy7M2t3/JukmoqALqCaIj0LArkLPXEREc+mcVN03e8Y3kNjbBVeNNCyUph9q37Nu1QiFICc1ZL1r/pye2OkAFDJ8B98UnPj0oTX9K9LdCq0O411dGzN9vKE7ULrLArmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S6Gi3USBU8qyYczBpsZgAKOjIm/7zYXxzAlGQk/Jgw=;
 b=JRmB97oT/eG2ODi+bOj8aefm9feCpszqc34D+Ccyd/ZJguMPXAwXHj/+nkVLIjG55+nxy9qoAzggZznS7G1I25uJo9/erV73oZoW0vG1+gOO4MuJ52BZIzQrlI5SbmiEdN4whEfzgPR3jdgH1S71CHBVMWBgK4CMVXsjj+vCHr0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Sun, 12 Nov
 2023 15:29:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%6]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 15:29:26 +0000
Date:   Sun, 12 Nov 2023 10:29:24 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: remove mast_overflow.
Message-ID: <20231112152924.wzuxtcsvlwaxhf4c@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Levi Yun <ppbuk5246@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231111110417.38655-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111110417.38655-1-ppbuk5246@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:207:3d::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 217d7023-af4a-472d-b81d-08dbe394272d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcOAUH4UmC/KtnDZ+IT/FUWD6S8ElMi5ki+dw3lKydI8NMbShX1ebMtiyPLkQ9wMADpu0f7FlXzqim45Wm2lkeTnU/rpl8KXxD7Ly+0W3soFrh0P5LEFMydMttfsn+TxT9SmFAQarrrNmzJbpEjHbZdUr8JPB2wPf78gWj4qa6fxPCEJU98DWZPKtsEOxQ1l5VAiWfd5QXEMrFHpBfYFZ9cohLPuxqjVwCExJf1agpLJyqjYX/vG7SIlfqpkbbxF0p2+SR413EkafrnEW49Vr1Dq39jTNEReKKTXWu6sNedNRQoV/0dmnx029BJCpSnlD3V5/A8tIRIELODGmOKCmE3RNfjJ3vCpM1Fn6C1Qvd9ZNuELSuPo+6W4erJ7BgO7b/z3Fi2uyL+cELJh/YmVp9zPzWcvKUMjDiLCjsYDzpDgfhc+FA3jA28i3GeQhFkSXnU+8d4hcFyXqSPIyQZTiURsP6FHyX/Ukb8wPWomO98zeuM2dth8ZmvS7d+Yce04HS9OcYODf8cdvYuf9mYm+hWBmwBbdEFOwHfNSv4axwdmrbQ43ImbZoV8CyPR9ka5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(1076003)(26005)(2906002)(5660300002)(86362001)(6506007)(33716001)(6486002)(478600001)(41300700001)(38100700002)(83380400001)(316002)(6916009)(6512007)(9686003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGTECK92unLy4Lpr6ldQTEqBzvlKmjatKI6bll09xFYiSuFylA0RAtjsTJoL?=
 =?us-ascii?Q?SHyBTYzAdCtryeOHf7yN0Lfk6xHJfWCYb2ZF8GK4hzuRAoMh4P+b/X1pkM8o?=
 =?us-ascii?Q?8klDJGlodX1Hkt6uLXQ7rCR+nvCWMyRFLMbvAiU4RSaGNs4ta7i7gqPqvXt8?=
 =?us-ascii?Q?YTaGj+A1aCRVbp3uc7um5X5EwBUWM+ep00dYL5kLR6mto5lgH8myNfyHqXb0?=
 =?us-ascii?Q?k40b1X4R6/RNMyL8BCWhtSmvPdA0AdpH0m9VK+XAr5B4wrSB+sjP5AV8wAZx?=
 =?us-ascii?Q?6UYFsHl3ODxNRrS8fKctUNoBan+CgGIW4eQqpE+bzC5/vCFgaiiXc9mpunlb?=
 =?us-ascii?Q?3O5b/YQnJcE9nkKzy/jRjeYLrtWrs9VuqR+fD64e8mYQdvHYo8QhZaxhO10f?=
 =?us-ascii?Q?0TOWPYqd/mCw9g0w8cBn+UT1l5krX+6GoMV5HGwXVpsGYVLEBkIO2AKNpV4J?=
 =?us-ascii?Q?2fz4RgZJlNrWUrlMX1eaWmYiokqvoiCciYAwPIVDVcP28qz/mWG+tD0dK8er?=
 =?us-ascii?Q?n45/8nu66xchsZUDjxg/dt67etWwPVctgrqrerVNsvZPTECjUfsIhP57xXH6?=
 =?us-ascii?Q?hxpxbxXji+UVuXGXqjBMtnUKeaJmofT71NYjhBIPv1xdD8rWRI8mZJTZY/Hi?=
 =?us-ascii?Q?QXAsH+JrVuVL3Pe/hZBTna4Mvkr1HrSSW6aUvASwl27/qv7sYQzg7tcPcW8M?=
 =?us-ascii?Q?RkugBSfz/h7I3FoboJqMjj+9LQMB64UYNUfZucB7si6YcTZxIp9OV4oqOP40?=
 =?us-ascii?Q?6VBRxCXcHnDcg6xVyU6/BGgZZyF6G/LPcEYyrbmP5NuCB9gm0+fk9aklGysW?=
 =?us-ascii?Q?l0WSK/rrjzb1p8AE0kwwaT8P9Ip+ZfwKvUytS12ALiROj9Uy9ZzdsibVDZ69?=
 =?us-ascii?Q?5B/z3fFLmMlhBMKcCMA7vm3rDm7KDShMDDeab7b+9pWLVRGIQB1bIZm5r3mp?=
 =?us-ascii?Q?qnSgz0E3gR6CZmVlutJHDNm6Zl/hgEvWgiRvReWC0nO9W8RNrcZKzABuRLHD?=
 =?us-ascii?Q?memgjFdcqZFXD675t2JtCQba3RdW7tsm7aCxTkxgrzhNcuXnaxtFCbh2vIpc?=
 =?us-ascii?Q?4AE7dLnTqllHw2gWPO4EGTroVD/3n66tN4kdJr2XggY5/sdfbNj885WnMdw9?=
 =?us-ascii?Q?lxtqAzrT/dAQScCIVpf/Dr0+R8HwU2akRFimsKHdyOMFIXmyGHSqMSyY3pQA?=
 =?us-ascii?Q?5DhM7fVURpk2GzOCYwPaDqtWpPoqQGrzPNsPb0s11ppf5cc8WopZpjIN1tFC?=
 =?us-ascii?Q?5UZsiYPGsCjq2YgBwQoU8zRblRE96nr9L8XN2dl++kUNpALMa2vanmBSRatu?=
 =?us-ascii?Q?mff7rROgc+xwtGUd4ul8eM4I6ki/PXXkT1N1hCBgnUs9D1Kjk6DVHeqtOdD8?=
 =?us-ascii?Q?Hl6bsXh1lQGOt3XXw4yOH1DPUJZVdHBCBx3qepcAk+0bJEw9A6UUXDOuBxO6?=
 =?us-ascii?Q?c+rcLCFF1U5RnM4l9mFwF+Jt2ppxZz4zMgzNtJ07pLetBSwg6NskpCPxc6A6?=
 =?us-ascii?Q?mFJqr+F4J5bBEa7iGVw5RuSyJeJ5BHUj38E8cdNkeUbE+9Gnw5CIUDQetWka?=
 =?us-ascii?Q?YrWdORY+BU+mcRH9fTYw0kMex3EpA+EL4dw864oR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q1JtpagLFY2tkyIRNKixa77X9xpmAt8bMia+i5Zw/JAYLYyIily9Me97eEEepzdC6lI4bJRVyowUpwnJJCp17CHBww4I5wKqRukonB0fRu1X5X7yvAceWUhQSOzrshRwXwg91EUPE9gzsChHaS3N6aPP4+cg4/iUcfuGuQXsqTmEfoLULXnAIq8lIcxBpF6xTZScnr1iU/9V8FgjhwFFN2UbxEN9TAd/ymmub5wjJXdL8o8JjA0cEKi3bdhOzlBnMgWXaOKCHGUJFzSwDRDnD5BmS2001q50C517b8gBzr72zdoXGnM84uo4e47XsIGFgYwxEWU+nhlMoX95xaxES6ZU952gS9EB8LNGZiFI8wQ3PVxE+uLbE26UyY24kiWVo7dGE2PDpC60mWMOEVY8JaqjXOwCq8zhswAxrRNxbiAGSDSJraUIGTZRrBbKkPagDc3D83Eku+bO/FzIPX+5WVSbNkP/xHGotYH9EF7ke1Cn+tLcA8UYfylsGUs3Hyv+ANJySqlXNaUmUy57zrF8XCeC33+u4YtKxErMEdR0d8QSbJy003QokvxNucUSeKmm0E2Vvmb/OjQoXHT3MzRYFOuquRtoO6YmC82FTxBZuA06p6zhouMqZweIrJbRp0zteEA/bS9xTjF6AXTe/yqzkiu/FoWFFxW3vVJFno1uyIgI0oNxf36D70IBcnWNrKsLkOGlXxGeeZh5rhLJ629CdQ7avEoG1rvKg+IRMdVQGpHiBzLOrMw24SdHio8/O3MYfdx376T0YyyRWNL+mP0uwwiOcfPREkRZ40009EZYotnZKTHj4DSXo93v/gYpDtqdOL0nyFpT1kCqEjow1mTCJKfjVkxkYiDjxwb0MDixaf8Ntsf0RS4eIF2lbJuS0Nce
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217d7023-af4a-472d-b81d-08dbe394272d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 15:29:25.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVMw2UopLASRjz69ji7hbZB97Iji+fztDAZsPCpgSr2tXcgJjPV5Dg8vcvunPsStnJkCu5jWj2ReNS850KQSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=765 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120136
X-Proofpoint-GUID: aXgqhvgmW1toIoNQ__R3U8VoUB5skwiA
X-Proofpoint-ORIG-GUID: aXgqhvgmW1toIoNQ__R3U8VoUB5skwiA
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Levi Yun <ppbuk5246@gmail.com> [231111 06:04]:
> mast_overflow is used only in mas_spanning_rebalance.
> But when mast_sufficient is false, mast_overflow always returns false,

NACK

mast_sufficient checks the mt_min_slot_count() against the end while
mast_overflow checks the mt_slot_count() against the end.


> and when mast_suffictent is true, it never reaches to mast_overflow in
> mas_spanning_rebalance.
> 
> Therefore, mast_overflow is dead code in mas_spanning_rebalance.
> And there is no other usage of mast_overflow execpt
> mas_spanning_rebalance, Remove mast_overflow.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  lib/maple_tree.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922..1e591e71621e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2767,19 +2767,6 @@ static inline bool mast_sufficient(struct maple_subtree_state *mast)
>  	return false;
>  }
>  
> -/*
> - * mast_overflow: Check if there is too much data in the subtree state for a
> - * single node.
> - * @mast: The maple subtree state
> - */
> -static inline bool mast_overflow(struct maple_subtree_state *mast)
> -{
> -	if (mast->bn->b_end >= mt_slot_count(mast->orig_l->node))
> -		return true;
> -
> -	return false;
> -}
> -
>  static inline void *mtree_range_walk(struct ma_state *mas)
>  {
>  	unsigned long *pivots;
> @@ -2934,9 +2921,6 @@ static int mas_spanning_rebalance(struct ma_state *mas,
>  		if (mast_sufficient(mast))
>  			continue;
>  
> -		if (mast_overflow(mast))
> -			continue;
> -
>  		/* May be a new root stored in mast->bn */
>  		if (mas_is_root_limits(mast->orig_l))
>  			break;
> -- 
> 2.41.0
> 
