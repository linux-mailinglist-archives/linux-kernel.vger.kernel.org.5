Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA479735F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjIGPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjIGPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40061716;
        Thu,  7 Sep 2023 08:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2dzY5m6BF6ZOLJhBZlRrkcv3/fY0WoD/8BRAdI17+a56TLCBVue2WuHYyf0tyQg6o4W9yd862woDX+iW/RsZ/+m+6o6aw5XyvdlnnMeWAiXGE8dGq2vxJY3DGF+TZXFpfj85Ui6SQ/v4DAZuGIA3C4VpPr/VqtG9vBBE4nQy7MyZJHXzSenlKx7OEJo7esoKpUlopfsKBqRInFABj8lT9+STWBdHwx8dSyM//fvnxVD3RNz94xJrcflVfLaCRFu7xOzvoenlKCPVXJrLVDoPQxM0XsYJQAvTPlecnA31J9uaRso/RU10v+Tyo+T5kuQ/Xolt3S0URp1eZBlw3MjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxTLc5Dvxkf2F33/rb3bvJy7VuNTg288G5SlQBiMfdk=;
 b=kYo+byUqoczPk8w2eASBydv6iuiYv5KXn35oX4eOa6TByWZz9JeS2XjPduPAtXb8SasMNDaQcmSKDsNeY9hJpKjiPNoUDL/tsmiz+COPbxS1V3WtJ3pz4UchG4TYu+GkzcDgwqYZWBLs53VOA7LnXq3cuUp/IqVmvPM4L6kVo2bdTwdiLSKqxhkoYH22YwFZvJBVrxVd27gWTPe9WLTt8i+Aa+KLwXFFa0b/MTN2cBl/MJtGNxvNSarTSlPYzGb/o0JPh2S2y1wFXtamn3EGTAbvNEckkegaQ+SVBi1/cWc5/ti6HZ8FA7CiZ61bwFlfwZEqfBSI98KrkTdP4JcDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxTLc5Dvxkf2F33/rb3bvJy7VuNTg288G5SlQBiMfdk=;
 b=Har3VgFvwtx5gcBzU2KASWfkXMxgrro+O18g+JWHYuGp/Lg7JcZQbNn5ttsZT6uqEJdt4uea3gE0qI6lgIfF2FkV/EEwx14dG2fw3jayZevvnP11qzw8a9APXHqfZSqpYsRIqhfvPSWreA426UW9+LH6LxtHz1zm7XvJRMs0YYyEn98LkdhRI2U/KdFPoJRfUXWdaU1V6yWom6styXkExuwMO6mx/QwHuxXF89KmmTPPiKfqj48hz39ub1di4Pj9A9llb+DElIn1NYWts93kHxWnHT8bL67HUSz2V3ELnV5ZO6LI9hrNYhJMu/scJ0yOBPOXcjhloai3+o9m14ghuA==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEYPR06MB5038.apcprd06.prod.outlook.com (2603:1096:101:52::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 07:24:56 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205%5]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 07:24:56 +0000
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
Subject: Re: [PATCH v8 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Topic: [PATCH v8 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Index: AQHZ2z4BCgYXyLFfhU2TpGaED9fRsbAMgHKAgAKBe+4=
Date:   Thu, 7 Sep 2023 07:24:56 +0000
Message-ID: <SG2PR06MB3365982279825C98859FF1768BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-3-billy_tsai@aspeedtech.com>
 <20230905170735.GA3528724-robh@kernel.org>
In-Reply-To: <20230905170735.GA3528724-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEYPR06MB5038:EE_
x-ms-office365-filtering-correlation-id: 0478c14c-c563-4c09-5b06-08dbaf73894f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0ivBwBj9/ddv3jhq+VyRpmP1EwFSq9Lu0ctkjWkMnSnluP92uazF+4SQEzZs0avdWUiBQ4xmibyUjxAwyfBqkrkJl5FBNCoODS/6cqrdtffyf9Zrn79gXzzMH4mrMr7aDxeGy+h7pxgHvRa/y0fvBtyZbNgyma409GfIjfgLi8nsx7LcnhVFOlh73jkOFd6CtDqQCYQcXnvhX9nTXeg2/K9/LcoyvhsdtXM0mzPPo23aUMmu73AMOViARO2XZ5GQ69W7jKYmbf6cEEwq3YVHGhQul1iMc3s9fjCZ08O4vowYmQ9+D8Zp1DIT5bSgSaYWMLtrexx7MtMErJN0NB5PtgyIZSK84+NVwHY1MoJt+q3Yw/7MtYzi/8gO18sTwJCHeY9Ukh/XDdGV8rAo5SLH1OU+Qdi3d1P1tlZ8lvbImWIBt3Ys5wC48Vbo7k25GWE/p1pGnHRrrPbVfn+Ydxw8in+9L36UynO/8fOOvqSAGn/mj4/lyZrne4CgymmCHrDXvkhnCUf4S5shIXzBWbGZftCmFX3Yys8D+KeJu68rdztEY1shp6LLnGIkiZWo98CTI+cMlPiICbI4Z/At3pDhIa1YpM/4VV1anxvIJJuioH6uO91Sy1Uy6NrYPC+2Y+v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199024)(1800799009)(186009)(4326008)(52536014)(8676002)(8936002)(6916009)(316002)(2906002)(66476007)(91956017)(4744005)(64756008)(66446008)(54906003)(66946007)(76116006)(66556008)(5660300002)(41300700001)(7416002)(26005)(55016003)(6506007)(9686003)(7696005)(55236004)(38100700002)(122000001)(71200400001)(38070700005)(478600001)(86362001)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o2Hg9QJyumXkMfa8NUshFscUB9EMoPRhu62KFNYGg0hvOg5vITJT2iu4xm?=
 =?iso-8859-1?Q?yK8MYfOct8gxwY3jgI6iu9ZuglZgKhf86Lb6kbcwMIc1jHLVFrEN+OzBaD?=
 =?iso-8859-1?Q?KSkZFrwDmoyFzk+3qzCodKxE0TZBTtw7dbhEBkY4X1RBUUOrEha/Kzw6pD?=
 =?iso-8859-1?Q?gZ0N9+V0CUwiy+A5Sz7R6Lul7tryo0WKeBDwFBGkP3Oj4VsuMWI9FwDlWN?=
 =?iso-8859-1?Q?91f+2JMofKN0AxbfNRROYHrDNi466DhdlqUmKClVKyk8v0huUlat1++8Y0?=
 =?iso-8859-1?Q?obiMhMY4R9MimxRdjY+GutWaWdsCAm+2GmDhdS+FzwWErwIYRqKpnEEg28?=
 =?iso-8859-1?Q?uUC34LueFIicnoe83o3VVOBHNBZfws5NGhyipofDxTQC0j8/VT0/Bd/WxS?=
 =?iso-8859-1?Q?3hVQO7PlIlXphjX8zWnI4pNncGmXDYFJ5BTjoIaSiTU8rWGnbhhPPYQulq?=
 =?iso-8859-1?Q?buK6tT0QoWAqMicv6Xlsb5BaOGxHcBdBmFOpeeinfxTUUgVWKdKsM9tiEJ?=
 =?iso-8859-1?Q?rdoXcEaJAdE0kQIZ/UHmr8JYGPlWXJO7aLGzrzbTJhiwB3G8cyIfwyffbz?=
 =?iso-8859-1?Q?jTTRhReOlRYk5mKjXz85sreowOPXmdB+oppQztUXirx9a1XbqtjA29Rzik?=
 =?iso-8859-1?Q?aHDDXyBmZ4rz3R1bMJrJ/U9+lytNIq15G84NPSqWJhR5ZWUMViJLPnRfzh?=
 =?iso-8859-1?Q?w6BJ06IoVThiCaWEVPolXJ+YWv23SX2K/DmQJDHcvlvuhr3DhNm6wZW8u/?=
 =?iso-8859-1?Q?/4gcIdutg9lSQYjXZrQq9zZKWKj+SwquntRR8Dgzwt6LscZCd6GrC6llsE?=
 =?iso-8859-1?Q?G2+z8GwtFEkKUWdqkSNm7Bm+3Zlo3LfKfCQl44CwXK5gboJy1jEMX0dW5Q?=
 =?iso-8859-1?Q?SwsC9k1XdKiJgqk06tprxFKzXruxyHi32bqQTdqwXosJYILsisGIdxjhJF?=
 =?iso-8859-1?Q?st59TLjWMjYWiSjjKXYTcZ54w6EmurgzbyyQp8hs7JF7RMZnc7VH2Uyyfz?=
 =?iso-8859-1?Q?t7wNv9/U5mCHLJA+jvuUTAKX+7fwWEtePsDpPVFCr9w0FT4DKgzSkcDB3I?=
 =?iso-8859-1?Q?CVKizVsyjcOvOBg6JCjqkLFgjALVmPS7VGCgOooNWImIgT/0iqxKfneSRM?=
 =?iso-8859-1?Q?LURvyZ8w/N2iU21Q8sPfl06dnG1BXte3IOw96Dr/K2yksPZVhNfSKXc99P?=
 =?iso-8859-1?Q?YnwHYFMN6+8Opqdn8VZKBGeBYJsTe59Ggqv86zCG8bIrR8HuaX+yPcKtEl?=
 =?iso-8859-1?Q?IKK/kukLuPIT0NLfmalh/AlkXu/KGcY9ColcGF6+8RkJ2JR2bKntxB5ktv?=
 =?iso-8859-1?Q?08b3ztkrMKoVAjciqEz9CbvYA1JjdKFdKhEGIx4G1pN+U//EkBbhBgCvvl?=
 =?iso-8859-1?Q?/HKEOHeaHsvZf2DHS2efWlUu6Ur4ScRz7B82c9UCymFZ729qAyqIWGpBry?=
 =?iso-8859-1?Q?hOtJaY46Mf5AoBujDq18rJ7UEWo5IES089AzY7/PSTyx9Md9ltPD09bEdM?=
 =?iso-8859-1?Q?0btODF7tkSPyqaC5NxES0LLXJ2v8orWPxKTKfdQOvlBlFcf14x78I0su0o?=
 =?iso-8859-1?Q?vuZc4L6IXiASuEnP2eHwXx1kSLWkg+spnhMX7xR4pImkZu+9/27CLPJy93?=
 =?iso-8859-1?Q?2l8teYECabgd6eFskRhSNv/MDG5CmODMNJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478c14c-c563-4c09-5b06-08dbaf73894f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 07:24:56.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmuBSMn1LhFFJi9Jq/amSVdDtXco2AUOO9myfwwZERvL36+l+5Yb4+LjRQSOhXWLgrbLwMgtZeHO25Yxw42SlTmitQlLvdLalcGXbTo3oEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +=0A=
>> +examples:=0A=
>> +  - |=0A=
>> +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
>> +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
>> +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
>> +      reg =3D <0x1e610000 0x100>;=0A=
>> +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
>> +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
>> +      #pwm-cells =3D <3>;=0A=
=0A=
> Blank line.=0A=
=0A=
>> +      fan0_hwmon {=0A=
>> +        tach-ch =3D <0x0>;=0A=
=0A=
> Don't you need 'pwms'?=0A=
=0A=
Yes, I only want to create the fan monitor without fan control.=0A=
=0A=
> +      };=
