Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4375B7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGTTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:19:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC51724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:19:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5728df0a7d9so12827647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689880757; x=1690485557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=als7alM6wl4HPiHeVC1qkxagLYbhNVGTD2+M73cPKzc=;
        b=c/2EGs3153+d36iIDKMBGGpJdLhaWp0J0+avlVYwQbipjDwrNg1CM/2Eel2ExzaWhz
         gfKouqm1OWCjQMp9vFkSCmbBT0MtSL89ti6yWZrB+y0YX0FoC/p9Vovee3BmWb9NanvF
         S0rcwvy/rc4nJTfc3tD+sUhAwFEleh+s8nvdrW3tm6CxOT0S1pFOl8FjlwRoMd8biDNE
         kWUsooKupU9rS9tWAY4xuOMoIOYqtCKhlnlhjtapToc2UAjeZiF3du3bZ6yxKahsci8H
         ctNwKE8/lSmxqrPEPKwmDBiZCAiN5BozfVb1sjllJw3h2wgJI/hm4KE6CmrrARY5dKCn
         of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880757; x=1690485557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=als7alM6wl4HPiHeVC1qkxagLYbhNVGTD2+M73cPKzc=;
        b=krXpPZgZVLb8QKO3NIwKQ5jwiMPzCiXbirqeEU68BnRwvodc+JkHBf4d+VZ8Ki5dPT
         gj1BDGBGMGvrHSGelJpGm6WnaFIOxbRANK+Srv8SCZwH0W+u0bZ34AuYR4JUPUMgjGDE
         qIPlJgyrW1tKHyk2QJaUozlaG/6/bTNczy6QtP50xlvFSPywl4Z6pnaG/OgkZKR4n90Z
         fQCDTZKEwFNw4dmaNvNB1VorJcGwjBCCWzOcuIYfwUiPgDmWCKrQbYvBdCe7PdFFb07W
         WzUs+Z6n7BAQeQHudMcheuJWgxPswxbOlPbbIypNufNfdWFloTdWELa3hc4sL1Lcd0Cd
         hnsQ==
X-Gm-Message-State: ABy/qLZsZm0YU5luIfLQ/g7h1Xc4Q3CvSGfbx3vX6F99W5Mn0i0fbdy/
        nFWz8UJXiWn66Kfah6ekQWrxC865HOrQN5e8Qtqchg==
X-Google-Smtp-Source: APBJJlEKHsTY3J3aR/UfecQYYLRiOprm4ld8yB/fRlOfar6oxQEJ/1bIkz0iXkP5eRvlGd0WILMSfkBtBRsrnItYvCQ=
X-Received: by 2002:a25:68cf:0:b0:cef:bc0b:11b with SMTP id
 d198-20020a2568cf000000b00cefbc0b011bmr5731048ybc.51.1689880757343; Thu, 20
 Jul 2023 12:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
In-Reply-To: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Jul 2023 21:19:05 +0200
Message-ID: <CACRpkdasmjUFZ6vnNe7HYoWgi2rSgX9uX9S9Szvb5r8ecr3vpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: cypress,cy8c95x0: Add reset pin
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh!

On Fri, Jul 14, 2023 at 10:19=E2=80=AFAM Naresh Solanki
<naresh.solanki@9elements.com> wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> This patch adds support for an optional reset pin.
>
> The reset pin is used to bring the chip into a known state and has an
> internal pull-down, allowing it to be left floating if not needed.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Both patches applied!

Yours,
Linus Walleij
