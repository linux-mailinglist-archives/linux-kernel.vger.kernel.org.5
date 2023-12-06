Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66975807840
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378763AbjLFS5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjLFS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:57:50 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A5884;
        Wed,  6 Dec 2023 10:57:56 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B6CFLul008070;
        Wed, 6 Dec 2023 18:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=maNycuam/dVXRrRzwOf
        gZHYHHhCopecALsh4kP2mlx4=; b=iG9ZB8R9xPrEBsZHKsEP4rRpIORtUOxsxRQ
        wsApotZBeQT9fFHnrtxYytvibTBpJ+tZ3k4IvudndbK5f8UmZ+E9lX8EJqj4JDYe
        nGmPrIcRfxVfQmbAWVXMZlMFt7GHH0cfTw+LdoHkPq4J006EWXbDNc+QPIVilEfo
        GFMNFr3ziVBfICNroljFBSI/iDxolVDk4pScttgEQTv6fjs8wTqRoAeD18vuxh3q
        R3tbKvGhIwlF4ryKjqXNXcpojc9GGsh598cpehOT9yQoxuUDiIN4xkKMN0AF9EkE
        F2apKoOk6xl7g6woPGRVULYKmJnwFzURWabN7QBGMug/IzJ5Hww==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd53gw4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 18:57:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzjZIe06q6X+PAfTJ6C2KXq6DqtESTokxUItJEwZzNDDKVO24mOcK+ZmUxErAo6u9peCizFMlYH2ItgmnwZ56vjzELWn+F+hS5Nu2WqpdWRgjsn/k0Xt+gvycVEst8uXGBAu2bLUKa+o8M8yy554ihGfLDQI1Mcx7sw1q9gKJBbORuZTpaqZY4vDDOBaolChvMX7G4j4+pneGNsHjREortXXNY1CSpBAQf5csFqOaOqFDBYluafgN9m9X07VLHRZv7rYqH65O+kQtEFq2wxKnqCO21d0mvlNuyu3jjL67oBBBxdSlqcuuRClN5lGKAfdl/xZEaI0+hSLVheilqfwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maNycuam/dVXRrRzwOfgZHYHHhCopecALsh4kP2mlx4=;
 b=N8GRg1H/B/CE06C0BweWpJXo8BFKCZO34OXwin9HCOQFc9kjRV45xKL/R8g8eGG/AnjN+NvmToI4btvQMYIQC8reADtBvclYRkape14fxrCo3NgrTTlDXqX/hpONpauz5saJxzlwlZX8rTLpqkO6MGPkyovwesBGkVSiveKWyd9Ab5OPHzVIjdytwPZjMf90WPDZTr2tj+SjpgMRVwISw+KBrDdkSKc7Oc0R1YVHwZS2m0xMvzYfzJbsm3iD6ucZSFddN5pwkrahwlpj5V4VGYD8dmFo6Er+bS+DYNBitHLMmPRmYFrgwH2pcMS92MvwdJMRX3FGHsvCi7NTitf1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:56:12 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:56:11 +0000
Date:   Wed, 6 Dec 2023 13:56:07 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: move THIS_MODULE from <linux/export.h> to
 <linux/init.h>
