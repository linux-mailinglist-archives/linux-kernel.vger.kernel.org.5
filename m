Return-Path: <linux-kernel+bounces-81364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA688674DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310E3285055
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676BD60863;
	Mon, 26 Feb 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mB6dP2If"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21498604C5;
	Mon, 26 Feb 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950482; cv=none; b=UeUM6534UWZEwIGTaC5KfXBo9EAiNtkexaqDgLf871y73TklpJW31+j/RHyLv11h26JQHyZBxLEwktaToLpUkU3tXkR7WhUnM3qxj/60aEvomyeGnziWUjzClUGOsawFUbi5Pwc0RHzlFeexgoSbORrqsi/t7WjhMxmBJPpjvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950482; c=relaxed/simple;
	bh=miy4N2ehf3wS51/2HOmrvNhD5ox2WtUJHV9WrrQzbcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAhgulAkZmj99lSHZqYe2mYX3vP0xKLcvndbQtrunS68Rnzi8LoaidNkFMSVet4RBiOIXidFstuEok52J9s+M5j5g6B8M2mLeHIpoZQ/tiPvDIfRTwGz1ZRNGo09q3QWBOKoFc4l0ZYuM9lkicHCk6h3g5xKXfH0HAIXLJCG7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mB6dP2If; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BehYZsTcBskWJbVJTSYJK03NQKC1Vfs2VOyvrT1egZI=; b=mB6dP2IfuiHH2mt6Om4PMPs6LD
	+njc7OCEnWxnk188JDHYXrrtzN6ZVA/52jhCzCL7Zmyq8Au0H8Hhs1qOLmvYUC2zaernc0A4C/4q8
	6KHeZK/Ixtp8yngEKbkrNfXn3iOWHokcG6TsPgJTxBOXahIQylM1PPqzfZN3H9vg6sSKb6W11NwE+
	farhczgWnrfLuQdX1H7PAZP0zYJUB9H9vRj/Dzi/yS2J7z+T/ItwIb5P0gvgvd+8Dn0zCaet0Rnir
	lrzLR5j8rAuvqoWauYbpFF3Y0hdOHR535+5MvMp1N4q/dTPTvJDyNVcGQI3AsAvsS6Z69ayquB+Ay
	tknsYalQ==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rea58-003Yij-Nd; Mon, 26 Feb 2024 13:27:43 +0100
