Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DA7B9969
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbjJEBEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjJEBEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:04:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28982BF;
        Wed,  4 Oct 2023 18:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/EmhfUX2powWP5tg0AuDybfqVLV5Hfzms+tYJ3Q3r2HwHI+mJnyTS4759y6lUnxRIT3/UqPRSiehzxZ6ySzozvqzjIWUdSaOycMx9iyyB8o9kHhIhSFVnkqqhJqB+XxBxrPQEUSxtZCKpBhDQr6wMWYeZFY+Koh/LajLopbJZxFjKYtuExFIaJhGfjJIIPNzNEqoFlhD5tKjNPA/8VkpXBEVE10d4bMv1nvzvGaep84YqCpjG5mKd9L2pwv0WwrAWl4g6ZYLeqQZdHGNCEn76Aknm0NYQpjyB+ugx4zMilQpJa3YSQsUF8nG/CZ2+wy2N78/2yn1TdPBJIbj1SyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aoe/12VPhXOcm7uv/lyfYCf6DGhIKDWB6AqNSrdewYc=;
 b=DQCSyDup6wcVnTDZe6K4F7PkzKs+/THaidczqh7CPgDhtTHzp+2rIbeaC5vGXlc+dbWWgrOfRpyi56O7JPOEuFrgd/ULhi1vC/Y7df4Yoqhc9041oPJxaEhXsVvn1fFXcJ+IBhBwoh16e4zH4OQU35IuKiK5d12UNkNcjBuJMBIk8r2ePyNDlcvXM4H6Hk4xLJaZJBESIcP8eE8z1imKVCI4jKdFbMBAdKPaG5pYExz68x0RwFTZwIZy/duaLfWJL5AgW4rl9v/zw+SWpdvxj7b4KKwAk95QKermrDad+UxmTT7Dft9EdDpQsp2d+46sy5nCGZ97qx6KN+AXOdWoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aoe/12VPhXOcm7uv/lyfYCf6DGhIKDWB6AqNSrdewYc=;
 b=T9YsBxV80WkUw06kCHq5wDOhMpiCnfERKHw3eMXlGt0e56I2y0ctkJiNVIABzuYwnL921D1+ndc/0/Eke0HJSEt0DUy8cLBGlCdZ/6YaTVe75ZX21Fb9YMzt1WEvPZGBbqroDra4+6seVfbHKUWjMsJk24eo0Ezl5ZkLhvtIbjLvzXjo/5FqHiaxs08Cx61fmrM/oSXjsCO3959MeqGBkwlBd+aSDcFIFNKZQOSa1FzNwwqyHawDPQro9/FwPmOovEEDbN7oV6HH080NhsZuEGPuvLMRgNMMJGH7LcMTGwMVkkFDGtcvT6VoZlq5uXLV36DayvQwlY8qIpvdCHGfMg==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 KL1PR0601MB5629.apcprd06.prod.outlook.com (2603:1096:820:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 01:04:32 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 01:04:32 +0000
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
Subject: Re: [PATCH v9 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Thread-Topic: [PATCH v9 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Thread-Index: AQHZ6fsjVtlxp0NmkE+mROk4Sacr7bA2tOSAgAPGXcA=
Date:   Thu, 5 Oct 2023 01:04:32 +0000
Message-ID: <SG2PR06MB3365ED5D60E709045FD010F38BCAA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230918064111.2221594-1-billy_tsai@aspeedtech.com>
 <20230918064111.2221594-2-billy_tsai@aspeedtech.com>
 <20231002152343.GA1747496-robh@kernel.org>
In-Reply-To: <20231002152343.GA1747496-robh@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|KL1PR0601MB5629:EE_
x-ms-office365-filtering-correlation-id: 657cd138-2d22-4637-c640-08dbc53f08ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoAbZgxVJQv6zK6+mW6UYDEs1QgJYk1vbwqx/pwo7gw5OCRrI0NUP6/mx5WOyrIRitRjGjCyCKjvLyE642Mv59GZGShEf6zixUEd03yIKdTdSErzmiih2ZSyaAUCItj02jATHFWu+1ZPui2xGxd7WnuYqflDOxjR0skvKxJxk3QZ6dCvMsBtuooeCY240h7hz+Vt7i+gWigh+FrzlX8CT8YlLAqGGTcr0zXfvHqx6brRTxM6PegMVtBQ4+d5qYd5Y0ldLcYxr1V2wM/FqRxepTDljVDZoAXgJe2KVOkHYmG7g8nZD28iH0H6ST2G4k3xD4hEmZokCjQG/FRA13u9VApfKbtlWn36fgdmbmqXTpKNse8MIwIbBWKBD5ScqN/zg4vWwa+Dmd591a4Qhac1IQiNXPboCsieL9Lh3HQEaLZ6L9zev2CvX8QD590ki9tfsQI1YJKrZjlquDU9pGniEbrIxI5DnMUasWsOrMDl+WoJ8zoQBYZKRmM5FmbqVhNmE05kGCQRfGVbJSi18jA54qM6L6ewaBYx8zHIoQB8YUYmI21ppEMe5YEm5cAd+bI85ZHk6s2IhmHJSGZS9jFBYdJTL4Ae6IAlNdQ8j8lQ1y0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39850400004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(316002)(6916009)(76116006)(91956017)(64756008)(66476007)(66446008)(966005)(66556008)(54906003)(55016003)(66946007)(83380400001)(9686003)(7696005)(26005)(71200400001)(6506007)(7416002)(2906002)(41300700001)(38070700005)(5660300002)(52536014)(8676002)(4326008)(8936002)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QGvAcZs0A9lETR2XW08iXuithq6uSbzbj6j0vH2/aeeHYkXKpErcj2h2O9?=
 =?iso-8859-1?Q?n7YpaxXG3+t6aIWDfXW9W2Q9/duqbBGHlsAhO9FlKhMrlkYNqE4hHRYpUH?=
 =?iso-8859-1?Q?ZtCKGbD+DNUZTNks1G7J4jz6svSJZvMZnbnRpwBN4vO/kMnbteHwSZSlZM?=
 =?iso-8859-1?Q?0O3SmcPCQQJt9Df/w/EqhJVlzislw99PWIysYmNRRrLmjM5IQJ0ZGFUvsi?=
 =?iso-8859-1?Q?sniH/vXPLlup6RoCTxzevDqMOgY8o9mLJWZb0opylwwFx4JpQs5O/Q0yzm?=
 =?iso-8859-1?Q?lPAjSJ8KlLamupjopSTN5+BUBgECYadJrXBtGIcHee+xVJStYQYtrgSMFF?=
 =?iso-8859-1?Q?v8JW7QgXKH5vH9+RHsqQdy9rtiSuTSXSt0MYpa4RR8xvZ+uWdKRlm5po7f?=
 =?iso-8859-1?Q?3oUmdlJ1wnXpC8KDhlnO9ZgXD0qCz+dpHu/DUOGSLNN7CBMiTCOqlOaNEC?=
 =?iso-8859-1?Q?02ZB3/2hC3RJw22VHwQLob98W0sTxAc4FEJ1d1JvnftaVGGk6LrO74ZLXU?=
 =?iso-8859-1?Q?hbvQa44jH2EaHfgLIpmnOD/MvAcVM/LtfJCpL1eSdBwl4s8lCae5zotCiU?=
 =?iso-8859-1?Q?8DHq46qNPkCMgfaPLCltLg1acp8GSHSABnTsIbE2R+9Kp83CB2I6O61QZ3?=
 =?iso-8859-1?Q?3WODngDzaybnVtep4k1SnnM1ynI3GKMGcpuWm8mhokA2dpw/IltmoNB6H2?=
 =?iso-8859-1?Q?mLVGAv7fW95W7FcvoQ2HMmzRPZ5LMCzHsYFEMpqYK3Bi2fYb7RnmUTJrZH?=
 =?iso-8859-1?Q?VNh2uQSXKiCFMOCUE+ogAeDVhplMx0ZP39gHc2ZOyw9xBcp06X85l1vrNU?=
 =?iso-8859-1?Q?MjZroshsK83PQZdF3e0ltQvy63wDzdo4zR9GosBIRRfUmICvBvI3M56xAG?=
 =?iso-8859-1?Q?/gxvRCClRNLodknpWn6DHRf+HjdWsa9PVSuPFhLRzZ0vPRP2YiXAdUMTPC?=
 =?iso-8859-1?Q?kSduoc657/Aa/W1alWzGpK6nCM2UQqmoVcEBBKz1yv8syL2wy5NSCHEoPB?=
 =?iso-8859-1?Q?PGBXpCtQmFbIOcBJj8OMpq+TBinJS6KXsInXWWxncmCUwz3BYfFRueHUh2?=
 =?iso-8859-1?Q?Tal956ivfuOjDRmyhli61RUT9pIdggIgD71stlyHv1voCblGer8xdUj2Fe?=
 =?iso-8859-1?Q?UXWD2uT6FBuf++NU5XZXOzqu8bkmku43m6IWDuGZnSlY7tMFjUXzWc95/W?=
 =?iso-8859-1?Q?S8m12VBb+2q1BsmloMQD3fmvK1Tx23thffp6Txuk1hy7rjGNNXH0bTlOhL?=
 =?iso-8859-1?Q?GDEL6YJW2/ykMS3HmwVH+eWg8ru4W4yh/a43stktt1XxObxOXgDfzPRqnV?=
 =?iso-8859-1?Q?WmnN7lgjc5bUY9L6c8E4ynWp1AXSkofjKak3eQOchbCn8qQzxl182EvZly?=
 =?iso-8859-1?Q?Y2ayt1wPsZ2UB5WOG+kkHtF7RxnJHd0UuRuMDD+GX19/JGF1UvpxgSqqGW?=
 =?iso-8859-1?Q?m48Ft8pX5XL1O7nNbA9sRAyh1pgJtpwgCKqkVHupI19DYgbZ2zA7bJKjhI?=
 =?iso-8859-1?Q?05bKBIlp2F7R818iLeNO1p6D0TeECAEKFAnGUBFKi3BBichgOQWnPdMdZP?=
 =?iso-8859-1?Q?dbCTzy1L2QKQQzLpSt+X0kMPzhIwTiQbPnrgP/gK4tJzFjJmauU/BQPg6S?=
 =?iso-8859-1?Q?ezReRZDCM72z8C76pv9T986AfVX3QntnNH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657cd138-2d22-4637-c640-08dbc53f08ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 01:04:32.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYGE8FVdZiCBet5L3igrvOAprkkILIJevi7RUvGnglezy7d0ipocEq90jVMTvl84bqEJd0Lq9RWk7fYdY6eWz43nFf6+Fjsvb1JuRMxIs8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5629
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: Naresh Solanki <naresh.solanki@9elements.com>=0A=
>>=0A=
>> Add common fan properties bindings to a schema.=0A=
>>=0A=
>> Bindings for fan controllers can reference the common schema for the=0A=
>> fan=0A=
>>=0A=
>> child nodes:=0A=
>>=0A=
>>   patternProperties:=0A=
>>     "^fan@[0-2]":=0A=
>>       type: object=0A=
>>       $ref: fan-common.yaml#=0A=
>>       unevaluatedProperties: false=0A=
>>=0A=
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>=0A=
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>> ---=0A=
>>  .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++=
=0A=
>>  1 file changed, 78 insertions(+)=0A=
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.y=
aml=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/D=
ocumentation/devicetree/bindings/hwmon/fan-common.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..2bd2f57fc9d9=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml=0A=
>> @@ -0,0 +1,78 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause=0A=
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
>> +    maximum: 100000=0A=
>> +=0A=
>> +  min-rpm:=0A=
>> +    description:=0A=
>> +      Min RPM supported by fan.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +    maximum: 1000=0A=
>> +=0A=
>> +  pulses-per-revolution:=0A=
>> +    description:=0A=
>> +      The number of pulse from fan sensor per revolution.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +    maximum: 4=0A=
>> +=0A=
>> +  tach-div:=0A=
>> +    description:=0A=
>> +      Divisor for the tach sampling clock, which determines the sensiti=
vity of the tach pin.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +=0A=
>> +  target-rpm:=0A=
>> +    description:=0A=
>> +      The default desired fan speed in RPM.=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +=0A=
>> +  fan-driving-mode:=0A=
>> +    description:=0A=
>> +      Select the driving mode of the fan.(DC, PWM and so on)=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
=0A=
> What value corresponds to what mode? I'd do strings instead. 'dc',=0A=
> 'pwm', etc.=0A=
=0A=
=0A=
Ok, I will change the type to the string for next patch.=0A=
=0A=
Thanks=