Message-ID: <ZXDDx4/g4Le38oEh@windriver.com>
References: <20231126071914.932241-1-masahiroy@kernel.org>
 <CAK7LNATEJ80O8r-B+ByBykNVhDR2SW9_cBDArhz1W75KNW=z_A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATEJ80O8r-B+ByBykNVhDR2SW9_cBDArhz1W75KNW=z_A@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::19) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad2f20b-3acf-4459-23ff-08dbf68d03c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WbAURscda1cgsCaJJE6w39VBaNVI7Ri8L0j+W8vM30QF1qnHv1WERivDtSH4moG7kXeUjsHRTh+loQj7iZW1rIq4en1p7KJ/cGWBaVTVRwMJbvc5Kq7NxRND7Ydx/seCFkQ7OVDphEJmaRqy4BS4sCSbfDHBsU8NqnD8gQTdAm0hwTvXT/PyV3kFbtgZgtMp75NBVPalZjDFpNjAbKd4sLgyIcRbnY3l3QecJ3U8RoXYSo1MxOyhm6BQK38Qr0aY3MaGVVPSectJIm7T0nfK+k+YQlMkgiqkHX2b4lmbb5vKDD9yeZfhNT1V+OFbX4LeieaAF2YG4r+oS2tne7B5E/yS2R5V4eEdcvtRFHGwaHebRu62hCUxPhodg3q5XlzU2krml1NAB0UXMmtf0XSIVwqG01A2tJ3zOMgJ9RHGv0o1uxklj7/wfuGTMUOvlSNR0YcNjTqeSs+ccmiSx28RP9qYHfHgoNQ53Xq1ZcV4uy/32LUp7UGoV9E+3soto19N4m/cooPcQish2XV4speMCXno25KRXd2ZINAt3Hg5POIgpnexw4hL0TVeTsZZcJq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(6506007)(478600001)(5660300002)(2906002)(44832011)(83380400001)(86362001)(2616005)(26005)(36756003)(6512007)(41300700001)(66556008)(66946007)(6916009)(316002)(8676002)(8936002)(6666004)(4326008)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rjP8TyE/oIksrR7Tc2GJuOzNklT5gkuXL/T9i1BfyetnLKijV8CmKwWcavls?=
 =?us-ascii?Q?8GDofTS9bTt7IytXLv1pS5DoZtWnRV5YwbIgMME/4NhN1s7qtccxSUSaG762?=
 =?us-ascii?Q?RplsSapS3VTGHQ1kCN0UsDbfordrXQpsZOSremlsz3Ejpg1iqF1k5wLAmePO?=
 =?us-ascii?Q?r6Dk7sJpO07rR0Urig+KIIdd9jNniBFz9UszZ9R6Yh8EXfYekBqX739DNFuU?=
 =?us-ascii?Q?DT0p2jd8Olq3wS/+YSKHaUIjky2XjuIuMZ+1eQzJ4cheaCQCo8ec8SiaeCWp?=
 =?us-ascii?Q?m2G9EEh5gexDY2e/6DL1WN8Fvk3eJXhICUrLl8QFfD5RraZ3W8mQipQwU2LL?=
 =?us-ascii?Q?z5B25g17JOb1r3PrGfow0QBBZLYsIF7Bfi5CBv+D5aonYJdz5asMLWvbn0E7?=
 =?us-ascii?Q?C+wbz9toz5Pjs9/g32NvRuZZuBCP0ix85gZyYezg2ZoManADL3dlaNcFpfnT?=
 =?us-ascii?Q?UF8BQheoLVO+oVqTYC7wuBTK5LDckWzU37epG7Dphx867ToHMkAddvP4Sysc?=
 =?us-ascii?Q?FYd7zi+omgx0ulcrart23DUblj7sXbg3WQ/PwE9IZ94SNl86GGcZ8MMFApJA?=
 =?us-ascii?Q?3sf4SKFyNVERLT3MQ+1ff/lw9ACcffDdCe7MAMNZDtORgqv9LZKjNIkW//Jd?=
 =?us-ascii?Q?JoIxHosx8G34EzyDTjc8bFDmdiEykDZ0PDTtSIwIdsi0XOU44XVe7zOsokFZ?=
 =?us-ascii?Q?qrPmvTpZe8D9f4/k+oYa7l1gPcpmxh9yyDjhetFkYnzq1C3WFHt2c/R/X+a1?=
 =?us-ascii?Q?1rym6M1UJdSpbUDZWbBJ++sHbUNZ3OwIt35x0Jd1CYJxMWaS2cIFcufZifBK?=
 =?us-ascii?Q?zForY8L4X7mcKHGCRUOnG7eqVmUq3c/d2mxzS3Xe2mN5cozyAUOmKvGyJ3Bj?=
 =?us-ascii?Q?jZiQNOCT6EN4gfv2K65t+tLMT7VZ5C9dEzPQaoPurEShiZBfoHd5WZ3AXoyF?=
 =?us-ascii?Q?9BojisrNMN44+Q1F//Uot0U95DQH/9uepie/fBWTEaKNJSRvYOgi8jL9EPsk?=
 =?us-ascii?Q?l4+EUGvloryHvPx5kqQjaZqWOUabjr0Zk78mdJ/UNxUTNg0LAarhyOmUdx3h?=
 =?us-ascii?Q?STEARiPMoM7hJ6KB6r5A0QBWNhBbChLGshZ2JyKxyB7w67wfNLhKtdz/wpeG?=
 =?us-ascii?Q?P0Au0W0XwpCeoeSS34wlSDcheQw/PuAvtmNITrb2HXAgHuY6Abaj4+HoClVT?=
 =?us-ascii?Q?pBB3TGr9kUzjkTYLwbQqnYw5UyEmvl8W0Dd4K6y0gKUEQwUJ3OCQYylhnbvO?=
 =?us-ascii?Q?q3AzgwaWaroEm2wUdhEXx2ln4DO0fKFlMFBndBns/UnJ9jhnZ3v8V3HuLr/r?=
 =?us-ascii?Q?6vtlnRhoTCI/gXoBZO+8v/zJnzByTOQB6vULry6p8KAPkRMc/NhZIH5rWJYP?=
 =?us-ascii?Q?aBAHVxLQo79WRhimO+O93IjSC5ZXnRgrYCNzmL5PjJ1xyjgpx65vlwVGWQAE?=
 =?us-ascii?Q?wgUeP8VZPfjusk3EumBzkB5t1vfTA5IVotR6OkdQDyEXUxFZ9hccMSTiMoLl?=
 =?us-ascii?Q?Q64Y/pzFetWnJSLqm8jm9+jKKFC7VdaD9clvd9qkUUAb4eN+yfZGxk1GSnsA?=
 =?us-ascii?Q?Sbeh9wecD18xJ4zG4qE4uih8uR0blck2+iHr6oT6eiENU8ITe4DmOxdq+fsq?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad2f20b-3acf-4459-23ff-08dbf68d03c0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:56:11.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lt9IS7CNZUpuwNj3qUXghE4Mgyg98vYWaqfCvMv5hfdvLNSLf3sqRRC1eIxHAYQ7oz1CZfXlDrnSqHG6nwqYi8PhqsaZWqfYxRLsi7T5NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-Proofpoint-ORIG-GUID: SYVw_WiOM6efgN4LXbmZUCyRL-KO73m5
