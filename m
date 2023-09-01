Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23778F853
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbjIAGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbjIAGEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:04:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FAD10CA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA7TthsMgyEgwhszCoE3dMlGzAtDYQmqjV0GO3eSGIJteIJYZIsbcUkZk6Y1thAKC4fxebuSQtTZ7MGFDHRhrVv6Y5kEaPVFEVxCA4L8s6FvHYkR29R1kECRvOg0me0JzEiSVJFqIOtAo4VG7IHOM6wrsNCYDPK1RNfQgZD5mo2mPF/6Cu+GUPjzey/obyzHSODf0KoJZTsH239O2hiWqN4LVX+G8y3okBqTkAEs+GpDWEdM84UwKGPAoYlyo7oGZXg6lVEV2DrX+w6wiE2/EkRH+VnV5pMFSozt2lj6aBAvV5pB7b/yZXMlWR/NuxGgg7hL044KiGAFlU8X4WCjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGYkt/TiZpbkX+LRQOAdUAzxM0F25cX6vOtZ1C1vfcg=;
 b=gk7RRnBlU4K3lYL810/6K9vJHaTvLS2D7mnFWkPHKjh0iGWWLy4WET/rPMtk9OOVvoha4yBvTOfhXavHfBk8brojLthuLaBwF7QbwtfhNgkWoYJVBPnae4TTyTbqzsVnamsVnXAu0nXuxoeJMX0cl/Fwaq+GNX2sMXJIuQpwu2q8FsLZxLfNcsJtCuNvmu/KyclZrpv4tu7UNFcVVfYMjPhAzsdZ1qQYitADOH6gYNaxIX+DyU2FzC7FXm47M2oy5Tj1fzDnUjDgEtP7Cy+smHfhnMK+nwyDIks42tQTPoX3N72v7t5cBkOo6JzxIMRLQ13UbkWo3GyY3ialrbzN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGYkt/TiZpbkX+LRQOAdUAzxM0F25cX6vOtZ1C1vfcg=;
 b=R0YT7JM6IhA0SSOygEoLPxTqc4TAGuKyNqsXk1du4hqJjljDOyn/3+ZcHo4pV+QUdw0L0/Y1rizgTs+CtR8oUY+vrnsRhdO9fdRSMvit2X61YhuN5PJrRa+VLCtwPALd2+xdur46m/q25Iy6+fRJuVNC4aAQZFiosDpmvS/g/ko=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5386.jpnprd01.prod.outlook.com (2603:1096:404:803f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 06:03:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 06:03:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mfd: max8998: Simplify probe() and drop
 max8998_i2c_get_driver_data()
Thread-Topic: [PATCH v3] mfd: max8998: Simplify probe() and drop
 max8998_i2c_get_driver_data()
Thread-Index: AQHZ3DsBG2p1+8xI4kGBV3U+Q9GGG7AFByCAgAB0AsA=
Date:   Fri, 1 Sep 2023 06:03:55 +0000
Message-ID: <OS0PR01MB59221E89480DB1C2FF86141886E4A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230831184309.67507-1-biju.das.jz@bp.renesas.com>
 <ZPEc/S2GiJM/S3kF@smile.fi.intel.com>
In-Reply-To: <ZPEc/S2GiJM/S3kF@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5386:EE_
x-ms-office365-filtering-correlation-id: aa4ddc5d-dcfc-4d6f-fca9-08dbaab1398e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5GdIFn90sjs5ovoReBW+TCQmqt0Qy2QjC9/UMLTNGHn0qnfKx+cXf0oCH/SK2piu5Hsf7GDbViyA1IzWwZXy4+SbqYtxM+we0KVrpfFuQshp3kW7vG5VCWMroNdRHl0ag4Ph7JlJJiU1l3ykZRHzfj8ImWm9sdFCLqU3kQk9PZISBceDwUxWJobOCdQkZUJjJ5GMSjHmQI1QdWlRXTf1iJB5KmCxT+oBJ4vp8OgMijyvtEjA0gk3gAli45Dejx+e0feZavp13AsJ9rLNnaPI1CuyIy4ggzE886m9RQz6v5lEn0VQfoy6YrSJ4R255EteM7wqG3BW6J82v9q88q7yMP1gd9RXKO2SISAu2cJvtASD4ZxDwuQEL2xOpkVwEe5/xsgs1Vw0IoEA+0rZqrUAIUmSHD2CNu54JImu9t3C/z8bpx0k5JjOtqvv6et903pyBE0qOM0gkkC8Lchr3UwRkmdL6btSR/R2vaQMoCHV1VH9o6ho7vdE23AsKs1uDxw3dUV5K5rCZ9hu6M3JaoRkpckx0O0KwDOMUmq1WNL8q7ap+VzusnTy63DWCRJxwLUU3Ii+dnD/2IbGL9bemC7JkqjSE6LhX6DkWN1JdNrigt00KFYCBK3PlFlJvFLtlfmR5ettieGDdUCWWCnoymLVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(2906002)(8936002)(8676002)(478600001)(71200400001)(4744005)(9686003)(66556008)(38100700002)(54906003)(38070700005)(52536014)(316002)(66476007)(66946007)(55016003)(6916009)(66446008)(33656002)(122000001)(7696005)(6506007)(64756008)(76116006)(5660300002)(26005)(41300700001)(4326008)(86362001)(70780200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9L1w+hUkam3d2rsg4XjzyDECXYgxUyLKgdOjjVyJrwA0BkKBTWjE7YC0hmZ1?=
 =?us-ascii?Q?OJH7nJnARD27/1abvHwf2COJlQKA8UwUEGxoE69mUJXWUXkPNxHKE/o0Dw6f?=
 =?us-ascii?Q?t0UEYbTC3JSAtJk0TkTIbvOhVrS8Zc//Aa4SGyt95UDoUT51P+TqvQCTFa/K?=
 =?us-ascii?Q?ffmgpMIrP1r2QC937F7yApMsZ+fGIwd7Z0UBgcH3W23S1Vc5QgEFc4zQiALQ?=
 =?us-ascii?Q?+FcYAHBaGp3To78gQybUO2hXbRNryEmBgNJNsb97W0+7XzMNkxKMVmsulVnN?=
 =?us-ascii?Q?SRecs4dF5WeR/r0ejGp0FuOjyioF3rIXP/dIEZ9YBge2FijwdJV9xwNbyDHD?=
 =?us-ascii?Q?13PbF3UUPrEk7S82emQR/m+wNIyGoqGOkvNd+96KgXosNkfFRtvEdvZseWe0?=
 =?us-ascii?Q?F2U8y79JIeO8nNAfCtg3pzFLYCw0fBAL+CwYLcs+OfQAeRZwGSjcew4mE6Sg?=
 =?us-ascii?Q?WP8GQpCF8exakhtnoQxnlq4p3kcj6pUtvVrQXqjztleZGO3zeWz+5UR4aTyv?=
 =?us-ascii?Q?V9O2ObRAwtOReuRPPYzEIaHRZkmZOLsEa0FN2H42i+//sbm9FaLrtt0fFVyA?=
 =?us-ascii?Q?n0ZwpAZ5ykFSN9ZjsqPsM87G8o3az1+60w521iezfQpI4OgKQXnoAsM4HzBe?=
 =?us-ascii?Q?c6Mjn4wFSqVyABnEmWC8ge3SKhR2bHk/13J7UGsnDH77vWyMS7wZGs4b7jbc?=
 =?us-ascii?Q?BCOM4cVv50B3F0d+xnFOBShpo3VAlHPLE3pF+0x+erB8okO5jI3O7vlmODJH?=
 =?us-ascii?Q?CaL/zSlGDze1aJxWP1BaGxwYc8SRzrjmoMrZMXLELLb6c0ee4L/rhDqGugJd?=
 =?us-ascii?Q?jNitds+43+NLrWkf7qkG4qkH6Pk4/MOUyJx7N+XjuO2zUDdVL/BQcuigQzSX?=
 =?us-ascii?Q?gbu3Cdjzj2NzdS8y6RXqfcQJ31GrYnBD8VBTLHKyDvYDeBcAHJl/Zwko2L33?=
 =?us-ascii?Q?piubMuofAKFA4gjYyiOVyd7kk+6gArpS9Hj9Ntr7MGUSdT9eoUaTfM6MyVJ5?=
 =?us-ascii?Q?3eAMCwc9kAcdJTSVavpL1ufvbs+9wm/nt//xWS+ruKjRKKNTQDo8B61crmTs?=
 =?us-ascii?Q?nnV75KrsJ/rGWKVNjKudS9wWcjNebiyMLloixyorJ2I56w6Xi7T1OSF7BZ4n?=
 =?us-ascii?Q?bIiVccY20/a25HKjatEcLf4lvtGeBYs5r7Gt+TKA3PZm7kwg5Z0GWCNyqPma?=
 =?us-ascii?Q?k497eYDbcGwD8/FOeG3x2XcKcI/apYYIT9xCGbzreKF16fSeqXlIidOtjnL7?=
 =?us-ascii?Q?CTKxiin/Yz8nC3OfQFcNBWSgjOWCwS52E4xBG3j00R6oduhHLxm0/UYUQk0W?=
 =?us-ascii?Q?23Tj+4ahlOGcEjmhex2w7BccnK2aOKwtifoRE/VI4ejTackojmc/txH1WNq+?=
 =?us-ascii?Q?BDONPIOA+SpIkbndRtWY16GneINHqeNssQDsnOadxJtUWSDD+mU95x1Zunky?=
 =?us-ascii?Q?ARJdPNtIgImy6XyM04JjoaGPS+8946zZI8oPDolkw/ISvv/OL+2cOP2gCOzW?=
 =?us-ascii?Q?pCoJbbpwzA2qxelA1YLHWBu4nOmuCrI6DF7TNVrjIhiJq0jnm2zwJZ0Y0OCO?=
 =?us-ascii?Q?TyINCMTacFAAaIwbJM6pPj4f2ZaeaLStDA5GvnnnVdxZDe6QCInJZM0W89mQ?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4ddc5d-dcfc-4d6f-fca9-08dbaab1398e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 06:03:55.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThMCBU63xCw5sXddPaKHHB8gMJ8tcTjXgsD3tbI+0WfJtgehHiAaO0ClkT7NqHLTGxhCv2QEqQ2yaMPm5znmz0hf/ctVe+21YektaQrmHqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5386
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> Subject: Re: [PATCH v3] mfd: max8998: Simplify probe() and drop
> max8998_i2c_get_driver_data()
>=20
> On Thu, Aug 31, 2023 at 07:43:09PM +0100, Biju Das wrote:
> > Simplify probe() by using i2c_get_match_data() instead of
> > max8998_i2c_get_driver_data() for retrieving match data from OF/ID
> > tables.
>=20
> Haven't I given you a tag for some of them? Please, double check and pay
> respect to the reviewer in case the tag is missing.

I missed that from mail and MFD doesn't have any patch work
to see tags quickly compared to other subsystems.

Cheers,
Biju
