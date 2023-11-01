Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DB7DE728
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjKAUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjKAUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:47:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18010C;
        Wed,  1 Nov 2023 13:47:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A1ATdFW022665;
        Wed, 1 Nov 2023 15:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=OadY20jVyDM4P9PEaptbbhcmry46167GjtNhtQnrs
        pw=; b=igQQSqxWPtg7yZaFFeRhSK/sRE7NRXdz6rbZltwzE6aPKdxjBHxoXJ0O/
        jxZuIOWxl6zGPoIGXteu41/Jz9/Epi+b663KrCnEIvYpF80cseXk9iK6p74UYcyP
        nyjCh2PcPRAv80T3zRGJIdUKwHTkBrmlloCsZD3/jrCQxFd+yHxW4BjHuMsARpjD
        pJO1BgKGhWQJPvcYFxTYujz2tv4YSovAjeQQxmjzSQNY0WgsbJ+URJPBAjMycn+U
        TNdjMBcQnmpTCfSiBnn1ve6+Ib7O6mD7pnlf0iBvflKFL1WjovGwg1s2ivYXiq72
        t5cJtD9DoO+7oVLBiXhHsYwUlQn3g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3u0ypxfxqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eowh9r85TXcE850B++qV6xJ75v9b6dKUA0rIPJtpiFWBy0Fm2qLS25aMFt4qvUCUZwIhA207Vo0IFBmghYift/Qv1RBr9R01beHrKGBg/WHfQUW8i/jXXO7QZ8eHCV/HQ1UEN8uXT9an3TNGokwfKtP6SP3xtQS1iOxT9heqxN5oF1rp8oNIbK1BUsAp/+vVS70nDFPgATSZNuaGB+gm7Lzo8n5Kw8Tee/1KDeYok1OaTt1vtZ6bVGTX6d/YYDPKg+3lFNZLGSxxVIhwUhh02Eku4Nk1jURUlKrmFzgA2cm0w12gWsAv8z7lI5SelrqjnC45DjKdDQ/PwcRiTmaBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OadY20jVyDM4P9PEaptbbhcmry46167GjtNhtQnrspw=;
 b=dTdD6NcxcmmyADq0jZK4PM8Boi6zfuO++OkXQ1BKt42Pd8vN8vQZHmk4iRjMHVptT22Fhc2yizyWtpVbVy6J6L+kW59mqWj93Axf79e2Eo4HEEcmQGl7fulBKRQb55Sh0O6modHHrCHl+w3Sx+nxDhDQgEHD2PVe7fkRiuhQYDYfRsBdHH5D98Tpmxb09hpcfQN2Fdf+cB4688XI/rUPq0SpVVAHDkrzZF1icb+qEnsi2fpVs/Ux57eUfTz1Miw43XGstvXckdQGjtOCF3PF54HwDfv9WFrxzN/EJIbjaFKVRLR1rBPPVRmYdPks0vLWk8SrGeDSeYOaio8fydqOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OadY20jVyDM4P9PEaptbbhcmry46167GjtNhtQnrspw=;
 b=NhicppRuzi4QNyxg8e7H1sxrAZ3djSmb8ZoHBUBeoirKg8qlX76ZluaviHeefzZmhZlS8BycukUy/11FP7wfnPU2MAvvSvRw1lkBhNCvpQS8cOLZHqN3ho/UDUtJvUONZod1UDULyBoahn0sBvxnyxBcfPx8h+tih+VdAz+2buU=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by BLAPR19MB4273.namprd19.prod.outlook.com (2603:10b6:208:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 20:47:11 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::afe5:fe4:70fd:e67f]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::afe5:fe4:70fd:e67f%5]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 20:47:11 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Topic: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Index: AQHaAeyf+2JrjyX4UUi0J9ryDkVps7BZ2eSAgAwrY4A=
