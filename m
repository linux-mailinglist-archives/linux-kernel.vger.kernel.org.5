Return-Path: <linux-kernel+bounces-122111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107588F1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EEC1F2A598
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A5153814;
	Wed, 27 Mar 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="c3GJgXuc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD41DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579362; cv=none; b=n7USNsfMlwU5f72i96l5DxL9xsWPF4yIftnUUO/+RAZC8z9DDCUjsPPfEqHq97QppiNQlAP3JMTjnQ0inyCcC9QylwxmZzVKjf4orgb3YEbh4aIpeegkVByfT33aozo+nqPzQnoskYQGZkEpdRzyrvjXMTTvajA7C2lpxIPYMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579362; c=relaxed/simple;
	bh=OUK0TZV9CvCY56wNEg/B7dXjgwPzM0GSoXh+zWhV8uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LE3FbD3K5dcTcfHf5bgXgbpEGqrsJCrLGOfv/Zmdt4L/epZaGPUTXJRodXo35KPbOXmcoVZFN1lDdPBOWcMWmSJKstuqqQRp67iwfvZXA8nfYnKYQs59rELb4wfen6+Gwqa99v52dPugzbPCbUPtwINs3Wi62VGe8C+uE5cWP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=c3GJgXuc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34175878e3cso201073f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711579359; x=1712184159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXoWALRK74j2GT1cs6f6h/sLMJZsvN+1W90emFHKus0=;
        b=c3GJgXuczTguNYg3J0T4mNZQ8jPlki5UgO5dDn1r8u5czLBNpesjFWn8XQ2cFjbcUm
         nZaYHfkXDw6mX/rfmCDf9a2JwZxYH6BP5EULfFkKcqGVkVhqSXHPtY0U6IYsyhgkXzm+
         bEgrNvQI0Q7pUQ8A7Tp4yW0frnS30XDCGww8R18/XBzJrtNKAlHlea6AI7CcH5aVTM79
         mkqClrQkQUzHUASH1GKLoyh0OJVECQBTF1rpsZuCw4KZNLl0fLqEVDcK9aKUW64pG7o2
         utakjpO0B2nt+5VeJEg4Fp0b1/opyjiqe8XisopuzEG3QLT7qhLI3aSU/Xl10Ts253Gm
         qPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711579359; x=1712184159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXoWALRK74j2GT1cs6f6h/sLMJZsvN+1W90emFHKus0=;
        b=erC/7kJbfdkPSswhaG/LCV5W2gW19q6V2m9UA/gCCWyuttwiyZhgkpDyX4IP2i6gxD
         8oJWgqExyECA9ECBRPXJw2tNi3TWrc6VDCIMzQz97xrj7BJH2Wls2yxRu7xie7OOKJFP
         2ASrliOTrxrNVcz6/tE5zQu0un4yDjT6PQNeulzwUh+XqRauMjHbMZJJGd+tbVtKFff7
         gNIM86hRmQ7HXYmZiZPZH60OGI7eVPMaOSie/83Iwj0vo1vW9z6ROx/4rQwJCf+GuVi3
         tq9JGBdopx32HOgeiLtHC/p+ypCRn2hqxOmSxH+xkN0BP4yJ0lDPRGmOAPlZNzZHMY3Z
         TjZg==
X-Gm-Message-State: AOJu0YwUNF1kp8EO70TpQH8rnD5GWmu8RTIR1Xg4wMRTWcQOe6H0KyOI
	q3fqDzy1yNxajIf6lMPj9waxF6UDrfTn53lEvkzCC0Au+VM1xrpYggz+lo+M4Bo=
X-Google-Smtp-Source: AGHT+IEZMzWV2SJKUCdS8iu6U9gaodDhemOJER9PA6vYTmbGejqwD+Hf45kvbkRUGiOe/92vKbpCHA==
X-Received: by 2002:a05:6000:c46:b0:342:37d9:dd01 with SMTP id do6-20020a0560000c4600b0034237d9dd01mr686682wrb.6.1711579358898;
        Wed, 27 Mar 2024 15:42:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b0033e756ed840sm149812wrm.47.2024.03.27.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 15:42:38 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Leonardo Bras <leobras@redhat.com>,
	Imran Khan <imran.f.khan@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] smp: Use str_plural() to fix Coccinelle warnings
Date: Wed, 27 Mar 2024 23:42:17 +0100
Message-ID: <20240327224216.54342-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
string_choices.cocci:

	opportunity for str_plural(num_cpus)
	opportunity for str_plural(num_nodes)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..58b7f134c044 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -982,8 +982,8 @@ void __init smp_init(void)
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-		num_nodes, (num_nodes > 1 ? "s" : ""),
-		num_cpus,  (num_cpus  > 1 ? "s" : ""));
+		num_nodes, str_plural(num_nodes),
+		num_cpus,  str_plural(num_cpus));
 
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
-- 
2.44.0


