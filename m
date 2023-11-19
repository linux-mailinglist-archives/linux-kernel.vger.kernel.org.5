Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18B7F0955
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjKSWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjKSWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:14:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1E137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso894173f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432078; x=1701036878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GBQ+8VOCybaBixFJ4dT3fSyoQYw2g31FmVcURyPmuM=;
        b=jMlxFV3+yyF5HmJM3Z3as8ZAJAePssaaSHZ8msp7nomM7WEbqyZPvoD1QaOVm7mcLn
         PdXpAjPWHXifDw0+6cvd7jvCZwQfiKOFNrxjO1lAh7Ly0YpJV9+BQDwRGu2yFxQPcKr3
         BZkvCMj6zY11axaQ9SNbMj5p/s9knJhtWTdByapeqGqrl8NYTl4KwCbDlmN8oq/g5waE
         629VbRRVstWx4u87FKSAoaEZwwgWf08FtY/aKh4j8T5NH26tBB5itXecU920HqQjNDhw
         6GhGJKF1Th2oZrsLT01xFwzZ1x1PmUPDvsbKSSOL5jRQNZVlQXickSJ3pSbt70Zfgaix
         XaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432078; x=1701036878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GBQ+8VOCybaBixFJ4dT3fSyoQYw2g31FmVcURyPmuM=;
        b=R5H+QhP2YzMQ4kMdQdAi3feYADkRiPCuRve48kTKBRmS0n8GqjcwyW3qq9DcOKLJrc
         SAi1QCd4Kp32HITHWNw/Yx+rfzi/CFLjHSpmragNqwLNpnur1L0B4SETlvGmWKT3ekSC
         jr+8R1c7jNznPfQ40T/GxkfyT3Sl3FoEioqrNu+zi9+U2ZJ56ehSH423o7UxBsXe28bh
         L269l4ODeEP38FlifPjqup0VH+wnEBrROIZG2vLbOUIJrZIeqRK4wfdfhDtBzIeragoa
         MeCoWZ4oL1C6jca5N1THKK2B/m+chsjdjNG4qsWD5LY/hqTcQntdhBVEh9uie1c3ZfaT
         mOFA==
X-Gm-Message-State: AOJu0Yxib3SXcOhYOHJurl4L3+Xh1YpFD9cuGaOmFIj2V/brwAFQZXcs
        0vv2Fr7BrvKsKri3eJnPhkc=
X-Google-Smtp-Source: AGHT+IHqraCUCVq10Sx1RbuDHA6IvH9HLv1tm5G2LD9uSOxzqC97kc2D+HbN3v89e5eoSybangA25g==
X-Received: by 2002:a05:600c:4590:b0:40b:2078:b8e4 with SMTP id r16-20020a05600c459000b0040b2078b8e4mr1748962wmo.1.1700432077721;
        Sun, 19 Nov 2023 14:14:37 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b004063ea92492sm11356777wmq.22.2023.11.19.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:14:37 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:14:36 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] staging: rtl8192e: Remove unexecuted
 rtllib_extract_country_ie()
Message-ID: <7b88c62d3cc5c3fb670b5448c7381c7c099b3518.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable "enabled" is initialized to false and never changed. Therefore
IS_DOT11D_ENABLE(ieee) returns always false. Because of this all code in
rtllib_extract_country_ie() is never executed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 31 ----------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ecaa4dec3f94..d9517dbc5593 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1663,35 +1663,6 @@ static const char *get_info_element_string(u16 id)
 	}
 }
 
-static inline void rtllib_extract_country_ie(
-	struct rtllib_device *ieee,
-	struct rtllib_info_element *info_element,
-	struct rtllib_network *network,
-	u8 *addr2)
-{
-	if (IS_DOT11D_ENABLE(ieee)) {
-		if (info_element->len != 0) {
-			memcpy(network->CountryIeBuf, info_element->data,
-			       info_element->len);
-			network->CountryIeLen = info_element->len;
-
-			if (!IS_COUNTRY_IE_VALID(ieee)) {
-				if (rtllib_act_scanning(ieee, false) &&
-				    ieee->FirstIe_InScan)
-					netdev_info(ieee->dev,
-						    "Received beacon CountryIE, SSID: <%s>\n",
-						    network->ssid);
-				dot11d_update_country(ieee, addr2,
-						       info_element->len,
-						       info_element->data);
-			}
-		}
-
-		if (IS_EQUAL_CIE_SRC(ieee, addr2))
-			UPDATE_CIE_WATCHDOG(ieee);
-	}
-}
-
 static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				      struct rtllib_info_element *info_element,
 				      struct rtllib_network *network,
@@ -2146,8 +2117,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 		case MFIE_TYPE_COUNTRY:
 			netdev_dbg(ieee->dev, "MFIE_TYPE_COUNTRY: %d bytes\n",
 				   info_element->len);
-			rtllib_extract_country_ie(ieee, info_element, network,
-						  network->bssid);
 			break;
 /* TODO */
 		default:
-- 
2.42.0

