Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376C79846F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbjIHItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjIHItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:49:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5672E1BEE;
        Fri,  8 Sep 2023 01:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YobqQmROvwANhzjtRpHGG3ML1QQlNtUr1WiEvKysZeo7ep81Xz5xbRw3EQJU/rZhpD9dqsEKifks/Fh3HjIYOAcSrlgCM1Lt0RVFx2xuX7dqtqb0b0NX2D7WdswNfhymNzHGOeEwBefu1plyewC5z/qhcnXZn8ZluCJFIzTZBRJzjXaaWRuXI03FtzxiEzPIqV2QhEtSJ/y2UsPfccAFrE0GDCfpMpZI5eZqUFntEPbmTTPd0ngJelE9Zj4eJVhqyuX2XHgGPdjybd8Lwf3/JWfvHHOQHO/BdH5azzlrinIWMlcyficiQulndmnZzcRiGzntULgu+UFJ6qOEDt+UBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/sryLcnlRCdI6AMY6X/AxgKrFqlpkF7HkBroAsp28Q=;
 b=ChuMp1jaP1tWKiOXFRvsNC9nx/GKpax/6YaLJGggMoxg7gR5vt/OAhJAWi16nBHUbnM7hPJUybYt7rrWOb6OPmZEwk59ObXeUZ+WQdwZyI17NXUNexaYJAFerc1thiNWp7zz5mrcRygv8rpwvOfilFo5WDG071KBEAPPVXLliSsbErQxI6Y0+FPDkQRwopDdI1yV3bO5Ac3SShn6UjNhfk57TKSNGAHraeQJtZeLGYfuO/t5ZmTzHrjUrGwtoCQFuV9otqEy5v4F+mTmZQRsE/rfc2a5B7PySXCVveoCQDMnZ5qoYIoF6lSATRi6YsEBS87sUTufQMDV+K9MJTtk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/sryLcnlRCdI6AMY6X/AxgKrFqlpkF7HkBroAsp28Q=;
 b=ZlJ5AnakE/HLdhk9NfbLsZ2vGUX8+1UpnlMjtUtbogcFzrCMKDNDC6NAiRx+gSIhqpOKUr6sIM/uH56/wjR+MUntwU0iO0OimRg9mHFeVAemiyAaKgm2BpveX1FwOVJAXoPqqmSdLIe57M7j9reVwRjSoVdKSdAItOBKOZuabkd7fRzhkcFkICHAny/W0uYDsxnXQplSpuOz2owPxozGelcNFuWL2afJUsJTd2gs6WK87Trnzy6bsG4Rx46+HmMLXFRKYvz32KnHpx+lfqQ1pNVSSL2Nf2uR7d8IMED8GH6nbNFld5wCEHLkMK5xCPbBhaQ9bWHwb66+9dmTwZdoxw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 JH0PR06MB6342.apcprd06.prod.outlook.com (2603:1096:990:11::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 08:49:25 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205%5]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 08:49:25 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Thread-Topic: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Thread-Index: AQHZ2z4C+uKKem1S50iGi7OYH9WEnLAMfl8AgAKBk6KAANDSgIAA2pqv
Date:   Fri, 8 Sep 2023 08:49:25 +0000
Message-ID: <SG2PR06MB3365B916E3AD2CE331A0D4258BEDA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
 <20230905170010.GA3505375-robh@kernel.org>
 <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <20230907194351.GA2033402-robh@kernel.org>
