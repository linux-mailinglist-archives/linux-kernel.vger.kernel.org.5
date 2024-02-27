Return-Path: <linux-kernel+bounces-82609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE710868712
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC257B2688A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84910A0D;
	Tue, 27 Feb 2024 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0uzbVx5"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81044A28
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000925; cv=none; b=ucv05JogPJeZHNPbw19/QmKP1uQdXgjxBkH+qIFQWqRFTRybDh1nIXtG8ZvQBY97FIyCBTVgyCe179oobfT8GRBlk+H4MLGiCYr9eAV+owiptPEeqng4Py7OzBPzBgzn7hHFCwEhIzhtsBgUjfyWLjObZC9OFo9cVZy8mnyIWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000925; c=relaxed/simple;
	bh=HKAijoFYBW695X3LlmkH83hiSUHIDJwE4sstHDgL7aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEMUbhQE9hY3dV1J7ioGwv+3iU/yURTyheVRD+QGdwMDYE4vpANk8DWQG2KtMmsjx5mTRjucQp8gOnuygeyD7qimXB8ITb5AT6hEEm7UfXfxBBKC3cHTCA3dkDrhFs6p/IDufkeCrqXlO4MekRxlWFUiPGaD9kjbfaMv16NXIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0uzbVx5; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc745927098so3562647276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709000922; x=1709605722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XAVC2O8s1iUmh8KQv0O2JZAD88RsKV5A8vS2LeefpzI=;
        b=r0uzbVx5WL/hZx+yXFUf2xs8BdECezE5uGEUeqVNM5QfYhi7l9Yilk4b2s/dzD8f6y
         hnPW2bzaAHRG/LUepI35y0lowNAbciUr1zVanRyIOIwT5zBYJMcurfJyOzPVOtlHsDU1
         VU1P4Qox7w8ucPyBeXEaTZeK6i889zPjFcsXPFzlpvowz5aa6oU9w2O0sSKTFpIiv+Lk
         I+EiGtMHhbbyaypL9/ONbUJyfh8W+KPJuJVEe0UnQY81NUW0RG9cs1Jje8m64s1aOFrs
         iQXisn8iKAqKkSzBHRXz20dviHNohwNScmDwnV5MOcxKRF3u5Wj+lDmjXj5Tj/DzBTv2
         vaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000922; x=1709605722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAVC2O8s1iUmh8KQv0O2JZAD88RsKV5A8vS2LeefpzI=;
        b=f+J7p0kyFUqYHvBl3ev9OHWHA18FJRqJA/PnH7PC8mws3jLcY5cyzxigIll/GbaUUI
         wFtYFJGEAVBNKN9hXDWebUnPCiUls47dfmlKhhty/n4TouIUAxmM/vWwUwSdg3qw88dt
         Ji7t4wKpQQeLZO0LLT2TRUKx60ta1seFf6EZ5E0Kw7HKw0ROXA+kiGOuAxGivIT+SKpt
         usHEOtjiuLqtO93CjwzmAd5N5TNKbA9+JshQzRYGuEofNGlacKlGwbtkf9Vr22q5etV4
         eTlxtyaF+G9KsHZ9vuvdeKAtJ3tF2GlgU1LeV98ewlj1FdMI68Pt2/jmhSDbRa9MFcnf
         JY7A==
X-Forwarded-Encrypted: i=1; AJvYcCV6/S1EA2KK0FrUBNcbf4ZnJ2d01/rlA6nlNVXLbmQeae9O96r9GShkQljy4oCF1ElRo2FAiNOJSRFktY89g9ckUuTTCoWOq60qOL45
X-Gm-Message-State: AOJu0YxFpo78PtekLP8mv80rGCvZbqttKWHXTtf9mRyRLA36z3+y/7mB
	6fxvNAa9+f728e0tiTEI2zo69ynWTeSpWHLRfM+MejT1KVf1HRzd8d3G6ZlvrAn63vZfXd+vwut
	F06mTnEg9UagSuTQQqfRwYP6Y/mtEPvWLUlDrxQ==
X-Google-Smtp-Source: AGHT+IEJZmKxPHJfJTilEO3vsxmovuF2Xw6qItC6/DQpu6WaZopaBrkRcTD6MSJNKHUlioZSye0ybLoXHGMmHnHmphE=
X-Received: by 2002:a25:a383:0:b0:dcc:383b:e48d with SMTP id
 e3-20020a25a383000000b00dcc383be48dmr1002565ybi.26.1709000922566; Mon, 26 Feb
 2024 18:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-3-hsinyi@chromium.org>