Message-ID: <f078cbc0-f8bd-4e14-9395-09afa851a070@igalia.com>
Date: Mon, 26 Feb 2024 09:27:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/36] drm/tests: connector: Add tests for
 drmm_connector_init
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-5-8f4af575fce2@kernel.org>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-5-8f4af575fce2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 15:13, Maxime Ripard wrote:
> drmm_connector_init is the preferred function to initialize a
> drm_connector structure. Let's add a bunch of unit tests for it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/tests/drm_connector_test.c | 170 ++++++++++++++++++++++++++++-
>   1 file changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
> index c66aa2dc8d9d..a268847be8d1 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -3,10 +3,175 @@
>    * Kunit test for drm_modes functions
>    */
>   
> +#include <linux/i2c.h>
> +
> +#include <drm/drm_atomic_state_helper.h>
>   #include <drm/drm_connector.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_kunit_helpers.h>
>   
>   #include <kunit/test.h>
>   
> +struct drm_connector_init_priv {
> +	struct drm_device drm;
> +	struct drm_connector connector;
> +	struct i2c_adapter ddc;
> +};
> +
> +static const struct drm_connector_funcs dummy_funcs = {
> +	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
> +	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
> +	.reset			= drm_atomic_helper_connector_reset,
> +};
> +
> +static int dummy_ddc_xfer(struct i2c_adapter *adapter,
> +			  struct i2c_msg *msgs, int num)
> +{
> +	return num;
> +}
> +
> +static u32 dummy_ddc_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm dummy_ddc_algorithm = {
> +	.master_xfer = dummy_ddc_xfer,
> +	.functionality = dummy_ddc_func,
> +};
> +
> +static void i2c_del_adapter_wrapper(void *ptr)
> +{
> +	struct i2c_adapter *adap = ptr;
> +
> +	i2c_del_adapter(adap);
> +}
> +
> +static int drm_test_connector_init(struct kunit *test)
> +{
> +	struct drm_connector_init_priv *priv;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = drm_kunit_helper_alloc_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	priv = drm_kunit_helper_alloc_drm_device(test, dev,
> +						 struct drm_connector_init_priv, drm,
> +						 DRIVER_MODESET | DRIVER_ATOMIC);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +
> +	strscpy(priv->ddc.name, "dummy-connector-ddc", sizeof(priv->ddc.name));
> +	priv->ddc.owner = THIS_MODULE;
> +	priv->ddc.algo = &dummy_ddc_algorithm;
> +	priv->ddc.dev.parent = dev;
> +
> +	ret = i2c_add_adapter(&priv->ddc);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = kunit_add_action_or_reset(test, i2c_del_adapter_wrapper, &priv->ddc);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	test->priv = priv;
> +	return 0;
> +}
> +
> +/*
> + * Test that the registration of a bog standard connector works as
> + * expected and doesn't report any error.
> + */
> +static void drm_test_drmm_connector_init(struct kunit *test)
> +{
> +	struct drm_connector_init_priv *priv = test->priv;
> +	int ret;
> +
> +	ret = drmm_connector_init(&priv->drm, &priv->connector,
> +				  &dummy_funcs,
> +				  DRM_MODE_CONNECTOR_HDMIA,
> +				  &priv->ddc);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +/*
> + * Test that the registration of a connector without a DDC adapter
> + * doesn't report any error.
> + */
> +static void drm_test_drmm_connector_init_null_ddc(struct kunit *test)
> +{
> +	struct drm_connector_init_priv *priv = test->priv;
> +	int ret;
> +
> +	ret = drmm_connector_init(&priv->drm, &priv->connector,
> +				  &dummy_funcs,
> +				  DRM_MODE_CONNECTOR_HDMIA,
> +				  NULL);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +/*
> + * Test that the registration of a connector succeeds for all possible
> + * connector types.
> + */
> +static void drm_test_drmm_connector_init_type_valid(struct kunit *test)
> +{
> +       struct drm_connector_init_priv *priv = test->priv;
> +       unsigned int connector_type = *(unsigned int *)test->param_value;
> +       int ret;
> +
> +       ret = drmm_connector_init(&priv->drm, &priv->connector,
> +				 &dummy_funcs,
> +				 connector_type,
> +				 &priv->ddc);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static const unsigned int drm_connector_init_type_valid_tests[] = {
> +	DRM_MODE_CONNECTOR_Unknown,
> +	DRM_MODE_CONNECTOR_VGA,
> +	DRM_MODE_CONNECTOR_DVII,
> +	DRM_MODE_CONNECTOR_DVID,
> +	DRM_MODE_CONNECTOR_DVIA,
> +	DRM_MODE_CONNECTOR_Composite,
> +	DRM_MODE_CONNECTOR_SVIDEO,
> +	DRM_MODE_CONNECTOR_LVDS,
> +	DRM_MODE_CONNECTOR_Component,
> +	DRM_MODE_CONNECTOR_9PinDIN,
> +	DRM_MODE_CONNECTOR_DisplayPort,
> +	DRM_MODE_CONNECTOR_HDMIA,
> +	DRM_MODE_CONNECTOR_HDMIB,
> +	DRM_MODE_CONNECTOR_TV,
> +	DRM_MODE_CONNECTOR_eDP,
> +	DRM_MODE_CONNECTOR_VIRTUAL,
> +	DRM_MODE_CONNECTOR_DSI,
> +	DRM_MODE_CONNECTOR_DPI,
> +	DRM_MODE_CONNECTOR_WRITEBACK,
> +	DRM_MODE_CONNECTOR_SPI,
> +	DRM_MODE_CONNECTOR_USB,
> +};
> +
> +static void drm_connector_init_type_desc(const unsigned int *type, char *desc)
> +{
> +	sprintf(desc, "%s", drm_get_connector_type_name(*type));
> +}
> +
> +KUNIT_ARRAY_PARAM(drm_connector_init_type_valid,
> +		  drm_connector_init_type_valid_tests,
> +		  drm_connector_init_type_desc);
> +
> +static struct kunit_case drmm_connector_init_tests[] = {
> +	KUNIT_CASE(drm_test_drmm_connector_init),
> +	KUNIT_CASE(drm_test_drmm_connector_init_null_ddc),
> +	KUNIT_CASE_PARAM(drm_test_drmm_connector_init_type_valid,
> +			 drm_connector_init_type_valid_gen_params),
> +	{ }
> +};
> +
> +static struct kunit_suite drmm_connector_init_test_suite = {
> +	.name = "drmm_connector_init",
> +	.init = drm_test_connector_init,
> +	.test_cases = drmm_connector_init_tests,
> +};
> +
>   struct drm_get_tv_mode_from_name_test {
>   	const char *name;
>   	enum drm_connector_tv_mode expected_mode;
> @@ -70,7 +235,10 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
>   	.test_cases = drm_get_tv_mode_from_name_tests,
>   };
>   
> -kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
> +kunit_test_suites(
> +	&drmm_connector_init_test_suite,
> +	&drm_get_tv_mode_from_name_test_suite
> +);
>   
>   MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>   MODULE_LICENSE("GPL");
> 

