Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C67AC44A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjIWSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjIWSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:05:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE9136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:05:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50435a9f800so4628949e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695492317; x=1696097117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcipxSNQY08wl7UPw3CDMFJCTeN6Z65jpzmRv2y1p7Y=;
        b=Yb0m3ZNueVYWCDBBP0RdYirqLddPCZX0l+BK8D2hQljNkocxGFmwA5TZD5QEAtk9Sh
         IjAirY78b/pd7KK46EDlhMN+IkuHASg55baBzueEdCvgzIFPaO294zkE8vZs3yi1wxY7
         lfRwopxyMQG4s01cBPk1gTSnv59H8AnLB0k48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492317; x=1696097117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcipxSNQY08wl7UPw3CDMFJCTeN6Z65jpzmRv2y1p7Y=;
        b=eiim2bavbwUVtvXLtHYAXmlcLEtUMxhu97nct0lGEm4KAFn/UQg20fGNZsOClLXkqJ
         PKC6zIy8UvtjwtaedM2etVxNa7UzGiLnWzsBpn/e97OxJJuq9X5qNWNuoVVYo7D60O50
         Dg248AujcgH1bLz5MUTYR4lI3nrG19ZBysFGhs2tUz7apL5pGIh6yagsZDiBh8wYPpsy
         kYqPRAr17BNnqvxJzJO6KaXtBH9picX2TrToMj17QWQq7gJUW/kaUK2N8/1+VZwYnC8v
         oo7LRxR2XANt7427V1pWnFIo0hjKlmT+8UyCLPUrRqobK3IcIArSoIAvgXuc2ee8z4o8
         RnaA==
X-Gm-Message-State: AOJu0YxYFLQsJtSLQdNWo4YfzJTiizyQECdRrW0jXovyJsKYpBNKvTD4
        g3KIRnQzeUSNG2nVk3rhY39+2NS5r4gS85nC+Whq0rd8
X-Google-Smtp-Source: AGHT+IGoSaS7BX/qUQbrVdnUjXIIIuKa8sG4zhokWkZbK0rXwHQK+wKFNLssPBk058gymHl4pBTj+Q==
X-Received: by 2002:a19:2d56:0:b0:500:9ab8:b790 with SMTP id t22-20020a192d56000000b005009ab8b790mr1863626lft.60.1695492317272;
        Sat, 23 Sep 2023 11:05:17 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v25-20020a197419000000b004fb9c625b4asm1160064lfe.210.2023.09.23.11.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:05:16 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50435a9f800so4628868e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:05:15 -0700 (PDT)
X-Received: by 2002:ac2:4bcd:0:b0:504:4165:54c1 with SMTP id
 o13-20020ac24bcd000000b00504416554c1mr2774098lfq.7.1695492315346; Sat, 23 Sep
 2023 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook> <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <202309222034.F2B777F55@keescook>
In-Reply-To: <202309222034.F2B777F55@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 11:04:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
Message-ID: <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 20:49, Kees Cook <keescook@chromium.org> wrote:
>
> 2) __cplusplus is relatively common in UAPI headers already:
>    $ git grep __cplusplus -- include/uapi | wc -l
>    58

Look a bit closer.

Most of those - by far - is for the usual

  #if defined(__cplusplus)
  extern "C" {
  #endif

pattern. IOW, it's explicitly not different code, but telling the C++
compiler that "this is C code".

So this new #ifdef is an ugly new pattern of "do totally different
things for C++".

Apparently required, but very ugly nonetheless.

               Linus
