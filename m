Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00AF78CF03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjH2V6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbjH2V57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:57:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E3BFD;
        Tue, 29 Aug 2023 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693346276; x=1724882276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UDLuiDS9MveSpZkSMoJ+lQBt3LONLtYyAY0wCeaSfxI=;
  b=G4dcceXacljblUXneB8nUJFPUPuRvpMifTa+gVPAtWXPsQbenBQFMT4z
   rl6DNvRNSJrkFGCJuMfZj8vLktp++eTxZsMrPdTRC+82ncL3rmD+Ix6yv
   kodYT1PVpjnyYQ15SiAcLtmXCkaOc4bUrzxg6XkcvyVJtQc4xPWtKF7in
   r8r1VZbXTvayE9wi47U0s8zuNXQ/RUz4zdlHC7iX3ZuWCZx4ogVExfyiS
   P/c/OAar6f5LUQDPDlPubFRqNBKuzSR5K3QqOhmzS9VsLZRcl53y//Xr0
   5FxId7MDWiMdO+/4BZlmRhdVEcCbASwKAoDgkX9IYI6W07GiX0mtvjLU6
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="2002465"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 14:57:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 14:57:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 29 Aug 2023 14:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfindMz7QaWdajQnccq/4XQE8RE7emRGB0MqmBmm5J0jfW2P0fc7ZMjU6RrTdyNTg0dK5NxaWuPLKyX/c4JPJJ6gNp8uqr5JMKd1UgNVMhTKlEaBb9uUjVXDmfZcEkmpz1QeXR0dRg4quTndBWLvvZMfXAgxkF6D77JLJM++hnJcDkVnmVXNZDwTiTQ92lH5dUytVdhdKl8f0cXWZN6Cj3CeH/bfLWBmZjmwHB/qH5D2CyRK6fu5B6jYyhc9cc58AIgXic0oYAHqb0vynxwisYXJU/qQ/EhS8FwSO9+2e+MNDi0ap9bLKJHSK7BW4Km6eQB4sxGJvk3oXjnurbsIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKkD6yTKZCa8FDT49yfTaGI71emPPJTOVbdLJGKkDqc=;
 b=Vcx5RhfA/UDQpj28xQ7dyG2bOv6BpqjtmKBEbTV/Ovl2FxMJs0J19wiSjNT8o/p8XJXZhX3InHP3qtBFbN2bdlG/I6l2gjnPgwwPhM63X8wwniMgyYWBbJlCNeSFnSQMesNJWYd9p01LWGpFxejbjUlYFPjApKLEuKcXXWCxOe5xdg4i7RMhwOMnUjx+gYfT05+ANIZljZb+Zna6n6VjYn0u/Tzsdg4E4Yd7ZqaLjr1AehoVF29Hvx8UcaAx6Q+FHEvPGZpYWBJIJeaG79EmGjhrukzppPCwXyRrSwSvDd4Q11Tz2ceK8tn6HA5haVjEE1vlIqIv7smIvD+Uvmn3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKkD6yTKZCa8FDT49yfTaGI71emPPJTOVbdLJGKkDqc=;
 b=ca+hsYTHTUE3YeQiAypTke/ey3cCvtQVK49cNwXvnFUCkdonU27uuyl9x+1kXW0Gi1w2ayK5hdnhjTqXyT4+BUcFDS7R0aGoqe/g2s4FEL/SJCGB30P/gu/H4FvHpEFKfw807VgqKMT4a4OQZ4CpPVou4JPDq0LDWR1CBg2eSAU=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Tue, 29 Aug
 2023 21:57:51 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 21:57:50 +0000
From:   <Tristram.Ha@microchip.com>
To:     <olteanv@gmail.com>
CC:     <f.fainelli@gmail.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>,
        <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <lukma@denx.de>
