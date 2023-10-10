Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56017C038A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjJJSiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJJSiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:38:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B37A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:38:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5033918c09eso7611891e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696963081; x=1697567881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhSNL7cMHw4PLYbCPBTl1LNULSkwojpVoNBfxMTdOrU=;
        b=KvHPqaDBTif73ykZWtb1IfGgNecFk+27EonAEWvzrh3BBA1t015n4+st9fWO2PWZOC
         k5H3cYmlGD9F66sAm4GvU+q1UYp3YEQHBgMe1nbdMRH/hz/6pZ0G1h0zFyJFofRDxaF2
         Ma+T5zXqa0og9ipI5xY5FM00MF7EgPJ9mdhCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963081; x=1697567881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhSNL7cMHw4PLYbCPBTl1LNULSkwojpVoNBfxMTdOrU=;
        b=uBFvhKKvYgm8W9L584K6Ozv6fStKM3nrx+4CZK270xb0vPNY+FMYXI20UuUl5cyTso
         7Cxl1DShWiQ/z8JpDtV4D6sxk8iKEuHxh5a9ZcUTRCRjhPyxFexJbgWxcjSBK1Q/V7mJ
         +7eWGsLK4atmAPRM4i51N65No7EeeBsVV9r6S+kX6+DGqshjZqvcUgiyGzWyZu4yZH0J
         Q26JJSXSCiHm9JilSVP19SdwWytB5yUYn5SaZcEBQ4rBhAyXyU/cujYD+34WktdeKKNZ
         pJWCBpMKuo01lwHyTR2+n9bbpSp2dTpLMf92DVLhj9dojMUoEASiw/K5VCGm2bTZL70j
         bK0A==
X-Gm-Message-State: AOJu0YxLSf242kMuh94gP6wgSQwIjdX8wUEFSfG5828P3ec0Ip9dxj6s
        t2L8J5O1Ih1qk/A2kp0ucpJH6JgTjzW54GujKcOiHYLJ
X-Google-Smtp-Source: AGHT+IE70KHJGkM61IQOOxsyPrzfc4o4Rj1mFU8MQZumQuyLnwifjoR5a5hdTBnrudqn4d0dovn8xg==
X-Received: by 2002:a05:6512:3a83:b0:505:7360:6023 with SMTP id q3-20020a0565123a8300b0050573606023mr20036977lfu.39.1696963081028;
        Tue, 10 Oct 2023 11:38:01 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b0050296ee046csm1924792lfi.69.2023.10.10.11.38.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:38:00 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5033918c09eso7611865e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:38:00 -0700 (PDT)
X-Received: by 2002:a19:ad4b:0:b0:503:182e:1def with SMTP id
 s11-20020a19ad4b000000b00503182e1defmr15121375lfd.69.1696963080129; Tue, 10
 Oct 2023 11:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
In-Reply-To: <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Oct 2023 11:37:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
Message-ID: <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 11:22, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Please note that besides propagation of the addition into address, the
> patch also exposes memory load to the compiler, with the anticipation
> that the compiler CSEs the load from this_cpu_off from eventual
> multiple addresses. For this to work, we have to get rid of the asms.

I actually checked that the inline asm gets combined, the same way the
this_cpu_read_stable cases do (which we use for 'current').

              Linus
