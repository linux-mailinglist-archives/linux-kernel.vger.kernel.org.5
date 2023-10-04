Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F17B8DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbjJDUNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJDUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:13:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D0C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:13:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso284254a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696450380; x=1697055180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Iuh7RyMhUNLXRe/si243CkpiKKa4NFeV88G+Kg84I=;
        b=hBNSAQWS3MpgIgZbV1FfnRjIcclJfXiQ/mHiyAUar1x+j5oYhhB269QSys+iwCx8A4
         np9l8Hu7EE1pjVZcBKPMJ9N14B3D7A3UtNxVcc6tDUKIqbQs44dAoIHFe0pCKukhq0qi
         9OlS1q++CqWpA2Dcz606FQnMW+SGPdD+VJKvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450380; x=1697055180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/Iuh7RyMhUNLXRe/si243CkpiKKa4NFeV88G+Kg84I=;
        b=KNyNI+LhqDb0su1180JoyFf6QoyiRXJxoWMb5Ydx7bI/BWgAmA4oa48ilg3/XOunsC
         vr0RoEP8jpmuBnpDhVxrUvmHnMUcVhE7I7pAt9qXle7dvgPZUBkLeGKo1M+f0oYP1mha
         3By2+7IZtf2YRTVnsSJLs6jsVs5CGDTnLDLsD7KXtmNelvD1Z/rv9pVpu2aIeIhIo/Jr
         L+c15sGsqmdCTJt9Om7NBz6TxQfJv9ev0GhVRtvvIcwRaPTP2okvfWg6Aq1N5bzEmIjy
         tU1/iBkhA2eYVnc/hNHOoZRF1yjkUSMPeTOrxeS6ad/Q/f1Y48my8IwgRjbrEJm1D4dK
         ByHw==
X-Gm-Message-State: AOJu0YzWRtPbiCUHp4FMsWMhwTjsN6p+QZKbYLyU9vTy7opq9GxqzesH
        zcJMRwBGFwcUBVPm9cDUwYk9ODPOyyosflFnPHkJbQ==
X-Google-Smtp-Source: AGHT+IGJkhSpziolowSGAJiE+hnbPKwYAVgvdWTLKkpE5ChVVuc2RfEyWDL5s9y8ug5wk1Cr2HlBIQ==
X-Received: by 2002:aa7:c253:0:b0:532:c690:92bf with SMTP id y19-20020aa7c253000000b00532c69092bfmr2841325edo.28.1696450380515;
        Wed, 04 Oct 2023 13:13:00 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7d0c4000000b00530ccd180a3sm334455edo.97.2023.10.04.13.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:12:58 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so268128a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:12:57 -0700 (PDT)
X-Received: by 2002:aa7:d84d:0:b0:530:9d23:9f27 with SMTP id
 f13-20020aa7d84d000000b005309d239f27mr2709237eds.31.1696450377468; Wed, 04
 Oct 2023 13:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZR2U4DLycLT5xFH6@gmail.com> <20231004192404.31733-1-ubizjak@gmail.com>
 <CAHk-=wjuRGzhuETLYDoi4hM6RAxHVL0ptuRb3TH-od+348Y8zA@mail.gmail.com> <CAFULd4YRHmQVnwaORm7=7kUs7DYG7SfwdTXAitDt=bxiMU5AoQ@mail.gmail.com>
In-Reply-To: <CAFULd4YRHmQVnwaORm7=7kUs7DYG7SfwdTXAitDt=bxiMU5AoQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 13:12:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKc9UCsrZ6sNRb=T2Yhy4Dhr=LUBi9r-gPhfwCmuOeZA@mail.gmail.com>
Message-ID: <CAHk-=whKc9UCsrZ6sNRb=T2Yhy4Dhr=LUBi9r-gPhfwCmuOeZA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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

On Wed, 4 Oct 2023 at 13:08, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> You get a store forwarding stall when you write a bigger operand to
> memory and then read part of it, if the smaller part doesn't start at
> the same address.

I don't think that has been true for over a decade now.

Afaik, any half-way modern Intel and AMD cores will forward any fully
contained load.

The whole "same address" was a P4 thing, iirc.

          Linus
