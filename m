Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0E7A40C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbjIRF7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbjIRF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:58:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97BFA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:58:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c0b5f984aso28424547b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695016712; x=1695621512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV1uCJ8pmpiIkKeLvWd+ZzcVlYy/aRUeYL380enELwQ=;
        b=eLDnyPWhaXgF1wtKykWq1r8CEEbAExVGwuf3VjxDhS8JkWEzg3RyQdt/jcT68uxI/h
         JUR9CZprDwZBy+eKplP5BXf8Q9r0m11k9VV6gZiSt47192IUvUc3QtZCocmZjJfcwb4x
         7w+6mxJ2529jx3pF1Dw76cv6BeFPWF+UumTwVXtz/PGuk7nFxITVB1K6KMqAUAS4cHYq
         ty+LT4iaMPXDOManj0VAK2dgJzsFuKJQWSJ8SK1PYz3faTivMRegvlTJm425TM2pKEa6
         mYtPSn/5bM/wqQhmdtctKnwvF9Xk0bLabbA3KbgneTdCq/iM/gmpAkc29KjMotoB9NYn
         trsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016712; x=1695621512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV1uCJ8pmpiIkKeLvWd+ZzcVlYy/aRUeYL380enELwQ=;
        b=J7ga8cqS0MLjx6bmZRhH1zLYkpGkTLnhKvci97W1K/Zjjzw+o5urbulDKDC7g8CQ9R
         WOYnfD2xXhpy6AcauHLw3uoZYdH8YRwaqxb1VlugqjvOkakRd7hrm0jc5/apUzw9ihYK
         NpObAVn2wTENhoUK7WFwzU5SYidzCzVo0WU+PXYlWHPrx9J8UfKoXe224isYRb2jG8Um
         jIIhvooaxSDBhSuzUFNEdnSoZ+zg4k0KqbuUVZVZN130F1zySifDqSHe46693egq+Fo+
         Gzs26Rh9gXTrJ5A9xPiWlNe3FQHLwfylekYFxwSazYwp4vpe5m9qD1U1PJoYYPHdCk8d
         82dg==
X-Gm-Message-State: AOJu0Yy59HANUijGczsT6brcipezQlCIqyp95hPxy6D39JwyUIrh/SoT
        Q+pWJZ8xVvQ4O7ty/V1yOW8Ae15fGgC/Lixx1BGAIA==
X-Google-Smtp-Source: AGHT+IE2GGEGegrjeWO1lrgi7QNiOlH0eu34fYoq67Qp7gq81DXnLUWi/FDZIJ9TSRJzeWNHk2tiW0dzM3DiHHAoiys=
X-Received: by 2002:a81:79c3:0:b0:59e:afab:d5a5 with SMTP id
 u186-20020a8179c3000000b0059eafabd5a5mr864968ywc.23.1695016712528; Sun, 17
 Sep 2023 22:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
In-Reply-To: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Sep 2023 07:58:20 +0200
Message-ID: <CACRpkdZEo06hrYkcQiZe_3WP_vMahDP9vp6y2dGkYCroTtZB5w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: supply: Drop deprecated ab8500-battery
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Sep 17, 2023 at 9:08=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Linus Walleij modified AB8500 to use the generic simple-battery
> and samsung,battery bindings. This is an unused leftover that
> can be removed.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

How could I miss this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
