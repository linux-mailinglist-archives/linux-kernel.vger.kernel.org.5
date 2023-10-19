Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914FB7CEF03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjJSFbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:31:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF6121
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:30:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so68316a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697693455; x=1698298255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnzVjXLcGJ68uYJU2etwiw2XROZ8HwiF1EjuRYmpiPg=;
        b=SRiJvTVbA+2vX8JfQsc54CQmayrSip+uUz6Aa9dL+Q9b6Ch34KW/wSYK1XJkupeDl8
         wUKZNTwV/ZljEcHbfTrmUfjYleJqfd1UK9NYhMAodsxKGWaZfxhF95qlL7fPK4G873od
         fTfHUkZV4yJj9OD1iC/96V6CJLXUGmGEgPEb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693455; x=1698298255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnzVjXLcGJ68uYJU2etwiw2XROZ8HwiF1EjuRYmpiPg=;
        b=tXx2LlfJtTSgwBxKoXhGPRF//8Qgbz9sHfTpyiNfseNLGaDwBCSXsoKm7UoSwDk6IR
         IavN4naoG9TGaSkHAEFSzLxm03+TyvWBgr8QS+w25QwfPnUI8xqlvs12n9ZpA6Jwq9dE
         8Adp3HhzrSVbkrKtnrBYSTgZJD+p7iTcvr0ZBumuUPh5ltY1qktBvVcMLO9TNdATMsi2
         6cpa9sl9hMXThasuGBvNAgaPR5bRKuM0cCJZ4KyQAgXihScvhcLlPka0+JdeYFCsFbv1
         zIoHKiI5w5E9O+qflCrQd/hIG3X3qE0Pkx2uELC3n5zB7zxBLisAdsnbk849TOqaP34W
         VWTA==
X-Gm-Message-State: AOJu0Yzs8ZEAEkadlAwBJ5FRrDIfuDcXHSat7chg2K0JknJM9tB4brOr
        4urrIml3963JGearFeRjIvXbJw==
X-Google-Smtp-Source: AGHT+IEHjV5wBQAQBHQxIAmeDsNxJk4eWAORpHR3P43FYYXJX+Li9UVJZFeBDWJ+ISEUR5t11MLHXw==
X-Received: by 2002:a05:6830:910:b0:6b9:924e:b43b with SMTP id v16-20020a056830091000b006b9924eb43bmr1353380ott.6.1697693454900;
        Wed, 18 Oct 2023 22:30:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78bd4000000b0068fb8e18971sm4242166pfd.130.2023.10.18.22.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:30:54 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:30:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: replace deprecated strncpy with strscpy
Message-ID: <202310182230.ED18D3A92C@keescook>
References: <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:36:56PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect wl->chip.fw_ver_str to be NUL-terminated based on its usage
> with DRIVER_STATE_PRINT_STR() in debugfs.c:
> 491 | DRIVER_STATE_PRINT_STR(chip.fw_ver_str);
> ... which uses DRIVER_STATE_PRINT():
> 444 | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ... which relies on scnprintf:
> 434 | #define DRIVER_STATE_PRINT(x, fmt)   \
> 435 | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> 436 | 			  #x " = " fmt "\n", wl->x))
> 
> Moreover, NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
