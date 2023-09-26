Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027C37AE303
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjIZAkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:40:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E1109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:40:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so8016647a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695688806; x=1696293606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnEgEKAhGM5JWN8y/Tiqur2/djSzZqgbL2OPyciIbQ0=;
        b=f9/VlFzYGdX6Q31H9Wyps+y8Qw7eWoHJ0sa8CWXv2Q0GwTTHKduyxPgQIzY1FmzJyr
         0XWxrL2urYrfMOaUH9LLmapQks+J2rbDYODUh0tZJVcaAqdrn5IHcdLgfjO1yQ05eFoQ
         bl9COZT+u+5oKAxCcN4AdDXSnvbnhmg2Y0wWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695688806; x=1696293606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnEgEKAhGM5JWN8y/Tiqur2/djSzZqgbL2OPyciIbQ0=;
        b=QiASqgCHwrBz6GGw575XGScBT9g9DK10TnpPxAJkXB8zaQErGOq7HxIQp/uWmm9rAa
         k9K/z236Y4zhyVJ3ANhrTkaVCZ+XWbY3QPWVK4h+zPwWxULMv7hnIA/VK3PHe8PDPnG6
         oCXLCtGnhDVGJSHhmclq2S4FL9HkT8Wd8aCG06F145VwqMO9kfNtD0Md1Vk16LrRz8eg
         0W2QLL1J/KFAUr42SbAqG3OcWC/7DANQUoPysIUuZBqQYEzVUatMjOID56A+tfh9ut82
         8oa+Iti9vmqBm9OnCifs1AUJmCBknK1LirnXVFf0VkVfLD4vwy3VtzwRM/lm863o0gtk
         7fpg==
X-Gm-Message-State: AOJu0Yzblf2pI8QSkEH6z2PqLaOtxD8BjzDFJzJ5M+qFt5cdY8Gs94HR
        qjVXKkaKJvRIbh6KMZLW2b9+tZS5ZHgUFqrIqrxYCj24
X-Google-Smtp-Source: AGHT+IGO3/O3VGRw9aYw36ctfuvi+ghcby9yzaSKLleBQpdJTOllrK69UGoQlrYbyn9W0XjAteZigg==
X-Received: by 2002:a17:907:7627:b0:9ae:540c:90ef with SMTP id jy7-20020a170907762700b009ae540c90efmr7822239ejc.18.1695688806340;
        Mon, 25 Sep 2023 17:40:06 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id f12-20020a1709062c4c00b0099ca4f61a8bsm7048575ejh.92.2023.09.25.17.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 17:40:06 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so9029a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:40:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:405:35bf:7362 with SMTP id
 n16-20020a05600c3b9000b0040535bf7362mr54102wms.0.1695688785170; Mon, 25 Sep
 2023 17:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230906160505.2431857-1-dianders@chromium.org> <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
In-Reply-To: <20230906090246.v13.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Sep 2023 17:39:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
Message-ID: <CAD=FV=UBw1-9=LPUydewyOg8oL2WMG+ZCQ=PBpe0CiCs-ToWSg@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] arm64: smp: Remove dedicated wakeup IPI
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        philmd@linaro.org, samitolvanen@google.com,
        scott@os.amperecomputing.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Wed, Sep 6, 2023 at 9:06=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +void arch_send_wakeup_ipi(unsigned int cpu)
> +{
> +       /*
> +        * We use a scheduler IPI to wake the CPU as this avoids the need=
 for a
> +        * dedicated IPI and we can safely handle spurious scheduler IPIs=
.
> +        */
> +       arch_smp_send_reschedule(cpu);

I was backporting this to our ChromeOS kernels and our build test bot
noticed that arch_smp_send_reschedule() didn't exist in older kernels.
That's fine--I can always adjust this patch when backporting or
cherry-pick extra patches, but it made me wonder. Is there a reason
you chose to use arch_smp_send_reschedule() directly here instead of
smp_send_reschedule()? I guess the only difference is that you're
bypassing the tracing. Is that on purpose? Should we add a comment
about it, or change this to smp_send_reschedule()?

Thanks!

-Doug
