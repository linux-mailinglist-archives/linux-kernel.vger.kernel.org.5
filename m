Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF779AEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354346AbjIKVxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjIKJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:02:29 -0400
Received: from out-217.mta0.migadu.com (out-217.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66129CCD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:02:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694422942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ncMOdzmNge2dDHCrVx7yTH1c7a8W2V4JG4MDc4VOKkU=;
        b=z3iyY7ndOuW/FUIIBXdRnFOdp9wfaw9gmT1bCa2W30gMzXqJMIIyErsHBSgxs0FLur0BFL
        1gvz0JJ1jUBeGYvxsh0cBm3IztN10B3UTRzOzWvGdMX5+0WjDkNz0VzPnu7t6++P87W7RD
        E53rNR2IN2bQzpadeGj7eZpLep3xKmWE/1/gYepn1Yy+aghiQ/OBzROUnl5t20FdW9h/u2
        B0IlclixsKj0wKcixKfKt45d008w1w2j0IxklcjNu82lXRF5/9raYl19XFLvTb8OSDd/i3
        s0UjmLAM1eH0306WEODRhnAkJ4LskKZydU3udWRLnodAVdt4KU+u8KHJ6gTYMA==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] Add FS035VG158 panel
Date:   Mon, 11 Sep 2023 19:01:58 +1000
Message-ID: <20230911090206.3121440-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I have recently done some work to get a new panel running on the kernel.

I am completely new to this kind of work so I don't know how to split my
patches up, especially as I did some light refactoring and fixing on the way.
These changes affect these existing LCD panel but should work.

I'm also not sure if this device tree yaml should be merged with the existing
leadtek,ltk035c5444t device tree yaml.

checkpatch has also warned me about updating MAINTAINERS for the device tree
documentation but I'm not sure if that's relevant here as I have put my name
in the documentation itself.

Thanks for your time,
John.

John Watts (8):
  drm/panel: nv3052c: Document known register names
  drm/panel: nv3052c: Add SPI device IDs
  drm/panel: nv3052c: Sleep for 150ms after reset
  drm/panel: nv3052c: Wait before entering sleep mode
  drm/panel: nv3052c: Allow specifying registers per panel
  drm/panel: nv3052c: Add Fascontek FS035VG158 LCD display
  dt-bindings: vendor-prefixes: Add fascontek
  dt-bindings: display: panel: add Fascontek FS035VG158 panel

 .../display/panel/fascontek,fs035vg158.yaml   |  60 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 521 +++++++++++++-----
 3 files changed, 444 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fascontek,fs035vg158.yaml

-- 
2.42.0

