Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C377449C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjHHSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHHSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:24:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A85222DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:36:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAZPC006879;
        Tue, 8 Aug 2023 14:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ao80AxN5ZfvAjj++rxpAhh3IX2lTODUNCQqxTzHjl1I=;
 b=oAYCOYKMXAO620hwb9OLvUnmYN8x4J1c1lKT0NYfbWKVjkSHzbyzn9hafIvsE36X8efA
 8yrERnA0+IfpdWQh1coEHO+Rv/6vyuB6XYEcNuvRG1J2si0b9P8JKpJ+zC6fUI9fVAHw
 AmZMM4ks/11XlEdXnnShvA1ZYc+1bt2hqMzVOIPyu+KFBjJRZUb1GtcL9H58r5xRrasp
 snCX7gzyj8+MFTacgcQ2W1IZQMvb0a04Bdb3ip8n5+WhwPYgO6zlHnl+IOHaR4kOoE6h
 vjnwPWuQWQ598Rs1g2wHO0d9LA2t8kG7Tpqe5tNzXaZVzJg/WhgZq9qbVSMIPcnw2LAg Zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u59p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:38:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378E6pm3027678;
        Tue, 8 Aug 2023 14:38:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5vju9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLSVxiaWwW7BvotTV70rQwUNErNPiSWQ+ShtmlUhYWY8zBXi1ATS/e2GO01uOL11VICLN1R1Ad/2kSMFmSLtl3c7hl3D4aSjNhKWutMT9gArf4DiW4d7kC58CTQKIjbIepPXDOTsEjWlcKaUc4eic4opbYFbF6IB4Cn0ieYPd4QVpu01ut4lF6xH2NW9038RmVZoSRhChcp1dSWTu2bTC13m3t9huzIu00/a0cekJMVkJ9dqSEKds3sgekBBUbj3xWPdv6sTDytL4nv0oQoIidqN/qokLQ32yRerXlmig4fpfuQd/Smn8cq2+ZQX2/vGU4G3pTiE/YB0I4+FHoqqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao80AxN5ZfvAjj++rxpAhh3IX2lTODUNCQqxTzHjl1I=;
 b=N7qJLrFAet7ljS7sxOY71sdG2aABlSG12ytRJiH6RUZYJ+uebuCf+Wc8Ro60wZ2qX+mhMYoX8fgWfyDIC4SBVJDMW8WOqXFxzjvP2CspYuwXaXmc238rc4VezNHrEl1fO2jERz9xHOPAt+FMIqKrj1+xtN6rbHt/xx3U7qV9NOuLbqUvr+WYH/zrQIw08o95a2JlXTseFAww/WrepC8y7VS4bW9sLCtt+dUKm8mpxdrHkfVjyEXUMglvC/SsfDHLO4+4skaqber9kp/XYXurlzwwEqN01NHLuWbDenbmT84wlwocrHlQiXktQScvgX0Dcirv0EQNyszWj9yikcsH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao80AxN5ZfvAjj++rxpAhh3IX2lTODUNCQqxTzHjl1I=;
 b=yH3XT8AHQ/FlhdTo8E4L+N9b6VFuEtlhZgSjN/ILT6N+FcQuD+xEtoEVXAOsjYckJ1vyAQYU/U0khCYbyLkI4HY+pHNuUyZ0+5QpUvABRjENkFiolNGbgJHrogOSlacQRgZ+xcZc8DDWLZre63yveB+kwf6C+exul/WHpA02I6o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5760.namprd10.prod.outlook.com (2603:10b6:806:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:37:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:37:51 +0000
Date:   Tue, 8 Aug 2023 10:37:48 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC v1 5/5] maple_tree: replace preallocation with slub percpu
 array prefill
