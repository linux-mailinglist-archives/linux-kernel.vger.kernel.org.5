Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236787BB06F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjJFDNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:13:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517CDE;
        Thu,  5 Oct 2023 20:13:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962PL7t022370;
        Fri, 6 Oct 2023 03:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0jeXdRCSYP627MchBc/W8vBgxt5K+A8Sz4Wd3FDNOM4=;
 b=kO3cPo9LVrwyAcPYG8U4ZPrBwK1k+0bKGXT5G7HvJd/K9a3Ab8d4iMIb6t+lAEkcAFYb
 MLFQGq0iHujOB5aoEQsvl6Isp0563REsr6DaQfCgIrhaskfVnv+qg9z97NWEMyy39FMP
 3ElGoF6x95CRp9tX4QoCU9GkAvb52GnEVndVNzE6gowGoDyL08FUcWshXkWZUoeAIgyN
 vjEUMPbLhD7zyvUAcKMGB06oFLajyY9IyF8eo+CldGQs71HIr9Hh30zUzi+4X9l3gwd1
 Uz5vfSlMtIBWd8kF5t8Cssxi9FY/XJGt95YnLdHDslwkvjWaxDOpy63OUYin+UdKoZ4W wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vjwhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:12:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960u78Q008754;
        Fri, 6 Oct 2023 03:12:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4ah5b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPo9uw8fSCqlIvdXzSFXUwjoTkySgs58VAGtT87FyNU080f3S/5OpiuyGTPR/n4pF5F6VJdx+3xvufnNoRUcY2sCINPWaceJnpzpMMtWLh+nzSL237oDO4G0elC83xvbBNu5CbQ2kwaCEz9sOx/sAaR4cxATEC7EyaE9fgdys72kpo/25hJj5MZiOlurzChDFu91rBJPJ1cIHfULxjCUhcmcqdwZiJbYVnjjSmuZ+iSGnA0nu0Mv+IUp5xxttpkvfg+VzqGnS63adXw9ij1T3vhYbZiyP2Wj74qJhyZ8TteoYz7+cblf0B2vYj5E7R/5f0kXQsJSURSsjkYjBwQZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jeXdRCSYP627MchBc/W8vBgxt5K+A8Sz4Wd3FDNOM4=;
 b=lEYCOJBhdv5UdJ8aEiOfAw6uOjgGL7bsaySAlzEmH+o2YYzuAV3DADhR2vt9e2dh0HIIYwsoOeyvMmOrvUzPlvxx+DKWhrkxaLjv+lbJhYob1ehUtT0nmWtB+KcWN3dSSp8Lz11DbnY50IEI9e0WXJlR2hiQRbdTGRr6AJrvKTBBxWS653lDHyFmjuuhKTK9qAUPavdFV1zBK2/UK6VXtziBb8gbcn5cvsT2eeomEjcds36o3vb/e4lNlcUGZVS3oN/u78qwNESACARwY+9xbpMuE51PlETttxRL9Nc2LWeNEFtUkyBHO0DBq2DEVPml5ZFVH8j55uPLawDX9FQLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jeXdRCSYP627MchBc/W8vBgxt5K+A8Sz4Wd3FDNOM4=;
 b=kC+vJotFV+zwF+FjY6PAScZIuXAia/7Cv/pd/cOktNEmQkt332Wv5bZTPQ7aZpBlb/rrZ5WVUsy4sqrere2pWGJ1ReGLr/JxS7Ug5e3jtvgrMYIF+66nqXQk5Qdthsc2Y2/EsqWR/VJHhV3EjwEYGUfQAIWYdeQ2IAguzcYIb50=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BN0PR10MB5272.namprd10.prod.outlook.com (2603:10b6:408:124::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 03:12:25 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::983a:62f5:8590:73ce]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::983a:62f5:8590:73ce%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:12:24 +0000
Date:   Thu, 5 Oct 2023 23:11:30 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
Message-ID: <ZR964hc5+PGku4a/@oracle.com>
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
 <ZR7jIxh/VNT6tMVr@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR7jIxh/VNT6tMVr@oracle.com>