In-Reply-To: <20230907194351.GA2033402-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|JH0PR06MB6342:EE_
x-ms-office365-filtering-correlation-id: af7ee160-e128-49e8-05b4-08dbb048814e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QB0cFEOBJI6LQSjrXzyq+mqMgn94pxdccjBrebOBKspGfEeSDIq5hBUXSM7CtfMv+KtGcSvamoRFA4Iuu7XWpZ/QKBsGJdLSx0raaY9eb9Y01Ndcw6aDagRzot2vyiYmd5SS3lyvZ5TWN1XnhpuV6uXn+N09LBItD1L5DeFIZAwrYKXyN8JKmpTUOEWzqYWnK9a9pGryQsWvTq+vjHEz8ktQ5n4lTZ23fD3DVJBISR0uTwNSv+qvUVDmhZCw+5YSxw/QwWT0fehtt8vTyVC/6QIO0MHTddz34QGBkwhRebbhwXlbv8OEeFN4DFq3tYF5I6lhqHrxUglrj53Rx9RNa1tkH9RP//90fgqwOYdRT/iUcTYPeTDTQnUr2ZRKIoVkVu8lxlLSCfoDh6db5yI4rkrx5k/BGILYudAR/UbbS4D3lrR+1Rs0YQ2QqPxTH82WLHCMRZxvVP/u65PDJeD+v62g2oxuIsGmHOQPHEYRa4CY+6ZKmsyskINcSRbNED9j8T358E7x/hGIy7D0fXXrLoMMBNv8pvNINN1KLVEX34k4s1d7JLQ8gGTHMs0SaijDMd2YuEItZ+aQ3uJu82NhCPOD1SIhUfGJCfM0HAsiGTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(41300700001)(9686003)(71200400001)(7696005)(6506007)(55236004)(966005)(478600001)(83380400001)(26005)(76116006)(316002)(7416002)(66476007)(6916009)(54906003)(66946007)(66446008)(64756008)(66556008)(91956017)(52536014)(5660300002)(8676002)(4326008)(2906002)(8936002)(33656002)(38070700005)(86362001)(38100700002)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cBy7xRqLUgJHE3SgGYqkxUyoH45asUHwOf2PTPTMkJ8zomFfH2LIB/39yF?=
 =?iso-8859-1?Q?22z7DSqhd3Nq4uLVncowUDmIb/gFxziPMH8wcgRqKHOIE+o+Sy03ASnVzJ?=
 =?iso-8859-1?Q?Cg6wZ4Bx8E1VEcu8PBcl5AS6s+n96lLP6aeE3IvmGRHSHO8+bnVmp8st9u?=
 =?iso-8859-1?Q?Kkrs0CJlUX7VmwGluTOMpsUK1v6YAbEFecTtZxilS2nEy0agNVQqzhpWyZ?=
 =?iso-8859-1?Q?O28x/CuzVkSQAMC9CVjQIVycoueaUvgEvDzNKzjZBxb14yDFwPSD2qUyno?=
 =?iso-8859-1?Q?DtNezY3SK7Mey//87ptNWVkT3EhmhNUdhmsxfCoCzvaDdkhpbxHAhKNxZ7?=
 =?iso-8859-1?Q?+nZjbOHm8nv0AVozlVKR70+Zg0eeothcgH8TihyawCYRtW6n1jPrPBPHQY?=
 =?iso-8859-1?Q?P3p1wunEeVXGrhxymzD8ceH38UA198yIfA65jPslpqQDqpCs/nwzQJ9Oat?=
 =?iso-8859-1?Q?wnlntleR8V5WyYH62+FkbTg6C0EZbkbDBtgOMD8Hj3/Q0eOCJchXrsU6NH?=
 =?iso-8859-1?Q?SjLk1liCOxToruOi1ZwF3n7YcdmJAhYH0VTdAFKQE8UvrIN8Xz7vG+sSg4?=
 =?iso-8859-1?Q?g0rVzZUdD0KDIxOC7quwPToaD6pfY9exY5aaH4UpU4pyLdSq1IrH+ZiFV0?=
 =?iso-8859-1?Q?BjtgqFguO3LEo2hLS4MWfc++eZutvuvj2XyUybBL0sho8YAqpFxXCT+iTC?=
 =?iso-8859-1?Q?HTO/GfL/JG+FogSdm7tJur7W0jeY/bl/j6s/5ZEAJEc0rf6qBJNWpJiZal?=
 =?iso-8859-1?Q?/lBXEPbKvxFXqnUXtMai9IoHl1UXCIJvkAGA/Qm2kB8+ni/WygkaVGHGkl?=
 =?iso-8859-1?Q?EVu4itNnO8uDzp1tYXC6rn+ge78CDvfqkMbeyBaVinU4ZFNnxBMMw0nMwM?=
 =?iso-8859-1?Q?86BystXV0/nyiEly1IUNL+a8w9oxja6Ui9OmTpgLOzO/IKuQux6NLRCYIm?=
 =?iso-8859-1?Q?hG4uK8meguERYb9iqhKDdgs23XFcQ8Kv6GxUCs2+J+vTkKG+Z6k7SOPwUb?=
 =?iso-8859-1?Q?hg64mjoj9f1bCbM+V3/qNfFiQHNCak4Ryg/PD74fV/hzIO8Y38Jt+BSTsx?=
 =?iso-8859-1?Q?J2La4Tt8uYFaC2teU+jS5Z1sY/sv+Wfhvf92V4Dgt8Pa7uhz6AlB8HFbn9?=
 =?iso-8859-1?Q?qRa9cXwIEN3PV/AC4my2HJMpXvy49PvoaQMuIeFodyHYaIo1eZGjAUgJTh?=
 =?iso-8859-1?Q?6cwedilMmXyadfV1veHqxGHBRvuYPVq7LKCVs55bzpmi7zpgrHj+tWszC+?=
 =?iso-8859-1?Q?G0dXvEwhh73v4vVIIpwn9XECSm8sRvW7jwW4mg/B8PjZA+U8QcBjhkdwM/?=
 =?iso-8859-1?Q?qO3pZ+Ni16f7jFy8r2KLBD1suqSDBzgsgWw4AnHOcL1F/tNHW0gXJh9dAe?=
 =?iso-8859-1?Q?wGVm6PSM42p7LDohiUwUTVxc5VDPofuZVPvkxS20kALrz8LiuGRsdwnRSz?=
 =?iso-8859-1?Q?gvxsn42ggXnjpTzgZK2g/tk9b3Q0zt9yzbA1gwj5gZgAg35ZRGT4FLrco4?=
 =?iso-8859-1?Q?ctIfjRBN0gi/LKdj8QARspLBfeJzkGyyJua2k0rSFGObVyh3Uwqc7SdZ4U?=
 =?iso-8859-1?Q?eW/kQNTsj9DoHd6lBQNe3J4NDTDl1hzQtFEzwwPqj8Uu6B/VXuvnx3VFes?=
 =?iso-8859-1?Q?7I1skqiD9syEFF0P1g35cWZQVxaFd/n0Bh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7ee160-e128-49e8-05b4-08dbb048814e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 08:49:25.6552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/yDB/vKKga/qxBblVIdsQZjHOKejk9H8HUGa4Q3M2iDerSOroUx/S3qpxwCyGay+Hue5r0GHz6lljpkmTFya8G+QFxSEXc+EzDHDuZkOyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:17:55AM +0000, Billy Tsai wrote:=0A=
