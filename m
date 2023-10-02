Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839CB7B5878
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjJBQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjJBQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:43:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AE0A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:43:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392GDxKe017462;
        Mon, 2 Oct 2023 16:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=u+5DXP3mdurF9dxGYP8pOyZRtkgZPdLZBjzSkaT8kcE=;
 b=M0bGQcZqcNv3RqGEQZRUZs5stEaabD7sXHOjCT0Mm//7Fd97xNqCOnUDNGa1PCFTj9Pn
 QHM5nyVb3NMSpXTbSzsYkbEkXuOMRtyWdOGIN+pV5eLp4V7Wl2g1/HnouOE6dJX4c69h
 ojdu6b9H9w8OnOPLjbWPUNnp+PaXXuJVO3TqCM5vbSxPKhHbjNIgV/r3LoBrQgSkTVzC
 C/oypbp2fO0EZiQGU2tG7ft9gVjOVbJdMK28p7EGclwMXrg2aWTs1Lutf1BMBbu6MZFP
 nLz1bLsTm3pS/VmnfOTGsK2XeMgFM3SWs07cOw6d8RiM/MY/o8HRr3jxM/o+x0ghA+9O 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf42xnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 16:43:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392GVH2D008788;
        Mon, 2 Oct 2023 16:43:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45b6x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 16:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho2qCJRr5f2TeKOz/JfJCB2OirrUu+0g7Fh8zY485A/xzmHMw4f+cwgGLOOs6VvKTsgR39Ag77ocVuN0riEmGzluCRFK/LgPoqsMjv2vEzAziUKYIcwRV9zhI5BcwHhGGWcF8qfvU98Hv8XmmlQtgqEblGfEkcjNUo6TdihNzjgaTXOYSW7z3AHMT/Pltt/Tly6DQuOTHl6Q93DK1c6QdJdsecVCztEx9K6CleNr0rS97KahJQSVG4AHq9IYDcnJjb08WMXXiAw4r0jzNvNXmImv8G1JX/fB1OvxIvdx9erL+XBLTl+epnxs9YZ/KeBl5LoJuElo+8XTobV69H3EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+5DXP3mdurF9dxGYP8pOyZRtkgZPdLZBjzSkaT8kcE=;
 b=X5a3SD8uaDD0yroAxMjK7cp1D9tRmZ2Jw3mNtdzNc8Xrd/ExXJ10WtSqbqc9OCRiVodClax1v9Ym16H0q6DwkKk/2j8Npqsn2j2WmQdbu4WzoZPqdjapEnLf4JaDzImQjM+NRH2xIscUZmvXv1o0hC3fHHLRRP1PcHB2NH3EaSAx6er3jPhscKrCYLkCd8Lko6kpmLTa0WVTTSTD4gEm1W/4+8Ogw9QExtBcYkboF2uVAxq5Q0bJoA9ex6FkRhC5gCZKpjTf4eOei8hL916QLz1wzr4+aPDmZKzNAme413X2S4uifKRFS26bX8Y/QZ+IjBWhNO1ZVMixHlMdMnlyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+5DXP3mdurF9dxGYP8pOyZRtkgZPdLZBjzSkaT8kcE=;
 b=gHO7UDWZ6LR1oBk4CxRhA0CHclXZdCd42iI9D79dDSOChV/AV0RGMwvNPEYced4Z+rTvHfHnK1mHFjmvw1ung0169iUY1j3pMJZmMzUpA2WNQLSFLjDyc6nsAdJ5jzGwCMUP2cJlVK+PkN+6rP2rQXSPGb8VDqlvyxNzhN2CIbc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 16:43:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:43:12 +0000
