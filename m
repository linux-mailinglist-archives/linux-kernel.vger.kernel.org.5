Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89829800D23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379167AbjLAO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbjLAO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:28:27 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B546110FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:28:30 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 790413F1D9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701440909;
        bh=J3tX3M2zYj5xzUQ87L+5qVD8j/S83Al/tHxvfxTDyUw=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AkkS/ol59EXGAb+QsIO/byDT45l8s7RHVDq5Qku8XiCzKUPH4+ZsfaE1m3h/Izi9g
         XFPzW74jIedKNmcw5nWkS0aejur4a3V59DqFIVaOhZ/qLjvTtkIDzbGxxPd1GLyOEh
         GSHX8obFb97QRLlrdaUyamDeLyievNzmu3v5VI1P49jpNeRX7gcYu9h+6fT7L3O1FB
         32hzkslUhfC0DH6j+YsVXZnCuxpe9X/go57MOpztZD1eygWguSgfuxsf2yeN0yFFkt
         KXwC4iydgKmF5cLQQAxj79UkgSBtZOjvVALVYbVa+iB/AojdBg6HSkHZ0fJ6k1V0UB
         aWQ3DoenkOB9g==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423e22075f4so24776641cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440908; x=1702045708;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3tX3M2zYj5xzUQ87L+5qVD8j/S83Al/tHxvfxTDyUw=;
        b=qZgAnZU7hVhgDCAqOA9e9k1FsFMRhTgOMl8//Osep7bykAfRbWPE/f2Zfps7JaHSWT
         c7qv37mih7yAecYonXcLyFjYgXtTNJTCQ7fgLXgrNAed2vU1VshojtHIg/X7ZnZKeRHY
         tK36MuSevnjFF0g/zdb0ARmwymkrWqLnUpkZP7ucmczJCcQ0xW0kFYk/3TMuMu8Kyyqx
         F7svxKIluH79cWUnYkZaAL0JgnnnEgk7ZGukRHTEDj/bjXpkksTlqBcyn0O8lPTluCAl
         QZywy6c8TMUoYJHhzFybRraOEaWM2zn+IywfA/btjg3HacMbTGSaHzC+5XO31ZCc/RdF
         lY7A==
X-Gm-Message-State: AOJu0Ywf7OXAzqi1OhJTEnUNN80rxQBgZIHGKiYOgB1BaXUQVUkpCaQ1
        QOv5Zbm0h4f25NkT0piphw6H8+mF9smJmWHRh9LHZFM6/awXzI+zHCWZRsQTvA5m5gwUFyZHij5
        BMAtwV6X4mMyEJ2+zg5UTU/xwX9cUlbagYtcxGs99TKRm8rijNoagAyVHgg==
X-Received: by 2002:ac8:5882:0:b0:423:74a5:2847 with SMTP id t2-20020ac85882000000b0042374a52847mr27370893qta.49.1701440908461;
        Fri, 01 Dec 2023 06:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz6QSK9JfIdYSeG1hMKcfp6BJsk9FZlcDEDSfyu1q6fE+aNUWQuhYy7p5rzkdPobcTPVTqnTSPj2jiq9s9GYc=
X-Received: by 2002:ac8:5882:0:b0:423:74a5:2847 with SMTP id
 t2-20020ac85882000000b0042374a52847mr27370879qta.49.1701440908234; Fri, 01
 Dec 2023 06:28:28 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 15:28:27 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
Mime-Version: 1.0
Date:   Fri, 1 Dec 2023 15:28:27 +0100
Message-ID: <CAJM55Z9CooaYqeTuZK0FARKupf_StTSfWBo7ziv4KtGq6pEVaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To:     Nam Cao <namcao@linutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nam Cao wrote:
> The driver always registers pin configurations in device tree. This can
> cause some inconvenience to users, as pin configurations in the base
> device tree cannot be disabled in the device tree overlay, even when the
> relevant devices are not used.
>
> Ignore disabled pin configuration nodes in device tree.
>
> Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 530fe340a9a1..561fd0c6b9b0 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -492,7 +492,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>
>  	nmaps = 0;
>  	ngroups = 0;
> -	for_each_child_of_node(np, child) {
> +	for_each_available_child_of_node(np, child) {

Hi Nam,

Is this safe to do? I mean will the children considered "available" not change
as drivers are loaded during boot so this is racy?

Also arguably this is not a bugfix, but a new feature.

Same comments apply to the JH7110 patch.

/Emil

>  		int npinmux = of_property_count_u32_elems(child, "pinmux");
>  		int npins   = of_property_count_u32_elems(child, "pins");
>
> @@ -527,7 +527,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	nmaps = 0;
>  	ngroups = 0;
>  	mutex_lock(&sfp->mutex);
> -	for_each_child_of_node(np, child) {
> +	for_each_available_child_of_node(np, child) {
>  		int npins;
>  		int i;
>
> --
> 2.39.2
>
