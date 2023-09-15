Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4E7A1241
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjIOAUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIOAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:20:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9972695
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 17:20:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0db66af1bso12190725ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694737243; x=1695342043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccX2gvw1qSPWr5qXb0fG86wgmS6e9ZRJiYSlfkRPwO8=;
        b=Uvn8PwkRMklZOZnQ9lTTyCA74BdG/Yst6jcEdbA9N3J4GhQFO/YcwGRgijdk8SpV9w
         7PnIWQNzacbp9dOmZDHrradgNEi7QUhJevAARvIqhz9LebPrqcRPUFdBLQuUNkrFEN44
         UuMFelcpfpPgNvQfwlQzrzKOrq3G25U2x+atc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694737243; x=1695342043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccX2gvw1qSPWr5qXb0fG86wgmS6e9ZRJiYSlfkRPwO8=;
        b=wQI//clBnb1j1pAtxD58A10xyFVcb99GM4/fLfDg0qc9u0pslWsBPF5FltPq7H1bkM
         D0Q/LYSqt2u4w4D7yS5F47QGQrTESCTlHuRLwpGXLYRIoyrcejj1UOHjHlR3GG7oFBak
         r0fPsMMVOSfWckZGhqki96TT3GS11r5nieJjHhGSfjP3mdFbvFfy+ylVdl62yp33sxCq
         nYf0kd2bTUoK0TV28RI460bG2ViZrMa14tFgW/mAFOY/PJpjn/jEqFmY4oSTfOTOOYqS
         ZwXR7Cn0IR1ODrrkxIf0yUEO9kJ8gupZQsfnkjtrhz3p9fAiS0Q5GgKxLcvB81AT/MPC
         ENqQ==
X-Gm-Message-State: AOJu0YxFs27BzQ3h5CcV8r7zED4UmtVoSvr6mzr3qMnzDipK+pXvSZ6u
        BNpUFzW5htrbWHV7DvUZc534aQ==
X-Google-Smtp-Source: AGHT+IEyhji/rreG138qZ8mOF1AMGzgZA5xtnA7PJaQ/as7QJ7PYziFOpOfY6VcIzMGt6niYciwpxA==
X-Received: by 2002:a17:902:dac1:b0:1bb:c64f:9a5e with SMTP id q1-20020a170902dac100b001bbc64f9a5emr224115plx.5.1694737243036;
        Thu, 14 Sep 2023 17:20:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902eed200b001b8b45b177esm555049plb.274.2023.09.14.17.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 17:20:42 -0700 (PDT)
Date:   Thu, 14 Sep 2023 17:20:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: linux-next: Tree for Sep 12 (bcachefs)
Message-ID: <202309141708.C8B61D4D@keescook>
References: <20230912152645.0868a96a@canb.auug.org.au>
 <202309131803.6A3C1D05A@keescook>
 <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:38:07PM -0400, Kent Overstreet wrote:
> On Wed, Sep 13, 2023 at 06:17:00PM -0700, Kees Cook wrote:
> > It looks like you just want a type union for the flexible array.
> > This can be done like this:
> > 
> > struct bch_sb_field_journal_seq_blacklist {
> >         struct bch_sb_field     field;
> > 
> > 	union {
> > 		DECLARE_FLEX_ARRAY(struct journal_seq_blacklist_entry, start);
> > 		DECLARE_FLEX_ARRAY(__u64, _data);
> > 	};
> > };
> 
> Eesh, why though?
> 
> Honestly, I'm not a fan of the change to get rid of zero size arrays,
> this seems to be adding a whole lot of macro layering and indirection
> for nothing.

The C standard doesn't help us in that regard, that's true. But we've
been working to get it fixed. For example, there's discussion happening
next week at GNU Cauldron about flexible arrays in unions. It's already
possible, so better to just fix the standard -- real world code needs it
and uses it, as the bcachefs code illustrates. :)

> The only thing a zero size array could possibly be is a flexible array
> member or a marker, why couldn't we have just kept treating zero size
> arrays like flexible array members?

Because they're ambiguous and then the compiler can't do appropriate
bounds checking, compile-time diagnostics, etc. Maybe it's actually zero
sized, maybe it's not. Nothing stops them from being in the middle of
the structure so if someone accidentally tries to put members after it
(which has happened before), we end up with bizarre corruptions, etc,
etc. Flexible arrays are unambiguous, and that's why we committed to
converting all the fake flex arrays. The compiler does not have to guess
(or as has been the case: give up on) figuring out what was intended.

Regardless, I'm just trying to help make sure folks that run with
CONFIG_UBSAN_BOUNDS=y (as done in Android, Ubuntu, etc) will be able to
use bcachefs without runtime warnings, etc. Indexing through a 0-sized
array is going to trip the diagnostic either at runtime or when building
with -Warray-bounds.

-Kees

-- 
Kees Cook
