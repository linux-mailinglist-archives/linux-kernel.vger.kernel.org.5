Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E978279D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHULMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjHULML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:12:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB808E7;
        Mon, 21 Aug 2023 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692616328; x=1724152328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SeAAB71wRn6D4Y0gECeMd7o8irSoKFtD4vukzJQLYNQ=;
  b=cLRtFn0e0mKlz+7aX5vfo4qWahT5yPzjzcJC33FJZsHWjoi7t9bYNQ6x
   KP2bLsqpHawMS/IDG3QbfWaQa+TN99VfZCMLvKKiKXmhXrX8NgVjp7Wk0
   Y0GdPMHy07jKZIz6JYFRbSqaW4AWcLuL6vZTwjhJYuMg5vu2F6+B8ANTk
   kHXpKbhX7uWVn18DzFzPlPpVQlqhluRnarmdRGvQ58MFtoGXseIAJx7IL
   zzCDHS1t/4UYwjvsHvgjdAgJ7kd97GElTsRP+O7fBf7ADVdu2dX2Rn6Rm
   QsCHc4CbrKwm1LV6YpcGZz1ZT01d9s1/8lZ++p+SJbI09BNFyuGWZfDBE
   w==;
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="167456921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2023 04:12:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 21 Aug 2023 04:12:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 21 Aug 2023 04:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIZ2+sW2K/3uBj3UTaFZ6N6Q4bca3LQIFSLJYTQdMv9NuaEM6pvY24qi84WYaJk3g6BdQqAoH4T61H4LOTZ6c4zSgjR+uomCP0Zm7xDj8RR8NJ5bLoPpZTvGDeyO2dn4xwAlV5+JS6W8yQLyiQi6CztXPOANWnP+WHweZlS+Z90kuAhfMydcMYG4+0ZpV9/2EKC14fF42e0H7K7XwGIHjmGFGqBCFLQo4fq6BJP5cA8oBCFbdAiE9kIKMjIbblJnASSOvTQUjnT8AMV4pLyBT85KuM5qWQYlDv8l0o8cotiFTvh2I68GZ9qU9s9ff50UyQQN8Zimfh5Oad136HlhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rRDDWmeB7MwcGGe1ty1VN6mFk984RZ4zKFnZ3XLLNI=;
 b=T8XGQ68wZHhAzyeikEyQoQpeyoRC8hxvtOuhO0pJXJX57bWHYlC8cLWKvgB8kx/EzYSRbh/XH70FV2F/PT4656b93RvIUOaRb0GZcaO+5WuReC12Tsu1hZ+ZYjHCNrIkwcrorfoPDnrFUtMzjhaCUWvDdYfspsE2RkZtEokfHsS62jdd7Gh2AHe9YlC0SsZ22+sj07uAipWUHXUMKrLUSHViJkrlP7S+jnPiyji2Bgdr5Fv5evUmrVai2hzor3ng5Q4j8484uLYj7NG1eduCU87JPIX6xzfT9NV1k6VRN2okx9tq5Ml1IxySlcakSaYP3AnIvBIVAruk1LGVT/vAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rRDDWmeB7MwcGGe1ty1VN6mFk984RZ4zKFnZ3XLLNI=;
 b=PbQE8yfdlQQNX6C75juo8aZ03vahrn1CIPFym8n9esfH1s1z9aVM3UyyrDaIFjnWM8K6gK2s5E6pMOEYlUCq0JQFUQDVkTwL1hj1aTXIVhKbkAxfb0WzIG36RFJtIUkxrPwSLYH/y7o5dBvT+NLUAPwTGFT1R0OgMxXdTVzcjrc=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:12:05 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:12:05 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>
CC:     <sakari.ailus@iki.fi>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Shravan.Chippa@microchip.com>
Subject: RE: [PATCH v2] media: i2c: imx334: add support for test pattern
 generator
Thread-Topic: [PATCH v2] media: i2c: imx334: add support for test pattern
 generator