Date:   Mon, 2 Oct 2023 12:43:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk [EXPERIMENTAL PATCH]
Message-ID: <20231002164310.bi62wfekacfxb3ve@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
 <20230922135155.tqrelea66hcj5cog@revolver>
 <5d908c60-88fb-49c0-a150-bfb468eaa513@alu.unizg.hr>
 <20230928195926.ucp7it3c3c75erzk@revolver>
 <5a30110b-2457-4638-8779-baa33326f6a6@alu.unizg.hr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a30110b-2457-4638-8779-baa33326f6a6@alu.unizg.hr>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a96d82-775b-4327-c36a-08dbc366aaf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI8A2ylmDLTjtCxrynElFE1w1WG9RoSgbAws4CnaibZUlf9S1YcxT1FmH+NlfaFiolvKJafYotxBM4t/4LHTDeayWmg/bavvJCh4K3U+O/xQBbCT4+zUfzS+SxS5DiBKA4nhyOKI72c59AUX5cSYbZ8ocVb3IkJIVy/7ijiK4cGhuw8Sgj8p+jz0PjLlubxpJmtFM77L6gGyVt+CNiWnXtZNdL0YJXAdm+w+plw/eZNj4qrjB/pC+wsXhrSKZI3rqqMSROUrqOxxsp5zR2+ALLwD00I9G1demPgY9A2/rtB5vTAkk3FxjxHToGWMgFXxsmM48h6G4dFocXBaLy5b7salgXHpvV6QJgHeWF55HfKtAztNro15RgKtMWpqELR52CVwPxm8hDjhidLO3wcX4yfKDtknDEiR0l5vYSkxnPfu4LM5U5cb6UONs192X4YENnHAyydxbCAtyFoG0YFZ+RdlVuaRgqJDhCJOtvu+bcmhb075RB7lf37wy1wft9mqGj+dkAaKJGsJZ/M6IEXklQ/pfvU24QrmtSCMC0qpgtt9eiq6NxAuT8dly/QQYZdz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66946007)(83380400001)(26005)(6512007)(9686003)(478600001)(86362001)(8936002)(1076003)(6486002)(66476007)(2906002)(66556008)(5660300002)(41300700001)(6506007)(33716001)(6916009)(8676002)(316002)(38100700002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P2f4V0fjJ2hD+w2dCGHjWgpwdQ5f+yQZp/oUImboBt8ih9hNsYHre9AhtD1c?=
 =?us-ascii?Q?hOaMMC2v7lrjW+ALEjj+RWra++01PZ0ABZE1+xeX54DsW5tXgJZ8o3qJ0u3Z?=
 =?us-ascii?Q?Wzi6K/eUmV4clpyBwPxsK+uB2TwSryb84isr15fzoucVv8b2ef3g4/ayEymW?=
 =?us-ascii?Q?2V5Z6z3andjyNcNoulAuOP3C5WQ7U0QGibiEDGlxI88i72WZtuJS0V6OZLZc?=
 =?us-ascii?Q?hT+uhNLMUvB7UIqI+DbmziYsOAzRqp9m4lwK0rTAWUFdc+mi3YO1sVVzUX8A?=
 =?us-ascii?Q?dM7xiAqOBHGTvTGChOHGiQVT4jxbbMExr8JKWcVl/Q/pgaWFvzC3kUPIecrO?=
 =?us-ascii?Q?8nYzZk3mMTWwIqT7Crowfc6B1s8+YDsIUiqCUHkzUw4VL0p1qebKsQcnaaSp?=
 =?us-ascii?Q?xorX547slIWRjevnFsWV6QsjtdkW3SVf0R4Bd9gnaPJ8Pi2BT+0gBqzBLDr/?=
 =?us-ascii?Q?Ulzoh5nDowWmNIIjmHVRvhjDZRfXct8tc9VSP9e/K7BAFf+yF/djCLLHmhTn?=
 =?us-ascii?Q?dMhgpaJhOv9Xu1+q1oV+9i4c0MvC3UmmBMaCNZAiFZZNIdvecFR246cp+l8x?=
 =?us-ascii?Q?wNBJv9jE4FVy+e9y97Rj6Zup466zw/bib+ohFD/XV5iFv8SFKrNBxG4y/LpC?=
 =?us-ascii?Q?sPXJ5hJtLmBKzYDxguE8BIHceV8DQiOm/YRjodZQBTxt1M2zYm2JMZjKHHUq?=
 =?us-ascii?Q?ersVVVyCc2gjMphpBt2gRE7/raSZ3hjqF1xBCmC1kJdJ8kZKE8WUbHeBSxtp?=
 =?us-ascii?Q?76EQt+VposIZqVIUBoI25nXAveEeC+b8Z2usTvOF+O0DFpIWWifL5pY+YAIq?=
 =?us-ascii?Q?mnGyfWHzQsdkQ9GZp0GvKr4q6gWIt5ggIS7MNVljTkw3HTSF5sbTQALebaUB?=
 =?us-ascii?Q?CymtxXqouvmC5Po1dp5x5kFqjJsAB/6P7zE8NjqVPVYYkF4EGQSdMcVrQQuP?=
 =?us-ascii?Q?/GoI7l+31FF+HsnCaibfb27wG4Z6KVmRYtzX36R5mSSqcXAZbxmWysLvrzzY?=
 =?us-ascii?Q?dltWiguNemcqoeR5Bti7cKOkKtw2//lIQEE812Cv6FmbEKBPsfkLUxxsxFr9?=
 =?us-ascii?Q?+n3y9bZlbd2bDgIPGInF3bhB/Z/CoPisQ/nLhyx6TN7XxfByjBdaRiTV9cAi?=
 =?us-ascii?Q?MfR5nbnluvT8jGmSJ2SBXFl/roT+L2CzqU14zpFO5B20DBBuLTIPiNFqsu3O?=
 =?us-ascii?Q?3snU5tMGu6/xf+pKhJGIlShXRXIuhKVAyamnrInAT3k0RIebGCUmY5UohcDF?=
 =?us-ascii?Q?Sd3EYRpznocm4CHw6netzpvDMDhgNN7yRA4I3IfQ7eC2QEC8ZKLhSka/i1ZD?=
 =?us-ascii?Q?KNzhvt2Fi6uzFRD6N3QVTFWlgJRUGKS2Tdef+rcdBhRnZJWoFVzwR+W9+zzD?=
 =?us-ascii?Q?xlQXBt2Y8cmdpIHiBSUZ8FlZf/LLeb0bz4RjdEEkDrL7xvdZ7CBl19GjjxjK?=
 =?us-ascii?Q?FBPxsszt9YlIgJ/MuEDtAxaWdmSaMUmPuZH7WiXMBXhza+wkJTAKFx0A34vh?=
 =?us-ascii?Q?w6HvlxHeItvMRACs3EKM9sd1mxxZIlOeubKU4hpWzC6sCsGN95hW5UakE6PN?=
 =?us-ascii?Q?q/DjpDh2/jBSbzMYJ8ecBT8dlmSoXDdx8z3ZV8oN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p/A7pmaWYAYZ0KxHa9RnS+5p+bkhjiJ6igp4VVjy4xP2e5W2faod20HUlhw1FEPUYU0cFZ7U516Gp0AuTLiFS/AE2HUCLCXg5I2H7qU8Vkpoi5+px9+AakPcXonscPUbgQqQ7Vtmtm3lNBImOzICyoSIhF8r3hGflZkHWuJYUjKms7jGM8LQ83vBt3Raakz5dx0HrEiSgptWaqsf62QRm8NCWrdfmyF3ylLssH6gWPH6aE0GRKQh9ur6V0yVX9AuQDMmqp/OJ2sE1wj6ub4ldAeWA6CtktX+CgqxPoKSJiReqkqYMQALFZPP475D/dsUDbBdjbAvWJ1OAfvijg/2J7WTZ2d8rGaHiFsFy2yqY4iPdMipXvgjqvWgrrOk5KAoYE7xSR+AFOmwmkb8UAJu4rq1uEP22hJBWCVPsUY2OffGelWnGPU1Fa4Xn6rd2yvHceqsmJfqQb55EK8ux82jhkU28OeMNknUYIeStfC6vR9UPV/DJP6Jf4zBsehZmvJo5R8z8HYlKPuYywbuU+xjgBEZjYM/BAnsd0nGv+IJjrEoOqXI5YnNUyLeA2xxlg9EV0y9yBBtLXgh02tk5oZIAFidteJD1o6XjSi/5okGEkm5W0VywsTdMVw2IuNYV0ZNmeq4aa6fu4IQupEgGwY1JhLu8ldy8ZaTvam7/SjUoI9wh9+VBNFlrqkrUYAMqo7Xkne/OyOws3vFIDB98exOJkQvplFuCSUd3fIW1HGhpIzBPvipaMHr63hNiuN10AVS5AV8mW1inD6kzS2G0EgR4e6pmCXxMsPqMMw6rEoG64wr5Tq5++CosOqAPkYZKFfq+8j4dpEdtBiL8vb/9SjaEjHSZJD8ZSsHuX3qvOmyXkcMVIM90GLfXVhYUfXDef+c
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a96d82-775b-4327-c36a-08dbc366aaf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:43:12.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ockw3UvBZFv08yLqJWAWB/m/g7sIgAr3AX+kQvx3fmBZEa/yQUGer/MB4ukDCZTKxs93odYwR64srdEhwZohCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020128
X-Proofpoint-GUID: _HsWoX3qYTaeZrqAdou0C405Pnxh64j_
X-Proofpoint-ORIG-GUID: _HsWoX3qYTaeZrqAdou0C405Pnxh64j_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> [231001 17:09]:

...

> 
> They say that one patch speaks more than a thousand words.
> 
> I am just running this little patch that actually silences all of the KCSAN warnings.
> 
> I cannot tell if these reported data races are the actual bugs, but it is possible that
> the Ubuntu 22.04 gcc is doing some funny stuff when optimising. In Prof. McKenney's
> book I've read about the load-tearing and store-tearing. AFAICS, memory barriers should
> prevent load/store reordering, but not the compiler optimisations.
> 
> Please find two versions of the patch attached.
> 
> While mas->index and pivots[offset] in maple_range_walk can change concurrently,
> I am not smart enough to see whether you expect that in your algorithm or is it a potential
> bug triggered by GCC optimisations and aggressive Ryzen 9 7950X parallelism.

None of this is necessary, for sure.

I will have to look at this when I have more time to investigate.  This
will likely not be soon, however.

Thanks,
Liam
