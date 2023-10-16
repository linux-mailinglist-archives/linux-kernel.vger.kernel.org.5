Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675B17CA471
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjJPJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:42:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245F97
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:42:39 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59e88a28b98so36049297b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697449359; x=1698054159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/nnCBN46Tnq7Ei6+gKfmkaaPzuzJg0HiZNdB/zb6f4=;
        b=aeh7Tmlp5/qkLmKlK2h40b3vJDH6JC122/CUXRfztmijmV3bQ1THqt7BkMbkAHVpMS
         flqXQ7Hju9cOcBtVVKt/unylhjs5ojYNffdrYPiPmCvKTSXnBWe/THFGxPHYWGyd5/rQ
         fMS31KJRzEdBqekIIv/SdJin4NJyuPyG0ugmYWGb03uqHXwtUBFL2uNCaisVoy10zwX7
         RkujXiUovo2Mv4lc+4X+ZJe9BzQBFb0LiCnq6iHxISLVibJ4jn4OSc1qAbFp26lg9hn3
         81feR5lwfE5qipcYqzxvII5Q55+DC6XMLCrmQPbkksIvPpHrNjXe9PoEQIxlf51RY7yB
         E3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449359; x=1698054159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/nnCBN46Tnq7Ei6+gKfmkaaPzuzJg0HiZNdB/zb6f4=;
        b=gjaQemwQsBtIOG6aKm0dJRkAo91rT5Wkgwu0PBAa0uoQ6LBA7nYgKDm5HJcrlcre65
         TQjxK5C4c1rtmq44ZXJOLSZBDjNCd/d+E7haZ4ymLJR3Wh/gpZARV1qP9Je37fYlCYyI
         pGkXMzxYF4DNv72+1Yvu4FVc7C2MxoqUq6Nk+UA38gjL1pUGzVFjPrRYiSYoUNa0jXpi
         +Q1XUuDLN65Ruei2HNsbj0VNISlARyG3CJc46kzVkw3wO/tl8QtepA/y3B4ggyJ1zM73
         8ECkBD2sCgH4y1BDMlve/SYzu3QH/9xES17lUimd/JjyQmFdImiSq8fxRKtWJx8Y1cBs
         8nJg==
X-Gm-Message-State: AOJu0YyG0d0wsvJfdBJONCPwRGCn4xa18P6vV5DRXXL+AN9gICfF5z/n
        7NyeNyFKBql6Q1wDPoWEITjbxYLB8hL+cE4bsQ0ILg==
X-Google-Smtp-Source: AGHT+IGaIwKO1dkSLYSmXTSXBK1J2DFomuGXdajOOcKSa1k8aM+feXePbt2MHAoxM4aQIfbHtumb7fu07KMXVV6qSYg=
X-Received: by 2002:a05:690c:fc6:b0:5a7:c8c2:2947 with SMTP id
 dg6-20020a05690c0fc600b005a7c8c22947mr4240127ywb.16.1697449358511; Mon, 16
 Oct 2023 02:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231016073709.27851-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231016073709.27851-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Oct 2023 11:42:26 +0200
Message-ID: <CACRpkdY6k9T3DOr+zuXs3uu7eJqOd79EPNQ2CfYx8gGt=k3xvg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.7
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 9:37=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:


> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:
>
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.7
>
> for you to fetch changes up to 8aec97decfd0f444a69a765b2f00d64b42752824:
>
>   pinctrl: samsung: do not offset pinctrl numberspaces (2023-10-09 12:37:=
21 +0200)

Pulled in!

Thanks Krzysztof!

Yours,
Linus Walleij
