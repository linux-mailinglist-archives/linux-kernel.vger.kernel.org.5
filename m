Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98475FAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjGXPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:32:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DAB1B3;
        Mon, 24 Jul 2023 08:32:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fd2f298712so13734485e9.2;
        Mon, 24 Jul 2023 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212742; x=1690817542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLAkbsYK7QIyvj28dGSLrTuJv0qXZGTFq3rKFWJSTa8=;
        b=AnB+05knb3qUpk3tgMEV76tSVJNMy4NFF1nCvQRvZp8KJfQFQgEQwzRWUKGTVhdnzy
         /h0ZwqLtXhp87T1XnU1FWg6VPt/SixTmvEHsAI2B8fHAMNFp0EjMcEiD78fMLsGRaBMD
         q/zzKiq4iPR4M4XqwiwkpyRNSwUPfyQPjwhWxIaLniP01aCeBJEeChUTTiu6ol7DL2iZ
         TmqAIkkJ82+IpPRSkKalt8klg0hDiS7kEO/TmgdUzE+BWnviES6WWXqHmzyL9R0jr0/d
         5bqy81GLeqbzRP9couiZ2KnfjiGIkNW8XbsoTbh/rZajFFs7L0VIvW5/o/zHDibe8tdC
         yAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212742; x=1690817542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLAkbsYK7QIyvj28dGSLrTuJv0qXZGTFq3rKFWJSTa8=;
        b=BRD0Jx+Np+oDzqnnZK6mYtsGL5eODXxwPgD+3V0uV6/+9txqpduSue3RVD7Z4Wy438
         anV39wlPvUg25bZXwZcFdY3BumJzNrkJ6PycJaHRxVv+kCUe1U0KzO+9TQRwFNY8WZj/
         nEz0Xh/loKNWCQL+V3n7XhMdEWu4n34/ycuj+SkymYUIUzJZ8kbG0h88LHm0+FMt/M2P
         cMVaxh4sV8sjIYfHsFJkBG8+RJsZYv6mh0C2WHhu9w/sgh+rlPEjoPdGYdepMK9SXthG
         +Tny6I9GsrQcaAngJd/X2xw28NFBotrgfTmVfPPynEM15oiS5SGpjl2m3WyucTLXdTFA
         CYIQ==
X-Gm-Message-State: ABy/qLZaWIx0qKtwyVQ2+jLqTcJOr2gxFxVseXarWjadDbGYncPJNNI5
        iAPpXpQygHxOr++rcy7bnB0=
X-Google-Smtp-Source: APBJJlFzUChT3stE+hWXYTvd8qsZM9EcHcQKmn4J4SGmiACu+AiMweUAUZKJjx/4+C6zxE3hdiZeuQ==
X-Received: by 2002:a05:600c:446:b0:3fb:fda1:710c with SMTP id s6-20020a05600c044600b003fbfda1710cmr5821024wmb.2.1690212741966;
        Mon, 24 Jul 2023 08:32:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l8-20020a7bc448000000b003fb40ec9475sm10676900wmi.11.2023.07.24.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:32:21 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/3] nvmem: u-boot-env: Handle "reduced" ASCII address declaration
Date:   Mon, 24 Jul 2023 10:26:32 +0200
Message-Id: <20230724082632.21133-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724082632.21133-1-ansuelsmth@gmail.com>
References: <20230724082632.21133-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing ASCII values is hard as hex values can be declared in many ways
and OEM never follow a genera rules. This is especially problematic for
parsing MAC address writte in ASCII format where an hex values can be
written in 2 different format:
- a Full format with leading 0, 01 02 06 0A
- a Reduced format with trimmed leading 0, 1 2 6 A

The current U-Boot-env driver assume that the Full format is always used
by parsting the NVMEM cell size and expect always the form of
XX:XX:XX:XX:XX:XX to pass it directly to mac_pton that expects this
format.

Reality is that it's common for OEM to use the reduced format resulting
in MAC address in the format of XX:a:XX:XX:XX:XX:XX or a:XX:XX:XX:XX:XX
or XX:XX:XX:XX:XX:a.

To handle these special format additional care is needed.

Some additional logic are added to "normalize" the MAC address in ASCII
to a format that is accepted by mac_pton.

As using the NVMEM cell size is not enough anymore, some additional
validation are done by checking if we have at least a format of
X:X:X:X:X:X by checking if we have at least 5 ':' char while checking
the NVMEM cell. The size validation is changed to check a range of
ETH_ALEN + 5 (assuming a min valid MAC address of X:X:X:X:X:X) and
the full form by checking 3 * ETH_ALEN -1 (for the full format
XX:XX:XX:XX:XX:XX)

The parsing function try to be as redable as possible while saving some
code duplication and skip the use of memcpy function as the post_process
is called very little time just on driver probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvmem/u-boot-env.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index b64c37308789..e33565e872f8 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -76,12 +76,58 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
 						unsigned int offset, void *buf, size_t bytes)
 {
+	u8 *src_mac = buf;
 	u8 mac[ETH_ALEN];
 
-	if (bytes != 3 * ETH_ALEN - 1)
+	if (bytes < ETH_ALEN + 5 || bytes > 3 * ETH_ALEN - 1)
 		return -EINVAL;
 
-	if (!mac_pton(buf, mac))
+	/* ASCII address might need to be normalized, try to parse it */
+	if (bytes != 3 * ETH_ALEN - 1) {
+		u8 tmp_mac[3 * ETH_ALEN - 1];
+		int i = 0, j = 0;
+
+		while (i < bytes) {
+			/* First check if we need to handle a reduced section
+			 * or we are handling the last byte.
+			 * Example of reduced section:
+			 * - a:XX:XX:XX:XX:XX
+			 * - XX:a:XX:XX:XX:XX
+			 * - XX:XX:XX:XX:XX:a
+			 */
+			if (src_mac[i + 1] == ':' || i + 1 == bytes) {
+				tmp_mac[j] = '0';
+				tmp_mac[j + 1] = src_mac[i];
+				if (src_mac[i + 1] == ':')
+					tmp_mac[j + 2] = src_mac[i + 1];
+				i += 2;
+			/* Handle a full section or we are handling the last 2 byte.
+			 * Example of full section:
+			 * - aa:XX:XX:XX:XX:XX
+			 * - XX:aa:XX:XX:XX:XX
+			 * - XX:XX:XX:XX:XX:aa
+			 */
+			} else if (src_mac[i + 2] == ':' || i + 2 == bytes) {
+				tmp_mac[j] = src_mac[i];
+				tmp_mac[j + 1] = src_mac[i + 1];
+				if (src_mac[i + 2] == ':')
+					tmp_mac[j + 2] = src_mac[i + 2];
+				i += 3;
+			/* Return -EINVAL if we have a not valid ascii address.
+			 * We can use the logic of missing ':' to validate a
+			 * correct ASCII address.
+			 */
+			} else {
+				return -EINVAL;
+			}
+			j += 3;
+		}
+
+		/* Parse the normalized mac instead of the nvmem cell */
+		src_mac = tmp_mac;
+	}
+
+	if (!mac_pton(src_mac, mac))
 		return -EINVAL;
 
 	if (index)
-- 
2.40.1