Date:   Wed, 1 Nov 2023 20:47:11 +0000
Message-ID: <C3E444B1-4BC3-4C30-AD57-051B6B804662@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <ZTiD5VUSi65OK4VK@nixie71>
In-Reply-To: <ZTiD5VUSi65OK4VK@nixie71>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|BLAPR19MB4273:EE_
x-ms-office365-filtering-correlation-id: 7defd274-67ea-467a-9041-08dbdb1bb8eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FtEw3qrYQyXpaMaaO/SObe84xuDRuZj7D1PyvWbO6Wr7hwv/D3Xu6sJiEKYEj2Or4fjIeYogvzCh36g4e+FoeYMpukU3dMlNgFZMRO1bixLoTiLk2MgjjCmDVgsDRPwG/0bciW351kDOcfnP6jlr7+gymSmOooPnIht2MmD1viUizI1n3W/w1Y3lINIlulTbCGF5nSpEWAPgwFTlTWWq7S+kRfN7nQzR+dJojtygLUfptcGgiDQYQ6vt/VYb5taLcTfSafX9JdRcm9K8MDghH+6v+tJp+9n+OU3/aGl4LymIMhnHf/61PP6yDgkw/6fl1h9TUAUb1eeYuhZ0k/V5vyW4gYN2oVeMzyplTghI2vLkKc+rXfRRB0p9D5gPpYx1ab8V1lQxq/erXoLWfQU8Wdc/MWT0fatZ5ot/BIeap4Q8qaEZX8P29Bhx1/Iad5cpw9OVboo8cEu9PG9H0vcCI5TyMEF2WNpbwff/Lwmo/nMs6QtH1LY9LJ16M6tFHWdAs7hhI+eYgZVKWdV1bd17z7d3Zd2OV91VPbe1mu+1tL8Y0S+hh3XKFU+NCZ5nba7Ru/DGY79e8kxn25Xd017xsZ2hIQYBpmhASVuiKm/Qyr7sq+/b7Kht532VWz0zb8qFn7bn8qn+MU4i/AlU8V74A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(122000001)(6512007)(86362001)(33656002)(53546011)(2616005)(36756003)(6506007)(71200400001)(38100700002)(38070700009)(2906002)(478600001)(83380400001)(6486002)(66446008)(64756008)(54906003)(41300700001)(66556008)(66476007)(6916009)(316002)(91956017)(76116006)(66946007)(4326008)(5660300002)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QCuaPm+yJTTjma7ADm1CABf2h1+6fP1cKdP39yhMM2tAgw9rnaEnBZzSnnS/?=
 =?us-ascii?Q?s47EYbTA8UlTWGW5x3ZfUlP7TS1oXV/XVyUgq/TWzwhysWgBcjud9ozcZsOT?=
 =?us-ascii?Q?QeQyKnljTTj39gXGEoaSzvUrhSJbFsN98REbvCRfmmJlHc8vts4NJXjdHn1V?=
 =?us-ascii?Q?vDWau5O7olaPbX+1t23O7y9Dix8GSrjZq+ScB+hYld8FdVCpYwPcWf7DobLn?=
 =?us-ascii?Q?bLOKnvGdYL6oftvoq4JUS2iMk/Vp5YiMYSGNmchpGZAFca5Co1LVCB8cuyqR?=
 =?us-ascii?Q?3s+6gznUGJqounrCuQtYG9U9sVOjOh7wOLMRIaFi/XjGvXYY25tpmUhl/iKQ?=
 =?us-ascii?Q?zbpXfsuhmzrqOUGm8TgbdpUFlptJH7OR0feaK2YcaczD41qwoQsuEHIic14l?=
 =?us-ascii?Q?PMN1tiTF5NGCzk+YpzUSuNoLNHlABOnId9z0b/r/JMDRUFWw1s5r4N37b07B?=
 =?us-ascii?Q?VJOKAsYBF9Zi5KEHbWmBTRFOD+XIGSezN0AuJ5jDK+En9vqgHoREB2Z2zAMK?=
 =?us-ascii?Q?MiK12zBISi1TB3c9I6JcpkNgWKshH0rSt/FnG4Hw/cYNPYLxtpghxZHRYCRO?=
 =?us-ascii?Q?P/EJ2imrgThOPWV6b+nuJgOs/jdxG4+O2K5EKJ+N772kduZDdrf/KL/vvMAL?=
 =?us-ascii?Q?ISrap1g4j0mZQx71oliXWpRZcobVEqP85iwx6dOcicpIXY7OLAtG4s5rxH+Z?=
 =?us-ascii?Q?XpFIx9efR8TAs8ZLZdhyf6MI2SxTrHSFCoBhki61GP+D2R25q3dOYS598fkQ?=
 =?us-ascii?Q?T9R3Toh2n6XJMH3YxViDOIjGxOKJmg7UgY0rwZPxHC7cG8OIZT5HUQqkpv1a?=
 =?us-ascii?Q?VA7Zzk5KWQJ4oCWOcClsamfP5S4SgLg8DktXfNMCOL72Ne0oQ0Rd1q8ax1JY?=
 =?us-ascii?Q?HuD32JNrPvXKaqrjMURnU0QyU9J5HlorN96SU6iRDQeRC1ed/RN0jHARdvTv?=
 =?us-ascii?Q?xwT8sxxMIh6Zt1o4A8J7aXjghI67Vltkt2/XY0OM+zRqVWavA1OwejFJS9k5?=
 =?us-ascii?Q?gkW2q5HvWuffqg/EZuP4J8IvhlpJH/QACaFVZ/HFBnBNL++JlZwI1pxiIjBA?=
 =?us-ascii?Q?Vw9sAccoXpY34F4I8bAfnAoxuUK78+dv29lPzlaJPan0SC5cwrLTBgjeAk25?=
 =?us-ascii?Q?OUIdZshdNSD2cazXTyp4qO3IEjK9u6W/KyPwCGaBmA3EUPPzY7MWgQMzKPlv?=
 =?us-ascii?Q?C0+SW2kLK/1KWldUPhqUZTG6/Y8KqMkapCIcgRhHUMZTUnvCLY4Pbgvfv9tn?=
 =?us-ascii?Q?OKPmdRtflKUbHSAVwOxVhLOLtiaHfWpDp27Amo/h2X05xzv0jn5l/+TXgioj?=
 =?us-ascii?Q?8We7EkpK6fGwpg9OmnWWiVWEdCQ9D6SqVMmfRedHcc0FVLq3AFRpapwG8LrE?=
 =?us-ascii?Q?rLRatYpF56oFKD8yczTaU7PVp22z8gSJzYg6U/BkeboCD793ObYCTQ7g/vic?=
 =?us-ascii?Q?FXIi69u+xLbpQ2CGjvYuW5TJDu4I9O1GE/n3GX52kLnJh7i3m1OpZ5Y3Zu74?=
 =?us-ascii?Q?sQJ866JjDjrvziUjLZ3zEUMFiSapwt62jnSA3188+sBcj/2xAvR6eUwpIIpV?=
 =?us-ascii?Q?euzm13gi6GHQSUAjdUOq/2Sxl3pTUDRuwUlAFxxikO7h9PdsB5GqQQLG23Uo?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D59606B2BF32D48B1281D6C83A16C32@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defd274-67ea-467a-9041-08dbdb1bb8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 20:47:11.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRoPKh1GC1pD7+dmQH/JsMKWkexYZZlLSytH1e9rWpi3adEMdLv0e1S3GthTPceNFdbD4fQM4wj7hcms95a6YkuKTZdNyMnfYPK5Gv3i+Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4273
