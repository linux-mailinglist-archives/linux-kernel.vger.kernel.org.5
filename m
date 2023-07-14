Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2C753C18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjGNNvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjGNNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7335AC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992ca792065so258851066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342691; x=1691934691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urifUudkEPyq2FzlaT1w1iDQxgnQEtIqwDDZrLy2t8E=;
        b=HoaYNMUc+3aRJuYOwNmUedlSGEpUBUGY6lxQ/zMGvOj9K2wQntSgnZkBPOSKVBU3n9
         JOvML0jRSQx9AFX+U5PqI7PKiQSTaXK1lU7Dy/gIxiq58+VImnTu2PfOsBg5IpZI7VsK
         q3ulnWZAbSdgguL2WOpDHUaXFDAJj0wjLYErKrHkU/vRdKd/ZCqrP0XfIsws61YnV9Vx
         xGpfr7pSgCyoguvUWuGLjnubcw/zm1ifpg/0MFj7sMwdRoA/yO5g2essZAU7CA/VYFIl
         8RzBub+t/S83+3GlRVYB1TLsoYZhmkHzYSA2vZs3sz4JGC2q3tg1JgEoPyaV+cs//2g1
         pYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342691; x=1691934691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urifUudkEPyq2FzlaT1w1iDQxgnQEtIqwDDZrLy2t8E=;
        b=j5nhusaCbXVmhUj14AgJh+w50GxH0P+9r9d2IaMYR60XWFL9P/kuTwQkb1fVVWPydv
         62dac0y9pLn0/r27wMY8dsGXGEoBcdSfGTIi0Pb8ZnV1ja5lueCaTGRtKp3uNB+yFzgD
         bLdD6hG3t0dUkUfai5/e3dxbMVjQIPIhFBnPW7RxYLc+Zvxh9eO2+E7yfbbRVoLdRYzd
         lA+x27bIe/8/Vj+jkDVaJk3CzqZ55fwcxKhD9e6ixfg4iNX3wUgryoJxoNnPDR/vs/Rg
         I2mkSG2Xu+ndsyi/sHkm84PDnQ6yIY+HzpK9mOnbluWxIiJO7C8HBF/YitSNheJfx30R
         yCnA==
X-Gm-Message-State: ABy/qLbrQe75yfgUEkr6Bwqkd5S35vk2Zf62/yt7rh1pOJXjn4HvMcTF
        fb6rCH+cmoyby2Zi1YBHyKKruA==
X-Google-Smtp-Source: APBJJlGAmr0/UJAC8kytY2+fUeQfkDE7VGTOGWyv7yqIHO7IS3vrc7CDFjtiUckxYVrj8UVqqkr0DA==
X-Received: by 2002:a17:906:57c7:b0:991:fef4:bb7 with SMTP id u7-20020a17090657c700b00991fef40bb7mr3750894ejr.73.1689342691040;
        Fri, 14 Jul 2023 06:51:31 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:30 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/8] dt-bindings: trivial-devices: Add MPS MP2971 and MP2973
Date:   Fri, 14 Jul 2023 15:51:10 +0200
Message-ID: <20230714135124.2645339-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add Monolithic Power Systems MP2971 & MP2973 to trivial devices.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 246863a9bc7e..f639618508a9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -119,6 +119,10 @@ properties:
           - fsl,mpr121
             # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
+            # Monolithic Power Systems Inc. multi-phase controller mp2971
+          - mps,mp2971
+            # Monolithic Power Systems Inc. multi-phase controller mp2973
+          - mps,mp2973
             # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
-- 
2.41.0

