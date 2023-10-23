Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412FF7D286E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjJWCQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjJWCQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:16:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EC90;
        Sun, 22 Oct 2023 19:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtV+uRN8L0mvyHirgoZhgQz/hk/WAxjmrm7LQyBeKUJYhUu7uPtCvI0EiEhC9exExviWzgv7QZMfHzIGX7JlT6qdUyia41w3XYL4VnMtMiQhzWqJOeUHLDQagBw8lLZrlxvBie4ZO+HByUj8wOlnx3zyN2KAPGIWfhlc8naTSiMR9iS67zRPbb6dmmxwZSSQQK6vDF5Qs1Vf6Gf1vn28JMrn/ayaGRn9+foEMlJZDg6HlGuVGiqkGzgEKAqZq+0oDJsm9YccvlMFaNnQw9+BPlE3j7CRlHMD+zcAY2COKG2qOG75zG3LY/7UnaYrV0b+EZUXgDfc99jccmLzPNHgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o73vil6ujsJl4bhefLprgh7kGzJ7/gsVmctfLIjd6g=;
 b=KsigtOO8Y5qgzWSp7sYFlSzS1BTXylF6IBR5nbAvsGUIHxq5rdaYl+64AxuXC5671wdhWrL0GT8MlbJP5MeQqSrcqO8IjGjLjybSPJzswsRKceHWo9EleCkAho0/Ck1lkqnsnv/7PshL2OyHHVvh96d3SDEgDHVIXcyvaJB8oLdpXMRxyHfOMwL394H5af6vOmOV3yo/QEHgmDbryGGWPCri5MbMbCqm6K3tnESl/2iDqbYXctpnL6T3NzqJbZcWUPyTfydU3SpAt/HtG0msNK2ObTIR5USsSCW2bLr/aysVC9Dn2kpGl5HdTxIt80QUgs6ynSBmprrlOz7fUNzn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o73vil6ujsJl4bhefLprgh7kGzJ7/gsVmctfLIjd6g=;
 b=gunN7+msnTbLJPF5UMPpiwUGrIJM002MnqrQ66fLleZGuDjf2Hj9FcOsagYOFLWOHQ0/BvrY8VHd5pILYFxjjkh2+tW5CYf/a+PItJApyfxZ0UV01Oqu8y5tgr+2OrgCdU/Z5h6h6yCG7+WQpiEKdqaxVccLBOJkzJegF4JoGiM=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7411.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Mon, 23 Oct
 2023 02:16:26 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 02:16:26 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdoDCD3HfqdGXSjhR7u7/u1lbWxIUwBLzz6AAEfEgvA=
