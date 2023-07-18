Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA5757379
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGRFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:55:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A34E9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:55:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8439699e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689659731; x=1690264531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsbhJmZRrUVfIREF/YaoFO31V/VuA36PYOF5vrsxTrY=;
        b=TvrjMYga2+Hgvom8TQQo8p7mOuPyE1lsM6aLnnwAunLKKI5uDVEpghkBORAr0HzOH/
         xIc1C3s6mgPRsJpem750XgLU/IMijtUI+QctrT66UalwLHcpZzg4I1Bp8r7T2F7zg09Q
         Kif7QO5PnGk6IBVkHTco/sJ//wBcq/eOJg69AzFX3mQ+NPj96mphWjHhb7NERZ2cmoI0
         Yhf2DcxtgNCf8ooikgeLgqIlQtxpT1zc0mcUpO57Zp6XNyZ23QSehn/DmudccnNrHFXZ
         fptm6ujDMnYcN2U0oGugmXDNNnpD5sM9euETJ50oVEMPynuQUoE6EMNhmNG7mLB2W/7t
         2iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689659731; x=1690264531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsbhJmZRrUVfIREF/YaoFO31V/VuA36PYOF5vrsxTrY=;
        b=mBETTSFD6PcBvzrev0kxSNdhUgN862HjU6bGVmtfjlCbsXOGZFkg2XUh+iGMg/j13B
         k5yyUdAYL5QEC06wZeGpxZr8YzLhqYiwNuxuG3SoVvKQd0Isk6T3MqD5tD27IGxSbowE
         T0UpNI7mEOLZqyjv8MjQSLy+p4/cASrDnDXNmbP7de45hHKj5QILnKmZHX8R3DHZmRv1
         VKS2Li1B5i1D/qLeV3n2izC6sOnE1l4HQmKXkyz8f01KeWtti6y4kbJfFLS2zWBuZwLa
         I8H3aCrILXM+9PVHw4d71CMYBtrqCZ5CUaIu22dkL0YFQ1YlGWo5ePvahtSblXXeJKKH
         cAqg==
X-Gm-Message-State: ABy/qLb+DZLs/DBXLToHn03R3ozPv+fS4diM0ZCdvK2kyG1Fw7/+fjew
        SSr8H10bZiGztKFq8crbBI6dOA==
X-Google-Smtp-Source: APBJJlEKnXriHXhpepYUAwnNUDFbo9hDSR/GW0DhqttHRWYsNVESqVdXLfJaY6cJ5psPQjsT07aaVw==
X-Received: by 2002:ac2:5f09:0:b0:4fb:c740:326 with SMTP id 9-20020ac25f09000000b004fbc7400326mr8149939lfq.55.1689659731275;
        Mon, 17 Jul 2023 22:55:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d14-20020ac25ece000000b004fdc0023a50sm264342lfq.232.2023.07.17.22.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 22:55:30 -0700 (PDT)
Message-ID: <69f56e09-2baa-be6f-3021-2c5afd5867c9@linaro.org>
Date:   Tue, 18 Jul 2023 08:55:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm: remove drm_bridge_hpd_disable() from
 drm_bridge_connector_destroy()
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     freedreno@lists.freedesktop.org, robdclark@gmail.com,
        quic_jesszhan@quicinc.com, laurent.pinchart@ideasonboard.com,
        andersson@kernel.org, linux-kernel@vger.kernel.org
References: <20230717223451.16783-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230717223451.16783-1-quic_abhinavk@quicinc.com>
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

On 18/07/2023 01:34, Abhinav Kumar wrote:
> drm_bridge_hpd_enable()/drm_bridge_hpd_disable() callbacks call into
> the respective driver's hpd_enable()/hpd_disable() ops. These ops control
> the HPD enable/disable logic which in some cases like MSM can be a
> dedicate hardware block to control the HPD.
> 
> During probe_defer cases, a connector can be initialized and then later
> destroyed till the probe is retried. During connector destroy in these
> cases, the hpd_disable() callback gets called without a corresponding
> hpd_enable() leading to an unbalanced state potentially causing even
> a crash.
> 
> This can be avoided by the respective drivers maintaining their own
> state logic to ensure that a hpd_disable() without a corresponding
> hpd_enable() just returns without doing anything.
> 
> However, to have a generic fix it would be better to avoid the
> hpd_disable() callback from the connector destroy path and let
> the hpd_enable() / hpd_disable() balance be maintained by the
> corresponding drm_bridge_connector_enable_hpd() /
> drm_bridge_connector_disable_hpd() APIs.

Which should get called by the drm_kms_helper_disable_hpd().

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/drm_bridge_connector.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> index 19ae4a177ac3..3d4e25c2f3d7 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -187,12 +187,6 @@ static void drm_bridge_connector_destroy(struct drm_connector *connector)
>   	struct drm_bridge_connector *bridge_connector =
>   		to_drm_bridge_connector(connector);
>   
> -	if (bridge_connector->bridge_hpd) {
> -		struct drm_bridge *hpd = bridge_connector->bridge_hpd;
> -
> -		drm_bridge_hpd_disable(hpd);
> -	}
> -
>   	drm_connector_unregister(connector);
>   	drm_connector_cleanup(connector);
>   

-- 
With best wishes
Dmitry

