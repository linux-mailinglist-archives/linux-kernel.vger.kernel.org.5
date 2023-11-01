Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8612A7DE710
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbjKAUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:19:05 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4863FC2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:19:00 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5af5b532d8fso2535347b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698869939; x=1699474739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TitzneWvDoMzzr+coAisCqJHJdfZSk/3hIEHii6U/Bo=;
        b=uLkpk1S9HK6v9qnOElJdITKWjFE5P23BTIaJB3vQTuxJ7OtNwA0HA0T9zVM4D1Pk8J
         MJOTlZRohvM+V7Ik5XwK8dGo4Rap0yGNdoFHbQfl7ttseHQ6wtx6GzX9LlUGtK5Pv//V
         xoUibo02z/ziikkSBY0wSbVynhqJ5Le+rdHMViIyff/r56HC1XqHjceeTjXm5enXQXER
         LTwU8Dld/J1lJSVqEJ6lMuimmNB48OhMDLzVDHJ3Cwwy5/YaMzUQkAvWVaRjvYPH3g57
         QNmizt00Ba/nBUq5En+kw9FgqpX/8BNM+I0hRtZBZpQEc0cF9Y7WiKeFlyuIR2wjVPK4
         dYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698869939; x=1699474739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TitzneWvDoMzzr+coAisCqJHJdfZSk/3hIEHii6U/Bo=;
        b=Z+EGkAzSs8UPSSFJ4ZE3QbJla4Z4A9qB5avpZ1oLwn6iCu5VWj5ndZLRIK+98z5Q4f
         229BAYzwES+naLalmCoEfIndyI3VC2GOa1XqqMCFW1KPpXjwI3m8Ez7+l8aqKPNhnp0U
         xo8C3QoKxGdxsOhfQdqmggFX3heDy10XqA6fvqrQ5rx905UdyvyZmY9CUOyz7LStM1ys
         0Wst0ClyraoNi8Yr4e3S9ziY4I5K8UNMt0WlveemAkZe7PeiLsG5jktslYOb4lvtKzEl
         /fJXmxPNnwX1vudWXK+jd5LvwdQAdB3glXCQ1fHehtedl5eLxBNEC5/mdioYT7x4gyMS
         TlxA==
X-Gm-Message-State: AOJu0YyCM0/wOBXFIRwLRk3oMipSsiihJLQvV+I5jO5nVTVhlbsT5a6+
        xMj7qxA0oCDDXWfsh8i7/lHV5D+LF2j4XHLxXkLFXQ==
X-Google-Smtp-Source: AGHT+IGo6+MIYRKhTrama1zkFjt1CLUiYGYVyMjn2OnPbe5KN9hBfB3CyP4WowMIfpzZSNbhubM4hATIU/UXf+5ejxk=
X-Received: by 2002:a05:690c:39b:b0:5b3:4264:416f with SMTP id
 bh27-20020a05690c039b00b005b34264416fmr6121252ywb.27.1698869939518; Wed, 01
 Nov 2023 13:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
In-Reply-To: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Nov 2023 21:18:47 +0100
Message-ID: <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:45=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.

Luiz is not seeing this on his ethernet controller so:

pw-bot: cr

(I've seen Vladmir do this, I don't know what it means, but seems
to be how to hold back patches.)

Yours,
Linus Walleij