Date:   Mon, 23 Oct 2023 02:16:26 +0000
Message-ID: <PA4PR04MB9638E6859D64EF4FC4762C03D1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZTP1OXGExKCMk14D@livingston.pivistrello.it>
In-Reply-To: <ZTP1OXGExKCMk14D@livingston.pivistrello.it>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM8PR04MB7411:EE_
x-ms-office365-filtering-correlation-id: 034d9d63-62c7-4061-b0a7-08dbd36e0f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrOCQZIVqvcwT+TuYUDZ7MjClSppJlckUumv6n3lU0ikIer5LbWtHhNEWhwqkdWr7Zbb8QYrfgSKiybwBCLs9XXc1TSCJjPcSunao0E8twg3patshyyDkgZQcPDvRJ60PBl1wadgwhQEdmgxW5I7Iat30om8CvOWMSq7Rgt2TUIwpdNk9aVHVOCLZo0fje9XajCeNJOkw70VmE0N6YXmzO7aM3Z3ugzg0rilr9qooIk87M8pMtK0YcObAY6tyCp5jJnmyY4xpGUgUpjxYCkhHI1eTzNyUbwVYZSICjctJ5mE05Khsynl1OvbQ/N6webXg/6YsWSmSBfwgBIL1kZFzWbb5X4L6WlDWfqgR5lfv4dM4hbD4OrOU1XVFIvGTxh66xCSm5G/X7yXhfApGSFdAdSeZgnnkGQZGHRFy74dPElQ5mwxkQR/72fHy2Z+0bxcmaCJqJWttkFpq5EabD25Thsdi7V3LA6xPqrbjD9QUlvADDOzrSCid9fmwOWY39HmFN0p7t73PzNAlg9rbjyc9w6lagB3xl4Jjy8M+bHdacthRcgjjL9C55JJUwtGpdaiwrKHOudNcKlcD1p/WJ/MrNnLkowuK9Cbm7eHIRfh4eQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(38070700009)(38100700002)(2906002)(55016003)(41300700001)(86362001)(52536014)(5660300002)(8676002)(8936002)(4326008)(33656002)(7696005)(6506007)(478600001)(71200400001)(122000001)(66946007)(316002)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(6916009)(83380400001)(966005)(53546011)(45080400002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQo4ZBAnDvNOVzzAOivmqXIgrJLp+aCckbeESerMI0g9I+x/Omq4i0hZeCeO?=
 =?us-ascii?Q?eC4p8U4wPXHI2ixCtm52OdqD11xltEGjD2USUzRDy5rEpbr94G5vVMClAia4?=
 =?us-ascii?Q?62sZ1fWcwgZVjeaTlz6u4NPfmvU9D2Dn8NsZmkdLD5PF1IcaNHOo+zvfTqsj?=
 =?us-ascii?Q?EmH3ySNLGK2P0CrgxUyvD/gWzBGmcDPHMVUyAwr+NLT/YlabEWB8tNrlCSji?=
 =?us-ascii?Q?mVJ/mW/0gw+WfM4+fljh4A57AD+Z99jYLKyy+kq0RWFHBVRtbRteK1iiOFk4?=
 =?us-ascii?Q?IUWVKx9iXoJG506X/K+EVkm1Ja02sBV3hx9C52cdmfBjN08FGPsFigpGH7+/?=
 =?us-ascii?Q?RSEi2HDmFAhu6QbTmfuxa4CcCr3SWGolk2BWWZvmb4Q4F8qvNugj8F6O6M4M?=
 =?us-ascii?Q?rVyd0rgSbeqwzemy+gh7BxYdbZWd4Wt9nQc2X9IZBFm+4/WFuJawzI64xT8e?=
 =?us-ascii?Q?ubh8fWZ6RKiuK6POx4Zm+Q4g8JvhBpqCF1/iqynjzcM1iPKq11mx28bhMsK0?=
 =?us-ascii?Q?IDE2C4tF3UJv9ENvUvyyhljwHe86Om23YtyLqUFmj+hboyg212Zhf1+6VxUg?=
 =?us-ascii?Q?bCi0Zl4XXOLjpSPNZMYrpAl4TsWvvR5HnqR++NQHgqNS6Wc+YP18wWNTMrf8?=
 =?us-ascii?Q?XfVgG5RCaQm++PtL0efZ419ODr048SP+TNjA8s4s8rrwO+OcL6Lkq1gdl2VN?=
 =?us-ascii?Q?x85Onf68RvjpuuoVh027rjNmB3GGPT6hwMpZ8/eCpejnEXU/k7P5O8B/Ys9+?=
 =?us-ascii?Q?dCzINpAXdfMmaR2M1j09rqXjMfn8KrIAffX5z0KsEHwpbTtrxDEskUZfzvys?=
 =?us-ascii?Q?l5u8wuECZWG7FzHAk6Ev1oQTYBszBCo9Pc9vjsrAAyApNdowRisHRx64m1IU?=
 =?us-ascii?Q?0F9RuN0selFZJUmKp/2HClS2v8eNuDgctK9OC8L3aT5BnGR0eayHS0qHh+r0?=
 =?us-ascii?Q?qU89DvqvVa9AN4VzgMzbrM5CqS+/PU8eJViorOORzXj+4A2Hy4gPnnnkc+cz?=
 =?us-ascii?Q?0I0u6PiaMhxqIO+K2/xT/dfSnebltf5Ve3DU5e460Uc1Tm976rK4HYd823MC?=
 =?us-ascii?Q?sEfDgzB6Lx48v9dtgpmrxsxt3b1wz1gtvU2sBgG3EnqFB3I1KKuo8V3TL8lP?=
 =?us-ascii?Q?mHN0+b3DZwRgJen0x4Sjv5bOh1+TkT/64ZfUq/oqXBtRh7uOsuZ2egdpjeb7?=
 =?us-ascii?Q?6TwW3sLEBjYIBk6mxjD9N85V6HDorFVlkpfhN8DJ96SZs0UwxRsGZWeiz5JI?=
 =?us-ascii?Q?kKDOhKRzYR1fbOZ9lC6TbKXiv/v44BwA6CXi9EBWa6h9XRNOAGpAEqTxIEm9?=
 =?us-ascii?Q?13IXRsxSA/EpcIdbkcR+LQeDvqtqcwN3dWyOvBLrA25CmiOrzzIZJfJ0+aTk?=
 =?us-ascii?Q?BbDSCSBh6gXEPEkxC7k8pQQNp1dhUpuOYwqt05DS+58UlmWOzS1Qw8js47+E?=
 =?us-ascii?Q?zZ2jIjrDejeupVCSTKS5qk1lXJYaEaX9G4re6FAh4rxFECmYyWiL5LmecJpj?=
 =?us-ascii?Q?btDsbtlSEEP8K0sBCLG2hQzmPCwusCgxSKCbqtluTRqrDaZIBUsAqvqnvI4j?=
 =?us-ascii?Q?gny+Tuhw0S3rB9SeqEDaA4tEefK4foChn6/uaorh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d9d63-62c7-4061-b0a7-08dbd36e0f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 02:16:26.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cxo8llWpbnbkiQD32Dl52WmLrVr1k8PGmmw1WBYmecveHgFbaIMVuvrKC43bRf9UZHQhD+Tz8PLfW0yjX3RdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Saturday, October 21, 2023 11:59 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Sharvar=
i
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v6 1/6] wifi: mwifiex: added code to support ho=
st
> mlme.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Hello David,
> thanks for your patch.
>
> On Fri, Oct 20, 2023 at 03:48:11AM +0000, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. Firmware key api version 2 is needed for this feature.
> > 4. The code is only enabled and tested with IW416.
> > 5. This feature is disabled for other chips.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > ---
> >  .../net/wireless/marvell/mwifiex/cfg80211.c   | 327
> ++++++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  14 +-
> >  drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
> >  drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
> >  drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
> >  drivers/net/wireless/marvell/mwifiex/join.c   |  64 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
> >  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
> >  .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
> >  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
> >  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
> >  .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
> >  drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
> >  15 files changed, 582 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > index 7a15ea8072e6..40c39e4765f7 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> > @@ -57,6 +57,31 @@ ieee80211_iface_combination
> mwifiex_iface_comb_ap_sta_drcs =3D {
> >       .beacon_int_infra_match =3D true,
> >  };
> >
> > +struct mwifiex_ieee80211_mgmt {
> > +     __le16 frame_control;
> > +     __le16 duration;
> > +     u8 da[ETH_ALEN];
> > +     u8 sa[ETH_ALEN];
> > +     u8 bssid[ETH_ALEN];
> > +     __le16 seq_ctrl;
> > +     u8 addr4[ETH_ALEN];
> > +     union {
> > +             struct {
> > +                     __le16 auth_alg;
> > +                     __le16 auth_transaction;
> > +                     __le16 status_code;
> > +                     /* possibly followed by Challenge text */
> > +                     u8 variable[];
> > +             } __packed auth;
> > +             struct {
> > +                     __le16 capab_info;
> > +                     __le16 listen_interval;
> > +                     /* followed by SSID and Supported rates */
> > +                     u8 variable[];
> > +             } __packed assoc_req;
> > +     } u;
> > +} __pack;
>
> I noticed that you ignored some (all?) of my feedback [1].
>
> Maybe my feedback got lost between the quotes, maybe you just forgot to
> apply it. Please go back to the previous discussion and either implement =
all
> requested changes or keep discussing them.
>

I think I replied your request and follow it. Please check following link:

https://patchwork.kernel.org/project/linux-wireless/patch/PA4PR04MB9638DEFC=
074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com/

Please press "Series:   | expand", you will find cover letter with related =
patches there. You can review any commit and reply the e-mail separately. T=
hanks.

> Francesco
>
> [1]
> https://lore.kern/
> el.org%2Fall%2FZRLsuJfxuvFk1K16%40francesco-nb.int.toradex.com%2F&data=3D
> 05%7C01%7Cyu-hao.lin%40nxp.com%7C60169d7a09b1452f396708dbd24e9e7
> 2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383350073303695
> 20%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DcBRFymTJojjf
> Kp%2F42K%2FWue8ctA1mTdIOqGjtgiHx%2Bsg%3D&reserved=3D0
