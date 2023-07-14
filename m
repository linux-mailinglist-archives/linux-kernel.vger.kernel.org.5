Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423F753121
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjGNF23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjGNF20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:28:26 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3921BFA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:28:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cad89b0d35cso1454982276.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1689312504; x=1691904504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFEjZXU3eSdRPNIXfyXM5z+iMQpziRAe96oQZyCPSwU=;
        b=PIcINIE7B3KCORiu+jwYAfyerDDtgsIlXu3t6O8YLprAwl7lcdjrGfRggkgqFK5TFw
         z2o4oLDtF8jhxZcU8+YMyFUwtei8PBoBXl9B1AmQakS551FlD24ZxV9czElWGwbZeCiF
         olzxTqQUr2AAbakkmwYbfmRIg5QLSrnDm1aiESeM2rv1L9AJNLqRuPFP6IQ8zZQdtanD
         uASvbtd9m1rQbWVSszCorK6Kyoz5uj1VqJ58AcCBEqoN+mnSFDxngTxI5ab4+/fnU48M
         DCwl7F67wv043k50515erRto+rn2TZcy5swlftLPmuwwSXWHx5Yv7s2Cq+asAaRtnkap
         7Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689312504; x=1691904504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFEjZXU3eSdRPNIXfyXM5z+iMQpziRAe96oQZyCPSwU=;
        b=EWYhJnh3ROn6jrb+5UZmTs2BlgsO9ydl59rOH84TwDrRqyu52sj1iW1tUJ39L82jA0
         9OKpN6tXpXvdbUj9sXBV5WB5Nv0yQ3gfZMxLsOAuhRH8/YwmKN+T9wBW8g+Aepm1hDtr
         Op8SkzFOm/xqIzkkusgYr2LIjrMZcn6flXxJaf51EA/12Xq+wMLlvkWwG5Px+oXaJru0
         C2aGM3XNvEDZYZYnaScJ0JQ5yv8T36U/M21AsGQtEqgEpEFX+iut2Yjmw5KRA94A7CsX
         Vl++qS1iMPW6r3w5dSm9/JhKw/w9EZicXOu61ULkItI57SLXpVJSMs1Ddeh9umY3+Qxx
         SIpw==
X-Gm-Message-State: ABy/qLYbQ66jnMXfywvOcrNZnjMly1E7AMXStRzsHLXqiWvj2fGkKVtE
        CKhEQWr9aDtygPMjv9wsONST42yivA/ULMluhz9FvQ==
X-Google-Smtp-Source: APBJJlEaiU/h7ySqTpivDQRsTd9uubAuwpwPzJ8MHaA57MOI8Wnpw21sa/tg3EBhmE4guSsrlJbZB3RuiOrWwKSQ4bE=
X-Received: by 2002:a25:d0d:0:b0:c61:e44d:c08e with SMTP id
 13-20020a250d0d000000b00c61e44dc08emr2990126ybn.19.1689312504662; Thu, 13 Jul
 2023 22:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230403193250.108693-1-sebastian.reichel@collabora.com>
 <20230403193250.108693-2-sebastian.reichel@collabora.com> <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
 <20230713193812.px7q4sdfdppuywsg@mercury.elektranox.org> <20230714091150883537486@rock-chips.com>
In-Reply-To: <20230714091150883537486@rock-chips.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Fri, 14 Jul 2023 10:58:13 +0530
Message-ID: <CA+VMnFy0Uix64PxLECFK9D8KBF1o34yo3L1t1zQrhV+N2Dipig@mail.gmail.com>
Subject: Re: Re: [PATCHv2 1/2] clk: rockchip: rk3588: make gate linked clocks
 ignore unused
To:     "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        heiko <heiko@sntech.de>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        pgwipeout <pgwipeout@gmail.com>,
        "finley.xiao" <finley.xiao@rock-chips.com>,
        mturquette <mturquette@baylibre.com>, sboyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel <kernel@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jul 2023 at 06:44, zhangqing@rock-chips.com
<zhangqing@rock-chips.com> wrote:
>
> Hi Sebastian,
>
> The clock needs to rely on two parent clocks, which is required by design.Refer to the attachment for details.
> Our internal branch is implemented using clk-link.c. Recently, I will implement the real GATE_LINK API according to upstream, without modifying DT.

Do you have a solution to share or any pointers? I tried to use
clk-link by dropping GATE_LINK from clk-rk3588.c however the issue
remains still as double-parenting is unsupportive. Did you add
double-parenting to the mainline clk tree? Other than that, I have
used existing clk and try to attach the link clock in conventional
clock way like

        vo1_grf: syscon@fd5a8000 {
                compatible = "rockchip,rk3588-vo-grf", "syscon";
                reg = <0x0 0xfd5a8000 0x0 0x100>;
                clocks = <&cru PCLK_VO1GRF>;
        };

This also seems similar issue.

Thanks,
Jagan.