Subject: RE: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Topic: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Index: AQHZ1qKWLyunbFo9dUGlg3dtAL+k26/6NENwgAB9tYCAAHHrgIAANckAgAEO8gCABXFuAA==
Date:   Tue, 29 Aug 2023 21:57:50 +0000
Message-ID: <BYAPR11MB3558EFBB4DBC86AC3C338747ECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
In-Reply-To: <20230826104910.voaw3ndvs52yoy2v@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 9f28cfed-090c-4830-ebb3-08dba8dafcee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: se/7kAFlfgdXN8ogM8esNZT9pQjGRd72j9ky/FE309OdmqKqDN8yX3hlJi66dYV5//xXAr9vjXvGoY1VUuUOYMSY7oem7B2gscq1thbxOnb/OJ+IBwQDlVYkAcG+51RrFC5ZDDJ3w6Hz4/ySlXYJj8pRMEeik2UNRrtpJLeFNvw+eLlv13cbwu5oLnSnlW3PuLrI7QZjktwdxEzABfh824Je8w0Mtuv2mS+d0L53nOkQ5DMn8XerVnaMvoq+O2dQzcpVf5wy+rmupQG2Vz0nQ8t9getNOdB4OTHHjO7WIk0AxduWeQ+L1ncOIJSv9XnJqxzu1gsE1TXc5g1jTmPMf6FAEcmfVWS30TG/psxmpgK7w/O0uNOixhe7k6/PJa0uCCrKXMjwYrJjGOT+OLwM8+NJM7sHS0Uk1dDtiYffBrVZIQ+NwFEQ+g750/yYMBBwc3iwOV9qSYwApRQM68fZVHlqWVeKFVVvX8+GL38IjTuFkb+FtsRPubzzCmeplhFbkZPdNVZc9Io8VFBh3k3syNVt6ekuH8ZOQpzC+fnExdB3NEd5ka6MBx8go8SDjYqegC4e26TZCaekagB03bYbIdCL9m/GGEF+/ll2b/BsyN06NZWIe5XBYTGlqpM+DkLj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(122000001)(66946007)(478600001)(76116006)(6506007)(64756008)(7696005)(71200400001)(66446008)(54906003)(66556008)(66476007)(6916009)(38070700005)(38100700002)(316002)(66899024)(41300700001)(9686003)(26005)(8676002)(5660300002)(52536014)(55016003)(2906002)(86362001)(83380400001)(7416002)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6TqU2wmCpynnomuCLEl0eg2AXf4T6BMCTV8yBDH1oJ8o9Q+4IImyPvt1V4NO?=
 =?us-ascii?Q?8C2tL+56V9D229uecIvNlpj3Mqj9+JxzoneGuCZyx+cshMwPlwiQniNpmIHJ?=
 =?us-ascii?Q?VsxVF/vF4tohShd0brFBAC60KYrmE8lsQo5+wgcbIvae34DaZjjB3F2XYIfQ?=
 =?us-ascii?Q?Sm+8A5GEBpbzJLpf6yZZzu3CbCP3/1/GKJCKQ9bFn3X+C4Zvgh9TkjyzBSYp?=
 =?us-ascii?Q?Yu0qhL1XNm6pl/t7OsXgOKJnc+/UsoOqb398NcJyV2R6KXe7yx6te9hQkGxf?=
 =?us-ascii?Q?MtZTyhA78pK3aLEUL5eLRB0Zbh6SgMasM9SGq/aGzNdPLuEunHQwNNa4vN4w?=
 =?us-ascii?Q?1qDfRwQ66qevSVUojVIyMXOGs0Zetu0XlIXyt+FZPO2FUR8SYB1Uyet3/dme?=
 =?us-ascii?Q?Yl85JPphvaayeUgxCt/ic28FtIKbFJEW6MFKNdybqlUmNN7igd1C9r2PyTtx?=
 =?us-ascii?Q?Bx930JVUKgk3K87RQKm2Qz/UZe5I6LEznqqBLpo0knFPDcfnCMX1bfENVsHH?=
 =?us-ascii?Q?XOcx6r/ArttSub61pTh1RFx7W8KQeW67/V1WCdrqZi4amTz+XLGZUit9rTGr?=
 =?us-ascii?Q?QGuA/jvDGQYd8HbrGTVoeYrsv56a6TCNGl28VHUvr0od8QQgLc1Xn1+Nc182?=
 =?us-ascii?Q?B/K1IN4lJcsPvvwriONIyiqajz6JLPmmZ+N2jr3kRo8ldbbFDPzfQrNDC45Q?=
 =?us-ascii?Q?2cxyeTZLIzEry7bYd3jdtqCdiybBo+JRxCVJ1HipBz66HldoMKeSwN2QNy8l?=
 =?us-ascii?Q?mz4wNwCY9HP6idvI+if6zEjXjRWtjGNZ2n/YXcE7/PHmXZynRsOqznCp8Gme?=
 =?us-ascii?Q?gBZI3E0t9t0zHH/fgWYjXtO0JCmIO0X6eMZlSG1z1aysw3Sw7OXPn8r3jizv?=
 =?us-ascii?Q?Ti13+Q6c8aQK3aKUZCpNM6+Mm4Wr9QbtkSHkKyQYtBksRvW11rKoIJO8t2GM?=
 =?us-ascii?Q?Gyx1FyF13APmLah90DYTZb6i+YiiLQqFxPHGbjmatfowK+n1ajqJp3iS2fMk?=
 =?us-ascii?Q?JkN7eZk6se5j9KF3wtWXClBqkw9/MySThl4pur2jeKfBn3uStFo4gZrUPS8f?=
 =?us-ascii?Q?xjVUBpjqkePNKy2/tzrdplwpUGhpQAJkCgRag0wDmTy7ZpP/28+2H5dK/pYD?=
 =?us-ascii?Q?BjZlL6I2C5wimQnWrXjmTO0gHfUThXRbso4w9KKLCgkT6i5FoapnGxG8k2qI?=
 =?us-ascii?Q?w06GP9VnENFnAWIphdjGs/IzAxKiyCANHFhgPHCSj1d44N/jDSvo5uTXK80w?=
 =?us-ascii?Q?wjD331+lByh76ZGcteIv0khCHkdMWYURWa6LxmjxA6x6ZkdIgSFXMT2RW6a5?=
 =?us-ascii?Q?/976qNgAhzGcHlpbrFiEcjAwVGv1AU4AZmP4BmD+GQgEhXrGZjDCsYwaynoQ?=
 =?us-ascii?Q?1NeZq4r48+/iBrcy+DnSSK8Ff0rpaSwJYkv5ClALVLhHvPKxa2nhaP0msDF+?=
 =?us-ascii?Q?Z+9N6s3CBZY5u234akU7gfIZ5AL8JAo7CUxXnuvK495dySBtjOQJRMQ/xzpx?=
 =?us-ascii?Q?Ahc0ejqCzTvu7+CkTw4Z/ajVvmg2jUW1uLlW6KIYOBRbiOOoMAg6LGxTxnEH?=
 =?us-ascii?Q?+naJtURnxugAq8/krPRxvOBRjLwbDcAdfXzVdW8A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f28cfed-090c-4830-ebb3-08dba8dafcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 21:57:50.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVPESPGByfnlD7DrEzHH9d36dllfVc1sZNRdcVk05CMpJBnJ3jtgN2it3/gDvM3zMZdd0uVGE1rwwdiK85F9t2/UCfvGOk2DETWniMO6BaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Aug 25, 2023 at 06:48:41PM +0000, Tristram.Ha@microchip.com wrote=
:
> > > > IMHO adding functions to MMD modification would facilitate further
> > > > development (for example LED setup).
> > >
> > > We already have some KSZ9477 specific initialization done in the Micr=
el
> > > PHY driver under drivers/net/phy/micrel.c, can we converge on the PHY
> > > driver which has a reasonable amount of infrastructure for dealing wi=
th
> > > workarounds, indirect or direct MMD accesses etc.?
> >
> > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893 switches
> > are special and only used inside those switches.  Putting all the switc=
h
> > related code in Micrel PHY driver does not really help.  When the switc=
h
> > is reset all those PHY registers need to be set again, but the PHY driv=
er
> > only executes those code during PHY initialization.  I do not know if
> > there is a good way to tell the PHY to re-initialize again.
>=20
> Suppose there was a method to tell the PHY driver to re-initialize itself=
.
> What would be the key points in which the DSA switch driver would need
> to trigger that method? Where is the switch reset at runtime?

Currently the DSA switch driver loads independently and is then
controlled by the main DSA driver.  The switch is reset during
initialization, and later the PHYs are initialized.  I was talking
hypothetically that the switch may need to be reset to correct some
hardware problems, but then there may be no good way to tell the PHYs to
re-initialize.

