Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4768879742C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjIGPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbjIGPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071c.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::71c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717D1BC9;
        Thu,  7 Sep 2023 08:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh69poRUVIAktMtH+ZwKoMdyPVk2TVa3Lr0iO1MPpX/ggtxhazSd6YCn5j4iMEXcOXxzpGKYlsDuuEuFEyXp02UEu14FedlLwKEfS2AljTSjw+4PsTDgxEakMssu6CTlbpHn9wMs50mKVsLkhnVyUHwfrBUulAuEaq5szvqAY4dz2DwUW/XKt4041OvOMwXLRgsgHPctyXmsW4djMZ59bhKIBVLNi8m3BQZNlwWHxPZBa6Z7jwqEo5dxTUmlAE2Z0d62nB/Y8RhU1/SRG9J09In8moMaDI51AlEwyIfZRMnf8GNn2R7YgyyLQoMLkwcvqlfv5LB2VrtMmGTxwitbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILdyH+y3Ag8MQ5/OU0a8nDvQT8qItD7SrbA7qWiTn3Q=;
 b=eFT5iPgK+zNHhHX4MN1za1LqwITCwpPGzM725B+bIAPcUrYb3GqNMLj2THzsDmS1Glep/IzYTQhdfkf7Z2WXPKNojjGhtHrPPJRQqdD4yL1vNNHaG4GUftrZAIUuU2lT81Pw+SM+EXMCud6s8xr467+fSzooiqgCKkb8P3IaLvVcWa5tjE2Rrjj4uaKA4G35rElljVibvooMuZls3/vfILjxeccp5/m2EPK/fHsZ4z1Ddgyo3OQ7W8dF0CvfTHiRTUochXnYvHe8c7wGAGkDS1snz57p9BtWx5Yvl0AHEGUSfQ2/nkkwzNqDj4TY4p4m9TMiqGi9FSbhS8nnkZD7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILdyH+y3Ag8MQ5/OU0a8nDvQT8qItD7SrbA7qWiTn3Q=;
 b=TIT80aqnx1oav1pXJdD6mq8zgsPlgj117pgQPILSZw8uxjtA9xaxFVwmj7loWAbvxuxE4chi0EMacAXB71bs2hkTjej/i8ScT3gov0E8kId1mgbn7KsJlSsFiy1rMBKEEiMQr7pGD2oO9ZSlep1opb45aJp+sK7Omz8V0cKS4heHeIK/x3Z3YdqY3HQCfx5Wf7ZmVLTFxGbKszmHmcSiO8cOZbZNtibhBrQY4Jq3dIMx8GtKLNZ+gUW6lB57NOjYgraqI0eCVjv1kyYOW3C1AzP0FLhOE3aHCU6ZB+m8F+djkE/ZUq74itbITI3RyisC+T5J3RUBxetMCWNNhooq9A==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SEZPR06MB6198.apcprd06.prod.outlook.com (2603:1096:101:f1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 07:17:56 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::791a:38e8:18cf:d205%5]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 07:17:55 +0000
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
Thread-Index: AQHZ2z4C+uKKem1S50iGi7OYH9WEnLAMfl8AgAKBk6I=
Date:   Thu, 7 Sep 2023 07:17:55 +0000
Message-ID: <SG2PR06MB336567E43537C7F4947E342F8BEEA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
 <20230905170010.GA3505375-robh@kernel.org>
