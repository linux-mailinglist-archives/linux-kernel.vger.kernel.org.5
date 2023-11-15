Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E27EBB63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKODDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKODDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:03:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9EDA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:03:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso4839343b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700017420; x=1700622220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2NJqY9YsGejP0tvY4g7KbbK4VWtM2B+ypFWWtUvLTI=;
        b=HtFwonew5CH0YCRi9Iq3JtlA2XZgjZT9G76q45CnKI8IQsuN1XHOBjq8HTOOBcWNaa
         Sd5umjK9xOE9VKvI6AZH4E0LP5Jtya7SmaIfcKoQancwTPoCX6mHYtLc168XNObpQOOn
         e7LUS76sdiSODj44hijj+cRWs0PoqXhFIIjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700017420; x=1700622220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2NJqY9YsGejP0tvY4g7KbbK4VWtM2B+ypFWWtUvLTI=;
        b=oDQ4DFOLOJqlPhBqnFa4xG0rQBE3VEudpN6Z4ZgRrLiI6OYsvboFiOJZB0rjCR3Gx7
         /JBhyJ5mbMgTsc0ckQs9pHHhoPFisjtDLWLpSsU4gb2RNRxgXlO6AJNtDfdNfE3TgapT
         21vYrvK6kKlfkTLIKQM112qp1IXWMZaBusPVju+NV7VO+gmM6r/vluUhdCuVYLNU2bK/
         6CU4idQRKASTrNRYVy152xV/KWMlAcrM8Cwrd4GsEghsCvXfGrArZJa/sSM85z78Lac8
         4jU2+bZLigQRthahmv624xI5YyLDIKqHxbOECspbTdiR26znckNWB660tK6KbtofcadI
         U1Sw==
X-Gm-Message-State: AOJu0Yy6d0mkS/0qnwN4zstjVdRTSxt+vM/b2RP5KC4LqDnNvPkyDV9x
        YQQcr1qIUiIU1ufPxtnT8mXiaw==
X-Google-Smtp-Source: AGHT+IH2CmT0U/FV4WE9B/tMn8JLmXuKHQNxah2EdL59VFMPy803dw0H/rvMltvHqKIyGPgpgSRxYg==
X-Received: by 2002:a05:6a00:e0d:b0:68a:54e5:24e6 with SMTP id bq13-20020a056a000e0d00b0068a54e524e6mr12166196pfb.8.1700017419680;
        Tue, 14 Nov 2023 19:03:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y22-20020a056a00039600b00692754580f0sm1888588pfs.187.2023.11.14.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:03:39 -0800 (PST)
Date:   Tue, 14 Nov 2023 19:03:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix
 -Wstringop-overflow warning in aspeed_create_fan_tach_channel()
Message-ID: <202311141902.A5AE1300@keescook>
References: <ZVPQJIP26dIzRAr6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVPQJIP26dIzRAr6@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:53:08PM -0600, Gustavo A. R. Silva wrote:
> Based on the documentation below, the maximum number of Fan tach
> channels is 16:
> 
> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>  45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>  46                 integer value in the range 0 through 15, with 0 indicating
>  47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>  48                 At least one Fan tach input channel is required.
> 
> However, the compiler doesn't know that, and legitimaly warns about a potential
> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
> in case `index` takes a value outside the boundaries of the array:
> 
> drivers/hwmon/aspeed-pwm-tacho.c:
> 179 struct aspeed_pwm_tacho_data {
> ...
> 184         bool fan_tach_present[16];
> ...
> 193         u8 fan_tach_ch_source[16];
> 196 };
> 
> In function ‘aspeed_create_fan_tach_channel’,
>     inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>     inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>   751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
>   193 |         u8 fan_tach_ch_source[16];
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Fix this by sanity checking `index` before using it to index arrays of
> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, pass `dev` as
> argument to function `aspeed_create_fan_tach_channel()`, and add an error
> message in case `index` is out-of-bounds, in which case return `-EINVAL`.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the v2! This looks good; it's able to pass back the error
now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
