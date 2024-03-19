Return-Path: <linux-kernel+bounces-107765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81EA880166
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7727E1F2477B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B327D80611;
	Tue, 19 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uYeOPqgv"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55185915E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864402; cv=none; b=YOKXIJPcD6c5w2g4MRjselsQ60OeLhiGgYRs3GOhnP53ODIAyaTgVhu8wtXpxwP+csmdgnPcfyFPapKgu7ufHlv9T0FJafjzPMNqxOxkB5HhZ7GmEod1skWXSbdx/abMY4+oLljgknfftuY5pvC7esDxfWHiENg/r8XLtOwaDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864402; c=relaxed/simple;
	bh=8BcVorYEZJUFNP+hSS1ZCSnjlA+9GDRTwy02W4Vbc5M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=SEu4DIgI+OiJyVvSOS/z/8yXK4G7vythJQMfvODEHjwgkM3rhBCcu6uctgUT9k/UCOYgKfD8lvqCT3fvx1eH7KX5055anSSM2VZI5GdNOxkVO5mDnI2fyroC3uBhA33HESdH1tY7wfSKi1Af2e6fOMt4StdrlpgY/jKnnz99uQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=uYeOPqgv; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710864395;
	bh=psNeR2S3YVtwlr1v0vPii+76l0YziRO1wh17cEJ0MJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uYeOPqgv7F3LWYY3aCFrwCufKXWRkjEX12xMeNI3DRF3oes7xBpgN70OSe7y0OXFt
	 3XDvFUU5XMVeJEX+a0nyOr3uTeS7HMpgk9Z4phZftpNTGRFEpz3qQcfd+y+LCJx8+z
	 969w+WEW25VTHUOvb+AqqLXeMtcp3FEX3/AHHCmg=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863897to47qhqmy
Message-ID: <tencent_AFA0EAC990F407E6793FA267BE2A6DEAF907@qq.com>
X-QQ-XMAILINFO: M9XhwTN42XZcDNZ2F3UvBXX/s8I0SBFRu+YTTa2tsrjv6jsbOmlt9SLAW+qTA0
	 1vJtulFAsAkPD6kqKPyN9uGRCbA0ifAYAtkudZCEhZSgp0qskkmvg1fQuEGwakAze8jydhX4Bg6K
	 vHdyIIMJ6nKKAPIwGlEXm9YWA/8G9Ofih6TxiZyv3IvC/40LywoeMx7kJdhH3gGj1QrwPCHrKgIs
	 HRq0D3Bysrl7p4JlqZQhCulxRFoODbWu4Bgj5r/08vUXMElA0CP5fFiQeJa7wc/cAkYepbN0arRo
	 RpNPV0AkemikyT1BisnYeuB5weZYNlzR5K28Fp5M6XX17G6sdjkqa/OiYejIsCddmh62Py4IFDp+
	 4VcwW2CCQFEl1Qg/q2riLpNdnGEmc4JG9tHXbAzpMiUXLVo+Np279dWZzRc3S0qHw996br/bFUgg
	 eKLLg0uNyBMMd/O7ImhC/c9GePS6TaJiuOzEc0wx0T11IG9Tr4hB0bKsUPlbJghXkQtAT503e6Gc
	 GBfNyEgmQMYk4OkGKtTRWKDxo8b+PSpcmeMPRH1DJQhhuz2sO25e/T6cYPVeyzboGdN/PEMi9rEN
	 g1Yp9vzebaFTxUO2y8nQL+934Bs2BD2V/YWrzKOtMmikY9ZnRi4BwPjKo1NDG2PNpHT8WyyUgKza
	 SSrg/f3QqXNMbsUs6IEk2ICkb5uHYI0xzbnEWuRM1YNCRNDPtt18kd6zRiYSvad3R9QqUM23Qw+k
	 j5STOpR7Gq87xFW5b1tJqIJ7yJ057Pj5H9idw+9PF0z2K0paqA77CS319WKXyjatbaBNCiKrkaRl
	 5cxSY/MAS19o5fENFaSTwW4Zv5JXL4vYAipI7OKbH/kVKK4bQagOEli8paRxIuO2sR96W/y7SjAQ
	 bE8Rnahy2WDfs7U97Ykr4Hgc95pDPMaUW7+YLL7XgzApXLza9g1leMk/TkNgxGbpGVHUtkfehH7f
	 1YLw6LmaJjBk6TNBk2LD5vYvYPVbMv/uCtDG2CQoHt0dngD23YDi+MasK+YwTOIsog4NfvDRUlzM
	 gKYrxJ0ig036ayQ/BYtnz7RqTYzl0pX+bzQTUK+Dbbt8Q9sfbYGba1iltCEWpnlKUBYkLSQJPINa
	 KPCTB0lEq7+q3W3vJj/1owoWmx3nUhp4fRe4j6eAbGFfHiaOc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 4/9] net: ipv6: delete these unnecessary static variables two_five_five and minus_one
Date: Tue, 19 Mar 2024 23:57:45 +0800
X-OQ-MSGID: <fca6260c605ee6051136e9c36534e50865ac49ae.1710863674.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
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
index d63f5d063f07..d90f5ad3a289 100644
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


