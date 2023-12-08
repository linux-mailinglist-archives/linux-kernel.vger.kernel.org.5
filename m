Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3280A81B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjLHQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjLHQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:05:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF476172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:05:35 -0800 (PST)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BADAA40A75
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702051533;
        bh=NPjAizr1MOai52nap908c7Q+sjbuL1SW7438n8FuRps=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CLeHnkjTEXizPKVW9PXMldAiB4zVUIgg5jwBu/dtxTdAdz23KCAmbPbdgJcR9boBp
         aF1gxUWYL27Kbcx1Pg92+KDd8whjvb9MLaPhIsRdDmgAZEr4ozU0Zn0lXwMkA3hPBF
         uQiqnpwIfF5+myiXNbenbYCl+2K/tUs5oaOrFOR+D3/4FvnlJVuyW8S46LBQc5Y4Jy
         DSR3AzqDXeicI4kyA2NI5VnP+jNB0k4PZaKgpbpxY0yYitRJ/Cnp+2W3hLcYBnR//M
         e1gU/Tqo0vsduQI/eIf/qjto+EdPqUiqcnWKK6mi5f95O/3TrhsRAXIEZGurFo0Hc2
         Fu7phetzZ45OQ==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50be6eae316so1617690e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702051533; x=1702656333;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPjAizr1MOai52nap908c7Q+sjbuL1SW7438n8FuRps=;
        b=ZqtjXpdWQ0bPaRvgCyMwLj8JztnjT9atdtlMXxjbwSgTS16RX2x4MROZ6f2DJlkgJW
         aWC+I857GhTksGSqXwp3LzXYDMRH6emHPLLqSWzDnst+UNmjgNezy03Q6iGUXpTM5950
         +33nYZbtxlVFIqYh8IuY/WxvP7JtinOLekk/wHOWK+3eyV/KkLVG9giLFJd53T6oVmRJ
         zSQ2QYKq4oUuEXG8wHip0H+774bcqTkOZnU5upyTvV3XW7Mr8LiPt+5REP8NXXlZyuHv
         CWAbNwGqZgwnUDE0WYZoHdRMhVAmOSFHMdr22X6EULYrpA9V1u/SAgWcE8Rs1dVGFYXV
         ryZg==
X-Gm-Message-State: AOJu0YyzMbD5cqiY7qahQWoEEG8IyT/pK0tiN5dW6IcKcF2WqhmhmbRL
        qjBqNtBwWspDLKo0kFwxcsSVyfqwQ2kTC5vkAFFiHjZYrXfMLCHYCRorVVf6rlH3sSUCxbpeN+a
        PABaOlJoAow/JSVty3HxfGkjvtI4ce0tlyqEObsx13lddLRmSfDXOiVfB1g==
X-Received: by 2002:a05:6512:4894:b0:50b:ef17:5136 with SMTP id eq20-20020a056512489400b0050bef175136mr42292lfb.154.1702051533070;
        Fri, 08 Dec 2023 08:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgfEA4LBbLEwJ04GKNCXCYVhgqscCJbjoiVfiXJNCGNQMCBQy0BVcPeUSngDtE9hH0oJFzO52hRcf04wYtCO4=
X-Received: by 2002:a05:6512:4894:b0:50b:ef17:5136 with SMTP id
 eq20-20020a056512489400b0050bef175136mr42276lfb.154.1702051532771; Fri, 08
 Dec 2023 08:05:32 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Dec 2023 08:05:31 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231201121410.95298-7-jeeheng.sia@starfivetech.com>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com> <20231201121410.95298-7-jeeheng.sia@starfivetech.com>
Mime-Version: 1.0
Date:   Fri, 8 Dec 2023 08:05:31 -0800
Message-ID: <CAJM55Z831ucY4QqPTR_0zJVB05UUT4W-3M0CGzvtyPo=AMD=Vw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzk@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de, conor@kernel.org,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, michal.simek@amd.com,
        michael.zhu@starfivetech.com, drew@beagleboard.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sia Jee Heng wrote:
> Add initial device tree for the StarFive JH8100 RISC-V SoC.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

Looks good to me, thanks.

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
