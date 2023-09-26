Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1D7AEEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjIZOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjIZOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:43:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082E10E;
        Tue, 26 Sep 2023 07:42:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B10C433CA;
        Tue, 26 Sep 2023 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695739377;
        bh=uMjIAFfVnuWj2Z28spkl8zPcFTWWFYCo1rAP0UtIQ9M=;
        h=From:To:Cc:Subject:Date:From;
        b=LyaBuSKfQXWP56qsP4GUXh6c9xYn3Stl0nrozbD9NELYcX9GWWfrHRN1c+LaWHTQC
         ujH8Cd2PSKwwC8TyhjQITk4d+9MgHe1mvI1/Rx6ZPgmilP/003ndSf0MlMF2Y8vVL9
         0ioejwwvksqZBC3U1zlDeS4KQnZxWVns7TtNdUCc7xt4GS14zbxeyLV44QpswFtls2
         ecbJi85EWYNEC3TzGrwGyyfwgK4kSvZIG5WzmphClQfdJrrs0HBGRdjS/ETaS00QR/
         TMShVThH2OAz0Eidx7ZpHGyXl1lLuj9FF34xyxbgqDKaGSGjw8uoroLYuriUc4XqUS
         MURD2f38J/O+w==
Received: (nullmailer pid 4053487 invoked by uid 1000);
        Tue, 26 Sep 2023 14:42:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: syna,rmi4: Make "additionalProperties: true" explicit
Date:   Tue, 26 Sep 2023 09:42:44 -0500
Message-Id: <20230926144249.4053202-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it explicit that the not yet documented child nodes have additional
properties and the child node schema is not complete.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/syna,rmi4.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
index 4d4e1a8e36be..b522c8d3ce0d 100644
--- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -164,6 +164,8 @@ patternProperties:
 
   "^rmi4-f[0-9a-f]+@[0-9a-f]+$":
     type: object
+    additionalProperties: true
+
     description:
       Other functions, not documented yet.
 
-- 
2.40.1

