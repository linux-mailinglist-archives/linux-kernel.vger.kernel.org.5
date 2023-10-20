Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010187D1612
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjJTTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:06:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BED4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:06:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so799117a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697828786; x=1698433586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URtsuBkq1PlfP6enjE5/unNQzMTKd3kE7D83R3MqH4Q=;
        b=TeBWtUDrZLa4tHwIIZWcQ40qkXDWrr6Gog33AaiZx/47BkAZqATPeQBQDWt2XJM/8c
         yxK/QKldpIAVz+MmNMXNalMiFG+XjiyKL+gRgxDbhJDjyCvU85TYcMTazX2GWXNNUfAn
         Fcl8Cm6TGP0E/Xmi9SNbBweAbykv6JLsuDN4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828786; x=1698433586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URtsuBkq1PlfP6enjE5/unNQzMTKd3kE7D83R3MqH4Q=;
        b=BqLNAOm8mUGowmUieTRuJFHNDZsFkx1nyYpbLN3WhetWWGkoRcazTlrnl1CZZdLKqz
         KmGqskezdYgCM0O+mMB+zfQTzjKtO1/oU7skUmnoJ3LzDyYsXjY8v/pzokZpoiLtDtGA
         BLEM8CjZ9FskKx1mLRFQ6Wg/Ux7asjPeQFsWP+Upb9kkmIReXxGpCRFluISBqSV64feS
         haqZfPGppK7IpdY/q2xreSIZ0a+e8CQ48sCG/RtPT3iif8e8pllm+C3H2JB/oBIKazMH
         OfmQFQdzENaQgSoqL/0uf5ZBMxssaYQq2MawRJHQ/rhE7dB8ys7MYo99+qfq6y/nkQDN
         68RA==
X-Gm-Message-State: AOJu0YxnQW3xUUTruvnfbFMQNyOkllQxyu+vvp5fO2d10WZsuiqUy28z
        HMfFaAUzgnC+fO/02Jo8BsYpWw==
X-Google-Smtp-Source: AGHT+IGZAx49Ov+0Y8NtP7+Nd4TtP5zk4M6HLrhjbp3+NqOYbrLuGFkh7nPl2xFTM0kJArIeJmcRgQ==
X-Received: by 2002:a17:90b:3504:b0:27d:60b1:4f2c with SMTP id ls4-20020a17090b350400b0027d60b14f2cmr2592965pjb.4.1697828785944;
        Fri, 20 Oct 2023 12:06:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a1a4800b002776288537fsm1953870pjl.53.2023.10.20.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:06:25 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:06:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2515x: replace deprecated strncpy with
 strscpy
Message-ID: <202310201206.2D1271C209@keescook>
References: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:59:34PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq2515x->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> val->strval is assigned to bq2515x->model_name in
> bq2515x_mains_get_property():
> |       val->strval = bq2515x->model_name;
> 
> ... then in power_supply_sysfs.c we use value.strval with a format string:
> |       ret = sysfs_emit(buf, "%s\n", value.strval);
> 
> we assigned value.strval via:
> |       ret = power_supply_get_property(psy, psp, &value);
> ... which invokes psy->desc->get_property():
> |       return psy->desc->get_property(psy, psp, val);
> 
> with bq2515x_mains_get_property():
> |       static const struct power_supply_desc bq2515x_mains_desc = {
> ...
> |       	.get_property		= bq2515x_mains_get_property,
> 
> Moreover, no NUL-padding is required as bq2515x is zero-allocated in
> bq2515x_charger.c:
> |       bq2515x = devm_kzalloc(dev, sizeof(*bq2515x), GFP_KERNEL);
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
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks like a good replacement, just like the prior I2C change.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
