Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD977E37E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbjHPOZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343570AbjHPOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:24:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A5B1999
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:24:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26b4a9205e3so1991650a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692195894; x=1692800694;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1WGFmUFQbZk1gRHuf5U7fgkfS57PmP0h28a+2hxBjY=;
        b=TyRLJKa3FRbKLMywDuW3EZSOaSUQIruIgQtIvZ92NVMkkM5rR/MwpfvAA8FjAtDW4X
         yNe+1P2ChHs7RznxBsVp1jRBIhMlMJaPFj/YFwYPdKjnykvgOY003h21AolAjtrbnJQl
         t2LL6KbDixm30xvFehhjYS2JBej485WINZu8sMI4JM3HA9D04PwsBiK2o4I4Z3T0XKGZ
         tIAoq0VztDy1Z74F3iYcV+RZoKjyEvKlyeT/kaRCqH/CZ0oXtmuWc3Ms+niqCoYP+wpW
         EpniaXrcdWyDiv0fI4ZWpnFRtVE7OqQYhWpzndgNYGSFRuk2DmioWCZ8rbZN2gNBzd8Y
         uK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195894; x=1692800694;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1WGFmUFQbZk1gRHuf5U7fgkfS57PmP0h28a+2hxBjY=;
        b=h5HE6Za4tWkHW82kEwXV4UFFRYt4vQqrfsrbt5Dh9xmcfdhY9IBp3qRYdqUTN3+YCP
         vzFTLZQI+/AudydlGfBYWSHASsVnlTwUMCrIkETBX2A+WQIEETXZMioB5UN1zK8/ZGQw
         1MS+nxiSk4BPpUZkoYLnnw/9zANVc0ASgJoqueeplyEf6VVq7b/NPFuQz0+Zbg4qabs7
         nFdyhMYj36FNVwrvt5tnRLwnFaGq7qSeIVXOp8rIdBQzb1EXT5Ns6HTRYTr0WwbPT0o5
         plcL/Zj++PqQeZHW99vOKWmq5Q19goQl3TdH64WRmyHD5jCVpItexIuIU8/oWVD4DVae
         IExw==
X-Gm-Message-State: AOJu0YyQdAGP/BtR+ZpqjJoZVwOxcctBrpXAKa7+dxG8DA55P9gAegWf
        brWZi2V0dcS4HRbttbaqIj2VGg==
X-Google-Smtp-Source: AGHT+IEhASnnPuidtpatB9VyiPbNp+Q1/lOfH92sBonVT/ZVG3ZNut3Q7QzPxS1bxTjDaUN5y/MjHg==
X-Received: by 2002:a17:90b:681:b0:268:15dd:c5c7 with SMTP id m1-20020a17090b068100b0026815ddc5c7mr1328421pjz.40.1692195893982;
        Wed, 16 Aug 2023 07:24:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id fs11-20020a17090af28b00b00263987a50fcsm13247424pjb.22.2023.08.16.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:24:53 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:24:53 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Aug 2023 07:24:51 PDT (-0700)
Subject:     Re: [PATCH 0/2] Misc RISC-V timer driver improvements
In-Reply-To: <20230710131902.1459180-1-apatel@ventanamicro.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        atishp@atishpatra.org, ajones@ventanamicro.com,
        sunilvl@ventanamicro.com, Conor Dooley <conor@kernel.org>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-5adf3416-5d04-4a55-a6bb-1fbe921f9f48@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 06:19:00 PDT (-0700), apatel@ventanamicro.com wrote:
> This series does two improvements to the RISC-V timer driver:
> 1) Keep timer interrupt enable state in-sync with interrupt subsystem
> 2) Increase rating of clock event device when Sstc is available
>
> These patches can also be found in the riscv_timer_imp_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (2):
>   clocksource: timer-riscv: Don't enable/disable timer interrupt
>   clocksource: timer-riscv: Increase rating of clock_event_device for
>     Sstc
>
>  drivers/clocksource/timer-riscv.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case the clock folks want to pick these up.  Otherwise I'll look more 
closely and take them via the RISC-V tree.  Thanks!
