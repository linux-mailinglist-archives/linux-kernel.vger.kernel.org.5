Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66E76278F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGYXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGYXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:52:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44542139;
        Tue, 25 Jul 2023 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690329125; x=1721865125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=leR7Vkoqfk/7909NLP+pO2sI7mxe3K9ABm4Z5B0zIn4=;
  b=pWBu3WNO0Y3ij+wz61aLL9RX0kRPF0xPPYfDBquL56mVggymy/x9xBMK
   ixF4OqrmzeVAQncBP/jV0a/hhp789/QIZhXMwONvJs2U9cGssyQK+oecv
   GdnFNGqk49CfPPJ1umsIgWHbTYtbO21QJMwMhuLo7I7lWflygTfpQwzac
   CynIRH8WhTYqVFcjZT4/ubj1pA4TjYucU4UHexuc6niUTpfp//es1orM8
   Af3kCY5iH/KGntcL9JgCboGlHLBO2dS2e0uu1NbI9AoL+0mnXf9JUB9co
   fm9olKJPlMYqnuwTDXZLOWj3K7RMzjA2fg0whyoa1QYEf3wzkifR4Ffli
   g==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="237768362"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 16:52:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 16:51:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 25 Jul 2023 16:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoYgglVJ+bK0M8Kfjwg6mqPOSB6yuIuhnRWocK7Xtq+uTTw87SM+BFNoonmjRjoxWo6kIIEZDJyy6lLK0f3ztwjBHphf7yZlxpgqW+moGcl8pflL127Ykx9Fblf1d+gn5TYqaJCcxw2j1qFiivaKo0iIbi7BUbITyRxBEll4l+dK/mcxVW7QA7IksrvgsAWcOIUkUIIngf5erPdg/pjiGc2D7Ds4uhIMBofTGmffj67nVhVUfrwl/EsbDPHyHfWiUYtaXNbrpM69BwHjSCtRGlRv+oCl+dWpPoktbCvld5hUZRb6AKQj/RQtT6m9j7VNNGRbpwUrH5xCjaF8cPriMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kEXoWZlZMXZjW33xr+3DZCYyLEXUAHV/kfsiqfwRr0=;
 b=joUGH/aPTMqeEHlPtttPtzebrIuYyx+MGQt0o2j6Niw3rjC2eBVjS1ZDzYOdWqIyAJIqk8+yRFZxqVmovkvLZ8VTkG0VsJ/3O3LuL6CFvxJEG+fyXnLdDyxQ34ka9lBX7JVYHZuMu5DS27q2Do26i9UsdC7IWTj1rAZLOBT5Oc/Huf1sHpwktqqe93P/l7Z66T7SH7VWirVXsYDAAvDcblqRSpsb0g41CoKx0DgacMpWeDhMGioKX+0DHBZbc8mWgjcZefDJDwgMCOCQCANk+ZQbyy1TQzl4FTGQsfJEQDlDymYorfzPmdmb9qnK6tc4IIuf1uFj/xryxzsLOnHeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kEXoWZlZMXZjW33xr+3DZCYyLEXUAHV/kfsiqfwRr0=;
 b=unF9RkX2mrJcofgcuhGwtgFxKi5NeaFMnlCsvn6C9+7oHPBxcpXxDpnXRq9BZB8INK6IVDbCQG1eIQFm/fF7WT0f3HID1g3qZ0BPBDGZLF159eiyTglO8q0yDLNYOsfOVDWTtqj4Ik1J1xv+E8Hf72ZiOSf2TuMfu/SpbHzuvCc=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 23:51:44 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::65ec:88e:32d0:30ff]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::65ec:88e:32d0:30ff%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 23:51:44 +0000
From:   <Tristram.Ha@microchip.com>
To:     <kuba@kernel.org>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <f.fainelli@gmail.com>, <UNGLinuxDriver@microchip.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Topic: [PATCH v5 net-next] net: phy: smsc: add WoL support to
 LAN8740/LAN8742 PHYs
Thread-Index: AQHZu2v70H+1OzGMA0qdZdmnF24a96/Jmo2AgAGUNHA=
Date:   Tue, 25 Jul 2023 23:51:43 +0000
Message-ID: <BYAPR11MB3558593293C41090D57EADE4EC03A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1689900053-13118-1-git-send-email-Tristram.Ha@microchip.com>
 <20230724164351.2ecf6faf@kernel.org>
