Return-Path: <linux-kernel+bounces-157038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04648B0BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5435B211B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3315E219;
	Wed, 24 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9XjSCXi"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DD15DBBA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967555; cv=none; b=N82H+tBbn9i2QLOui7NlKB27uUP7TYCSczaKdLzCX78374CFgSbI5zEX0PEzi2CUVZqzzC/YT78VMT+SdXI6lrI+3vg9QVocXnlPbst5zMJuz4rac9ZzlAsSwgNZoh0fIt4481LOfH3tzsWQzocRWiP4rLDkxLBhFTuCTn7TWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967555; c=relaxed/simple;
	bh=pzM2Ee19i9xuwdVm7wtL/DpLvEo5jssFTnFEbmrlKz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O98yw9KJACepSzC9e2+rUVWVgfvb+vgoIU34kHksfgblyi9zICnGQTAX8EeJnP5xXbHRv0tlZr6VRGIcRAAQbqF1q+Cz43FcD9lfcN8IzE07IQqPtJC+3Ku/NlFDhyjnQRMM8tFxL01YEBRDLe1rPja4jXiOYNSXlFzl5msJSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f9XjSCXi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343f62d8124so5626155f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713967550; x=1714572350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO2qseMnEiNi51iZjrOv5zkQ/0iFN3HnTr7pOyrnOgs=;
        b=f9XjSCXioYNhcWvXb6pmpWn65sj9gPjjJxZDLYHaYFCFnanuvG9Hn/Av7k6YVf9o14
         B5Gs0Lb/nI8HL6TIwugOUb76/wnvuJipyIMJOXgeMrDQ1/Ki8gQHD84GnvgDOuYaJWmd
         9BYiSxLPdKq0GJOLsaGWbW8wSMKlHbtqeU5kQ/hCP4igE/Ti+q2412jwSrFKB2VD4yMf
         DdtaMco3QkQOXDHnCkaHA5jSg9hoBalo3dCa6kTxF6NHu3NgHVnHRUc9XPaxk2UNFHNx
         r9k6xhiGwykFKzXkkmLz4uNwPxDkOhyFEGqZ4nY+6S2CaBgtBNU0NmyUOyXJUhncDfCK
         Q9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967550; x=1714572350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO2qseMnEiNi51iZjrOv5zkQ/0iFN3HnTr7pOyrnOgs=;
        b=vjbhGT0CqZKiI38oRXHkCvQOhLG8GbXq3B4Fq+TZqEVrdbfiRmjf43GRc6hlNKZtMv
         t8dLAd2RpU7KGM84W0ozt1yqDF2JwlTrn1SZ8e1T8f6NgpMYA7EmnsKSl2gfk5ck6Q7w
         C67sg42nUS5l6bBpXZYUUX3ZsfGMqCNvPdfEWI5YheemztLE4vhZI2PLjssK8Mg9RNA0
         vq4EG2D10iQAXukdgkCSG69kHavMcE5ArZAEUz2ndyj3oz5MuDSmIT1fShvURJK7PKtX
         8UQRYrSLLIskqt7Ddw3gCafCe2Hv4EP5R9tjLvVeuXVJbKg35NJthpyJJ2HlvaLLUxpb
         tDcA==
X-Forwarded-Encrypted: i=1; AJvYcCWHCizikdAoDz+fpuzhQK520j3Ls/O2EdHZfgG4rGLmJk9OpZv4neN1FQRTHFZPeVMcu7CiaPiR1SwFbVSQCBQBpnxA7xjb0ku8ZfGd
X-Gm-Message-State: AOJu0Ywpbtf7rD29OeRsfkZBiCFEgWHJXx13owIL0AfpPL4gTtfvjTbi
	laMKJt0wfTGsnJybIyPU/glb+f7kkpgn2/tsg5psas9caqKCZDZF6ZStKbVJre2BnHZTLkikKlj
	m4cw=
X-Google-Smtp-Source: AGHT+IG4FtWF4GLSRqwunMp9Dp7ZmNUSmYCWY3Ci5BIcaqIjosU7J9HsN8aw6mTgzIHb0p4bdhMnoA==
X-Received: by 2002:a5d:408d:0:b0:34b:b0ac:c63c with SMTP id o13-20020a5d408d000000b0034bb0acc63cmr1766527wrp.66.1713967549826;
        Wed, 24 Apr 2024 07:05:49 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm9105325wrs.108.2024.04.24.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:05:49 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:03:34 +0100
Subject: [PATCH v3 1/7] kdb: Fix buffer overflow during tab-complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdb_read_refactor-v3-1-f236dbe9828d@linaro.org>
References: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
In-Reply-To: <20240424-kgdb_read_refactor-v3-0-f236dbe9828d@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=pzM2Ee19i9xuwdVm7wtL/DpLvEo5jssFTnFEbmrlKz8=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRFeBl7WDOxk6g2Vz1ghh35u91oebBU7XTmKb
 eGAWsdXcFWJAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikRXgAKCRB84yVdOfeI
 odcZD/wNGGoEPbgv3vkcFidVOxzNb+ZDeswc+rrXpA9em1dPd7pWJyJNNjW7V8dH2A8vNlyRzJM
 nHjNW2jzFgd1Kci6i5IXSAY9WtbRlMIzwW05tyCPX7Y90JriEepDE+rnPFV/mgl4OKYlihJ/4w4
 QzrPADJ6x9Q/+WKg1hu9sQBhT9msg1JS1ruCiAMzSG6eU2W8r2eNtKHlBiyDa49Bi6pMip9Igdg
 sblCHRpsLmWF6wO8YZMqToE3jjp/tbjlOykkiuAE2djgVEUHgxLTAmpVYVObwf1AfJZlhEbTgFb
 m14g4bV8FPfvje0AoLb4lwM/s0nngV5d+ddUUn9jUJMi/Xq7xeyW81YO7Cz1cdupY2RVCbHe7vP
 tzzMuN7K3fH7ZOutVmV0Z6ooubU/03li+u7kfFKp6v5BHvA4aG0xB7p0j9k3S80ibxUxMkrLyHV
 qGcQp5fZBnqYnkXqm/xrK8nnoT1FA661h7QTND/hs7EFEwLP8iEQD1+xIr0vxLhOCicvTfCZUlI
 zuVf7WmSFiXv5jHc6OKgxf9CLpQMifkADPqziUDKIVV3yTM8WI868/GEI/zy7TxO32r/5q/pceM
 Es4HFumgKjjajRixUEuTVJoJD1ezkci4ccm5uaQGVLxmmExhSd4Gm6PF0o8V2zQc7x9goo12Dgy
 DNtXUsXfO58HZYw==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, when the user attempts symbol completion with the Tab key, kdb
will use strncpy() to insert the completed symbol into the command buffer.
Unfortunately it passes the size of the source buffer rather than the
destination to strncpy() with predictably horrible results. Most obviously
if the command buffer is already full but cp, the cursor position, is in
the middle of the buffer, then we will write past the end of the supplied
buffer.

Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
calls plus explicit boundary checks to make sure we have enough space
before we start moving characters around.

Reported-by: Justin Stitt <justinstitt@google.com>
Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Tested-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 9443bc63c5a24..06dfbccb10336 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -367,14 +367,19 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				lastchar += len_tmp;
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;

-- 
2.43.0


