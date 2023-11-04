Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87577E10E6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKDUQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKDUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 16:16:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B0FB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 13:16:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc3388621cso33076895ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699128997; x=1699733797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3q+26NQjsCSsUclbOoVT3OpgFnwDtiYbZS3n2A1sXk=;
        b=nD04PvV+MBhuj5r5pcXaR7Sk7u2/7o2NLWP8LPzI8HkgV6CsBdlek7cNIyLE5Ex2Yx
         ZzAg0m7IHGZ1AcZqoevXmg75dGrfPpkNZ17z/bFHuMVfjiTsRzdUY/x/nrgdh0jXbYfi
         cuVJdfGC6YSazIh6IEZDofmxfk6VM+Wk5Rhbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699128997; x=1699733797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3q+26NQjsCSsUclbOoVT3OpgFnwDtiYbZS3n2A1sXk=;
        b=HLT1xtNhiB+4VqduOrb3Fq3fu1h0Imh/SbpAAQdPBOZ/Xqskuo3TjlyPiMKYweMlsK
         GOPgNPLmlfS5BUArScjDMf4F1+84jG4hZfcKY4XG0qVeUEjwqr+BrOWjWazPdrNNq/Hk
         Fcs3Pg/ZQQL8kFNnNHwrJ1VjxC+ERZSM2WS8vV8uKoFiwCXurleqfJkz2DAbZjwyUYjK
         4/WzwN+4DO7Y3xALmcEE/CLGsffB3GBPXAcp7D2z/XtaQqynqlbno3KKrxNd9+tvRe89
         xaKV46Xm4d5gjoLdLSVzhINLwatf/6N3QFPwSrib68bT2Yr4Q8EmC3hCw4UvgVXk5Pl+
         xzKw==
X-Gm-Message-State: AOJu0Ywx899WbtHwTdFmSMFS5t7SNJ9iK3dOt/OdMyGd0AkSjJ/CsB02
        s+aZd/9OoMVrlfUEXuAPpqZozA==
X-Google-Smtp-Source: AGHT+IG3c5xfOJz1RbIcNJcl94Po9noSiBFDwt07JlMVvyocCZu40rrhyVtY2DVrXGeuet84jn2G3Q==
X-Received: by 2002:a17:902:e88e:b0:1c7:5776:a30f with SMTP id w14-20020a170902e88e00b001c75776a30fmr8832331plg.12.1699128997174;
        Sat, 04 Nov 2023 13:16:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001ca2484e87asm3280474plh.262.2023.11.04.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 13:16:36 -0700 (PDT)
Date:   Sat, 4 Nov 2023 13:16:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Joel Granados as co-maintainer for proc
 sysctl
Message-ID: <202311041315.F91B4DE@keescook>
References: <20231102203158.2443176-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102203158.2443176-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 01:31:58PM -0700, Luis Chamberlain wrote:
> Joel Granados has been doing quite a bit of the work to help us move
> forward with the proc sysctl cleanups, and is keen on helping and
> so has agreed to help with maintenance of proc sysctl. Add him as
> a maintainer.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

And honestly, I should likely be switch to "R:" -- that's most of what I
do for sysctl. :)

-- 
Kees Cook
