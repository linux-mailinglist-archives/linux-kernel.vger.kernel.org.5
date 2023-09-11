Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECF79B185
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376578AbjIKWT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjIKIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:52:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3271A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:52:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7ba4c5f581so3657791276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694422363; x=1695027163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+TBKfXcW4VNeT7h3JrMxAlQteRcuMFFm4dXlpFkqqk=;
        b=qCWhxUxB92NKRMNnvDvHjVczsYel3m8v4+U/vXbhiUQIrJvlIdkXgIG/FSCrPTdtHc
         9dAuIuZLIPNabti4CS7eFQqcNDZo+g/SD8GBw13xP+dzOEfGxXHAPw6ynvRfb+Ey/BUK
         Hc5fk/PR83hhMfuEy8dKdfDZgQGW5YzTfOkLOkqiIH+98NPj96BdujAF8PRRwm4Ot7c1
         AIJLi2gRehu9qH79M6CqpQDRAE8MUzeU1i/UAhiHKm/+Y18rrxqi9n1nSShdXBtdXhTC
         rI7Zo5cFiF09b+gJLv8ekJGsyY9er2PAu6b7UxcqRfvAwEiTY3R5yEGbxXwm0VwajnEJ
         Zy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694422363; x=1695027163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+TBKfXcW4VNeT7h3JrMxAlQteRcuMFFm4dXlpFkqqk=;
        b=FGpGLeOb61zElYNl1dqHzzm7MjQ9tw8xLwDhJGQgtSL6UOl46sht03Ly8Pan2uWsUJ
         01bLNLWa9WeBcnCHgeBpEgoFrwCjPQTq3vwMYE0RVuiG33YdkXTnxuTFjj/eyJpqHBE8
         UtCWAnAuKHniGrB9a2iKaxGlDLB/sno/KVb7+A74cp9MJ4fYnrUnTm54F1++B/rcqGqU
         RLKxDfZhQ/2o8sqsAOf6em/fK1RQg/RyNScjN5cMDC6Xq4BB37OZHaexXX+OYhrmHCbV
         LK4eFlC1nlSfn2r+oGth0p6KSfCtsBkWn1mOIMbPvfjjuv5/VEV7XaE4DUS9JvTG5Yh+
         62Uw==
X-Gm-Message-State: AOJu0Yx15lHHuuXTdbstyyVLJpgRVTUu+StR71UTlRTN6eo9zs0tbUMB
        MZa3/n1An4mu4XCk2+D0itNG1lX2AeEERVtfMSZJWOvWZzY6tiKt
X-Google-Smtp-Source: AGHT+IG/7XXVErcSB7fRMvEak2L05rtVWPjY5fxZdBayCUIhiXjJE6hICBmuHJK0LCu4wfYW2GHb2Ql3VGOVdjSdOK8=
X-Received: by 2002:a25:e74a:0:b0:d80:bef:3035 with SMTP id
 e71-20020a25e74a000000b00d800bef3035mr8806351ybh.52.1694422363761; Mon, 11
 Sep 2023 01:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230824105703.19612-1-tychang@realtek.com> <20230824105703.19612-7-tychang@realtek.com>
In-Reply-To: <20230824105703.19612-7-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:52:32 +0200
Message-ID: <CACRpkdbehdVKbcJjdGb-4_KuTwAJVuj1ucBihkg5tX+VJe1z5A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: pinctrl: realtek: add RTD1319D
 pinctrl binding
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
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

On Thu, Aug 24, 2023 at 12:57=E2=80=AFPM Tzuyi Chang <tychang@realtek.com> =
wrote:

> Add device tree bindings for RTD1319D.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> ---
> v1 to v2 change:

My comments are addressed so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(Then you need to also fix Rob's comments.)

Yours,
Linus Walleij
