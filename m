Return-Path: <linux-kernel+bounces-37459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FE83B05C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A321D1C225F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240812AAEB;
	Wed, 24 Jan 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABzXQkTJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2812A16B;
	Wed, 24 Jan 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118445; cv=none; b=uEKe7QJl4Z/wjlkaQljKWMxZZtlP94KqKOsB8yzej9OB/ZR5f3TeKR6fq60WIKinp3LX7TkpkgF8TeNZOjkKqdY+G+6QzQ3/y/tJ+mIgbg26E9m8CG5/HmY13Fqi/a5RxlBzSQXYiqd7vziKvjY5qZGgvZcpwyUaLTRRB9n1wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118445; c=relaxed/simple;
	bh=JUBz4HV56EeU4/nPAgND0SO1KSnQD6Dq6LeiFiNVnDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia1PWMrhwcs8Lv8mDrX3j2PTLqQPPpw2ypuZsBa5tuMjIyi1r9xvjFt7vf2YGb1njdtdAJjJGCYUDKJ7G41Ya78dqH0VWpOq/+kyz0NHeGamTnFNltm4NGfWx17ytacLdgQAVqmbv5rVbJn/B4AVIeyNkELtWw/7SM4XpCqC5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABzXQkTJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d720c7fc04so33999175ad.2;
        Wed, 24 Jan 2024 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118442; x=1706723242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gneFCt4ceG2iUK09c51bLYD/2KQfSVJ2BvbrNzbdXrk=;
        b=ABzXQkTJh2DWgIeRs7Kca4RYpIiAmZOkEgIfajPbQk3opGCN0tmWIludURmhuiWcgp
         eQDY8ptddLqmC/Ba2PQ5x4zcavAop6EgGBPdvYHKFD0bUCCfY/FQ78Kumwpj+Le1v2Ms
         VKpAbJfUt52Febv+GgzgPonuZitNpaiP/tmi2vIfJSamEoD7CZDa/Jk7o/VdlZq5BRqS
         2lwUV2j4RSNU1y4enZuRwLVsppWjwfS993o+7emd7AZ3r+YfZqO452hY4ut5W9kjNLWq
         jkvHbIZ/he9Lgy6BMgav3QIkAG6M/g7W+sRDdAN9DOCTkMlLgjlSaoEntuqXr6j0u6jP
         KjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118442; x=1706723242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gneFCt4ceG2iUK09c51bLYD/2KQfSVJ2BvbrNzbdXrk=;
        b=m1pQvVXuUBJTQA7LZM8Fp1vXF5AKfl4/XdBTXVzebanezxdBPPe9W6NDfZ+6/Xqief
         e46xU5cWWtgWuVFiNs9oO1pCaG88UZmarza/I5QLq+M9Qnk5vMk6tGHjvrxqSjoi2p0q
         iS0DQ3tyIo0WoL8+VeVFPwTqEyWmkx8eOoPVXbtK9qP9klMpw5OwVyPrVUrOA+kK+uxB
         px4ChpxrsvPHHu+3WTmBdaJ1hXQ+qtfVk8HRGyCrnKdGPu4Xd5HuQ7cv1HY59zvRIRY9
         btRtndLfkzcbIuGfyO0HYy8ERbf1MjbWUttcgRjjFg8ZQJWJrB4jyqf0vnfvxOfJLBtf
         K9uw==
X-Gm-Message-State: AOJu0YwIdDHk+fVeASmB3ZpAEKrqsJ1Q8TprH0DGmt7ZRyCSyGcdq7aw
	/n0KRTYbOqawRfwhabVXiv0Ff0GyZRugZq07cZmNrWxGUoaSMeab2mtn2W6C
X-Google-Smtp-Source: AGHT+IHntv6ux5YegeJy5fbsfu7RHvSkcChc6KgWk1uYecoX9oMy6cYCDp+xy6SzcHEU2w/iX73N6A==
X-Received: by 2002:a17:903:41c2:b0:1d7:6c80:644f with SMTP id u2-20020a17090341c200b001d76c80644fmr1210450ple.9.1706118441767;
        Wed, 24 Jan 2024 09:47:21 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709028f9600b001d6fbbdcb82sm10665544plo.134.2024.01.24.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:21 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 4/8] net: netconsole: add docs for appending netconsole user data
Date: Wed, 24 Jan 2024 09:47:02 -0800
Message-ID: <20240124174711.1906102-5-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124174711.1906102-1-thepacketgeek@gmail.com>
References: <20240124174711.1906102-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new User Data section to the netconsole docs to describe the
appending of user data capability (for netconsole dynamic configuration)
with usage and netconsole output examples.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/networking/netconsole.rst | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 390730a74332..54f072f47921 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -15,6 +15,8 @@ Extended console support by Tejun Heo <tj@kernel.org>, May 1 2015
 
 Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
 
+Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
+
 Please send bug reports to Matt Mackall <mpm@selenic.com>
 Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
 
@@ -171,6 +173,72 @@ You can modify these targets in runtime by creating the following targets::
  cat cmdline1/remote_ip
  10.0.0.3
 
+Append User Data
+================
+
+Custom user data can be appended to the end of messages with netconsole
+dynamic configuration enabled. User data entries can be modified without
+changing the "enabled" attribute of a target.
+
+Directories (keys) under `userdata` are limited to 54 character length, and
+data in `userdata/<key>/value` are limited to 200 bytes::
+
+ cd /sys/kernel/config/netconsole && mkdir cmdline0
+ cd cmdline0
+ mkdir userdata/foo
+ echo bar > userdata/foo/value
+ mkdir userdata/qux
+ echo baz > userdata/qux/value
+
+Messages will now include this additional user data::
+
+ echo "This is a message" > /dev/kmsg
+
+Sends::
+
+ 12,607,22085407756,-;This is a message
+ foo=bar
+ qux=baz
+
+Preview the userdata that will be appended with::
+
+ cd /sys/kernel/config/netconsole/cmdline0/userdata
+ for f in `ls userdata`; do echo $f=$(cat userdata/$f/value); done
+
+If a `userdata` entry is created but no data is written to the `value` file,
+the entry will be omitted from netconsole messages::
+
+ cd /sys/kernel/config/netconsole && mkdir cmdline0
+ cd cmdline0
+ mkdir userdata/foo
+ echo bar > userdata/foo/value
+ mkdir userdata/qux
+
+The `qux` key is omitted since it has no value::
+
+ echo "This is a message" > /dev/kmsg
+ 12,607,22085407756,-;This is a message
+ foo=bar
+
+Delete `userdata` entries with `rmdir`::
+
+ rmdir /sys/kernel/config/netconsole/cmdline0/userdata/qux
+
+Beware of `userdata` entries with newlines since values are printed with
+newlines preserved. A userdatum value with a newline could cause the
+netconsole message receiver to interpret a value as a new userdata key::
+
+ cat userdata/foo/value
+ bar
+ bar2
+
+The `qux` key is omitted since it has no value::
+
+ echo "This is a message" > /dev/kmsg
+ 12,607,22085407756,-;This is a message
+ foo=bar
+ bar2
+
 Extended console:
 =================
 
-- 
2.43.0


