Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91867DA93C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjJ1UK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:10:58 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020002.outbound.protection.outlook.com [52.101.61.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39970D6;
        Sat, 28 Oct 2023 13:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRAJ4ZZJztNX2gunnXQiwi51v+80BWfhqYVvDF8W5nNjvtuY8rwcYt8S2cCxYXUnBcmO8aDaQhZ+gokF09fUE2nwnlOxPTSCN7yGTTuxeY6duDPwDf71IIBpSCJpfHoBkgkkIOQ0KprMWRelvV7U5aNlL1/hIPzyPcPAZrEXvM3a5EnqXhv+EHUunDfbrEEnpeYbNcBjaNpE4RPLh+jrCz9rvdkn4tDmEtb2cOpjCrwS+uv3DtTEMNPaEillgxPfIm3UfEGodm+A/AjMCUwnkLNcA3k35hYGbRqK/txHgneyT9lB9GA9zIbP6vIq2Gkv8NQeSBN+GXiyBql6t+D0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAxaH+C/atGAZ/4bE2JC1CEluGL0FTddxhIxSSKsA2g=;
 b=MVBvFakVvO5LEpqErRvNzdJDtRjajJx6kO/OygPvTq7Xw6QjIudsxQyld9noZlg6eMt/hDJZH7c87ctsx2xxESuf/rfpnwS2qZGy8DQJGXfN2NZiKwYiOBSQkBthIoJtEYGUjvLHhNENMG+ouRep9HM4eX/kKtfKsdmkiiXl2emB2DJ2xxdyUDkD7l15n/snO6c1qcWMnwQZlhH9XSjs6P3ooOzMV1M2PGGe7SOpNayKc7IRhyLSsoExkxdDIrPQVRXmISUwO1kEhdymx+oieQQ2QkW3UgD0gofhdmWD7BS4nJh7Gw/kw/r++k1iYC57mLO16VagLfWsx04LuVrhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAxaH+C/atGAZ/4bE2JC1CEluGL0FTddxhIxSSKsA2g=;
 b=bQKF0BIiZRs2cXsoG50EDFUuuK7IDQ2z6Xiga5+182K5icjJWtEiHjx1it5MYssVPibM+SAx5U1x+sDyzdH65XCD4Nk0IhyJlGZoQ22xr0kUoLbgZBEaQNB441OlW8fRcuza+C/vsl8L/U1inpBnOxFrOZQVIzz1l34yNVJJJK8=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by DM4PR21MB3754.namprd21.prod.outlook.com
 (2603:10b6:8:a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Sat, 28 Oct
 2023 20:10:52 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::9ec1:1d74:55ab:f67a]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::9ec1:1d74:55ab:f67a%4]) with mapi id 15.20.6954.012; Sat, 28 Oct 2023
 20:10:52 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Nischala Yelchuri <Nischala.Yelchuri@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
