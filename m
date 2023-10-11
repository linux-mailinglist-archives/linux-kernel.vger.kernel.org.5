Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138A47C4874
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjJKD0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbjJKD0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:26:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73492;
        Tue, 10 Oct 2023 20:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+XIlDSPTLeOrlP+9czgVIXdRC9Ke8MF/xv8QCgqPoizVfcq/ZPPMGLwIpUgx2Bic/VF+pejbeqzmm+2sh7Uj+a3g9GMvlwJMHxeccelWpbKSv0NHpP8oMs6+YNPy9fCwDkRN/yDjR3ggsHIJC3FG1eadRq6zGVoTAW8jiQWpizAsotxFFeb/1ALZQF0YxdD77a3N2ArI6+J3gPhZkEciKOMe09UCpdWW7om+zyAbk77g1uFUgaa0vAz+35Urj/8GfkjoTDhmvq4alJ7HyZ6gakluUGOnkzLul82BkZA67UrwLH+02QH7pfmnX4oxQ7WmXK+GZw2TKRP3Tz2mde/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Romv5UKyhMV2yJCVrLi8rdpg4RqaqZ1hXBDLsxRRJmg=;
 b=LrAyxkeHxjFGSzQZ/7ZKy4aHk+1DZNqq+hAhoy9YfpiptgtN9TNUH3123/t3hr9IXb3rVk+9636b+b+XPrcTOEAdw51eLy4ESt046Vw3Evl4+QFswsbqK35pr3dTYjsg32UAZSba9zdIEL/qgqqdWS/SLnJjc8YgGArn3hoW2FuVgvmCDCPHYUwL4zW+e2YY8DZmjZd+4ZGAlw0+v8XWs3uhi/kGmtZp3xpqkNCs/nCxY9hRBI7RZlGnddoMww9BQPF5QQtczHp+bwsVpC+wsNYQS5Sh1lr0XsF8YEgM7WGn9kUWXrk+impO7SzzQjbwhm/FCfzjk/Jxxjb58hLcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Romv5UKyhMV2yJCVrLi8rdpg4RqaqZ1hXBDLsxRRJmg=;
 b=mtDwDAsKBpPLbs3gGia3liOEVEYuiqiCj5A3P3xySWHuADUw46VfX32vU04rSoC+Qb1MUuXj1VYd99LdhsLUJf4oXeP005ZmqEhV1Ikf14R04JNTqKGPp0XWYT6yh5pY2dfz7t1yMJUMXd28fWP+6a+5IRA0c3kNg8B3/Qh9dOmU9sHUvE+GO+NoO0q+vRnTIv/t2oXfA7uHhfZy/2TRv3j/9NLIkO3eIFGCUtoEYFsc+yBlUmsDOWTVJJgNufuIsxqHaoH/v7vypICJemSvbSP3uNcdA28mgmlyklifNhBbf/LtlHHl2ZEiu8NAiHthNoxlC3SfUrH4N3yiZdKYQw==
