Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC87B2273
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjI1Qdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1Qdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:33:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFB195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:33:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65afae9e51fso57253636d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695918819; x=1696523619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kI7xhtv1up4cUf/uSqI2zpGGqMta0B7Fjm2QJg7v1Ho=;
        b=DUtuTyHG0b6gmTSG3lNDKW9OQox4Bl1tdDNCetGIngwxdMeouEQh6VyZlIrDXo4ZBB
         JCTTSXc+Qrf2mRF90uiWKgE8YB6ExCrYQXxOifpMCWz0rJ9IiBeudMXGEhLZEifByqHH
         Te3vU0zzyFkgaQ8W1C3ls/FtY5meHMI/L5wOow10tzlCHvY4TJ3VXLDIYW088uO0ks+0
         YGTuDi0xvL9lQfkwgGYTp63RRpxy0oLAp1AqqSHSCW6/4JMcYJFPDCmrRYIsyOB3BeHw
         R5GDKLckZQqbolCvqISCX3BgOJYWThHtQuTODgon440rqcHYhkyyKKRJK5eJ/HQ60zmC
         G89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918819; x=1696523619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kI7xhtv1up4cUf/uSqI2zpGGqMta0B7Fjm2QJg7v1Ho=;
        b=HqYFhk3pqDYycDhISho9KrGNCmx5o5L65qyoREIdDwyaLOBMHcolXgATWE8Fwa0kqk
         ggqYnNbqHMMX1t1A8HfevPdxMYS7qFk5bY9u/VxqPu5dGSr3vm2ZJo6JYaClbCSY7GN9
         YVy0p9LLbessnkDT+6/bIcySiamVcKrQahoW8PPfhPvBCUaZnugmWoampnPBSn9KcMC/
         L0Z7fPZP0QzJjYksqy88kYSdKWkvX17TOcFEACfC2wHgwrjKeT1nai/yoA+Fbqa62jsG
         8x55AtqdZ/FLEEuMUaD2c+C2E4zDSuEpTfwoDkLeFbMNy6kKn1i2IghIBd6Dx/3o0P0h
         p49w==
X-Gm-Message-State: AOJu0Yy/ZmAr20GAsmUyFIX3bgTfYnhrFjYUg+JiO9hGqfrUpdnz0vOx
        wSNk+GAofUsBwQHUPQw3pn6BPA==
X-Google-Smtp-Source: AGHT+IEJQKbMz2k1XTUOPKvzbFD6l40vnHDCsN9RGiWm/EBpa2E3iae718GdN0kO/vCFkGt/QgVjjg==
X-Received: by 2002:a0c:dd87:0:b0:658:a043:376b with SMTP id v7-20020a0cdd87000000b00658a043376bmr1628798qvk.8.1695918819251;
        Thu, 28 Sep 2023 09:33:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:5086:8bae:a4b0:bdad? ([2600:1700:2000:b002:5086:8bae:a4b0:bdad])
        by smtp.gmail.com with ESMTPSA id x18-20020a0cb212000000b0064733ac9a9dsm6755734qvd.122.2023.09.28.09.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 09:33:38 -0700 (PDT)
Message-ID: <5f762ab8-c4d3-4ccb-af77-10c2692e5ec2@sifive.com>
Date:   Thu, 28 Sep 2023 11:33:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock_event
 rating
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4e4bf02b-2264-491e-9b71-ae3b5ad7fc39@sifive.com>
 <CA+V-a8sSmy-UNwsB3b_yuETTRGS2fBWvS4sTMaVghTWm6oUb+Q@mail.gmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CA+V-a8sSmy-UNwsB3b_yuETTRGS2fBWvS4sTMaVghTWm6oUb+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On 2023-09-28 11:18 AM, Lad, Prabhakar wrote:
> On Thu, Sep 28, 2023 at 5:04 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> On 2023-09-28 5:45 AM, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Renesas RZ/Five SoC has OSTM blocks which can be used for clock_event and
>>> clocksource [0]. The clock_event rating for the OSTM is set 300 but
>>> whereas the rating for riscv-timer clock_event is set to 100 due to which
>>> the kernel is choosing OSTM for clock_event.
>>>
>>> As riscv-timer is much more efficient than MMIO clock_event, increase the
>>> rating to 400 so that the kernel prefers riscv-timer over the MMIO based
>>> clock_event.
>>
>> This is only true if you have the Sstc extension and can set stimecmp directly.
>> Otherwise you have the overhead of an SBI call, which is going to be much higher
>> than an MMIO write. So the rating should depend on Sstc, as in this patch:
>>
>> https://lore.kernel.org/linux-riscv/20230710131902.1459180-3-apatel@ventanamicro.com/
>>
> Thank you for the pointer. Do you know any tool/util which I can use
> to make comparisons?

To measure the latency of the trap to M-mode when receiving the timer interrupt,
you could use the timerlat tracer. This computes the delta between the
programmed timestamp, and when the IRQ is actually handled.

To measure the latency of setting the timer, you could add code to compute the
duration of the set_next_event functions. (min_delta_ns won't tell you anything
because set_next_event never fails.)

Regards,
Samuel

