Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA17692FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjGaKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjGaKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:20:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E3B1732;
        Mon, 31 Jul 2023 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690798789; x=1722334789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qtxdLrp2lTZ1W6zsv8Jivm6JoQtiCvPoG6teWuEOObk=;
  b=eK76kgW/Uw4yYWqP8PQcTpKFSjXJuRjug0/enniUrffusndt1OFk13+R
   FR97KZE+X7clwtc/c6Tc2wi/I3QEejvTqQT3EpQFfKlqd7xRnJxeFVNjr
   Hh6Gl2s2nBxczC8kN1fXSiCIF7OJwAy7cX0tGiR7FXkPrfiEB92U87ObQ
   73QzcExsnLzN02eexq5Uu2uJbvMWykHHSL0zlu7x2OomQp9hT+FNnhmoV
   5NebBStquI+4UEidoSeeJ5XYRRURJig3oywyRbNdrkoNhuyNIabOjfT6h
   tdjiHnl0Lho2sfwlEDSeNuYcGa3zsMWHVxQmWYBcVoJL3jjst3aec9Oi4
   g==;
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="164100292"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2023 03:19:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 31 Jul 2023 03:19:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 31 Jul 2023 03:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emBUG/aeRrzF6zBuBqwHZ5TTi33XSoe6UezgUuW1EDUEwcCMBptIQ1iaDQYyOMNIcZeXHhYvv9U/zD8wf5gHwT9BDQwaK5I3lA1L9T8ahW3SL13cemKm81MspWZan8mm6nylBWbRw6x4o65jOyiJmcnFQ0zlX7W0UVrr6jeIY5qZLKWtacW1enZ7IXCGl1IT1XJwFi9izuwYWb3emkU2FI1bnHEntGxeRqCbI0ncKhdXfPhNde7ZQ4mp0+dyOm0ZcVqkoF7eZAcJrxW5g+FPDGQ+gVZnVK0AzNSA/siJi61F+r9KYjGfNftAGMyKWM3IOpylS9Au5UBRwe2tEH1F6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp4gSEPMaIgEJya5bMw2c7LnpELCV6kDwpZnE04CF2Y=;
 b=b7tkSGx9Ws86g376SApAcJQnNazoj7We3j6ykiaVSlJrIrvwltt2qjkQTCfVfyZ45NQwfWHruQ2ipTKrKtYKdaBwh3Hq90jyXMfUMYm6Dy5Ob8KN3sLV7HyY6Ef/R+BH0Duab4Du5NqCJATCeSrw/VRAUL4+JTLFgCuxkysmFGsKUTUctKF/Ev0AEj6DDY4dJg95lk9KNOUoZOx7gCEP0o90y5lFcrh37CgRgr73etZoBy8gJ9nj+zmR2NOOOs0gxifLgLN+XDwhSMX2XoA1WAoijkIhu6tSUB0ni6424tMQc9MMTiGeQiqxY82/eW4ZvjamZ7kqC5so3Pv8pQWYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp4gSEPMaIgEJya5bMw2c7LnpELCV6kDwpZnE04CF2Y=;
 b=HMJtPIBWK3o2jBMN/Katf2E051UV8pDLKuKYUCDVwBZdBLFEZxC90T/E5Me8q9HlE60Cuhj8TDEoTjczt49iXjUkQiGfDF+w+9IbkWynsFi2/w85/7wDPeYUpuUBHq9SLFZHkxWGlugR2W+ZzSApIjoMpyur38DFi45TKFQTT2o=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 10:19:29 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 10:19:29 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <Shravan.Chippa@microchip.com>, <paul.j.murphy@intel.com>,
        <daniele.alessandrelli@intel.com>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] media: i2c: imx334: add support for test pattern
 generator
Thread-Topic: [PATCH] media: i2c: imx334: add support for test pattern
 generator
