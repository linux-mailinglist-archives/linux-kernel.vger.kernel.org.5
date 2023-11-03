Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD637E00C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376441AbjKCKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347710AbjKCKST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:18:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9279913E;
        Fri,  3 Nov 2023 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699006693; x=1730542693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RSTTBpoxbE5jNoLO6RprvNAG+HE73+6gZNW999gnDTk=;
  b=SPwgcbA8rmE1b21thFhzgqbfI8OOjs5z6d6vZUjACi0qiquap2Rquje1
   mXUAR1wWMbUCNTKCCP/1eb9jhhFO1/19udFb5ll6IBfPFyL2hiHOkPSWD
   LOdTVwKgD20y9YiDebqTOZYFUFC8Zf1hqz6L2jNXhvkX8WWmkZDA2aP+B
   adbwEY4g859GCIcoayE52qQwMW8tOLce/T2P9NlrRzcPGX9vQh5dyqz7C
   SXFP4TXwamYSIQ6An8AtIVcGf79fhJUgO0WEOH2wDtTzwc99IXBVVxlAV
   2eJ782HSbZp8YoX7aXsE+jdZ/VH8oExGehE6JNkTKObHS4trZSZrsG+yW
   A==;
X-CSE-ConnectionGUID: s6JYBNAvRli0NaofhSdzDQ==
X-CSE-MsgGUID: 2612XXurTSiF1wpyf7bCJQ==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1293338"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 18:18:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZWF8Nm7YQAqDK/hLxgPt8Q+EsvKN/Fs/oPFQR8bdW5e7Hec3vEBnD7N1NAqIj7j1DBRD8Ux/urFz+MpPKKVpg65kXKOEXk5fg+70ALE0mPAd1EZJo5QJE9WhynS6ilRO9W9Z63QgESGZg1L83Boao7VOrqAGwbru4p6B26UZJ19jD9oOE2UGVm4P6M70su4fhIZVfxRsCfWoxTKViDiOclvTfRp5CTPUwHCaw7TgZ4iPCbDIwBmNYZDb88UmabGJuGTSWDZmlSGLBJ9co5o+WxiJdJ9yUqjvAnobHtwG82CW7tfTPfAO1BWJ6dbCIh/qifLtWgFrLliSodksHHDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxmL8r8v3VuJUcw3HaC9/Ur/5dIb5laKysyFSYWhvLw=;
 b=GGaFscZSHJhsvO1T3KL2fPzjejW13OHl1bU3Mh3uQGzt5ft99VGBVdGAtRMAjRqjJFIPWm/VEafYIlucgv/N/4bUH5t7jv2xJ3JTNCuq3Y9IdUOoBoqnYnhY+7m7ZbfZLLRcgpCp/6al2YTb0yQHJfGizBUbkbx9VzZ/eWh4eOEyxfyZntp+paPGxK1KMF4TObTIKDyc9ATKnWguoiQSxZS8nAjoEN+r7aGqNuSvfuiO5+SRK5RU0D6SZFgR9mEYWUigsRk3ax6QWaQNtMLEa6D2yOzZEVF+xyHiavuOQ2O+d57poqjPvMb6RMERVYehtcXY5XjrMlIVD8QCFnj4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxmL8r8v3VuJUcw3HaC9/Ur/5dIb5laKysyFSYWhvLw=;
 b=hZGd8SEvVDN/9lXqmK/a7XVoDqh4PaCW4J/dwNzWqLYE+1G/E7i0lKZF/XLNNExdxouCKMf90Xh7UDTwAv/v4MNHG7mApDLtPP08E+obPpJRyaYm9SdwlhD30Qc13cb/Sed8CKUxig4eX/oISIKOw6y+86atFHa8HOY1N3OZ1sA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7475.namprd04.prod.outlook.com (2603:10b6:303:b0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 10:18:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 10:18:06 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Kornel_Dul=EAba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/6] mmc: block: Do not lose cache flush during CQE
 error recovery
Thread-Topic: [PATCH V2 1/6] mmc: block: Do not lose cache flush during CQE
 error recovery
