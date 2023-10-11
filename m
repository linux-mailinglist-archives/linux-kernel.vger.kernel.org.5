Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432467C59CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjJKRCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjJKRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:02:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9D98;
        Wed, 11 Oct 2023 10:02:35 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 26F12C88E9;
        Wed, 11 Oct 2023 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697043754; bh=+BQHia9/w67TGrZbccljU8R+/OKVwybI13ORg8GBv+U=;
        h=From:Subject:Date:To:Cc;
        b=VlBVF+QPMAPlEWjOiivDnpceTXFShZfa6zb2G74gIj4BDp4svClAmecSY0tWr4aRw
         RgEZiHMiQXaoR7+h8dCDTZFh0PA9jAN3u8QhGU8rztHLjVs49zMTZd5BqM48nht4+o
         k6r9mktcwuLTLsT2pDnyRmbjv8uUhjdXwLBviL/o=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Add support for HTC One Mini 2 smartphone
Date:   Wed, 11 Oct 2023 19:02:23 +0200
Message-Id: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/VJmUC/03MSw7CIBSF4a00dyyGCzUUR+7DdICUColtDVDSR
 9i72Dhw+J+cfDsE450JcK128Ca54KaxBJ4q0FaNT0NcVxoYZRwpZcRGTQYzzC8iaqaaC4qO1Q8
 o/7c3vVsO696Wti7Eya8HnfC7/hTEPyUhoUQKzSXSvqFK3jY+xvm8rBu0OecP4iMDuKIAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=+BQHia9/w67TGrZbccljU8R+/OKVwybI13ORg8GBv+U=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJtUmTdedyo0l7L3ekw0j64oi2aS9h6YOWXTZQ
 sOttlwKQpKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbVJgAKCRBy2EO4nU3X
 VtJPD/wMT+efGfEKz5adZImikzgIl3STOSDFlAajmee3one3s1Uj/eIh6N90SkaEAfo4LdZppPm
 ABn/8b6SrVVOirMbBbY0Ngfr65VjVss2jAEMJNdEo8ZDbDhnKuWBHOujCxC0LC6iGN4oNfYLdw1
 6xoKkWi2GEcwt44u4K+y8e2wzf6eKTrCsd1FLX9mxSlDKPlZu6MAw1lnrBLOWDOZcVMInA896E3
 TjCZvqbiLxP7LL9WL4cWtxa13E7h+eeF9yd1dGoCngqxM5Td8V52I8NJApjtI3xKOX0c6mnMNNQ
 jIyVNrlAFDDRFKSFMRBQ9q0GZwgea2ZBIcFRIe8zdnla7zuA7k3OpP3Qjf59fOMNq7BijsTY/Zm
 Kf6XKqjFfh4bKndBBnPYwqj3KrOKAKhIwq8T80CsDUafBUpAKV/V14Bc/Lih+zZRVFlmAXUy6M8
 WSLLPpN/dTtlJXaK8eQ0kxzTcmBzBBbdB2o2x8zEXt/DmRDzH0po3RSQ3OE/0Xo/pyl57/Um82a
 +k0sdDXd6fBfPfBpUOG7A0szIBlYbixIQHl1xehNsQzlCvqw/Pcx5Fi9hu+LV7vvuldHeZa7goT
 /WHavBF/h5ezVMFBZBQ+WWz8zWayyeXTQMJKVaBij8lwQGTJygAL15/FBK+FeSEzDukKm6TS4pe
 WyvRFuUAvTCYQWg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this smartphone from HTC which is based on the MSM8926
SoC and codenamed "memul".

Depends on, runtime-only, bootloader enables watchdog so we need to pet
it to stay alive:
https://lore.kernel.org/linux-arm-msm/20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz/T/

Depends on, for dt-bindings & Makefile change, could also be re-ordered:
https://lore.kernel.org/linux-arm-msm/20230930221323.101289-1-rayyan@ansari.sh/T/

(Technically a resend of msg-id
<20231011-htc-memul-v1-0-97c3910f80a9@z3ntu.xyz> where I missed adding
most email addresses, sorry)

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: vendor-prefixes: document HTC Corporation
      dt-bindings: arm: qcom: Add HTC One Mini 2
      ARM: dts: qcom: Add support for HTC One Mini 2

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts  | 337 +++++++++++++++++++++
 4 files changed, 341 insertions(+)
---
base-commit: 4a914c105417214fb38cd124317f174247c0a426
change-id: 20231002-htc-memul-742a8517d24b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