X-ClientProxiedBy: BYAPR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::49) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|BN0PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 460fc842-c994-4b33-364f-08dbc61a1007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80EcHXGYU+CHz8IUm7DZeoKCR1HJow4dfbnIXsWigB+tFL2+Jx32Ojz+404YRIcih9qc4V3b7heLe9iyN+uRaQ9EyyoQBduVvm2zkxtB2pjg2UcE0JdYFaS4z0WFrnzOGAQSVfDlHH6wwV8BG9BcW3QHic+2eK4p7TJWr9lIQTtv644M+EAmljkKzWfGTdwPCvQ885jQsWWZmw7PFzBdBHXITDt8TDvd4/gr6Neb5xWU7KxufAduRcLedGKB+uqDli8D/ZrcUnVS9GC5DKmXcQD+EjiEWCb11m3vuPNdixkyUoeGYtgaTGkCHRS0FMqZYQnasg2iKEx+5ykvH37OM3CbTKt8V5yp9YmD/WewHtnAOk14Qx6JacGJbz7DGWN5272SUO6fe0GnX8UPy0dFq1KcU5SHbIzREcY5v+O5fjU2dPe2HStu49a5RvwRSNrbgn/TxmqDK1PospVaJEQ8JDfGkfnvp/FYd/ZzBdi6Rj6SqK8XKwimFeKnLrYMMdYmnhBWQ7FoT20pWwThvgF0OM18A47ZUEJCNzIN0s7vPxmCX1y/Qvyi+u2xer8zCzwpaOidAxNZ5vH9AS7ptYVfPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(6512007)(2616005)(66899024)(2906002)(30864003)(36756003)(86362001)(6200100001)(38100700002)(83380400001)(54906003)(66476007)(5660300002)(66946007)(478600001)(37006003)(66556008)(41300700001)(316002)(6486002)(966005)(6862004)(4326008)(8676002)(6506007)(8936002)(7416002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ufWruVEGNBfsh0xV0vEiiJtcHIKwnVtVi62KWjFW+AAFitSV+jpuMUEm3N3J?=
 =?us-ascii?Q?yIgG4mDXAugT0Fz7nnlzZabTTS+94TVbNxgowq4guFotuI5BHEbdPzEqAKbf?=
 =?us-ascii?Q?WjzoKXW623LcOqYOyzy4Eku1mhwrCJR3K+fzcoLKM066IjW9UrVXDcoBeshG?=
 =?us-ascii?Q?3AEA0Q/w0wqOXNV/kwxXzI6108pJjzra4pGTAC/nZafK37PdsryDrttm98ND?=
 =?us-ascii?Q?aeP+NxdfdJkD7yO3QXtAzz2SM5OoGNQC9/fW3qtQSHc1L5/g8HUBkS344tma?=
 =?us-ascii?Q?A7d3hDzJPghojoKqaP8WML6UfXhMVM1fikLMHezmUCXs6k569paBrpXU5m0W?=
 =?us-ascii?Q?Rxbh+TfD1+S9aWpxe2kt/cPmKntTtR4rBdqLSPYD0+SKL3VsaUmQ5T0Ctaqh?=
 =?us-ascii?Q?zw276UHlMF550lW6NEmJBeLSHx71SyPNLl7zp3JzovCEFGmqc1+2w/EBkNpL?=
 =?us-ascii?Q?Is+AODk+/y94dTOWuanzYBkRpykL23Hpj8VwDlR+qHatVZeFjN2e8zBoWBAg?=
 =?us-ascii?Q?hMWyG3GlcOcyCNeQkSFDbvLTZ9RwOqfIkmUwt0nhDrEPPUN7l5ElHQOu5W3k?=
 =?us-ascii?Q?VTP95PS5M9PLd2gVkqsQtAkH4Van3rDeSs0s1BTWu5CX4EuA5+dOKlbl2AY/?=
 =?us-ascii?Q?FNZCNpbFpUtV5s4OQABlVijGLtB9mFHgIn8PxsYshXE2br9IXr1q9YSwo7xN?=
 =?us-ascii?Q?Vd17CjhJDp096Vn+Y6SUwN33gTu3scCww7wcDklRlgfRRBerQ1c0kSolCTj5?=
 =?us-ascii?Q?v594Zk/50P+mXtFsrlbngjDVzYRsoyoeX8KdHrTKIFUJFspDBmxJ3v40TV7D?=
 =?us-ascii?Q?FZRFc59oDKT1VtUYqPgBGjSZs34lWwhXD9FEV8SdL/86uahazpWa7mBOa1HL?=
 =?us-ascii?Q?27fquBGq0kvzV8sD4bwkWQV+4mLZMr7yknkwohnlbE1Q/5ozlnYpc69J6vhm?=
 =?us-ascii?Q?YJcfqTlVehkZWJLzcACQ0NJzushrhx7Dov1n7EMv+u2M/b5KLLpv6BpeXxkB?=
 =?us-ascii?Q?cI4lA/Yy7yIAd76j/itBiaDTovzFX/oH7v0AZ/iLMyNNJpdFJBT/u9BCztFG?=
 =?us-ascii?Q?NTXmuRfxH4apaIA5EMH3agdVjOBmx0S+Zu/CIbErd6LJgABwCT3a47nUXcQL?=
 =?us-ascii?Q?8sBqbjWBhLIag3WRkzYfqmf1RZqDzZkxp+RbYs+35F3FgeS9i0aVIXp9vdU9?=
 =?us-ascii?Q?1Yt1rI5Xhl+Ue/vGhF7niLr9wo6KHLW3Is7u7FtOCw9U7MYa/EPgMb9N71lc?=
 =?us-ascii?Q?rRnqxwx7i2QP1fCDaW5tGa37jGIkY75+lDHwM5gzSmbjzTiYExRZDgmyvZ0P?=
 =?us-ascii?Q?MRGJgpLYYi5odkLG881SzB3xsfSt0y57O75aqcLDJe52jc2dFbnnhNXDfA4s?=
 =?us-ascii?Q?CGtNIDOlOxywzcjT5FHsVWgoJXKZbkO7xF/74DFHnlvakBrX5tQjESIjd0o6?=
 =?us-ascii?Q?MXLphSxPnSu92J2EiKER7tvsm6Dew82FYHN5pA02bKoP2osICJBr5UpL0xVs?=
 =?us-ascii?Q?0Kf29t/1JVGTBB+OPLw4EGJanBLShhMJsDsjqW9aVBlCjD/FSjvAJ4Vi7V9m?=
 =?us-ascii?Q?tsf5QqhcKC/nqd1i1/vX0aPXnTaeBcScii/wWe2T/HHzEhbpv1ak3o8tfBHw?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?X37C4zq3xOqswaDxDHIjklwWNGJJeic+oPnHqDS0theKA5v4WlL7FoZUQGhK?=
 =?us-ascii?Q?9LOMHKCsOgmyNDhDXTSLHOsfFoDaXlSOl16poHKDfgWSvcmdhLfl5qTSXWoM?=
 =?us-ascii?Q?/EprkBC+dIUGG9/I0zpvs0GO/cez2tKnDRE7nbzGB2nElxPbcShnsN5Cvs6N?=
 =?us-ascii?Q?AmiIa7l5gHgfay4E+Uk8bJh33AOCowDjkrhdjPVRFAprRcd8Tx4VMx7rhuVB?=
 =?us-ascii?Q?GggzFrgmHu7xtVYjS9SRKEVapiGpf54uuEne13TiM/sZYme7yq9y1kYtDAWZ?=
 =?us-ascii?Q?NoN27wVyKmtAYL7DW9CG9/9bYCg6TcLDU6Ngv7bdy/Kw6GAep7KDalv5M2Js?=
 =?us-ascii?Q?6Znt2WowDsg5G+3hkWzp5PDRZOicTqVnYCSerqoaGBppWGXf8md+SIsoudFK?=
 =?us-ascii?Q?oa+zRQ9Vi8Rub3EOZb1zkt5I1vEFiIsOWPFDdOuuIrK2KbdA56befl7lwwxZ?=
 =?us-ascii?Q?DlvSDxpbpGcki3j/NJpwJB8C7LaKBhUXR6L2t/oxR7mUNBON/Q89MiDkpnRh?=
 =?us-ascii?Q?Oz5wsgIy+yKGiDJTVkSeq0Fn7nus4gO9uQIcBXNm2csqcDDQMiRYukQOdQH1?=
 =?us-ascii?Q?h7Oks8/ad5tDxaI73AHuXh72cxF4+oPBhr7DLTnToq9TIv6Wdt0DIj5UZuZ6?=
 =?us-ascii?Q?JkTgQi+d9Xw/Wg2Vl+NsjYaqNYlUrfgAZ2YqBqgCS7y4X5TKz4z0q0gdLczI?=
 =?us-ascii?Q?IJzgIuspCNFK0l5//dsObXAxRK60MXBaz1uQ0e7TRlwoAhBXG1ITj7V9X3T2?=
 =?us-ascii?Q?TMBCIKl/jMnraPCwskxoaG8B9lN2mhWjn14Y1TMFt1uojw11yDne43WAsO0T?=
 =?us-ascii?Q?AeEUHgBbjTv5IBRwGZ6fd/fUMRJebGxHnYm9F5FzKjc2bM7eaiTbHtzrLMxe?=
 =?us-ascii?Q?Y+8XKs43O5fnrA4UR3AOYcbh5H3DhLHRniFXroSdP/N9roBAsN5qChvIPj0j?=
 =?us-ascii?Q?3iB2IExc1wMicneCUyni9xn2rleT22hi/LVxbaMPfCN5TnVkZCmWFileKKyn?=
 =?us-ascii?Q?apNIOAhAiWNPrB+NSHiliugVlxkVURC88WkavHilrvQOIfU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460fc842-c994-4b33-364f-08dbc61a1007
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:12:24.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69zkBn/41dtyck+nF1QVwmJEh/Tun71nLqsEpIE/QzePAv1kKKh3lXXpQSaDDkdluVDwcR/QpAQ3r74he6nn4CfHkfO4meWBlZKEokGRHK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060023
X-Proofpoint-ORIG-GUID: y7Ydn-V-tWu2dy6KIA4IU_ca9g8QWyAW
X-Proofpoint-GUID: y7Ydn-V-tWu2dy6KIA4IU_ca9g8QWyAW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:24:03PM -0400, Kris Van Hees wrote:
> On Wed, Sep 27, 2023 at 05:35:16PM +0000, Alessandro Carminati (Red Hat) wrote:
> > It is not uncommon for drivers or modules related to similar peripherals
> > to have symbols with the exact same name.
> > While this is not a problem for the kernel's binary itself, it becomes an
> > issue when attempting to trace or probe specific functions using
> > infrastructure like ftrace or kprobe.
> > 
> > The tracing subsystem relies on the `nm -n vmlinux` output, which provides
> > symbol information from the kernel's ELF binary. However, when multiple
> > symbols share the same name, the standard nm output does not differentiate
> > between them. This can lead to confusion and difficulty when trying to
> > probe the intended symbol.
> > 
> >  ~ # cat /proc/kallsyms | grep " name_show"
> >  ffffffff8c4f76d0 t name_show
> >  ffffffff8c9cccb0 t name_show
> >  ffffffff8cb0ac20 t name_show
> >  ffffffff8cc728c0 t name_show
> >  ffffffff8ce0efd0 t name_show
> >  ffffffff8ce126c0 t name_show
> >  ffffffff8ce1dd20 t name_show
> >  ffffffff8ce24e70 t name_show
> >  ffffffff8d1104c0 t name_show
> >  ffffffff8d1fe480 t name_show
> 
> One problem that remains as far as I can see is that this approach does not
> take into consideration that there can be duplicate symbols in the core
> kernel, but also between core kernel and loadable modules, and even between
> loadable modules.  So, I think more is needed to also ensure that this
> approach of adding alias symbols is also done for loadable modules.

Re-reading my email a bit more, I realize that I did not accurate demonstrate
the issue I arefer to.  Obviously, the current patch provides aliases for
duplicate symbols in the core kernel.  And loadable modules are annotated with
the module name.  So, all is well unless modules have duplicate symbols
themselves.  And although it is rare, it does happen:

# grep ' metadata_show' /proc/kallsyms 
ffffffffc05659c0 t metadata_show        [md_mod]
ffffffffc05739f0 t metadata_show        [md_mod]

This again shows a case where there are duplicate symbols that cannot be
distinguished for tracing purposes without additional information.  So, the
proposed patch unfortunately does not cover all cases because of loadable
modules.

> Earlier work that cover all symbols (core kernel and loadable modules) was
> posted quite a while ago by Nick Alcock:
> 
> https://lore.kernel.org/all/20221205163157.269335-1-nick.alcock@oracle.com/
> 
> It takes a different approach and adds in other info that is very useful for
> tracing, but unfortunately it has been dormant for a long time now.
> 
> While module symbols are handled quite differently (for kallsyms) from the
> core kernel symbols, I think that a similar approach tied in with modpost
> ought to be quite possible.  It will add to the size of modules because the
> data needs to be stored in the .ko but that is unavoidable.  But not doing it
> unfortunately would mean that the duplicate symbol issue remains unresolved
> in the presence of loadable modules.
> 
> > kas_alias addresses this challenge by enhancing symbol names with
> > meaningful suffixes generated from the source file and line number
> > during the kernel build process.
> > These newly generated aliases provide tracers with the ability to
> > comprehend the symbols they are interacting with when utilizing the
> > ftracefs interface.
> > This approach may also allow for the probing by name of previously
> > inaccessible symbols.
> > 
> >  ~ # cat /proc/kallsyms | grep gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq
> >  ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
> >  ffffd15671e532a4 t gic_mask_irq
> >  ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
> >  ~ #
> 
> In the same context as mentioned above (module symbols), I am hoping that the
> alias you generate might also be able to contain a module identifier name,
> much like the aforementioned patch series by Nick Alcock added.  We have it
> for loadable modules already of course, but as has been discussed in relation
> to the earlier work, being able to associate a module name with a symbol
> regardless of whether that module is configured to be built into the kernel
> or whether it is configured to be a loadable module is helpful for tracing
> purposes.  Especially for tracers that use tracing scripts that might get
> deployed on diverse systems where it cannot always be known at the time of
> developing the tracer scripts whether a kernel module is configured to be
> loadable or built-in.
> 
> I'd be happy to work on something like this as a contribution to your work.
> I would envision the alias entry not needing to have the typical [module] added
> to it because that will already be annotated on the actual symbol entry.  So,
> the alias could be extended to be something like:
> 
> ffffffffc0533720 t floppy_open  [floppy]
> ffffffffc0533720 t floppy_open@floppy:drivers_block_floppy_c_3988
> 
> (absence of a name: prefix to the path would indicate the symbol is not
>  associated with any module)
> 
> Doing this is more realistic now as a result of the clean-up patches that
> Nick introduced, e.g.
> 
> https://lore.kernel.org/lkml/20230302211759.30135-1-nick.alcock@oracle.com/

Reflecting on this a bit more, I think that there might be a much easier (yet
sufficient) solution to providing module name distinction for builtin modules.
Since only duplicate symbols get aliases with the current patch, that would
not be sufficient to identify symbols as belonging to a (conceptual) module
i.e. a module that could have been configured to be loadable but instead is
compiled in).  You would need to add an alias for *all* symbols that are part
of such conceptual modules, which I expect would be considered to be a bit
excessive for the moderate benefit.