Thread-Index: AQHZsxQYYBGO5cxM8kaGl0t15rBqFq/TykLg
Date:   Mon, 31 Jul 2023 10:19:29 +0000
Message-ID: <PH0PR11MB56115C777A76F5E17F5D79008105A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230710095111.2994969-1-shravan.chippa@microchip.com>
In-Reply-To: <20230710095111.2994969-1-shravan.chippa@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|CY8PR11MB7172:EE_
x-ms-office365-filtering-correlation-id: 31c8443d-1aed-4d09-dd5e-08db91af9ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qy45j/iIQDLjza1WY4P9ytXy6CDDPm5iKztxkKf/Pnozs+1aYZZC0vm3I26oBP/zA0CWxZxMDIotf4hM0cp66SKE2XpdYHUcV9MqA+RdScBSIO6enr6uj398GUsKaVAbp+VlFGuB91GavjRr9myWf3rHBoHkipXf1HhMGuGvZjwvijE6tW76wp3R9oUw881awxvopiyGr5a6X2AwWHO2VAHrQh2Wln09UVvLVbjXvvxUJK/xkKNGuWlaBitUFgpQ1VYp7kGmHT5htS5RACRQ6GwUQkwdo8RDq3njbLiujoxg3UiehGDBK9zWEm/VEwA9fvBt4Hf8dkahw0FLg+nenwUB57w2goMalOqIUOCfry/s/7BevT17BNXdmqS48ijDXteFQW5K8W1u0UazWhzCu78cgyvlHDHkn+6h9Kv9mn9qx9FED+TGx4rHKY2Wefz9v00IL+V+1yulu9z9tmz4sPLMzhcUaewY+ztnPVAdPlzopCpiPr6thWu49lx54dvCOcDld0Pgd82Vj4VAJAR6riw8dBwj+8nQihn1V8WHX7DNv7RWHGKd6ciFVQeAFl6zUODyRGbebD/OFyyDuJ9XvXfPCOVTc+2t/VsmRvIO1h6baAfVGZXL6G/Aya4dYkQL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(38100700002)(122000001)(55016003)(86362001)(38070700005)(33656002)(9686003)(478600001)(71200400001)(7696005)(53546011)(186003)(26005)(8676002)(8936002)(6506007)(52536014)(5660300002)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(54906003)(110136005)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nDu6EBQESDCLKBkW1Thk5uZC4rkC6f7O1BV7wLtGG8okHx1IiUOfYjpdUwE?=
 =?us-ascii?Q?CzUsBo7kCW2nOuYVuknlEVs1diNa3FMvJK+564Smiw4BFYYLyKLCbYPHB5Wh?=
 =?us-ascii?Q?bTxoasXLtXfw6ryV95J9Rqc1X/kf5JUGuirrgh82VScE5aNeWmJpKzimMTDQ?=
 =?us-ascii?Q?7AnMy6kBe+ktfvwBKJ3IuF/gQVZ6PTNucMVC7b0ABxSuNx3hwqeYLRiQRzOU?=
 =?us-ascii?Q?HW92CRN7rv6YOa05RcZYW5q/s5WpOQ/GrP/FnC75w9lKdYwryDzcv7gM2AIM?=
 =?us-ascii?Q?holR17+Fgh66sPFKz+eyAmyhMjE1CR1AWG/zZ8IlKRK9ttahTXtHpGVMzdP4?=
 =?us-ascii?Q?qgmqWaJh+x52mXL2jOxwEKSC9RHiAEvpr7SPRmQw6Id6p1u9DxFcwqhwWBN0?=
 =?us-ascii?Q?j3zZUgcr0HwcpGPIv/q8oGAWU65umwI4+p/aDSAbKU2eM91ZK39l55Tq+X9N?=
 =?us-ascii?Q?ML8bITXri04HgfuRKqP3EC8vQOmQ6isDPeZcWhdXE2zvMoelKZhg8LmmLMj/?=
 =?us-ascii?Q?ku7MdcSDJZW1pzKrVYoXwHch4XIkvh9UVwghwhODSrOI1BqUdKOJ5Qusmhi4?=
 =?us-ascii?Q?yTuazJ4HWzYHbfyqtxy+NDmekNTwhZokO6SMkGt2HovIII/W/lwNSe2qWnW8?=
 =?us-ascii?Q?uFB/ZDl98S7gugd0OjNjJVPDBLFOPHkNZyJiT+N6QqgLGHbOhyVXSLq/63LH?=
 =?us-ascii?Q?RKfZm4SF97RRqD7q2nuQr3b4BLAsBsAU0wFGLbnTI4ICjKVXjbja+0cizZOB?=
 =?us-ascii?Q?oXoTkzisa9fN9bZPLe3cQUjyIDCGXo3V8W+0GVk3EdCiuCDnuuXsF4YaSihs?=
 =?us-ascii?Q?U//3WJPN/TJ4VsHuWV6LIct74xpI+UakNWW03VQOqQ+r7oZ3kPCjwmqsvQZk?=
 =?us-ascii?Q?IYeshcsDJf70lDy5fGA+ICV23UcTm/Yg6K+Q+ZnnhKJqVUg9q7BAVMNPFMi+?=
 =?us-ascii?Q?IDo4w+Pgy/g+oRb7aK6dWGEE8SD0T6SiQ6wPVjxbg4tCpjkJBAbPljSvOE0g?=
 =?us-ascii?Q?UI/OYX++nYaM9qO8hMr3CCXNHq14QTf0fvodd1LK5gb3mOV+6vMQFya+ubX0?=
 =?us-ascii?Q?/hL8GdPv+NCT6IzhgNppb1Mwimm3m6fHS9uJVBSoWS23K3V7CBC4+g6Tc6fM?=
 =?us-ascii?Q?NzPpaCd6KHvusu+FdA0Izs8SLZrA6iA9oEd+X5/5LH0xEj5edsfcRGjmyHKg?=
 =?us-ascii?Q?fNkF6dApeeR3Z75+wc2ylUhVYtZNqol0xEMXEz8rFIvOG0cDMrcV9Ti8VM7f?=
 =?us-ascii?Q?55NoiCoBfEzskxo6LdXr0xM/D6mIsyvErAD6iHH40h5Y9vJUup2puidUrxYK?=
 =?us-ascii?Q?BTuxF8tH+NzPf9FdpJsHHe9pD8M5rtxiGvEI3POaCFxARjRdSfiznkv4CzCt?=
 =?us-ascii?Q?pGtm2rclCCo1v23OhOdwehNByW9o8Cq3xtXFidteBZBojD9HtQ7AU5VVXt6L?=
 =?us-ascii?Q?FK8pwGOP9FGgCCW7BDzGDVtk8HvjUgx0Lk0YVr3/C9DE+ZwYBq38KZszX6fL?=
 =?us-ascii?Q?CicCvYCo1uU6nZgu8TIiXdN39s0gTC2Pav3BskKFyzNjzZOx0BpSfzqCzCfK?=
 =?us-ascii?Q?XonI6qQEQCx7zVrlxMhxam9lcL4btXfM6DoaZ9xie9AgB3wvFVmo0zU3AOGz?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c8443d-1aed-4d09-dd5e-08db91af9ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 10:19:29.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzPM7bZq8puK7LsEUa32dY2knrdDi/rEvMXe3sOolIas5G8vzi1rcHqVZd0bQPqwhyG3ozpFwMRiorwkzuSfHAM2iV4kiahJJaKZlqtYEb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> Sent: Monday, July 10, 2023 3:21 PM
> To: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org; shravan
> Chippa - I35088 <Shravan.Chippa@microchip.com>
> Subject: [PATCH] media: i2c: imx334: add support for test pattern generat=
or
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
> b65c526a5f1c..248ab65a6725 100644
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
> @@ -429,6 +447,18 @@ static const struct imx334_reg
> mode_3840x2160_regs[] =3D {
>  	{0x3a29, 0x00},
>  };
>=20
> +static const char * const imx334_test_pattern_menu[] =3D {
> +	"Disabled",
> +	"Color Bars Ver",
> +	"Color Bars Hor",
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
> @@ -711,6 +741,26 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
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
> @@ -1217,7 +1267,7 @@ static int imx334_init_controls(struct imx334
> *imx334)
>  	u32 lpfr;
>  	int ret;
>=20
> -	ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 6);
> +	ret =3D v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>  	if (ret)
>  		return ret;
>=20
> @@ -1277,6 +1327,11 @@ static int imx334_init_controls(struct imx334
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

