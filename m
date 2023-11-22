Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252577F3F63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjKVIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:01:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798ACA4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:01:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso4190165e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700640069; x=1701244869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9ADCjEI7o9dzGO9BsaR3z0G/sfMu5E5t4/ZTd2GGTs=;
        b=g7hbwMOhIUOaA+GN1m9F5ZlSXOp6oiVoTpokt2Se4CCwYdHFmEGtpWY1pCGirjuvNo
         M8SN2W+/Q2+sYr5B5+jIl2pFww+ZYTUBumUdedw3Qi7F0EhwxTWpV3eGuAhqCtVdNid2
         as3cJDGCwEc7jtWbnJyaE7//v8PnkW3vpwtA5i8OGGCkQF7nAkFDTyqkFiS5MEeqV+Zf
         anCBe5txgS+VYRaU9zxtjsjFeqylfPEWj3LI9Y3+n1+dQcIGx86M5X1lynqzDVmlnVDI
         K5jnUT5l14x7L1EP/KH3y5jyTPHAgIq+s+/+4FZULnPrAU1vL/ASEBhqxOUuj4KXPfX8
         FD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640069; x=1701244869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9ADCjEI7o9dzGO9BsaR3z0G/sfMu5E5t4/ZTd2GGTs=;
        b=D0vDtiTjf+r95HRn3hIbhudqZMluyxtmUsWJ2yQN5DBL4NZuuBhnr67xghn+nUmEwG
         WpJkxmecj7Veks/qdawx2Rfp+vBOUj0qYWuwC/OKZgmHAJroVfbjdFqw/asptTZ/2f4h
         zNm/ioRIv8dQcTVHQ+o0u8oNvI0lOJd0BUgwDTULfh6MddbSMaA51YT9+hXgNuxPB4qd
         ZCMUS3e1XeGnmfF81H3GXKB5p5vT69m6sKWR/vxNrXv3KC9UDIODR6oD6KVOXHu6A+Sq
         oaAKSyZfSeJvuD9CUwdezrAobkiAB+EwfWlCaljOyzf/oaBa5fVbknb9AYWYjXdhYlie
         hJQA==
X-Gm-Message-State: AOJu0YxWCK3Sciu/xf+47GZ0jWj5MFJR58ooeh7UAPOpXnGcTir4c3JS
        DNyaPWupg3ySJ6YyNIwGMbN0jw==
X-Google-Smtp-Source: AGHT+IE1/C3weLHdhpWJSWXJPJYT4boAklbn3sgz4rb9EWKq6qitvv5j2eDGac4BGRWMcwTjthYjsw==
X-Received: by 2002:a05:600c:4fcc:b0:40b:2b82:dad8 with SMTP id o12-20020a05600c4fcc00b0040b2b82dad8mr1190319wmq.5.1700640068378;
        Wed, 22 Nov 2023 00:01:08 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n44-20020a05600c502c00b004083a105f27sm1326932wmr.26.2023.11.22.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:01:08 -0800 (PST)
Date:   Wed, 22 Nov 2023 09:01:06 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: Fix issues with $(SPLIT_TESTS)
Message-ID: <20231122-ef1578645fb74a7aa0fca822@orel>
References: <20231121165631.1170797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121165631.1170797-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:56:31AM -0500, Paolo Bonzini wrote:
> The introduction of $(SPLIT_TESTS) also introduced a warning when
> building selftests on architectures that include get-reg-lists:
> 
>     make: Entering directory '/root/kvm/tools/testing/selftests/kvm'
>     Makefile:272: warning: overriding recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
>     Makefile:267: warning: ignoring old recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
>     make: Leaving directory '/root/kvm/tools/testing/selftests/kvm'
> 
> In addition, the rule for $(SPLIT_TESTS_TARGETS) includes _all_
> the $(SPLIT_TESTS_OBJS), which only works because there is just one.
> So fix both by adjusting the rules:
> 
> - remove $(SPLIT_TESTS_TARGETS) from the $(TEST_GEN_PROGS) rules,
>   and rename it to $(SPLIT_TEST_GEN_PROGS)
> 
> - fix $(SPLIT_TESTS_OBJS) so that it plays well with $(OUTPUT),
>   rename it to $(SPLIT_TEST_GEN_OBJ), and list the object file
>   explicitly in the $(SPLIT_TEST_GEN_PROGS) link rule
> 
> Fixes: 17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code", 2023-08-09)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>

Thanks for these fixes, Paolo! And thanks for keeping my old @redhat.com
address alive!

I've tested this on riscv,

Tested-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
