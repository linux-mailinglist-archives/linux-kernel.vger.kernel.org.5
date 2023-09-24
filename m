Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACC7AC66A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIXDEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:04:47 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7F124
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:04:41 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b64731334so2194055eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524680; x=1696129480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sQ7m4xt0fK6eu4MW7lFXq5f5EhNnp1BBnPa+JfP91w=;
        b=Iu1Dkt85dqEYsbP3Bv+7mtNRP+/1lI+PBrMKtfjmUOwWfuacR0f2JZuyhWv6PY+cbD
         7xyG7YLAY95X0efx/m2bKMfl+k5pTGfmtbU+slNhguQkb0eYY/wZ/4uWG9fRYxem3od0
         4n7ZGvFuIxuJow+/eQPEJgrO2S4OMgjlb6Nto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524680; x=1696129480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sQ7m4xt0fK6eu4MW7lFXq5f5EhNnp1BBnPa+JfP91w=;
        b=hPD19HcR9PBM1Bi8bfm8MLzLEmaBfWDNYlgIwXZSjgojs9dLKDs5GBNoAJKKapXhAD
         cKHeCLBepc5kaJIFJivigvSFBG27OENUcFmGkf4lpD9dzo08EzBMDEOEnPGav3aNmh/m
         /oNlj5iMjwwn6Q8NvANQDBYUgatCrIpp4r585QowvyTEvqTtevvuk/DU7up8zr4cvenS
         3vqtjkklN8o9ANbnxMXfpJi3HTg0Xn01cc6wmCNfeI5Aiqoq05ODdFsqliyUoYYu1Az4
         VOhbyov38nkvDo7N9xwbnxqvW1Lhq+YSuQFvxTLLz1nqBEYjl56HqGYaIBizzpMYutwB
         lbsQ==
X-Gm-Message-State: AOJu0YyTRvtpgIS5jj+/aX6tuAhWns105nexQE/F9utedWaTManHcF1+
        3MlbTmePxg5/mOvDBxThK1J1+g==
X-Google-Smtp-Source: AGHT+IEyctQpGdRHVqfskRrctSvr+c0AutzD5V01OHg/wphX4795l8UXDPxsR/JiCrGwUFsS6seQ2g==
X-Received: by 2002:a05:6358:991e:b0:141:d2d:6da7 with SMTP id w30-20020a056358991e00b001410d2d6da7mr4584544rwa.17.1695524680210;
        Sat, 23 Sep 2023 20:04:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b0027480345180sm7265781pjb.2.2023.09.23.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:04:39 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:04:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: replace deprecated strncpy
Message-ID: <202309232003.05306BB415@keescook>
References: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:51:04AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> We expect adap->name to be NUL-terminated based on i2c_adapter name use:
> | dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> 
> NUL-padding does not seem to be required as `master` is zero-allocated
> and `i3c_master_to_i2c_adapter` simply returns a field from within
> `master`:
> |       master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> ...
> |      	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
> ...
> |       static struct i2c_adapter *
> |       i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
> |       {
> |       	return &master->i2c;
> |       }
> 
> This means that `adap->name` should already be filled with NUL-bytes.
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

Looks right to me; straight replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