> > On Wed, Aug 30, 2023 at 08:32:00PM +0800, Billy Tsai wrote:=0A=
> > >> From: Naresh Solanki <naresh.solanki@9elements.com>=0A=
> > >> =0A=
> > >> Add common fan properties bindings to a schema.=0A=
> > >> =0A=
> > >> Bindings for fan controllers can reference the common schema for the=
=0A=
> > >> fan=0A=
=0A=
=0A=
> > >> +properties:=0A=
> > >> +  max-rpm:=0A=
> > >> +    description:=0A=
> > >> +      Max RPM supported by fan.=0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > =0A=
> > > Physics will limit this to something much less than 2^32. Add some =
=0A=
> > > constraints. 10000?=0A=
> > =0A=
> > =0A=
> > >> +=0A=
> > >> +  min-rpm:=0A=
> > >> +    description:=0A=
> > >> +      Min RPM supported by fan.=0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > =0A=
> > > ditto=0A=
> > =0A=
> > >> +=0A=
> > >> +  pulses-per-revolution:=0A=
> > >> +    description:=0A=
> > >> +      The number of pulse from fan sensor per revolution.=0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > =0A=
> > >Needs constraints. I assume this is never more than 4 (or 2 even)?=0A=
> > =0A=
> > Do you think we should add the contraint in the common binding?=0A=
> > In my option, the limit of the max/min rpm should be declared by=0A=
> > the binding if necessary, because the usage of each fan monitor is=0A=
> > based on the connection of the tach pin.=0A=
=0A=
> Yes, I think we should have default limits.=0A=
=0A=
> Unless we go as far as a schema for every specific fan model, then there =
=0A=
> is actually no way we can have specific limits unless the fan =0A=
> controllers have some limits.=0A=
=0A=
> The most I see in tree for pulses-per-revolution is 2. There's no value =
=0A=
> in more. So set the max to 4 and then if anyone needs more they can bump =
=0A=
> the value.=0A=
=0A=
> Or maybe there's some electrical/mechanical design reason fans are 1 or =
=0A=
> 2 pulses and we'll never see anything else? This document[1] seems to =0A=
> indicate that is indeed the case. (First hit googling "fan tach signal =
=0A=
> pulses")=0A=
=0A=
OK, I will add the maximum value for the max-rpm, min-rpm and pulses-per-re=
volution.=0A=
=0A=
> > =0A=
> > =0A=
> > >> +  div:=0A=
> > =0A=
> > > Too generic of a name.=0A=
> > =0A=
> > >> +    description:=0A=
> > >> +      Fan clock divisor=0A=
> > =0A=
> > > But what is a fan clock?=0A=
> > =0A=
> > This is the divisor for the tachometer sampling clock, which determines=
 the sensitivity of the tach pin.=0A=
> > So, if the name of the property changes to 'tach-div,' is it acceptable=
 to you?=0A=
=0A=
> That sounds like a property of the controller, not the fan, so it =0A=
> belongs in the controller binding. Is this really a common thing?=0A=
=0A=
Yes, I believe this is a common feature for fans. You can refer to the Docu=
mentation/hwmon/sysfs-interface.rst,=0A=
where the fan divisor is defined for users, determining the fan's sensitivi=
ty.=0A=
 =0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > >> +=0A=
> > >> +  target-rpm:=0A=
> > >> +    description:=0A=
> > >> +      Target RPM the fan should be configured during driver probe.=
=0A=
> > =0A=
> > > What driver? By the time the OS driver runs, a bunch of other boot =
=0A=
> > > software has already run on modern systems. So this value would likel=
y =0A=
> > > be used much earlier. The point is that when exactly is outside the =
=0A=
> > > scope of DT. This is "what RPM do I use in case of no other informati=
on =0A=
> > > (e.g. temperature)".=0A=
> > =0A=
> > So, the description should be changed to 'The default desired fan speed=
 in RPM,'=0A=
> > and we shouldn't mention the timing of the property's operation in the =
DT, is that correct?=0A=
=0A=
> Correct.=0A=
=0A=
> > =0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > >> +=0A=
> > >> +  mode:=0A=
> > =0A=
> > > Too generic.=0A=
> > =0A=
> > >> +    description:=0A=
> > >> +      Select the operational mode of the fan.=0A=
> > =0A=
> > > What are modes? Spin and don't spin?=0A=
> > =0A=
> > The mode is used to indicate the driving mode of the fan (DC, PWM and s=
o on).=0A=
> > So, if the name of the property changes to 'fan-driving-mode,' is it ac=
ceptable to you?=0A=
=0A=
> I tend to think that should be implied from the parent node and/or other =
=0A=
> properties. PWM if "pwms" property is present. DC if the supply is =0A=
> variable. We could also use compatible strings in the fan nodes if =0A=
> there's a need.=0A=
=0A=
So, it looks that this property isn't necessary for the fan. And it should =
be determined by the=0A=
present of the driving source. is that correct?=0A=
=0A=
> That reminds me, both of these modes probably need a table of =0A=
> voltage/duty-cycle to RPMs. I imagine it's not always a linear response. =
 =0A=
> Naresh also privately sent me (don't do that) an updated common binding =
=0A=
> which we discussed the need for this. I expect him to comment further =0A=
> with details.=0A=
=0A=
For this purpose, we should add the speed-map like the usage of the gpio-fa=
n, right?=0A=
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/hwmon/gpio-fan.txt=0A=
=0A=
=0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > >> +=0A=
> > >> +  pwms:=0A=
> > >> +    description:=0A=
> > >> +      PWM provider.=0A=
> > =0A=
> > > maxItems: 1=0A=
> > =0A=
> > > I don't think there are fans with more than 1 PWM input?=0A=
> > =0A=
> > Ok, I will add the constraint for the pwm input.=0A=
> > =0A=
> > >> +=0A=
> > >> +  tach-ch:=0A=
> > >> +    description:=0A=
> > >> +      The tach channel used for the fan.=0A=
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
> > =0A=
> > > The existing ASpeed version of this property allows more than 1 entry=
. I =0A=
> > > don't understand how a fan would have 2 tach signals, but if so, the =
=0A=
> > > generic property should allow for that.=0A=
> > =0A=
> > Ok, I will modify it to the uint32-array=0A=
=0A=
> Perhaps uint8-array to align with existing versions of the property.=0A=
=0A=
Ok, I will modify it to the uint8-array.=0A=
=0A=
> > =0A=
> > > Perhaps 'reg' should be defined in here with some text saying 'reg' =
=0A=
> > > corresponds to the fan controller specific id which may be the PWM+TA=
CH =0A=
> > > channel, PWM channel (deprecated), or TACH channel. I think there are=
 =0A=
> > > examples of all 3 of these cases.=0A=
> > =0A=
> > I don't think it's necessary for the 'reg' because the case you mention=
ed is=0A=
> > already covered by the property 'tach-ch' and the 'pwms'.=0A=
=0A=
> Yes, but when we have N child nodes of the same thing, we usually have =
=0A=
> "reg" and its value corresponds to how the parent identifies each child. =
=0A=
> We already have a mixture using PWM or tach channel. Yes, this can all =
=0A=
> just be in the fan controllers binding, but putting it here would just =
=0A=
> document the options.=0A=
=0A=
Ok, I will add reg property for the option.=0A=
=0A=
> Rob=0A=
=0A=
=0A=
> [1] http://www.comairrotron.com/methods-monitoring-fan-performance=
