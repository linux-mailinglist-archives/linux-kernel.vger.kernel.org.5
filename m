Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEC76FBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHDIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHDIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:21:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91FFC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:21:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba2318546so15896255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691137268; x=1691742068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSQz11o3ul0yNyVq0pFtGQung0CwKOFZmwNl8PJxv+Q=;
        b=oBVOMrt4+1w1zDz9OfBIdQ+ZbW3KAVLf/anefxKNO2eHmC4q38EUevTtWu2e22kSrF
         VZHd6G8nwCuKTK0yXoCVWhIylifzK96pEGW2UDfzliIQe1Bv3oj41TkXX+MWRUizb1m3
         YwJF8o9P6g0JOvBWpytfxl/9hsl1K47r3/JOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137268; x=1691742068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSQz11o3ul0yNyVq0pFtGQung0CwKOFZmwNl8PJxv+Q=;
        b=epxwj3ZrnC+dqTvxGnUf/01R2/oP2vhtyhzBLCiNYAABrJ7iNZElesbZ1cjl6rnL3Z
         Gb0aPHccfN5xIBzipomWLgd2Blsa6uX+heTP8ybHpqqJq5cKT1VM2qBYsJFJrGwEAC8f
         YWf+CJl7j5D3B7LIJmTX/JtiVEBCc87Fg/E+Qhp/fbqdXzeLvUugPWNz8E7Nhtsy+UM4
         xgK+rGSqAPuRmEoCNTkRaTJCOFXKQV97JnZNdQjkNrg3si67Fj3QLk4CJieWdDYJN3dZ
         E+WjROSZ6llhhIPgkpqREEoG2BPhwMRwNfKaFfzxNEa3iA0lzsljKtdfjo/7ieGF7JAG
         STJg==
X-Gm-Message-State: AOJu0YwW4wBIf9IVz1UMreUmX8CqnfjWBQ61qgIea3nI578KpKt1/6qX
        W/OYInDPXNO3zqr7DIIT1rd5Kw==
X-Google-Smtp-Source: AGHT+IGJZB0215YHu30q3ARos/W+RSG09nTjMIKs8Qq2qlMv9bvhWlg0eKZX7tJXcm8qtw+8Dm1UVQ==
X-Received: by 2002:a17:902:f809:b0:1b8:76fc:5bf6 with SMTP id ix9-20020a170902f80900b001b876fc5bf6mr978656plb.43.1691137268446;
        Fri, 04 Aug 2023 01:21:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001b8622c1ad2sm1138143plr.130.2023.08.04.01.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:21:07 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:21:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ipw2x00: refactor to use kstrtoul
Message-ID: <202308040120.183400A04@keescook>
References: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:23:06AM +0000, Justin Stitt wrote:
> The current implementation seems to reinvent what `kstrtoul` already does
> in terms of functionality and error handling. Remove uses of `simple_strtoul()`
> in favor of `kstrtoul()`.
> 
> There is the following note at `lib/vsprintf.c:simple_strtoull()` which
> further backs this change:
> | * This function has caveats. Please use kstrtoull (or kstrtoul) instead.
> 
> And here, simple_str* are explicitly deprecated [3].
> 
> This patch also removes an instance of the deprecated `strncpy` which helps [2].
> 
> Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull [3]
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This looks correct to me. I would be curious to hear back from the intel
folks if the interface continues to work correctly with real hardware.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
