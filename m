Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B878C281
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjH2Knf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjH2KnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:43:03 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA819F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:43:01 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-48f856b04b6so1216295e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305780; x=1693910580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=if6AepQI7oElnZuMvLx21VEEZIt+xpKV5k6pCG2vAcQ=;
        b=sxW/8MKsFgaQv6oj2DYOdFIqJMY7vCRNz2YrVrNVE5kuOoFU5tK3Z35GnM7S9W6mG/
         zHcRLCRPAn0NBss87wYnpzc6Q+PA5zuVTRKTyDuF6gWyaLsBE2Kfqj8FulddxOlr4FmQ
         X8LZj/lWi1e7rThqBCQDDKVFwL7eX+R3Xvx6sY5wORrO+eQfkmwPLpSAUupoS57kQ93+
         9gzqhkHMjd0Ttr7xEMqAIizl35CiZwvCaPim2px7QeCTFUzhAp4fyJnUinAVSwrcXKIJ
         WN3BLLGHzMIKQQw+qV4+YSx5AJMUBBkrfh0X0moPV01siFJMXs622Wttsaeoil2iYy/I
         Mklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305780; x=1693910580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if6AepQI7oElnZuMvLx21VEEZIt+xpKV5k6pCG2vAcQ=;
        b=KGlarPZQ3uOO7APPa3/JrAYWa86J/O8JfoKpssrCxVxWDfchFrCZWR8k3GqFWL1C1M
         Jr53xU4ZPuDP3W3OAOC41Zuk93Lf1obTc4U5FYsjnbUgvuPrBU6YkYj7Qw9vbVdZM2Ig
         0By+S8e0nZhCDVcJrnrZEepo2WF3GvmXFrazhzIWB17OVKdr3zSbxLWsGZERVasrpTS9
         N5McNA8y986nP0ImmnWX8qCOa5q3qTXy+KW9B4RYuUupOXaRFhNzbsniwPNct3MywCu8
         9l+Wvz4Fa1Sxt2tuFey/agXIgzza/BTSjsXoQ2SwuGaOZdnV1xRpJhmo3qLOQp+z47P+
         OvPA==
X-Gm-Message-State: AOJu0YzU4Z8XhWGLCKkgWtnv4b+ZLVNGyMMvMZC4JvGHTl+2o3TEBFE+
        3wRpKozV9HCwGnZ0NdGaGcUob06fd5U7yI4+NR9gsQ==
X-Google-Smtp-Source: AGHT+IEPn80gj3WtM50v1h2lnAs5LtX1xABHIUxfXdo+y4pMuPPWvecGOP6nMiBOi3f6/P/CijM2bLXL3VVSMPVwGkE=
X-Received: by 2002:a05:6102:3027:b0:44d:6320:b713 with SMTP id
 v7-20020a056102302700b0044d6320b713mr12795980vsa.0.1693305780098; Tue, 29 Aug
 2023 03:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
In-Reply-To: <20230824083012.v11.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:12:49 +0530
Message-ID: <CAFA6WYPV2GWP97xaE_Mx3vUNF_xUvmsedEHr8LbJLQ+LWK-YJw@mail.gmail.com>
Subject: Re: [PATCH v11 5/6] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP
 should try for NMI
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
> handled as NMI. They are very simple and everything in them is
> NMI-safe. Mark them as things to use NMI for if NMI is available.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> I don't actually have any good way to test/validate this patch. It's
> added to the series at Mark's request.
>
> (no changes since v10)
>
> Changes in v10:
> - ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.
>
>  arch/arm64/kernel/smp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index c8896cbc5327..4566934aaf9f 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -946,6 +946,8 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>                 return false;
>
>         switch (ipi) {
> +       case IPI_CPU_STOP:
> +       case IPI_CPU_CRASH_STOP:
>         case IPI_CPU_BACKTRACE:
>                 return true;
>         default:
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