In-Reply-To: <20230905170010.GA3505375-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SEZPR06MB6198:EE_
x-ms-office365-filtering-correlation-id: 0feb26c9-7fdd-4aae-70a0-08dbaf728eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjadcIWuvkP37pgM56WRpO2Jn6eLPzrv69Z7uYUYI2p61PEBBfmiqsrBzJV+riJN7Xf9umG4wJsKy5z9gQZ27hkYri5Sfm87KhjtMtDT83yeS2qjqYSBLbxA65YU+qC86LBJlwAbRTAK7yT7EkVMbZEpjEZKJSQI/BzcRI/EsmAdfZp14D6lriG18LdOl5xiy1UIjmAOx6bZKsvxq4amto8MKaypE4pDxBg7J+CnPw887O+U5Ec8Oao2UrjW8heHCfNJk6twrwlsra/+nVs+kAEvT2XzcaYEGrq/7+vDwcCaW8woFHB6mYg/mQtwQfVxRqAjqbKh/MLNgB/L23obES9mfTDML3qPDz8qJXyJiiOq/EMgAxLgAH/NgUYCmhOH3rq0449vFEe6NCAV4jnOyturcJYa2IxuYJChl8R0YN7Swze6YkOHNLSQLwEPWmusKBWBU1Vu5IbWEtQaANChhpSYLqAso9ILWHVpmuxsmWHDd/Zwaoo9m+dhWgq3NN5zzlXL9Zo2L9c0FeTmDZ4bz3uU9tnwcMPouOfahoSMssqmfQGz75K+g1liadu+y0UEzdZ14F13git/NGyBncZoKo5jUXONrmZoDZqCyXB77Ak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(396003)(136003)(376002)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(55236004)(55016003)(83380400001)(26005)(122000001)(91956017)(64756008)(54906003)(52536014)(66946007)(38070700005)(38100700002)(76116006)(66446008)(6916009)(66556008)(66476007)(5660300002)(7416002)(316002)(33656002)(41300700001)(86362001)(8676002)(8936002)(4326008)(2906002)(71200400001)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uq8qgk4rMOm3HKcl/zSWqwPMKP+ZvhjefiHO6IWQ1VJbiP1RGFYTt45WtE?=
 =?iso-8859-1?Q?Y2JttAbiyZluub6uNRg1Ix9G7HXFRfjGdqiJb/Sz4nRUTw/ayLn384w3XT?=
 =?iso-8859-1?Q?T4SLsgUg7HaJClkfXsj7kd8S5cr4/Op5mVecKZ5OSEQQDeQe1jHwVFhEy/?=
 =?iso-8859-1?Q?qixBQsxufAZmDEi9qda9DYVv77P4ZELokqoXuL0QvLbrYCkHSW9UpyVBvr?=
 =?iso-8859-1?Q?+6twoQbBH3mVM2sI6goSkN+TWXGRD2ZHAwDfNZqZwLcnGfrmuta9QluUvb?=
 =?iso-8859-1?Q?50sdZTB+gBuO+1hDUdd66iMY/fz0fLCg5RGKwQFwYLZMmqF5CeFH8bkHEZ?=
 =?iso-8859-1?Q?caYLhzRVBKfJqPF4JoiJXrb3Cpv5UL4ywC/g6UJlHTnbyyiM+eFyzVeWHf?=
 =?iso-8859-1?Q?OedUHtpB2KuAXZUujz1nqlsG74Dg3PGb0Bb1hn9SQv/9/fm+GjJ2Jl6epY?=
 =?iso-8859-1?Q?iZRE/TZnGz686+BZY0+X69du9m0lHJBEtBz9pDzTGC+ap4u5RmvtUd6rYg?=
 =?iso-8859-1?Q?zQWFLBRDcfIo7iCva+AEuFucyJwDV06r5XqhcUNTggRqCGijLFw5ffHP2k?=
 =?iso-8859-1?Q?yIVZ546Ickjthbe0v64l2JKw2Em7UB1K164kj2aduroYkyvnd70XnhCD+2?=
 =?iso-8859-1?Q?S44mjV1nYRvD1vu3KzsIpm9fNwHJjEW+KpQTIHc5wiRUXRUFn+62DGj+9+?=
 =?iso-8859-1?Q?jeo/yNA8di/3/6FQsEJrBR7+0pX2SnWTGiDaSBpY6qSCT0e7NkhiKferDM?=
 =?iso-8859-1?Q?vCbLhS3dOONQpNCxd4qdu7IKCLQCnlFWUZo1UtQjUZvqQpp0D3UPv3Qn2c?=
 =?iso-8859-1?Q?Dv1mKziE1ZJg1AotH210odX7vPypv1zXRXFowbrpv4/UVYk2iCCE9Il1/6?=
 =?iso-8859-1?Q?r6UQIfdU6ARRusGz7d5Nfvg1ossngANkYEZV1OS5j2PrPzIpY6Y6DjLhtD?=
 =?iso-8859-1?Q?/LzJDubwlJfXfpQqM8diePEgHXgCg+zdY83cpFxRZmx0gW+pgT2QBKOAWC?=
 =?iso-8859-1?Q?pufGZOqj+vYIkhB1w1LP97SwPFogv+WDhe8gyZoBn1LDFkggJm0gnJL0vb?=
 =?iso-8859-1?Q?T0RrgqNe1PSwZcf2Fj/XqVGL0kLdHNE4UvvN3x5jsBGQINFyji+FPkDNrK?=
 =?iso-8859-1?Q?fEtktG6yorIBT8+0qgZB0xASXeKXKfryFGRZIZobOt9DvjEACWnClPd60F?=
 =?iso-8859-1?Q?DxdIlJ1OSfON+ZKr5bEc7ifZtxiDVQe2mzNuyGA4yszsVuwKXqhIDnYgcn?=
 =?iso-8859-1?Q?VccLbKTe7Ekz/a86x3vMN+FChnTkA/dmgqsQkpP8+mZ/u2+JlI/nzxXa0J?=
 =?iso-8859-1?Q?ATjQTTXna9Xc+4J88yP+q8dGnioO4vBAKDcOGyqFqVGABLCyYl7RovTvTP?=
 =?iso-8859-1?Q?1zuwJTIKb4zbCcXX73ylCGFqelJDw/hBRnjvfFKRKtuH9HkNV/cjOfgkTI?=
 =?iso-8859-1?Q?kNfO6ppIsMhKUWZGaXoeTBPtdO2SIq/3hi8MAUVCtYPpEzsVfj2RHd+ym4?=
 =?iso-8859-1?Q?nfm9V823kgjPa2R/nh+Eg0U39/8/TdPAZ3LV+F+uQUJ2RAlTXAWnnsjgZE?=
 =?iso-8859-1?Q?WM4WpPe1vQbJUY40bz35MO/ozV8yaAXAI9ejNR7wAqvSwiLjJGOMa+juUv?=
 =?iso-8859-1?Q?BbFGAKwpTQSHbT2LtwWpPfyJHoBXi8Ju8m?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feb26c9-7fdd-4aae-70a0-08dbaf728eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 07:17:55.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcK5GmglR+3MXi2qIIq1nHTdHr6oevqtBYy47RKg3qcXJpuqNzf4Q5AjQYW07hTw/GFt9L3fMCEUzLBiZsTYcUrYyNaEywETx9eMH9xIi/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:32:00PM +0800, Billy Tsai wrote:=0A=
