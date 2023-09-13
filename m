Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAE79E92D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbjIMNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjIMNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:25:55 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5519B1;
        Wed, 13 Sep 2023 06:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694611535; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LeX5saRTr+At6MzyVh7+sXPc0NqRVuiaP1Ch1Jk+WoDev33+xd982ReLjqPSK7am8m
    pjDqrs5KZy/tc6wIIzHX5isdZ3siv3337Tr+8AbHkDBJa9FwHrNbrai83ytiavkztzhb
    gvfYeczSNBUZExMnypVd+CMxaHzPLUuNmPO9BokvrfDQvdJGjDD1GQ5+wUvwY3dDsDoo
    9wwYsCrxx8BYBPZW0mvejy4zqRmWsYxKH88LvSSLijks2N3uKgwg1qv+DWr9zHoTVcH2
    yNZjwPjZK1Oe2fzaDHWvZxElE0t+bEduY86s5SwAyqjvplTqyijvh1cvKnCF5UhDUgNq
    X/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694611535;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=2yYfFfmY5L7Akn5oP+M8fMk+qOUch7gWpcmspCBJC10=;
    b=XOkFFIzthoqY6IcoWQhZQUa44uIYcgK/7UUdkygpp62uwdVEiANwgGMuhIIDoWjLBv
    eZ9GktJRynxGIuWxVd8NJYl9fzSZ991/k9upSzAA6hT9xxby16yqWXtmEaLkAFubrTOj
    IqhgWXQPDVd580aubLJjr4QeltO6UluZeGJPqILmtv4QGsQeXBSh5p8BH9tilj6LEXiO
    BCpVkOA4gcka26j3KnoHThAWnfahY6J2APwcWtOpw+4JaXNg/ncdpIgtYPToQwzquKOQ
    bycJRHJ+NkR+aokCeYOnkx1JcjTuKEYIeSeBPYEvDPwoX9CvFqmdqqb9UpabC7/hIN1S
    M+Qw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694611535;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=2yYfFfmY5L7Akn5oP+M8fMk+qOUch7gWpcmspCBJC10=;
    b=H1JEV+mcJatiM9wpsTmlPXO49b82lMTKd8ZsFpB0Co/TEdRQ/Fp4f2Y8sHu04oVdSP
    cTxuBnCwoNO0GbGTezT9WQIzO4dbATa07j3RyhD4vd3gXb3/a05bkagHHCyuGxh2aMcM
    XZZgcBVIJQ/cmLrTNh46m3avuqI5F3r6m/IzpephZJLJI8T5K8o+VjgnwS9u6DyL1K4R
    v/acdK5RjGLVIrc82Z9OuHH8vCF92qZ08RRXj872TuShzBDHBEsYy7LSTeJi3UZ+4vOa
    2DDARiRQoJBA+vDbovvFtadfyHdxoIvV6w9VZ7acJmhpJ0NfZV3zEmYIWpykUNuRM6CG
    /oJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694611535;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=2yYfFfmY5L7Akn5oP+M8fMk+qOUch7gWpcmspCBJC10=;
    b=v0wJetINySkyDEtRwAQQDmmWmmRAybXLk/t315YJBqvhYfdaIDTAbwc7kzM6N9FjEW
    Sq/tQ8SVyNJxtMWTb1AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p3mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id xb560bz8DDPZuEG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Sep 2023 15:25:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/2] Input: add Himax HX852x(ES) touchscreen driver
Date:   Wed, 13 Sep 2023 15:25:28 +0200
Message-Id: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEi4AWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0Mz3YwKC1OjCl1jE0uDFCNzc2NjIyMloOKCotS0zAqwQdGxtbUAYgG
 x7VgAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema and driver for the Himax HX852x(ES) touch panel 
controller, with support for multi-touch and capacitive touch keys.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Jonathan Albrieux (1):
      Input: add Himax HX852x(ES) touchscreen driver

Stephan Gerhold (1):
      dt-bindings: input: touchscreen: document Himax HX852x(ES)

 .../bindings/input/touchscreen/himax,hx852es.yaml  |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/himax_hx852x.c           | 491 +++++++++++++++++++++
 5 files changed, 590 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230816-hx852x-3490d2773322

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

