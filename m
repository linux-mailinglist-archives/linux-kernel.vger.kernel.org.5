Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99081252F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443037AbjLNCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjLNCXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:23:08 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DA9E3;
        Wed, 13 Dec 2023 18:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZyHLr5N6prJ+fIcHr+O2PMLWCQReJD58TvMgQbvkUF8l/Q5qgPnlGtpijoIRDfOXgHKhzfY4EVCAHq3Kiqgdr36xZXpEDk2DY/voV4N9rrX1p26qV8yIuLvf08bst+Y1kI2fF2hvGHuhpmyn0GD9I2vE3ka/G4/HGvC8PISFRfJUwE6SlgL0ZHXPeHHUCZ71ghY5w3i9QUnmzoMRQJcnLzVuiFknJsz5oQsvq8K+4nwetvAfEyM86n/phu8sevZAM0upc7Bb5iqBwZTxhfXX6XsIxJrreMgH0rupaOhUyS1Wf7RQNcDnAn5BBxASf3LwVrxVOlnwOEKFRpu/BLhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otUApAgWFvsxeEfJsIOmQVoC5sAdxRyZZGkzriSFuQc=;
 b=BUHqTNgYOlC9fNmUSzZaQMWem9IFKf0C19s4Sf7Q/rY7VESD4oqJPx/On1xxsR9GlvXEZZkDjIEi6JJadj6t40CdC7oybx/fpyG8OCeJhxuU7Om3iVbAZLgU6eUW7PzPK8alpBBZ1s8bfNJrEET8lrb1WwkV1+uFo5DhRs3zgnNzmm9NYSOKCat8V1p/4f0Doq7bA03brV0j4j41ihrw/sqlucN3IlZhP/lmevWvDdXzAuIgiKZqmUJcIF4lrGRNGuNm82w3NOp0bt2UrRdSvwqag7+WN2ZT5Gn7warJ+raAsIkqlq7ORSdMRRNcp3TkngWAdY0bioS0iq+LiqFSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otUApAgWFvsxeEfJsIOmQVoC5sAdxRyZZGkzriSFuQc=;
 b=j0zibBq7d5iwi4WlDM+z185dh0/LxCBW8nDsmBWJISR8Q/utHPyFnAK2jcAvSlYVCYnaNjeckYpWYYMY47iKzQh4niUmlck3QzSZpq+sGUXTbPmug//GPbkimmWDDUA1yxPX4511qI4UtG9hcnBx/PyK4zvEgy43Qw/QNFjta8o=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9758.eurprd04.prod.outlook.com (2603:10a6:150:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 02:23:12 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 02:23:11 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Topic: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Thread-Index: AQHaKjAcb/i+pQpnHEy+2M8UmgtSVbCoEGkAgAADiBA=
Date:   Thu, 14 Dec 2023 02:22:57 +0000
Message-ID: <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
 <ZXpjjmD5Se7axJju@google.com>