Thread-Index: AQHZxuaF4uxgr4MksUiVu23PrT1Bna/0smYw
Date:   Mon, 21 Aug 2023 11:12:05 +0000
Message-ID: <PH0PR11MB5611F35E56874D00E1AE4AD4811EA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230804151541.3162667-1-shravan.chippa@microchip.com>
In-Reply-To: <20230804151541.3162667-1-shravan.chippa@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|BN9PR11MB5557:EE_
x-ms-office365-filtering-correlation-id: 66a320d6-1cc0-46d9-c517-08dba23773ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8xvLmPZNEZ/hSzapKqEtdSurSW2GK1zDRzGJyVpd8n9ijt/SraOuhYE5xynD/GrAfbMImrFCtUT6D5ZQgmWhvXS6R3c8K0s6ZIDQzoCPCbFGURJSAQCrIt/FR062CG1EfQtR+bKpnjt1K0VLfiTc5LN8XA9JLHP3TclQxwGaRxhZUILQxZAW1NOsQa+rdQ0LlSDvMyXNOqAGEbbNH8NZQKOZMxkq2D+WwQKefr6o3qepZiqZkUk3zL7+cdfaHlg6d1UwY0wdO7Ll6rw/hQMEgrgPqndbWFMibFLhZ6wFcoy58ujQU89yMNryhu+ihSxSGeDffWFHla3aV6fibuTM7z2o40yrHwjVFzqsyFwTy4tfy0QY324ertT20nRPcXr/QfXWyHAB6+x6G0eIYmlOIV28ko/XxCN+WyRJADgwAKvuhmO9Z5Q0Ban4qA8iR9/a39SmpKwscjFzA/Xjq5bEAFH+9DeAzTZQ91ZNFWLvKNJpZxQRY13gdluOKVOKn4uh7ECCTWA7W7+s8YawSzKMNaP4uXOedBbxSKwOJkf3dNtMoG942762v1uibtmFFXYvWM90uWp4Qljb2HtkK5yvZQnjiBCKNOti/Zcl4BdgR1mr4eb61HCgr+gieEv9Vf7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(186009)(1800799009)(451199024)(66446008)(54906003)(66476007)(76116006)(66556008)(64756008)(316002)(66946007)(9686003)(110136005)(8676002)(8936002)(107886003)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(7696005)(38100700002)(38070700005)(53546011)(6506007)(83380400001)(2906002)(86362001)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cdevAEr1iea0snU2y+iRwpQy634aWhmpaSep4pWEbQ4fXKEoT7Fus2tC7N/z?=
 =?us-ascii?Q?YwckPPxHiN/30sxBC9PO1fkq3M6FPsJOEqSjlpRYiHeuSw39fFy6SVKwAKVD?=
 =?us-ascii?Q?YUoaPxFKv800590nnEwATCXV9aiT4Cr+HumZqSkALpJReCIMqyPddtu6DQ+3?=
 =?us-ascii?Q?sTsJB8VoO+YwK8e22Oz28cnaQOZrnCUsE6mUACBtvWbdcfjeqCBwC1rPpybq?=
 =?us-ascii?Q?TWg8NB06DEVrRniAEx9nnb2KGmjgQKZLMpOU9G4D45KfnBZ//PQk+2gcf7d5?=
 =?us-ascii?Q?2ai3B3BdwwG06Rkg+sDca8Z23qFHtAkcormww/y/A2yzDG0DnQqZKS6lNxRZ?=
 =?us-ascii?Q?1fyBHGevyzSkV8N+L3XJluqWwH+Fe76T9Yzqhgk+d+zLo5p3J8d03tfyUJIh?=
 =?us-ascii?Q?IIr3x4n8pCrQOVqCPppoY3pGEHLIGeJKc57h6j69fLlX+HXbDC5PWmKVVOlU?=
 =?us-ascii?Q?NnTHLpc160ZB0YnW5GZCzgUcfMJMnWKcWV1rf/nFlJW2FQVBvoCZyp7WWELp?=
 =?us-ascii?Q?ujXP/y1ktXVyjnF/vR8y1aO9ysr9HHyaRZ1SJKIFh5SbzCBEhH4I/A3ZDY/u?=
 =?us-ascii?Q?jkRS8ebnxgq+GZQJFo8Nbq/Tr7E63ryCkJQkN/HSG36aoiNLb6sszMgBtvlB?=
 =?us-ascii?Q?C0v4GO4vjI7Ue4x+9hPD4oozKN2hcqefrKgRNdw3W1ksYy4TbqWwqvnVczAn?=
 =?us-ascii?Q?8AnaPwKWHOUbf08RMrBeL8sOiMGhEHsZtZ1UDRVZgRwLFRQCcSaZmRobxszP?=
 =?us-ascii?Q?A8mTtCBQv7KYPJSq9o6SbzPLiuoUm41vh656f2DNmZuZ25mJEb401ENlFFlV?=
 =?us-ascii?Q?QaP+BfjaSXbXQxoG5h6InXCrkAdpIQ7UlxDQNMfpLM1E2jYsur14vdvbjgNY?=
 =?us-ascii?Q?dpzYLV4S+g0jlkKFfUNhG4GOKc/kNWevHynxqZNw/Vzln1t7k1ZqP0XWv4+c?=
 =?us-ascii?Q?rdhDWKEvVNB9KRlyGpR4eh+sQqb1JP1zNcVHrg78dKB398EExSD3zlpgySNA?=
 =?us-ascii?Q?5xpj2KndEubyE7x3ae4EiC5thQQD6o9kXqKTN65LZBNTE7Droc9OElSf4XHq?=
 =?us-ascii?Q?Uq5xIfRIvIam7RpP7Vvt2v+nIq0WCvEYaadw/T+sGn8WETdSY9zcpkClskR1?=
 =?us-ascii?Q?8nqO7QLinKVP8XdpiyNNoAhovKKyswLrbVZCkWKod7fbYcs7diqBuIO4K/xd?=
 =?us-ascii?Q?3Trvo4VCdXnMguwmx9xMORfBg25j1731ql7lL5dhieuAb1INHUPN8sRn9TqB?=
 =?us-ascii?Q?5Euxm2HhpMBTeeMfc0yw63QoDSGa9GQyMpQSLjADyFjvMrzWzo3ebbh4kBk4?=
 =?us-ascii?Q?3CkKLib8Ez/d5bJ8X7OpjieYIpzM3IdGqMahpb+pAPXRNYRoinpog/98mQR1?=
 =?us-ascii?Q?ehMy7j4rsjgY/hTnHW7J8MYoaxidmGPsvm9rHor154t/OEkN3/3ZCUo+4vVy?=
 =?us-ascii?Q?eFvg11Z+xScMpPSDCCOfWBG+r8I0j8+4Kbz39abDdkfnhs60GQTlAwEqjZF8?=
 =?us-ascii?Q?oin78hHSkOp/++Sr2873xoDd3ijp7dC52F7j2nwYfp+sFvGdR7gVcBqxxmzf?=
 =?us-ascii?Q?D4/jr2X0+QRd0KBigkRz0f81pfBnvbRwMU8V/ZMh3igOwUPU+g2OFoZdkpXu?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a320d6-1cc0-46d9-c517-08dba23773ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:12:05.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRFGz9tLOPrZp0qL1O9a7/N3GoE8qtmIohwaR3sz5gyanyqon53lq/RIBOX0UaNSUUB7Jb+FIYd/7dK4Uqvx7jC4u6g9uAsgwhyLAzbjF50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5557
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping!

