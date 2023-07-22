Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40475DA1A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGVFOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGVFOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D635A1;
        Fri, 21 Jul 2023 22:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556CA609FA;
        Sat, 22 Jul 2023 05:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E8DC433C7;
        Sat, 22 Jul 2023 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002856;
        bh=qix+tZKaBVNnw9mICuUlzMX2ntTGa4gblWUsIg7EcQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnjeyO2I6hXiBYP8ey6sa6B9pqrG6DALYTgyy3MzgUMZhxsyXx3CEHhB3p4szSp9o
         H3RH1b7I7eQ0/worQvAZYVHPLTPrHhBMSKxP8x991bM4M06x7zNdGjEL1v4yNrZz20
         wLJbWaBqLu9KFsz1XBuZGPg4vEgkt7e/qvVr1HZIDWQcOaPKrVI8PUwCGMTfcFB4fQ
         /Gih20EtCMqaPvF3ndj73KYce0o6cJ8w/VxGJ7zMGazz7WJVMsbII3otN7C0oX47Fk
         36lidmRhNzMc2zuiJVCaIAU809mTlrtr/ebKJ+h28bfuf1xjISYPryL0U2FKI8gG9x
         9E2ng9m3EHVqg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
Date:   Fri, 21 Jul 2023 22:17:15 -0700
Message-ID: <169000304216.3611206.7163700257157871891.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623100135.5269-1-linmengbo0689@protonmail.com>
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 10:01:48 +0000, Lin, Meng-Bo wrote:
> v2: Squash patches
> 
> This dts adds support for Samsung Galaxy A7 smartphone released in 2015.
> 
> Add a device tree for A7 with initial support for:
> 
> - GPIO keys
> - Hall Sensor
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5502 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> - Touch key
> - Accelerometer/Magnetometer
> - Fuelgauge
> - NFC
> - Vibrator
> - Touchscreen
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: qcom: Document msm8939,a7
      commit: 0391cb15439625c12f0630dc1f8b00ea8ee71113
[2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
      commit: 507f9db1e9decaec1b71d320a15c7b1cb95c0848

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
