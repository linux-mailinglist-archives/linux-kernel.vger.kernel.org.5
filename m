Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2427EC71C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjKOP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKOP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:26:16 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B79C;
        Wed, 15 Nov 2023 07:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvq/UvcFBEp1JAU5fLtOiN6T4uTy7+XMZiEowMQQG5I/x4SKvhHoZ7ef0Zxt+Szo6oeCYZlNClu8hVV//Bp6cHCgRVg091k3iFuYlL4o315A2USC43/5rExhGPaYMU2yOLF62SAuGGJEC6LtNX8zHOYKgEzhRTcNiKuSub5aPC07+a8EPdfxqCBBcKOYzZgCWIWGbawtT3WAMe6FejRK6+v1cF2kCtceV1+gedEJIB9j0FeUrzrmsa2zsihLE+xPZB060nNGfwhj/X2yBp8BE7PWJwY0p/NVAAvJge0P8ultY8vrebdbjDkAjUwFVZuyz3CrGY0fRYgznMwp4tUuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytFXS/ocKxMAjDtVC9HHxmzxupVmSdBUDDfd6e6DaXM=;
 b=n52OrPpAMJrV3sI5v9ZmPC7HyT6ZuHCqEI+k1FZ/Nv01sM5jz5sog0FhTdY1wEf47+Ac+o93DGGHXcAnXVhgveDabJztyJZyiJbE9JNV4u+U18R6gxSiS6ys4FFq0l0r6KSV73ZpkUZ4wUvOKaq3W2q9Fu1hZ8sxear6GHlgICLFkQhpooi4J97XaZt+DEF+QtizpJ7iFbkSbRoH6X8G0LZm4p/3+kWxy6NnhOkY4PZnwUEe6VIXfHAgdLz7ZpOqR/JKiDZy0cWSpgdtYFDKAz2WC5dE1ibiEaxvt7TP4XXkZLA4hoBrZoP2ddvbPiCSkJCkTWGPYBM/nCuibGIkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytFXS/ocKxMAjDtVC9HHxmzxupVmSdBUDDfd6e6DaXM=;
 b=Y7197CxaWxmuS4SAG9w++wEVz6DSKsHQ7jeV0Q8UEunFPDexraCqCFouJMACGwd3aZH/l7amMFQgM9SAdCd4jTp8AYDHF2mGK0WrFt+RRJQLnsLZNk9u6MItkfgsly2HKbR+3GmGjW6rVoyFesu5Z7hevH9iWW4e1buVuEGVack=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB9622.jpnprd01.prod.outlook.com (2603:1096:604:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 15:26:10 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b%3]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 15:26:10 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Simon Horman <horms@kernel.org>, Min Li <lnimi@hotmail.com>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v3 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHaFkk3eRH6MefMLkCKQYiqHXoLmrB6NqSAgAFM3VA=
