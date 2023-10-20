Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984C7D15F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjJTSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjJTSnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:43:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3361A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:43:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so826667a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697827393; x=1698432193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4j0ST73DzoLLM9MbJMnveHu6akxSdB+XraQpl0qwIw=;
        b=YBFrTi47cd/GMNrSslfL/sv7VMNRe1UFc/F9pTGh2JWNUzJsPaoFO4gOvlyEOSbFzX
         lk4bPGj8TfLYCSXIeeFX/UPbCFeavrh+GAqLcPQhFI6EPyyOTNYUz7vdW/mW2YyjtXsi
         vnQFcLbukRk8hab8JdV9qoUfTuP3j/FLpw1TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827393; x=1698432193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4j0ST73DzoLLM9MbJMnveHu6akxSdB+XraQpl0qwIw=;
        b=SEGIQFbeNpI5neKGSNpf+oqWK/W2VsTQtxLI+Fi8sDBIkznewG/mQcbKVxoSIGwG/V
         Hikl2+37Di7DhUWgAuGGmkVYvxQ5SaakXOCk6zWZ654bRBqHGoHoNxLOfpVI9jrW60ms
         5N09MNgoDoLPH1rUo/00wpd1BT/7tdpW7s5+gueOVNK1ZrSxNcSq4MuR225b3h9IP48S
         n0bIo+/yL/Rb46u0WkqCB49WtTEuPiGBDfi+Ra8Hrolbx9hyPlGxRawElgjJKIIYgZe/
         b/RA1otpce6iagNsvERaWYUOwBMB388ZAMFhqYoQ9B4A4LAOotRba3QYOuo+k043maEd
         mjgg==
X-Gm-Message-State: AOJu0Yx2Lvs1dRElI/jZmSAUGMNLjfQvzoxSV79GY+13nucWtUrWXCfT
        eys4S0R+ObmJL2mt94UnhWzo5H7LLphgfbvnTtU=
X-Google-Smtp-Source: AGHT+IHDjFhtgPPzRwhtKHGylJFWVO5Pw8Mo+6OtHDRda++bfVfLvXMK3PeMwDZDvgflUMEx8pyWwA==
X-Received: by 2002:a05:6a20:429f:b0:17a:ee7d:c035 with SMTP id o31-20020a056a20429f00b0017aee7dc035mr2509247pzj.38.1697827392801;
        Fri, 20 Oct 2023 11:43:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79d11000000b006933866f49dsm1917333pfp.19.2023.10.20.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:43:12 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:43:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24190_charger: replace deprecated
 strncpy with strscpy
Message-ID: <202310201140.B6C54194@keescook>
References: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:14:47PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bdi->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> val->strval is assigned to bdi->model_name in
> bq24190_charger_get_property():
> 1186 | val->strval = bdi->model_name;
> 
> ... then in power_supply_sysfs.c we use value.strval with a format string:
> 311  | ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> we assigned value.strval via:
> 285  | ret = power_supply_get_property(psy, psp, &value);
> ... which invokes psy->desc->get_property():
> 1210 | return psy->desc->get_property(psy, psp, val);
> 
> with bq24190_charger_get_property():
> 1320 | static const struct power_supply_desc bq24190_charger_desc = {
> ...
> 1325 | 	.get_property		= bq24190_charger_get_property,
> 
> Moreover, no NUL-padding is required as bdi is zero-allocated in
> bq24190_charger.c:
> 1798 | bdi = devm_kzalloc(dev, sizeof(*bdi), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/power/supply/bq24190_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 3f99cb9590ba..1db290ee2591 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1803,7 +1803,7 @@ static int bq24190_probe(struct i2c_client *client)
>  
>  	bdi->client = client;
>  	bdi->dev = dev;
> -	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
> +	strscpy(bdi->model_name, id->name, sizeof(bdi->model_name));

struct bq24190_dev_info {
	...
        char                            model_name[I2C_NAME_SIZE];

Length replacement looks correct.

struct i2c_device_id {
        char name[I2C_NAME_SIZE];

And it looks like this wasn't accidentally leaving strings unterminated,
so that's nice.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
