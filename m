Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9B793EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbjIFO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIFO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:28:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792410E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:28:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so3076814b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694010517; x=1694615317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6HeleQWw0Y9XHoQUK3nM3UW0QTq3DvRuCxNVLyqk2w=;
        b=Z2q+hMxYG7IJ/T7s52U2e/6oyZQbztQNtxXIlzJ6ipxrdROg7x3Hz4RTQOHD50lZ1p
         4zZai7YJ0ijdKoqHg2QorZ/lFAHh8tP3UR3LBVFdeLij8NqHdNMP9O2mASRjyqk1wG3T
         T9/A1CtYH+KU0CAQt9aBIvoDeVmN+0Ldk39BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010517; x=1694615317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6HeleQWw0Y9XHoQUK3nM3UW0QTq3DvRuCxNVLyqk2w=;
        b=YmN07oD54PuzPUrfNzPqnM5cXnLTIq51XGPhSed56i9rydM893QyAB/5dXJMdr/Kco
         cIdlcBmpzttCREUe2gu3aVZSAgGA3jPYYZrm4yWI43OET2gdE/HegbHNi0JwW4h5Z7lj
         240aAdVyCX0vbY7UM9Rd9ocBBVouy5YCj7BF2z6OyPtkDHuzfNZoj8jNrmpCGdyNBRa5
         BITpn7XcU2a1mxsN6jwHVRsU/BIrnaKpgaJm1/3AtZLO657deMXSiXhQNWFRR/qdNw1w
         0DbZvy77yIBTUCquQiObJUIrN/RdPsvuMXQeVpW4GEaZy7nvvRSc9mGIkEGQihOhR3UM
         7ERw==
X-Gm-Message-State: AOJu0YybbLLyIxoyNPaH+EiFg7JJcFW2WwWI3Vu4X5aoXFS4HHZk86hb
        ksREaSx1ZH2mqTuyPbM78QkZFQ==
X-Google-Smtp-Source: AGHT+IF7mOxXDB0NXRxhuQI4L0nXdWHrGcl43+W7501XqvJ8gv9aJTJWLtT8+XHIqibH5Q0caQSQgg==
X-Received: by 2002:a05:6a00:330f:b0:68e:290b:bb57 with SMTP id cq15-20020a056a00330f00b0068e290bbb57mr3498614pfb.18.1694010516829;
        Wed, 06 Sep 2023 07:28:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4a07:e00a:fdae:750b])
        by smtp.gmail.com with ESMTPSA id p20-20020a637414000000b005703a63836esm11393807pgc.57.2023.09.06.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:28:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update DRM DRIVERS FOR FREESCALE IMX entry
Date:   Wed,  6 Sep 2023 07:28:03 -0700
Message-ID: <20230906072803.1.Idef7e77e8961cbeb8625183eec9db0356b2eccd0@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the discussion on the lists [1], changes to this driver
generally flow through drm-misc. If they need to be coordinated with
v4l2 they sometimes go through Philipp Zabel's tree instead. List both
trees in MAINTAINERS. Also update the title of this driver to specify
that it's just for IMX 5/6 since, as per Philipp "There are a lot more
i.MX that do not use IPUv3 than those that do."

[1] https://lore.kernel.org/r/d56dfb568711b4b932edc9601010feda020c2c22.camel@pengutronix.de

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'd expect this MAINTAINERS update to go through drm-misc.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a6b229b820a..ea69720f1552 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6899,10 +6899,12 @@ F:	Documentation/devicetree/bindings/display/fsl,dcu.txt
 F:	Documentation/devicetree/bindings/display/fsl,tcon.txt
 F:	drivers/gpu/drm/fsl-dcu/
 
-DRM DRIVERS FOR FREESCALE IMX
+DRM DRIVERS FOR FREESCALE IMX 5/6
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+T:	git git://git.pengutronix.de/git/pza/linux
 F:	Documentation/devicetree/bindings/display/imx/
 F:	drivers/gpu/drm/imx/ipuv3/
 F:	drivers/gpu/ipu-v3/
-- 
2.42.0.283.g2d96d420d3-goog