Date:   Wed, 15 Nov 2023 15:26:09 +0000
Message-ID: <OS3PR01MB6593C3EAD4DD26695242D812BAB1A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <MW5PR03MB69324AE8F4C54FE03BD93A55A0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20231114193439.GF74656@kernel.org>
In-Reply-To: <20231114193439.GF74656@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OS3PR01MB9622:EE_
x-ms-office365-filtering-correlation-id: 53375e54-fe50-4abd-f7b4-08dbe5ef31e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlbGY0HDEux30YaXCiI3gjOUePA7ICXdOqCc/ugXEmo6GJqryXvc9sJa8YKdzdRrj2Q5Pui3SoIkNXsZBCDCA30/gaifY8Rg8pnpnpPkwuIpl18uPMEibYCWIE4cX/G0oBm/DFCVzOCSNblLJjzluzAWTYQ1qqhXmOor8hoQRGyzWzegzl7BBBvgDJP/HIrw05ttLL4FQIucju4F0uoXNiAASUlbzATzIq3NQdUO2TGwlsQFYEqUvsmzn/HqzUv0+UO8oFLpUgofPNafPqXouSIPIcI7wA6t8G19gtJxAT208iqu0O0+RfZOXWqiSn3h7JlcBQRrFXbb6eRezFzxRD/uaiumbrLJsane5bPBSteJlapRJl+pTrEw5ZbmezT2kmUYZuUU8bELDtQoNVCOk+AMEvstVPgKsYs8uKsBrDHvfFb9RRceia17bbcZ6WAywq7gH4O8Bw2G4ty62kMcXvpsKIHcnqAIC7S996BnXQIRSalhzWqP6U/H+HKRAoTHbQx2VcEMu5m1zPVaW+B+eu/ZS0bBeFpDwYbpOyOj9jvckNRVL4BFkfCQqfcPqVOSbK4vihHGulwKav3RB80hhem+VVksB9okQckCRmFUTSQHqbyHB8CGlYzzPZTUXG5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(122000001)(38100700002)(26005)(55016003)(9686003)(7696005)(6506007)(55236004)(478600001)(86362001)(71200400001)(110136005)(66556008)(76116006)(66476007)(66446008)(66946007)(316002)(64756008)(54906003)(4326008)(33656002)(8676002)(8936002)(52536014)(5660300002)(2906002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oi0mHZeTivz1cwI97Et7Y4qBjglBLriClGKiNWBZNjXprQJ4SearPj7gjJ5S?=
 =?us-ascii?Q?Ogcon1EdDdey/wwG0TWIPGNOfiebti96vJIJ6bQXTIQqSEghRCFS8gX0Pft2?=
 =?us-ascii?Q?V5uvcz4z5uUUP9+fD6fPvSl3pJ8nH3+UuV3eGYiYbASRf9Kthx4sHD2Xh4M3?=
 =?us-ascii?Q?E4cb2wTqdZgs9LAjx6/53OPRQrRle9N4gvm6IYNw+RiiO3J9L/IYBj5GABQM?=
 =?us-ascii?Q?1pAcwYmNT714ZCyFXWkvCHgZtk2b09iKQhyWmX1FjFKG/Jt8ZhQiprK4258w?=
 =?us-ascii?Q?dmj3kMluKCttzZVd6CLwwqZ24fp9kHq+u3x08VUhdZWZVz944xGz/gN0yOh2?=
 =?us-ascii?Q?aiJBOp2dT9nlK26r8kRIdBb6PKKqkmmv2biul01QE2exD/q6UCFmFfp4oLM/?=
 =?us-ascii?Q?0UEE+Hh8HpMC2UeC5+8prZmP6ebnXTNhhg+090D00l9F1rcHvolgx6qyqB/d?=
 =?us-ascii?Q?OA84R12ks20HbA2VXyYs2L5WFi9/43zldb5YfpUWa4fDCle8SxBNrnW2uPZL?=
 =?us-ascii?Q?m8KTrXFpsCyb+7Dt/uxjKltSIsuUHegQq+3MvvABwAJa/+Rah/cKiks1PsIZ?=
 =?us-ascii?Q?2GMQ/0RdPfXpS+PkC8rFpVU+qRBxXpofiIuIqHSPiDzGfJ/cKe4HllrKLLrU?=
 =?us-ascii?Q?NQpJFxJ2hSxvTstfdcn/lY7xasEzVKUs8LvLvXwFa1+z3R9FTNAE9AkUNfn0?=
 =?us-ascii?Q?uQoI/ieDb2C2DtkGszj1CYyCtvUzXqsTR0nIE8Kw0FgWuihtfPxrGFMYDUa0?=
 =?us-ascii?Q?2srP4DCXJG7TR1KcSeZ4jieFR7/jju5NUuJ/rxRL6npQ8ZkdTZIh7JbGV0D1?=
 =?us-ascii?Q?FgHN1Ny9X1BNWW3xsGfuFU5DI6Cjmh76ZUimWUTX4e0b7aM9KsyVG48sXoIZ?=
 =?us-ascii?Q?eTxefeQr15yFH5ofN9gwFmg0lLnNA/josvLnMGZI1aJKNrcIppnrUroviWHd?=
 =?us-ascii?Q?uhyJmDxGjBhYAyCm+ZF9P/KeJqesGRFtk7Wuohbo6XMuwXGCz62jSqG7l77w?=
 =?us-ascii?Q?wjwe3togXhZbkEsx6+sXucYw27Mz6UVniXr+0ps0waIGvkanYFBISqXst4Jy?=
 =?us-ascii?Q?Fu+LgbC7OOlS5IBbsnOiqSECnEiZjubFzqsDz5VVlPiuSRIyWNLVSmH+0irx?=
 =?us-ascii?Q?kqGMBNXVYiEuQrKrdn4FFZ1kl8v13bkyQk+9ZA5k+YhAyBnhUh/5M77Pw3o6?=
 =?us-ascii?Q?UgMSchG2ABa9OjrLtXriyJ/NEqHJprWks+Ikm1VvDfNncwRUx9dyk30rJm7T?=
 =?us-ascii?Q?Btv9aiPLSfbmlGicb0LAevxm0utJsvychzcYJ28Ii5FqFjf9k8gSaECja668?=
 =?us-ascii?Q?jL6GRXQiyBEHKmInkVuYqDLpnvYh+zQnG/GO93cw0bYlkXARobAs6P8QeXL4?=
 =?us-ascii?Q?VRj7Ze7+S6nUekRnvQPbV3OkRV3kKdL2/bO5UtsZvxP2O77zru1tr4tAL4dE?=
 =?us-ascii?Q?eTNT8n9++HXlu6w2pMfveQfRPANFRmMRuI5cyMUIbVfLIDDw4iaOUKEuQXzi?=
 =?us-ascii?Q?VgYdidj29UykZNMnq4X0bmVXWCk6jVid+fgDu7NYffpAFmCJOmY7fzr7IW7x?=
 =?us-ascii?Q?D6yGFPvT/QIfmsD3onWjZAlezcwgajQYuX75cC+0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53375e54-fe50-4abd-f7b4-08dbe5ef31e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 15:26:09.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1ZKE3UgKRFTKi3sVSBiPhtkaT7CnWQ07odKecfrYe69chSdPWsPD2eB0v6s8+mOKgZ41ZZKPWuvoAgRLKvUFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. idtcm_output_enable() still seems to pass a 16-bit value as the module
>    parameter to idtcm_read() and idtcm_write(), which seems inconsistent
>    with this patch.
>=20
> 2. Related to 1., get_output_base_addr() returns an int which either
>    encodes a negative error value (good) or a 32bit address (maybe not so
>    good).

Hi Simon

Thanks for pointing out those errors. I fixed them and sent another patch.=
=20
For the int value returned by get_output_base_addr, it still works because =
The expected addresses are 0x2010xxxx so they are still positive for an int=
.
=20
>=20
> Removing IDTCM_MAX_WRITE_COUNT seems nice, if it is unused.
> But this doesn't seem related to the rest of this patch, so perhaps it=20
> should be a separate patch.
>=20

These minor changes came with one patch from our side and it is related to =
the change due to the code that is not seen here in the official Linux repo=
. So I am hoping to push them all together.
For easier maintenance from our side :)

>=20
> > diff --git a/include/linux/mfd/idt8a340_reg.h
> > b/include/linux/mfd/idt8a340_reg.h
> > index 0c706085c205..b680a0eb5f68 100644
> > --- a/include/linux/mfd/idt8a340_reg.h
> > +++ b/include/linux/mfd/idt8a340_reg.h
> > @@ -7,20 +7,20 @@
> >  #ifndef HAVE_IDT8A340_REG
> >  #define HAVE_IDT8A340_REG
> >
> > -#define PAGE_ADDR_BASE                    0x0000
> > -#define PAGE_ADDR                         0x00fc
>=20
> Likewise, cleaning up PAGE_ADDR_BASE and PAGE_ADDR doesn't seem=20
> strictly related to this patch. Though perhaps I am missing something obv=
ious.
>=20
> ...

The same reason as above.
