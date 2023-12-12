Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF06D80F7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjLLU1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjLLU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:27:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77352CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:27:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJaZV5008514;
        Tue, 12 Dec 2023 20:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=3lolOOrsBLNrtcqjnfI8/hoDcGoH44mXA91pxhqWb6s=;
 b=EPnP/Y3Q4H8bS/k8dt1CxJACJQpjys+8WYpd5bprivWsZvtCCVUIXcR9I9bBM1LSQajy
 YOifsBqng5gBnI6QX9Ku0ItVckljL1HbICZ79au06aTECJ7vKTBbog7GMUKX5pyFO+r/
 2wn42UxFrABurOPAYal6/Jb2FBeVjajAwOZwIVIBajiohzmq/GMZjnFGbCIyBn4kK62u
 mRIVoUkWQ1d4+SYcr9l77BRD7BN1wbSYJ8P8hOENt0mS6ZsvlB0r36Vpu/HVkoA+JkMt
 CG7e96rPqQNYzh+L+pWkW5zgZuFP1nUiozFfU4drokl75mjIbR0erCKmJ2LXdOFemEmp Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df3b9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 20:27:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJreOU010087;
        Tue, 12 Dec 2023 20:27:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep759b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 20:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STuJF4OQPcGAoY9AF/RZiiG92A31DEx2k/4wbLF/17wkdzzo6AELe1OG9yrMXq3mFR4StTFlfQOJ6UOmsi4t/SO2bgqskiwYutic0vATDRtB2TEllcLFG3G4qQ5gHv+ln2fxFgYS2nRY4iWUHFoxkDwyK3VT2vzn6F3DEkb+Od8El+RsogKDDXoLovR+ENH6iR+9bkarXlTdqS4iAy7zHKWyfpxMEa9Mwq6hU7GBHRkQTIPyFhyZ4xhp8ZPglJ0XUVZ3WPaxsJ5D0mokNkruRjp075seKQ3tP9o+f7J2rYo3NDuX2ip1702NZHH+QmxHDmuzuII8gEwl0LvQW4zYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lolOOrsBLNrtcqjnfI8/hoDcGoH44mXA91pxhqWb6s=;
 b=KdI9ptD3+FXyMifqboPudQozD3u8BiOEv6VTVNqSyn8K16h8UI405wiNDsy9CWzCKAz6oCCam+yalmbNeeP0ISct9wvPo4kPEh3NTdewayO8D9oXzAjgHXSz8lvwYt4u62j0RRCqp9TH7iE0tO+d1YLhruAVAkr+/Jx+01YRReBURlL/Y5+U1YLhGbqGe7/PlIC6+hTjerxYm67D/arerDGujGQ+uRHUU/D2Y72H+tBK8raFlJ40FeURLnZHHx/IsJ1fpufRrZhYw3IpDyjC6HqlsFep2JEF5Mj/6iy1Pg642dvdsp7Ch2qBaSE7LaQD7PmdoSwjWiT/Eg2DIYXm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lolOOrsBLNrtcqjnfI8/hoDcGoH44mXA91pxhqWb6s=;
 b=gQOaHjtKPR2pzwzFF4RaABSC+dunOERNtVgfM0RUnpkNEF12kfyuc8mfkuu5NnQ6Ncn+cfDyJfDSoMQoGSEeBHRnQ0R0xgbDTqqZ+yG2tIZWUFOR2hPzc113aFkbWMQLfKAhsh1bGiKr78zSCkNnXe6oR6ncIta4ozwrnJEMrlE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 20:27:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 20:27:20 +0000
