Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62958799CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346381AbjIJHKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjIJHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:10:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055461B8;
        Sun, 10 Sep 2023 00:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+77jvGLY2zEK2ZwS91Y6V1viPS/hQOo7hkjBz9spaZocKGiMtxcYf5/G2JH7rTi8MsJ957eA2eToTZG3CINa8/LADwmdCNUrVUFAttHmDnu73UTg82TJdEZ9wXKuJanfgvDMHWv/gzDUodkBmjUUJlOFLavmsCHccqKnXUTgY868WYDJ2g21C4cTpHHIY/XV79dumiCTD9EGA9SjLHLqv8voL8tpl3+dJH6EdTbNRMly29+R7UnFqTy+/Z5HNHfEYxDeQJoAgw73POiuREUmjZqFbrzHhVzmN3TVI29Z/EJj+5ZjFTWzbHpXJ6DoY5Y7f/IEUsV3PiGPQS6LcW4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5cL4THlGfk2zdA7iY+J0uSww8HmsbmTjBEqH7Efb0c=;
 b=awjGxNv+iFpsgcbEZmb+NrMRV8gSBe7BKqjebC9xyiploxPgLai3EK95y+nwYj5QJchDJ/fyLvINNYNPJpJmi7fFjIaQVrCq2AxdTPpItd9rIEpIVNN/43h+cev9MRy/ptD3rYM5uX0OkDNtMBr0rDuuAZjfuqpqODcWsvhG1uwk3v0EUdPoK9GzsnXE2G+7VpEa26QrCsWlPNnFmEi+X3l38V6uPYaM4qH8RYaTSj1kTX8csYWxPvRy82u4waB7GMJR0ihi0G920uR+HwvKy4Bz1EhbKrhPpuenBUo9Gkl+VdEZJsfuKsSfE2QiGhRkQz3UNSAwqvHhRWNsHf21Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5cL4THlGfk2zdA7iY+J0uSww8HmsbmTjBEqH7Efb0c=;
 b=j3P1p2bwNMiuR+OccC9uev48caOTfUsKfqKKMTLtOHIsYALozd7a4Zv4xeUePq+c+SbyAXqbk79AFrzUxs8Ptq6tn4E6q7UmMhadOg8s3H43JUr0qEZxfVs5heBhAtWvm91yaIRZAwHSyzQD2Jt8FvJdkNGuUWrbuxyAF9lBVE0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5917.jpnprd01.prod.outlook.com (2603:1096:400:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 07:10:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 07:10:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Thread-Topic: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Thread-Index: AQHZ3dRh8L2C1nAfk0Oxs8wvUKKJfrAKc6kAgAk760A=
Date:   Sun, 10 Sep 2023 07:10:06 +0000
Message-ID: <OS0PR01MB592285B86C29C3C1A992C09986F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
 <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
In-Reply-To: <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5917:EE_
x-ms-office365-filtering-correlation-id: df34b7ed-3e80-462f-8a75-08dbb1ccf612
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jbMTf8b+iQJpIe5GwCjkkndbw3HT8pxRWDKiFo2fo3yVPd00Q+4W0wQxKeBNg3091Uuu9huaQlkABMmO2vbmvwXd4wmAxiwGOPrED/5aey4nOAIs212H/VjjP2ema8NO7zHVVMTUHRXzabfDNtrCZ8xcrRWd/HIORAb8Rh2vos5+eEBzfgliSd+uNWJytMQF/SrLHNFB0Cr8FC5RapOamCX5ZwEhOG4Xv7AaPG7AUaA4A259y1JZvs4Au2WF/czTSljCWbkNEL88bk9+lvzdn2GrNYI9DAenxbvWRLoDc2FNWJJZXlmDnrLCr9+BzImIxevDCY+drYqmzS1WarEquJZmamfY+FW2DlmzSzVLYbRyEtL0oWMsS4dbyO0TD56sYHlS05WaLUNWiPxj/5L4wNcGRIJfnf9fDy87orlrVmdPHZw6vdmeDydAe+XhhVxn8e/sIsP0vykGd83afLqOW47TSi6kla8yW9Tsggj0g+Fo+NVMZVCX+R9w9wBHfSxfOw663ZsSRDjBvlF9YArPrIYqNFyo7vG+KV1S+ctQ7kLCSw/srYYUfxgkrsvHN6hnjCOi5dRX1U33wexLZ3glaaqJ4T7506iUh7Mp1UhWIkzRbkB/GECfLLCUCQVWjSIc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(1800799009)(186009)(451199024)(6506007)(7696005)(71200400001)(9686003)(478600001)(26005)(2906002)(66446008)(54906003)(64756008)(66476007)(66556008)(66946007)(6916009)(316002)(76116006)(52536014)(41300700001)(5660300002)(4326008)(8676002)(8936002)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AN8m1Goz+W2LRCvpZHwnDd+BplT9IYfRwffZJjiSIHXEgh1taSiJOAuh+oq5?=
 =?us-ascii?Q?i4E0FnoLBGcu8ASe7skRHbj1AZY2HOkhwaJ26tWo6UuKyj0lqmHg/TVQCuF0?=
 =?us-ascii?Q?c3H0ADkvtBbT229zgKhbm13kgehBbqn81PfVu5SLdlvngBnZf7cAt733opD9?=
 =?us-ascii?Q?R8NlqxuuVoeNWm2XPrOOL3wP87RnQJlVCdpvu9OKQgf/feTeivEbFCfOuYj2?=
 =?us-ascii?Q?pfzzAGebHUkb2+G99NuPSITUAcDp+wNmdjjY1bl8Jk4BVIIvEcPs2kHVf5D9?=
 =?us-ascii?Q?epUmEx+su48zg9HNr5n6TQdn+E7Ax9gLY6ZuTSbVdHT2GbDcmb87ojreIK6Y?=
 =?us-ascii?Q?yRGECOi2lSnL6TG5pVgC3wh6thP9f+pLhTd2LwH08R/kJqyiPplTm0i0hW70?=
 =?us-ascii?Q?zoGUOFDNO250uj8dYbT1lwMu0fbMSZqhWVjbC3O+cpH0/l/k7iyPqgrm1qUF?=
 =?us-ascii?Q?z0GvQxxt/xOEkL/0E3mzykggyqzDXUE3vml3zDY4DnfdujgvppqkyzldoZxV?=
 =?us-ascii?Q?1X4aIo4glRuMprcd1WNjDQP40fnGLmPNcKmDqO0UBYQOvfeJfBccAROHWnsb?=
 =?us-ascii?Q?H3CmSjfETbRphRvFAGcIPCdW6SfKzw0s+bTEE9n/+XR8cBFQZAFjvYiYoFm0?=
 =?us-ascii?Q?Y6iN2kZ9odGVCGxlvhPe1DLRuDtGaQym5zOJj2MGIi2DQLhnU9YLFb0iTFkR?=
 =?us-ascii?Q?uraAsZtqbQPVxqmbeptSLcT/c4RMtwQgzE2O4cE8eDAMqFEh1zn5d85aHzvL?=
 =?us-ascii?Q?g/ZsdRFh4KayYA7YZmqyccEMD00GZLvpWVy9T2HVtGCYUR6JOZhF+hWbllnR?=
 =?us-ascii?Q?p98ek7x+Ty1qJUXbw74ryoB7Dt5KDrQMxGaTHPT7thmTTmuHXag/jIm83jxJ?=
 =?us-ascii?Q?hDLJGSMFcXW/nds9RqnQmarXua081psKOkSOAcB6djshZYusyMTRFdRl9ImG?=
 =?us-ascii?Q?D2aZxTHjVYLMPkKh6UL/iDWtCYb3f0ZYUZLhPf2WN9j3C+7KZQ4R3uac2Wuu?=
 =?us-ascii?Q?OUIxPBrFTHp4p1dDx/n7rKea45YR8GAlum3JAvklOu/XCq2q8X/wJV9BA3nn?=
 =?us-ascii?Q?IYzR6sD1UUD/FLumcHOgKQj4RUHg5gRwvvHONEvQYbQGyTOjqBLtlbWuYufN?=
 =?us-ascii?Q?T65uvGewr1163OF4AdZl9OA47nYtZBY1Xbqkp1FaYt4amsDmXR1wHPqdPVWW?=
 =?us-ascii?Q?dhyphbTb2FDFbAATe4MJy2uEvvX+gbLeEFDWqkSI5tsydgc+IYsmkv+SpvJP?=
 =?us-ascii?Q?r1BoborrCq3kUuoWd4mkNIsfvuITF6oC1swAk1Ra6O2V2LGPeaWeY2lC9pSH?=
 =?us-ascii?Q?CYj7xGYz6CEgiEC+tUudL+nkevMbiA4SFrNrrTOs55pKlClW/AiGWd5q7qLm?=
 =?us-ascii?Q?ebp0KaSgClfZKnNjyfuIIiofMxFvwkA4+rd8LRALelvSTQkI7hQLPKh8GmXR?=
 =?us-ascii?Q?qloDyWtX0DEqBLA3I1JsSK5IrrAAfBNjkHv0tcuGSNhyU3X6RviSWZoklFx0?=
 =?us-ascii?Q?v7DCPZ6TcCF33TWQZyrU9MzTDqRoQ/0lxggrRzmUrQ5z4xqzcutCxtFgOGz6?=
 =?us-ascii?Q?tZNhFUNUZVODvAdHuYZ4CltuzYvyQNCbnPgFz8AKa865HDq7czQr9Tx9MJiG?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df34b7ed-3e80-462f-8a75-08dbb1ccf612
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2023 07:10:06.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IF7mR5pD4QigzHpgPoFdQa7iSmTsAeqCpl7bNX4khEV/oW0DCZG8u9vhV0Yp9QLIxGKVf3JUexpcw7qhtkKY6YprM/IoeV0SeJZGVyvM2wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5917
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH 1/2] power: supply: bq24257_charger: Make chip type a=
nd
> name in sync
>=20
> On Sat, Sep 02, 2023 at 08:33:30PM +0100, Biju Das wrote:
> > Add struct bq2425x_chip_info to make enum bq2425x_chip and it's name
> > in sync and replace chip->info in struct bq24257_device and add struct
> > bq2425x_chip_info as match data for OF/ACPI/ID tables.
> >
> > Simpilfy probe() by replacing acpi_match_device() and id lookup for
> > retrieving match data by using i2c_get_match_data().
> >
> > Drop bq2425x_chip_name as there is no user and also drop the comment
> > related to syncing chip and name as it is taken care by struct
> > bq2425x_chip_info.
>=20
> ...
>=20
> > -	if (ACPI_HANDLE(dev)) {
> > -		acpi_id =3D acpi_match_device(dev->driver->acpi_match_table,
> > -					    &client->dev);
> > -		if (!acpi_id) {
> > -			dev_err(dev, "Failed to match ACPI device\n");
> > -			return -ENODEV;
> > -		}
> > -		bq->chip =3D (enum bq2425x_chip)acpi_id->driver_data;
> > -	} else {
> > -		bq->chip =3D (enum bq2425x_chip)id->driver_data;
> > -	}
>=20
> Do we still need acpi.h after this change?

Yes, it is still needed as it is using=20
ACPI_PTR.

Cheers,
Biju