Thread-Topic: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
Thread-Index: AQHaBm1F5Iw4pphf3EmudYnEmejGXLBfpSNQ
Date:   Sat, 28 Oct 2023 20:10:51 +0000
Message-ID: <SN6PR2101MB16937C421EA9CDF373835360D7A3A@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
In-Reply-To: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eb796e71-0ae8-4313-aa5f-f20ecb0d7941;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-28T19:57:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|DM4PR21MB3754:EE_
x-ms-office365-filtering-correlation-id: d49f054a-e76f-4a1f-c49e-08dbd7f1fc2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +I2pa+F6nvrsW5KpKpAnK/2z+0j0jy7i7dZ4jcWrWPhI2pi6KKzrWsvHO564KM3g2tIuPfmIslCOPyDE0fZ7Loaene/cf8W2Yvur5fIYxUFUhvmH+t2Y7rx7OrBLtD9rifO/aZWv2KvnRFeq94BxBOi52XGihBhFZIYXZVJJg+Xf11FbE7HA/HT/2dxi7ppxKjgkwiNJuIlD1AXCsuIuA9qy4do2PYGC/Vhrh4++Y0v/rlDXeyM0FEVij3NhNK2FKiNLcWYTNywbDQ+0hZQSZYeL6sbIZohMnATk4/H7kK4YOkvPr9t/SEQWfs55wQ3+Xj7e+wl/dFV6iTpnUPLPvYpRIw855SI+rWR8nBRiqxn3outyufi/RsHbg9HkKWpIAtut+UK8igPTyDZMN8juyCuYmF/Te47RFjnii1+wUMipE/heOh7bIUWP11TMbXMPs8dXrZmD81iaHbMdaFRPt5V1ePvOhsY6XkI2g6nx4ofBp8dLIhldzGNmY3Jqhwor8FmmDKDjKRdb0Kus6BfnUc62daO4XdTridHGj3Rg8bXF5zPm/gKI5RlwnPiYcYTgZmlKhIHp1//bAoG8Ce+5c8xIHNQKD3zH1BMe2rHfNKmcbjXtp8g5kRLR8gAR+/pXDAocKLgDLpk5et0RGfBsS8a81wB6T7ElrcWOREmx70fmUniFEO6uRVuGWLTatajB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(33656002)(55016003)(71200400001)(83380400001)(6506007)(478600001)(10290500003)(2906002)(8990500004)(26005)(9686003)(41300700001)(5660300002)(316002)(8676002)(4326008)(8936002)(52536014)(38070700009)(54906003)(6636002)(64756008)(66446008)(66476007)(110136005)(921008)(7696005)(82960400001)(66946007)(66556008)(76116006)(122000001)(7416002)(38100700002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tiHGeb1RwTldVFHw8TFVlUs6artpOTp0/dYS/T+PQ68oskXSzVxOjm8FesX1?=
 =?us-ascii?Q?4vJhTAqup2hEtjSNUIcILAtWdYHMqSdf5wo08nXtYSeFHjiiMklMlI5zNdEZ?=
 =?us-ascii?Q?nQnUoEWJH8zy2+eVgTivPeB0O0QMvaBUyF5RpxuojomSUMDPAe2PZCjULecO?=
 =?us-ascii?Q?YzEB208OnE68IEQZpUDcPl6Ljg0DY0jz58mczSjxb1cO/geRFQOd2PaX9LBy?=
 =?us-ascii?Q?q0hGBSIAqB9lRY2IuSJeA3d9/KyU+qDp399o2+c8r0h3e8UGpnFp+p4VwXs0?=
 =?us-ascii?Q?KCfOBsAO9/bKMOtW388mE83n7pWrc/EjMQPE2JqLn7xWNu8FFdCi4H4qlSPQ?=
 =?us-ascii?Q?gqoKjADCiZziBuLe0ik4DP1dhLDV2/91oc305PC4KFnb2ylST3A2B+ONKEvl?=
 =?us-ascii?Q?j1wnCizXrxWXQw60dB2P6WIgiOU1+vWVzhH+U5MIPi/spPNI0uo/YvKi3BBE?=
 =?us-ascii?Q?7sYSZNUKb0tpm2NaSS80b3JfpZumF8x+T5g+psvcyn2MDDkmtoKWi1vYV8fe?=
 =?us-ascii?Q?dqNb9rNwOvEZA/0cs++v3G2qAu5jOuzxLb+ZP71SmJGv/EOd3/U865C1Upxl?=
 =?us-ascii?Q?5PhPhrMeMcb/NuW1gPmh2R4lPOoRbjKZHZYsU1AZN+fCDR2L82PtLlTt1q7f?=
 =?us-ascii?Q?4R348T6xLqKGzmrJCkxEbXZVc0AxacP1lyejG7BAwUraRB4HDodoiOsB3ZLf?=
 =?us-ascii?Q?q8KxEx3ORAHpm4PRwsvGdBEoObsQ2nuBWK4szODWcBkzeYEtr9We1Uw6ayq8?=
 =?us-ascii?Q?ZXde4H+8peX+AImKkeBbHKlRCxx4izmfrAwXoRAY4dDI4g8z7hq//fdeX1iL?=
 =?us-ascii?Q?WxC3bjp/A/WHck49H1CRWqKaX5Q/qR9tFd0etEG0zTQzXVZ8aogRSly85s6s?=
 =?us-ascii?Q?BxoB4oBVG4n4VAHIZ1iM/SPfyLdFrvAu+IpelQv6UF9RU0QsKGj8RuotOWjE?=
 =?us-ascii?Q?0oSdy7Zevaxhci+4gy4/h6OaF5KEpnftCOzIFoc46QqP6Nywrr0y3myQFTEX?=
 =?us-ascii?Q?Vz4XfhzMirT9TiDRGLpBPRKyiwdZMGNhq7RZMO8NYHH0Or4r6nIRWflBhcKk?=
 =?us-ascii?Q?hrrkst2z6yxvFSkYDfs9Rk66NbCKYJUGqvldXXFryEsQJw+cX50vfBkt5HHL?=
 =?us-ascii?Q?1xLmELlf+jvkQvRTk9eCr6TSi+s2wISEaIZYD8Ht9A1ETlkj7u2UbzpSWxGB?=
 =?us-ascii?Q?VTsTnxCbRnfYQtO0wh/tNOX14S8TLswI1Q44pZ4xwlgm1qILYPSVnO4EKwTc?=
 =?us-ascii?Q?t6wz41TOETuxF8NfPt3rL977bdSiyhSGOUcO0JU1LWeoBlT/1HBUkW0zazbt?=
 =?us-ascii?Q?nofWBgwpbxF5x/Nw9eRCMGlwdRlvgPrj4K69jWstCTQbsIvxobKs9hGifZoE?=
 =?us-ascii?Q?SnlBFSsiwbaUdFoMgSkw+0VkerAST9KJhTU8UgwZE/++fCKzGrScihUyEn3H?=
 =?us-ascii?Q?f9VGwnEn2ot5yepBk9iwV+/R7Eg/YhnYeS8ad5DpG+BXbmYJXfloEvlqHcTG?=
 =?us-ascii?Q?5dwf+YLsbJQ0Y96NxLk6LkIYgx+Ipdc8saw7kTt59MwRVPgD0DE3m2scWwbl?=
 =?us-ascii?Q?ZRJ/AYnIvy5YWbCa5dDI6IHDYXqOcg9uz2BGq2CC48safe1Ith0LcV1MtQ82?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49f054a-e76f-4a1f-c49e-08dbd7f1fc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 20:10:52.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUrJCbESqBeR4Wn2pRpBfOI9IT/98y/vtMg0RRDlBL6rnMhwjh4uIOO/sxPPe0d7E1FioY9UXUvhHCtdh4kh5vwZ7ZIDGpEY2LOaOPnmmjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3754
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Singh <singhabhinav9051571833@gmail.com> Sent: Tuesday, Octob=
er 24, 2023 4:29 AM
>=20

