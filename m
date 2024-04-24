Return-Path: <linux-kernel+bounces-157039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE48B0BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEDF2823C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438D15E7F9;
	Wed, 24 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JN4K+gAM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57381143878
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967556; cv=none; b=Ju8ypGWmXv9/aVnLzMc+c6q4yFXMyiD+3c3B+cnks0bfAQAh5QvchBdIdzqJ8ESw38SXuSQs+IDu/NhKGizVBvXI0OpofDBzyJEqZdDF4CelHeU0yV8HvFPxNBRVRycjrL/lJvw0tvPw4suPJ48KJXLHMevS/N7+I5QD2kGXLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967556; c=relaxed/simple;
	bh=pUuir1uu0AsFezKSVWCJ+HLjIqUcc98HfYuUzHwdnik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6bAKEcFbhb8Z3AOBW2f67gk9HPbjJkWMgwsGIpuDmmkJoAnN6hP0eZ6ct/7f9I9he1xjcb+G2L2SPCgSwTswcyqa1w8rpC4ftv5XGIWHUQ+N+8pz0d2SI+4UMgzLrHVjgvGo6fwgNdrNU1F3hXV1qfDRbuyLNwTwTT94PPRLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JN4K+gAM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b2119da94so2169485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967552; x=1714572352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpHsNOkxngtvba9wSq++zmIn8As88KCaI91fFzXimkg=;
        b=JN4K+gAMMB5YauThDrEgmuzfGxUTGN0YegMTcLohBstHKK/I+vMMkgiKAtKUYmQ0v/
         BVR8xcCSjAIFr8xxqB/kXJjGsltaDHxDf958ezFHiibWjeTbFr86k327h5c9ZZa2dzl3
         FEOjTA2aBKmnYC9FA07wAZGiI3PgYB9htUYlw3aBXwjvyOHxFbnn60nlSB9IRqNtAekf
         MId+ZDKCOillGzcwZKwN54m3XeS7uLL3LKVWrp2K73hO9MRBcobgL3TBSpK/DKzUY1mu
         AIZhzH4gVSSdqS6rgZmIZNQhlYsaU0WS+5EVzy4Odv6aLromF0rbPVr1iaMugjIca2Hr
         Q3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967552; x=1714572352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpHsNOkxngtvba9wSq++zmIn8As88KCaI91fFzXimkg=;
        b=NatQDI6g9ghGlYmB43sA0jqQTQTanQiRXNgbGnIJIJd/ZCihDVPPbp2vaazHPugUMo
         mlXfxy9ihbxvYGfxxnS2rXGB6tFJoA4F8Ffz09P56hIkWiZl2Qid0Q4samPlkS/Ol6eB
         IkttJ1qGhr4+jwB+KvEzA1iVg6iKTRjqf9Gt4NodF0t+4zjXG2vDEJ0K4ABTolexiOAc
         hfEcsFOsoev8HgA0FlwZEAOaZVZfwry98ZfbOl8oWjoH21fdv9DALwQU1bGfiHeQBQsB
         YB/oPrLXeMgBC9Ba4yKyhL6JHvgIgjkP4XLr6pObOqM5h2mmfmEXOwVONin+8wqdV3Al
         Aw4A==
X-Forwarded-Encrypted: i=1; AJvYcCWTD+L7G/YxsNYPh5Lyy3W5aVS+C1Q+wUkZu0FFLj1LjZ0v2lIpgCq5L5y5rnHh63Ld68mu+GY3eiBo5Z7SfmUoipTENfLil+rML43m
X-Gm-Message-State: AOJu0YwdV/jjuNdPFY1f0YptGOT+70umiXWfRR7ubZ5xhUW2m4QNVOPb
	uXD+GKdiNFrHR7cs370uivyxXkRoMVYtHNJL2xXMRrrpxY9zg2ZbDv3SWHz39bDYTCwog8yfJql
	EUjk=
X-Google-Smtp-Source: AGHT+IHrPrgSzW/eVw7jFZHVPCK2stE2i1eZs6gOPOq9XnTtiiffxLzlqTup/NIJDSvunaQRTGqq7w==
X-Received: by 2002:a5d:574a:0:b0:34a:e73a:56a3 with SMTP id q10-20020a5d574a000000b0034ae73a56a3mr1627330wrw.7.1713967551890;
        Wed, 24 Apr 2024 07:05:51 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:50 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:35 +0100
