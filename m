Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A27570D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGRAT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRAT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:19:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC1188
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:19:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99364ae9596so725556566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689639594; x=1692231594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lx28ElhK+IZcw5jSy5POKWFxZtYmjsFabIngYCTFvk=;
        b=C/mqU3wkxCjYbpwFwM3opgk6S5XQ7hxterSz2KJjooPfNujlkNp+Yk1vYrN9FpKlr/
         GaV9nwr+Z4ePewYMgRcu1u/K/RFGMsK+WHitO0Luc/Rky7CRp9agEXHfPUOI0/C1LIWa
         BDYul3ygNww7i1pe6SclVBcLoHdZ+rBsMVrVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689639594; x=1692231594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lx28ElhK+IZcw5jSy5POKWFxZtYmjsFabIngYCTFvk=;
        b=aF16OxObf7JnV7DsGDCxKOTpRou4pWpBgVhBy2VLVbapn1qary2Fue0apl87wU8dqr
         6o/Du03nxwf1OWNtuV1N5IOfzbr7Sz+uUzbTvjar9o3PKaeU0QGPVrSzvaonAboN+1ta
         YTBEw2aSpbk4TrFHs/ZtQpFZxRMDn+5ACcvbbCNj/SbzK/PyWVxTUrWAGBW3/uk3VZ9c
         bMqSNTCLbzAWbbnDddEDZQIlvU/udqGEjXS5clL3yoICprzct3+bx9RdILr+3cY/eR/z
         16G7hsMGsfqnkxnfLx5v1FCK2vXvZBq/YtNIoM5zF2QF+OiZwN+VyTmzLC4HcnFcb8ay
         kq5w==
X-Gm-Message-State: ABy/qLbVi0eUMQoBk7+CxsZUxtBr5yUO0oEj+fHj0L7KWR13tHvXrBw8
        dPEIX4f/DCaai8Tqj0pOOTncNCzFEZ+TGz8Uh+4IAQ==
X-Google-Smtp-Source: APBJJlF5SESR7IUKswSze7l66dFbj/615NRgH0ZSugpYFQROeoiMTlrw5dVLnFMcYzuvJc6Ofk6HvA==
X-Received: by 2002:a17:907:3fa8:b0:988:9621:d85f with SMTP id hr40-20020a1709073fa800b009889621d85fmr13342881ejc.58.1689639593864;
        Mon, 17 Jul 2023 17:19:53 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906828b00b0098860721959sm276408ejx.198.2023.07.17.17.19.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 17:19:50 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so7270698a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:19:50 -0700 (PDT)
X-Received: by 2002:aa7:c75a:0:b0:51e:1656:bb24 with SMTP id
 c26-20020aa7c75a000000b0051e1656bb24mr11289223eds.26.1689639590195; Mon, 17
 Jul 2023 17:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230717223049.327865981@linutronix.de> <20230717223225.515238528@linutronix.de>
In-Reply-To: <20230717223225.515238528@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jul 2023 17:19:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com>
Message-ID: <CAHk-=wh9sDpbCPCekRr-fgWYz=9xa0_BOkEa+5vOr9Co-fNhrQ@mail.gmail.com>
Subject: Re: [patch 41/58] x86/apic: Add max_apic_id member
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So all of your patches make sense to me, but the whole apic_flat case
confuses me.

On Mon, 17 Jul 2023 at 16:15, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -94,6 +94,7 @@ static struct apic apic_flat __ro_after_
>         .cpu_present_to_apicid          = default_cpu_present_to_apicid,
>         .phys_pkg_id                    = flat_phys_pkg_id,
>
> +       .max_apic_id                    = 0xFE,
>         .get_apic_id                    = flat_get_apic_id,
>         .set_apic_id                    = set_apic_id,

flat_send_IPI_mask() can only deal with a single word mask. How the
heck can the max apic ID be more than 64?

I'm probably very confused.

Which is what the APIC code would do to anybody, which is why I'm
cheering your patch series on despite (or maybe _because_) it confuses
me.

            Linus
