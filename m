Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894438108B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378451AbjLMDX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378454AbjLMDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:23:26 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C04D2;
        Tue, 12 Dec 2023 19:23:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Fx1rr6eClJccGQT+aUH6MEy5YnOqDqZ7HfmF0mb7KSVDg+bECizb6kErD4bn4gRQ4WoGRUER5SD/DOMwkxA7HxhuuRP59+xDax3eAAOLCn8nfHoJqzE9zQnJGOFT03jm3eAo1jiIe1C/RBoz+RuHalvveNfYQTJHAr6aKQCPeQu8JuDP99eovaq9hMEs8EdRDL5siTlmXYIDin+oHkwCntANT5OAUDBiAJuhWar1TdRkZaseZ8dryHaUWs6kEoAyQEbCRIjsOOdraU3+NSP53Af0yvdWJznmYWzBo2A8njppeK6bCCSshmC5BuHfwB+6cUKaPAp+SF4TTGFKLxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+vN2/9Jan56PwObpWXGtQzwfz7wH6YKNRyc7th54Fs=;
 b=gynVzRWcHLfC3wDJZ7x1CsH5WoOqoOXfdBdSG8BWVWSREniyLLoRraZh89lGMqRd+nPSaxhF0x6rKzSldw06byZ3MBphmT10uyj6DTKe9EWKafQeoHIihFUswlpOWBNeA64HTs3QfZaN1DYP216Rpp7lAzX72fTQ9ekrCrV6HLXZIdoCMUBOwibGwtXQTzNX+83GZ/rRF6li0szoSjs5/2V8I8FOH82QXzvV+FJJKQgUn2YgBMi6fkf/7PbabQJswfPcR6l/I9NkDxElkTtY2Obsv606FccQTuL1+ctAV05cBqdA0J6h+57Gt+yNZgx7IeM+1f9r0VFPl59B/g53tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+vN2/9Jan56PwObpWXGtQzwfz7wH6YKNRyc7th54Fs=;
 b=NbxUT3J0FyggAGWhcnBqtmPP5OGcwgrWTuhHq8wWXFd58vGC7J/pD3pYKJuayNCN+sT0XvjNL/JkHPRWTgZcH+JAf8g/imhZmB9et7vWiCJ5vi6mqDof+p68hn8myQQeSscbQB5VnLWfw0s204qpY4J0B38nQUsyEUnatYSjhVjL9uIZoZtPkw/9TBtHqd9xWNdcaERDntjT96ExAsSW9W4POuvsr/8oWyJRdlGhS0YDkMeOQLbUi2W2qzsGVzHzO59wO85MIQWWt+nf4GDhGKvplUtTSonv6ySMghlTglLPUztexg79ybS/8a+hOtN7+JDG1UGkMuGdfNaigcoKlg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB5667.apcprd06.prod.outlook.com (2603:1096:101:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 03:23:23 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 03:23:23 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
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
Subject: Re: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
Thread-Topic: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed
 ast26xx
Thread-Index: AQHaEWg7S/NllT0hPE+qUe52iPc027BvNyiAgC1+14CAAAJLgIAKCWl7
Date:   Wed, 13 Dec 2023 03:23:23 +0000
Message-ID: <OSQPR06MB72529B0769B89A21DDFB8B1F8B8DA@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
 <20231206174823.ok6rrufhez33rte5@pengutronix.de>
 <ed9d28e0-f879-41f3-8679-7ed5e0eec7ce@linaro.org>
In-Reply-To: <ed9d28e0-f879-41f3-8679-7ed5e0eec7ce@linaro.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB5667:EE_
x-ms-office365-filtering-correlation-id: f6d86246-0c1b-482e-517e-08dbfb8adcd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvpeZwR5TL/jWvm/Tl14W4H08+JMxVCBmpADWSZ0nGlTV5xQO15iO9TkmsKXOHzuTPE44peoU2yPRKDoVCDJM+K6U/WsRoGQmEEOam2oSHsHAP+ZoLBOzmsI0ON5I3af/L6Ok68MpcsLYtSDjrOqcOAYFSjPFLeTqZTJqqnHmJFkcpJbAVgckJABl4CgaXyfKsaol4HzEg7WJDhWJTHEZ8Kk+D4rwbLOR3F6CDlc8ISbzWukXkW47wZ8mBoeLJQu1je+bktcYnElFtEfc67ViDo6sWU9nxXUCsd42wbhowktqvKpKckTBGvFZcc6DMG6e5ggpI/xIKGS79mmUhmMLvucW8csRViW0yzpGzKcT+4pb03ZyCi1HvSubU9NE4GfQLvDyNxQLL+W711uVVeNDWzgXMmsNiTA2wLFK/iF0GHw29qLCF/rrZXGaF6S04JmKx1vMzdjtq8qYyCBFuSRzz6V5C6q7OaAUc4IWV85T4EqR1clUqSMBp8E859BCyFqbNXepE6ltO9wzvgCN/XTGKJoJGIj/fJISRAHfyuwhRzBseD4Dxa7y1OejnVonqVIY0EvonR4KYrP1d0BP65sEuSzsih7iwzWRJQ74HfliHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(41300700001)(7416002)(5660300002)(33656002)(2906002)(26005)(53546011)(55236004)(7696005)(9686003)(83380400001)(55016003)(6506007)(71200400001)(478600001)(966005)(122000001)(38100700002)(86362001)(52536014)(8936002)(8676002)(4326008)(64756008)(54906003)(110136005)(316002)(66556008)(66476007)(66446008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Az2o7Ae0WZHT1PVD5xu1XnPkWGuMxKwGvgMn6dTL0IJg1Q64ORAZr44EOH?=
 =?iso-8859-1?Q?EYj2VQz70IyESiIw8JTN/oFZ5uEc8u6xliaKB3vcGiWhxXckPhc3rUq2/B?=
 =?iso-8859-1?Q?uOR1ypDwZcbZb62A/B0+hs8a6Va7BqqQAP4aA2PBHubZtRTOmazMENcMGa?=
 =?iso-8859-1?Q?g6cEUBxEQsGz21fqZ3RuB4oFzyS2G9A/zgQTyYaJZbEtfSAXiJmhw49NOS?=
 =?iso-8859-1?Q?vBAXETZKjzTnSbn7XEnnAUFXJFKftOVHDDgBwQXY60ycKJOv5AH91LXu6R?=
 =?iso-8859-1?Q?W5jWo6aP1QJbKbVW5xuZZ8o6vSC4Tsp7xFwIKRqG2ZIxcdlO7+GUdaGQyL?=
 =?iso-8859-1?Q?iAdeZKqRpcyc4muZgzlZgcXauD2aKhQ0YVJlzAdtV10ekvN1j/KK06/uBg?=
 =?iso-8859-1?Q?v+15ooXFGnWeUoL63+YBfE3hOpI1RstyuplT9jmBLekZrleHZWneOWas1H?=
 =?iso-8859-1?Q?f8ACCVY1BV/pDBfOx4hyNEK3VFOn68AUH1ZBysLsr/4/Qq0xmem1Y6oYQd?=
 =?iso-8859-1?Q?BaXtoB8AWXAIG11k0f0dR1mX1KYY23r/bfPeLKSfYg/UQ3wDo5iT72tPZn?=
 =?iso-8859-1?Q?7Mw+xgKsNFUZTYlHhn2gHzthReBM7VeMbKZk7Hh1IMYI6y6HRUwJ6ZAH/i?=
 =?iso-8859-1?Q?e0l/AWXmu5Js//f1OinDtK7wGoYL03ILigrvtCzOXsPF1d1dD1hA7cXCh4?=
 =?iso-8859-1?Q?lydJhdv+h/TbOfsgkk851MHorwytZCGK2WwtP3HirqcfmSnw53lHmY6wm3?=
 =?iso-8859-1?Q?dnqMAXEl+aWs2xMy2z56i3b9PoETHMULhwp5I+WvR/d66120xVRStagnUE?=
 =?iso-8859-1?Q?sIm6UTG92Qer8Y5XqtAnrw0GDouJ78i6v8Tyn5Uk2lw4n3MXW0IP8m8VVF?=
 =?iso-8859-1?Q?YrskQb+oKmdAB/j/2qqDUntUBLowH22sjvLB2ollEf0tqwjiM9RMmHC2PP?=
 =?iso-8859-1?Q?gqCM8TG1UEZKdI77aiVihXYoMyiVJJLJTVTa4wlgb2MLmN5kzRrWIZS55B?=
 =?iso-8859-1?Q?Klkx5+mbbvecIOXLOqjqw2pIzjK0HmUmsU6uxM0I3pV/Ro4krzhqLKj0uK?=
 =?iso-8859-1?Q?p64/6Qy0COjZvBTws1AyDQJ786ABVXcGQ2zwU1nLiY1OVkBvqwPRUVYJzE?=
 =?iso-8859-1?Q?V8L7pmtV92nzpcXmo/fdI0bd0Z7zZoPvXWrqjsfWOzReoAoYndWi9GwYPR?=
 =?iso-8859-1?Q?KjLogHrWHXzNhFXCWPDaD93F2gTJqnPuTHqyV3fgQ43zvOEFpE/KnNMWFa?=
 =?iso-8859-1?Q?5lj5RR13w1APd7auvXEJFQ+/VDoKeQbm6LVr7RwmOzNJjZf1YqR5N8CZNp?=
 =?iso-8859-1?Q?SviU+ZUfa0r1NtGB5b+SuLcHeyYiwEV9opFoM6g6HeJHf+9CdVj448Df+m?=
 =?iso-8859-1?Q?IY5LJHDwfCa4ecoE3sCUkxlR3jkUnxdJkFYePSA21D0NM/KZu2LUktXZ47?=
 =?iso-8859-1?Q?cVEk2ePYJJcCaAxdicEu/N643jY4uahlZXToJn+0Ol/ANTDuBLZGs0IkQe?=
 =?iso-8859-1?Q?YJyRyUoJrDFPwgvw1I1B3AyOSVWLMUL60qi/Uy7B21EdVHxkoHlBMAnWV6?=
 =?iso-8859-1?Q?JwuW/mS77UYpmUjnR0fQvVtz+/u32a9P0OAO2JX1A/69tS96bIzgEDs0AL?=
 =?iso-8859-1?Q?eZCxrGhzEGCT1BMhDLXrccAFG7GoRacNJf?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d86246-0c1b-482e-517e-08dbfb8adcd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 03:23:23.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m59l02BNGgtk+Wvaw72k8j5W8vzb+S7q4axxvNaBtFh6uAeAfRfCgXV6mUDVXqSCxFdmQTeNoVT13VjR5Mccg5MTttZD1x3xAIG7fUCJ1CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 18:48, Uwe Kleine-K=F6nig wrote:=0A=
>> On Tue, Nov 07, 2023 at 11:02:43AM -0800, Guenter Roeck wrote:=0A=
>>> On 11/7/23 02:50, Billy Tsai wrote:=0A=
>>>> Unlike the old design that the register setting of the TACH should bas=
ed=0A=
>>>> on the configure of the PWM. In ast26xx, the dependency between pwm an=
d=0A=
>>>> tach controller is eliminated and becomes a separate hardware block. O=
ne=0A=
>>>> is used to provide pwm output and another is used to monitor the frequ=
ency=0A=
>>>> of the input. This driver implements them by exposing two kernel=0A=
>>>> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside=
=0A=
>>>> existing drivers for controlling elements such as fans (pwm-fan.c),=0A=
>>>> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the dri=
ver=0A=
>>>> provides sysfs interfaces for fan.=0A=
>>>>=0A=
>>>> Changes since v9:=0A=
>>>> Change the type of fan-driving-mode to string=0A=
>>>> Fix some typos and formatting issues.=0A=
>>>>=0A=
>>>=0A=
>>> What is the resend about ?=0A=
>>=0A=
>> And to the original v10 there is a reply by Krzysztof;=0A=
>> see https://lore.kernel.org/linux-pwm/3d9e50db-19f0-43b3-8042-2f80a1e7b7=
9e@linaro.org/ .=0A=
>>=0A=
>> I'll mark the original and this resend as "changes-requested" in our=0A=
>> patchwork. Probably the most cooperative way to object is to send a v11=
=0A=
>> and point out the changes compared to v10.=0A=
=0A=
> The resend might be fixing issues from v10, but who knows which and how=
=0A=
> many. In any case it should be v11, not a resend.=0A=
=0A=
I apologize for responding to this question inappropriately. I only replied=
 to Guenter and removed=0A=
the others.=0A=
The reason for the resend is simply to remove the 'Change-Id' in the commit=
 log, which triggers an=0A=
error when running scripts/checkpatch.pl. =0A=
It's a minor issue, and I forgot to mention this change in the cover letter=
.=0A=
I sincerely apologize for any confusion.=0A=
=0A=
Best regards,=0A=
Billy Tsai=0A=