Subject: [PATCH v3 2/7] kdb: Use format-strings rather than '\0' injection
 in kdb_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-2-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, stable@vger.kernel.org, 
 Justin Stitt <justinstitt@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=pUuir1uu0AsFezKSVWCJ+HLjIqUcc98HfYuUzHwdnik=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRFrh6HPOcCklaq0yycGzE/JCVXYmszt3a2b3
 ez4yq9phveJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRawAKCRB84yVdOfeI
 oSo0D/0ap+RFd7GQkBARE2EvV7WKwb/s+o03JffFP+H5p7ja6NtXnZxw2vCbIgxiEa+SiqrfVGg
 yzaB8XzeG7cYtdaPgecedLfh5K1TbOsl+XwTvaLmIGC5Xtm607+HG+lGv327PjwGX+0pFns5tOM
 wRUYTWBHJel5K4vQbkNlCGBEiofmusoJysKAVhfDZ7lV23MoO5IYJ2LK+1et6dyHVcadeAYRqkS
 jpgJN81La4V6lDejD5wttUylt2l7nxsrjvVcydVhXPGxY7ZWgZRHC05DzLJePM+hQKANEeUDaqh
 mOyeA0tZKEUMftyKX3C/iwVUoSEvjJrgdgNC930zDugN162bUIj+yz2rqXjNmCZHh+rjEuYNDKZ
 5zlUw61uA1i3xJQifNTedO1YL0lS/+IurpfQ+XAiGBzUC2QadU5uA4OPk3ehLGWmo1AXEZ70ozV
 jMHZYX5KxbecN4V9KZh8p1D6cahJN2HLZ5oOeIp3jjv0GD3Bl+QQo2mIq1JRmfyliCm76mm3VRB
 j5hqskDS1vzo9kahcpwK4TPVe5R0Y1iaA+K86culQYQ2FSDbywkV9L3WGZvpUFCsMpVoqD5A59x
 Lv+9LXP2hbo4wVaObNRyx6vwMVhzAeXQjJKrF8pcn8kb6Q/Zp6wh65Gv0yoQ0kzy6R3Ej0Fib/h
 bqSnTUTmJdvcI6Q==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently when kdb_read() needs to reposition the cursor it uses copy and
paste code that works by injecting an '\0' at the cursor position before
delivering a carriage-return and reprinting the line (which stops at the
'\0').

Tidy up the code by hoisting the copy and paste code into an appropriately
named function. Additionally let's replace the '\0' injection with a
proper field width parameter so that the string will be abridged during
formatting instead.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Tested-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 55 +++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 06dfbccb10336..50789c99b3ba8 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -184,6 +184,33 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+/**
+ * kdb_position_cursor() - Place cursor in the correct horizontal position
+ * @prompt: Nil-terminated string containing the prompt string
+ * @buffer: Nil-terminated string containing the entire command line
+ * @cp: Cursor position, pointer the character in buffer where the cursor
+ *      should be positioned.
+ *
+ * The cursor is positioned by sending a carriage-return and then printing
+ * the content of the line until we reach the correct cursor position.
+ *
+ * There is some additional fine detail here.
+ *
+ * Firstly, even though kdb_printf() will correctly format zero-width fields
+ * we want the second call to kdb_printf() to be conditional. That keeps things
+ * a little cleaner when LOGGING=1.
+ *
+ * Secondly, we can't combine everything into one call to kdb_printf() since
+ * that renders into a fixed length buffer and the combined print could result
+ * in unwanted truncation.
+ */
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -212,7 +239,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 						 * and null byte */
 	char *lastchar;
 	char *p_tmp;
-	char tmp;
 	static char tmpbuffer[CMD_BUFLEN];
 	int len = strlen(buffer);
 	int len_tmp;
@@ -249,12 +275,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 10: /* linefeed */
@@ -272,19 +294,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -390,13 +407,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;

-- 
2.43.0


