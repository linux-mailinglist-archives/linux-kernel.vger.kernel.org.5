Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E27DB623
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjJ3J2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3J2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:28:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2110.outbound.protection.outlook.com [40.107.6.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D11B6;
        Mon, 30 Oct 2023 02:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D483QjjDOSZhnqqfjkOzYrU812lhHHQ8NWJ18YP2+g/24cF/u/WFd/pxzJhObkQDQdfr1365TOqEZsfGxZUDwoYom0dj9a4Onn/QJ0t/dOJRKqWMXCeknmVsx5tekH2B0wz5VdCj7bWk69XyAbk1l4Cok4JeuxTvHn0x34l9RApTciqxLdQi8jLiW54cy9xi1ttxyF4HBdzQp7vbyQbly6DRS3nq5RSOqrEFnbInF53LYpMeM3n23dNICet5oH/suIWf4dx+v0pVzNSWqnjjGC6qDw0l8E5eNbDwATxUT+UNINRLrlrKyeBUgPM8PiTw327ZuApZF1EDV6298jCwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGB8F/H/NHpzcKkoIPyrGrexQmVj1MsHaBEAJyg1TtA=;
 b=JjRdv877lhOZS5l7qSNrzktzWKWrCX0+KAYkbblputNyO5XsgZ7NAJUwTUbI+9DIfeVq3TDpORRE6euv94choDy6MAFgdvBADna7TdVMHLMgdR4rLcIKh/mk+Iwn6vowTfRO6MzZkkCxYnWT2aDQs9Z3GNqcfI1iG1oMSzrf80OUgDSxz7Sfis5M/wFgSgGzz5Hclx2uWVaoQcXIT3nULwB3JOwlvl0qTgfC+qKTtKKCLNVkJ6c0mPMLGGQa+0nUnFHPOVstd+eek1RIP4IvEo9N00p95PXtWr3osWPexY71QWne/cPcioCs6w4XNJnfwZ+VRbZAga0OFIoy/UItSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGB8F/H/NHpzcKkoIPyrGrexQmVj1MsHaBEAJyg1TtA=;
 b=QSWElGAOMFA1/Ox6C5HzX9SrF56qaeagC6sDRuNVCboZNvNcRTZp4wA8ZuIwivk2RSjooLcNFanTY2gqQguLnUlI6Nw40DulmzBZjjVOir9EBoogNmBv/ISHdAdi+M9mrXpMwVD5HjgIKYcLbWBItQnHD4tWcKDZXhUUAdiZfhY=
Received: from PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38a::18)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 09:28:42 +0000
Received: from PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13a3:a50c:b905:5af9]) by PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13a3:a50c:b905:5af9%3]) with mapi id 15.20.6907.025; Mon, 30 Oct 2023
 09:28:42 +0000
From:   "Stoll, Eberhard" <eberhard.stoll@kontron.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        =?iso-8859-1?Q?Leonard_G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: AW: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Topic: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Index: AQHaCCByhlFLq4Q3qUiFonGDuLJz8bBcrx+AgACFHbCAAFIEAIAAQrOAgARCaACAAAa3wA==
Date:   Mon, 30 Oct 2023 09:28:41 +0000
Message-ID: <PAWPR10MB823946C2D201CAB2CCFCBDE6F1A1A@PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net> <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
 <ZTvbFc+kFMotVUkh@finisterre.sirena.org.uk>
 <ZT9tyDEBqwqv26O8@smile.fi.intel.com>