>> From: Naresh Solanki <naresh.solanki@9elements.com>=0A=
>> =0A=
>> Add common fan properties bindings to a schema.=0A=
>> =0A=
>> Bindings for fan controllers can reference the common schema for the=0A=
>> fan=0A=
>> =0A=
>> child nodes:=0A=
>> =0A=
>>   patternProperties:=0A=
>>     "^fan@[0-2]":=0A=
>>       type: object=0A=
>>       $ref: fan-common.yaml#=0A=
=0A=
>        unevaluatedProperties: false=0A=
=0A=
OK, I will add this.=0A=
=0A=
>> =0A=
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>=0A=
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> ---=0A=
>>  .../devicetree/bindings/hwmon/fan-common.yaml | 63 +++++++++++++++++++=
=0A=
>>  1 file changed, 63 insertions(+)=0A=
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.y=
aml=0A=
>> =0A=
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/D=
ocumentation/devicetree/bindings/>hwmon/fan-common.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..a69b4d553e45=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml=0A=
>> @@ -0,0 +1,63 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause=0A=
=0A=
> Drop 'or-later'. It's GPL2 only.=0A=
=0A=
OK, I will fix it.=0A=
=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#=0A=
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
>> +=0A=
>> +title: Common Fan Properties=0A=
>> +=0A=
>> +maintainers:=0A=
>> +  - Naresh Solanki <naresh.solanki@9elements.com>=0A=
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> +=0A=
>> +properties:=0A=
>> +  max-rpm:=0A=
>> +    description:=0A=
>> +      Max RPM supported by fan.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
=0A=
> Physics will limit this to something much less than 2^32. Add some =0A=
> constraints. 10000?=0A=
=0A=
=0A=
>> +=0A=
>> +  min-rpm:=0A=
>> +    description:=0A=
>> +      Min RPM supported by fan.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
=0A=
> ditto=0A=
=0A=
>> +=0A=
>> +  pulses-per-revolution:=0A=
>> +    description:=0A=
>> +      The number of pulse from fan sensor per revolution.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
=0A=
>Needs constraints. I assume this is never more than 4 (or 2 even)?=0A=
=0A=
Do you think we should add the contraint in the common binding?=0A=
In my option, the limit of the max/min rpm should be declared by=0A=
the binding if necessary, because the usage of each fan monitor is=0A=
based on the connection of the tach pin.=0A=
=0A=
=0A=
>> +  div:=0A=
=0A=
> Too generic of a name.=0A=
=0A=
>> +    description:=0A=
>> +      Fan clock divisor=0A=
=0A=
> But what is a fan clock?=0A=
=0A=
This is the divisor for the tachometer sampling clock, which determines the=
 sensitivity of the tach pin.=0A=