Thread-Index: AQHaDjKL9WyFoDZvmECWnAl1OY40DrBoYYGg
Date:   Fri, 3 Nov 2023 10:18:06 +0000
Message-ID: <DM6PR04MB6575A9870AF9D49AB96EEA19FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-2-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-2-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7475:EE_
x-ms-office365-filtering-correlation-id: 08655585-2f99-4f8d-1c67-08dbdc562c1e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwgX0+XMxjViG9AvHagxV62/GDXydJMtDVzVOGqXjAtnClomm/icYUJYJzFdKbYZO8Mj39m9LOmiMQg1q00ow0Y+SrnKcuFsO7RNszN6ZHPfncqhpcgmZAS6oFB7IF5wdURbzrM73pcDMKz97DZKDm2ey8ebK/KMdX7vMGe65uqT0rCyheDfKvdjAX9KfHrUFiiyTFn9rlJUnU1AT0WmVBABJb3WhbbOLBtMQBXGc5DO9jcKShvARx+zpg92rCaEsmQLfeACHYYDZ4c91UvtEKlcPOWIMcLvoXIwOVaq7B+Ci1lvyQMYtHEOIEuLTTfBbzFeBkOeUEeAKFUzqvFA/PapM8FIdODP7HDNqEua4UA8W2EEt1T5clJzWRmcksdBeYowgHTxtbrhgxM4Ut8H+n61l9CJzs3siDFOjdknKnhCr240kYKNOWvTBxI9831Wwl3kHnV2TfBlm8Xc7Fa/Aq5H+Wc7gZmHD+wKNZ0yMV2GVOCVUGwSvPNylkZnVq118mZtzBAg8RnInSLqnkMawR0gFL5yttlAH+xkJWoo1U0jLPvWFJxmGJiHUGQ6hjb/7TIGS3cqqSWxYvO67WHBI1KtCPkfnn/fxujZu14XUhO0XiwZmw3wbm4FFvyADObP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(54906003)(76116006)(66556008)(64756008)(5660300002)(66476007)(316002)(8676002)(55016003)(4326008)(2906002)(8936002)(66446008)(66946007)(7416002)(110136005)(71200400001)(478600001)(9686003)(41300700001)(26005)(7696005)(6506007)(83380400001)(38070700009)(82960400001)(33656002)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?huPjzgVRWwHoPS1cmzUlN6WvASrHYDZtdjx88V4ImHWUJwtJMhSoXXVBfJ?=
 =?iso-8859-2?Q?s/Jswk4veMaWcnNV5yMNQ3KqCWWGeqzjJ398Lh77D/buj0mUa9eniBm6vk?=
 =?iso-8859-2?Q?lVoY7aag9EXo7bg1moL2wZO5xXctRCF3Ybs8amiKHvpvlZgeP/N0HmexO4?=
 =?iso-8859-2?Q?Ly/x8SLmNwUxutvJtqtarUGiJinOoegQtwSiLabNFcdLdKnuv1xrl5Jt8P?=
 =?iso-8859-2?Q?jPuyQJiZLftPPp28PqegO9i4A0FRPYM99rA7JdF//JerSfmajSfNGWChzw?=
 =?iso-8859-2?Q?haYEFwQen8MM70DbNIVLz8MIlS4fFm9jTI3W1lLzDylY+DSePk+s45Pi4G?=
 =?iso-8859-2?Q?SfLei4x0QfRSki40Wx5iniHwSTIXISh9PAPFOZfH2M726mRH3bX0zSIfMf?=
 =?iso-8859-2?Q?UNhI/udwheg601CWRNtbA0cdSvTqRzPpXIT2YEFinrUMPH1KJ4x72jID1N?=
 =?iso-8859-2?Q?HrSUuAn9ng/RVmEC6QYsFL+a7rALSbku8xuLSqoK6YReSMtjaqqmV5XvUy?=
 =?iso-8859-2?Q?+EtWvQcZBIpPmaw1MMml4LzYK581Q3o9xALQS6N8GjxdxC+V03/Un5i3oX?=
 =?iso-8859-2?Q?RRLBtXD+gsBtCcQ9KYLx+RUfSiATFOCdvZbWST3O3iVbYrn6MAdLzgG2eD?=
 =?iso-8859-2?Q?aDp/+cWL0+WLyRtGSVzK9jb3Uv6Zu70npXwpLk+pVD/RjRKJApm+zWqYDE?=
 =?iso-8859-2?Q?UjLZWaIe+/qp6Vhr5oCDWXsIm3eleP1KZ6rcT5D5ITPhkL0Ptuio2+jAXn?=
 =?iso-8859-2?Q?SmzweAcb0inVQprSozMgykeo4argO39GaIFzlxIyccOPMSNIlaGpj91+g2?=
 =?iso-8859-2?Q?+NLGbpvEbV+o+R3IiJRSbqguAMsNfMC5dcNdA2+fIxZ3WmSMBCqxKWzvn+?=
 =?iso-8859-2?Q?cmSzUFMCG+IzKuXpUyZX6SvcnD3OcpSWu+UaoILg6iVM4eM0jvPOynQtmz?=
 =?iso-8859-2?Q?fH4dH45TrqOxU7v0dLg0oEcKtmvm8BZSSzLtX9pIDsOBaK9AY1/ctILZTG?=
 =?iso-8859-2?Q?G6QGagAIpe+tGDOb/x3iAYmc18j34NRx8bUiPVGrie0xUaYl6WpSy/eATI?=
 =?iso-8859-2?Q?YbAfsdnC4S4uhc2eBDTv4uKIdd1ee5lJa7nls0a4D+UBbyx/FLC60uABOJ?=
 =?iso-8859-2?Q?4VdGDx2KbiNMyuThFGKUXGsLJSEQuZx7WdWMndpCjyO0VI17pkTDb/0X5D?=
 =?iso-8859-2?Q?23vNrX3TtKywW85h3e9npxKVfPHghoqcf7dd8XMClNKzRCOAILZoX4VTr3?=
 =?iso-8859-2?Q?dPpI1KSOJdCT9Nyl/cviECBXCdzjcqq7oWDzse3IJAOfZUb8jPsSvWdu4l?=
 =?iso-8859-2?Q?BCT6acnbM0679fWxNIH76ucUbcg0YuxsXCN3Q5jZi0sbXV9qzA3OTmjKYe?=
 =?iso-8859-2?Q?xsVwrlJxXCHl1M4BJXweSXQEqTdafb+3UZHVXUcrIjb7PbVSqRryjwkeZF?=
 =?iso-8859-2?Q?bu7SXBv78a47fx0tt2r5bwtNkJ2d5M3e4IF1mdN8tki+I4WhehIvMtA3MR?=
 =?iso-8859-2?Q?wfAYyC3eCJMdaOIy9MQlgy1KbsEfnqZGz9mZbrsRdMlTtoeoLXQ04NgFh1?=
 =?iso-8859-2?Q?qIlY362+gHxF3wPRlR71yd484uYP3EP88hxQnAMJCZSb2GfxB7+b5Fc1RT?=
 =?iso-8859-2?Q?IvbmAg1+9kDMod7lMgDpN1hc08RYcVlapx?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?M3FkVvMmPdCWtFT4XdG4dlnlsmsu/l0EPfoGXeqaAG6z972Jk+w+/Olb7L?=
 =?iso-8859-2?Q?mhPRWLCRPF9sjtUfFMe45VaZnVeolRuR1nE1HURlb0sByPZp4amBw2GjhZ?=
 =?iso-8859-2?Q?5I/aYTsQTQVUwjWZDYNZsgP6V/OT0V/v0zA3ddZdtSoCQ9e7g7nLOgyjXY?=
 =?iso-8859-2?Q?Y16aTnnvAd0Iw3+9zMOBb8EjNiUT+xC0CAuveSzZf0fs39vMu87l4MmHqU?=
 =?iso-8859-2?Q?jBCmKotD6ZWm3jJZsi2+Tgal8w1Zc68lyUGIfcxHTIo9i+sDnpxMCn/i86?=
 =?iso-8859-2?Q?hE0z+HgG7pyCXOp61v3icSNmQsgnvxPA854ZF6NwIDp5vMGkXE5a7VVsAa?=
 =?iso-8859-2?Q?osCqTy3tr9ct5sglHD4CtfAaoxEiu3Zuub6S2zag5piHWK5cM+DsaYZFfM?=
 =?iso-8859-2?Q?ZYjwT3TN36wZIOi8aBZ9v7OCd1RvLNJ5nH8oec8nqRM4kykY0oGYMcDD5O?=
 =?iso-8859-2?Q?zjQQua2gqPixPTwIXoSKuWMydivG7cUzzBUtemMPNuwitTPrU+R1UblvHE?=
 =?iso-8859-2?Q?8jD3VaegNFav4fAvLrlCLpke9gAKjDDl+GC6KxNE+Hdb6Fg5dH3qAM6qMe?=
 =?iso-8859-2?Q?Expz1nEVf/jmRlJhhJcpDVbh6NkY7vxkW1lwbI3jPc+1yIMuAbqI/b3z/1?=
 =?iso-8859-2?Q?gVdwlHCi64Ml0rJxquiPwwSsDATS7SYn/hAMVNOfIkN0zuJAhqQFs/F66H?=
 =?iso-8859-2?Q?6rNg/F4laF/KekyVfHxY4OZ7rgL+Zr/ATY5ikEo8j8k0O1OKvL8ddIgp4y?=
 =?iso-8859-2?Q?/CeRS6HC5g+msJ+UoySXeKME0hTD3OL4N2hSy9wthdwRMLVG6puqtzzoLS?=
 =?iso-8859-2?Q?qwXYySO/gbnXPvdQkPHweDKvfkePG2raQj8E36bcn7dpRTCiLJCN+458uz?=
 =?iso-8859-2?Q?GaSW7AV8wQfKGnnbo+tK4+SuAw/Ux1Js08O9Yhn0buiNHV+JBauNmOEbbl?=
 =?iso-8859-2?Q?0CRAPoZUM5RWzl6Rr0uXMNwAKJ+UNhQo7YgOs2zLRI4CapJbNcZU8ABg1P?=
 =?iso-8859-2?Q?EvCoKbLMDZzvZEhU3m3BsUhDDX93nV+Z89dY7OSLNspAf+sAoe2/cLZB9O?=
 =?iso-8859-2?Q?rzoJ9FUJd8H63auQriGSmZJ/6ZVx1Lvv20H3kcSHkn0swkqOlMJPF8yt5z?=
 =?iso-8859-2?Q?Fy/aXcoBJt0yyKTWHrRrrDQSlNIukfx4aGo8zHD+eMD3Vs1kdc6ok/CI6k?=
 =?iso-8859-2?Q?6K/7J+PFN4berOg7phOxzBdpcUK+Fw+CLa4=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08655585-2f99-4f8d-1c67-08dbdc562c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 10:18:06.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeqUDxmuvUUYJZ+biQy/EU7PxmFUPK9AUW+zySALvTjEPGQ0Te7qmdlA0Xg/hFtjIeCofRv3/QXKxErmdJCc1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7475
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> During CQE error recovery, error-free data commands get requeued if there
> is any data left to transfer, but non-data commands are completed even
> though they have not been processed.  Requeue them instead.
>=20
> Note the only non-data command is cache flush, which would have resulted
> in a cache flush being lost if it was queued at the time of CQE recovery.
>=20
> Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/core/block.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 3a8f27c3e310..4a32b756b7d8 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1482,6 +1482,8 @@ static void mmc_blk_cqe_complete_rq(struct
> mmc_queue *mq, struct request *req)
>                         blk_mq_requeue_request(req, true);
>                 else
>                         __blk_mq_end_request(req, BLK_STS_OK);
> +       } else if (mq->in_recovery) {
> +               blk_mq_requeue_request(req, true);
>         } else {
>                 blk_mq_end_request(req, BLK_STS_OK);
>         }
> --
> 2.34.1

