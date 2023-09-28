Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9D7B26E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjI1Uxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjI1Uxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:53:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7119E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:53:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d776e1f181bso15323259276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695934419; x=1696539219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOwNzxsGPfo7cMZUYR/AlrykeFdMS8Jk3CVApYaoi44=;
        b=ACiYCNyiLRw/Jzqs0QhvgknXDJFRbOImkMdqjtj5crHlLiRPlspIpFAJVb///+N24E
         8lB1YU7/v1UMOuGoFVr6WkKVbmYxBn/wf5qbuhECopANVW+Qwm+UIAaeQGKA8Aaaws7N
         jvzw8QnqAiVXa+p2ikoWBZLMMT+a+7kn+x9xucmSxWBN1PBMoBAMtC7ZPVECID8bYbSp
         fsTGnxRDXsshn6PpJuHSyZiKUKSjqBV4eyxXdwJbu2ufBI7D1+Xwl8FLPaBA2rX6ITfc
         bpkKEkIg0Dv9TUaMwMQ1kThm0C1k3QuJYn+UwAi9Tvg7IQMWc3jdc1kaqcvi3llpyL2i
         /qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934419; x=1696539219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOwNzxsGPfo7cMZUYR/AlrykeFdMS8Jk3CVApYaoi44=;
        b=pDwQX/39HT7UnA6bshmFe4e1xo8XaL1xEYuZiJ8cUqPa3glbvC/pYc9wL7UIeiqnGO
         JeXm2fwoV4UxcoNrLMEz75GDnn7SITZdpbJ4pPARa40UB1otcF9fNwkOTNOVE9V+cx3e
         pWjk++erxcYwFClzc3g5/li6KXBQCT5mGTmzyMk43HiuLOJPppNkap0AGcgW3Rub0Xjn
         K87BD3/oQeg1l5VjLFvtvDFBZo+QxomgTeC+3yfNFgN3PIOYrjpO48xvonlla7ZdeGaD
         iqyoufVjboJkJeN9BQ1WxzaclsxD4sUvlOzEQecHhY8Iom0McDDUM8tWfF84BpgQXcuS
         tA2w==
X-Gm-Message-State: AOJu0YwgdtcltlQiPfEzIvrpCwxeskELQ2RcBzbMHNywJvp3MpFG5UYT
        6x3vUG6PT4tFO1QfvyQgtsv89TOgBog+N4oNv3WPpQ==
X-Google-Smtp-Source: AGHT+IFSlI6fRsLGLuQpuzlTwFu9Bu8WQ8PXxZtdccuFVKar/m1+t8x/SiSa1P8A8iTwCj70M5BysQnL9i8vZ+snw9E=
X-Received: by 2002:a25:ef07:0:b0:d8b:1407:f61d with SMTP id
 g7-20020a25ef07000000b00d8b1407f61dmr1638744ybd.26.1695934419047; Thu, 28 Sep
 2023 13:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com> <20230926-vf610-gpio-v4-1-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-1-b57b7f6e8368@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 22:53:27 +0200
Message-ID: <CACRpkdbvXXJX48nuCQNU_HVJztnH_qQ=QuJWOWp3ZBzN_JsWHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpio: vf610: update gpio-ranges
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, Sep 26, 2023 at 5:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 supports four gpio-ranges at max. To fix below issue:
> "gpio@43820080: gpio-ranges: [[30, 0, 84, 8], [30, 8, 66, 18],
>  [30, 26, 34, 2], [30, 28, 0, 4]] is too long"
>
>  Update the gpio-ranges property
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