X-Proofpoint-GUID: SYVw_WiOM6efgN4LXbmZUCyRL-KO73m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312060141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH] init: move THIS_MODULE from <linux/export.h> to <linux/init.h>] On 03/12/2023 (Sun 19:06) Masahiro Yamada wrote:

> On Sun, Nov 26, 2023 at 4:19???PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Commit f50169324df4 ("module.h: split out the EXPORT_SYMBOL into
> > export.h") appropriately separated EXPORT_SYMBOL into <linux/export.h>
> > because modules and EXPORT_SYMBOL are orthogonal; modules are symbol
> > consumers, while EXPORT_SYMBOL are used by symbol providers, which
> > may not be necessarily a module.
> >
> > However, that commit also relocated THIS_MODULE. As explained in the
> > commit description, the intention was to define THIS_MODULE in a
> > lightweight header, but I do not believe <linux/export.h> was the
> > suitable location because EXPORT_SYMBOL and THIS_MODULE are unrelated.
> >
> > Move it to another lightweight header, <linux/init.h>. The reason for
> > choosing <linux/init.h> is to make <linux/moduleparam.h> self-contained
> > without relying on <linux/linkage.h> incorrectly including
> > <linux/export.h>.
> >
> > With this adjustment, the role of <linux/export.h> becomes clearer as
> > it only defines EXPORT_SYMBOL.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> 
> 
> Applied to kbuild.
> 
> I did not get any report from the 0day bot so far,
> but I hope it will get a little more compile tests
> before getting into linux-next.

Haven't touched that kind of header shuffle for over 10 years?

But yeah, it is near impossible to not trip over some implicit header
inclusion somewhere in some driver or a less common arch and hence break
the build at least once when doing this kind of stuff.

Paul.
--

> 
> 
> 
> >
> >  include/linux/export.h | 18 ------------------
> >  include/linux/init.h   |  7 +++++++
> >  2 files changed, 7 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/export.h b/include/linux/export.h
> > index 9911508a9604..0bbd02fd351d 100644
> > --- a/include/linux/export.h
> > +++ b/include/linux/export.h
> > @@ -6,15 +6,6 @@
> >  #include <linux/linkage.h>
> >  #include <linux/stringify.h>
> >
> > -/*
> > - * Export symbols from the kernel to modules.  Forked from module.h
> > - * to reduce the amount of pointless cruft we feed to gcc when only
> > - * exporting a simple symbol or two.
> > - *
> > - * Try not to add #includes here.  It slows compilation and makes kernel
> > - * hackers place grumpy comments in header files.
> > - */
> > -
> >  /*
> >   * This comment block is used by fixdep. Please do not remove.
> >   *
> > @@ -23,15 +14,6 @@
> >   * side effect of the *.o build rule.
> >   */
> >
> > -#ifndef __ASSEMBLY__
> > -#ifdef MODULE
> > -extern struct module __this_module;
> > -#define THIS_MODULE (&__this_module)
> > -#else
> > -#define THIS_MODULE ((struct module *)0)
> > -#endif
> > -#endif /* __ASSEMBLY__ */
> > -
> >  #ifdef CONFIG_64BIT
> >  #define __EXPORT_SYMBOL_REF(sym)                       \
> >         .balign 8                               ASM_NL  \
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 01b52c9c7526..3fa3f6241350 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -179,6 +179,13 @@ extern void (*late_time_init)(void);
> >
> >  extern bool initcall_debug;
> >
> > +#ifdef MODULE
> > +extern struct module __this_module;
> > +#define THIS_MODULE (&__this_module)
> > +#else
> > +#define THIS_MODULE ((struct module *)0)
> > +#endif
> > +
> >  #endif
> >
> >  #ifndef MODULE
> > --
> > 2.40.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