In-Reply-To: <20240223223958.3887423-3-hsinyi@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 27 Feb 2024 04:28:31 +0200
Message-ID: <CAA8EJpq2GkJnV52bS2WOQkvKQKw8mR4607nGz8pOon0FwysnWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: panel-edp: Match with panel hash for
 overridden modes
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 00:40, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> It's found that some panels have variants that they share the same panel id
> although their EDID and names are different. One of the variants requires
> using overridden modes to resolve glitching issue as described in commit
> 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"). Other variants should
> use the modes parsed from EDID.
>
> For example, AUO 0x405c B116XAK01.0, it has at least 2 different variants
> that EDID and panel name are different, but using the same panel id. One of
> the variants require using overridden mode. Same case for AUO 0x615c
> B116XAN06.1.
>
> Add such entries and use the hash of the EDID to match the panel needs the
> overridden modes.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 52 +++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index f6ddbaa103b5..42c430036846 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>
> +#include <linux/crc32.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -213,6 +214,9 @@ struct edp_panel_entry {
>         /** @panel_id: 32-bit ID for panel, encoded with drm_edid_encode_panel_id(). */
>         u32 panel_id;
>
> +       /** @panel_hash: the CRC32 hash of the EDID base block. */
> +       u32 panel_hash;
> +
>         /** @delay: The power sequencing delays needed for this panel. */
>         const struct panel_delay *delay;
>
> @@ -758,13 +762,13 @@ static void panel_edp_parse_panel_timing_node(struct device *dev,
>                 dev_err(dev, "Reject override mode: No display_timing found\n");
>  }
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 panel_hash);
>
>  static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>  {
>         struct panel_desc *desc;
>         void *base_block;
> -       u32 panel_id;
> +       u32 panel_id, panel_hash;
>         char vend[4];
>         u16 product_id;
>         u32 reliable_ms = 0;
> @@ -796,15 +800,17 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
>         base_block = drm_edid_get_base_block(panel->ddc);
>         if (base_block) {
>                 panel_id = drm_edid_get_panel_id(base_block);
> +               panel_hash = crc32_le(~0, base_block, EDID_LENGTH) ^ 0xffffffff;
>                 kfree(base_block);
>         } else {
>                 dev_err(dev, "Couldn't identify panel via EDID\n");
>                 ret = -EIO;
>                 goto exit;
>         }
> +
>         drm_edid_decode_panel_id(panel_id, vend, &product_id);
>
> -       panel->detected_panel = find_edp_panel(panel_id);
> +       panel->detected_panel = find_edp_panel(panel_id, panel_hash);
>
>         /*
>          * We're using non-optimized timings and want it really obvious that
> @@ -1006,6 +1012,19 @@ static const struct panel_desc auo_b101ean01 = {
>         },
>  };
>
> +static const struct drm_display_mode auo_b116xa3_mode = {
> +       .clock = 70589,
> +       .hdisplay = 1366,
> +       .hsync_start = 1366 + 40,
> +       .hsync_end = 1366 + 40 + 40,
> +       .htotal = 1366 + 40 + 40 + 32,
> +       .vdisplay = 768,
> +       .vsync_start = 768 + 10,
> +       .vsync_end = 768 + 10 + 12,
> +       .vtotal = 768 + 10 + 12 + 6,
> +       .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
>  static const struct drm_display_mode auo_b116xak01_mode = {
>         .clock = 69300,
>         .hdisplay = 1366,
> @@ -1926,11 +1945,13 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
>         .delay = _delay \
>  }
>
> -#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _mode) \
> +#define EDP_PANEL_ENTRY2(vend_chr_0, vend_chr_1, vend_chr_2, product_id, \
> +                        _hash, _delay, _name, _mode) \
>  { \
>         .name = _name, \
>         .panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
>                                              product_id), \
> +       .panel_hash = _hash, \
>         .delay = _delay, \
>         .override_edid_mode = _mode \
>  }
> @@ -2077,13 +2098,32 @@ static const struct edp_panel_entry edp_panels[] = {
>         { /* sentinal */ }
>  };
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> +/*
> + * Similar to edp_panels, this table lists panel variants that require using
> + * overridden modes but have the same panel id as one of the entries in edp_panels.
> + *
> + * Sort first by vendor, then by product ID.
> + */
> +static const struct edp_panel_entry edp_panels_variants[] = {

I'd suggest keeping these entries in the main table. Otherwise it
becomes harder to note, which setting gets used.

> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, 0xa9951478, &auo_b116xak01.delay,
> +                        "B116XAK01.0", &auo_b116xa3_mode),
> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, 0x109b75b3, &delay_200_500_e50,
> +                        "B116XAN06.1", &auo_b116xa3_mode),
> +
> +       { /* sentinal */ }
> +};
> +
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, u32 panel_hash)
>  {
>         const struct edp_panel_entry *panel;
>
> -       if (!panel_id)
> +       if (!panel_id || !panel_hash)
>                 return NULL;
>
> +       for (panel = edp_panels_variants; panel->panel_id; panel++)
> +               if (panel->panel_id == panel_id && panel->panel_hash == panel_hash)
> +                       return panel;
> +
>         for (panel = edp_panels; panel->panel_id; panel++)
>                 if (panel->panel_id == panel_id)
>                         return panel;
> --
> 2.44.0.rc0.258.g7320e95886-goog
>


-- 
With best wishes
Dmitry

