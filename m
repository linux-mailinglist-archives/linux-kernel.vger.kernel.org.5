Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAB7A4A72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbjIRNBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbjIRNBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 09:01:13 -0400
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [IPv6:2001:41d0:203:375::e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381F11C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:59:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695041955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BEh2hV3TzTOBIIrOtmIqsqf5lqlafqT2o4G5jUNVHEY=;
        b=dojQryMs9RN5bbOVgqK0uF0bNwkLsX/9J2WJgfRSK9bbNtix8GVX3KodBeRRVx0f25NMSl
        gpqzBE5DI0nqmSn1+QbJwnIv8QU6liGsWM/mOH6F6uUL/9pz8kqnh9urdA1v9tOS+MI6+g
        OZcBQoAtiAQhH4Ef7z6k4VDUYknsYLbbe0lnzFCt82TOCGSU1cyi6SYCE0/jNJA6UWfC7P
        jNsiDI5KWywuFvYpblM4vrNjsk6/n5oI+Va7vEL0dzkQad1BomSt+019mV7W0jX2MkrgMI
        P4mJh3yEH6JMl14oXRsDVtU0w6nIsuKeu69itn08aEoPkGxTt3qKZV1kA5SEBw==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/9] Add FS035VG158 panel
Date:   Mon, 18 Sep 2023 22:58:44 +1000
Message-ID: <20230918125853.2249187-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

This RFC introduces support for the FS035VG158 LCD panel, cleaning up
the nv3052c driver on the way and documentating existing panel code.

John.

v1 -> v2:
- Fixed a variable declaration style error
- Cleaned up device tree yaml

John Watts (9):
  drm/panel: nv3052c: Document known register names
  drm/panel: nv3052c: Add SPI device IDs
  drm/panel: nv3052c: Sleep for 150ms after reset
  drm/panel: nv3052c: Wait before entering sleep mode
  drm/panel: nv3052c: Allow specifying registers per panel
  drm/panel: nv3052c: Add Fascontek FS035VG158 LCD display
  dt-bindings: display: panel: Clean up leadtek,ltk035c5444t properties
  dt-bindings: vendor-prefixes: Add fascontek
  dt-bindings: display: panel: add Fascontek FS035VG158 panel

 .../display/panel/fascontek,fs035vg158.yaml   |  56 ++
 .../display/panel/leadtek,ltk035c5444t.yaml   |   8 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 520 +++++++++++++-----
 4 files changed, 441 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml

-- 
2.42.0

