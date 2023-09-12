Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB79579C898
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjILHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjILHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:50:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259EA10C2;
        Tue, 12 Sep 2023 00:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694505010; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DmXgqBUdp8c0XCJ9K3rW2asByY2yNYSpKXLkUQsGKqXQP2ZILmFaVZDT3Pf5RvHISI
    PdJD7StLS8MUkZawg8eByT57bisbaCd6pRZ1NhsR5gydNZ2dmNayUfYC63jcCV6l73Fk
    xWN77yPFs7iPiV6GMrGp/hI+lxu71b6wsA85fUkv1ITCnx92n//gTvk3ysbAj3DSBElz
    ESv5i6z8upH+lo5Z2W1KZnUx0OYRNNKzVGmkUUZZKWbcmORfJjf92ATxpZ+Wc4puo09f
    XrAvapo1kaUzYihBn0KlysVhr92J2UBssiF4lETOM+n+wdwnUarnTzhRSIutyqkoPx5/
    /yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505010;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=jSjCvcuGUtmDVM5LebemKIMbXYQsSZIFLfVWBoighTA=;
    b=iGUSK+mFpxJLB9NXXDczqt+dn0Wty+fF6tbpihoOZ2JwV5OAV0Htaj0lMQur5dv35b
    uZxUCHHLZd5/5LsRfGlihI8Vn8bMJpeHW+xz7yMnDDV5s9BQTreJSgTCYr0iqjnJnGU+
    i7Dn3RNesN4QUzkgrq2huUiCNmpTJXFco7iSYn5Q24RXrw3oPnCLIf9FYew+y32l1tGE
    /375bcO1cFz1MSkFauenMZBlz0/PF2C59ILiM/LL5m+N7HOE6APY09WynkOWH9atEIlq
    NXx4QxwW70E/tHfCX9AHFny+7jpfuODBZStYPyJFV+5C12eWxK1cuzKj0fMcwoexAXF4
    Hyvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694505010;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=jSjCvcuGUtmDVM5LebemKIMbXYQsSZIFLfVWBoighTA=;
    b=X58wvMl1YInii6yl+OMTBHNe+t+tGjaQsFFHVMkSJzuKicsrURIkTdJ7RQCbDepbEB
    0yutOKmOTTeUSPEK4Wy6zksHJsCgZLgOtC82i42wOuQpCb0IKKzEFIi340T8Y6zoJ0d+
    AgkIBg2iffQnIb2cUk7PAqS0Ch6fyl1be2PrN14g8JlcF2Gh+DY2jHjt/MmuyF24n77F
    FPo/sfTG8qg1/264QXTU8GORl58aOUAv6ZXgSntOqpNZ1Er94RUzAyz54P0pAQrrteFH
    6fwhM5XS/lrwtLQUVh3Q3eMHyhw5VGbUJjqY9lxHzIblpIynUBp2XMG5bhZkUyOd0/Q0
    OfAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694505010;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=jSjCvcuGUtmDVM5LebemKIMbXYQsSZIFLfVWBoighTA=;
    b=lLkdfdVGIQom/dXOgHMlTrGeJjq6Qu7P9OtCQ0r7xVViMJPJiqvxg9q5m7k1QPt5e4
    9TWxQr3HVgvjHLWhwXAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL7nT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8C7oAcKl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Sep 2023 09:50:10 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] regulator: qcom_spmi: Add PM8909, PM8019 and PMA8084
Date:   Tue, 12 Sep 2023 09:49:48 +0200
Message-Id: <20230912-spmi-pm8909-v1-0-ba4b3bfaf87d@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwYAGUC/y2NQQqEMAxFryJZG6gOo9ariIuoUbOwlgZEKN592
 sHl4/3Hj6AchBX6IkLgS1ROl6AqC5h3chujLImhNvXHWNOg+kPQH501FpeWmKqmoy9ZSMVEyjg
 FcvOem3eVi2x94FXu/9cwPs8PHDXiLHsAAAA=
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary definitions for the PM8909, PM8019 and PMA8084 PMIC to
the qcom_spmi-regulator driver to allow reading the actual voltages
applied to the hardware at runtime. This is mainly intended for
debugging since the regulators are usually controlled through the
RPM firmware (via qcom_smd-regulator).

These PMICs are used on totally different platforms (MSM8909, MDM9607, 
MSM8974/APQ8084). Each PMIC addition is independent and useful on it 
own. I only bundled them to simplify review.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (6):
      dt-bindings: regulator: qcom,spmi: Document PM8909
      regulator: qcom_spmi: Add PM8909 regulators
      dt-bindings: regulator: qcom,spmi: Document PM8019
      regulator: qcom_spmi: Add PM8019 regulators
      dt-bindings: regulator: qcom,spmi: Document PMA8084
      regulator: qcom_spmi: Add PMA8084 regulators

 .../bindings/regulator/qcom,spmi-regulator.yaml    | 68 ++++++++++++++-
 drivers/regulator/qcom_spmi-regulator.c            | 96 ++++++++++++++++++++++
 2 files changed, 163 insertions(+), 1 deletion(-)
---
base-commit: b03f047d9f28d6e68dce6ca66383b80ad66ec1ce
change-id: 20230906-spmi-pm8909-d7aea168a5a9

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

