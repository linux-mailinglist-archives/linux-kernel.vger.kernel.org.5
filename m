Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB45C7EA098
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjKMPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjKMPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:52:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA0D79;
        Mon, 13 Nov 2023 07:52:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc394f4cdfso32545365ad.0;
        Mon, 13 Nov 2023 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699890738; x=1700495538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xj643O8VB6EKANmt6qc+gF+kehUK8LxYuY48YwpgjuQ=;
        b=drugjEUtJILMGOSgk3neSSjZSTtqhGIm/P+U2su7SwkTdz/f9ZjGbbpiV0abV1xzHC
         RIA9Ng9JcvFhF3RNWqNzx9d7JxvzdaVz+YjBdXF//Ynqfd64+FlIKOIjsYPL8EPfm8gL
         CQ1sNQdiVla/ypK3hxLU1tscEzn36JXuFVlYSxvnd77f+LKeuk6SimVGygHdtlRGybJM
         JZcb8MrxzuSwzRKrUwMpXjJGkWQ9Ms9AT1QroUc/c7omqtiaJtVOGzJABxt1V8AbcJR7
         jwJkHEEdLTTKimxAkm5uXZD3j6EQ9/H6hVI8Lu6qkjTxo/Jj8MKjkFSX5s+R2iiWafMC
         kV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890738; x=1700495538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj643O8VB6EKANmt6qc+gF+kehUK8LxYuY48YwpgjuQ=;
        b=tQSIORqIpUskQk1tnCLdHph7c8fxu/FsE+LYHqdd6XRqib6+igCjn8++JS6GEhLfAO
         Q5tmdvqPCFRaifQa398/TcsRIIw+aQJM8DnymZrIAkYGtmhMXgqQngDwYiclHqmGoCqc
         ec5fXNMkuvQMl1w7HJWHMVwN4vjCmivZhyxRIRPpYYmCTk12WNnlU+YhSxDZ/JTKR1Tr
         8se2ttk+CRWxdrPuyc60n9wqM0NqfLVgbZxKlQrEAwSV0m1pg3uzSFJgHyxorjcxSEOu
         sb0ziy/wLcJPxSIfYsZ/7/D3hRINMWktmNj/2sKWlpMDspt04QWlbnDwHLuxtle1clFj
         gHlA==
X-Gm-Message-State: AOJu0Yzhep9b198Xr7HMaghhS3vpzbpWAVK8c+N3lWY/V5LgELbE46Yr
        Vbeq8tl52as7KAciTDw8btA=
X-Google-Smtp-Source: AGHT+IEqK3KKoxEvBw7RSX8bFrW+34NpTW4iFPvzBIrlrLodgRk/CgcM3ZBR1p3rjL2VyCU9s+7ixQ==
X-Received: by 2002:a17:902:dacb:b0:1c5:befa:d81d with SMTP id q11-20020a170902dacb00b001c5befad81dmr6072197plx.10.1699890738517;
        Mon, 13 Nov 2023 07:52:18 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001c5076ae6absm4155925plb.126.2023.11.13.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:52:18 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Date:   Mon, 13 Nov 2023 23:50:07 +0800
Message-Id: <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree bindings for mp5990 device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7680c8a9b4ad..eb83ab4c02ee 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -123,6 +123,8 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
+            # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
+          - mps,mp5990
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
             # IBM Common Form Factor Power Supply Versions (all versions)
-- 
2.25.1

