Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3357ADB68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjIYP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjIYP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:29:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B195
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:29:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b281a2aa94so260241866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655763; x=1696260563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOrfKssBZ6tPiXkBwLOUz8n2rdUkUTBa6TNU5TWDfM0=;
        b=EBs50kJsng2WoCQOCbmnXYk7D45lrA/U7D4pztlwUaNIvrS+wlwa+6S1HwC/xZkXF0
         vXRCSSKtuVsQCmI1VATfbYrLl820AIE7twg3M/yVdG1RovetIMjMlJ/xDhqZASPtW25F
         n0aO3mESEmngxqcE9reTEfSaLNNHqFeY0SM0hQFpdSZ7SmYeEvtWxM5oHJhmP07hyNj7
         yMf9bP+GuiyOAkHAMcPmsGnwW0dKhc4w61M5OP19n470qZ25I9KTp2FTPsYkIQWjqPlc
         EAgj1IZCDr/THxangKT9bJU3Mg8xOf4rpze3FcHiaa4wrefiWLIjUcQlmnzW3w92/Lcy
         9ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655763; x=1696260563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOrfKssBZ6tPiXkBwLOUz8n2rdUkUTBa6TNU5TWDfM0=;
        b=hmx3jNbd9CLLaC6PgbTOEDJlfcHM73FBm10cN1aI4tyRqyvmmpNJFQfLoMWHTy1wp/
         7BhAmjDisoMmifmi0OnFeX9SzrMtj/5hTDvfdFra3YWugG6XSXcDBZ1T9ZGdJx1nheDq
         ZjYAFIqNLNCAfZxQ0yZvmWmpGg5e6wZ9xLrITsOekAXq60iCj2d7XufqMpWwRiX8feKw
         5Ew+IMGitxwgHPsnPRMRy+00awj589WiDqb5Co8pT4kWTXoQG6XTGXOhhhFOpMPrYruD
         EDFlqX88Jp3Y/41qahI823tyBXbZeCGXwQJlYVt4FQdKiJC4ZYBNO24F+h/7sT7Qzzie
         xznQ==
X-Gm-Message-State: AOJu0Yx+B2j3cLElrm5mZpkgXC/kUwJjMWKonkU37UxJ6OvzwpRtdbr+
        fejoA4/21Vnyy+buXzhHEdc=
X-Google-Smtp-Source: AGHT+IHY89kh3JJby1pbvhe6WVwOjRasFpbMMz9jFOaCxEh+NVsguyRHHY9tQsRWFSkQWTar4MEUog==
X-Received: by 2002:a17:906:8b:b0:9a2:474:4aa0 with SMTP id 11-20020a170906008b00b009a204744aa0mr6407443ejc.48.1695655762414;
        Mon, 25 Sep 2023 08:29:22 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b009b293d1f2eesm553884ejc.107.2023.09.25.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:29:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, airlied@gmail.com, daniel@ffwll.ch,
        samuel@sholland.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] drm/sun4i: dw-hdmi: Switch to bridge functions
Date:   Mon, 25 Sep 2023 17:29:20 +0200
Message-ID: <2167865.Icojqenx9y@jernej-laptop>
In-Reply-To: <vdwkqq3jovlgr6xrprq4mpqv6ldkcklf2v5ffbcetgifwrnatu@4jfjk3f5qbnu>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
 <20230924192604.3262187-4-jernej.skrabec@gmail.com>
 <vdwkqq3jovlgr6xrprq4mpqv6ldkcklf2v5ffbcetgifwrnatu@4jfjk3f5qbnu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. september 2023 ob 09:57:22 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sun, Sep 24, 2023 at 09:26:00PM +0200, Jernej Skrabec wrote:
