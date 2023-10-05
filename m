Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9E7BA630
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbjJEQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbjJEQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:26:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F11BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:22:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-694ed84c981so946977b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696522921; x=1697127721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xlZdjuRZ3EiS5hUIS3cheCtDGn4hllvnDuk1YtIiL8=;
        b=iQIwcjDtUcQ5B7rrH39U4s3CYqxQgzRv+yOXK4ffX/PQ0bDtRpArNZ3ZP0TU2V+iSO
         EjiiE4Siown06hQ3iW692SiwY8IgnChw/Xl4jVtIOppxjoQDRYRrbDozpzSnFelVSbBG
         Iz5FDOl0ifwGXffc1W0e6+GEtk1pg6ONmqSHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522921; x=1697127721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xlZdjuRZ3EiS5hUIS3cheCtDGn4hllvnDuk1YtIiL8=;
        b=PzsaKacf2mbz8M4tal+81Qszms8iuVLhZR4avnDUGQsYkNVmamHZtHi8yPUeEAU2SF
         2OkIjf0fMrfr/xP43cKEbpKzd6m5AcvhmjDwTnRj/v40nkejJ9xPj87VQ0efXflRkXpy
         IF27Iii57CLVB4fbtWSK7idbED1XriP/l/k+1tfXoTzUE6iFCtcBu2gzpICkkYSYHPi6
         RQZg5FG8OZhLrYcS4gagBMYZQRmkH26LViXORwaAX6V1UZUW0FsHUxLobiGUB8xFSIyE
         hrj5lYmCWTdIms/ZFZZhfUmTr1liJj4hm//B/mg5RTJtVdIaZ7cRMlv7y376Xlxxy1Cd
         y8Mg==
X-Gm-Message-State: AOJu0Yz7Q0K8tophiCx6pIze/iCCYFERVZAzVpSR5ZHDuI4UssTuSduh
        KKZ8PdD6aKWm/B/FugRPUJntvA==
X-Google-Smtp-Source: AGHT+IFPkZwwtErvUtwQx729VOR4jIp/RfewIvjt55LeIfJ6pMziUndRTcO/Mi/qbMOguQZV28rD9A==
X-Received: by 2002:a05:6a20:8f26:b0:159:fe1d:2f32 with SMTP id b38-20020a056a208f2600b00159fe1d2f32mr6782722pzk.42.1696522921110;
        Thu, 05 Oct 2023 09:22:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78017000000b0069305627494sm1568468pfi.165.2023.10.05.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:22:00 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:21:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux@rasmusvillemoes.dk'" <linux@rasmusvillemoes.dk>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        "'bvanassche@acm.org'" <bvanassche@acm.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 next] compiler.h: Move __is_constexpr() to compiler.h.
Message-ID: <202310050921.F0B15702D4@keescook>
References: <2a6680bbe2e84459816a113730426782@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a6680bbe2e84459816a113730426782@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:39:54AM +0000, David Laight wrote:
> Prior to f747e6667ebb2 __is_constexpr() was in its only user minmax.h.
> That commit moved it to const.h - but that file just defines ULL(x) and
>   UL(x) so that constants can be defined for .S and .c files.
> So apart from the word 'const' it wasn't really a good location.
> Instead move the definition to compiler.h just before the similar
>   is_signed_type() and is_unsigned_type().
> This may not be a good long-term home, but the three definitions
>   belong together.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>

Yeah, this is what I'd expect (a duplicate move in tools/). Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