So, if the name of the property changes to 'tach-div,' is it acceptable to =
you?=0A=
=0A=
=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +=0A=
>> +  target-rpm:=0A=
>> +    description:=0A=
>> +      Target RPM the fan should be configured during driver probe.=0A=
=0A=
> What driver? By the time the OS driver runs, a bunch of other boot =0A=
> software has already run on modern systems. So this value would likely =
=0A=
> be used much earlier. The point is that when exactly is outside the =0A=
> scope of DT. This is "what RPM do I use in case of no other information =
=0A=
> (e.g. temperature)".=0A=
=0A=
So, the description should be changed to 'The default desired fan speed in =
RPM,'=0A=
and we shouldn't mention the timing of the property's operation in the DT, =
is that correct?=0A=
=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +=0A=
>> +  mode:=0A=
=0A=
> Too generic.=0A=
=0A=
>> +    description:=0A=
>> +      Select the operational mode of the fan.=0A=
=0A=
> What are modes? Spin and don't spin?=0A=
=0A=
The mode is used to indicate the driving mode of the fan (DC, PWM and so on=
).=0A=
So, if the name of the property changes to 'fan-driving-mode,' is it accept=
able to you?=0A=
=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +=0A=
>> +  pwms:=0A=
>> +    description:=0A=
>> +      PWM provider.=0A=
=0A=
> maxItems: 1=0A=
=0A=
> I don't think there are fans with more than 1 PWM input?=0A=
=0A=
Ok, I will add the constraint for the pwm input.=0A=
=0A=
>> +=0A=
>> +  tach-ch:=0A=
>> +    description:=0A=
>> +      The tach channel used for the fan.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
=0A=
> The existing ASpeed version of this property allows more than 1 entry. I =
=0A=
> don't understand how a fan would have 2 tach signals, but if so, the =0A=
> generic property should allow for that.=0A=
=0A=
Ok, I will modify it to the uint32-array=0A=
=0A=
> Perhaps 'reg' should be defined in here with some text saying 'reg' =0A=
> corresponds to the fan controller specific id which may be the PWM+TACH =
=0A=
> channel, PWM channel (deprecated), or TACH channel. I think there are =0A=
> examples of all 3 of these cases.=0A=
=0A=
I don't think it's necessary for the 'reg' because the case you mentioned i=
s=0A=
already covered by the property 'tach-ch' and the 'pwms'.=0A=
=0A=
> +=0A=
> +  label:=0A=
> +    description:=0A=
> +      Optional fan label=0A=
> +=0A=
> +  fan-supply:=0A=
> +    description:=0A=
> +      Power supply for fan.=0A=
> +=0A=
> +additionalProperties: true=0A=
> +=0A=
> +...=0A=
> -- =0A=
> 2.25.1=0A=
> =0A=