> > Since ddc-en property handling was moved from sun8i dw-hdmi driver to
> > display connector driver, probe order of drivers determines if EDID is
> > properly read at boot time or not.
> > 
> > In order to fix this, let's switch to bridge functions which allows us
> > to build proper chain and defer execution until all drivers are probed.
> > 
> > Fixes: 920169041baa ("drm/sun4i: dw-hdmi: Fix ddc-en GPIO consumer conflict")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 114 +++++++++++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |   5 ++
> >  2 files changed, 117 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > index 8f8d3bdba5ce..93831cdf1917 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -8,14 +8,82 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  
> > +#include <drm/drm_atomic_state_helper.h>
> > +#include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_managed.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_simple_kms_helper.h>
> >  
> > +#include <media/cec-notifier.h>
> > +
> >  #include "sun8i_dw_hdmi.h"
> >  #include "sun8i_tcon_top.h"
> >  
> > +#define bridge_to_sun8i_dw_hdmi(x) \
> > +	container_of(x, struct sun8i_dw_hdmi, enc_bridge)
> > +
> > +static int sun8i_hdmi_enc_attach(struct drm_bridge *bridge,
> > +				 enum drm_bridge_attach_flags flags)
> > +{
> > +	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
> > +
> > +	return drm_bridge_attach(&hdmi->encoder, hdmi->hdmi_bridge,
> > +				 &hdmi->enc_bridge, flags);
> > +}
> > +
> > +static void sun8i_hdmi_enc_detach(struct drm_bridge *bridge)
> > +{
> > +	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
> > +
> > +	cec_notifier_conn_unregister(hdmi->cec_notifier);
> > +	hdmi->cec_notifier = NULL;
> > +}
> > +
> > +static void sun8i_hdmi_enc_hpd_notify(struct drm_bridge *bridge,
> > +				      enum drm_connector_status status)
> > +{
> > +	struct sun8i_dw_hdmi *hdmi = bridge_to_sun8i_dw_hdmi(bridge);
> > +	struct edid *edid;
> > +
> > +	if (!hdmi->cec_notifier)
> > +		return;
> > +
> > +	if (status == connector_status_connected) {
> > +		edid = drm_bridge_get_edid(hdmi->hdmi_bridge, hdmi->connector);
> > +		if (edid)
> > +			cec_notifier_set_phys_addr_from_edid(hdmi->cec_notifier,
> > +							     edid);
> > +	} else {
> > +		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> > +	}
> > +}
> > +
> > +static int sun8i_hdmi_enc_atomic_check(struct drm_bridge *bridge,
> > +				       struct drm_bridge_state *bridge_state,
> > +				       struct drm_crtc_state *crtc_state,
> > +				       struct drm_connector_state *conn_state)
> > +{
> > +	struct drm_connector_state *old_conn_state =
> > +		drm_atomic_get_old_connector_state(conn_state->state,
> > +						   conn_state->connector);
> > +
> > +	if (!drm_connector_atomic_hdr_metadata_equal(old_conn_state, conn_state))
> > +		crtc_state->mode_changed = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct drm_bridge_funcs sun8i_hdmi_enc_bridge_funcs = {
> > +	.attach = sun8i_hdmi_enc_attach,
> > +	.detach = sun8i_hdmi_enc_detach,
> > +	.hpd_notify = sun8i_hdmi_enc_hpd_notify,
> > +	.atomic_check = sun8i_hdmi_enc_atomic_check,
> > +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> > +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> > +	.atomic_reset = drm_atomic_helper_bridge_reset,
> > +};
> > +
> >  static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
> >  					   struct drm_display_mode *mode,
> >  					   struct drm_display_mode *adj_mode)
> > @@ -99,6 +167,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct dw_hdmi_plat_data *plat_data;
> > +	struct cec_connector_info conn_info;
> > +	struct drm_connector *connector;
> >  	struct drm_device *drm = data;
> >  	struct device_node *phy_node;
> >  	struct drm_encoder *encoder;
> > @@ -187,18 +257,57 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
> >  
> >  	plat_data->mode_valid = hdmi->quirks->mode_valid;
> >  	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;
> > +	plat_data->output_port = 1;
> >  	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
> >  
> >  	platform_set_drvdata(pdev, hdmi);
> >  
> > -	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
> > +	hdmi->hdmi = dw_hdmi_probe(pdev, plat_data);
> >  	if (IS_ERR(hdmi->hdmi)) {
> >  		ret = PTR_ERR(hdmi->hdmi);
> >  		goto err_deinit_phy;
> >  	}
> >  
> > +	hdmi->hdmi_bridge = of_drm_find_bridge(dev->of_node);
> 
> So you're also adding child bridge support? This should be mentioned in
> the commit log.
> 
> > +	hdmi->enc_bridge.funcs = &sun8i_hdmi_enc_bridge_funcs;
> > +	hdmi->enc_bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> > +	hdmi->enc_bridge.interlace_allowed = true;
> > +
> > +	drm_bridge_add(&hdmi->enc_bridge);
> > +
> > +	ret = drm_bridge_attach(encoder, &hdmi->enc_bridge, NULL,
> > +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > +	if (ret)
> > +		goto err_remove_dw_hdmi;
> > +
> > +	connector = drm_bridge_connector_init(drm, encoder);
> > +	if (IS_ERR(connector)) {
> > +		dev_err(dev, "Unable to create HDMI bridge connector\n");
> > +		ret = PTR_ERR(connector);
> > +		goto err_remove_dw_hdmi;
> > +	}
> > +
> > +	hdmi->connector = connector;
> > +	drm_connector_attach_encoder(connector, encoder);
> > +
> > +	if (hdmi->quirks->use_drm_infoframe)
> > +		drm_connector_attach_hdr_output_metadata_property(connector);
> > +
> > +	cec_fill_conn_info_from_drm(&conn_info, connector);
> > +
> > +	hdmi->cec_notifier = cec_notifier_conn_register(&pdev->dev, NULL,
> > +							&conn_info);
> > +	if (!hdmi->cec_notifier) {
> > +		ret = -ENOMEM;
> > +		goto err_remove_dw_hdmi;
> > +	}
> > +
> >  	return 0;
> 
> Yeah, I'm not sure. We now have two different yet redundant set of
> operations with no clear definition wrt what belongs where. I'm really
> not impressed with the use of bridges for things that are clearly not
> bridges.

DRM bridges should be taken as more broad concept than just a physical
bridge.

> 
> The "nothing happens until all drivers are loaded" argument is also
> supposed to be covered by the component framework, so why do we even
> have to use a bridge here?

There is more than one reason:
- Display connector driver, which sets ddc-en gpio, is purely bridge driver.
- In long term, I plan to add format negotiation between display, dw-hdmi
  and DE3 (I already have WIP code). This is already implemented in bridge
  infrastructure.
- There is a plan to remove connector handling from DW HDMI handling
  and use display connector driver instead. This again involves bridges.
  sun4i-drm and rockchip-drm are the only remaining drivers, which are
  not yet converted.

> 
> You were saying that it's an issue of probe order going wrong, could you
> explain a bit more what goes wrong so we can try to figure something out
> that doesn't involve a bridge?

Not sure how to make this clearer than in cover letter and this commit
message. ddc-en pin is responsibility of display-connector driver (see
commit mentioned in fixes tag), so it must probe before sun8i dw hdmi.

Why are you so against bridges? As I explained above, format negotiation
is really implemented only there, so they are needed at some point
anyway.

Best regards,
Jernej


