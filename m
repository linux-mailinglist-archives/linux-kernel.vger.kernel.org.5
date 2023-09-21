Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C47A9608
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjIUQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIUQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:56:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB25C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502e6d632b6so2022992e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695315375; x=1695920175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpzQyHHzEyWIms3Xvm/C3MN/zZk6cMQQr8BMD0wmneQ=;
        b=ODI6jAgoVXJoUwz2ouq4KjmaDK/IENZ6qM2E7hLdv+iJYPxu3Yt/dCGg/rfgsQGbyz
         mpIJ3kCuDmLDAgnl3FgKTEXgdGIV0gbzoQ7aZlKBvhkKtiC7MucUMytG893wgOfNhIxT
         W4hNNUeObUI+ltIeulz5LzxXUKGGgQFmnOxveSgg2WKmSonNbqzzCqmyGkDjfKI4KyiF
         WULu2Gz0EhV4ZY8PyM4Z0HlMO6jzeZ5Q4FPnzQnorGZa85GYJiuqi2cGw7olM0FslSgX
         6DaX7Z433Ya6zg+rh3kgO20t1VtL+rhkWPrNuhz+grLTtkb4eQnKbufhSzOEZw2kNKtK
         89YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315375; x=1695920175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpzQyHHzEyWIms3Xvm/C3MN/zZk6cMQQr8BMD0wmneQ=;
        b=pue5ufTbWmIjD/evEF0Xng3PLY3+rOAr9dh34gvycw1AQ6FkvV10fG7qWBB5+11Pso
         fgnMLmYo4+qsKPOdoFEMmMbFHBrS+/F6yDHQEw6y4n8xK9R1vf4gmFwGIdQrXsL+8akj
         1aU3F0VOr+lIQ2K8Hcg84z1W+wZdzuzX1LpOEie8E6cleoRKXue1WlakinMgFv/TmfjN
         a6h8v0rYB/fkatXmbuF9QQkJyeO3QqrF/hENOJyHfLgaXpSjh3C9JsXvwBVVy/Q7le3C
         4HjcWoO31Pw17qVHrRtu9R3POk2hLQHFRlG253Btk6vmaH6fEmM/po39ddhmbhuqHkd6
         nP7Q==
X-Gm-Message-State: AOJu0Yw9ky9K7O7BU0l7ukm5Nr1sFivOc2JrKILjZTxrVU8+4mDJMYYu
        K0YCsN2miPQaaz+YLVMnpDo4dIdLzGqxOdcl1+RQxGE3nckS5QmNPxt3c8F6
X-Google-Smtp-Source: AGHT+IFpyIuxAeI+zJtqVgso5gl/oZPdQPJ8OzyoLwfbQ+BnxcwAYhxcZ6tg7lLrRy8p1y2N9Tuf2kP/Jg+Cn/6HtPI=
X-Received: by 2002:a17:906:30c6:b0:9ad:e43b:1ef2 with SMTP id
 b6-20020a17090630c600b009ade43b1ef2mr4584204ejb.16.1695289242308; Thu, 21 Sep
 2023 02:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-2-dlechner@baylibre.com> <20230921-b304d3fd05b37a8588e101a2@fedora>
In-Reply-To: <20230921-b304d3fd05b37a8588e101a2@fedora>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 21 Sep 2023 11:40:31 +0200
Message-ID: <CAMknhBFfxWy4mWDVYkmaEBx3KkJnRvo1CsNSuab2Rj0TdtozQA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: resolver: add devicetree bindings
 for ad2s1210
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:06=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> > Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Missing a From: or co-developed-by?

Missing Co-developed-by:. Will fix.

> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
>
> Why's this a chap from analog, rather than the authors?

This was written by my codeveloper so not sure about the why. Michael is
on the CC so he can clarify if this is not correct.

> > +  sample-gpios:
> > +    description: |
>
> What do you need the pipe for here? Don't see some formatting requiring
> preservation. Ditto below.
>

It is just a habit to always do this for multi-line text. Will remove.

> > +
> > +  assigned-resolution-bits:
>
> I figure the lack of a vendor prefix here is "inspired" by the same
> property for stm32?
>

Correct.