Message-ID: <20230808143748.t5ravl4yaxxktikw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-12-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808095342.12637-12-vbabka@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d5e727-914b-4796-9f82-08db981d0b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIZVX1EkqR259YXcMD4Il0/GEGReiTHTb9qFUo2HEGLeapu1NxjUbvjpU0822G3uhcAbh+vJnFLUck2w3NRDod/5NhtN4mohogE7QzLlDrbSdLwAcJoAHJbq8UtF+DILdqEkwldGPaKvwxLmb66H83T4iljHmuSiISuvPxhI5oACa9an2ZthpVpmLsc1T+eXJfn4tDTi2aFLLHxhes8ZHAwh2HanuR4nwgr8jh+hnE1AV/ZeXTI4DN485iw6rM4/vjvBIog9dONpTCLNw79OuquL42I+nIRdxfBRHKWskrMFg44y9ApDLaatVjw69p04tJBvh+sTBThPyFq/kI8ewGhFe3wY+JCl2KL/Qj8181d3ZnUGqjgwEbvk0baKbVnEIdkHv2PlEvf+d66b8QgGtFZ9aweqj6aCyblQ8zj6lPEJoUsI2i2xPk4N0WP7N190he0e6OoGS6hDqZD+Dp1h0wZDYVpZjMldbUNpDkscAXmI+o3KHTARYbfmHoUZYMq3xbJtFGmJYT999S7Bv7bU3Q8XlI8aSeydF5UrAYm87CESIsq4DtbA2U7wMvqTCudM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186006)(1800799003)(9686003)(86362001)(6486002)(6666004)(478600001)(33716001)(6512007)(26005)(1076003)(6506007)(2906002)(41300700001)(8936002)(7416002)(8676002)(5660300002)(316002)(54906003)(4326008)(6916009)(66556008)(66476007)(66946007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tqPpPk1NVMeQx19AhktMxhqurzKDX+SSY6cTHq9E83UzjUHAZGflAuPLyet?=
 =?us-ascii?Q?kpjtrQ0i30292hXgbWvNw1j5v2x7vtF6YHY1RYX50WQ/PgJvLN6VE2p8Hg5/?=
 =?us-ascii?Q?XRc1H9YRPGkg61an2wJ8gmutkEJZ7HDSiNsYy7YjnitzjDfV6bGFmUdhOzHw?=
 =?us-ascii?Q?aqqNnk6tEL8t7ZcNyO01bVeAgHPDZ3asCGHemjjloQxuUqPrBuLmrXp0Hvkb?=
 =?us-ascii?Q?jgiAxfZVCQbNDR1buA/iv3cWMJmIuo5Uzu5ht77XMwcsigExSsivLa2MQi+Q?=
 =?us-ascii?Q?ykPvl86jw6rmbY7f558cVeVbktZvFwP7DCycwUYSlrhD6E7+AOMv7T1JIsB0?=
 =?us-ascii?Q?zUoSvTnlz3DUYDWhLFmCWZ4Bx1h0xJS/pPqQ6rt6Hamx96h7oBKTKVkgzvZ0?=
 =?us-ascii?Q?+swxP3JwaykLyJmqNOvzl5PDScLrhENmv7iCJKVwPSeJ/so0s+7NYTSJK4BI?=
 =?us-ascii?Q?ox2N05k0NF45ba6kmkqBJT2e/fYNtCjK1GVjG2y5Lj0O5DBBtYYCwyT2uuQZ?=
 =?us-ascii?Q?1vapoN1pD9VQBvNCdyl6AvUBROQG3xcHGeocrIHrXqPX3DcqQTp+ZD46GUhN?=
 =?us-ascii?Q?p6jFXbiYitA+Ucm+J+GZGULjBskHKDM3t9HOs8deExUen+Zvg2mVPO5P3eso?=
 =?us-ascii?Q?c3oyfQVwhdmrKwxGuSPKgppVFQVjXvzsisG9y/2ifuxwvLpk62FneUfDRUwk?=
 =?us-ascii?Q?UCNBMWhsgRmppanLJ4bH7bIgmeWNxeyEnY1hcT0PDG6kqgKAguD5BGnemsN3?=
 =?us-ascii?Q?wwelBPQDgG2kyr18D+IPGF5J0GzKfjLu7AS3cY/sIfMRbEUDGe5dKe2ds2+e?=
 =?us-ascii?Q?H4hAH8WHidHiz8h59NBa80UzJCuxKoogtSOqesDEHYuRHpU5eMn/L/cWPU3N?=
 =?us-ascii?Q?C961UdqrUyrqiJXtCzW4Jdi9DTlBtTcD1p0cH++C4VWlnOEjQHVDz48U1XSs?=
 =?us-ascii?Q?LKOVFg1mYO7Q9ppn3ap9bDmyI9mRMhiB34aJtyYqCVhh02Trpn1/eUYYgorb?=
 =?us-ascii?Q?RoBlYW/RWWTtWDH5YUlvhCYgWynL4w9ayxWbf7lQ1jS3Ndo1/nZeJAjARefx?=
 =?us-ascii?Q?woGAVZT9pnUmMUdrdoLhSFk4189Ov+h+h/xLHzJi6oTaahNJmfQ+pKV8wRc+?=
 =?us-ascii?Q?pqoOYgxssSWYtsXAPy6NYRKG34n2ceJ8B29Q3NaFPqYWefspZLTEGCXd11Br?=
 =?us-ascii?Q?UVuaRZolzlrSdoQGD4NZav9EqSIEPlRByDDFO+wErtmZYZGiwavJj2GXnazP?=
 =?us-ascii?Q?4KOm10jeZOAAs8HUxeiCUBzI85/Up++gKgVvYHdj8AJGye5mEYZhzQKN0DX7?=
 =?us-ascii?Q?W3TQo2PhiBY16IcI61xWrI/Sz82Z0Xs3cQ8v3afZGopDZVG8Qzl9RIaXDtcG?=
 =?us-ascii?Q?JTLM13Xl8PF2dZs2sOB/JVa42H1ESC4mUJzhK9CeVaxXv81/ATF6aUcNgZBR?=
 =?us-ascii?Q?xMirIRKJvHys9TcRiyZZdl8ImHrXONryJUBGU7Hr+XDMM13X7Qy7kFf4TgOr?=
 =?us-ascii?Q?e+qsgs9UnsqJDm9B17asRS6p63HvMs1wemnCTaw8amnXyjqLPVzBmtO2D2pI?=
 =?us-ascii?Q?KSuMt4lLX7YIQLnkMWLwaLoAarZ8aAit3WlvNH9F9awKFXBEUXIsWYyazYFO?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eqN581B1KCkwSa+EmY50aM23t7b1aVrsiRcjdbuG3FABTpTw++QXLHCEVb3x?=
 =?us-ascii?Q?PqD3CrZdQnp1vo+VSbXP+/3ZXA2lLvHTGXR5xq7SKicjvVUgbCKmFD/F6EBx?=
 =?us-ascii?Q?rPyBWRr2FhMpldotmcpSswirKHKHmBnOku3TSSe+DRzCQMGia+srNcy2mBqN?=
 =?us-ascii?Q?8w6yI1PtC6VJHJ1G2xjiVWsYzC+XUt7jcLZCpYZLES06DZu5iwcaSBO1UJo1?=
 =?us-ascii?Q?9ufBaeZ7bZiVScL/6CEZ+lkiBZKDSNJAOuwaWOzV4kNKPKlPjx+urgNdVp42?=
 =?us-ascii?Q?HhwLFH9KVQyJepWpuyJ0kaEz5Ts1kux66A2wi9nKQqsTHZmGdPLorZATAEA8?=
 =?us-ascii?Q?MrWLnwyPuysTARdN/ytYAFPPsQqWzoI9j+739Vmk9XE9qPra81u0DTHjXK5/?=
 =?us-ascii?Q?T57BdhAMOVWYSbBwaUHd8a2lQozxbbKs8J4cxOmv7O/LArdLYettspFg7KJh?=
 =?us-ascii?Q?q9Ge10YQi9p+tU2hmoTkIIj+PtfI3EV419ZrdnRJ1SaenyHIjdwC39vWHVNe?=
 =?us-ascii?Q?jFQCxbs1nZVLwfS1QMlqgLhcBFU2yXNYUgNSC7c32smHrClFTqc1uJ8gx06H?=
 =?us-ascii?Q?esuo/63tDWaAuMocj1VtGCBvhcMCdBuk7aLw0LR6OEM7H9GjFpLknc9pXVV3?=
 =?us-ascii?Q?7C6fiqKQljCpAjBGjC11XgCl57XauFmOlOpzUrRYHug8NeuW9LOJzo67Tn9R?=
 =?us-ascii?Q?1MJ8KKt+EB1/8Nw4OmBB1uLK4XtPCpMJU/Xs+6E93AadeIte71L5jCHs113q?=
 =?us-ascii?Q?yG2OVndjWy33emrlB9zoZPt8w2n8HFUyld1I3xTnZQ8C8ZwwxE1Q2K5K9Jmg?=
 =?us-ascii?Q?qNauqAMe8k+rIOtVk+UKTFfcpGHuLdBz6xY+ARrmLlh32BMa6ywFlWNsPnz2?=
 =?us-ascii?Q?GKciWRIIJDnC8R3uxvUTkV5y/vbVaW96gS8VuSchXl1mVRIRpURnLVY0FYYt?=
 =?us-ascii?Q?LgVIBOo4VM+xqdHMOx2P1jd5d3NZBKYYqFR8m4zg1/jw1rduoyL6SG19IMm/?=
 =?us-ascii?Q?U7yn27pBxzBpZ3osS7f+F9FOwRwJdJrxSLy5dNVeCHOS+DY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d5e727-914b-4796-9f82-08db981d0b05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:37:51.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV8QTiw8fT61NZ3gdxgYHf82b/36EsvsXhLy15C3vgqD7a9JLfSGzMLCBQsHiX3IQD9UMWaSjUTXLboo0E7lgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_12,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080131
X-Proofpoint-GUID: ccw7EP_w3cn4AyLfQsHFNmhNJ2tJvRAy
X-Proofpoint-ORIG-GUID: ccw7EP_w3cn4AyLfQsHFNmhNJ2tJvRAy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230808 05:53]:
> With the percpu array we can try not doing the preallocations in maple
> tree, and instead make sure the percpu array is prefilled, and using
> GFP_ATOMIC in places that relied on the preallocation (in case we miss
> or fail trylock on the array), i.e. mas_store_prealloc(). For now simply
> add __GFP_NOFAIL there as well.
> 
> First I tried to change mas_node_count_gfp() to not preallocate anything
> anywhere, but that lead to warns and panics, even though the other
> caller mas_node_count() uses GFP_NOWAIT | __GFP_NOWARN so it has no
> guarantees... So I changed just mas_preallocate(). I let it still to
> truly preallocate a single node, but maybe it's not necessary?

