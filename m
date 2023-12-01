Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB3801268
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjLASRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLASRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:17:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70CF9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:17:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d048c171d6so7337015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454624; x=1702059424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80BOfbzU3jRYQRqKUun9qybGXNm0Ak9QPhMAb8Oq5lY=;
        b=ME+7xuShkkCd0062a9EL0L48UcVgl2XNVW5BRL6HrY/mg3DiShxSdpn7IJmQxj/w1W
         y6Kih+9DYWaLfoqYp+5pe938En1UXK6dzqyoieMKZZnN5wPV/Uq1I9TVzm7jMnnSzyry
         5cZjnWvfXpQLdgXob0ttJuENteq2/BltyHmws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454624; x=1702059424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80BOfbzU3jRYQRqKUun9qybGXNm0Ak9QPhMAb8Oq5lY=;
        b=JVhcVt0tLWvvcBiabuT06iTW33tvqa/R+debx4TPaNcifu4ldMHAeM1jNUJSHi+oJL
         FybYLwb78o8PLDYho+ULmP/taXJY7F1own1Ckb9Ari4Umq8+4PMxhdqdWAyYfNZwYvhw
         eItGMihB6huRIvJvgHKSfPXSB70Ih7Xy44r/Ju4dvtZaXmNyD5C+HJf9KXHMPN4+7/tX
         tgJjPxrUztkFeal1NV+TkF+WASxByKAw625X6IOnzH8f+DX120UoEW+Nj8f/N9yCw6Fx
         67JPL1dJzdgHJ12IgrRTfs1p4lNa+hS+r7ph00T3UK/ARkJfNHB0FarpmcR/fb5Inw9t
         mbbw==
X-Gm-Message-State: AOJu0Yym5SAH7nwlJhWhSDLZFPX4JXxx1UABU3zgNYk4pwUapW+rUFUU
        FMzPGqXEqWBug+auEEq15hoHOg==
X-Google-Smtp-Source: AGHT+IHL4QH3wU1zQC3wiy9r3528WOQq1iSHFfDCieTdatztPnIyrMoq50t3CKZORUjazAX/9P8zkg==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d7f with SMTP id m6-20020a170902db0600b001cfc3766d7fmr26246754plx.42.1701454623948;
        Fri, 01 Dec 2023 10:17:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001cfb99d8b82sm1570921plk.136.2023.12.01.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:17:03 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:17:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <202312010953.BEDC06111@keescook>
References: <20231130200058.work.520-kees@kernel.org>
 <20231130172520.5a56ae50@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130172520.5a56ae50@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 05:25:20PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 12:01:01 -0800 Kees Cook wrote:
> > This has the additional benefit of being defensive in the face of nlattr
> > corruption or logic errors (i.e. nla_len being set smaller than
> > NLA_HDRLEN).
> 
> As Johannes predicted I'd rather not :(
> 
> The callers should put the nlattr thru nla_ok() during validation
> (nla_validate()), or walking (nla_for_each_* call nla_ok()).
> 
> > -static inline int nla_len(const struct nlattr *nla)
> > +static inline u16 nla_len(const struct nlattr *nla)
> >  {
> > -	return nla->nla_len - NLA_HDRLEN;
> > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> >  }
> 
> Note the the NLA_HDRLEN is the length of struct nlattr.
> I mean of the @nla object that gets passed in as argument here.
> So accepting that nla->nla_len may be < NLA_HDRLEN means
> that we are okay with dereferencing a truncated object...
> 
> We can consider making the return unsinged without the condition maybe?

Yes, if we did it without the check, it'd do "less" damage on
wrap-around. (i.e. off by U16_MAX instead off by INT_MAX).

But I'd like to understand: what's the harm in adding the clamp? The
changes to the assembly are tiny:
https://godbolt.org/z/Ecvbzn1a1

i.e. a likely dropped-from-the-pipeline xor and a "free" cmov (checking
the bit from the subtraction). I don't think it could even get measured
in real-world cycle counts. This is much like the refcount_t work:
checking for the overflow condition has almost 0 overhead.

(It looks like I should use __builtin_sub_overflow() to correctly hint
GCC, but Clang gets it right without such hinting. Also I changed
NLA_HDRLEN to u16 to get the best result, which suggests there might be
larger savings throughout the code base just from that change...)

-- 
Kees Cook
