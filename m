Return-Path: <linux-kernel+bounces-97846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D6877072
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193D9B20C49
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B8374FE;
	Sat,  9 Mar 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YNOXTIus"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC647249FA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980329; cv=none; b=IS17I1FsEO0CDLDfym7CPMtyScaMFZzDHulkkzrOMltR7jXCVH9toRLhWAdB7+lI8hE6nyL71tQ5kH8m5uhW8KaZqzJmu0Rs2PPbIy/TVNcykR/43boZeXg5rafA6VqxCGcP/6RUxiaWppLJTH5bpWkm5Zq+PuNlHi5AXmuXL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980329; c=relaxed/simple;
	bh=TH29i2Bc42PFOj1292tHJvrAH/KS2zZghiBH9f+q/Ig=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NzmmM2JGxVcQrzyjUr//Ia8ckxNozdlV9QUc9TgBnD70xnGp7NHoqj9xL8lGrQ0QGkOZaXAIFHLH+Hal1fzczMrxFgJnOyGeVwQ2WPQQC4g1MjvQ06S2wNLRclSnGlpefl8T89VgZFOoTtv5vX/Joke94gKF6pZgrbH+z7PkDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YNOXTIus; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980325;
	bh=xYcTxl5N7odzXs3IZfO28w2s5Obvy+K5YsX/aVos8dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YNOXTIusNpMhJEj4y5Rbe29k6A3QfNN/eHuFsL0wyJnIcvW7oUVbMD02xRLf3Pmdx
	 0SfO4nE8qxDH+vYkRf+WN1hvrBhoXenCIL0welTnW87ym86v2LTpL/wwwmCrV7TLLv
	 D1f3hINvcfF1oBukVtOgUzLIUA2MLbW9oRKoM2VE=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980321to0b86fz5
Message-ID: <tencent_9988AA3C6A8AA0A649B2F45C66243F946707@qq.com>
X-QQ-XMAILINFO: NOIkHYnr7VzduAlVVuM+FCw32GAR4VClHv3WJ85jeB5F4VX7v9U2Hsl5oBnIxw
	 U3EaY4sArRMOh2h7TO/f7SNdoRQ0k/UgO50s/s/riR8O2qHtvQGrmJ0T/gWlbICBv6srsC+NjWnu
	 /TTWTbFP+2U8Gjep5jkiqzAq/Oot/pze4x0NwoNoZ3jiD0vhqiPj7Iv2g685Qzk9MhFTbNrcydxw
	 gc+/v0xxBBIaYYJN888gmih7EjDK1o+PAaSf/AZRr8dFSYXNyDSVxkcMyk5VI9Nd1yX1FvFwqJsz
	 lqw0PRdB8k4X6FV0htYBvy2RO5COp599rflVsd4zR6CVt3JcFciuD0b6jX9i8jF2QcxDQ5nhE2zm
	 qTtNLKpQJyrekBmp5jkyyGvRotcVww1D4KtWIfOmW12CbGG8nhB/Z96CbWgsi3TTk0l7qZNUx3AQ
	 cEDylf1Hk0ShtgZESGV2RPyhLDQoGGJAmb1yaQfH/Mr26tSA1YD+8nG5BBZt2yMq9NWqZQPztQAJ
	 vylzgFwcyGHDltrx0NbPBqzgQCt8RrU5ZxOIJOtEXd8D0GPAAJOJ3SMmjunWUCFEl+4N5M3cMgVl
	 Iu/x4aSnr1smTjtVoF9lFXGUbJDJ8p57wCsR2Ti53CwEKnXMAxDIHi62TIP6llI2BJB1wdP7D87t
	 7rBmhafkqBRnlwjouys0ctklN5V5bt4pzzTipg6VrEzCWqPbX7BE9+wCGUG6Tr178Hi7CRtokVXv
	 S8hcybHn41ACRL520VrIJR5glZnIiK40P17SobxjyPyCy/L6oiqB+Crd+vc0QIpxArcOO4InNaLe
	 XpIPm/RISFR/V2tjO5+Cd8iDohzjSd87LGaPwUAj3On/tZh9maHK9+WUgr9czGxAfeb/tTgSp6l3
	 JmhOz3fee97nEBGY+M2bI3+bp3zCj+x0xIpWvHVjZYcVlhloTQygFvtfdseELIwaGLue0dHXkFfx
	 7ptnOoPmwxpvvwpiYSzJgWN12qmwOgfH3kpJieTVIcrZiaHheOgVbCCQQr+GL56kBwHUFqK6EXKJ
	 iaSDl6Ocu0KqSNRP57za1cL9tRtmURaPvIPd7p10Wt5tp8+DdeMZKOZ3JU11H+kFKy1b6dQ3v/V8
	 beJJY0e8Qfhb5RFY4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] net: ipv6: delete these unnecessary static variables two_five_five and minus_one
Date: Sat,  9 Mar 2024 18:31:21 +0800
X-OQ-MSGID: <698ff4dfc01491f6e926d054a820ab447e09573f.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1709978655.git.wenyang.linux@foxmail.com>
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Delete unnecessary static variables (two_five_five and minux_one)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 net/ipv6/addrconf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c..73776ff76365 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6660,8 +6660,6 @@ static int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int minus_one = -1;
-static const int two_five_five = 255;
 static u32 ioam6_if_id_max = U16_MAX;
 
 static const struct ctl_table addrconf_sysctl[] = {
@@ -6678,8 +6676,9 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&two_five_five,
+		.min		= SYSCTL_NUMERIC_ONE,
+		.max		= SYSCTL_NUMERIC_U8_MAX,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "mtu",
@@ -6722,7 +6721,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minus_one,
+		.min		= SYSCTL_NUMERIC_NEG_ONE,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,
 	},
 	{
 		.procname	= "router_solicitation_interval",
@@ -7061,8 +7061,9 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&two_five_five,
+		.min		= SYSCTL_NUMERIC_ZERO,
+		.max		= SYSCTL_NUMERIC_U8_MAX,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "rpl_seg_enabled",
-- 
2.25.1