Received: from TYZPR06MB6770.apcprd06.prod.outlook.com (2603:1096:400:45e::12)
 by PSAPR06MB4184.apcprd06.prod.outlook.com (2603:1096:301:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 03:26:43 +0000
Received: from TYZPR06MB6770.apcprd06.prod.outlook.com
 ([fe80::1ed6:569e:e826:62c2]) by TYZPR06MB6770.apcprd06.prod.outlook.com
 ([fe80::1ed6:569e:e826:62c2%4]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 03:26:42 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
Thread-Topic: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
Thread-Index: AQHZ+J2crJyBQdSH9UyM9EfsuHkdSrBD8ykQ
Date:   Wed, 11 Oct 2023 03:26:42 +0000
Message-ID: <TYZPR06MB6770154F3A65CE1E6AF7283080CCA@TYZPR06MB6770.apcprd06.prod.outlook.com>
References: <20231006213917.333702-1-robh@kernel.org>
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6770:EE_|PSAPR06MB4184:EE_
x-ms-office365-filtering-correlation-id: c1e40ac5-ec17-4c47-3504-08dbca09e3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2bSIPmSvvIbxgk/CkVNq7YlKjngwCovHRNrILwoA+TWnkUjmD7l0YwY2G3Og2jEr0PLpRV5FLFvjRHzt4kvehkYV5T5R2KCtGmT0ShWc8gneJRt2KRHE85c+HBeTj6j3CRk821vZTwfC8ba13txQagIzn3OmXgQo91k9A37NJN9/f3knCREE+EQkIeAdRJhJgisA8+Y4H1AZKxAaSlLLpDB6eNx/DhCuOzPhFCYT1i11NqYIaIi9NnbrGZWEMAX8HXShmsxmlYkI7iGA+jMaXoP4ZXSgMdJvZBzE09y2JszmxuZte4j2Jb8ctrRLFoNA9fF7Oln8hqInsOCZgPqIR6w+l7mYujNOlfkdMxhDBAU3x9y0zOfpo575GTNF1jEULsj4VKaHkd2/d7qTDwMBjxjyptL9euR5yLHz/+a6xEaSdNAh25rbACsDZQkBqanhpnmv4W72+9YR/tDDciGM8D8Ww95IJXMVqa0UMKPPF1CbTvbAMDcfRVINrYc0qOif9AO85O4JRqQHkzhwZR4a8l3dXEHTS/y9ZDgi6D/eXATYmPa7CCZFk4ol6A7vRM51q07E3QjPkzcCKNgC11sCR9FVvz+m9W1Y/TtIY6i8Cc8orzI7wG+P/wfVnAbLVIm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6770.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(136003)(376002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(38100700002)(316002)(76116006)(52536014)(8676002)(8936002)(66946007)(4326008)(64756008)(54906003)(66446008)(66556008)(66476007)(41300700001)(5660300002)(478600001)(558084003)(71200400001)(2906002)(110136005)(33656002)(86362001)(6506007)(7696005)(122000001)(9686003)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEllnyoFYtKisCeZAkBRnMJ6lG4qX3s6A2XrbqU8u7FVY/9kIcAihgFR+Zk2?=
 =?us-ascii?Q?apooLk5N7FIbuh1AATUVe3e6J9LW8B8LUmwWJetLBVF4sRKojJw2x247HtYE?=
 =?us-ascii?Q?k74gSaW+dz1zYY6WeDJs0MfPLZcGmVZDUeAPk6WRsVSEInh0FYJOiMPp5bhc?=
 =?us-ascii?Q?s3lEsRS7hIMlYKoqEOz6ZS4BV3zLxIuMnO6s9L7iUMIinV2wpv2lOKuj7ir4?=
 =?us-ascii?Q?IIiYuiDtWL0YDvaGy2bJ/1uCOaMlC/Amfgy8fECmd6i1gvZ+EAmPNUAZO376?=
 =?us-ascii?Q?x3EwkEQuX2jg4amy68IOkKDzx8OxWiF9iOSQw6gjTWCzH7eucGm6vUnh+aKp?=
 =?us-ascii?Q?Lo0cDLAbqnN8NFyB0ze49jyk4GpuvOMNcD6yyUEJ2a/zprKilkqG0Xys4L0g?=
 =?us-ascii?Q?bgpHip3dxYaHy8zEor06skUyfeoPlE0G22M6nGWgcQS7nM4fuuSpXYs8VunW?=
 =?us-ascii?Q?qr1vvVbw9V69EPFuuRivtE1Hr8BhO9epYfYTK/R54l9u0/oJRlw08+qlRtuN?=
 =?us-ascii?Q?Y6lu7Es7kY0T995l8mvKdJqMGZcPfzpx9u3fvURBw/9/jTI/bikLz6PjAniP?=
 =?us-ascii?Q?NN/yrB3t2ND+hi9lJSyNYXspK+M8m3wUlmFukVlCSQu+U5aBMyuEEb3H0Ciu?=
 =?us-ascii?Q?2Eo+B858GvPMW2yGETrBrnfVAsOpb/zDJrs1wAa0APs72ot/pjA6vl6gloYB?=
 =?us-ascii?Q?prFhE1tLTH1qskm2AVEVNejdG+VF2FqdYdbb/vIyOiJbJIroOUCStGT05vXx?=
 =?us-ascii?Q?TpWVfH0/r9d2cFohr32bf9U/q5AelVNyLEpeBOJrDo5nhSHh0g/9IHtu2vO6?=
 =?us-ascii?Q?6Xy3f8ZKe5t+P+jV1fj9O/mfNRxczwpS9Lc0DsP99vmPHXN5Y8yf2Ll2WnqN?=
 =?us-ascii?Q?oY1xBXLCuMJnJPPrcnYg1f1fa6eVoRZNkK5bTbIEGULu8nzIZwU0olAyDUIs?=
 =?us-ascii?Q?+qCSGJ0Q+hiIjCtv+rOsC+eqfWEOIXg97lrTiCAsbioT8WoyNAtb8nulfaRZ?=
 =?us-ascii?Q?hUJ/B1pshfshCzo/9StqOr3SLeCOyMRIFrj2nEe7AeG2B3SwtcbSSVBCg8kl?=
 =?us-ascii?Q?HSkMZ4tZtkWvKrm3IETwF5K2Qg2WykUZ5ACHMrQko2hbmoHTeg7Kcme3WH1e?=
 =?us-ascii?Q?PtIAkLvbOZS8nWuJWRl2swjOS3P6EeKvSsdB+OQ0p8YBZecAVsoChxHzf0Cl?=
 =?us-ascii?Q?hwGssTW/lIgekHEGBLOkrBCzxzYZLAfWhxnQ60Dr++ClMcW/lyC2f55O8RWf?=
 =?us-ascii?Q?dU3cgL8f7hhUvSY/NSDgGi+VwvUlXVVCT2hErcPDNzBRE9Az2CMXBfj7hd4z?=
 =?us-ascii?Q?Emn28NVXwyhpwVIx9lvAfou5i4oFVPvB6jy2ixxKcOQqH5pIDjQElXcGh7xE?=
 =?us-ascii?Q?EwYrB5lzbKw6mLuFsn9gHubkl/Cja7L2yINkmBiUYFky7wWFO2ShVgjmaoDC?=
 =?us-ascii?Q?DkfCr2h6iKCe0NFpaLmTxahxSRW6byTTuhcahyn5CjO7zDH7P5qabfkwquud?=
 =?us-ascii?Q?RAaFYKJ1cHix/8/DE3NSFd8Yw+yNyp/1acipSoqjqDp/DTE/KCTzoPpDUyAQ?=
 =?us-ascii?Q?rAVg5ExoqJzbtIxkdk316vIp3Qb6M9gwaV/L1mB3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6770.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e40ac5-ec17-4c47-3504-08dbca09e3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 03:26:42.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJs4YPfGsnR9Uhj2hKsppl8AqbnjsDvR5obygThfP3+WXWn6AtO0qMrlsF26plf/eEgjjPsNNqDQkppwbBhepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Use preferred device_get_match_data() instead of of_match_device() to get
> the driver match data. With this, adjust the includes to explicitly inclu=
de the
> correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
