Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13B777218
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHJIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:06:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76D2127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:06:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58969d4f1b6so8240967b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691654795; x=1692259595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q9pMCSuL9vESktwMqE858tVHd35r/KvFWuSuynvaw0=;
        b=gzmkYeW+DoSxNOhF5bU9z91nkG8W3e2vRMcTUaJDvx7JwwfLx5rbKDXJaR/NTQ0OEC
         HOPJHj9DohyYtCIY6K1RPD6oOAyQm3yA/NFcBaBGRaVPXESNmHZCb9iOEW24oVTl0JPd
         wT2ka2wksrD7wiVh77r/pTMtt8NUrvEdHJ4fheJOI5TvnfRffeY46BGvpJjIO5yfn+TK
         jQ5lCzygVnMSs+Zm2rNkw7KtWoE+FJsUoVppvqGuCw8kbyzORX8kqQMP2hBPlG0lbXMN
         OnzHtywtPeqzpNhlVWBCiVsxvBOtsYBE5I5MkpOa82j1CoApylwwvX6uXBdm7U9IGhma
         yTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654795; x=1692259595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q9pMCSuL9vESktwMqE858tVHd35r/KvFWuSuynvaw0=;
        b=XAnDh3+Q9CulxeblRApBgsY5gRKqKC8C37fToJW8grvbUM50xNTQYcIY12XGiLT79W
         vyhuf0U3yDUdpRTDOAFpH8DTL8H3Iv7lFr85OC2RFC3WZSp/gwJA6CtzIvfuYT+MuWPp
         P8Gukrj/QoxdBdRPPXq24ClQ1EfmEJ37fLLHzLegwUZmtMNDA5Uw8WxzQC6pyCrpFN57
         jRQp2qgG9ONc1cz/8BSL9s9QzaGWwoyN9YRvPsRi7V0vYDZuneT0iCKBIgKqNQeieUOF
         UeT5goHXccIJdFYtVfiHVKRHgxBz/Nn2rPLPLcjdpYFNWlm7pVJaVnuzTEz5iE5LxtSm
         s/oQ==
X-Gm-Message-State: AOJu0YzMWGH3UlFAsrTVL+3BauG3PmE3V1NIFe4j092DHfBxygCXAdBK
        old1W9a1ko6suiaA1Cm0Ya8Gk7NscWYrylwX7S9VBg==
X-Google-Smtp-Source: AGHT+IEovomRK+kWYS3QSvXc1niAj9s+9GizN+e7dQ7c1g8YM/QDhcqBJqkVb1A6lv+dItHlSEOtTwsaEPVqxh1Pd90=
X-Received: by 2002:a25:2d02:0:b0:d4c:68e5:5570 with SMTP id
 t2-20020a252d02000000b00d4c68e55570mr1924983ybt.48.1691654795698; Thu, 10 Aug
 2023 01:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801111712.45653-1-tmaimon77@gmail.com>
In-Reply-To: <20230801111712.45653-1-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:06:24 +0200
Message-ID: <CACRpkdbqqUhUf=KYqW0+439Lijy9mCdJ3Pszwrj6aRtbzH0AOA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     j.neuschaefer@gmx.net, zhengbin13@huawei.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 1:17=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> w=
rote:

> This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX
> Baseboard Management Controller (BMC).
>
> Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> period time.
>
> Arbel BMC NPCM8XX Pinmux functions accessible only for pin groups
> and pin configuration parameters available only for individual pins.
>
> Arbel BMC NPCM8XX has eight identical GPIO modules,
> each module has 32 GPIO ports.
>
> Most of the GPIO ports are multiplexed with other system functions.
>
> The NPCM8XX pinctrl and GPIO driver were tested on NPCM845 evaluation boa=
rd.
>
> Addressed comments from:
>  - Rob Herring: https://www.spinics.net/lists/kernel/msg4881522.html
>  - Kernel test robot
>
> Changes since version 4:
> - Pin controller driver
>         - Modify DS definition.

The driver sure looks good, I'm just waiting for the DT maintainers to
ACK the bindings then I will apply this.

Yours,
Linus Walleij
