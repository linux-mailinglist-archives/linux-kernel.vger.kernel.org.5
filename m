Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6166278FCB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349278AbjIAL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIAL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:57:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576F0B5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:57:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so49645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693569436; x=1694174236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reCEJHqFLA1tTH9reQV/iOmfsI77/ReXtaNhrLBR2u8=;
        b=aUtqJTv+KjD/oII0764loo5ATOx01p20yWxX2OguXsfrarJbJpogdoXZo63Myu14/d
         Srzl0tSy25xL0ykSnxE6s7ROWCGxbKGPTzLsT2h7UA/svwzlivaQDgFfoKvo9DBEKHER
         Q2U00CccZFDWskNe3MKbexiFjuyDmGdlX3z9udzCwJ+xj87Fy1+bXCEgZkDsOAZqBmSy
         CfVuE6ZQnpjkxP7suIMN9dYyh5xotTX6u+bnbXf+/GOLgQZEDyaIk472dbRJ4MCCouiX
         tJiS1ZzigDzw5LsydwjzadIDI+qHg80ZBiJrpBtz4xtlQuRty26kh0HsGNW0KFjLFVE7
         Azew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569436; x=1694174236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reCEJHqFLA1tTH9reQV/iOmfsI77/ReXtaNhrLBR2u8=;
        b=BcNtQdyb0lLy+PfZ2wpDqSSExW8GGjAj9RQ1nlDjtETkqR5mmhpOOzw8luskX8KC9/
         wqcjBxLSsgYTRMtdcTI4UCPHrKD8XVJsICUhIxYoMURDT1lac2q1ZlG0QxVxtq32EFNO
         QUqoVKeTLo37Zl8IcXe7Qt6NPvVvmG6Eti7t14zxluymON6KTpVMmo5iBJtJUIkMmkb6
         tFlatPJRWExBRpNt+IDUPZxMxmxXdGgI/PiKWB7k1RSLucClU5ysHI2UQpDrw70SsC0o
         EB//D+bi2Hx6KaaUxpTW36EC/7+IX9nhHlGabszt/H+Jum/y2gEgPbsfwa9V5dPeB3Ye
         D7UA==
X-Gm-Message-State: AOJu0YxY3/sc0Lamx1UtBpON9wQvAv1L2hIsgQLooTB1J71ZK+zdM5Vz
        +/koGN2MmMBFL5ZtWHv9MIER60Ll7d2CvKkYeut8iQ==
X-Google-Smtp-Source: AGHT+IEYiE6an4LNNFzm40rOnWJRJuiTxTl9AnhfNz3EZyquRjhGbZh6SZsUE3rD71zSk7VBKYlW6w==
X-Received: by 2002:a05:600c:282:b0:3fe:dd72:13ae with SMTP id 2-20020a05600c028200b003fedd7213aemr134365wmk.0.1693569435651;
        Fri, 01 Sep 2023 04:57:15 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b003fefe70ec9csm7783182wmi.10.2023.09.01.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:57:15 -0700 (PDT)
Date:   Fri, 1 Sep 2023 11:57:10 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev,
        kristina.martsenko@arm.com, broonie@kernel.org,
        quic_pkondeti@quicinc.com, justinstitt@google.com
Subject: Re: [PATCH] Revert "arm64/sysreg: refactor deprecated strncpy"
Message-ID: <ZPHRlmBHZnFAeBeI@google.com>
References: <20230831162227.2307863-1-smostafa@google.com>
 <86v8cudtky.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v8cudtky.wl-maz@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, Sep 01, 2023 at 12:24:45PM +0100, Marc Zyngier wrote:
> Hi Mostafa,
> 
> On Thu, 31 Aug 2023 17:22:27 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > This reverts commit d232606773a0b09ec7f1ffc25f63abe801d011fd.
> > 
> > Using strscpy is not correct in this context and the commit
> > assumption is not right "strncpy is deprecated for use on
> > NUL-terminated destination strings".
> > 
> > strncpy is used here to copy parts of the string(cmdline) separated
> > by spaces into the buffer and not a NULL terminated string.
> > 
> > This breaks the arm options "kvm-arm.mode=protected, arm64.nobti ..."
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kernel/idreg-override.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > index aee12c75b738..2fe2491b692c 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -262,9 +262,9 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
> >  		if (!len)
> >  			return;
> >  
> > -		len = strscpy(buf, cmdline, ARRAY_SIZE(buf));
> > -		if (len == -E2BIG)
> > -			len = ARRAY_SIZE(buf) - 1;
> > +		len = min(len, ARRAY_SIZE(buf) - 1);
> > +		strncpy(buf, cmdline, len);
> > +		buf[len] = 0;
> >  
> >  		if (strcmp(buf, "--") == 0)
> >  			return;
> 
> Instead of completely reverting the patch, maybe something like the
> hack below (completely untested), so that we can still get rid of
> another instance of strncpy(), and yet bring back some sanity in the
> logic?
I was thinking of something similar, but I see we limit the len anyway
by the buffer size - 1 and force the NUL at the end so it should be
safe, unless the goal is to get rid of strncpy all the way, in this
case we can do it as you proposed.

There is also a V3 of the original patch which uses memcpy instead.
https://lore.kernel.org/all/20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com/

> Thanks,
> 
> 	M.
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index aee12c75b738..be5c778a3f14 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
>  		if (!len)
>  			return;
>  
> -		len = strscpy(buf, cmdline, ARRAY_SIZE(buf));
> -		if (len == -E2BIG)
> -			len = ARRAY_SIZE(buf) - 1;
> +		len = min(len, ARRAY_SIZE(buf) - 1);
> +		strscpy(buf, cmdline, len);
>  
>  		if (strcmp(buf, "--") == 0)
>  			return;
> 
> 
> -- 
>

Tested-by: Mostafa Saleh <smostafa@google.com>

> Without deviation from the norm, progress is not possible.
> 
>

Thanks,
Mostafa