In-Reply-To: <ZXpjjmD5Se7axJju@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB9758:EE_
x-ms-office365-filtering-correlation-id: f542afdb-eaa2-4bf8-d586-08dbfc4b9667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FazUFj4Gqo5T21DoBuS4k5zDxGl+RX7xS+NyZB5p5bUnckj9c/ur2FfuF/2NgcBw9u+WK7udePM8TQ7HeerBBmwwgamRfNOr9ZIhTTE7AiKnGB7Jrzb96re8d7XTuD3uitD5gdTFR36+bht35/0AcKFX60bRMr5ThQQCJsVfj3Ow2i1f3iMImEIsWnG/8MmB/rbZxXFa8boxvxDolU2HQcrxjUyQg8dgIY+q/CkAzfWFDc6LQoQluePWRlf5fRGdlgccr5i0FjJmCNS7Zy8oa00YQPtbBWVNSjmqRv0HyVQajvKG97kPClMi8I1vLhNe4PD5pfD3zHyUAv5mj+bIIAQWg0eB2wjSQDIKka6XWN1n2GMCVMPwFvkVin1e4d/Qe2QG9yutLT4cZS4WFP4PlqvprmTvgSYM75Hp+qtR6DN0uah+nIoLJExkUT2skAk2NzC4Eb6SolUM1mRXoFBb2VdveCVPUZZbb42r99BLSXi4KgGbQIW4UGsIOvvzGEAWC+LB/RxnBaAR8QUVwK19u1E+QjIt+1u7Cy1C4rVKF8NbaG6H0Njt5HlzBrymjfOOgbqAdyrF9C4uzt417S65/Bd4599plDKXFd8l/cETcWnd+/fJzgi+1/TTknuMu3DZlMhN7U6H/A5kdETsqJwcQRSZmbt4A7Sx5A3G7J+h79E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(122000001)(9686003)(83380400001)(38100700002)(8676002)(4326008)(8936002)(52536014)(26005)(316002)(2906002)(5660300002)(6916009)(71200400001)(41300700001)(6506007)(66556008)(66476007)(66446008)(7696005)(54906003)(6666004)(66946007)(76116006)(64756008)(478600001)(53546011)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRuI02T3D09X+C/onmQ0LpxNqtSiV/gh5cwWtuJN9o/Nu2rM2rw0OQfcNzTX?=
 =?us-ascii?Q?QNtlaWnos+kZatdN7+XkqrErsnxIpsI0lDoPU3bHin9r8u0HvKn60TLBIqhr?=
 =?us-ascii?Q?YSkcajU57dTwlyVIvF5mhiPZJ7QE+quxxdKAxtEvEfSqwDGsLnZmBVD8BihI?=
 =?us-ascii?Q?TZ5laVX/T03zIVr8E1OdA7LoAixjbd3udRsFLffna3AEyblNDtlQyT9gkeWc?=
 =?us-ascii?Q?XDPLo4dasj9WVgHheXNPBpoq+u6j1r//PKK/aWquY6l8MwyRzGWXWzhdHipR?=
 =?us-ascii?Q?jCjsmcEMUXfjbQQnloAhnoORTSMFnRm3tOotKehGtDSOlLNv1m5myhaAi/Wi?=
 =?us-ascii?Q?0XISITK7xlXd+LR4pvDh/zO/wLB3M/sJ1xtMxdZDDPAKeKK10PwcCoBnzGYi?=
 =?us-ascii?Q?mbRL2goWV+g+FH75FqzAnmJktTaz08/rXuLKE0G3VVyBrTEgYEdbMba6LKg6?=
 =?us-ascii?Q?OIfSrVXOqiL1fRy+1WPQ5HBKpyx+lbkUj5KybdiNjv2cDY/9ifDj0xJ+MI4I?=
 =?us-ascii?Q?14WwaR/HFLm7hYmFEAfhjCSCCzqfCH2B7UN3jUtL+xHdIslnmKP8fiLaIfZX?=
 =?us-ascii?Q?kwiNJa9Rp+OZ1ob8MQItNJyB8N2EUYawPa0ePt/gBKN3f5Z8pc2E7N51X9r8?=
 =?us-ascii?Q?lRXQsHrLHR0yOi72Hcs9gyxmGO8mdzb6OWWyqmpger0VwpoEiw5ZKzX7OUFl?=
 =?us-ascii?Q?1NbIJFj4WJa8wII3kVWkL+MVqQqp4GhZearoD8Zncud67szpa3ciYRJ0XnPn?=
 =?us-ascii?Q?WfYoruDJUaEpth+ey+QFFfOu1Imlcj+/Y7OT1BghIPLONSef9JV3iL6IymhP?=
 =?us-ascii?Q?ocYrJ6g4aT99SKVufzyoEH5l4jjl3S0qoEGCJpQSdmEX3fH1ZGvGdIeN4mbc?=
 =?us-ascii?Q?u1md3RFh8TJ4tLCbtjpFnx+Ikgjj41gB/zGzvD+TTcQDzs1B1jSSM5LUK21j?=
 =?us-ascii?Q?ecdsBw8dvSXFt3TpT6eocLS6qR9ZIEQ4Mzkx2L48gQ5ssAx/XhFxd/IDglmK?=
 =?us-ascii?Q?iQMaJ6RzRhKwr5uWah7hLbowxMdZBFL1q7anykHGwLW0l3wSpxj5aLPXo0p6?=
 =?us-ascii?Q?e5rZFy8cM2+EfKi3fDqAww9F3CVrWkK6ZdDdpXDWyv7B4DvVSjIw1mPJv3aG?=
 =?us-ascii?Q?2afoScJtcZu+xWf6avKHvN41TVn6kRUBCJV08El0IUbwzJMdpuKQpn+GEveF?=
 =?us-ascii?Q?MaWqRsNxwgtibaz+K4Jn0mI6yS9jvu/zJpzEs932kmIBSmg4ffSgb22uwQTc?=
 =?us-ascii?Q?dFMRm5wbS/ZrdCG2EdrAD2qeAfMuJ3/wW+iEkXhiICVVrsTV3thica3A56P9?=
 =?us-ascii?Q?HY7/Bs6f7dfhPFIcA/5B00t4dOCzSzPxG+5uKoxS4FbIfv2PCI0Cndp+ddng?=
 =?us-ascii?Q?nnZ6vF7/0R3z8r/qwZYVrt+BNM01BVUBRbiLWxOBUsXisr7Hnm9pzWP31NcQ?=
 =?us-ascii?Q?SRRqX4vecSPym+e76lFIhDy2HEHbbSOMTThDjlnTUtEzxobRyrWZBnAXIu6m?=
 =?us-ascii?Q?YQPTjABfJE7xP7TnKVR9XQm2BNMT8E8xiXXjlPTNbYzGZP0LG4j/aaR8L5OG?=
 =?us-ascii?Q?UAAHsavBvnpncaiz+vgXiu1gHoCcFT6v7qox/Gfx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f542afdb-eaa2-4bf8-d586-08dbfc4b9667
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:22:57.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIrvPgw2p2gfyXfJ/KYp+7WQwpm+36h7MHk6VFq8q5TDDBhi7/roiV4zSJ7QPOAcckgIC9v6211T8Pdo60vJSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, December 14, 2023 10:08 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; stable@vger.kernel.org
> Subject: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi,
>=20
> Nitpick: "fix STA cannot connect to AP" isn't the best commit message; th=
at
> could describe an enormous number of fixes. Maybe something more like
> "Configure BSSID consistently when starting AP"?

