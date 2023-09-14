Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A617A0708
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjINOQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjINOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:16:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA9CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:16:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31fa666000dso890113f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694701010; x=1695305810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2kB3K2UJ4g8w/oEGmp+zgtYqt7DRAr5lRj6AMn1pyY=;
        b=a3XRDwYKYhTtZny3s6to0KtJSFI/QCAEmjFgCB7w1HWlDJxX9Fhe4aD+HiWF5Mf36T
         QQZmq5ZQFInl2BZRLH6JtaOJDsQZgYRxxIMcSeQyE1W3PDKjRU0ISSaNTYXTjMIWiBmS
         ONiMdz2b0DRVGi47N1UBk5IMtqyfL4gOketpmttyQ0Dj/YIWKKh8Yviv7si/bmAeDU6X
         xtFYYXrJIynKeUStTnPC7A/rgFBM0M8d04TCE3J1NQgdPmGz/dcKjS7xG8Ac1eG9KuoL
         5T12Q+Yw/cUzEmEi7Z+bDQX+NT9267OEigy8xiGfsJYVPwE1mNe5yzZ0pocrg+A16bum
         Z9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701010; x=1695305810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2kB3K2UJ4g8w/oEGmp+zgtYqt7DRAr5lRj6AMn1pyY=;
        b=Dd8OCSjoumwVvqK/3+f72ueCrFKrEArLmzmaM3/bsDokpmHngboQNg0a38uBjXz9Td
         PaNwz6o/GitKiv5yCiGqSmDePXr3C8ZYJzoczTbzKk0zHklkgwa/BfdjnE8CkP5ccl5N
         yjcCpbnx/UXPpnZV10pJhX76p5mJLGeYwsmR/7Hm4OIXnhlaxa/pi5PKM66vfihkh9Pl
         UD0GF7bi6F3dlaH6gCzLAekUJgepSjDQQlHzgN82CUMwNrBHz7yz8MIcDo8UtzTsPv2o
         ehKy/IYnPzW9cCbFZ6xQ+mhnjkirhsfMtTBTqRmVzZI+mqS/iee4HPOh+3mPjR+qpO5x
         qIAQ==
X-Gm-Message-State: AOJu0YySH421MbqGovYWdC+gNQhf6Qm6YNsrvH06eAjYVswHrhgeRvam
        Wsu95KNQt9XofKJDB6GM9IL6r5gwMy0=
X-Google-Smtp-Source: AGHT+IGX+qWfRKpSfsJR0HeKvM9FR6IfWa+a/g5/HteSVFNj9/AAHq4VQZwDAuuBJxpAAAwoSp3X8g==
X-Received: by 2002:a05:6000:68a:b0:31f:d5db:a13 with SMTP id bo10-20020a056000068a00b0031fd5db0a13mr2302589wrb.61.1694701009817;
        Thu, 14 Sep 2023 07:16:49 -0700 (PDT)
Received: from gmail.com (1F2EF048.nat.pool.telekom.hu. [31.46.240.72])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003fbe791a0e8sm2127131wmr.0.2023.09.14.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:16:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 14 Sep 2023 16:16:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Huang, Kai" <kai.huang@intel.com>, lkp <lkp@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Message-ID: <ZQMVz/wepyo9rlhE@gmail.com>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
 <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
 <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
 <20230914072959.GC16631@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914072959.GC16631@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > It appears the __noreturn must be annotated to the function declaration 
> > but not the function body.  I'll send out the fix as soon as I confirm 
> > the fix with LKP.
> 
> FWIW, the reason being that...
> 
> The point of noreturn is that the caller should know to stop generating 
> code. For that the declaration needs the attribute, because call sites 
> typically do not have access to the function definition in C.

BTW., arguably shouldn't the compiler generate a warning to begin with, 
when it encounters a noreturn function definition whose prototype doesn't 
have the attribute?

Thanks,

	Ingo
