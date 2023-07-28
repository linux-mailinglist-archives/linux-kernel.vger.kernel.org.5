Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004AD76637F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjG1FGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjG1FGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:06:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415A2D70;
        Thu, 27 Jul 2023 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690520798; x=1722056798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=La8BKB/Ok04WVkAyRVxapsIWREpCl1nV0s68FaNuXk4=;
  b=XGFNv3j3Quq068XF+qW9bgM25tzEE4p2f3NhbKOB8oEn3WiKUfqjuIuH
   D5NX6P22mbsw+QDAqQncIU7/AzgS2GXDlZ4PdVW4wbzEhIFYm4jhtg0Jg
   drdI06KoGLWcUAYCfiyOcDADvVqUB5JgK7k+nVNlIxyBFIEfyACHyMf69
   lyavZOFYAc4r33598M6bBzxMbxKbba7e76kHqpf1vzYHAW9rFhSpHPMt6
   glCCkJ8EfzMo3FP5sj9qyFRRWJwggsCin4Uo+eOH/C/o6I6tCLlnLeLTh
   SPovSner5/FUM/v2Vz3UJz2/dmP3XAcexaNd4hL3/GjMmNN6uNMYBhYfD
   w==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="344455428"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 13:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBxr2BaP4EYmsneR2oHgq6oOH5A/rBO4XQIj7jUTiLvIQQLPgyq4oQcsuD/wuCtRqDSwoWuCBCAu99d1kbqMErBNu3nWA5St1FV5N3hBEbspMHViOC+GVitYXRwCKFKUuACScMQTUdvfK/2KQfb0qPJPk5PIRGq7hHvSj5GiWfcBkM/5B88winDtpz3juJLhyORBHY+g4O7BaNl3O+d5b/aTmpK/3BdHXiHgNtWctlMSK1WoKbATmfNTkm5gYDpIufMuM9NoKbv/PR+W0qYvYJYzKv7Jz2T6vM540tA/I+UU8we25VJvOpiHvEghjF2IouM/MEyCo50L9l1VnhoCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21aEO1Dca+s6dHSd4tfSlWlppECuF1gcIv6xTEtsxMY=;
 b=XZCJuVHzGHyxK6q6+ZUNlt+qaNQPeiwFjlIDTJzL7OdDBx6qVjZVdc/k2TR/OCEL9ACFSINqV8P8DostG6RiAE+0HsGIBh03pFYO+6fqtwsD/iJ/WNGDolFLCD+8EgyM60fDTlon18yj8JDneD5RmYLdX3N3q61uyO4pcBJR+Q/TvbOzZlnOMAgcFipNYPSZFphryjg6nVnjfGk25GIrj8ZOG3X5SQrOKWKZTWUplQCl/UuXuzuqzJD1h9x8dVIKfXLyWcpji0aA6mU4tQ+NG7MZurDCHzSGpJxtOu10HHQm9muu90fVbFqpy+jECIIU/4fBW6Z+ubMJpqayxjiCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21aEO1Dca+s6dHSd4tfSlWlppECuF1gcIv6xTEtsxMY=;
 b=pX4o+EMO2CRuosmzsOQa2R5F/Ubyg45HBEYpkFOPXaq9l74MdkCP6HYHnD6Tl2xTzwwFXhVt7oXk8JeM45GPhWfPy3C444xUZipbmRRFGyxCEU+DZIFhSmKMvn1j63U/rYBlW6Tgjw94qz6RthjbGSaCHIZ5HBDldaPdGJmB8dQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8119.namprd04.prod.outlook.com (2603:10b6:8:2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 05:06:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:06:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Thread-Topic: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Thread-Index: AQHZv79EpGj72imkKEOvomc2O06946/MIqMAgAERAgCAAIgcgIAA5zkA
Date:   Fri, 28 Jul 2023 05:06:34 +0000
Message-ID: <ky32xyzyii2c5fr7kknyx5z6fikvh674v4sw2s4yux52l4vu7w@4nqmrmyxkwmw>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
 <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
 <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
In-Reply-To: <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB8119:EE_
x-ms-office365-filtering-correlation-id: 3c3cfd70-d984-4b12-ef75-08db8f2869e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnZcubL14OZEM6u55DqH42GN1VbxLFjQT0uGVQ1lAjOrKyotlcvJ05CPE/XiG6yat2gJ0Ig0OXfJArUD658yHCGiLareCs9ln7PuunhgwyDu/Ic0RguXTF4teLzZDLRDe65u++0JzBOx24DQpgdlMQpyfGxXqfzCrvwtWjZF7SAL5oyE+rJ00Vn34nil6o/zjMU53ChHswoL8vA8uBTH0rYTSEqrPMy5LDeTyrAKI8XfFehPjHrBet24mWkg2VBIS3JnnL8bMoeBA4HekM6+dOZsCqyGqdmjyYVF+rqZRG214OIvp8snPDXTIIWhgzyvUo4ONpYQ1V4s6A7H26S3uDfBaNXj2zVwZBA3TmNVWBhji3P4rYDJlOKO6a+OgBKQl+s/5hbnk5iwp4aR/zXiBNuMxZg5tkKv3c3LVZ1fD3WnErMKi1Yj0b24uDh8tnNUP75HM99QEzzvG3e0R7OlgPQfWYc3MEl2BAfyfmcDJRjU9PIdeJ+dokuD4lvoPj8vni03TH9xK8O6pCjtfy+Evp9cfc3/a30873fns3SdkOPpz4yVtBmc4Ms4CtAXIql+YrfNeH2JF52EirwaSDYAe5dtr3RdBfHjKwbRJlGPQxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(41300700001)(38070700005)(44832011)(33716001)(86362001)(6512007)(6486002)(71200400001)(122000001)(54906003)(478600001)(82960400001)(26005)(6506007)(186003)(53546011)(966005)(9686003)(83380400001)(66946007)(91956017)(76116006)(38100700002)(66556008)(4326008)(66446008)(64756008)(66476007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hkop6Dg3XpFOggF07zGbmM4xPYIKZ1FGf99+Bfhf+Lf37kMzIg8Q7iF/6dXT?=
 =?us-ascii?Q?tHF9PWwwmUoAobit+m27oo9od8Cq63SPzYnLd9Q5rBOOyFqnI3ltyaIfOn1A?=
 =?us-ascii?Q?eWCP9w/pBBVsRqWGy+DbKNjFD4uJW2bol7HKm654aYxFWAhNFpZwbdYi01ab?=
 =?us-ascii?Q?A5u8R4aZjpNGwCfRipYf1Ocb4ZuY57Ck28iZccLxWHw6vFJ01Y0WWRKM6jQ+?=
 =?us-ascii?Q?JqCf9ZPGUgOxWaGVhUIuoQNbB+ba7iMOmEvEnel3IOePXNQP/G4CrIKpJwrg?=
 =?us-ascii?Q?A4fHpA3WtE8hx1wBnpkI/8UTPROPYv4m/yYxWD6J5oWAJFWv6mJ4TS+6mZmY?=
 =?us-ascii?Q?EwVx89VlE2yUR/eZdy3QEvfRf4PaJpDB3jPVQvmLBL1ytWq4YhPGG5HjtYvZ?=
 =?us-ascii?Q?OmWkF/n3D8g1ZhTLTzn6JZNxgAvogQ7LJGKwyWeNKcpq/lObncY+WNEde8jp?=
 =?us-ascii?Q?ec25oxzP5koTOHpqwgYBJ/x+pcfCuKbRG8QitBJA4Lu9tdcYMSoqMPFpcyba?=
 =?us-ascii?Q?sUnRJUsiyq15tLw5inRA4/XejOqAIsr/fOnnhRL/aL+ec9GYqetex8jxNeGj?=
 =?us-ascii?Q?2xgq6v1Vl9tTSC6iE0UW+yPyqv/FuBWcrEPR9YMEW7I9FW4Lpue+EZkVBgzv?=
 =?us-ascii?Q?cwdGrdVmM8fUWZpweywSMsYTFBLDC0GrQyRV9Oao9UPfHDFFuCsxk8Ut7rvu?=
 =?us-ascii?Q?tvlnlHnDrR2C4I3VvuY5uY27a0vW3xW15DMwSEYqDsCyCE+hZXvz8Zqmyk3P?=
 =?us-ascii?Q?zZsW9yhAOS72UgAiraJmL7ou8NuEUE3Ylt2kV8Wv3rTx5a0ytHy7PEScjE49?=
 =?us-ascii?Q?hDsUX8AZVvudfFBCQQh+Da287ogI6ZkBqRRj6hkbrh/VvMtwcAZlXE+2cDgL?=
 =?us-ascii?Q?jHofrqvbhj+J1Ic2Rq0nRwRCDZ7vUNevzDw2WUqriDkBc3dhFjs62gAaamaf?=
 =?us-ascii?Q?y9cL9/0x1dicjrj98zOgtm4SKqYUKzUouP7nvs2VvEbVc+H05wP0TzvMtWeW?=
 =?us-ascii?Q?dUd7O4DIRqKtsDU9ShQYIxBmSouaugie02Pmz0qy5tvYZUBhJGvM56Wk9Kw+?=
 =?us-ascii?Q?zbx4nflL4CHTvqIs2G/qlDklTKB45Y366RiyulEySUWxn+KPEGYSxKaqK5QX?=
 =?us-ascii?Q?PiFRenVQb7oqSPFr0+Crooj7liVapFFetYGjLgwqk41NpQVQOVuBQowLYU+l?=
 =?us-ascii?Q?OzN9XeRnPOuzbPxMUCY40R+io3L7XWVLOmEI7KNZgTw8/KQHeXsa2Fu70kYz?=
 =?us-ascii?Q?63k1X80HbvAyjVNVIiqiqV8pWpp9wVdX3xg+2U4mmiHbEigAAho+8Rjvl6Im?=
 =?us-ascii?Q?165PKtO9RMI2j6Fs0UubTLdF9y4YhB0vnNXdDYDNfEsvqAx/A+CkiznmVa6N?=
 =?us-ascii?Q?JrMlite7dFe5M62EHNoaRPk3BBxJzRShpHi2aR97rPJ4zuQi+QdcEmXXyVGy?=
 =?us-ascii?Q?zlUwYHoLHAqHQ+/yWx0gH1ddQA1zx/UliS7eblYjluYCNfqdeSxkbvRlh+mJ?=
 =?us-ascii?Q?mjyrzYZbVJNm9sa1fdCySsrDT92R2EmzuXTPa38ziv0k9amgUR/8Rp3B8OiJ?=
 =?us-ascii?Q?xk3lC6NjmAQdZhwkmeDv5qgC8Zc37GZfmGTFjZxihP0+hOqiu/ZBY2jjY3QW?=
 =?us-ascii?Q?MSDeixvpF3+KQKKlrEkAn9g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36F5A8830207EC4BA90091848C866EAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yQbHx3VAvNreg8EXA5U8a4CxqCZBD0HoRAkBBemwtlpo9JoNYB0a69/PhYdj?=
 =?us-ascii?Q?kJ3E0yIZ1EDmoJwo0pS6Tpk12SyLp4fGtGi52/2WcgyEiJr4YP792zzIRI7G?=
 =?us-ascii?Q?mr/smpfbGShLD6g17RMz5NTymwhm8+zSX+y52/XTGBz+VYJs+UAgBQON5m8h?=
 =?us-ascii?Q?GAVtxDwaBypI6nVgnsI8nKDJPBbB05H/rAhXbBaOqLsE03lIXgoBzhlB6zdu?=
 =?us-ascii?Q?Iqzqw4YV7XqJHiOBmHuivtjLK24plLtzIF18nPHV2prh+MJDMPHOUIpDEjVx?=
 =?us-ascii?Q?OBonz62OUJwUyqjGGfWDdkPkmAZkMW0I5KhKlnQpA1exIPdtybpBgM2AMIQd?=
 =?us-ascii?Q?9SJI0raoBSeq6m7BB87+Qds8Sbf8kNbJp0izcsFxqSEP9ixwkJGjU1U5XXm3?=
 =?us-ascii?Q?ipp4WFOqDVmSuTE0idbPzukF10V2S2GOfEtgHANBrBZ7Ia2gapFxT1f3/MNg?=
 =?us-ascii?Q?Innt8dAgMh5kc8Woep5kmvA+ps+IoPSg6hC6nFU8/Z+3TouTA4qQWzz7QFXH?=
 =?us-ascii?Q?9GuUgxGtNevbwRL6DHDmzvHjphDKIKwXMIVOdqKNwPlPP4xxJG5AD5e29Wb0?=
 =?us-ascii?Q?1fwv0nQEPyShFkP425sBykNpjq5oFe+OjaNIgIgXj/djiqz5GhuIXJboPQCL?=
 =?us-ascii?Q?ldsw+rAzM44I3DiZBLEnvm27VN2nDw9wJWT3mSEcsSgnISzOOnKgzuQa1YsK?=
 =?us-ascii?Q?llCwwpvX+tJ712Z+0F/VUyJyEnASAH19TgN3Z8q9Uyv/lCRuXqcvQof2PfgZ?=
 =?us-ascii?Q?38U+mxhJoTTqOeOq6CzSYXQq4QYis5t1PVkaFNUimNAnCGBacsr8g9cNiP2N?=
 =?us-ascii?Q?5AZZsafN0YQgG+FsFgYe7PHaC0EVQhrggqdZKTVFvaYTN7qo6U/a0ppz8MsO?=
 =?us-ascii?Q?4Y72Ur2eACQWplySo8rHw02LUM6ndmN7HKGrB6GlCBQIgT2bz44WqcMlFNYY?=
 =?us-ascii?Q?twvPQWEv1eWXF9mwRc50AA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3cfd70-d984-4b12-ef75-08db8f2869e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 05:06:34.1247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeRgU/OEiBzB9AL1HcnU17bqoKVNXolLVKT9B9sezyWCIqD72+jCjdCTGXpe4dJ2pROcHGgOl7MgxeVtRgs/bjT11q4gyA3CsJbsjFIPQXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 27, 2023 / 08:18, Bart Van Assche wrote:
> On 7/27/23 00:11, Daniel Wagner wrote:
> > On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
> > > On 7/26/23 05:46, Daniel Wagner wrote:
> > > > Group all variable declarations together at the beginning of the
> > > > function.
> > >=20
> > > An explanation of why this change has been proposed is missing from t=
he
> > > patch description.
> >=20
> > Sure, I'll add one. The coding style to declare all local variables at =
the
> > beginning of the function.
>=20
> Isn't declaring local variables just before their first use a better styl=
e?

IMO both styles have pros and cons. Declarations at "beginning of functions=
"
helps to understand what the function uses as its local data (pros), but th=
e
declaration and the usage are separated and makes it difficult to understan=
d
(cons). Declarations at "just before first use" have the opposite pros and =
cons.
This style is easier to read especially when a function is rather long.

In the past, I preferred declarations at the beginning functions and reques=
ted
it in my review comments [1], but I learned that this guide is not so widel=
y
applied: xfstests scripts, or even blktests 'check' scripts have declaratio=
ns in
the middle of the functions. So I think both styles are okay at this moment=
.

  [1] https://github.com/osandov/blktests/pull/99

More importantly, this discussion maybe going towards "too strict" guidelin=
es,
which will discourage contributions. Similar topic is [[ ]] vs [ ]. Once I =
was
requesting strictly to use [[ ]], but it did not seem productive. Now I no
longer request to replace [ ] with [[ ]]. In same manner, I suggest not to =
be
strict on the local variable declaration position either.

As for this patch, it is not required to follow guidelines. Does it make
Daniel's refactoring work easier? If so, I guess it will be valuable.
