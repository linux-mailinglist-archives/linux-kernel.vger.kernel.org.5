Return-Path: <linux-kernel+bounces-65423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08285854CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B91C28364
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C36604D9;
	Wed, 14 Feb 2024 15:29:22 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6971604BC;
	Wed, 14 Feb 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924562; cv=none; b=l8ugBqJ64MWpZKLfsRz66GUM2Rtaobq+XVnGcrAHxLmZH1nqC6qkUIK0Hjqb1rUhSWc76YjTsV1Ktupqw4QxQjvzWuGzFz9IqVk27sn5oJV1+MDHg6nMOGGIIBVK2NqA43KeYxkA5SJA8tf3JOTOSlsD/xM9inTYJxH4fmQTPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924562; c=relaxed/simple;
	bh=y8Yy7JuWAr0hlYj34mhtnJ9uprCaT28YrkTkVP1WGqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvxONgv4ta+m1pm9tNKqDzrOX+WQfMNpDv1q4h50Ft5BqdLZr75Fg3Q0xjN3LhvQ5hU3hTRKPvnkr22/EzMPbBuhrrQwnhtvKRllpyOuIi50ltOcPzSKZVhE3mFyhikGZ5f6swvH/DXjVCcOCt0k5qvYtqZl6CgPs0+Bm4/3ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so772334566b.0;
        Wed, 14 Feb 2024 07:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924558; x=1708529358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqTpQP9pQiJvkl3GsY1HlimXwOgRt4l3Wqy4PtOiAx0=;
        b=b+G7rrXb9MZNQLksNYHua1PRtaAcugk8hRBytAXNawsfEWsauGsqijB9Yo4Reji2S0
         8tOzUCX4CRfA4shQsm2kYk7bNK6XzHCAc2FJBjdueIcc/FXyflh+ht9du7DZHTTG0pgC
         /DUhFU4Bd3X5lmjQwrSlpBBNE7JQ7yhpdRTwGOi4YX+79JyPSslMaYN4czsSgOZHiX6w
         AvZCMtOm7aQkPuAYziYDad4EyqbcQuR9vldZkKPs59ftTHaZMDZ5YDGeJFYVsaIibH5l
         lbxec19zUieZCLb9AyYhJQFyiA6TTbx1dthXvwYtKph4wVKTe+bB+ELUbAl4EvgIP9n2
         +8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUiFzVjGf+nQIVIcWseb1pAKG/g+MetsuqURAc8mb4ZEQVTIyGp9t27oHZ0XQa7l6n1tGnMN3G1n9L66NAXvVFIpgEkuEMwprDbTrhMaujkkZkXmFYbiHRvYjIyVriS/GLeSp2JAYXF
X-Gm-Message-State: AOJu0YyrtD0CjaOeXAQMoZ+eW32fzQI6/Jae9ouD/wVe9bs6hv3TpILW
	8zh8u4jgDOLVCFJcSuLZww7t8GvijfMEW94D+OEDvjYkuw3W/Syo
