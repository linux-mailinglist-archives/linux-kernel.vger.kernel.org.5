Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B130B7A7A17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjITLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjITLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:09:04 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5183CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:08:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c0442a359so57657087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695208138; x=1695812938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jo3K5hZEHtRUmMkWajypIc1dzDZhC7YyfBmpkmzcjA=;
        b=XBQDcZDC+bnCYYOFE+xyC+TAQTVTCAnzDGY+uaCoYvczS5vhtyLNnibVmDxq3XYu24
         M9o6omgaeEWb2BiF38R+1iBwhYGYslMzeOTL+UX+3jmcq4KSuQjOQeb0zs6LJXwrjwwN
         jcRwLij3v1wWG5yZCflRWWZWowbvWfRC9INmjSkaprxLTGIqsCZIMzC0fFdcMnsgV1u0
         vWXk2pq23Uzl+shrABZ88Lttc5x1UcY03WRqh9+ECMHmPLPwQITouS6QlQ+wlXHj5vsq
         A73SEthWsek/dI2CQZcsAlx+J5hvNrxwwfybI9cpVkB+79VBNQ94lUziAsjPTbnRgKv/
         S4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208138; x=1695812938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jo3K5hZEHtRUmMkWajypIc1dzDZhC7YyfBmpkmzcjA=;
        b=X+z8gF+9wGSWCILa5PjrgcA/ebKkNqvIk5RCEtYZs6X8+cU0oj1xGknmeNt/wHlJnS
         IziqpHf8TYfr6zjkH5t3lxSCGRIkCGfV25twiQ4c6FNiCucN9KCjE8G6F0/Rjw/SRxQZ
         AbSIfwH7blX9PYwpFeufPhEHnPqRQ60xQhO2oVNvWBaCVp+q1eKUSFMu9+dm1ef9SaKb
         jYaX+nScybBK6bhs7QrRsafOpGrDpEpEiYLDHNnu3ppsLAV4io1ruXeClDQQ4Wtl+2+E
         3RKd62/mWs9dvyIy0mXLmvdJD4wt19ex/2XxiAEmk9W4jcXS7nZqGRjKDd0Q1ZsQ4Q03
         KCWw==
X-Gm-Message-State: AOJu0Yy40b6JCFcggOL1Pgldt83BmQUKkAMdhXMhSVSAVnZ6d0JI+ORD
        ZS9YmMIQA0oGZAGeTGov9a+3QextBkYxwxKJESY7RwOd613QJzwX
X-Google-Smtp-Source: AGHT+IEiI8ik+VkdOGL8Ne6V9Qo2SCzhnEr1PXNFQ7Bz4n/o9x1S/fTMugXn6kmF3YFQ+9wxYfMTDITWHbdgWvrlvY4=
X-Received: by 2002:a0d:c804:0:b0:59b:d3cd:ffb6 with SMTP id
 k4-20020a0dc804000000b0059bd3cdffb6mr2147130ywd.33.1695208137793; Wed, 20 Sep
 2023 04:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230919101117.4097-1-tychang@realtek.com>
In-Reply-To: <20230919101117.4097-1-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Sep 2023 13:08:46 +0200
Message-ID: <CACRpkdYtGhhNuBnP0MvMKiqP=wPsv=5K_ZBaWcgW3sssLrm2aQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Add pinctrl driver support for Realtek DHC SoCs
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzuyi,


On Tue, Sep 19, 2023 at 12:12=E2=80=AFPM Tzuyi Chang <tychang@realtek.com> =
wrote:

> These patches add the bindings and the pinctrl drivers for Realtek
> DHC(Digital Home Center) RTD SoCs(RTD1619B, RTD1319D and RTD1315E).

All patches look good, bindings are reviewed by Rob, my comments
addressed: patches applied for kernel v6.6!

Excellent work on this patch series! Thank you.

Yours,
Linus Walleij
