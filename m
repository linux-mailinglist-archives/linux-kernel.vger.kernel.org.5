Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6AD8016E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441836AbjLAWwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:52:31 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98B1712;
        Fri,  1 Dec 2023 14:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHgWe3G3b4Ew2t0j4+1R4QWPAP1zPH8dKiTMJnDLmjactTTToV9MxH+bT32ma7nViCOJQtYsaR1+sZGfxO5tJP1fVh1tLXctaqtyNefBVMIPNCwrXYtYPMs/J1Eg2+NtpYiwhlMG1d2Wd2e4QpQY6OZudrZJCRrETMCwSkwAH8BK2XVKi/ydII4vyuEdsqj2Fi8hg9KZsuFnnhkiLVJssHFcHcsQN7WvyWP6ZVdBOZ84qgwUtbhBQgUae//ozGNReCeWmrmUKr10DoiCZBK7RVRkI2uosHWtsfxFga9oL3VStLBx5UekgoCxTpVmsHvJMLcI3fGs5NwxMik0+BoPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kZPJK1KncXMxnNdzGwTfrL7W1VGsKYJavNC0XGRelM=;
 b=IdCJym4okJyKq/hfHXWnBgA2wNbKSb6/R5E62ACi3h0uCz++PlX2mImI2kRRkrS7qbvyTjqUfMTU0gMnM1lpMMXMi9MDaHdWMQM4ppMrRpQzzf0ffRqv1OBuVn0MhpTmYFBeuEww5h1k1wRDm0mPRFktZAzAd1vQlEa0TpszUu8fmidYtmaBvibLv+ETcIUE5TSJVtdfPhrbZ43LanUEjOUC0tVdPr91dL6sXFF7+XVKmEUz/bVemKofXn9h+N7zQAUqwt7vKekh/Eydjf7u81kuSsyVXWgq4Flb1MJcqK8z2U1kH6l4LvJv+PB2T73O7DOgflHPuX2Rx/VCypkNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kZPJK1KncXMxnNdzGwTfrL7W1VGsKYJavNC0XGRelM=;
 b=rL6r3Tf+G1Tl5eJQqbUhFhrfMHB/Yu8ofW7YCE8YsjUObGHZL0aePPSvAF3+n8OR5AtimaoDzY+e0EpzOuwENLisbDr80kLy3J68iq3jkS951w6MPeR4dSZxKTWzV0MPKsdlSMxgMtxTmvR7elUerKITpZHQlftOgQxtM8uevXY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 22:52:34 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 22:52:34 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 07/12] wifi: mwifiex: fixed TLV error for
 station add cmd.
Thread-Topic: [EXT] Re: [PATCH v7 07/12] wifi: mwifiex: fixed TLV error for
 station add cmd.
Thread-Index: AQHaIdVdMu8RyyAG70Cq3kEYh+tgZLCUQOMAgADNL9A=
Date:   Fri, 1 Dec 2023 22:52:34 +0000
Message-ID: <PA4PR04MB96386CC1D8AE6475E0C2541DD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-8-yu-hao.lin@nxp.com>
 <ZWm3PPilLWbxNrRr@francesco-nb.int.toradex.com>
