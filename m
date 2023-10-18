Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530887CEB96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjJRXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRXIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:08:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25568118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:08:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b709048d8eso4069726b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697670512; x=1698275312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+6LQBPGNqtPA5naLsc4aWMbk2cbN8f3X83ZN1e7doc=;
        b=Xq16VMB8MbLQIbbytd5otyYLEV5P2YpV1m0avVRYXmb7fxOQ+y/1DjQg8EiZGn1auC
         BoLq16q7xV3IWV/PrLuaJnEmN/80IWjLd6d7PXrdeuBXNvCq4+q2g3vBbVAabycaAPP7
         zHoJnb7bg6Xjx4OfEYnbPBZE53RHlC4ngKZB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670512; x=1698275312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+6LQBPGNqtPA5naLsc4aWMbk2cbN8f3X83ZN1e7doc=;
        b=X8eKXKT7EA56MExPhDnf4vQEKpv7LlEE5jD7JOnHR8FPMoL69QzITHaSD/3EYa5zll
         3k5R6ZC/OMrJuPEPmrSGw6XuM+3MnO7vjZhKqJCbVSkHEm47WzmkXahaoyLY/raWSAPS
         0HusXF4qP64KmxP7C8gg0zCPe62qsEBf+K4cAg+cmqFksvwwpeTts617DBsYYIIFlEbu
         T+W+B7hYABiGs+TClfKrFsT0BhXLhj8h4SzHK+Lyg89Rvbr8mkWGYZcN6HtqXzHKZZZ9
         84Ghu4N/awfEjw3VoXMaPz5dVNu73oVagV8+3AQf0q7IYbmKq7VV1FDmDDYEI2Y2yK0L
         FlxQ==
X-Gm-Message-State: AOJu0YznVivMv5fEPqhsYZ1yvTP6l3jBKOo9qLRqZfcDRc01TxiZd859
        /S0Qa7nFZ/3/3bJUQ3F0ztSnMA==
X-Google-Smtp-Source: AGHT+IGYHNW6Jmdfy0D/h4oQ4a9/L+RvvlkoNY7K3oxKe9nrIXzWzuGuPdxEnJjAmD+yjr63m8Zczg==
X-Received: by 2002:a05:6a21:329d:b0:17b:43:9ba5 with SMTP id yt29-20020a056a21329d00b0017b00439ba5mr625475pzb.52.1697670512667;
        Wed, 18 Oct 2023 16:08:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709029a0500b001bbb7af4963sm471155plp.68.2023.10.18.16.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:08:32 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:08:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <202310181607.2244DB9F40@keescook>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
 <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
 <202310181534.54934E68@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310181534.54934E68@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:36:00PM -0700, Kees Cook wrote:
> On Wed, Oct 18, 2023 at 06:04:07PM -0400, Kent Overstreet wrote:
> > On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> > > On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > > > Hi Kees,
> > > > 
> > > > I'm curious if this is something that could be buried in bch_val given
> > > > it's already kind of a fake structure..? If not, my only nitty comment
> > > 
> > > I was thinking it would be best to keep the flexible array has "high" in
> > > the struct as possible, as in the future more refactoring will be needed
> > > to avoid having flex arrays overlap with other members in composite
> > > structures. So instead of pushing into bch_val, I left it at the highest
> > > level possible, bch_i, as that's the struct being used by the memcpy().
> > 
> > I agree with Brian here - I'd like this buried in bch_val, if possible.
> > 
> > I also went with unsafe_memcpy() for now - that's now in my for-next
> > tree. I'm not seeing any advantage of DECLARE_FLEX_ARRAY over that -
> > perhaps later if we could use __counted_by that would make more sense.
> 
> This won't help here because of the combination of -fstrict-flex-arrays=3
> and -Wstringop-overflow (the latter is in W=1 builds). The builtin memcpy
> still complains about the 0-sized destination. I'll send a v3 with this
> in bch_val.

Actually, I've sent a v3 that totally replaces the memcpy with a direct
assignment instead. No struct changes needed!

-- 
Kees Cook