I am working on an alternative solution that won't bloat the kernel with
extra aliases and yet should be sufficient to provide module name information
so tracers can use it.

> > Changes from v1:
> > - Integrated changes requested by Masami to exclude symbols with prefixes
> >   "_cfi" and "_pfx".
> > - Introduced a small framework to handle patterns that need to be excluded
> >   from the alias production.
> > - Excluded other symbols using the framework.
> > - Introduced the ability to discriminate between text and data symbols.
> > - Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_DATA,
> >   which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
> >   excludes all filters and provides an alias for each duplicated symbol.
> > 
> > https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati@gmail.com/
> > 
> > Changes from v2:
> > - Alias tags are created by querying DWARF information from the vmlinux.
> > - The filename + line number is normalized and appended to the original
> >   name.
> > - The tag begins with '@' to indicate the symbol source.
> > - Not a change, but worth mentioning, since the alias is added to the
> >   existing list, the old duplicated name is preserved, and the livepatch
> >   way of dealing with duplicates is maintained.
> > - Acknowledging the existence of scenarios where inlined functions
> >   declared in header files may result in multiple copies due to compiler
> >   behavior, though it is not actionable as it does not pose an operational
> >   issue.
> > - Highlighting a single exception where the same name refers to different
> >   functions: the case of "compat_binfmt_elf.c," which directly includes
> >   "binfmt_elf.c" producing identical function copies in two separate
> >   modules.
> > 
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> > 
> > Changes from v3:
> > - kas_alias was rewritten in Python to create a more concise and
> >   maintainable codebase.
> > - The previous automation process used by kas_alias to locate the vmlinux
> >   and the addr2line has been replaced with an explicit command-line switch
> >   for specifying these requirements.
> > - addr2line has been added into the main Makefile.
> > - A new command-line switch has been introduced, enabling users to extend
> >   the alias to global data names.
> > 
> > https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati@gmail.com/
> > 
> > Changes from v4:
> > - Fixed the O=<build dir> build issue
> > - The tool halts execution upon encountering major issues, thereby ensuring
> >   the pipeline is interrupted.
> > - A cmdline option to specify the source directory added.
> > - Minor code adjusments.
> > - Tested on mips32 and i386
> > 
> > https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminati@gmail.com/
> > 
> > NOTE:
> > About the symbols name duplication that happens as consequence of the
> > inclusion compat_binfmt_elf.c does, it is evident that this corner is
> > inherently challenging the addr2line approach.
> > Attempting to conceal this limitation would be counterproductive.
> > 
> > compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
> > but report all functions and data declared by that file, coming from
> > binfmt_elf.c.
> > 
> > My position is that, rather than producing a more complicated pipeline
> > to handle this corner case, it is better to fix the compat_binfmt_elf.c
> > anomaly.
> > 
> > This patch does not deal with the two potentially problematic symbols
> > defined by compat_binfmt_elf.c
> > 
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> > ---
> >  Makefile                |   4 +-
> >  init/Kconfig            |  22 +++++++
> >  scripts/kas_alias.py    | 136 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh |  21 ++++++-
> >  4 files changed, 180 insertions(+), 3 deletions(-)
> >  create mode 100755 scripts/kas_alias.py
> > 
> > diff --git a/Makefile b/Makefile
> > index 4f283d915e54..f33c179f4cc3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -488,6 +488,7 @@ OBJCOPY		= $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
> >  OBJDUMP		= $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
> >  READELF		= $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
> >  STRIP		= $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
> > +ADDR2LINE	= $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
> >  else
> >  CC		= $(CROSS_COMPILE)gcc
> >  LD		= $(CROSS_COMPILE)ld
> > @@ -497,6 +498,7 @@ OBJCOPY		= $(CROSS_COMPILE)objcopy
> >  OBJDUMP		= $(CROSS_COMPILE)objdump
> >  READELF		= $(CROSS_COMPILE)readelf
> >  STRIP		= $(CROSS_COMPILE)strip
> > +ADDR2LINE	= $(CROSS_COMPILE)addr2line
> >  endif
> >  RUSTC		= rustc
> >  RUSTDOC		= rustdoc
> > @@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP := 1
> >  export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
> >  export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
> >  export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
> > -export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> > +export CPP AR NM STRIP OBJCOPY OBJDUMP READELF ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 6d35728b94b2..d45dd423e1ec 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
> >  	  time constants, and no relocation pass is required at runtime to fix
> >  	  up the entries based on the runtime load address of the kernel.
> >  
> > +config KALLSYMS_ALIAS_SRCLINE
> > +	bool "Produces alias for duplicated text symbols" if EXPERT
> > +	depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
> > +	help
> > +	  It is not uncommon for drivers or modules related to similar
> > +	  peripherals to have symbols with the exact same name.
> > +	  While this is not a problem for the kernel's binary itself, it
> > +	  becomes an issue when attempting to trace or probe specific
> > +	  functions using infrastructure like ftrace or kprobe.
> > +
> > +	  This option addresses this challenge, producing alias for text
> > +	  symbol names that include the file name and line where the symbols
> > +	  are defined in the source code.
> > +
> > +config KALLSYMS_ALIAS_SRCLINE_DATA
> > +	bool "Produces alias also for global variables names"
> > +	depends on KALLSYMS_ALIAS_SRCLINE
> > +	help
> > +	  Sometimes it can be useful to refer to global vars by name. Since
> > +	  they suffer the same issue as text symbols, this config option
> > +	  allows having aliases for global variables names too.
> > +
> >  # end of the "standard kernel features (expert users)" menu
> >  
> >  # syscall, maps, verifier
> > diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
> > new file mode 100755
> > index 000000000000..7c6b7045081c
> > --- /dev/null
> > +++ b/scripts/kas_alias.py
> > @@ -0,0 +1,136 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati <alessandro.carminati@gmail.com>
> > +#
> > +# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
> > +
> > +import subprocess
> > +import sys
> > +import os
> > +import argparse
> > +import re
> > +from collections import namedtuple
> > +
> > +regex_filter = [
> > +        "^__compound_literal\\.[0-9]+$",
> > +        "^__[wm]*key\\.[0-9]+$",
> > +        "^_*TRACE_SYSTEM.*$",
> > +        "^__already_done\\.[0-9]+$",
> > +        "^__msg\\.[0-9]+$",
> > +        "^__func__\\.[0-9]+$",
> > +        "^CSWTCH\\.[0-9]+$",
> > +        "^_rs\\.[0-9]+$",
> > +        "^___tp_str\\.[0-9]+$",
> > +        "^__flags\\.[0-9]+$",
> > +        "^___done\\.[0-9]+$",
> > +        "^__print_once\\.[0-9]+$",
> > +        "^___once_key\\.[0-9]+$",
> > +        "^__pfx_.*$",
> > +        "^__cfi_.*$"
> > +        ]
> > +
> > +class SeparatorType:
> > +    def __call__(self, separator):
> > +        if len(separator) != 1:
> > +            raise argparse.ArgumentTypeError("Separator must be a single character")
> > +        return separator
> > +
> > +Line = namedtuple('Line', ['address', 'type', 'name'])
> > +
> > +def parse_file(filename):
> > +    symbol_list = []
> > +    name_occurrences = {}
> > +
> > +    with open(filename, 'r') as file:
> > +        for line in file:
> > +            fields = line.strip().split()
> > +
> > +            if len(fields) >= 3:
> > +                address, type, name = fields[0], fields[1], ' '.join(fields[2:])
> > +                symbol_list.append(Line(address, type, name))
> > +                name_occurrences[name] = name_occurrences.get(name, 0) + 1
> > +
> > +    return symbol_list, name_occurrences
> > +
> > +def find_duplicate(symbol_list, name_occurrences):
> > +    name_to_lines = {}
> > +    duplicate_lines = []
> > +
> > +    for line in symbol_list:
> > +        if line.name in name_to_lines:
> > +            first_occurrence = name_to_lines[line.name]
> > +            duplicate_lines.extend([first_occurrence, line])
> > +        else:
> > +            name_to_lines[line.name] = line
> > +
> > +    return duplicate_lines
> > +
> > +def start_addr2line_process(binary_file, addr2line_file):
> > +    try:
> > +        addr2line_process = subprocess.Popen([addr2line_file, '-fe', binary_file],
> > +                                             stdin=subprocess.PIPE,
> > +                                             stdout=subprocess.PIPE,
> > +                                             stderr=subprocess.PIPE,
> > +                                             text=True)
> > +        return addr2line_process
> > +    except Exception as e:
> > +        print(f"Error starting addr2line process: {str(e)}")
> > +        sys.exit(1)
> > +
> > +def addr2line_fetch_address(addr2line_process, address):
> > +    try:
> > +        addr2line_process.stdin.write(address + '\n')
> > +        addr2line_process.stdin.flush()
> > +        addr2line_process.stdout.readline().strip()
> > +        output = addr2line_process.stdout.readline().strip()
> > +
> > +        return os.path.normpath(output)
> > +    except Exception as e:
> > +        print(f"Error communicating with addr2line: {str(e)}")
> > +        sys.exit(1)
> > +
> > +def process_line(obj, config):
> > +    if config:
> > +        return not (any(re.match(regex, obj.name) for regex in regex_filter))
> > +    else:
> > +        return obj.type in {"T", "t"}
> > +
> > +if __name__ == "__main__":
> > +    parser = argparse.ArgumentParser(description='Add alias to multiple occurring symbols name in kallsyms')
> > +    parser.add_argument('-a', "--addr2line", dest="addr2line_file", required=True)
> > +    parser.add_argument('-v', "--vmlinux", dest="vmlinux_file", required=True)
> > +    parser.add_argument('-o', "--outfile", dest="output_file", required=True)
> > +    parser.add_argument('-n', "--nmdata", dest="nm_data_file", required=True)
> > +    parser.add_argument('-b', "--basedir", dest="linux_base_dir", required=True)
> > +    parser.add_argument('-s', "--separator", dest="separator", required=False, default="@", type=SeparatorType())
> > +    parser.add_argument('-d', "--data", dest="include_data", required=False, action='store_true')
> > +    config = parser.parse_args()
> > +
> > +    try:
> > +        config.linux_base_dir = os.path.normpath(os.getcwd() + "/" + config.linux_base_dir) + "/"
> 
> This logic normalization fails when you are building the kernel in a directory
> that is symbolically linked to another fs.  E.g. I have:
> 
> 	/home/kvanhees/linux-stable
> 
> which is a symbolic link to
> 
> 	/local/linux-stable	
> 
> Since /local is its own fs, the above normalization expression renders the
> passed-in basedir "." to be /local/linux-stable, but addr2line is reporting
> filenames under /home/kvanhees/linux-stable
> 
> > +        symbol_list, name_occurrences = parse_file(config.nm_data_file)
> > +        addr2line_process = start_addr2line_process(config.vmlinux_file, config.addr2line_file)
> > +
> > +        with open(config.output_file, 'w') as file:
> > +            for obj in symbol_list:
> > +                file.write(f"{obj.address} {obj.type} {obj.name}\n")
> > +                if (name_occurrences[obj.name] > 1) and process_line(obj, config.include_data) :
> > +                    output = addr2line_fetch_address(addr2line_process, obj.address)
> > +                    decoration = config.separator + "".join(
> > +                        "_" if not c.isalnum() else c for c in output.replace(config.linux_base_dir, "")
> > +                    )
> > +                    # The addr2line can emit the special string "?:??" when addr2line can not find the
> > +                    # specified address in the DWARF section that after normalization it becomes "____".
> > +                    # In such cases, emitting an alias wouldn't make sense, so it is skipped.
> > +                    if decoration != config.separator + "____":
> > +                        file.write(f"{obj.address} {obj.type} {obj.name + decoration}\n")
> > +
> > +        addr2line_process.stdin.close()
> > +        addr2line_process.stdout.close()
> > +        addr2line_process.stderr.close()
> > +        addr2line_process.wait()
> > +
> > +    except Exception as e:
> > +        print(f"An error occurred: {str(e)}")
> > +        raise SystemExit("Script terminated due to an error")
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index a432b171be82..c110b0f58a19 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -91,7 +91,12 @@ vmlinux_link()
> >  
> >  	# The kallsyms linking does not need debug symbols included.
> >  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > -		ldflags="${ldflags} ${wl}--strip-debug"
> > +		# The kallsyms linking does not need debug symbols included,
> > +		# unless the KALLSYMS_ALIAS_SRCLINE.
> > +		if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
> > +		   [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> > +			ldflags="${ldflags} ${wl}--strip-debug"
> > +		fi
> >  	fi
> >  
> >  	if is_enabled CONFIG_VMLINUX_MAP; then
> > @@ -161,7 +166,19 @@ kallsyms()
> >  	fi
> >  
> >  	info KSYMS ${2}
> > -	scripts/kallsyms ${kallsymopt} ${1} > ${2}
> > +	ALIAS=""
> > +	KAS_DATA=""
> > +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
> > +		KAS_DATA="--data"
> > +	fi
> > +	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
> > +		ALIAS=".alias"
> > +		${srctree}/scripts/kas_alias.py \
> > +			--addr2line ${ADDR2LINE} --vmlinux ${kallsyms_vmlinux} \
> > +			--nmdata ${1} --outfile ${1}${ALIAS} \
> > +			--basedir ${srctree} --separator @ ${KAS_DATA}
> > +	fi
> > +	scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
> >  }
> >  
> >  # Perform one step in kallsyms generation, including temporary linking of
> > -- 
> > 2.34.1
