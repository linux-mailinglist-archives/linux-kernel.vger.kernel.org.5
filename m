Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D579415A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbjIFQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjIFQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:23:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21C1997;
        Wed,  6 Sep 2023 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694017402;
  x=1725553402;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=znBSTq5RS9Z8jmekHXsRIOZBs9Z3TiIq9C1uuLxH85g=;
  b=KL7jzHYoCDYJuMsVCvpGQJESyxkGyLt2LtTuLqj778mXwUajuH9zEtHG
   5oo+E5V7/7JOzkF+u4fuYVUqm+NK0aMne5w4bzcOa65GA2Lr/9045olil
   qBlqCUjRuERRBMDeuplNBxcuEKuSDsnBiqm+AvK5TcgszTobcOZSCHWAF
   y2gp6kulWpFih6HkL0+87OC2c2Q27kmHqM868vbFjcOWHJgIZtRnpR4xt
   nzBuQ3DKT3XXtQwyg/GOJFIgLr+v8IvSKdckUmUVvuskpdu15WOjsgaFz
   ljLkaH0cWtflyIy9WZY8ntT5GB6+25Ky14JuPtyj7ozudTClUuCGExs92
   Q==;
From:   Stefan x Nilsson <stefan.x.nilsson@axis.com>
Subject: [PATCH 0/2] Add st7735s drm driver and Winstar panel
Date:   Wed, 6 Sep 2023 18:22:15 +0200
Message-ID: <20230906-st7735s-v1-0-add92677c190@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADin+GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyNT3eISc3Nj02LdtCTLVCODVAtDAyNzJaDqgqLUtMwKsEnRsbW1AAP
 mLhlZAAAA
To:     David Lechner <david@lechnology.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan x Nilsson <stefan.x.nilsson@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for the Sitronix st7735s display controller
together with a 0.96" 80x160 color TFT display by Winstar.

The driver is very similar to the st7735r driver, but uses a
different pipe_enable sequence and also allows for an
optional regulator to be specified using devicetree.

Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
---
Stefan x Nilsson (2):
      dt-bindings: display: Add st7735s driver
      drm: tiny: Add st7735s driver

 .../bindings/display/sitronix,st7735s.yaml         |  81 +++++++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/tiny/Kconfig                       |  14 ++
 drivers/gpu/drm/tiny/Makefile                      |   1 +
 drivers/gpu/drm/tiny/st7735s.c                     | 264 +++++++++++++++++++++
 5 files changed, 367 insertions(+)
---
base-commit: b715dcd3db4a9a57b3fbe7820db37cae930f0867
change-id: 20230825-st7735s-fb9e20e81027

Best regards,
-- 
Stefan x Nilsson <stefan.x.nilsson@axis.com>

