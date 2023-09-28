Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF77B21E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjI1QAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjI1QAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:00:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BBB1A1;
        Thu, 28 Sep 2023 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695916828; x=1727452828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+QqYqH/oadx7AX9bQgtsUmR/KJjgaZAli2EsTz7qLRU=;
  b=Qt/H4iWO7D4KQuXnzAjugtKU0EzyLn1bRF++BSXOQn6vSF50tyE4lk13
   nArcJNwPFg3rni3d20CF405+T8D3hprwucqEFMEA9jxueDhdSieBJm/tC
   5W4xE2kAGoinzxQgacagj1PYUvdFotc+des/rDztcERRvR4zj+KPC3yH2
   gils7dwx+O3291LHGTPvaM3QaJO49BaIDHFTY0iFWuDv3sfuORQU47GIE
   vgBXbsB6ZR8Ass3fkY4TK+83Tz4cNLdqjzuO1gm0l95okWmgNjGRozvEa
   vIO39PJWp93uRD/WsSzBepT8TFQqHoL/gybW4vUd7Uiuy0l5U6umt47yM
   w==;
X-CSE-ConnectionGUID: BoCvnNLyQUyp+PRhWKEibA==
X-CSE-MsgGUID: C9/Ek+vPSmmGlMtZn4stdw==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="357304184"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 00:00:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwabhAqy0CcYxu6Q4sWNsrW/6qPYLSz5nPwqtjHHo9jZ52xubiPiiHkcHoRuEIvHMDxfyrj/ExJDlJX62kRZF1tUcTsI5Bd9G4Py7u9a4VCh2Jv7xdjTGGKvtMwXvewoQbFUExhjXGej0rNC+4xIYttM70Se9aPSecmpQDTgCyjk5E9n/jfXddGNlXe3zIuW5Yrx57p9Gpi5H2SuqkoFgFqNE0LfPdKLeDXABTIY74XSuQD6ZdPYS5nPMpcNmGChgMfQNmv1UCdZABjcvtjnNbrVXYoeFZUKVoohoyHx+aovQscRtqti1hkFhuUvIZjQp5gM3jGNCUakKZXijZlYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w8jtzrFJvZLXWobLt2X3XsScKQHkgvVs692vkw3qDI=;
 b=U3ZcGEdZm9+Ekfozodl3VRlnQNwiZpEC/W2nfiojEcOpEINwwRVpAiUrEJ4QCxxZIWUKDeLXIsMKPG7rtDwnduLEVC/riffWfJK/vwY5CUtq7slrn8ktYWnRCnUQxgCfSNlk9gojDjQ2OUfr1RhZl/fpBozn4baJ7WRnqJfCdKMkHPgJWXnZjfSQQQliz3I5NRdrk4ABVkRV3k8OO6Q1+/efelM1FP+QR2rR5BW1Oz1UJLTBC5GEJsqMd7rZcQeBPfCm34aq7uNFb0o4e0j7Cgj4j5Zr3LUfMV6QN8O2OHUhlJCg/DLcHf5RUgsj2Yxee7C1+NcDsi6PR8NBfJiD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w8jtzrFJvZLXWobLt2X3XsScKQHkgvVs692vkw3qDI=;
 b=n4EEAzmYMXwXcRyqXesSWQC0FbNeaZhS8vc0mq+JTGQsk/obaRuWqO/O9FBQCjuj3m8eAiE716WX1VrXBFfQpNBQfcHvTc1lMnaCkzwYEyhNNuYuGjjNhlS9l0v3pAurJq3MFjq8GYNs7ieYgE3ZTqzHZ9PdGrtl/3OUn1n4Z4A=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6309.namprd04.prod.outlook.com (2603:10b6:a03:1e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18; Thu, 28 Sep
 2023 16:00:24 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 16:00:24 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 6/6] ata: libata-eh: do not clear
 ATA_PFLAG_EH_PENDING in ata_eh_reset()
