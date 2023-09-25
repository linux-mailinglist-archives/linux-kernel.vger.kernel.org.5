Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF787AD551
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjIYKFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjIYKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:04:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2791E62
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:03:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so799940666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636190; x=1696240990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzA8h/cVpMYyOGcQ2DeSX7ASLOF+y6j7eWrYzh5qnnI=;
        b=MXYK4r7skn98DIIUWKrNl/9o+7rgW6Ot+1xnTIbn+Nnq71jTyL6Bmfm/bB+IlH2k55
         vWxpiqNtnM7KzOYxv7jl/gSvjef0y5A19HPOsPzki7e1bWZUfeU22iM0RDf8d6ZjjGxR
         s8acebLSuWqZZWNkwrAy5vTHYI0M5AzdgANUtMHGHplJs3C7gQcl5DaVpHA4+nCUS2yg
         dos2OKH0PUXyc0YTNzpS8nDVSo3NaaXtOdfw++oscLYMkGo65sMwUytPWN+TYoII0hTG
         ZrCTaOEWRiUpXHKcjCR/UgsZQk5Y/cWwolxc/NLLrVAK9KhO5ZgGys/WpuwyYAKSnRyD
         kU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636190; x=1696240990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzA8h/cVpMYyOGcQ2DeSX7ASLOF+y6j7eWrYzh5qnnI=;
        b=TayL9S+bunrjjt12PnoZF8eyuTEEQEIluPWKzFx80U2YMP1UEEHXGVt+t3HhzBAKwE
         Nj8tROGZ+AIhIRMhxosUuxxMkqOmtUC/rQMMrfwltqkN1+P6YIdPHAQFEOwqqVAdKYD5
         Rli8QswjHK1eejoxN0BEg9nFUqoAebD7aWbAsi5AHDQ56t7tj1RHn1WTfY74WRe4Kro3
         tqkLEgwcE8dJwUrZ32i3BxDmeHJ43jHR0i6OM0Kg4n3mi2X40Co7oqcgSlAFtdeTNSnS
         LF2VRkFIRSD3FbotbzTLchL4A4coUHgsYs9bZr6X4oEhZPvEDMPjNfEFsPHo2is0717y
         fJUA==
X-Gm-Message-State: AOJu0Yy2cam9v9DLDtWYacaTtyOkxNLWc9ZPNoEmBlIj8/JbUqlKSO96
        hf6ZjpmOrFIr5UCQnof9gl3rDtqqy88=
X-Google-Smtp-Source: AGHT+IHC8mABIgDfXmkQ3f0ZLCEbMN55xpbkplGI2a0iCl0YNq4af3v/0niAcIPc2FVlyAnIHkm3Mw==
X-Received: by 2002:a17:906:ae81:b0:9ae:961a:de7f with SMTP id md1-20020a170906ae8100b009ae961ade7fmr5921921ejb.30.1695636190171;
        Mon, 25 Sep 2023 03:03:10 -0700 (PDT)
Received: from gmail.com (195-38-113-94.pool.digikabel.hu. [195.38.113.94])
        by smtp.gmail.com with ESMTPSA id fu22-20020a170907b01600b009a1a5a7ebacsm4785035ejc.201.2023.09.25.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:03:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 25 Sep 2023 12:03:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRFa267Aa9Xs6fEF@gmail.com>
References: <20230925042302.593317-1-aik@amd.com>
 <ZRFHtCCsL4kKajKF@gmail.com>
 <53e60186-674f-449b-a99f-01cd759c65de@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e60186-674f-449b-a99f-01cd759c65de@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Kardashevskiy <aik@amd.com> wrote:

> > That makes this workaround to reduce nesting a lot easier to read & maintain in the 
> > longer run.
> 
> Currently it is:
> 
> #define rdmsr(msr, low, high)
> 
> Will the below signature do?
> 
> #define rdmsr_GHCB(msr, low, high, ghcb, ctxt) {( \
> 	int __ret; \
> 	ghcb_set_rcx((ghcb), (msr)); \
> 	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0); \
> 	if (__ret = ES_OK) { \
> 		low = (ghcb)->save.rax; \
> 		high = (ghcb)->save.rdx; \
> 	} \
> 	__ret; )}

Sounds about right. Small nit: please prettify the macro a bit for readability,
ie. something like:

#define rdmsr_safe_GHCB(msr, low, high, ghcb, ctxt) {(				\
	int __ret;								\
										\
	ghcb_set_rcx((ghcb), (msr));						\
	__ret = sev_es_ghcb_hv_call((ghcb), (ctxt), SVM_EXIT_MSR, 0, 0);	\
	if (__ret = ES_OK) {							\
		low  = (ghcb)->save.rax;					\
		high = (ghcb)->save.rdx;					\
	}									\
	__ret; )}


> rdmsr() does not return a value but rdmsr_GHCB() has to, can even make it
> static inline function, should I?

It's a bit like rdmsr_safe()? My above naming reflects this.

I'd keep it a CPP macro, it's simple enough, the other MSR accessors are doing
it too, and to make sure this isn't instrumented the wrong way...

Thanks,

	Ingo