Thanks,
Shravan


> -----Original Message-----
> From: shravan kumar <shravan.chippa@microchip.com>
> Sent: Friday, August 4, 2023 8:46 PM
> To: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org
> Cc: sakari.ailus@iki.fi; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; shravan Chippa - I35088
> <Shravan.Chippa@microchip.com>
> Subject: [PATCH v2] media: i2c: imx334: add support for test pattern
> generator
>=20
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Add support for the imx334's test pattern generator.
> By default the test pattern generator is disabled, so add support for ena=
bling
> and disabling horizontal and vertical colour bars.
>=20
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 57
> +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c inde=
x
> d722c9b7cd31..91c79af70734 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -56,6 +56,24 @@
>  #define IMX334_REG_MIN		0x00
>  #define IMX334_REG_MAX		0xfffff
>=20
> +/* Test Pattern Control */
> +#define IMX334_REG_TP		0x329e
> +#define IMX334_TP_COLOR_HBARS	0xA
> +#define IMX334_TP_COLOR_VBARS	0xB
> +
> +#define IMX334_TPG_EN_DOUT	0x329c
> +#define IMX334_TP_ENABLE	0x1
> +#define IMX334_TP_DISABLE	0x0
> +
> +#define IMX334_TPG_COLORW	0x32a0
> +#define IMX334_TPG_COLORW_120P	0x13
> +
> +#define IMX334_TP_CLK_EN	0x3148
> +#define IMX334_TP_CLK_EN_VAL	0x10
> +#define IMX334_TP_CLK_DIS_VAL	0x0
> +
> +#define IMX334_DIG_CLP_MODE	0x3280
> +
>  /**
>   * struct imx334_reg - imx334 sensor register
>   * @address: Register address
> @@ -430,6 +448,18 @@ static const struct imx334_reg
> mode_3840x2160_regs[] =3D {
>  	{0x3a29, 0x00},
>  };
>=20
> +static const char * const imx334_test_pattern_menu[] =3D {
> +	"Disabled",
> +	"Vertical Color Bars",
> +	"Horizontal Color Bars",
> +};
> +
> +static const int imx334_test_pattern_val[] =3D {
> +	IMX334_TP_DISABLE,
> +	IMX334_TP_COLOR_HBARS,
> +	IMX334_TP_COLOR_VBARS,
> +};
> +
>  static const struct imx334_reg raw10_framefmt_regs[] =3D {
>  	{0x3050, 0x00},
>  	{0x319d, 0x00},
> @@ -716,6 +746,26 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_HBLANK:
>  		ret =3D 0;
>  		break;
> +	case V4L2_CID_TEST_PATTERN:
> +		if (ctrl->val) {
> +			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
> +					 IMX334_TP_CLK_EN_VAL);
> +			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE,
> 1, 0x0);
> +			imx334_write_reg(imx334, IMX334_TPG_COLORW, 1,
> +					 IMX334_TPG_COLORW_120P);
> +			imx334_write_reg(imx334, IMX334_REG_TP, 1,
> +					 imx334_test_pattern_val[ctrl->val]);
> +			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT,
> 1,
> +					 IMX334_TP_ENABLE);
> +		} else {
> +			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE,
> 1, 0x1);
> +			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
> +					 IMX334_TP_CLK_DIS_VAL);
> +			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT,
> 1,
> +					 IMX334_TP_DISABLE);
> +		}
> +		ret =3D 0;
> +		break;
>  	default:
>  		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
>  		ret =3D -EINVAL;
> @@ -1222,7 +1272,7 @@ static int imx334_init_controls(struct imx334
> *imx334)
>  	u32 lpfr;
>  	int ret;
>=20
> -	ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 6);
> +	ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>  	if (ret)
>  		return ret;
>=20
> @@ -1282,6 +1332,11 @@ static int imx334_init_controls(struct imx334
> *imx334)
>  	if (imx334->hblank_ctrl)
>  		imx334->hblank_ctrl->flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
>=20
> +	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &imx334_ctrl_ops,
> +				     V4L2_CID_TEST_PATTERN,
> +				     ARRAY_SIZE(imx334_test_pattern_menu) -
> 1,
> +				     0, 0, imx334_test_pattern_menu);
> +
>  	if (ctrl_hdlr->error) {
>  		dev_err(imx334->dev, "control init failed: %d",
>  			ctrl_hdlr->error);
> --
> 2.34.1

