Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A207D3E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJWRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:55:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB26C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:55:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NHq9bd011547;
        Mon, 23 Oct 2023 17:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ydJCY8Vd2HClQXi/vSEcTpOWBxusMy+rLP3kHTZMWao=;
 b=4Rf9sjVVZJ/EEt5/h8UnPCGczaI73hfQMjxiCvjwovmA4MjmjsGS9bP4amPTfQiniMkE
 t28Xgfa8+oHJ8L9jumXww3LTjYKj8lbo1H4sAFUpljr2bxi8st8dRBCKiSrqYl9pjSuN
 p7r8/A5x8VmtW6mrS0xS7HXJfRMjTfwy5PKXsjxpWoNIYoobFvVzCQA+Ms0oSVlt9Pyv
 6kemijq7iC2LNJ5viXSlAZrBr1DwnJ8uXT6y33pN76ZYoQ9qfmPm8/fat4reHcI04IWC
 OOKACJSceu+6SsiePqpecsQhx5bV8ZEwwHxU3aiKsKeVntmSI8C7AmcX0PtLNQi/JrDV Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581kqjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 17:55:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NHKDU7019157;
        Mon, 23 Oct 2023 17:55:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv534hm6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 17:55:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCRuHmJINZ8PgzUHv3HETRACSl8jQp8pRudUTDy1H8bFtIXndJhzd9tWh2U3wVVh36a0O0raSq2RyFtd8od0zkYgLw9FKqqlLyc6vBmxTw5AhMS0PfLWRZlasiA5FP7ATnfbZK7vpv9HTfsgE2LkBcvFUiPEJp/V+B4aHBa6IcliPnql046nBmea9H373jTGnCZRddb9/p3qaMeT3AmfRP81gxW/zE/22EDsprioyzBpwcxxPPl/KIp7jhI035uEzg+PGpXUYZZMFSBn/YZ2XDF6mONG/wh/yw+JmuMERY36EHLNBeN6tYty8OwbeDwumKekmikXLTIkTgnJsZmkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydJCY8Vd2HClQXi/vSEcTpOWBxusMy+rLP3kHTZMWao=;
 b=e1edl/IX54P9xtTwoVcnM10D+fE4CbFLEtgDZ+lcdeKZAMrx1l+QomjvLAURtimniAcQIpLWI/AmDn6LcjoDjFp1NGQSBkZR20PmQmoLDkAh0mcQMppZPqhLI0XRR+TCr+gs+967kzXXxQhbDWWaDWEBEiH1KRU3TaWOGD39IXudV8K2rW5b72NGhOhizbYhV6w3u3qKcgsADfQzzQ6amqHZby4847LOnGr/ZEbLPh6FzV2MKAIY4CcnzBFZ8aDHD4N9N1DK9xrUr23yupSoUMi2EsQdqdpGpZVNqpZKJ5kyaa79Y1FbBQb3XXXHN7TOpYdIyERKkPLyNPHSDWeu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydJCY8Vd2HClQXi/vSEcTpOWBxusMy+rLP3kHTZMWao=;
 b=KbO9o1db/jNHOe3W6ua0kvSk/IN+ONu4c67vvG9jZbHPMncyrE8DX//5fJTg9+jZE4n8e+CAmEpESKM3nx2U7TLfPCcioGaN16W8E0GIdmTOdwQWHHRCWqJozqXvXL7lnLq83UypXjXJJz+hJsjKAPC4Y0bFuy8VjcjyJKZkeE0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM3PR10MB7928.namprd10.prod.outlook.com (2603:10b6:0:44::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Mon, 23 Oct 2023 17:55:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 17:55:22 +0000