X-Google-Smtp-Source: AGHT+IE0mcvkIbODdLAqivrP8oHz8aaF0v1Fc8pVlHtVXqYU4lXwZ3W+GVYUev+DLE6VxK5l8igtRw==
X-Received: by 2002:a17:906:481b:b0:a3d:5e44:83aa with SMTP id w27-20020a170906481b00b00a3d5e4483aamr1095848ejq.20.1707924558147;
        Wed, 14 Feb 2024 07:29:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMc8QGTVmMHLxLxmEcFEdZClruz57FtBWEjOGYGc7noFT47UYwvAwHEeXfdekQY01TnFKaqfLgdPZNK6A6MwCyLeor6rzJ8ZIPE/ggHUde1FE4i7oZBOvsBM9S4g1qGzHmcb8NznC0ABjKy2OUIaqoD+JjCJ4tV2MV35za7d1BtdLfrp8cnuCQuw7ip61nbEjcuupWnTFgai7UV2yy8qCcQpMBHsxEjeMZl2+GgVWsEHbKHLHwx2roCqR/FTnGHiz/P6xWXEWeQhQ1z5Q0Ig4q9Qps8TqwbjM3ejyOsj3ifVrI6wrgECuBMD3SzSlaCZjw+16ObdvMVwkuscDJpGOSF0+jRRbsWxOWwqWctSvb2uiBrdr5EgOd4WxWTxKpFSK74pzSaDJerYgihasXCxOeO0qPBZz8dGXLGj54HBnUtOZZM2vQrnQdetrO5+sW3umWaMC3jpHzPsm6ufS2O1aSYRB9sZjYee9SF1wabJbS
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b00a3d37a49a95sm839480ejc.67.2024.02.14.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:29:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	liyouhong <liyouhong@kylinos.cn>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-ppp@vger.kernel.org (open list:PPP PROTOCOL DRIVERS AND COMPRESSORS)
Subject: [PATCH net v2 5/7] net: fill in MODULE_DESCRIPTION()s for ppp
Date: Wed, 14 Feb 2024 07:27:39 -0800
Message-Id: <20240214152741.670178-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PPP modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ppp/bsd_comp.c    | 1 +
 drivers/net/ppp/ppp_async.c   | 1 +
 drivers/net/ppp/ppp_deflate.c | 1 +
 drivers/net/ppp/ppp_generic.c | 1 +
 drivers/net/ppp/ppp_synctty.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
index db0dc36d12e3..55954594e157 100644
--- a/drivers/net/ppp/bsd_comp.c
+++ b/drivers/net/ppp/bsd_comp.c
@@ -1166,5 +1166,6 @@ static void __exit bsdcomp_cleanup(void)
 
 module_init(bsdcomp_init);
 module_exit(bsdcomp_cleanup);
+MODULE_DESCRIPTION("PPP BSD-Compress compression module");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_BSD_COMPRESS));
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 125793d8aefa..c33c3db3cc08 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -87,6 +87,7 @@ struct asyncppp {
 static int flag_time = HZ;
 module_param(flag_time, int, 0);
 MODULE_PARM_DESC(flag_time, "ppp_async: interval between flagged packets (in clock ticks)");
+MODULE_DESCRIPTION("PPP async serial channel module");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_PPP);
 
diff --git a/drivers/net/ppp/ppp_deflate.c b/drivers/net/ppp/ppp_deflate.c
index e6d48e5c65a3..4d2ff63f2ee2 100644
--- a/drivers/net/ppp/ppp_deflate.c
+++ b/drivers/net/ppp/ppp_deflate.c
@@ -630,6 +630,7 @@ static void __exit deflate_cleanup(void)
 
 module_init(deflate_init);
 module_exit(deflate_cleanup);
+MODULE_DESCRIPTION("PPP Deflate compression module");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_DEFLATE));
 MODULE_ALIAS("ppp-compress-" __stringify(CI_DEFLATE_DRAFT));
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 0193af2d31c9..3dd52bf28f15 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -3604,6 +3604,7 @@ EXPORT_SYMBOL(ppp_input_error);
 EXPORT_SYMBOL(ppp_output_wakeup);
 EXPORT_SYMBOL(ppp_register_compressor);
 EXPORT_SYMBOL(ppp_unregister_compressor);
+MODULE_DESCRIPTION("Generic PPP layer driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CHARDEV(PPP_MAJOR, 0);
 MODULE_ALIAS_RTNL_LINK("ppp");
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 52d05ce4a281..45bf59ac8f57 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -724,5 +724,6 @@ ppp_sync_cleanup(void)
 
 module_init(ppp_sync_init);
 module_exit(ppp_sync_cleanup);
+MODULE_DESCRIPTION("PPP synchronous TTY channel module");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_LDISC(N_SYNC_PPP);
-- 
2.39.3


