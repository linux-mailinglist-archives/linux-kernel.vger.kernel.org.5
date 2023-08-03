Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915E76E2CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjHCISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjHCIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:17:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433444B9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:12:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso7004365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691050350; x=1691655150;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Und5YZ86VldXU2R2EeUENrtdoW05YhCbc25DsdIRgY=;
        b=e10Hdd/1RX4n3g1L0Ssf8Bcgo1AdrbDlJ0yS4kr5wa/EUQT26mx/b3aEBK5jeeiji9
         CJrIq9qkvUvY5kRK2bWJ/6cFj0Wy9doMDcMp14ba0qW11+sLOKcTGb3YgskArmeJy8dX
         MKafxbCgFiOCvk4yW1Tkr04dgB8WL/Y9+OmDKY5Q15ZsJlH4FVVWK5MEmI1lQTUt3I3N
         quQMHCkvJdbSC4S4Tfe0XKqaB8NPq0c2C3fWGcVvWN2TMXIN0vQSGqcWr/12v+AkAl4h
         Va5cqXgv5f+z+d2gOcmc93hckl9m6pceZJNDl5oP+vr85yQcw0fV+ieVWe8Nvvf/6qz4
         PXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691050350; x=1691655150;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Und5YZ86VldXU2R2EeUENrtdoW05YhCbc25DsdIRgY=;
        b=cmk9x+7btnz6OfRBuu/8CKfeSbn//YThF/j0MuSvB3RWDdsYNREPGl3XqLa0kQcNmR
         FZfi2klv+NxNJfa82MHMBk9zVnkBmN1gPL7mY5r5dynQM6OsRGSjqXZlQPBxhDKJB+7l
         QsCle64CgrgGugFNelw9FO5voeRtA000wpzz/HRjhW01QB8qJ+lzGwWUHU1L4kG1j9lC
         BopIwQ1vjcAnOvCTHRCbs5brH2B5LJtcJaAk4dAgk39FTg+s3/rI9yyhUBXZALOHgi48
         tPp67I26qkPOAJchicxcvxP/R6SaBO7BfG9r3TpDGbTaKPc0hmWZ7CMS2fdRm2L1TFRQ
         XcXg==
X-Gm-Message-State: ABy/qLbzE5+YCkCzzVrQquP5s2EghCi0bEWUu4uhg7iA9sdadvlh8Yg9
        Ly/8I/KzF+ggqnONvpTlfEgpWA==
X-Google-Smtp-Source: APBJJlG/YOO+u6HT6L5SMevwes6eeDd3CFOIIeZioqBlEygdRg1hzggi+IFVem11pMYzMCZjVloYQA==
X-Received: by 2002:a7b:c40a:0:b0:3fe:2102:8085 with SMTP id k10-20020a7bc40a000000b003fe21028085mr6664138wmi.8.1691050350175;
        Thu, 03 Aug 2023 01:12:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00317495f88fasm20989785wrp.112.2023.08.03.01.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 01:12:29 -0700 (PDT)
Message-ID: <2c671efa-4550-3749-395d-621dd3153279@linaro.org>
Date:   Thu, 3 Aug 2023 10:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/panel: Fix kernel-doc typo for `follower_lock`
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230802074727.1.I4036706ad5e7f45e80d41b777164258e52079cd8@changeid>
Organization: Linaro Developer Services
In-Reply-To: <20230802074727.1.I4036706ad5e7f45e80d41b777164258e52079cd8@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 16:47, Douglas Anderson wrote:
> In the kernel doc for the `follower_lock` member of `struct drm_panel`
> there was a typo where it was called `followers_lock`. This resulted
> in a warning when making "htmldocs":
> 
>    ./include/drm/drm_panel.h:270: warning:
>    Function parameter or member 'follower_lock' not described in 'drm_panel'
> 
> Fix the typo.
> 
> Fixes: de0874165b83 ("drm/panel: Add a way for other devices to follow panel state")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20230802142136.0f67b762@canb.auug.org.au
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   include/drm/drm_panel.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index d6c73f79c131..10015891b056 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -238,7 +238,7 @@ struct drm_panel {
>   	struct list_head followers;
>   
>   	/**
> -	 * @followers_lock:
> +	 * @follower_lock:
>   	 *
>   	 * Lock for followers list.
>   	 */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
