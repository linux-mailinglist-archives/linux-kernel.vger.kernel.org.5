Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB67D1616
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjJTTGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjJTTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:06:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B5D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:06:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d113508bfso982928a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697828808; x=1698433608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUVJcwpArHb7MBkbp3dkAUppiUopD2zQbbvJscJg8PQ=;
        b=jMbyAUTA7kRk7I7iE4WthE7sPQnCMtegi4Ex+tV4XpldKSd1uiEtUFKG/LHovcDxSK
         N+7OMXt4Z3m0P96IHnbr/HDkT5VncS7t3T8oHXW6sc2+ls4WgUjy8uRapMwr+j+FZZ1y
         ItnU9PJR53IA/aizssNDf5tAuA53H4MIPpykw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828808; x=1698433608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUVJcwpArHb7MBkbp3dkAUppiUopD2zQbbvJscJg8PQ=;
        b=Pb38dKpHZmgamPnJCWCr+ZXbbdF2g3RpDJp6tAygUlTIUNJhgx66NgF7rpCK05oP9Z
         bkaoVxQOsLphoyjEyaItv7GtdRh45HIX/hipTq5+EjA9LlbIHDk669ijHkWKNdmLotOb
         FEdnmr7KK/oLNFRBRPA27C9NC23coVHl5/cnQRK3yOZdwM/3865OPMbOmrjNMJ89i461
         ftH8RcTnlK5VpqN03mWpdwSKo+oO/jYjf3M0kGGeOjSNsUY6jBpvufG/U6L8z44YJz/L
         /MXwzgWV0FkTziM6jIyutTg74SOxKtopmU/KpldoiLqaEVLVEpBJ8atxE2WsYlvdHqxg
         hohg==
X-Gm-Message-State: AOJu0Yz2idvJDJwky7UgkBIA3ofHMe/WOZ5T2ClQGZiCd89LVZOSzL0L
        xyDMD4O2FDFYQmHpj+BTpVyXyw==
X-Google-Smtp-Source: AGHT+IEgFtHiGyOoViYf0N8c2I/S8dvVLOWnmh9wYvf5dD2u2G6gwpgPYyPbb6rknXVZIZeLc/dx/Q==
X-Received: by 2002:a17:90b:2ec4:b0:27d:a59:ebae with SMTP id ss4-20020a17090b2ec400b0027d0a59ebaemr2899423pjb.46.1697828807938;
        Fri, 20 Oct 2023 12:06:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090ad31400b0027d15bd9fa2sm3536022pju.35.2023.10.20.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:06:47 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:06:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq256xx: replace deprecated strncpy with
 strscpy
Message-ID: <202310201206.428C617@keescook>
References: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 07:05:25PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> val->strval is assigned to bq->model_name in
> bq256xx_get_charger_property():
> |       val->strval = bq->model_name;
> 
> ... then in power_supply_sysfs.c we use value.strval with a format string:
> |       ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> we assigned value.strval via:
> |       ret = power_supply_get_property(psy, psp, &value);
> ... which invokes psy->desc->get_property():
> |       return psy->desc->get_property(psy, psp, val);
> 
> with bq256xx_get_charger_property():
> |       static const struct power_supply_desc bq256xx_power_supply_desc = {
> ...
> |       	.get_property = bq256xx_get_charger_property,
> 
> Moreover, no NUL-padding is required as bq is zero-allocated in
> bq256xx_charger.c:
> |       bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
> sizeof(dest)) as this more closely ties the destination buffer and the
> length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
> Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com/
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