In-Reply-To: <20230724164351.2ecf6faf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB5916:EE_
x-ms-office365-filtering-correlation-id: 8c751be7-4650-4bda-520a-08db8d6a1996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SEosmZLynWbIEeBF+iYEqPEfECGMQY2AjMRJAvRcPddHjkwg8wWG7Xz3YpalXs+DH3jwTcjVucD7z/iZINcI6DvLh5/X7INH8BTvi2Y6gVxLT8DvFAag4Dr4kUdX0ELwJQHUbvoGTesJguDCJWHxzNy3h+8Q8eXE5Ym7kke2kuSs0yGr/UPczwg014HOK/xp7QOs/3Z01jSfiIjKPTMKlV0CagVJpZ/8MouWtUADt1BOkeedBZR7qGCqAq/QXC19zMp/qdt7ynMLNdXR3OAbmiY+7KBuJ+2D0HIP+nZdO2CJSJJo1GKSplUboRIfPqRS+RwbQvJz9K39urF+A18x33qMP+nB+r5BafVG9lpGnMJi4asPbKthfrkEHqwJS40Qcy/NmSR3AhTMTAljqzaqOLHO/v5G7HXgpUA/BYBM0S8pqY8V02gIQIzw/liXJZT5GcweYIbBt8DKvBnkZ13MpIY9GUxQqk9YSN8p8eurI9SYcuK2Of9YvhmHyf+C6knUQ4fqaIoTfu31KtYL5Pj6AOo/x3zisJY1XYj82DHskSR3/6aOM4ja0E8TZthOacTljL6o09P35QSfbW5e1MM3a7IcOxQ0L7jnuJROFmMXMmbHYbBUlXoBxzgCmOkNSLc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(9686003)(478600001)(54906003)(71200400001)(7696005)(83380400001)(33656002)(38070700005)(86362001)(55016003)(4744005)(2906002)(76116006)(186003)(26005)(316002)(6506007)(41300700001)(122000001)(66946007)(38100700002)(64756008)(66556008)(5660300002)(8676002)(66476007)(66446008)(8936002)(6916009)(4326008)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vg5CUcWBLnb6+85r9I61E4sY0lrIJdJ8ihn5PxNU9d4fPCVi+L6tnF/zVWoX?=
 =?us-ascii?Q?816pR8xSw5OCfqCp020bHpaRwstuINqR4Okm+3yFdCWPYF7+C5WNXyBwWnib?=
 =?us-ascii?Q?mEOf/SKrXJD8ILkdXvdvtRwGU9vtvaPKw1D10u73ZxDbLQbYACI2V5N7HN9I?=
 =?us-ascii?Q?K8NNBCU0iTNjvqBd6gw5p9DnRwU6/BgsqKrlNyC7nGVtdxFpxv412TSEeTUJ?=
 =?us-ascii?Q?mU6ySv3nBUnz48djIt8ooUaDN7rVojTdPsdMp7cRlcbrxOgBLtGIpSrk2pdq?=
 =?us-ascii?Q?5mKX1l1xzv5uUQ9PbCNX3HQzsaMHX1nB9nnUCNXb6n9PRUnXs5LLR/by9kuH?=
 =?us-ascii?Q?fIvPNWl7t9DG0dNrnA+O0s3Pivfecy8KcZFXXJay+5SEU8BKGoN/RwR3b0Lf?=
 =?us-ascii?Q?FomxLnraDH1MlxDuWl7SuND9RquSWhg7OLEwW/d/MgkaQ77ZGQo/tjkcOQis?=
 =?us-ascii?Q?KTlJUpY6DG393cXJSQq7zw3U5LEhfcLhlALWF9PSwzHs2rI6oW8J15VOETqU?=
 =?us-ascii?Q?nEqQ5aA5FlGhXUhd0gyWqC5Ho7jN5DiV9J0VZ6HTjaJVhfTXZa9ag4zT8fTg?=
 =?us-ascii?Q?Nr+z+clLPtfB7DEDGFEj/w0XSiKaEpNz1oDDByZ1er0CPFeoP8xEj7JWSN2H?=
 =?us-ascii?Q?Twr9d1OAgCd70spOagoWoa7hm8QAk9hrAx8FPnSfioodp9fFBaMqwo7Jo3/v?=
 =?us-ascii?Q?D5TV7d9yPltE/mdvvhq/m+nONyGN+7+cmMrGITw+w4fucFObyqOANDVNK5GN?=
 =?us-ascii?Q?+Frlnrz6ewl1yWYw35T/CkewZSCVpr4OymSlp3mQQ3xEzaesK9cCx8ben12U?=
 =?us-ascii?Q?Aa07/K8HFQVy8pgNkU2jbueXgxTwsQXSCAMa5WDvjHFbqGruDgqjxQ9zeq0j?=
 =?us-ascii?Q?av6SAFgU6qe1/kcRKdlHEPUyj+KkUvH7YY5Gj/UI9DOpbD+xtHeWsaSNAA7d?=
 =?us-ascii?Q?SSQyQ7LSeXIjD7hSAwbOkS/RD+NFHYH2hZHs1+LSCygBg1hr6SNFs3ALkDeX?=
 =?us-ascii?Q?cQP4MMc0i7VIQdkrvHDIbpaPZ6ioU9qfcyIucS1Eo6tGpdI3eT5jUpRsHqPq?=
 =?us-ascii?Q?VHN/VA9S4c5E9pLLtedwMLhMKlbUrsQ0cMdUH/O8HgiE9wd4A5799vz7Rllc?=
 =?us-ascii?Q?OnonrIpzxeko0fV6AyJUHf5X+xFUL26wIVAncdvn7OXOlle4gTYFokaLjQpI?=
 =?us-ascii?Q?h98tsHMkqfWuOYbAZjfRLy22IbagygOj5z/HzFjhKcRJgjY0c/XaOCPVSFab?=
 =?us-ascii?Q?XL+s+gfGENIlouhRMa/TDfPfhtLz+WtTVHeLavyoNAQgrupRwujxf533roSS?=
 =?us-ascii?Q?oCW/pEkg0xguoJ3MCz6HYT1ZHrV4OvxmZ2P7k9rfeW9w9iY21vBnQM0TJlp5?=
 =?us-ascii?Q?xRdMjwKShT2QiV3yRj44M2idJhVtQJhmIIF/55eNtzC3lA+9GKLTprxCVPm9?=
 =?us-ascii?Q?3ZyvLq9Li3Wuy2M+diGZZFrdXXbJIPC4oX2pJbRZKQ/r07n8qGN9lXlbsYKp?=
 =?us-ascii?Q?O3iriZq678SNXwVK0RB3PEljOt0ScMH4T4DfnOjo3Ng1ezOZrFjvv2J5sQoH?=
 =?us-ascii?Q?SqCqTyv/kXMBTO63/J9bcIgfb4g44/uLMKchYZya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c751be7-4650-4bda-520a-08db8d6a1996
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 23:51:43.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EciqXoTqIDDizpz7/z9H62U8WalqdrmSPNnOcG4O8qxj1Bp0bh5V8+QUrjp19t95CmwexXZPMu+a/e80khMZWHFdTio8AWbCJCj6dLAV/GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 20 Jul 2023 17:40:53 -0700 Tristram.Ha@microchip.com wrote:
> > +#include <linux/inetdevice.h>
> > +#include <net/addrconf.h>
> > +#include <net/if_inet6.h>
> > +#include <net/ipv6.h>
>=20
> You don't need these includes any more, right?
>=20
> >  #include <linux/smscphy.h>
> >
> >  /* Vendor-specific PHY Definitions */
>=20
> > +static int lan874x_set_wol(struct phy_device *phydev,
> > +                        struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *ndev =3D phydev->attached_dev;
> > +     struct smsc_phy_priv *priv =3D phydev->priv;
> > +     u16 val, val_wucsr;
> > +     u8 data[128];
> > +     u8 datalen;
> > +     int rc;
> > +
> > +     if (wol->wolopts & WAKE_PHY)
> > +             return -EOPNOTSUPP;
>=20
> You're not advertising the support for WAKE_PHY, so you don't have to
> check if it was requested. See recent commit 55b24334c0f2.

They will be removed in next update.

