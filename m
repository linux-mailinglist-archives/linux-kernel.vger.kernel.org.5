Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62177D9BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjJ0Onp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJ0Oni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:43:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE951D7;
        Fri, 27 Oct 2023 07:43:35 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 75BA240474;
        Fri, 27 Oct 2023 19:42:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698417767; bh=NeaRIvhAdmsiwixrPyzAQHliiv4QtYTDvXHLkzW8OEI=;
        h=From:Subject:Date:To:Cc:From;
        b=giTA9TyVqb6BRKMu2aVItavAXYm2H6+GfiFuQv2sATtV8WVUrU/qj2ePjNbpKHRkx
         ZugEkqUvcBAXaPsaQ3yp1hss1nvwA5A7bQpCkYF1An/2Oe0z+Lvo3UnJ6U902Qmp0M
         abX3dkFJw8R1LDEJpK5ATa+hRKRtP67L/plUZnmHEGyPjnnGAe5dS2sww1VjnvqZk1
         WUYUJumqXYLit74nuIIPmPI0YACHwBk8Gjbn9Y4KhfKzeY01lgSMlZybqlPMoprXPM
         TMyuVtc1XMtR2h7u4vGUQJqiA2HV28jYtcAhkAGTtbhbVlp238fMX5DVnKz+7Pdt6S
         UDqfMWDYnf4Ww==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/3] sc7180-acer-aspire1: Add sound
Date:   Fri, 27 Oct 2023 19:42:20 +0500
Message-Id: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzMO2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNz3cTigsyiVEPd4vzSvBRdU+NEk2QDs8Rky7QUJaCegqLUtMwKsHn
 RsbW1AGBtjsBfAAAA
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=NeaRIvhAdmsiwixrPyzAQHliiv4QtYTDvXHLkzW8OEI=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlO8xYvULdIu3LC9eztejqErSwObt6VpGV4XWrk
 JdonJIEfZqJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTvMWAAKCRBDHOzuKBm/
 dbqvD/4uU5Nx12cXGwc59v2QZQ1J+nGku4y+96O2IoOgzY97p0X5uz+R9GyQOTwcukxs3/mZ9b5
 EAHNLbm47jGXChy4j7n7KEBYNoNsGreTT+SZmAxUGhlwJwZoWj2shyFNliSRRsXos5tc0JXS6TU
 EEwCAcxzs6K51KalW/c+DPNMhIiVEXhv+ZH2EUO8+LH7gHGcDkC+UQQ17sNIm3m/ls8YPwpEiC+
 O0KMQ3jImXb6CsmLo5XASL+v4PwY4z8eXwm9dVCPvo0G6DITY0lMi5hyygE+70oHaabmfZ8zxAS
 ktniTXOWj18awMAx01MNrzvNBKeapWdCvW8bGz0Lg2WGwFGf42Hnavi/+G83wmdLuN0ilRv5W00
 FfRPL/CxXsXW0eAG052OHkJoeG0BWzMe7WlbLGtP6BOEaeeIriyd55Z+9G+nb58x++yjvtxQFxX
 zE0oh+WI/aKf86+5uo80AD1cLJedeEyuwxqx7jJuPTqvO4m8J2kmjYZCqYSdTWVfg75wKQrWRAo
 dQ2Ey23fG/DnrcI7wxZ78e4anLAk/BFYxcfgpt1jDLz2DR+xbFzfKPpMseR4Qmj2GuYWckVoYl/
 peBXvtfFYdsQHCGOxCPjBxisiby7OAJljm5SCT9ELo5klc9z5GQD4dnVkdI7BDTygGYHyqW4Fb+
 AFmgmJ75iBKprmA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial sound support to Acer Aspire 1.

The following sound devices are enabled:
- External stereo speakers
- Headphone jack
- Headset microphone
- DisplayPort sound*

[*] The DisplayPort itself is not yet enabled as it depends on
the embedded controller, which will be added later.

The stereo DMIC in the device lid is omitted from this series
as it requires introduction of the in-soc audio codec, which will
be done later.

While at it, also enable the PMIC RTC that, while is locked
by the firmware as read-only, still allows userspace to track
time with extra tools to save the offset.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Nikita Travkin (3):
      arm64: dts: qcom: acer-aspire1: Enable RTC
      arm64: dts: qcom: acer-aspire1: Correct audio codec definition
      arm64: dts: qcom: acer-aspire1: Add sound

 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 174 ++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)
---
base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
change-id: 20231027-aspire1-sound-53a4c06ac9fd

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