Thanks for your suggestion. I will change commit message as you suggested. =
Does it mean I should create another patch from v1?

>=20
> On Sat, Dec 09, 2023 at 07:41:27AM +0800, David Lin wrote:
> > AP BSSID configuration is missing at AP start.
> > Without this fix, FW returns STA interface MAC address after first init=
.
> > When hostapd restarts, it gets MAC address from netdev before driver
> > sets STA MAC to netdev again. Now MAC address between hostapd and
> net
> > interface are different causes STA cannot connect to AP.
> > After that MAC address of uap0 mlan0 become the same. And issue
> > disappears after following hostapd restart (another issue is AP/STA
> > MAC address become the same).
> > This patch fixes the issue cleanly.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap
> > handlers")
> > Cc: stable@vger.kernel.org
> >
> > ---
> >
> > v2:
> >    - v1 was a not finished patch that was send to the LKML by mistake
>=20
> Looks fine to me:
>=20
> Acked-by: Brian Norris <briannorris@chromium.org>
>=20
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
> >  drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
> >  drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
> >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
> >  4 files changed, 12 insertions(+)
>=20
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
>=20
> > @@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void
> *cmd_buf, u16 *param_size)
> >       int i;
> >       u16 cmd_size =3D *param_size;
> >
> > +     mac_tlv =3D (struct host_cmd_tlv_mac_addr *)tlv;
>=20
> Not directly related to this patch, but while you're expanding the size o=
f this
> command buffer: it always felt like a security-hole-in-waiting that none =
of
> these command producers do any kinds of bounds checking.
> We're just "lucky" that these function only generate contents of ~100 byt=
es at
> max, while MWIFIEX_SIZE_OF_CMD_BUFFER=3D2048. But, just add a few more
> user-space controlled TLV params, and boom, we'll have ourselves a nice
> little CVE.
>=20
> It probably wouldn't hurt to significantly write much of this driver, but=
 at a
> minimum, we could probably use a few checks like this:
>=20
>         cmd_size +=3D sizeof(struct host_cmd_tlv_mac_addr);
>         if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
>                 return -1;
>         // Only touch tlv *after* the bounds check.
>=20
> That doesn't need to block this patch, of course.
>=20
> Brian
>

I will modify the code for next patch.

David
=20
> > +     mac_tlv->header.type =3D
> cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
> > +     mac_tlv->header.len =3D cpu_to_le16(ETH_ALEN);
> > +     memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
> > +     cmd_size +=3D sizeof(struct host_cmd_tlyyv_mac_addr);
> > +     tlv +=3D sizeof(struct host_cmd_tlv_mac_addr);
> > +
> >       if (bss_cfg->ssid.ssid_len) {
> >               ssid =3D (struct host_cmd_tlv_ssid *)tlv;
> >               ssid->header.type =3D cpu_to_le16(TLV_TYPE_UAP_SSID);
> >
> > base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
> > --
> > 2.25.1
> >