In-Reply-To: <ZWm3PPilLWbxNrRr@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB9PR04MB8218:EE_
x-ms-office365-filtering-correlation-id: 6f0bdbad-2773-4897-db9c-08dbf2c03577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbK+nF4V+iDthdkKoRk6CBS9fN7fGxBhqkALPtBfg8QRs1epIaPBjFlvBlvhPGjnU9lEBes+OJGFgv+eq4nOxQJCOQFoIvIWXnL09H1YnVVwou21CQGY39FXcRgKjV9GVla1JmK+mTYbWMu2YbAad+axQoHJr3S0TniidKTrfyY2Sak17ig9Za/OD+lez6AdB8Tx1K867YJY3Pp6Aap/xkX9PHsyFZbzEsoPm1XSLXkh+2XnWHN4ftiWaxbZQ5xOcweHAaQxLk0oadFxGJy7kq8t06iCCPUFZinjVpCNpBGRfGkpv6Iujcyd/0gNxUL4tWw5050qeKS3QnbHcqHvw0lQDpsNL8je5rj7YefVSxhhDDI+HL3LGsvm82EmI2bbVEq8A0O5v+yP0a5lizpLOLwsjr1Bc7wv3eUzD1YO7pxI87rG1AAOYF5fdCU3oDHdJA9XjsuqrmX8iPqsqk3NhmUHxIGrYBHI+MQttwvWhvb56FM1xoEuVVaXlSAfrDzqZk/Iug5GnUoAROkGBQLqZVvbswyDyGnlWkGdVOizWiBSTyqdJznbuZjXYmmtGgTnJGf9Q1K20o9zck/cse+l64W3v1Hpf+3jV5zT8zCcEIZJ7met81SBaH3moz5ENwg8UlzMHqM5m+JM3co/9mv3FdNrLi14mMq+Mpkyd9uUMNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(33656002)(41300700001)(54906003)(66556008)(66946007)(64756008)(76116006)(66446008)(83380400001)(6916009)(66476007)(4326008)(38100700002)(478600001)(8676002)(52536014)(2906002)(5660300002)(316002)(55016003)(86362001)(8936002)(71200400001)(53546011)(7696005)(6506007)(9686003)(26005)(38070700009)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zhrNhWL/7RbE3soTxw65wwR3zcy3Yg8w7blFsF6khMpcQs3zTeNTl+6gXCHr?=
 =?us-ascii?Q?oMFJCkdUuUXpUYtlMg7KvlRGi2W2cd+q7TnCuTAHlmQv/W4c4HjSPgXv7lOX?=
 =?us-ascii?Q?k9BlpzDig4bi4w1NnulTbhhkerCIDLTSfEu6TEgKh0mlvydVA0kXQvv5K7jq?=
 =?us-ascii?Q?nWH3ZDjVpEABu3MoLAaqel+TCh3T7k+OS4K3atVT55cHp1RaKEIKtQQeLsuS?=
 =?us-ascii?Q?+2snNZZ630YPsrCCKkFjfZdo9oKfUYr0iFVZaLxyq/CZ343WVrexVEvZJjTh?=
 =?us-ascii?Q?dIXQEC7xTAm4g4g9LVhzszTVkJ9zgm8szGv514z9szm6OfieW7/UEhffHVDr?=
 =?us-ascii?Q?5lHLIoDIc12habrCXAy2Cj6PyamEnAI35efVHSBSXBWARgp1P4aDb/Kok73e?=
 =?us-ascii?Q?a/NxksKyzf6d90vM0qKnhby0s1U6ZJutFlFejd4gtwc1XjpVMVCNzY6eh0kX?=
 =?us-ascii?Q?Eeha3KVF1Y7wXfYwSAaqBT7CNuw5kjXZ28fZirywUqWNsEZPWcvVB3dU8JfE?=
 =?us-ascii?Q?0JLJqqZ1RrmgfgQXK8Uk9yTm6Db/blCBzMalQTyayJcgwH2Lg3STKINP7KIa?=
 =?us-ascii?Q?qOgqLIGKsHmx1dtZXO2N1tddeezONB9WUQKYjJoiW5pIcaN35++48t/zPErd?=
 =?us-ascii?Q?bSVJ18eE8vZgrmC5CNitKNvW0he7FczZS15/UyIjGw/LVEaXC1ASxZGoawbk?=
 =?us-ascii?Q?sz52KY4wmfe2wbFOfZhUkNACQNA4wIQm+wK0Gb5/3gB8u0rAh3aZfqy+Upm/?=
 =?us-ascii?Q?LAOnhydZLRNqekhTkuSBaJqn3Hl8nKrjKHFQRebgNhnXt2mKQ2oPmwO6IY6D?=
 =?us-ascii?Q?n842uZGQwsWO1EwmIJxP3/rWDL+EVpOSubI9TfNXF7TItInzfreVpHo2KIEv?=
 =?us-ascii?Q?WRYgNYJCvMla/rT6J+C5PoubbUWGDO2jdRJFYtB7g+FHAVuF6torLKDLCloZ?=
 =?us-ascii?Q?22FVHoT/R38lYhL+X8B0bUWYC5kfUht0FuTPFVn82Tr3o8GQ6lQ3Ea6YaURF?=
 =?us-ascii?Q?I8zN/ODJ9v9FEiXhwZhrsxMG+COJ4bvrIwiKmOIFfOutdBWgJBCorWkS6IBW?=
 =?us-ascii?Q?T1UAao98IHOFCaeHNauIzhs1YB9RGNEqmY1lzfrci5PlGdVPtdFlNn73dzHF?=
 =?us-ascii?Q?BhTT5i9gFoMIEdWAfH/8k14gQHeb7oDOUiUCoV3d6yjxN85MO0oeJs9UKiJg?=
 =?us-ascii?Q?G3Rgy2SW3uLO48FggWy/VnCGc/lV9udABHggWmku5w1lphhJTbBEoMlxV5fK?=
 =?us-ascii?Q?4fEpCgu2OwIsY/+Y4vtAFwpHwXyh+OPeD0CD9fenhVVTjKo0eZKZhv486Qze?=
 =?us-ascii?Q?Opod0VYoNEe6UoFaS5B10a7YTbU1j39TkbItdxNNL+6PTk2WwnU8ugzlSZCr?=
 =?us-ascii?Q?efFPP4pfF2PrG/m14E84wab07mlaIVMZTgnYDIqz+Aqky0OMf9Xo/+XM0iXN?=
 =?us-ascii?Q?T5bR97MPuzJ/y6ZmwHgOP8FujukPmnUEVvafFjG5Uz7yYScLEZydPyuzKBiS?=
 =?us-ascii?Q?BN+rkLR+i/Yrui4YSyrJQOpOGpO0geSjp7bqzUezNjdpCw5/yHCC/k4vIsyc?=
 =?us-ascii?Q?lPWID6l4oT9sphLlX2snCuPi7/5XDh039roYJSfI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0bdbad-2773-4897-db9c-08dbf2c03577
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 22:52:34.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9D2SDMXs2UbwnrUA2tBPbTPVlsJ14C4L0RYVWzAc8FDlqONzctABYI8Ddzpa+3wS4zyE4FYCPW63sQxeG1EHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 6:37 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 07/12] wifi: mwifiex: fixed TLV error for st=
ation
> add cmd.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:31:10PM +0800, David Lin wrote:
> > TLV commands setting for host command
> HostCmd_CMD_ADD_NEW_STATION is
> > not correct. This issue will set wrong station information to firmware.
> >
> > Without this patch, transmission will get 50-70% low throughput for
> > host mlme AP mode.
>=20
> Is this an issue affecting also the existing code, or it depends on the h=
ost
> MLE one?

This is related to host mlme for AP mode.

>=20
> From the commit message to me it looks like it should be a dedicated and
> separated patch, therefore should probably be before the other patch (or
> maybe even a separated one, maybe is easier to get it done this way?)

No, this patch is related to host mlme. It won't affect original existed co=
de.
>=20
> Francesco

