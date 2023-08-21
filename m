Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE2782E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjHUQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjHUQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:36:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D99FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:36:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31771bb4869so3255919f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692635794; x=1693240594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLeAswC8FPpnMLWgDTF18xaCa/KlTJOAu90A2tSHG+E=;
        b=ZMWD+ZPMbu1gWKaNmbRIhaJl6M0UdWARNKG+CVFRFmgdncqHY+nC82h8+Z55xxwz2g
         H4UsCTHk8poZdmNASIEX0eU9XMxgI/NRqCUKqrBG2vVDLwiNsgf7gUgEWSwFrNqO6Sc4
         SwklnAofSB96Y+ZzPmfD8ORqEN/I+Ep8ju9AqMYXJm78IGQEM9fPyCbD+4mAVdhZUlAV
         CcmKjMqJmLtieYZssdfVTjMOqPPWEVy5S0DFCmngIzcQrhUVG1mgUrYasUJoKMEhvuEl
         UoRQDmK0KDDBFlXHw1Pg/V4LleTBGM3NCg9G5IEfXI80uozNpfmuhAdlHauV7n45GWm9
         PRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635794; x=1693240594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLeAswC8FPpnMLWgDTF18xaCa/KlTJOAu90A2tSHG+E=;
        b=Wlo5sy6swzVJaCBzD6+J/SYF9RL+ckYkJ25T1ZjwN82arR1p8JE41e3UeKxEORNe1b
         tnJjPwwJRh6zy08EOUCktzz3+v5/bcXJSlIK0EEXd7HRa5yoyidCeJusgOPV/gLKdVbe
         DlfJS2s53c7d/4aWbmjRqr0XICeG2bt+jlpW9CviZ3qEULWDN7BNdQUIXyO5JPx/CsRV
         Q+WwhfRsI1xFoDLKwJEZiFWXuW6XMIYAxluxbCXSVaBXJH7fR8dM+JFHyzBcyfXBFwd/
         7u2CBSCq+SIz5ZeCdpua+NDJit9wzVNUBDTigbWThBvDQ/MWkBcvqr5hlHiu++rkN04D
         86UA==
X-Gm-Message-State: AOJu0YxUix8GXDLSP5pEiYSVvrLWYHypURvoD8a7q6QDlIMS1hUPRu5A
        Tql6V0eIXBHd6AUc6kNCHQhyhw==
X-Google-Smtp-Source: AGHT+IFhBb30ZJ4bzxScpzo0htWeygmB0PYxIMb7ZiGf78WIe5bZNnpUTDLFUVFVi2lm3yyfveQCqA==
X-Received: by 2002:adf:d085:0:b0:317:759a:8ca6 with SMTP id y5-20020adfd085000000b00317759a8ca6mr4734991wrh.62.1692635793634;
        Mon, 21 Aug 2023 09:36:33 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe7c1000000b0031b2c01f342sm7114191wrn.87.2023.08.21.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:36:33 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:36:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julius Zint <julius@zint.sh>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/1] backlight: hid_bl: Add VESA VCP HID backlight
 driver
Message-ID: <20230821163631.GA214013@aspen.lan>
References: <20230820094118.20521-1-julius@zint.sh>
 <20230820094118.20521-2-julius@zint.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820094118.20521-2-julius@zint.sh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 11:41:18AM +0200, Julius Zint wrote:
> The HID spec defines the following Usage IDs (p. 345 ff):
>
> - Monitor Page (0x80) -> Monitor Control (0x01)
> - VESA Virtual Controls Page (0x82) -> Brightness (0x10)
>
> Apple made use of them in their Apple Studio Display and most likely on
> other external displays (LG UltraFine 5k, Pro Display XDR).
>
> The driver will work for any HID device with a report, where the
> application matches the Monitor Control Usage ID and:
>
> 1. An Input field in this report with the Brightness Usage ID (to get
>    the current brightness)
> 2. A Feature field in this report with the Brightness Usage ID (to
>    set the current brightness)
>
> This driver has been developed and tested with the Apple Studio Display.
> Here is a small excerpt from the decoded HID descriptor showing the
> feature field for setting the brightness:
>
>   Usage Page (Monitor VESA VCP),  ; Monitor VESA VPC (82h, monitor page)
>   Usage (10h, Brightness),
>   Logical Minimum (400),
>   Logical Maximum (60000),
>   Unit (Centimeter^-2 * Candela),
>   Unit Exponent (14),
>   Report Size (32),
>   Report Count (1),
>   Feature (Variable, Null State),
>
> The full HID descriptor dump is available as a comment in the source
> code.
>
> Signed-off-by: Julius Zint <julius@zint.sh>

I saw Christophe's review (thanks) and won't repeat anything from
there...

> @@ -472,6 +472,14 @@ config BACKLIGHT_LED
>  	  If you have a LCD backlight adjustable by LED class driver, say Y
>  	  to enable this driver.
>
> +config BACKLIGHT_HID
> +	tristate "VESA VCP HID Backlight Driver"
> +	depends on HID
> +	help
> +	  If you have an external display with VESA compliant HID brightness
> +	  controls then say Y to enable this backlight driver. Currently the
> +	  only supported device is the Apple Studio Display.

This contradicts the description which says you write the driver to the
standard but only tested on Apple Studio Display. There is no need to
spell what has been tested in the Kconfig text. Remove the final
sentence!

> diff --git a/drivers/video/backlight/hid_bl.c b/drivers/video/backlight/hid_bl.c
> new file mode 100644
> index 000000000000..b40f8f412ee2
> --- /dev/null
> +++ b/drivers/video/backlight/hid_bl.c
> <snip>
> +static void hid_bl_remove(struct hid_device *hdev)
> +{
> +	struct backlight_device *bl;
> +	struct hid_bl_data *data;
> +
> +	hid_dbg(hdev, "remove\n");

This message probably should be removed (if you want to know if a function was
executed use ftrace).


> +	bl = hid_get_drvdata(hdev);
> +	data = bl_get_data(bl);
> +
> +	devm_backlight_device_unregister(&hdev->dev, bl);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +	hid_set_drvdata(hdev, NULL);
> +	devm_kfree(&hdev->dev, data);
> +}
> +
> +static int hid_bl_get_brightness_raw(struct hid_bl_data *data)
> +{
> +	struct hid_field *field;
> +	int result;
> +
> +	field = data->input_field;
> +	hid_hw_request(data->hdev, field->report, HID_REQ_GET_REPORT);
> +	hid_hw_wait(data->hdev);
> +	result = *field->new_value;
> +	hid_dbg(data->hdev, "get brightness: %d\n", result);

To be honest I'm a little dubious about *all* the hid_dbg() calls. They
add very little value (e.g. they are useful to get the driver working
but not that important to keeping it working). As such I don't think
they are worth the clutter in a CONFIG_DYNAMIC_DEBUG kernel.

Note this is strictly for the hid_dbg() stuff... the hid_err() stuff in
the probe error paths are much more useful!


Daniel.
