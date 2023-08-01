Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0A76AE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjHAJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjHAJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:38:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817143C0E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:36:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-316feb137a7so5619555f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690882597; x=1691487397;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VEE/213uFNcoZA1UJMhRsJszifwBFLP6R8lcV4+AfcI=;
        b=IvAebBA5BsMz0qDa2RB8atqf7DZKO2t1E9gyJ29old699f8bdN4uuIFfJHvPY1Jfml
         eL4Snq/oqIMgWL9v9xbCEd+sxoZ5/aFB1FuduyLuUf1ZOsyXkZ4XjFOoClGRTrrCgD08
         uUTWlblIp5uzXk5pNEBXn9VtfGTuPpttbPRemCJhoh4Z2Mlur8VKiSEjEYxQhZWX0ZFv
         K0YFqzvsYzpT5hUgDQdYNbOM7HwpBhsJaXIE9gKpD1rQpTf+pxQaCx4FaVRxwXyRIc8q
         Y7M5+de1dX+bY7HKviQ52bzdcq8VuB94WHOS4oJoLpobP/1escoglqr5Nlj5V/T8Wtc6
         w5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882597; x=1691487397;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEE/213uFNcoZA1UJMhRsJszifwBFLP6R8lcV4+AfcI=;
        b=Vo71o8H/w9Ui78mA9vDqpAmU5exEcPDEig3v1ZfunUyr0yN/jVQgBoC+fkiOW58X64
         X4tROav9Gh3zlWbrXyu5RwCbvMj2rMMCy7xLj4ddylX+Siv0sAcPNs5tSSC74LtOfbYS
         29W/6neg59zad7uJCUG+LTFb4UJBRYYmHuHRHiWddfmQD/Tsujf1DnA5ZP8rjwYRtj+5
         y6b8TZmnkeL/lBuzL5NhclXxZOjICE9hAtktNzpvd9jTD8EYo7XQuR0opjbtf/hQvTxp
         C8GuIIk9VGw43mqNE9PBU6vGdneupsrXeivqqbZGx3gAevC91cQK9hzLJjjyIUbDOIM4
         R00A==
X-Gm-Message-State: ABy/qLbLpYnMCTtjwNWktvPEYFdCqBqjfEdft6fyy+6QTSs8B1wtn7aN
        Oxhmy68wAMyuH7Am8ZMPUk1OtQ==
X-Google-Smtp-Source: APBJJlG/sqL4ZeXt7Eea5GDq/NoyXEJeYC7sfIU+ah8BQNHKJgRbhFfds389nYSSA/ksyDYHZKNlsw==
X-Received: by 2002:a5d:5051:0:b0:317:7362:3fe8 with SMTP id h17-20020a5d5051000000b0031773623fe8mr1995149wrt.9.1690882597725;
        Tue, 01 Aug 2023 02:36:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b92a:81a9:df6e:1e3? ([2a01:e0a:982:cbb0:b92a:81a9:df6e:1e3])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000050100b003141f96ed36sm15668644wrf.0.2023.08.01.02.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:36:37 -0700 (PDT)
Message-ID: <d27c41a1-d50f-c346-d559-ab367383fc51@linaro.org>
Date:   Tue, 1 Aug 2023 11:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Add cec suspend/resume functions
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, andrzej.hajda@intel.com,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230721124415.1513223-1-Sandor.yu@nxp.com>
Organization: Linaro Developer Services
In-Reply-To: <20230721124415.1513223-1-Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 14:44, Sandor Yu wrote:
> CEC interrupt status/mask and logical address registers
> will be reset when device enter suspend.
> It will cause cec fail to work after device resume.
> Add CEC suspend/resume functions, reinitialize logical address registers
> and restore interrupt status/mask registers after resume.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 37 +++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> index 9389ce526eb13..be21c11de1f2a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -62,6 +62,10 @@ struct dw_hdmi_cec {
>   	bool rx_done;
>   	struct cec_notifier *notify;
>   	int irq;
> +
> +	u8 regs_polarity;
> +	u8 regs_mask;
> +	u8 regs_mute_stat0;
>   };
>   
>   static void dw_hdmi_write(struct dw_hdmi_cec *cec, u8 val, int offset)
> @@ -304,11 +308,44 @@ static void dw_hdmi_cec_remove(struct platform_device *pdev)
>   	cec_unregister_adapter(cec->adap);
>   }
>   
> +static int __maybe_unused dw_hdmi_cec_resume(struct device *dev)
> +{
> +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> +
> +	/* Restore logical address */
> +	dw_hdmi_write(cec, cec->addresses & 255, HDMI_CEC_ADDR_L);
> +	dw_hdmi_write(cec, cec->addresses >> 8, HDMI_CEC_ADDR_H);
> +
> +	/* Restore interrupt status/mask registers */
> +	dw_hdmi_write(cec, cec->regs_polarity, HDMI_CEC_POLARITY);
> +	dw_hdmi_write(cec, cec->regs_mask, HDMI_CEC_MASK);
> +	dw_hdmi_write(cec, cec->regs_mute_stat0, HDMI_IH_MUTE_CEC_STAT0);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dw_hdmi_cec_suspend(struct device *dev)
> +{
> +	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
> +
> +	/* store interrupt status/mask registers */
> +	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
> +	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
> +	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dw_hdmi_cec_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_cec_suspend, dw_hdmi_cec_resume)
> +};
> +
>   static struct platform_driver dw_hdmi_cec_driver = {
>   	.probe	= dw_hdmi_cec_probe,
>   	.remove_new = dw_hdmi_cec_remove,
>   	.driver = {
>   		.name = "dw-hdmi-cec",
> +		.pm = &dw_hdmi_cec_pm,
>   	},
>   };
>   module_platform_driver(dw_hdmi_cec_driver);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
