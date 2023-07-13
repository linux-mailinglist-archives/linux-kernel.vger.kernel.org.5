Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC57527C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjGMPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjGMPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:53:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1401BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:53:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEJ0YW020108;
        Thu, 13 Jul 2023 15:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=IY7wK0fOwXTGiXTGeyg7yTImjRY9bCwBwZ3r6Tq5NEI=;
 b=USWsF4sB90DRn5hI3OToysyVkAlAPzQWKSmUaxqbEoNL78coe6f+nz4pMqzFi8S1DCzh
 9aPLIN/1XQzrMI98foFCNwh+F/BYb1UH/nhd53ypiAj/L36cl9rv7T6l86fS8Ghp4ED6
 oZ07pgSrQuGVplUiiSt5jNnNUMbzSEZQmbd4sQBun8Nv4AocJubv2D1y5Yt3VFbYHdx6
 PczL6uyeAOQl8h0v0m51viUdu5omdh6QPlOXjVMvKetatFSxKTV9d3eaOpje40COyk1F
 hO1gk9EkBiYh/q8zsZ7+t3O4OdyGr1fanNBT+tFvjeLDbLYYVFqSK3tmYRldYno3ruHj vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydu1v0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:52:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DF7OBW033233;
        Thu, 13 Jul 2023 15:52:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8929q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 15:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4wQG5vYmUAGbnNhJ0tLXeKON9rUcV31zYf+kybzJ2Df3v/3BoABaabWPvaK/MxWLgxJhQom7rVm46d0R782jz+yGf4U7xfgZCBcTNKGvvD7IFvTeaL8ja7E0tSW/NEOXAhuUHbrp5nT+izlO1w9hqDvWnp39qCbEMmzbPQ8iG4TQjUWJSzMbwYvPe+wiczM3Yzlg8zpSHdBybNg13NU63ElvyAF7UxKGOSjh1glfvsizJ7yGG278qxppzX5aIIfxql2QqXR11vXD6glaszcvX9P87vfLyD3tLCHArbXJ4AjSp/uTIDfRhbFtAKqIsMRSwgRGFV+KRTZ4np87gA0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY7wK0fOwXTGiXTGeyg7yTImjRY9bCwBwZ3r6Tq5NEI=;
 b=hLE3Ki9V2cN+xTodkG/ZHKgefUN9DUKIzWdjNXDhxumLE8OwBHGaKw4wl8abf2u6ySNjoqbWBSIegIBEOMI1oOXkoR5wdhGWMiVo68+J6l3duaDk1+iUZxx+9lzGjlzsihdEkGEqMmb4fuX05mkIBi4w9f3k+riGltIMSZaJ9eLwI6Az+O9yOs3u9jSvPSvX+USxTYY1on5/IoWMaNMi531go2y9m808Nc5V8ENloVe2xsm24D5iKnBdn5+d1gPc606avmeZf31QFQk74djeqlh5h1d2C0VVI9fJNue4D5BwK3sdsCjf1bYh5azzMhDGb65pCaJAV1DXBNqzfJP4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY7wK0fOwXTGiXTGeyg7yTImjRY9bCwBwZ3r6Tq5NEI=;
 b=R8RJRIeGvKdAW2zMsbIHtdI1+XUQewQ7lZmfzErc0VTIZOyBEXCrOgnbs29cxDckky9YbD8jgBhVDtiXd4RRgmJKN/Iw3hisVCsZLOOgXquYzdz/pdIOMmKtL5UGTJereQjKNaweFhPdQ94+kE/vwzEOy1nYxF+BCc7B5jeSNLQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 15:52:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:52:53 +0000