X-Proofpoint-GUID: 6lIItlCwnYDCrS5MvEBTz-zVpKN-KaLb
X-Proofpoint-ORIG-GUID: 6lIItlCwnYDCrS5MvEBTz-zVpKN-KaLb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> On Oct 24, 2023, at 9:56 PM, Jeff LaBundy <jeff@labundy.com> wrote:
>=20
> On Wed, Oct 18, 2023 at 05:57:24PM +0000, James Ogletree wrote:
>>=20
>> +static irqreturn_t cs40l50_error(int irq, void *data);
>> +
>> +static const struct cs40l50_irq cs40l50_irqs[] =3D {
>> +	CS40L50_IRQ(AMP_SHORT,		"Amp short",		error),
>> +	CS40L50_IRQ(VIRT2_MBOX,		"Mailbox",		process_mbox),
>> +	CS40L50_IRQ(TEMP_ERR,		"Overtemperature",	error),
>> +	CS40L50_IRQ(BST_UVP,		"Boost undervoltage",	error),
>> +	CS40L50_IRQ(BST_SHORT,		"Boost short",		error),
>> +	CS40L50_IRQ(BST_ILIMIT,		"Boost current limit",	error),
>> +	CS40L50_IRQ(UVLO_VDDBATT,	"Boost UVLO",		error),
>> +	CS40L50_IRQ(GLOBAL_ERROR,	"Global",		error),
>> +};
>> +
>> +static irqreturn_t cs40l50_error(int irq, void *data)
>> +{
>> +	struct cs40l50_private *cs40l50 =3D data;
>> +
>> +	dev_err(cs40l50->dev, "%s error\n", cs40l50_irqs[irq].name);
>> +
>> +	return IRQ_RETVAL(!cs40l50_error_release(cs40l50));
>> +}
>> +
>> +static const struct regmap_irq cs40l50_reg_irqs[] =3D {
>> +	CS40L50_REG_IRQ(IRQ1_INT_1,	AMP_SHORT),
>> +	CS40L50_REG_IRQ(IRQ1_INT_2,	VIRT2_MBOX),
>> +	CS40L50_REG_IRQ(IRQ1_INT_8,	TEMP_ERR),
>> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_UVP),
>> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_SHORT),
>> +	CS40L50_REG_IRQ(IRQ1_INT_9,	BST_ILIMIT),
>> +	CS40L50_REG_IRQ(IRQ1_INT_10,	UVLO_VDDBATT),
>> +	CS40L50_REG_IRQ(IRQ1_INT_18,	GLOBAL_ERROR),
>> +};
>> +
>> +static struct regmap_irq_chip cs40l50_irq_chip =3D {
>> +	.name =3D			"CS40L50 IRQ Controller",
>> +
>> +	.status_base =3D		CS40L50_IRQ1_INT_1,
>> +	.mask_base =3D		CS40L50_IRQ1_MASK_1,
>> +	.ack_base =3D		CS40L50_IRQ1_INT_1,
>> +	.num_regs =3D		22,
>> +
>> +	.irqs =3D			cs40l50_reg_irqs,
>> +	.num_irqs =3D		ARRAY_SIZE(cs40l50_reg_irqs),
>> +
>> +	.runtime_pm =3D		true,
>> +};
>> +
>> +static int cs40l50_irq_init(struct cs40l50_private *cs40l50)
>> +{
>> +	struct device *dev =3D cs40l50->dev;
>> +	int error, i, irq;
>> +
>> +	error =3D devm_regmap_add_irq_chip(dev, cs40l50->regmap, cs40l50->irq,
>> +					 IRQF_ONESHOT | IRQF_SHARED, 0,
>> +					 &cs40l50_irq_chip, &cs40l50->irq_data);
>> +	if (error)
>> +		return error;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(cs40l50_irqs); i++) {
>> +		irq =3D regmap_irq_get_virq(cs40l50->irq_data, cs40l50_irqs[i].irq);
>> +		if (irq < 0) {
>> +			dev_err(dev, "Failed getting %s\n", cs40l50_irqs[i].name);
>> +			return irq;
>> +		}
>> +
>> +		error =3D devm_request_threaded_irq(dev, irq, NULL,
>> +						  cs40l50_irqs[i].handler,
>> +						  IRQF_ONESHOT | IRQF_SHARED,
>> +						  cs40l50_irqs[i].name, cs40l50);
>> +		if (error) {
>> +			dev_err(dev, "Failed requesting %s\n", cs40l50_irqs[i].name);
>> +			return error;
>> +		}
>> +	}
>=20
> This is kind of an uncommon design pattern; if anyone reads /proc/interru=
pts
> on their system, it's going to be full of L50 interrupts. Normally we dec=
lare
> a single IRQ, read the status register(s) from inside its handler and the=
n
> act accordingly.
>=20
> What is the motivation for having one handler per interrupt status bit? I=
f
> multiple bits are set at once, does the register get read multiple times =
and
> if so, does doing so clear any pending status? Or are the status register=
s
> write-to-clear instead of read-to-clear?

The reason I used the regmap_irq framework is that it takes care of
the reading and clearing of the status register, and yes it handles the
situation of multiple bits getting set at once. I think I will merge the IR=
Q
handlers into one for the next version. The fact of /proc/interrupts fillin=
g
up with these interrupts is not great and was something I overlooked,
though I think I see instances of drivers with similar amount of interrupts
upstream.

Best,
James

