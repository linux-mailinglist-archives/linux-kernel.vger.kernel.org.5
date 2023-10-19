Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9D7CECDD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJSAj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:39:25 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95CFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:39:23 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5832ea25c7eso365284eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697675963; x=1698280763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlAqaHdwVhP7VKj5Daa/OfAYFr6hwyKTFgWl8b0z2fY=;
        b=CMuJGFPHhNXI2VOwSGJiFikZYuNbevuaGufA8gldUtBHXpgyY/TMu8dIjailP9wgl5
         eZh7ULnjXp7gb9lv4cLsP7cP125Zc/VwWz8mE/Orj6dxlc8ASPHcTbFy+QxTWJPDSdfc
         lth67MUvp5WnfAWa3WNdiCaUx4qSZqnm/rm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675963; x=1698280763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlAqaHdwVhP7VKj5Daa/OfAYFr6hwyKTFgWl8b0z2fY=;
        b=C2Z3YUy+/2vDNcmpYH/09J5eitirjyng4ePbGLMFqR6gP+m48+3KwFk2bBoMfHLDF8
         hH23TqAtSuom6OLNfvriWnZfVBuBwebqSbs2rUjLJxcOyQW2gk0oR6cDYmU4ghctSdej
         DqJVAC2TRkRKY6BYFnz56pX8udrVFUF9KxhDcufXDr7L4Q1VT7eS3C8dQ4lfpGnvwQpc
         wqHkKylAFPkhrSFXb4jpNojCjop+i3AvqsnVxMyry9nx/+DycqT/YE1mkhl5t5LtsPzv
         //Zihlp8oio7WqjCd6yfaCn5FY9Uj8jQ+3mJEmak+C7GwolAO2iiNTKk1mY679U6441f
         l5Zw==
X-Gm-Message-State: AOJu0YyWVq18MNZTseGB6CPn7gElkwR+AN6QxCR5V1lEHDL4hibvxySq
        GvkvKWZJ3qow8G0piHl13kpmCg==
X-Google-Smtp-Source: AGHT+IHNA8day/L5V0dMB7BwM3NkA+lMR8Hw9u2q1YJsT6nOhCZWEUr9ix9SqZJjb/erpPPVw74Fjw==
X-Received: by 2002:a05:6358:5114:b0:13c:dd43:f741 with SMTP id 20-20020a056358511400b0013cdd43f741mr471532rwi.24.1697675962983;
        Wed, 18 Oct 2023 17:39:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020aa79432000000b006bd2bbbaf49sm3929613pfo.122.2023.10.18.17.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:39:22 -0700 (PDT)
Date:   Wed, 18 Oct 2023 17:39:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Li zeming <zeming@nfschina.com>, gor@linux.ibm.com,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stackleak: Remove unnecessary '0' values from ret
Message-ID: <202310181704.F1089D5B@keescook>
References: <20231017060824.10434-1-zeming@nfschina.com>
 <ZS5ek5RrW3XaBph9@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS5ek5RrW3XaBph9@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:14:43AM +0100, Mark Rutland wrote:
> On Tue, Oct 17, 2023 at 02:08:24PM +0800, Li zeming wrote:
> > ret is assigned first, so it does not need to initialize the assignment.
> > 
> > Signed-off-by: Li zeming <zeming@nfschina.com>
> 
> Does this actually need to change? It's not harmful, and deleting the
> assignment doesn't save any lines of code.

I prefer explicit initialization. Any unused initialization will be
optimized away by the compiler during Dead Store Elimination, so all
removing the initialization does is make the code more fragile in the
future.

> That said, I don't have strong feelings either way, and Kees is the
> de-facto-yet-undocumented maintainer for this code, so I will leave it to him
> to decide whether to apply.

Oh, hm, good point. I will add a MAINTAINER entry for it. Thanks!

-Kees

-- 
Kees Cook
