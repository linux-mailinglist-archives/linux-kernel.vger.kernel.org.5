Return-Path: <linux-kernel+bounces-81069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF854866FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC431C2594C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F435DF2E;
	Mon, 26 Feb 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXmWn3Gi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CED5DF12;
	Mon, 26 Feb 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940363; cv=none; b=DSx2joSddIvsRTM585JEfD2vRLBeZls+n6/xpsUXrojGxuUULvs6u1JjVqCB0/IQVAVo4XKcjmctrV2XLKxSnTTIvGD/UqBz8bIs2RAQJRvQaWNRQVUdkNYAhilaPPU9SlfGnwh+ZaoA8YT0EKcHFO8fe0J3e8wCbMgdfKIJp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940363; c=relaxed/simple;
	bh=3sQIE5Ce5t4wLKok3Vp32KDZX/XtBqvN1n0Wh/SWVNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkcXIdg2xOJooyUhAB1fvulD/fnd6IPWsUw0sc8zmt/PkxHp6G1goucBGdO0cEEox/V0+Qe0rYTBT5dzqV7Mba/aBoDR1aQNEY9r4fuGKUcwH1cCgi5HMLWO3qOpam4LPAYQhKc4LYURhuGoSUyCxXmyGJrX3tqum8IBQrqV2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXmWn3Gi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e72ec566aso348518566b.2;
        Mon, 26 Feb 2024 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940360; x=1709545160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vawvIwXybApZ/749Z2EWmgW5ee2p21jliyJDHDQcteA=;
        b=aXmWn3Gie8XON7WCzheCzqAURX6yJP/B4yB445/SGjr3yPC1bbe/vtzonNg8ZaGS30
         9BGGGlCOvkDmtngY8w5Gz/xvevZulxfwV/IQ5WXU5Y3449ne64PgYgdmxQM4KsB+W97n
         XTWnUSAWxD6z0swVe704psVGOatwG7IHmt260ALO2ebPneEoef32Dw1GmWquWmtNtr0S
         OqQKTMNLlJsSbpAtA2JzivjlebAmAX4zruU92ATAl6T+OG/f660sNlJH5tq7BabCHXyz
         vB0xaa+uJgy3ABAfk2cl3JgMyAH/GNKBWVspLINmy5pcMtNeNKPJfEPJtaCdSZJiHQc/
         eMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940360; x=1709545160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vawvIwXybApZ/749Z2EWmgW5ee2p21jliyJDHDQcteA=;
        b=vXf1k+UmtqoycuS+sY4vXd/sxX5XRWW/W62SLOyXqjrMHjP7sZhBeDMLk9bNEXYgKY
         1NfsuQePVl1iLt8p9TfNk9inejwe8Az5L8usBTV5fWZ79h5qJvOeOj+Qa+OPzWPKZO9z
         /xHdC5jX/dUH05keYv8uTKfc/b3jNooovR4ot2ax0f8La1eK4JfQ54mspC2LT0ts1xhq
         f2oSlZBDldMIp+BfysTskVpRfqTxvLzgo+u0WAI37kR5kkGA+XokeXsOvj1oyD1aUKZX
         G/4ONoLdqZvRFfnhvWNHMLIXbjCo4+tBU7WD74Cr8lbSyHqPbg6LywBzcV8FZQofOdPT
         f1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVXf5tWYkxa7OuDMAfexkHXz+Q53jkboVUHAY4+gI87kwJDH+Mn91mo0Y4NhblEWY9mtTsK5B3A3jG+YXO7ECwNTncWc+fZuW/ff1qxOtq/r8EzxumwWfuzOaR9pypg86hd7c44qHrs
X-Gm-Message-State: AOJu0Yw2cUQu7CP8jTrL8rrE2o6jz90qt8nGOoD10dKu3IS/4IP46xpP
	aWzJNtPxtze6guqUC+lzJwyWP6nv+jnARFjenQ2FGEJf0UVEuCaj
X-Google-Smtp-Source: AGHT+IHGbfdoYnZVhOhTEfOcjzozW9EnW+g/nwo588gaAwWsI7B6sWmZr/epE9+HUsQuRSsA4578Pw==
X-Received: by 2002:a17:906:fb0b:b0:a43:5429:499d with SMTP id lz11-20020a170906fb0b00b00a435429499dmr1209736ejb.27.1708940360174;
        Mon, 26 Feb 2024 01:39:20 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a42e4b5ab00sm2226937ejc.41.2024.02.26.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:39:19 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-doc@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: freeze some package versions for sphinx virtualenv setup
Date: Mon, 26 Feb 2024 10:38:54 +0100
Message-ID: <20240226093854.47830-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you currently follow the instructions for sphinx install:

    /usr/bin/python3 -m venv sphinx_2.4.4
    . sphinx_2.4.4/bin/activate
    pip install -r ./Documentation/sphinx/requirements.txt

you encounter an error during make htmldocs:

    Sphinx version error:
    The sphinxcontrib.applehelp extension used by this project needs
    at least Sphinx v5.0; it therefore cannot be built with this version.

Akira-san Yokosawa reported this already in January 2023 and Jani Nikula
was fast in providing a fix (see Link). This however remained as a thread
on the linux-doc mailing and was never turned into a patch for Jonathan to
pick up.

Fix some versions for the Sphinx 2.4.4 to continue to work.

Link: https://lore.kernel.org/linux-doc/cb72b3d6-de7a-4c8a-a99c-72d58a23f89c@gmail.com/
Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/cb72b3d6-de7a-4c8a-a99c-72d58a23f89c@gmail.com/
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/sphinx/requirements.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 5d47ed443949..0aa4fdb84632 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -2,5 +2,10 @@
 jinja2<3.1
 # alabaster>=0.7.14 is not compatible with Sphinx<=3.3
 alabaster<0.7.14
+sphinxcontrib-applehelp==1.0.4
+sphinxcontrib-devhelp==1.0.2
+sphinxcontrib-htmlhelp==2.0.1
+sphinxcontrib-qthelp==1.0.3
+sphinxcontrib-serializinghtml==1.1.5
 Sphinx==2.4.4
 pyyaml
-- 
2.43.2