Date:   Mon, 23 Oct 2023 13:55:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, postmaster@duagon.onmicrosoft.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (3)
Message-ID: <20231023175519.4jtszivgfidn6p6j@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        postmaster@duagon.onmicrosoft.com, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com>
References: <000000000000985ef90607610b0a@google.com>
 <000000000000c05f1b0608657fde@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c05f1b0608657fde@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN8PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:408:94::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM3PR10MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e603759-5f02-48cb-a07b-08dbd3f13a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kktrOLvE7FyRC0cE708I8ySF+2u4e1Bn+JRryPWqG+ODSjO54p0wNEd/GmZGstMnvRFkcaIbgr4hz0ViQ02hfPh2ihAUeCqWBni0RANsInPY5MSsxT5i9P1K0eEGJ6ue9VNqO7kDvIolMlllsgl869WabSNHesSEpxPIuwkgaVW4WO1pfDvUodkwnV8Ft0ea+Y3jNEQv4sxCO8n1jeb/l3+761Nv7LoihNNDol6mPnQkbq1dG29cndhgFZUi0Le14+VW61sZo2xyYkpSwRPug5Z088A/NRAc+lgMh/kiM2obyafW7NxY3Ip7vufMfL0L0/rMJiWvbAI5Ur/5wlIG5E8x4hUkXtLCjJzbF8FSe9tY5wGKbBtBR8d4wYcfoe5E/R/ZP+MCeJwxLxzkDHXrikTajEtTWtB6eJ9inRFH5p6pmPysdRZhF4mGhamBFo3NVil52KrVAQXoTU8PHX74g43k7UhmcguLlamUCSkT1slreBwSX/FPbudX6puULJKeMUuDBpPn+tVcqy85V7TuIIte0PU+hVG7pdOfj1t+Kfa7sicE3Ri3miLL9cZe8iWkE6tChL550B6nzenuOTuQwXcHch5p/JONHgUfcyu5F5aIFKnaI22KCfULb6/qiALoRrqfgyLd9R5X5O0axirnBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38100700002)(6512007)(316002)(9686003)(66476007)(66946007)(6916009)(66556008)(2906002)(6486002)(33716001)(478600001)(86362001)(966005)(6666004)(6506007)(26005)(5660300002)(1076003)(83380400001)(8676002)(4326008)(8936002)(41300700001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/8eraVXXUjl/w9mzTh6ZlFuI9zfuDvPlBmNw3AWnjccShOMG2UOBC6GvCFg?=
 =?us-ascii?Q?AzRxBpZarUUP50XsVQDP/tW53xAVmLLkKDuMtK+MJR69zAx9bxxQ0wGRkbD+?=
 =?us-ascii?Q?524KhD7QJ0NxPYjpSwb8yxxx+G9nzUkYw8QaDwuO+3Kcg7zAT6uYsOuFEJ6m?=
 =?us-ascii?Q?iODIDrsZRt7e+G0y8D6gOuMbCiXp7oWOAutEtHLuqX4f7Qk9zwWUhRw1Pwom?=
 =?us-ascii?Q?L6sQgl8cj9PAHiAVMb0QdAMZWiKJfJRtaZm23fhYEq6rShGfNG41hzZfBdZG?=
 =?us-ascii?Q?5TThoi5sITBJXTeYoyzX9bx1HADCBFFYBQ/Kuwl+to9ocxFzKan07+vhHisi?=
 =?us-ascii?Q?ro+1PvzHDM4knDuaeYs55hm6ck9mUueMsUWRPXf6Cs84DMqx9EH2t30Krcl0?=
 =?us-ascii?Q?Q/g8D7IvQ3WPd06vDOSScTywzMhtc1KyfRTuU6r7LzJ8sRM9GiBjHDfezuEX?=
 =?us-ascii?Q?ex3m6mNFhQuO9MTZpSoPh7DQLnFAShPQxNjAQyOcQaFrqD1p1FVmit3N7f5+?=
 =?us-ascii?Q?h4/CVquP+p+kM26PKAOQzqG9PYqf46kJmGBTML1V3AXY48sDjV7+ZXjaLWuq?=
 =?us-ascii?Q?K0IAOaOk18A/DX5E64sUVCkE3/ix37D3K+OFrx8x+HBcHrPGlAOsDbZ4I+wD?=
 =?us-ascii?Q?mB8BTrItgFSbXOxMoUQ9me5KNjW90PWzv3htYmVDgJ5aTRPTBjczgzUAmjmb?=
 =?us-ascii?Q?YJ40odbleHSqxA063BD0G9yzOVUcQc++XrKZ+Pf5WPn/lCt/m+fMaOhKcEIM?=
 =?us-ascii?Q?uXlqcasXzQWg3m2KPebQLUn4AmRwmLVyZNKLYrCDGmnUNWhDcczinffeDVcB?=
 =?us-ascii?Q?EPf0DAdSycgKK01AsM0ibhQUOU/9e59Fctntxubh21QtCHqio80hPZNJN3yZ?=
 =?us-ascii?Q?0dDfmcRZEiM/pPEeXe8kPzMsBy98e63qB3n62EIH9iqd2PUSaGAAoQNDNlTV?=
 =?us-ascii?Q?EvrXiv2OKkYb0I/W+Upg0/j6oVJJSd/SeheiCTdFSzczKauQ6lnKZ9nTy6+s?=
 =?us-ascii?Q?01cBi4/z3FJw0csI46sjDO1IKjEq084c+gAr54qCnsz85v7m2ZrYONgMxTGW?=
 =?us-ascii?Q?wj+fq5PCeTBEdQbITB9iJS+LJastrqBsroRSu5LPuQS7Qq92ph9V6YYT3EY3?=
 =?us-ascii?Q?pSL416Vjb9g+xf8srhaom1rJFLymByvluRhxO/tQ0Zv7qnhmcdGXQOKzjnEP?=
 =?us-ascii?Q?wJbnr2Lp0oQzvvF4LHY0T5BJJhOuW7JtH37oBnGRlsFHbxWcEPQW567K4tUK?=
 =?us-ascii?Q?10oDTtwXYRT/1Ag2qLjLjOUS6Fo8Sa6l/VW5mERTY0yxw257g+a4XvePiit1?=
 =?us-ascii?Q?CBYQH22mh5hUHlCW2EcNM/+hnmmRCPVNmkVtDsjEJt9L4VOOuJlM3ukPCJYi?=
 =?us-ascii?Q?ywcuZ2ZYjVCwk0BQU4A9n1iuDGBCyksFBTDLf2Nx7D16E20RNxo+0G9Iw5m+?=
 =?us-ascii?Q?xTZxYDH63pSZDcKjHBaDNGJGeBBotwBSDQKD6lGsfbXZIth6xcXt3KEmcuQ1?=
 =?us-ascii?Q?IzmbB4BonLy0h6KAPXpV0hM5u8xcaT2olRSgNhbeWwgp5ufhSUPilWf630aR?=
 =?us-ascii?Q?MZNqgVeS25jB54n/3GNrr4lMu3AA20ck3Qy09ZYU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?M5+K2W6t2n5eD3WoqcSMxpU0Gm15CjoQPeDZk2FePGFi7wKE43fCudM2pyL+?=
 =?us-ascii?Q?0dEVH8Pw77qcn4wqlZcUW0kaWb2KYLbtAT9YCqACYymh2HhXWE9Z0j0Ukhmw?=
 =?us-ascii?Q?vrvlqv23MYe4VNoDzJq7hBlS861TMSh9P+19n0VJLHCwZsUCA/e2nctoaJN0?=
 =?us-ascii?Q?nJu75sjA36AjbMs/yg0pj8IVbqB9QQqaXr+X/I8h1+HpW5eD0lnTQMLc/o3H?=
 =?us-ascii?Q?V2QD+AaTKVBVRVNZjwqgpn7guD0e/uP4V6K+KFPcYquZP+k7y5dy37i2p9gt?=
 =?us-ascii?Q?RSli2tOGjpv+MVZy16MtHxyPaLt0m7T4QDLYzK6YdnhSJ+gj0MImNHAvivYc?=
 =?us-ascii?Q?jd7jKq9JSlq7MooTV8DtY7anUzi7Uo7zjTegaQpwaSHHQPcdQs71Ak9xrBSD?=
 =?us-ascii?Q?wstDVSNclX2k5eyNnZPTRtrB1jPo9bcUtmQ4qNuJcB3vUFwuf6UYyOMebVug?=
 =?us-ascii?Q?Slb312bKKqDg9qYZwaqqzLlXUIgPrYijI/ZRLelq39MAT4tLBAu9FzkXsVc5?=
 =?us-ascii?Q?1g2pTCtxbab/s6X1Yc8up5W3FiZx8ateJ9U/4CyJs0cb/SzsvKuBuumWJzpA?=
 =?us-ascii?Q?rRecqLjamdVkmSWNCIQyywfilr+Tm326I/y+kzSTEU0HVuvSELW2HiqBi88B?=
 =?us-ascii?Q?i4P3SggiOXqcznF3qKpzJ0YJU2kXf6o+kxqEd+MXCLUkk4FR3uguu77H/kX2?=
 =?us-ascii?Q?hEI5htQupO5qyZlyisHcgC4seqzmMFMptRyVdoYL0Gz5Xi6ZgUXjq1cJlMNm?=
 =?us-ascii?Q?6uTGPFPft8d7iUpOgefE+PT1EWWcLyOZl9mOMBYkQF6IBCenq0fLgCivUIQ6?=
 =?us-ascii?Q?KPoj9ygAYixAN5WANFnrOsHdX3EytbAYVLbSNL0AN7RLXaaK/rmnwx7ev6cu?=
 =?us-ascii?Q?U29W45vsE+b4fT04oBQ5nnEHUX6DFTfeOl/NshNQwzls9KxmyBl3p4VefPlj?=
 =?us-ascii?Q?rGZ+g6+aNEiMgc7TsVin4DeSIe5p1m3xHb2B6FBdZ8A5BMTUmy4Brrir4Lbr?=
 =?us-ascii?Q?C33CmDR4hIaOTDr67ssuy9JWxodgk+iCRlfngtp03qcfV+o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e603759-5f02-48cb-a07b-08dbd3f13a10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 17:55:21.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLpUXcln7VIF+XPJeLipquuxpML1cazxBM22Heattut+UBhlxIFz+tPgA3X7hwgWam/OOjSu/lyXkZR86eJz8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=797
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230156
X-Proofpoint-GUID: zKSIpvUA8nUYI2DWjm3Qo4h1qINlPV0q
X-Proofpoint-ORIG-GUID: zKSIpvUA8nUYI2DWjm3Qo4h1qINlPV0q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot <syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com> [231023 13:24]:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e8361b005d7c Add linux-next specific files for 20231023
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1207cb05680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75e8fc3570ec9a74
> dashboard link: https://syzkaller.appspot.com/bug?extid=79fcba037b6df73756d3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107fab89680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e28a7944599e/disk-e8361b00.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7dd355dbe055/vmlinux-e8361b00.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7b2a9050635d/bzImage-e8361b00.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79fcba037b6df73756d3@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> 6.6.0-rc6-next-20231023-syzkaller #0 Not tainted
> -----------------------------
> lib/maple_tree.c:856 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> no locks held by syz-executor.4/5222.
> 
> stack backtrace:
> CPU: 0 PID: 5222 Comm: syz-executor.4 Not tainted 6.6.0-rc6-next-20231023-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  lockdep_rcu_suspicious+0x20b/0x3a0 kernel/locking/lockdep.c:6711
>  mas_root lib/maple_tree.c:856 [inline]
>  mas_root lib/maple_tree.c:854 [inline]
>  mas_start lib/maple_tree.c:1385 [inline]
>  mas_state_walk lib/maple_tree.c:3705 [inline]
>  mas_walk+0x4d1/0x7d0 lib/maple_tree.c:4888
>  mas_find_setup lib/maple_tree.c:5948 [inline]
>  mas_find+0x1e6/0x400 lib/maple_tree.c:5989
>  vma_find include/linux/mm.h:952 [inline]
>  do_mbind+0xc8f/0x1010 mm/mempolicy.c:1328

Hugh,

41de65c4cd27 ("mempolicy: mmap_lock is not needed while migrating
folios") changes the do_mbind() code locking here to drop the mmap write
lock on line 1300 in e8361b005d7c.

This is an issue as it opens the VMA (maple) tree to being updated, but
you then re-walk the tree later.  If this is okay, then you can add an
rcu_read_lock()/rcu_read_unlock() to iterate over the VMAs so it is
safe (around 1327/1332, respectively).

I'm not entirely sure why this is safe to do without the mmap write
lock, but considering the change log it seems you have thought through
it.  I'm just not sure what is going to stop the VMAs from being split
or such by a ref count on the memory policy (or if it matters if they
are)?

Thanks,
Liam
