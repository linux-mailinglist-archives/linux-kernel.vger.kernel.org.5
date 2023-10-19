Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7E7CF405
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJSJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345035AbjJSJ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B67106;
        Thu, 19 Oct 2023 02:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766EC433C7;
        Thu, 19 Oct 2023 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697707585;
        bh=OCDUlYLWKH4hPIGJgGmkgyAHhL7/848MWsrLLQz3nbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9FqAg7Z6b7b6Q+l58S5MAWVseQF0hpk4HZJmu/Hy2hgyt/hquWS//yFAFbJPXpcG
         X4hOWD8y7KfJVGQ/eQL4O5JNMKRj8HKmPlKLZX5i8buLhzX+9g7jHDRGrLj9JjUTPX
         DQrBMOOppV2i/G26YN4EKlDl3ibLcvVPJrTOGb4tYc3VFUZMCRBRlVqkw99uabprEt
         SY0NBKCLqyNNgfC5G2jzbL1q7AYVrU6c8WN/+g30iejbiE4ZvhdsbR67AfG22oI3Ym
         h0G4t60zOQjJPH4PS9JSY8nlfZC889dgSie0TKOnqdIF9FI+Fla58dEyHFqqmZUjZv
         r/6eOlbpmKpvg==
Date:   Thu, 19 Oct 2023 11:26:16 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Message-ID: <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
References: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
 <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231016165355.1327217-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:53:48PM +0300, Dmitry Baryshkov wrote:
> The MIPI DSI links do not fully fall into the DRM callbacks model.

Explaining why would help

> The drm_bridge_funcs abstraction.

Is there a typo or missing words?

> Instead of having just two states (off and on) the DSI hosts have
> separate LP-11 state. In this state the host is on, but the video
> stream is not yet enabled.
>=20
> Introduce API that allows DSI bridges / panels to control the DSI host
> power up state.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     | 29 +++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 14201f73aab1..c467162cb7d8 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -428,6 +428,37 @@ int devm_mipi_dsi_attach(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
> =20
> +bool mipi_dsi_host_power_control_available(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops =3D host->ops;
> +
> +	return ops && ops->power_up;
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_control_available);
> +
> +int mipi_dsi_host_power_up(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops =3D host->ops;
> +
> +	if (!mipi_dsi_host_power_control_available(host))
> +		return -EOPNOTSUPP;
> +
> +	return ops->power_up ? ops->power_up(host) : 0;
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_up);
> +
> +void mipi_dsi_host_power_down(struct mipi_dsi_host *host)
> +{
> +	const struct mipi_dsi_host_ops *ops =3D host->ops;
> +
> +	if (!mipi_dsi_host_power_control_available(host))
> +		return;
> +
> +	if (ops->power_down)
> +		ops->power_down(host);
> +}
> +EXPORT_SYMBOL_GPL(mipi_dsi_host_power_down);
> +

If this API is supposed to be used by DSI devices, it should probably
take a mipi_dsi_device pointer as a parameter?

We should probably make sure it hasn't been powered on already too?

Maxime
