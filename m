Return-Path: <linux-kernel+bounces-63432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C998B852F23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E81A1F21BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B625339D;
	Tue, 13 Feb 2024 11:21:57 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4F38DE4;
	Tue, 13 Feb 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823317; cv=none; b=sbMHUlGc2S9ADL76MndSVC/VaOUEnJGJOKZaFu38SGyqWQ1TrKi2Zp3bQ6WBCo2ZcwGUOaL0NibSXzsYSD4eq1wbkK/RnhUFIkcaav00EnB4QWgu2WFefJs2iCEjowDqpycs4s7uZr6+R2OIciIlEKmEO36Q5CUj7oTlsjGmsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823317; c=relaxed/simple;
	bh=y8Yy7JuWAr0hlYj34mhtnJ9uprCaT28YrkTkVP1WGqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtzTxrjleqECf+G6EKmq4ypVMCMhfDpZIt9gC2jhu8m4wN54NQLDae0oz1Qw9+MyYFflmVujXhXDIyAuO0V5TAw1gXT7Yc+HNRTPhfMfOcbMAWo9PiN9ezNHqNvixjyDR2yBJYfXJjWAYfVM3r35ngcC/JRgVdP41MuOegv4Lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51165a488baso5558118e87.2;
        Tue, 13 Feb 2024 03:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823314; x=1708428114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqTpQP9pQiJvkl3GsY1HlimXwOgRt4l3Wqy4PtOiAx0=;
        b=cPQX1DJ4JP/64HZJC2+X4jrxa/BWVGC/IErkIyERtga+dvK1sw2qXq8HTSl5kMqt5h
         XDFekHrweqKAyYZkBFdhYbmmfp17M2lN35UpeFxDayc1NOBGN7jyIkC0BoVT+YtldhnB
         zJ4IB1W/+vaW3k3r4+uqrFyg0xwHtyljPfv/Ip1SnE2rErmXaqfZI4oVYBrtCFt6oTPp
         aHr/wRsT3dE5N/o8NcRFaZYymCFZUCNB3UqxlJL+O8L4YNt4i3lcpY2dGl6oJnuH6QDB
         /fPLRPWPv7WkLkS8LX7BTEvjpZ0cAKJIpK+BbOsIWqkaH9N1vgCHtk9oI52BhTPk9nIB
         YVIg==
X-Gm-Message-State: AOJu0YyvUTurlKN4r2IZ1eop+PbLE06n0moKlL+GSbPu+eS0xje9jhbh
	ZRKMhfVmr57378ykH22hF3XEu0GRWB7YoEbzA1prQqNgOksuJENL
X-Google-Smtp-Source: AGHT+IEOjzBCv4hlghJHFt0cRk+E/8TI4F+j0ehUyw1pRi4No/q7KkYleRvBcyimmR7SX8N/Mulsvw==
X-Received: by 2002:a05:6512:328b:b0:511:5c98:ad2d with SMTP id p11-20020a056512328b00b005115c98ad2dmr5523535lfe.2.1707823313754;
        Tue, 13 Feb 2024 03:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv5tFrwWvd7XTE4HxuUxQrdC0F+rESuKysGIDuOSdnjK8Kj0cD90q18veW0qEBUsQfionLLSkYyEkSfvxJOk2wFUZNEgCdOxaDs609FZwKzXvSbK8wmbPRoNtcool3yH9czHTyNqZGZSSIqOFetQHJIhV5FNeVzHhf70yl2zSl9Yg2dHsFvmiuha1IjusIhSpqO6rab17aoR0sMcJnDoRT9XFfDGaEY+NOOX4UkL1loazu+cNYUfxkUMk+mRvBFrLi/cHu7Kgf/a2UTqgkvWIThcr4rtFgfGjiMNYlozY4PUXrw98MY9PcUzj6AnV9wlH3h0eJS61tlgY2lsmv+QsWLuAxvYc9iV4mxBQWdkzUqLomZE3DgBDyDEST8qpeRup9QAQYw0q6YXbHOguUn7B8R0GJieeqMuVxc5mmPXFAUkuSXRpb/A1gX334b9/bq/+9Esr4BfOuGbs26Oz0CFwv5jziJOXtS0ZzgSdcSD4c
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id vx1-20020a170907a78100b00a3cf6edb590sm684777ejc.26.2024.02.13.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	liyouhong <liyouhong@kylinos.cn>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-ppp@vger.kernel.org (open list:PPP PROTOCOL DRIVERS AND COMPRESSORS)
Subject: [PATCH net 5/7] net: fill in MODULE_DESCRIPTION()s for ppp
Date: Tue, 13 Feb 2024 03:21:20 -0800
Message-Id: <20240213112122.404045-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
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