In-Reply-To: <ZT9tyDEBqwqv26O8@smile.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB8239:EE_|DU0PR10MB6827:EE_
x-ms-office365-filtering-correlation-id: 2492ac0c-d42d-4fa9-85bf-08dbd92a9b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvAZYAhswFZ5RzQTmHiqBGmacn1cxO/loWzDoK5fmRy2b4ovGENy9jKtCcRkGupDl+PnteFy4f/UWktervfRexW4L5fz12URr9SL+K9/AMS1/seBsqb8G7tnP7Y0r2WrbDD4gk9MlcojJDc/MdIa7xLa5upgugonhv2SRc3ElVbpDw9AzAm0dnXiS5cYAvDPGDdoj6cRERxbQQ0LJyJtTfyCv6kQx1cLPQAXV2KvLfncZKE93GUFftbLynmIb8NxYP25EKupB2uisUjQ3iTiQNHSI8vHAUQGM6qHWtQBRsuXAcHDFoaAgUuZHq4NnqE9P5qLHvtAkdrhboz23JKPYVjUNuZdKf0k31IlB7JUQP5eypYIvY/trrh1CJNX0/Ajixi8XW/X93p/hPy0GUEcV7x9aY2yFenQ/wF0bPKBZaCOq3dS4iOTikZfscmI3oQrfqNh6XdEh6N0jn1HK9sl3skKYTkmjoEEPdb6N8E2ZAFNoXg4Hx332O6Tn1Xo0uwLczW9wemgchHJdHsl0QzHjqKTJqxo7M/W/A+wQKHX10rowedGlm1qe0NFMRI60t8CkvlprRr7U5Bkm69t0hvJuBAq7TylPg9/OHYqb78MC32sptoirFsMNUzVB9heUsaH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(55016003)(2906002)(316002)(66446008)(66476007)(66556008)(64756008)(54906003)(122000001)(38100700002)(71200400001)(7696005)(110136005)(478600001)(6506007)(66946007)(76116006)(5660300002)(26005)(9686003)(41300700001)(7416002)(4744005)(86362001)(4326008)(8676002)(8936002)(33656002)(52536014)(38070700009)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7x6Vtrk87J2E9FGRGcrN0LK2ivWSGlxiz9mrhf/Zup9C3qTjsw5l4ofQrs?=
 =?iso-8859-1?Q?au38yF1FCCbd3z4a3gV1NZjUkNj3WZ3wVP4M42vaAP3knenbLLMWbEf+Gh?=
 =?iso-8859-1?Q?ooD4nuKQYUUH5mrR4tk/Kmzd0B/l0m4QwD9Y65tLgCU/euDLkSJTiEs5TV?=
 =?iso-8859-1?Q?foMe7Pl1bCbeM49xa/usNtdaUfxfhWFlbfPETnNGekV8iaUYuqKzaUZQVf?=
 =?iso-8859-1?Q?jaKZlk0piFt6J5nDQus885PbUSeVKBy9deVrw1CoIFrZdMOKrky5bX0a28?=
 =?iso-8859-1?Q?do4sr/Ca51R+UKUBUggSG9vNtQA+ZpKe/1Sy6+qnBir3te1omuEDolmV1T?=
 =?iso-8859-1?Q?EcpdgdnpXCoTPYLUGNkqTxqMhDEGvN/pY1T/pbAnXvXcATbhTgXolITRQJ?=
 =?iso-8859-1?Q?mtCyGv6LsKp9HnpXl7sbL/CfQ8udCi8KOpmY9zNFW4x/yfLTCW/tcVwzHu?=
 =?iso-8859-1?Q?gDN8koZIpOtY3fM3hc9sCTH+mrXnXbHZvNYLzoNJcPMLLphCqYQGUM5O0P?=
 =?iso-8859-1?Q?hFEDyjeZ3bCzY97YH2czxlBmwxGUc+WQ6CwYuiX/HoPI0xcjbrDCdqv19I?=
 =?iso-8859-1?Q?4iPUYqlSrAMZ9lwY/XfXjySNyGonB8Xeir+0Zaz6S4WgWbbTUWnlEdkSOs?=
 =?iso-8859-1?Q?vqNADU8oJ0316tGYJP5sA745ohR5HByGMDHGh80CF+lFnsk5WrtMmTJUtz?=
 =?iso-8859-1?Q?Zh7WetKDM1L/JyexpVqWNfsG6nj6/9sj8Xc8lXvl1HGhWakovfsZqFMvzO?=
 =?iso-8859-1?Q?caAQm86JjsBw25fy/fkUvY4+TPGUxy98jzH42KwUqIySTsV4FG8wnYbn7z?=
 =?iso-8859-1?Q?RgZujHLvpBIunY+TUg+uCHu2gMe7ueXPonhCBXfBSuVh1PoQ6qRcgm9bl6?=
 =?iso-8859-1?Q?IHpq0Hoo1YDGpeNUuN9AfV8SJ930Xe4RYDEqkr8Y9EKQBuHyuw8um8swNE?=
 =?iso-8859-1?Q?bgTaEsHzr3BP/3WNwGFNxfM6ReJx3emu1pW4EK6Z2sdoCGcdCG/LALsFJW?=
 =?iso-8859-1?Q?qXKYKzvODr3iaKsizkpMmzeyLS5Au0zL/7SBo0YgHVg6QpOowjS87Jospj?=
 =?iso-8859-1?Q?pMYmdN5t3tbtY8EgcEq8UUiBrWhqPUtVN/UZOqGMd7V+fOV6kI9SUwwRna?=
 =?iso-8859-1?Q?PTvV5/HVaumkYoDYOnEUT4egxgr9jlpHdSpgEeEVhwDjo/1aLB7Ytn4yNs?=
 =?iso-8859-1?Q?cSC7bHp6cFw2XIBDhIDu7I+R2ocLg3HGJCpfh5MXaowqhUARDpzn7a/W+y?=
 =?iso-8859-1?Q?KUPsxB17dtz8nI6QMf+PAHaYcKQXx2XAsOmnEW1RcSj9z1Jw6YBeP/10Q7?=
 =?iso-8859-1?Q?7ELop/WeyHrMvhNOG9oIdaPjjiwUNCoqwFZCfSL1yf/RL+zhuABx791lKy?=
 =?iso-8859-1?Q?lv8eqvytWx9KUmAJj1cfy8Ek06kjPlu+xyZW/xBdr9PKl5ov+TeFNyeFDT?=
 =?iso-8859-1?Q?dRqk5Y+TMRXZmVPpjTWZpKOo6rogaqaK3hA8kbPdoaNJwOO8xuJ9+sBvz7?=
 =?iso-8859-1?Q?4aMNInOSWsGZfX6aOcDQYIjiSPCe6DZgOR+kEXZ+mTk57bvJMjOaAZ2oiq?=
 =?iso-8859-1?Q?VQCWUxvB9NEtvmJE4JWQA7wJA8dekp8QA0u5CLNt/9eht8vwcTT0NGclYz?=
 =?iso-8859-1?Q?lU1bzZSQHlMxQ8HjZzWkmudN3Ev2XXSC7Q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2492ac0c-d42d-4fa9-85bf-08dbd92a9b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 09:28:41.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzH6lctIvccKoDeTObQ7kXCR9urKzb0m6TgYLrFshR/eZwWZ+9xRFvUrOHZa15OfDrVOx5Qf692JVgnUiC9Bp7OQ6bMBQFsBaZjB307UczM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, then the question is what does DT _actually_ describes?
> If we have an autoprobe of something that doesn't work on platform A and
> works
> on platform B, shouldn't these platforms have to have distinguishable DTs=
?

Yes it's one possibility to deal with it.
But I think the first choice should be to improve the autoprobe function to=
 work
properly on all platforms. This offers the most advantage for all. If this =
doesn't
work, the DT approach should be the fallback choice.

Improving the autoprobe function in this way seems realistic. So it's curre=
ntly the
way we should go.

Kind regards
Eberhard
