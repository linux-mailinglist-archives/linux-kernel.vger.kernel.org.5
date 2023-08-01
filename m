Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851376B312
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjHALWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjHALWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:22:22 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF993C34;
        Tue,  1 Aug 2023 04:20:45 -0700 (PDT)
Date:   Tue, 01 Aug 2023 11:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690888839; x=1691148039;
        bh=KXzVhdgvb6ACEBKjOa9F7qDxyiJ47Iva5QgIt6PZuuA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=qWVmMirlMSCXLq/qBkmnntNTHC+sABJ1TmhAwOyz8Xu1NBj44No4PNysb0acQfwAG
         PWK2nn3iMnhQZ6KoNiN+VeP1INxG5RnMLlw0xnxScClrUrKADtbpPbpk8EmRno7plT
         j6U28+oj17hrfBwIUQiEm9zXaNOmf6/EFWi7rUFO8CUKWAm0MPphpo/KKHAw/dkhUK
         TB8Ry3EKUqE4dkWze72z0SxgwVkPt4QjQLMqP/nl4nkGV9mpG/dWxJ3eXu48oPZJ81
         f6nNma+PfAAR7XI3/hou6TDuiQa2sSo+KTlWyySuAnnUuCoUT9usO9qOJ5yXpVeCUc
         fim5jF36Zm5BA==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add initial device trees
Message-ID: <20230801111745.4629-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Galaxy Core Prime, Grand Prime and Ace 4 are phones based on
MSM8916. They are similar to the other Samsung devices based on MSM8916
with only a few minor differences.

This initial commit adds support for:
 - fortuna3g (SM-G530H)
 - fortunaltezt (SM-G530Y)
 - gprimeltecan (SM-G530W)
 - grandprimelte (SM-G530FZ)
 - heatqlte (SM-G357FZ)
 - rossa (SM-G360G)

The device trees contain initial support with:
 - GPIO keys
 - Regulator haptic
 - SDHCI (internal and external storage)
 - USB Device Mode
 - UART (on USB connector via the SM5502/SM5504 MUIC)
 - WCNSS (WiFi/BT)
 - Regulators

There are different variants of Grand Prime, with some differences
in accelerometer, NFC and panel.
Core Prime and Grand Prime are similar, with some differences in MUIC,
panel and touchscreen.
Ace 4 and Core Prime are similar, with some differences in panel and
touchscreen.

---
v2: Use interrupt-extended. Drop fuelgauge, sensors and NFC for now.