Ah, yes.  I added a check to make sure we didn't allocate more nodes
when using preallocations.  This check is what you are hitting when you
don't allocate anything.  This is tracked in mas_flags by
setting/clearing MA_STATE_PREALLOC.  Good news, that check works!

> ---
>  lib/maple_tree.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7a8e7c467d7c..5a209d88c318 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5534,7 +5534,12 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>  
>  	mas_wr_store_setup(&wr_mas);
>  	trace_ma_write(__func__, mas, 0, entry);
> +
> +retry:
>  	mas_wr_store_entry(&wr_mas);
> +	if (unlikely(mas_nomem(mas, GFP_ATOMIC | __GFP_NOFAIL)))
> +		goto retry;
> +
>  	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>  	mas_destroy(mas);
>  }
> @@ -5550,9 +5555,10 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  int mas_preallocate(struct ma_state *mas, gfp_t gfp)
>  {
>  	int ret;
> +	int count = 1 + mas_mt_height(mas) * 3;
>  
> -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> -	mas->mas_flags |= MA_STATE_PREALLOC;
> +	mas_node_count_gfp(mas, 1, gfp);
> +	kmem_cache_prefill_percpu_array(maple_node_cache, count, gfp);
>  	if (likely(!mas_is_err(mas)))
>  		return 0;
>  
> -- 
> 2.41.0
> 