Date:   Thu, 13 Jul 2023 11:52:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Maple Tree Work
Message-ID: <20230713155251.etx3ypziiufunnmo@revolver>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0152143a-b105-a413-ddf2-47f688633d97@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5fe44c-000b-4151-35e4-08db83b9380e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlCAG1tzwG0JjHoSNKhqvceVqSAq/4qFPAKRNfy+/K1i5gdrkyQBon+rK2VTZaSYyzpBsG0LeYT6e2dGBlQUYZA4aCItJ/2pmp6/i1apzm6qw32qq1WBLBUKQMtiQVEKHXw+SwghBbDnCfPVCaWnypMFP+a/FpgqF1Z20sz3cuAQOc2Ypup4KRr8KbumdR4DzAFkSe1yEvpXXPeVGBtJGTv/lksCN1nI8wIsJm9X3MjuurW72OCtR0NRYjYnUT5lnHjL0NWmN50hi3CRKlzQb5h6jvxH0h3XkQyXt6Rf63TEojuDFAdQ7s77bL+4vn27gNZGEMvTZ1YjFHWqVEGxAyuUBIWm3UDcBa4KQA4GUo0q6w+wUJLiJ3YQFDtcTbgzfc8F6ru/hgoHTkKthQ6vcKWuB9SpndQYfCLXVtFFoDrN2YtPH3GfjBWenITJup6oWCRi9JjYEJ6G4TbUTZmnTQfgZ1qQIYHz5bjyftzLI40warYGJqlJZfv7PPzpQmy1wrf9mxNATymITo30RqDZHr6b9zSqJ43KXPrHIyGH8MsErTSpChsJyeRFoxhhRDqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(6512007)(4326008)(6916009)(66556008)(66946007)(66476007)(38100700002)(86362001)(186003)(26005)(6506007)(1076003)(83380400001)(9686003)(33716001)(478600001)(3480700007)(41300700001)(5660300002)(7116003)(8676002)(8936002)(4744005)(6486002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJXfmLTHbSvG1sM5YY2W+mhkf2+sZ2255wVWGRmJUM2Ycm79fzvgJ8DsPjOF?=
 =?us-ascii?Q?CRGgd+YEcxCGyta+Zv5iPwsokUMP3NyOg73/o6A3m2rUKqLdjXG0SI+idKfH?=
 =?us-ascii?Q?u/lDFBryyaCEK0vTH8R4vvwxeYJVC6Dvd09bbADIQk0uT7AqePUpRsXd+ZR/?=
 =?us-ascii?Q?BRfw0W7plRkujRpPyQEeafTGXOaC6C6ICAj+yj+pptLaZhC8ZpTkA+CZ9W+d?=
 =?us-ascii?Q?21uKHIx3uqmfDjETuKBPoixxT9HD34LyNV6qbcADYzh0TXajemZqRDw9NY+k?=
 =?us-ascii?Q?eNFSJKv082C/fUfc3CXQvbbhP3w6rj1xJPyFxqeslg7swEWb08lg2cDKF4X7?=
 =?us-ascii?Q?azpOfKlLsVDFYnsAaQkXegSo92Bnsud6oFNQivjDX1R+G59BOTZzCiGwA0Lu?=
 =?us-ascii?Q?TiwChD24rIpzAKqlJevEfBvOsR6ZgV5aUa8dyhNJSLrza5PECaRU/tgg3Wxx?=
 =?us-ascii?Q?jfXuvMByNxl0q0MRTDF8luYH3I3NyxHfCzJ261uq+acn74Z3ZLlyP+UoWAin?=
 =?us-ascii?Q?ofNPREy8ObhPVq16v0Ao6huG5Ack9/z8rHADm9CwWTJs+rkLxXONoRdJk+9g?=
 =?us-ascii?Q?9BVFOIQeB95Vswxrn3mCYQUZkUB75jyzFV2jalDCB5w3BE2mL/PchEq+ACn2?=
 =?us-ascii?Q?XgjyB9hAThjTnoBJl+SftSEjPAH8yucRKffPIsvZyoYtUxpVhzwA0UgLijA/?=
 =?us-ascii?Q?vf7QQCw+zw6tgADUGHaQcmQLa0s79nACrkqekL0bu+Oi5gzX64SJN9QhG1KV?=
 =?us-ascii?Q?2dbp9druy1s4qCbE5xBbeSUbDQM1Rwzq4SqEAqiSYvxyJyTzDyL157Yw+jHp?=
 =?us-ascii?Q?aIQBEXftfsPCZ667rM2l4U3NDtn3/er+/7JKc+fINsSinatYIkom6WxGAIZa?=
 =?us-ascii?Q?IkA9cDf7XYpgz7xmugrpLyAs4PqfSB9Wn73x3Pj1/vmAgdWcdRvE/2oL44Gs?=
 =?us-ascii?Q?kDsBla5CR4saNYhhRUTrP5vbs0QZN51TJi/t4mIdualkOtghY5E1YSDHhBA2?=
 =?us-ascii?Q?rodqXyRuSrYQTFoBWbnGypm2B78FStukphbTkltzQDRQI3JBrOk60SIpww6k?=
 =?us-ascii?Q?DVg9E9aQ4bMTwO68YZ8mSDMp3bOSVL6OMBO/aZABG4fpy8ZBBAxh+o3VsIMT?=
 =?us-ascii?Q?CnE8ACYDNoyk2mD2vxPT/OSCXhBx9TnQwtobuw/ea/2i8FMbCiWwgqVIe0ps?=
 =?us-ascii?Q?hDTe3frl5hrTcKS41pM+6FVQNcgTsahOSkyklsnGZVY2SsDyI2btfRJ78DNQ?=
 =?us-ascii?Q?cSCMb5rgd5levMZMNvJqIz/B1GKDR6nwQmht+J6YvWlIHEiDfeqjbVdGis3I?=
 =?us-ascii?Q?EgzKgxk+BpSMDYqqxuMs3apdqv2IK2Hg7BHoCcwCuzlcRvMdZVPKSkvow3zY?=
 =?us-ascii?Q?1VKa2cxQx+iVxb4/ldrG/IfM1eZA17R2XBeaoRQYsNDYa2+uh4Z03NLhmW78?=
 =?us-ascii?Q?LCpIAfkNc+jiku2n4divOsmfdDFcxZB2r7SY+vaRcoacvyToeJjiGxntoHG/?=
 =?us-ascii?Q?G1mXs1TdEN9dfwxWxaLv866ymjI+bLqclbK7oe/1h/7nzcDqn202iyn3ngxW?=
 =?us-ascii?Q?2GnFG2S1+glqf4RENDT2hED2eGa14nsMXWWXgfpwC3/SNKkMhJ/Q1OQ/Ejow?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LvYRlBASVTdEclmlSJXFNNmWAXnjiq3RdYr/x5Kw5+SD8AWXZQVYPJx8mIFmefvPVYuywV0sOx7m9soAFptInUWaC7XBEAxLmq2oAYiuk3LprgSsMV5RCLDjTb7bOARUsc76XMrm0Fdlemd0nldSlttJbqRJicF1X6MNMFxWz+9ibTvl4AFLCSQXDt8b0lcrPusKYr0XS1wid4JS/Fje2MAfJniKocHQO6jI+V93ba9Uxz2X5+hn9Js6L7iojQ/Ok20gN4hFp6jL/f0DguBdJQ8cenzgu9EP5fs6bd3WPViNZ8a54GBwKcbCeocYkC/KFZloI2FC9f7o8TGTXq0rBn7HZu3HsokXZodYQHEN70EXzEl6Rn/XOcCIOV7HSuBEbzQBNGvVdU2tYBQPvFpAwoKmTzp6uYMIOzKTumRWUDfvJ9e1Mez4Pwi5OpRQxMm25ab5wxyKEi65Hl6ykJXPZmuReZ4dY2Juo70ASJDUVlJV5V5gllRkiaBL9/tGHQQ6rG9vfI04+O6wFKrE0o5w+OPNu5l/oijtyZtEqQpym7OhnDSBOYLg04rO6jxmIqBathcnDQ6ysdL3PJ3ej9/ZqwQX5QdeR+5rRuxyKtqxpQI5AGvZhr/PGNlbwJmDc7H+H0b+Gc/SkXBYE0bsk5xFVQquSk2SdDpIJffUPdqj/b6tLOr4610DS8/tagT+as4wnU6IKGcEH7t+EHbsbIPWE/icjwqPVSkp9FxaDbXa27RgbDMibD4HRxEgZwR1JKwnYJo3Mt8rbO1Xa2gWeKu2gJFCvTm7j9knOHSR313o7aopqeZnJSc7VKHjYJVOaeWnWfdWDefk6noHweomoLPbxXQrbPNmI2dMBYcBSFvOjhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5fe44c-000b-4151-35e4-08db83b9380e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 15:52:53.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oafYE+mIrdZhcDJ1D/6r4sz1mkOJV212+bJsv1AFf5FLxSBy+1OOcxd0IIv04gtAxRflV5fMUiPB3T8vaiTFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=521
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130140
X-Proofpoint-GUID: aIyjw1cAfstvYq8n77MmyqLLwu6jjjov
X-Proofpoint-ORIG-GUID: aIyjw1cAfstvYq8n77MmyqLLwu6jjjov
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230713 05:58]:
> I have a question I want to discuss here. I noticed that the interface
> of maple tree has three different prefixes, namely mtree_*, mt_*, mas_*.
> I am curious why the interfaces prefixed with mtree_* and mt_* cannot be
> unified? I think they can be changed to mtree_* to avoid two different
> prefixes.
> 

I am sure there was a reason.. looking at the documentation, it may have
been to indicate rcu/write locking..  But the entire interface doesn't
fit that reasoning.  We can probably align the mt_ and mtree_ all to be
mt_.

If we do, and we probably should, we'll have to change other places in
the kernel and the documentation.

The mas_ is the advanced interface so locking isn't handled, and
internally, the mas_ indicates the first argument is a struct ma_state
pointer.

I can add this to the list as well.

Thanks,
Liam
