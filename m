Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE3E7B0999
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjI0QGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI0QGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:06:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6092
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:06:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso8985114b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695830800; x=1696435600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9IMc3CNSZ/gNDCqC4lhFAPbDDxmcPGnDavaaHDUQsA=;
        b=NID/x3BxuTCJ5oDS7YsoDD018qUxclIX0FaDro8paN8kBI1wV/14uGu0sco/3cfdNc
         JgFDeSrfn8+HOKdUVsk3qR2Gkbji7X3vF908ssrm4IQoutqx9b9EooD9mbTALQCqj1Ye
         dRoZ6NEfzQWZ/TfWxIKeERkZoABV1FsGKgD+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830800; x=1696435600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9IMc3CNSZ/gNDCqC4lhFAPbDDxmcPGnDavaaHDUQsA=;
        b=hS99Zvgu9Fe0p601Zsl05J+HcSzQZ83l0JeCji7ijGiqB+ELHXyTEcBzI/uZM8ZNSv
         EkkWKoyM6QGAa3TJC3F+rTrRtaKF7lDr+DmKWEurdATjgF1w/Wb5OyT/Mz0gggwLGEHp
         /9p6xIgMehrRITH2QdAzvjmmZ457ntUn92/wbrqxWU7CXabfi/WbQFdlEvHpF6i9GB11
         0nG/JLjv0lKkEly6+NHBD0cTazbLJvYOKNc0/VPkLkR42TsuWcQR0RQ4MXiMUB2Qk3ZZ
         Ae75JfSEYU1SOMV/UJYo7w5QcTJMbF+rNeP5+yJgupZH0xnzfsAgxqIRZeOYqHwAA8A2
         sSXQ==
X-Gm-Message-State: AOJu0YwvxZJyNLRbvMV4yx+WCQVL+E46Nbf4UX8uKG8MGleFJ7xRAT54
        ozoWCH+u4hiTmeJvFj0Ol9ki4Q==
X-Google-Smtp-Source: AGHT+IH1SofGgSqeNRn8nWrqgolxJTujcJ2tAHFRFhX6dM3k5+HerJ8jwPH2XIz59wXM/wDB99i2YQ==
X-Received: by 2002:a05:6a20:970c:b0:159:cf93:9b50 with SMTP id hr12-20020a056a20970c00b00159cf939b50mr1874284pzc.46.1695830800300;
        Wed, 27 Sep 2023 09:06:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005789cbd2cacsm11488172pgc.20.2023.09.27.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:06:39 -0700 (PDT)
Date:   Wed, 27 Sep 2023 09:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH 1/3] MAINTAINERS: add documentation for D:
Message-ID: <202309270903.D8ED32AE3@keescook>
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
 <20230927-get_maintainer_add_d-v1-1-28c207229e72@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-get_maintainer_add_d-v1-1-28c207229e72@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:19:14AM +0000, Justin Stitt wrote:
> Document what "D:" does.
> 
> This is more or less the same as what "K:" does but only works for patch
> files.
> 
> See [3/3] for more info and an illustrative example.
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..de68d2c0cf29 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -59,6 +59,9 @@ Descriptions of section entries and preferred order
>  	      matches patches or files that contain one or more of the words
>  	      printk, pr_info or pr_err
>  	   One regex pattern per line.  Multiple K: lines acceptable.
> +  D: *Content regex* (perl extended) pattern match patches only.
> +     Usage same as K:.
> +

The "emphasis" tags here are used when rendering:
https://docs.kernel.org/process/maintainers.html

In this case, I assume "D" is inspired by "Diff", so perhaps reword this
to get a proper emphasis hint, and add additional context:

  D: *Diff content regex* (perl extended) pattern match that applies
     only to patches and not entire files (e.g. when using the
     get_maintainers.pl script).


-- 
Kees Cook
