Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C707B0D35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjI0UPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0UPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:15:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA5114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:15:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77574c2cffdso96537885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695845744; x=1696450544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIIkMitTrNSDHIAlH1uq6vJrTxiNPJMdVtHBFBBDPlc=;
        b=ILCIx6xmz2azLwb8GDuCgY1udcz441/rPk8b1yRr6y2/jUPq9kaIcTQtiUpi/PoQBr
         Jiy7eutQj1tKuMGWCtBM1fvvFE37pHhiqpOlP0drdbTZefyQA/ZVtLZQFjTpn/Dt6xs+
         SR5TlWGMVMckSK9CGysg7BiS7w5/aH8EM4SRtm1XGhrwkmK6OItfrkwX8ksXlnBIdi+R
         74jaEDygDzGDj3hlIRT2HV53XOnelh1MwDKpvS+h/k5OBpXhIw5uHcateE6Y6Vn/SUbb
         g0TSebPomBnQN5uXSAXsW9ZDHi/GdsEfeLnkcmg/Gm5fGLX2uyhWUPtqZLPnh93g0Ygu
         k7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845744; x=1696450544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIIkMitTrNSDHIAlH1uq6vJrTxiNPJMdVtHBFBBDPlc=;
        b=slLVU4gmVWV1M9ednhRXjfUDp7YIARCzepbB2+92aO7JAKzace9ZO0oLt1Hg8pzNHG
         kMNWlKK1M1vrr+WrWAJer/akLr48bgku6Ojo9zhCAiGs5PiNSqDM8aE7eQMjlKXMpHgX
         K0M0QcXKiR1Y/pQEDgjrmlMX9z32LE1FXnrVVtltUgTBXfoHrhEZBBW+uu87mQ2cXP41
         q69xOatmcP9UEfD/5YGu9FqX1PjAQZ/BtpvBxGaZgZJSQw2zSyPINussNzntngEWsMWX
         3RuVJ7xFiJRWGQHZT4sOGGFO0IhG54mxVCQiZuN2cF7y3X+gjN364dXR1Ef2SXikvaNf
         6N5g==
X-Gm-Message-State: AOJu0YzStMSxv9vKN5VmEj3qiKz8fCBMUBLcWL7Mm8eMakWQd33Y1KN+
        bFFf5ngVJQb3QMnJDCPWihXaxA==
X-Google-Smtp-Source: AGHT+IGX1XnfSRNAReG5q04YfQKGoh+0IG7R+vPK7j1BQpXrbkx9xTpzlBHu3vjoMSNDJGjhfw3g1g==
X-Received: by 2002:a05:620a:461e:b0:773:ca5c:4556 with SMTP id br30-20020a05620a461e00b00773ca5c4556mr3157567qkb.10.1695845744297;
        Wed, 27 Sep 2023 13:15:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:40d8:421c:60ef:36d5? ([2600:1700:2000:b002:40d8:421c:60ef:36d5])
        by smtp.gmail.com with ESMTPSA id pi32-20020a05620a37a000b0076dacd14484sm5715366qkn.83.2023.09.27.13.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:15:43 -0700 (PDT)
Message-ID: <23935a29-0138-49f8-9efd-ea678a41c9c5@sifive.com>
Date:   Wed, 27 Sep 2023 15:15:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 12:00 PM, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

