Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28746767590
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjG1SiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjG1SiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:38:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F904488
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:38:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbd2761f1bso19311235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690569491; x=1691174291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33rFVY7OX9UkeWBGFwT8EclqMxrl4R8dedNz9bKvxDQ=;
        b=By+5JMuD4M/lflc4z2fRv1vZzoxOUZYjHnQN4K1rkcJbvqH88LjT5IBYClmIAOanaS
         VYATJHuG9lgKZPivIIP6bJwMkVB6vPz1kXw2NHGNdapwyCGyNqIiIuT7eX6J88XUW0UB
         umgkL6WUPWkNC1tS98P9ChR7CE4/J/0ksMXiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690569491; x=1691174291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33rFVY7OX9UkeWBGFwT8EclqMxrl4R8dedNz9bKvxDQ=;
        b=AY8ERn1MBNr9i5lZHBJzsTj21xLMJlCVIlzHS2P/G3DygJa7GljMcKcu5Gd0p3LwLu
         TY+pm6h3rFuj9yuCF5YrjeweFhu9Fef0n/dQFGwoytAfyVqQyaf14/MeT80g0VdGdfDr
         2NO1cnP9JLv3i0m7dSzVhLWXmoEA0gTKqJCQy+1v0WsBTO2BEQGxwKqcAKwXjty8AQ6v
         7HGGPkFJPKgkOcQS7Yjvll+xLpkoPBPB+sqPn2wpkkzmkIBW6visnvloyWdQ19iwampE
         /9LiFIG3Er58JbB/umz0ClIQMmKsWB14gf+WOwO0Qu8bqORulKIIeLH012heIJtELLvg
         vjgg==
X-Gm-Message-State: ABy/qLZmmqzYfJOXWzaJmaFuFzAAWkxY+QDLg6T7Dg6rOJT9SOQTgqiL
        FZ2P6Ax0INvwKMdAQnoMfnJ5ww==
X-Google-Smtp-Source: APBJJlGs+KiAjovc4Ff5bXdv+1247KNp4pAQW/e6jaoOH3v88JUN99m0BT5bc653vOVDiJeYTmDZgA==
X-Received: by 2002:a17:903:248:b0:1b9:cf52:2bcf with SMTP id j8-20020a170903024800b001b9cf522bcfmr2621118plh.0.1690569491651;
        Fri, 28 Jul 2023 11:38:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b9d7c8f44dsm3907903plb.182.2023.07.28.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:38:11 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:38:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Elliott Mitchell <ehem+xen@m5p.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: xen-front: refactor deprecated strncpy
Message-ID: <202307281133.16D4305@keescook>
References: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
 <ZMNILDgqHEGf8fNF@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMNILDgqHEGf8fNF@mattapan.m5p.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:46:36PM -0700, Elliott Mitchell wrote:
> On Thu, Jul 27, 2023 at 09:53:24PM +0000, Justin Stitt wrote:
> > Technically, my patch yields subtly different behavior. The original
> > implementation with `strncpy` would fill the entire destination buffer
> > with null bytes [3] while `strscpy` will leave the junk, uninitialized
> > bytes trailing after the _mandatory_ NUL-termination. So, if somehow
> > `pcm->name` or `card->driver/shortname/longname` require this
> > NUL-padding behavior then `strscpy_pad` should be used. My
> > interpretation, though, is that the aforementioned fields are just fine
> > as NUL-terminated strings. Please correct my assumptions if needed and
> > I'll send in a v2.
> 
> "uninitialized bytes" => "leak of sensitive information" => "security hole"

For xen_snd_front_alsa_init(), "card" is already zero-initialized in
snd_card_new().

For new_pcm_instance(), "pcm" is already zero-initialized in
_snd_pcm_new().

So things look good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
