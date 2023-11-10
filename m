Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30357E760C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjKJAwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJAwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:52:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D723850
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:51:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2426551a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699577517; x=1700182317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KX9cqTvC/riS8T1TZJt0uYo3mkWzkvpYYEC7L1TIAac=;
        b=doKHquWAmQTUtXYyu65fr0uURkiMGuNJ6N9ZO2jbwnHmR4QqTYvOt7ylIGWnj3fUDd
         Rs6K5NPvpWWony//G0MD5vgAXg3FcT77psWWsptrn0cFGuXHwKu2it0Z5GDqIflxHPkQ
         YmR0J4KNXBQsTRPi7SPg03xqWWeoTXDVXodAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577517; x=1700182317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KX9cqTvC/riS8T1TZJt0uYo3mkWzkvpYYEC7L1TIAac=;
        b=e4gAD36cvmQakOlOxCmXmeFsLUgakqUm05fehcXKqdYTjPBuvS2lX8+LUOgc5pgM1e
         Z8qMrVL30BwSkV4l3B8EAyC3SlkKsqbkLlD/t/cTDENIi1rPwYehdhiuD05Vow0rzWSh
         iC/JWP+vFLpoqFEg7PuidCDjGcKodPxXnhIuO9GldHjzYJmnoIEKRabDohmMcGWiYmnp
         I12KRzBaw103gdxX05qjMqqVKXeUhSul5bZ2ORSXH38Co1kpRSpUopBO6ZhPR3UI0XG7
         R1pIKHTKV774nlHMiJmkl90siBx+5SXgSqJjwGlCwMfw7xb2f837VVwwEeCUOgYmlNRq
         RC9A==
X-Gm-Message-State: AOJu0YyA5qdER3k+nP4hxKB+WIe6WVHiLW6NGmgyFfdoyHwyK4hhoQ1B
        Si/r7iaR2mQqBUZwzAEIHzAF6TLaxy2GxGY9F3/RKw==
X-Google-Smtp-Source: AGHT+IEXyPWdCSV5ERMIPGt7bIOPytzRRLsHTD/yMuz20PONM5Hi3t5Xx5x7nQDnwobZmFxjvkPJug==
X-Received: by 2002:a50:cd10:0:b0:53e:f321:e6fd with SMTP id z16-20020a50cd10000000b0053ef321e6fdmr5267819edi.9.1699577517639;
        Thu, 09 Nov 2023 16:51:57 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7dc12000000b0053fa13e27dcsm462925edu.48.2023.11.09.16.51.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:51:56 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso2438272a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:51:56 -0800 (PST)
X-Received: by 2002:a50:8a86:0:b0:542:dcb4:37f with SMTP id
 j6-20020a508a86000000b00542dcb4037fmr4543051edj.41.1699577516125; Thu, 09 Nov
 2023 16:51:56 -0800 (PST)
MIME-Version: 1.0
References: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com> <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
In-Reply-To: <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Nov 2023 16:51:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
Message-ID: <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
Subject: Re: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
To:     imre.deak@intel.com
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 at 15:34, Imre Deak <imre.deak@intel.com> wrote:
>
> The compiler warn should be fixed/suppressed by:
> https://lore.kernel.org/all/20231026125636.5080-1-nirmoy.das@intel.com

Ugh, so now it's a dynamic allocation, wasting memory, and a pointer
to it, using as much memory as the array did in the first place.

All because of a pointless warning that was a false positive - and was
always harmless anyway, since snprintf() is safe (ie it was only a
"might be truncated").

Please don't do this. Either do that ((tc_port & 7) + 1) suggestion of
David's, or just do '%c' and make the expression be

  '1' + tc_port

which should be fine since I915_MAX_PORTS is 8 or whatever.

I do wonder why those ports are printed out as '1-8', when the 'enum
port' is PORT_A..I.

So it would actually have made more sense to print them out as %c with
the expression being

   'A'+tc_port

but I guess by now people might depend on the 1..8 naming?

             Linus