Subject lines usually have a prefix to indicate the area of the kernel
the patch is for.   We're not always super consistent with the prefixes,=20
but you can look at the commit log for a file to see what is
typically used.  In this case, the prefix is usually "x86/hyperv:"

>
> This patch fixes sparse complaining about the removal of __iomem address
> space when casting the return value of this function ioremap_cache(...)
> from `void __ioremap*` to `void*`.

Should avoid wording like "this patch" in commit messages.  See
the commit message guidelines in the "Describe your changes"
section of Documentation/process/submitting-patches.rst.  A
better approach is to just state the problem:  "Sparse complains
about the removal .....".  Then describe the fix.  Also avoid=20
pronouns like "I" or "you".

>=20
> I think there are two way of fixing it, first one is changing the
> datatype of variable `ghcb_va` from `void*` to `void __iomem*` .
> Second way of fixing it is using the memremap(...) which is
> done in this patch.
>=20
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>  arch/x86/hyperv/hv_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 21556ad87f4b..c14161add274 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -70,7 +70,7 @@ static int hyperv_init_ghcb(void)
>=20
>  	/* Mask out vTOM bit. ioremap_cache() maps decrypted */

This comment mentions ioremap_cache().  Since you are changing
to use memremap() instead, the comment should be updated to
match.

>             ghcb_gpa &=3D ~ms_hyperv.shared_gpa_boundary;
> -           ghcb_va =3D (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE)=
;
> +          ghcb_va =3D memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB);

As noted in the comment, ioremap_cache() provides a mapping that
accesses the memory as decrypted.  To be equivalent, the call to
memremap() should include the MEMREMAP_DEC flag so that it
also is assured of producing a decrypted mapping.

Also, corresponding to the current ioremap_cache() call here,
there's an iounmap() call in hv_cpu_die().   To maintain proper
pairing, that iounmap() call should be changed to memunmap().

It turns out there are other occurrences of this same pattern in
Hyper-V specific code in the Linux kernel.  See hv_synic_enable_regs(),
for example.   Did "sparse" flag the same problem in those
occurrences?  It turns out that Nischala Yelchuri at Microsoft is
concurrently working on fixing this occurrence as well as the
others we know about in Hyper-V specific code.

Michael

>=20
> --
> 2.39.2

