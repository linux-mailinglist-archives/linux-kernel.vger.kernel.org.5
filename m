Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3B7AC655
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjIXCwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 22:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXCwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 22:52:07 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F0127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 19:52:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3adc3d94f66so2956572b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695523920; x=1696128720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qoxOpoYwwbcXvP8AhdHBWCEQ7XvmIo4NgjxEavDKJS0=;
        b=R7+78uPj1vsN9ArLH0OMzIGPyTzfVp7iVwptGLxavDM/4VWGPINkimkMWDGhYsJLLA
         KPLMZ/osNzryQT/bOFE2YrFLhsv5W1qWrGIgc+K6wycrLBQMNxtGOYN15t0Ewsl6cHcD
         nCBea44ociJPStjlivuIrUJ/jNR6rTgPiY/E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695523920; x=1696128720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoxOpoYwwbcXvP8AhdHBWCEQ7XvmIo4NgjxEavDKJS0=;
        b=w1Te6wprrAVXM4iYjgrXgWueB0BnxU+mQqgB08alrTOUuLxtmD4wx0BXBEs7gpKbwq
         uCc7hjtzZzQJpfris8MgXAWGsgndaFcdEhth1qPzBwd3W0pyDGSmMXSKmOWty/ry+aZN
         75AQ1Q6qiBI9Z7Txrqeupg18eJMLGzTLaZhB9Z13l4veIx18ZDJRTT9c/oQDK8A+AlCq
         dI/YH3DUO6GpKdRHCvwNBNt8WvD23YClUyhghUQ61Oh49xEwG2tXrQrxatNFFDGIDEXz
         eCrTeQAxlS/zjFNEDQH4ayrkwbDPx//2Un+0CTzKRac9vUtEnm4prOvT2/XMhQX7BsE4
         uEaQ==
X-Gm-Message-State: AOJu0YwLX5WYm86AfpT2mXTbquXi7hwqnqqhNSVWow4puALhRxwS+Tjo
        9OwtBmI4i66wmOdc3kj+6sJO/w==
X-Google-Smtp-Source: AGHT+IHcUoAikiUF1QqzgTagOroRwcP1YpmHmYrwno+IIkRbBhz92pli07wtVSNBbwi76ORGeUjvtg==
X-Received: by 2002:aca:1c14:0:b0:3a7:aa1:f883 with SMTP id c20-20020aca1c14000000b003a70aa1f883mr3738720oic.29.1695523919867;
        Sat, 23 Sep 2023 19:51:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm6038250plb.52.2023.09.23.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:51:58 -0700 (PDT)
Date:   Sat, 23 Sep 2023 19:51:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc_sysfs: refactor deprecated strncpy
Message-ID: <202309231950.698026E687@keescook>
References: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-strncpy-drivers-edac-edac_mc_sysfs-c-v4-1-38a23d2fcdd8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:47:29AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We've already calculated bounds, possible truncation with '\0' or '\n'
> and manually NUL-terminated. The situation is now just a literal byte
> copy from one buffer to another, let's treat it as such and use a less
> ambiguous interface in memcpy.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, I think this looks good now. If a v5 is needed, a tiny improvement
would be to update the Subject: to "...: replace strncpy with memcpy".

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
