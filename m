Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB17F3B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbjKVCB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKVCBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:01:54 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E3DD;
        Tue, 21 Nov 2023 18:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUFcl0msdoJjHXFdE8Ll1sqV6ssPZdPe7tuy+FzgAqH7LMLhSdwnw90uAJWpU4Fe6JTChzqZk930kEDnsjjJC4Pq1dBYzBD900iB20ZyM/HaumGusQNQnZgbXJO1RV9KiB7SsVfxBs+IAjcX7Ch6iByP9X3K9r6JIYVnMfLIZuZe3ToldIFfVJmcg9p0zG2JlB4RSj2CRv289Sv3xM1G51jxDcvKl1BsFoqCAdk0bn4Ax3KdfswnDaIHnEDQo051DOQ4/8eVfTpMx8GFLlRD4kDnsOtYjxx4lvtCtNM0qbhpV+8Gd6s+jR9KISjBFADCxAsHBpMvOf6CAaRdX4u4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4mMQRsfDom1vtINLow1rcwNUGNPOqtO3EwaszgaU/0=;
 b=KdGt6l4WZ+7Xqfcx6lHOHnOt5es3R+nF5EV8jXGs88uufn7BoE9vEeceDih6irUsGXvCJKioFo3Ulo1KpH8hSGCvwrxCzWHmXJtXsmfzlhZXrkHGVddzpC9UJwlyvnvrNsOsD1wz1a3Uu6+FBWkeZdKGwSnyi/fKyWP4tiyIV2vGYzLVGGGpiNeFb0XqnlErIVJtV5THlgX5vIJ5WUV8xBFpW1UupKFGDzpAcwvdZxT2+icFrOsLQZuIDh8EQ2nFPYig1nGhS33pqSuz8zvXdocYIx1/f+DdRDspUBRFOUhEqMey/Hux31yX267IBznXeO33O5NIx6J9AL2Lv8jAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4mMQRsfDom1vtINLow1rcwNUGNPOqtO3EwaszgaU/0=;
 b=OapWnM4hEaIZ7bWJe1srZ4/VmnAN8jMqwRE/d9qKJ7NT1+c2/Ntyt1hVpIaFmCUooAk3rEQKR2v86zi4QM+3zwEdaqVMh8zVQ7yO2osbpBzimk5Hc85oa4eMfnsS45iTl/AROdY5qJ6UKiNOLnQCYgF1aJmiv4PRFrBIdGAfjs8=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by TYZPR02MB4957.apcprd02.prod.outlook.com (2603:1096:400:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 02:01:46 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 02:01:45 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     Johan Hovold <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: Adoc59aTjxxtKq9cRWaHZUODs9wnvQ==
Date:   Wed, 22 Nov 2023 02:01:45 +0000
Message-ID: <TYZPR02MB5088F10A6C02CF08C1A02B0189BAA@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|TYZPR02MB4957:EE_
x-ms-office365-filtering-correlation-id: 580d218f-2aa8-4c79-f456-08dbeafefae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8V+R5AzIvcUazbqJdIItf+Yk0TM8wwet77HkS1WooZGSTpRTVTRWydC99Zi1Mzdy4HUnxSCjWKIn/F4BSZVXySyp7gxfWUxxfgrGP7TSsJmDvQ3Ogv32PSTJzRGooebuurqs6anrK0NgHnHZRwjPHaB4+ySfCb1mFgUNGt24EZHAvdNFoNmPbV3I0aBd4Vf/dwoLDNS1GY0T4FgFxo6DTQdr3dj8i9h5EGfpVtrCe9vY5Nyb7KztFsybLLrxhEV9lVGmicnJL8E3TZWUmf7hUH82aXpmhCmx54E0pPZkNqguGd+C2v73cD9zP9lwOIfLnrJli+83NvmoQfShyVtm6FlK8LGQvubZzjoSf2MDear6aPlJSSR0ikmPHOUcYolsjC3dqSDIuRzqCdMEtuwOBixlMDPCCuHds3DWeBjHtRF/2REt1+Np7ltHX7Jrui08SyihluZsm7o23U1MAKDkd4pqtwrQLJJgz1tLdZTA3aZ68dlmFPbkxS9im3DEYA26C/X43gI0VP0tsMnS/KY6wqhUYzqoaG2QX2h0p9FSoi3GDZUtAARmu8A4PUd6hcW4TaRJNHHs3HcxS7VltmdAtzpbVJY+RqXAaQfqu+u6Z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(55016003)(8936002)(41300700001)(4326008)(8676002)(52536014)(5660300002)(316002)(6916009)(64756008)(66556008)(66946007)(54906003)(66446008)(76116006)(66476007)(86362001)(966005)(26005)(71200400001)(9686003)(38070700009)(6506007)(122000001)(33656002)(558084003)(478600001)(83380400001)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o5hkUVq5tQYGSY9Ab17qP4FIkrbGLPfm5TgWpCGeFDjxwsa9LRyp3cNQOMHp?=
 =?us-ascii?Q?qi+j5qxXBokdNvQGYWStSKo9XWzZ2Evs44RQUvlaLc5jWymZrStB9VM8vqfH?=
 =?us-ascii?Q?qynDwLfrZ5gekZ+dJuPy8DFioFy5pD07ELgT6tmpyXIsnGSn7BBM/3qDZcfh?=
 =?us-ascii?Q?/n++v5tA+zyUCRmb5+mNoKI9ebx6V/oDp155j3L7zboyd4cEAgA2ILr5iubY?=
 =?us-ascii?Q?MHIeJxutWIQlAQGnpO4ElUgiPx88Wc60XUa4gphGxohG6ODPPTlfVYJrYYF4?=
 =?us-ascii?Q?OfdNLdXWmsvQjmGhN+o4lAk37Pd+iSzOgPoH3H2AdhScyCT0FPytzW+36ZuS?=
 =?us-ascii?Q?msy0hgnnXi+zFYXxtWss2cCDJ6lsOkwTXBWLZtLe1XAXECXYMGZWbEgKFkEu?=
 =?us-ascii?Q?MWygPsbSoqdA4qzzMOFKDxXdTfAqyxDsCwJQgfrNs/aXZJZ1JFaVDmH3Ywuc?=
 =?us-ascii?Q?dCfP2fU3G6GT4GfcJCuuFaTH+/wryDs/0eTrzbUzGrT+RhCUl5UZPZ0+nn+F?=
 =?us-ascii?Q?8ecU1Cz8csY2ihDt7dTqaRSesZQjRk0nA6bRS9/DW27Nehz07v7Un4O4BD2D?=
 =?us-ascii?Q?9FHMWwO2iXjl8hTBlkIjb06bEKfz25U3qHY6CkSue+alsPP2QFPT+kgouDzz?=
 =?us-ascii?Q?2/PV4w53yRvit4AMZwtIGu/bUzhs/kf1sba5vQ42KWz3swFDsRmYRnRx2gFb?=
 =?us-ascii?Q?dvEVzY8fWz2+IJV7kMFAvH104GeKWk4Dmo0qVFscMphlVC4FzezdwYk7J2V/?=
 =?us-ascii?Q?DDB1IrOnVZb0y2EJvM5Dqw8J34UAqdzgKtqKBxW5Neru3/0nHkPd8DpCQoUM?=
 =?us-ascii?Q?kyrDVm836BXrIVUXkXTSjBIgLBaXxfkJ6U71EEox/7JSSkRhzv7TZDDi3HxR?=
 =?us-ascii?Q?tOXy1o/y54EVQ1DEGgXfYx37uS2PwqDxwoFz8eYc2E1Hfzs+IgTG7pDsXO2B?=
 =?us-ascii?Q?+TjqwSX7LrB7r0YLMkkmfoY0hlL7SYkA+LFSD/jFRRAu6lvXMzlNtjuPGblB?=
 =?us-ascii?Q?m71H1srVg/bTSbfURpfyYHM3R5m8ichwkHG0qgxBaaNZgG3eKWUjqJ+9EIWv?=
 =?us-ascii?Q?PrLqBLUTmiecjb1VsP9zbas8fWynqHZeeUnVhXeYgwMIGwl7RwnjTLlnC7+T?=
 =?us-ascii?Q?XT737iKuSWvcpyypDe7AuZ0X/odjTL8eUsq51970oqO0Y/lmyRpdvwHQvbol?=
 =?us-ascii?Q?JNR9MY1fmQ1EfPuO52jBDTukxMBvRpBRbnZ1GYolDT6JxIQNrRIbJJSoXsm/?=
 =?us-ascii?Q?DuuYrAihJ2sOlNh7z28uN0gla4NU7eE+inAZLlKT1AV0Fu4yTIcEiMbY8Mtp?=
 =?us-ascii?Q?Yn/Uiu3gaQZam+AcxAEYXlUjYeKVnmbuSbci1vxgwKMrGhuxi2GA8lV8rz9g?=
 =?us-ascii?Q?UzqDMBAwXLboQhFwgxSMj0PpXs/Wlm+BNqXVCPUDlH00T0K8nwDS3sfSq0WL?=
 =?us-ascii?Q?wkmDxstaRhjMAzByyg4OSmgHkiLY6oFN3U69saV4hXJuNcrreSNss8enELq0?=
 =?us-ascii?Q?YA4YNc06vIyAod9IEW2B10KBHOCagVQqQD57PFjYO73SD92oCG+2wAKZMhlk?=
 =?us-ascii?Q?gAVibZX3P8DcUsozFbeDOQWS0b1A+gjtssa98d37?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580d218f-2aa8-4c79-f456-08dbeafefae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 02:01:45.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkCdhUm/RS8U+KFkRLfYbmAXgFZtwc6hYzJj8ZDePFk9GanM/+nfurtNZeZo3pAPdkI5oOENH9BR4vXOyUF2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4957
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Now applied with a slightly updated commit message:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/com=
mit/?h=3Dusb-linus&id=3Da1092619dd28ac0fcf23016160a2fdccd98ef935

Thank you very much.