Thread-Topic: [PATCH AUTOSEL 4.14 6/6] ata: libata-eh: do not clear
 ATA_PFLAG_EH_PENDING in ata_eh_reset()
Thread-Index: AQHZ7un7gzcVNpTh1Ea2XyoS5/QAzbAwa+2A
Date:   Thu, 28 Sep 2023 16:00:24 +0000
Message-ID: <ZRWjE7e8EQgL41ae@x1-carbon>
References: <20230924132050.1277021-1-sashal@kernel.org>
 <20230924132050.1277021-6-sashal@kernel.org>
In-Reply-To: <20230924132050.1277021-6-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6309:EE_
x-ms-office365-filtering-correlation-id: 8b607224-d659-4093-a636-08dbc03c0699
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d91jRahXTzURKZt9oQtzsRKaQtg6fjmnV1ovQaBv4MZ4kjf7Gs2NbQxhaJ53/zJKbyqX8pgIoq2ZnfiltGyKkeRiD6usihq3phbkoYwneBCJH2nEz2jQr1zu7/HSNZtJkxZuiObqLkNfPJPU4xKVFMA4KMgelMnv38ha7Svi5AKOLQLmxcyzvgRQP/ZnGvwwHj1TPlelkt8sKDbXJWGJr+ED73rbHZCXnEFOQffLnDQ6oRVNEwdCEVYKkUMCS3SS2scCRj7XZIl+Lqbd8bOKubTu/WBdE0Hr/cC+STqfoBmPWtAOFUxArQcEiFkSeL75lZhsTPhHBPApXIEMZLf5vfdQaXGIFS693nFgTrzb5d32zPDHNJlYHbMVGa6d2hUgAD3OilWyI4v5Y4O01mAMVwXMga6uTP3yvfX720eCtLwUXJ4qRG5fb9wTDVoxn32ZrxkI8Ur5kucGAWztvYltjYd50e7A8OCz7J+BaF4m7K1nLxwk+8CDj510uzvEEpcoSo1b8tqL2uQAaTX3icwl8Ew87WWdRiqsJRbdjvq5YnEU2SCeFEq0/RnmZKc3zF8dUS+uvgZ5OuOm7sn9uV96liHubG4AwhPYtSoFPz7Ca+SbWQmAzmJ1zp9OADmaB9nH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6486002)(2906002)(966005)(478600001)(122000001)(33716001)(38100700002)(71200400001)(38070700005)(83380400001)(26005)(82960400001)(86362001)(6506007)(9686003)(6512007)(8676002)(4326008)(8936002)(41300700001)(316002)(5660300002)(76116006)(66946007)(91956017)(66446008)(66556008)(66476007)(54906003)(6916009)(64756008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XSj8ob7eJgxkmoDDmdsVf21tJUjQdzlr9G7fRlli3S6gXcue+4S2ytfaAxmE?=
 =?us-ascii?Q?/nJNs62AXFoiI8WtVGw71+KqkazFTwHgw3hZp16gzVjEcWjOim9xLEhaJmDF?=
 =?us-ascii?Q?IM/gx3kHGLzupWjifpmjYjoteA5aLOa9744S9RFlV++KSRfscRHOhgtg6HPb?=
 =?us-ascii?Q?e9SOBz8XXbfav18pFKjqrokNbtAfFpKP1pg1rCMEnu6uHTOoGORZzbiqXn0p?=
 =?us-ascii?Q?RER8tN1JFUAONIkQHClj7s7QGb5Nbw5KV/tfxaBG9exQIxEk6Yv/ud7sd0H0?=
 =?us-ascii?Q?8wkoyKKH52Rkxj2VHLfNkhcDfe/3HaAs/htZL10wpckNy7vQyNv7xPHYGOAj?=
 =?us-ascii?Q?ksz9spRYlI11/txMOdQkXqWsbXI08wUIBAjT/h8dZCaQJC+Bq2os8Ckh36ic?=
 =?us-ascii?Q?ZG8qVdztRoqG6QER8DNITlheWQGL+vzH/Kbmh3IP+5n1aamp8c6gOKV330VB?=
 =?us-ascii?Q?02iDU8pcOeIcEtLvYW4bGIe7jamGvRHh3ZxlFU40JiYLEqEYjVEFqkIUDoNe?=
 =?us-ascii?Q?+XHQKcrZBDBjC0AVOsb7EzQaEp89Gn7iX82ec8z9Hj/jgfCsxw2BlQvGpGou?=
 =?us-ascii?Q?ceiq4L89Qiv2uie9X98XdWTvR0R3almAxHWDbHzSHiiV75ODPIHv9P9BrBDY?=
 =?us-ascii?Q?lVSBEG3d7sb3n1w2eic6zmeAoArkpHYqab1dqYvxfJcpgXXqu6wejTdiopBK?=
 =?us-ascii?Q?jgHBDVXTHtMUP3/VT+5eXlQgn56xqNF3vx+pY+3l1OCq44Cd/f37KNkUbGtb?=
 =?us-ascii?Q?ymDgq5ArCdfxC8jZO6+3FcynDVENABU9+yC0bVFhrdqcCnRQ2IIqczr/sygO?=
 =?us-ascii?Q?MHEDxxWqpO+Ng8NToYMQKMPoqMUUD+vEhbbaAYmwf/9fb7K8ViTYjWyISyLK?=
 =?us-ascii?Q?sfqSi/uvxII49pbQqqlLUiRITrdUnx0hMSgEKJZRHBg+Nt9ERGANEb5W6IDP?=
 =?us-ascii?Q?9V6axhlAKnVUqUCtm2e6XzQ2S97OsNurHoCG308xYs3Mp56cHoIGQ0Qipjup?=
 =?us-ascii?Q?EDJL3FB0mwVIJyKV+agmsMdAgdD9b2kZlPUFMK/quF0aEVRxTc2S6549bWOt?=
 =?us-ascii?Q?2yQHRV1DaATN7JsD4kDad/RbCTrw7Sar/fXQOE68fK8szbEq39BirbpBiZqW?=
 =?us-ascii?Q?b/XFYd5+e1KxtDisp3ol0KTHAQ3mBN9Iyf+50RD7LmD0UOKQR+VKzXMZaXRH?=
 =?us-ascii?Q?9pXgwgAxQg3faNkO5aoXw/XDvnUt2YGm9S8d63oodvEZ0OF0wxHeF0ZsbxwY?=
 =?us-ascii?Q?9c5Jp0La2MUfmnyX9KA7qVkZd8NKXc8aC9HW97H+PGyR3XSEOeyJJD6lUOZq?=
 =?us-ascii?Q?TV/uWXSIDxEHTRlsp/33oTMaV5v0GFl6kgIMnn7LL2lKhz3ehR03fCT8r+fO?=
 =?us-ascii?Q?tPyQTjaxk+OY7gkhUQNwno6lXoRbortJ7kyuBi0HjdCR2hS9p1RLHzmpVZbk?=
 =?us-ascii?Q?YTVOCkZl9/ZDh1LMlDsEs4HcF4ZN/XAYrROMcw6IllUlvRU1q/N8dsKl52jh?=
 =?us-ascii?Q?ztVO4kncGtmLAi4s9qjpATndJ6PA9j5jfYHZy2TPF5IDOR1tYQiry9yx7e5U?=
 =?us-ascii?Q?rVm8lyBqvjcDQeBMJrBUOOCU4bKoWLyw1//9Eiav/oWd2mnLar74saqTK4A/?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <438869F821C27946BC6AD77A7E8B3DEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MQBKFMZh7gv3OZyRVeHfwC2Brpak1Yfa8blgmg0W1q9rClfbpwy+Qs8qiwwyg1WTwB4yec04c535LmpkcnS0w2sHKoNcAe2sDpJ2+mzE/ZUVbcJrksxVT5IrUTZPraouqKLKkAMz/yW1uLLct8E5DrW7wuDBiM64BQPGWRpTkO3ZVVsfkxU5NcqrL0Lpw1Nau/8xEFVGftJxXw0JcFgTvEWrotP9UnFHVObnY4sdzaF37YSKNq4AnXocQ3z0q/gqpqthGe2Nkg0ZFFfY6WvOop4sShhdPp3Z/B390KV/OmLSPCNSTPBzp6L2J9PN7+uU+sjCohfeSCMjjFKtpxbnBw3qMi8nQFGRB0utsNpOwl/W8QORYK/P8h9OE1dmEv4UXTvP9dnofASUZlQvJTaSSF4JgsAYVw77i6SaxEUhXo+kJv6P7kvkncx+5aIxtQKJ2oTDkehi+mWhBCUvrV3vMWs59DrJYa0mBPVn+XLCtYJtvhGaTTM/F85fVIYYQ2s4D6zW6UkwLP/NOrPM0xqHPCMZSk34dirJeYzYws3m06shm5EZ+thRbzJd7Mu9CeZdLJL3Twe+fwvH9rFxdhdV4ShFNFk5m0X42GmnUUvrJj1oL81MpIVcwxrOd6KfOESpqw7VKT3ffaAzK8BLsRUNLodRC15uVnz8ATlMbq8RBVeDI8TMmiUdbBHow3MJAwFejwFAmIKwt1FbPJ9G0kT60NS3R22562q7p+cgfL4xi/+vWN0zXd+RwqXidJCylm+zIjCP7ViKnG/gtmQFfUd519QQzPrHecm//EchOEYf7BgJINTJ9O0+5S2YPE+Fi8zt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b607224-d659-4093-a636-08dbc03c0699
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 16:00:24.3876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UGk+N38bii/9hWC5FFjwYhYwYV22PZUSw+KAtdPMUjDvvfNKafdM/+Pz1eZgKvYP42s6uH6cgrbsO771xq/FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6309
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sasha,

The upstream commit that you are backporting here:
80cc944eca4f ("ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_=
reset()")

Requires that we have:
737dd811a3db ("ata: libahci: clear pending interrupt status")
in stable. This is currently not the case.

See my comment in:
https://lore.kernel.org/stable/ZRWf7Avtdv3DeqCU@x1-carbon/T/#t

Perhaps both:
93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert the re=
maining ones")
and
737dd811a3db ("ata: libahci: clear pending interrupt status")

Could be backported to stable.
That way,
80cc944eca4f ("ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_=
reset()")
should be safe to backport to stable as well.


Kind regards,
Niklas


On Sun, Sep 24, 2023 at 09:20:49AM -0400, Sasha Levin wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> [ Upstream commit 80cc944eca4f0baa9c381d0706f3160e491437f2 ]
>=20
> ata_scsi_port_error_handler() starts off by clearing ATA_PFLAG_EH_PENDING=
,
> before calling ap->ops->error_handler() (without holding the ap->lock).
>=20
> If an error IRQ is received while ap->ops->error_handler() is running,
> the irq handler will set ATA_PFLAG_EH_PENDING.
>=20
> Once ap->ops->error_handler() returns, ata_scsi_port_error_handler()
> checks if ATA_PFLAG_EH_PENDING is set, and if it is, another iteration
> of ATA EH is performed.
>=20
> The problem is that ATA_PFLAG_EH_PENDING is not only cleared by
> ata_scsi_port_error_handler(), it is also cleared by ata_eh_reset().
>=20
> ata_eh_reset() is called by ap->ops->error_handler(). This additional
> clearing done by ata_eh_reset() breaks the whole retry logic in
> ata_scsi_port_error_handler(). Thus, if an error IRQ is received while
> ap->ops->error_handler() is running, the port will currently remain
> frozen and will never get re-enabled.
>=20
> The additional clearing in ata_eh_reset() was introduced in commit
> 1e641060c4b5 ("libata: clear eh_info on reset completion").
>=20
> Looking at the original error report:
> https://marc.info/?l=3Dlinux-ide&m=3D124765325828495&w=3D2
>=20
> We can see the following happening:
> [    1.074659] ata3: XXX port freeze
> [    1.074700] ata3: XXX hardresetting link, stopping engine
> [    1.074746] ata3: XXX flipping SControl
>=20
> [    1.411471] ata3: XXX irq_stat=3D400040 CONN|PHY
> [    1.411475] ata3: XXX port freeze
>=20
> [    1.420049] ata3: XXX starting engine
> [    1.420096] ata3: XXX rc=3D0, class=3D1
> [    1.420142] ata3: XXX clearing IRQs for thawing
> [    1.420188] ata3: XXX port thawed
> [    1.420234] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>=20
> We are not supposed to be able to receive an error IRQ while the port is
> frozen (PxIE is set to 0, i.e. all IRQs for the port are disabled).
>=20
> AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) states:
> "Each bit location can be thought of as reporting a '1' if the virtual
> "interrupt line" for that port is indicating it wishes to generate an
> interrupt. That is, if a port has one or more interrupt status bit set,
> and the enables for those status bits are set, then this bit shall be set=
."
>=20
> Additionally, AHCI state P:ComInit clearly shows that the state machine
> will only jump to P:ComInitSetIS (which sets IS.IPS(x) to '1'), if PxIE.P=
CE
> is set to '1'. In our case, PxIE is set to 0, so IS.IPS(x) won't get set.
>=20
> So IS.IPS(x) only gets set if PxIS and PxIE is set.
>=20
> AHCI 1.3.1 section 10.7.1.1 First Tier (IS Register) also states:
> "The bits in this register are read/write clear. It is set by the level o=
f
> the virtual interrupt line being a set, and cleared by a write of '1' fro=
m
> the software."
>=20
> So if IS.IPS(x) is set, you need to explicitly clear it by writing a 1 to
> IS.IPS(x) for that port.
>=20
> Since PxIE is cleared, the only way to get an interrupt while the port is
> frozen, is if IS.IPS(x) is set, and the only way IS.IPS(x) can be set whe=
n
> the port is frozen, is if it was set before the port was frozen.
>=20
> However, since commit 737dd811a3db ("ata: libahci: clear pending interrup=
t
> status"), we clear both PxIS and IS.IPS(x) after freezing the port, but
> before the COMRESET, so the problem that commit 1e641060c4b5 ("libata:
> clear eh_info on reset completion") fixed can no longer happen.
>=20
> Thus, revert commit 1e641060c4b5 ("libata: clear eh_info on reset
> completion"), so that the retry logic in ata_scsi_port_error_handler()
> works once again. (The retry logic is still needed, since we can still
> get an error IRQ _after_ the port has been thawed, but before
> ata_scsi_port_error_handler() takes the ap->lock in order to check
> if ATA_PFLAG_EH_PENDING is set.)
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index cbe9af624a06f..8a789de056807 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2948,18 +2948,11 @@ int ata_eh_reset(struct ata_link *link, int class=
ify,
>  			postreset(slave, classes);
>  	}
> =20
> -	/*
> -	 * Some controllers can't be frozen very well and may set spurious
> -	 * error conditions during reset.  Clear accumulated error
> -	 * information and re-thaw the port if frozen.  As reset is the
> -	 * final recovery action and we cross check link onlineness against
> -	 * device classification later, no hotplug event is lost by this.
> -	 */
> +	/* clear cached SError */
>  	spin_lock_irqsave(link->ap->lock, flags);
> -	memset(&link->eh_info, 0, sizeof(link->eh_info));
> +	link->eh_info.serror =3D 0;
>  	if (slave)
> -		memset(&slave->eh_info, 0, sizeof(link->eh_info));
> -	ap->pflags &=3D ~ATA_PFLAG_EH_PENDING;
> +		slave->eh_info.serror =3D 0;
>  	spin_unlock_irqrestore(link->ap->lock, flags);
> =20
>  	if (ap->pflags & ATA_PFLAG_FROZEN)
> --=20
> 2.40.1
> =