Date:   Tue, 12 Dec 2023 15:27:18 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        willy@infradead.org, zhangpeng.00@bytedance.com
Subject: Re: [PATCH] maple_tree: do not preallocate nodes for slot stores
Message-ID: <20231212202718.mbv5tk5i3lmmc4ar@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        willy@infradead.org, zhangpeng.00@bytedance.com
References: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212194640.217966-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef211a1-ec3c-4335-8114-08dbfb50be08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nx+upfv2Xf/bGcnuCzJfQEaohvAHz2+xNpYu92CwinDGXSSi+1xerK3aEICuDx3uLvF1v5+RtchWe0HmUsQ/6wOhxA9zdG1lUG160t+pqJic9ElNyn7g5DICcujOm/LcFgx0AII/w6Oi9vWV8lcxgRNgBRBo/ZgoXT2cHQKvWMLdC/xtD/0yYyAObgCBBhb+9RZULTwjuLQFHWIu8pFakVJsV31i+2iY+mHjPwHp9viqHWe5Kw8BSOxKmMrSf3szDoydXgDR0ASHdsN5eLY/STQwURMmcuggjVcnJ8uTtOWmhC7AwirEthBSXnYAP6ZsXmDAAo+cP38+GM4P+UNXluZB2NkGxIuQ3ysOzSwfxE91GmZrEOEdEkWy4n8k0lpWqqimenZwcMznB5tjbjGjhIKw/Sg4D0BLG+eQgXaYuxpLxJCzQll9WX1W40/tJKg+wL1BaY4TOiw3ZOqKoC+mZhY6WeBIEDpv+SjfnSGVRFOtmlCBsCVFS9B9E70GGbrDbe2pW0GN+FqbtYmoXKtTU5ZaOMSFxa+RB7yUPwnnQCRNMfb+oseBnWfwHJkzMM29
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(5660300002)(2906002)(41300700001)(86362001)(1076003)(478600001)(33716001)(6636002)(6486002)(316002)(66476007)(66556008)(66946007)(26005)(6506007)(9686003)(6512007)(6862004)(4326008)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BN6iGzFYWKcJqcUMvJVOvbB5zX8rFTFC2q/z56H5LA6zJzmG+8lOKfU1HEjJ?=
 =?us-ascii?Q?O8YiOS9UsmNDOp4kvfy5P9ZHSjKbeoLF36JrGpZtjhXTKr5L4HK51dCcxMD0?=
 =?us-ascii?Q?UKOQ4ylNJgHJ1QZhteJlYVHFjfRyNaH6jf/+T98LTmPnAMwurAda+E3NHdGG?=
 =?us-ascii?Q?GXZewgHfX4lkSqdNfc0IzQLOWMJlDDYJRQB6uN+sI4ytj46AV/CMHWLKL+UU?=
 =?us-ascii?Q?3NtvMDDOGuQngxDJyLAg9LcJmbgAV8hdph3Fe9y/lI6F6urtBD/9/cHW5Gbh?=
 =?us-ascii?Q?nS11RdZN7PAyPtQaccP2r1bxq02OwzNNbeXpemcacAaVlliXEGgWV5CAYfJg?=
 =?us-ascii?Q?n3w2lXCLCo9aJGY5FtSSNfvJNVhucX/sExyAxDOizkEz5TlkfYYchHLuBPIw?=
 =?us-ascii?Q?HsQoFWQYkSPmKQsDe+psFvKvdLPkCP79vgI+ExjRaPXxrwyu0htUfT7e7c0k?=
 =?us-ascii?Q?j498XirKcx4mffPKXqzjzwH6Nau103Mr83cVWrB4TelfSl51Ha1D1mph8G/d?=
 =?us-ascii?Q?mpOY1Ww9iLRhDcRwSlVBu/8aPRzZ3OYEAEmoIilWbQ2EldpP4QgSgQRxhx5o?=
 =?us-ascii?Q?DESiqjqOsiU4zb9j/iz+uOeVw66mXYk6ActHjTl/lq5liQdoWarACiMbbMMv?=
 =?us-ascii?Q?as4GywBML73/UKf9OBGsL0hkLpM4za7e8SlrWO3uGPzs/xjojYuYFXnLvGL4?=
 =?us-ascii?Q?r9tpqMw9QmqL+gkkGFnuyfQ+GbFmUs5ztYCgkTUpv13cYekYF1YAi9DapyH+?=
 =?us-ascii?Q?3Ir2fAvJ1RtBwZA3EBvmlde2obGc3GamVKlIdmxI1pst8hG39++A47UJU2Zb?=
 =?us-ascii?Q?QY2myqiN6JWpnB0kl3oFZCYUeGQdQPkSkUIffxhjBjsrujbbSrDSwoKAozCn?=
 =?us-ascii?Q?wofCKMB4oGASahaF/s59nxCrHGeIjoEixKhY71KvjwQyqSBHssMziqIBxVmc?=
 =?us-ascii?Q?3Ysa0OR5jekBJdHFtJSq+nOK18xx7hlSG8WnjwGSZL43W2IVu8mEln4CoA00?=
 =?us-ascii?Q?hejZrzsqXQDPzGDxmwxpz0uytxArdKpCked7D/XWdMXS4IlkNoq+YuyUJ0vL?=
 =?us-ascii?Q?gSX8OizdMIO30h8WMWLbLs/x1WD/JpRjIrfG4ZITNBbBeVTE4+FvYkBSMl5R?=
 =?us-ascii?Q?fzkO2Ds43FBjEnimSyxf3kiJ+mqqijQxw6Nxz4fIR5YJhStAKMgRxKOnWzPn?=
 =?us-ascii?Q?ZThzksaTtWkg15v4dojrcrwqXL0ooMBEZ97uFrlqUQCSEptiekzeNmVDVnEt?=
 =?us-ascii?Q?QFEjf75JEov6nBQwYqGbmGtEODtPcOwizTk2thnxzP+3sJ9jaDj0DtvNYpcr?=
 =?us-ascii?Q?xRoSwsms2diUtw5LNJp1QetfmENYa3DpZT5M1MB9bKzdfyddIVXpZ9D6ynAE?=
 =?us-ascii?Q?5NGJdG19H7eFGF0906ZDzy9edehXyXYWrKSa70iitBwnDwqzmNKOzKSlpsvK?=
 =?us-ascii?Q?Go0wu8vWGu3vLu4WH526HzY0tQwKiy+dJMEHSEmcl0ZuxstsINnob0AxKejM?=
 =?us-ascii?Q?y9jDURgqu+4/0go+fStI8o6s4nq5/ZDJywVRwqTSc2tx8n7IUoZ2JndPepq0?=
 =?us-ascii?Q?11dL2NVtmOUd+mzfcYneIbRIb3emBjyG+c+6xwfe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hn5bw+pAZ+vYOVzUIJJxFV2sy2UCHKlH/K/TWRqVaOm5NB4HcxfX+kSlzareaSPqDDssJNpRT24UVM1a16bKxQ361lUppk8yldXQ0fKJHb2cD98Fq1Nr/mZLBMJHn6qn9XqXMXYbdqr64NvP7IebxgxDVIBHI95F502EluB6G/BhFpizTKTIE4S98WZJrqRAFgxSf/hVzTr5V7Homm7ZDx9K5/CMDg3zfZCiNfQb6bQRKctnS8VkOGLeJmBWLWxo4sAyJBC3s0IA0TVHa7Ba64yaWvWWnQG46wO88i6P51kZT2cBwgOGeiW99pQLWLUqwjJUwocmzq7Yc1ArsUO6jaR4Vs7Nnk0a6J1xiobIZogfnm6q9RZ2WdbZle3Cu4CSCJKwjuoIV2QiJx43sVZb51vLAK9NIMe4BAdBJjbZTqHGHbhyPo7bK3GdDWthsbkSSE+c65uKI/XwZIKNdc/750EZ6XH+MkFKpLNRE9BuIFEf7+a6lamRcoo2vzb+ZLjsnkWKl+alweO91YCDE945hAbkJf6e2n6lY7mz/pjAJGJGSsBaHVbSdCVpCxCvzkrvxDW7jWsq5mql9fj8EzDP0vMING9Mn6Ar3AuvAifjGp8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef211a1-ec3c-4335-8114-08dbfb50be08
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:27:20.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdRDATQj3tQDeGWzUurC559xOa0l07Y9CDIlJOIu8oxGhIQ69//VKfNPREOizh7TTdIWrO0fziId3vcxxRPTJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120157
X-Proofpoint-GUID: M0bPcXah1p-jSPACS1F5HjdcBXCZBa-8
X-Proofpoint-ORIG-GUID: M0bPcXah1p-jSPACS1F5HjdcBXCZBa-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [231212 14:46]:
> mas_preallocate() defaults to requesting 1 node for preallocation and then
> ,depending on the type of store, will update the request variable. There
> isn't a check for a slot store type, so slot stores are preallocating the
> default 1 node. Slot stores do not require any additional nodes, so add a
> check for the slot store case that will bypass node_count_gfp(). Update
> the tests to reflect that slot stores do not require allocations.
> 
> User visible effects of this bug include increased memory usage from the
> unneeded node that was allocated.
> 
> Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> This patch passes the maple tree test suite. A seperate patch will be sent
> for a 6.6 stable backport as the node_end field was moved from the
> ma_wr_state to the ma_state in a recent patch which is not in 6.6.
> 
> 
>  lib/maple_tree.c                 | 6 ++++++
>  tools/testing/radix-tree/maple.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e6954fa75eb5..e4a39beb1018 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5475,6 +5475,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  
>  	mas_wr_end_piv(&wr_mas);
>  	node_size = mas_wr_new_end(&wr_mas);
> +
> +	/* Slot store, does not require additional nodes */
> +	if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
> +		|| (wr_mas.offset_end - mas->offset == 1)))
> +		return 0;
> +
>  	if (node_size >= mt_slots[wr_mas.type]) {
>  		/* Split, worst case for now. */
>  		request = 1 + mas_mt_height(mas) * 2;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 687886cebd9d..f1caf4bcf937 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35545,7 +35545,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>  	allocated = mas_allocated(&mas);
>  	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1);
> +	MT_BUG_ON(mt, allocated != 0);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>  
> -- 
> 2.42.0
> 
