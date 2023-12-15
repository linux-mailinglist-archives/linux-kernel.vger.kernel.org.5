Return-Path: <linux-kernel+bounces-1779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9148153DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BE21C2430F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001B18EC1;
	Fri, 15 Dec 2023 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="O6zwzudR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92C18EBF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680033; bh=o5IMFBUGP2UovHyCSNRiU+4kZ3jQYyLWEB5ADn6j2oU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=O6zwzudRZVUq8/FVNESHRKoaMDlJ5scqxAv5JDviYB9mNlB/tPsF1kXlZ4Q5jGlhnqKfzbx4yEPSls7cv+tLceDr526M8rBDCa95/Omwc9A+ULU00lkuuW12xcAtti/B5hr8dw3ytH5MJBEIBI81PD7JYRSbd0gotwlNgCuVzcuDYHy6rOu7x896Ndynp8067dT+bmTstNVBk8X24e/khYoj5H3YoDshmE6IXXdA7vfyrxgVcxARqy0QQ5Dbh78/UPvqaXaYQNi8E8WG9Jef7JU4wjvorp3W3nQeE1t4Z8AaDEUZaBExYfKDxX5yDQe3cqDxFPM2czNYxKCN1iEIJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680033; bh=+bUJYUNOXUuVi58l0WjnoNkLHMIXQZXrNStlx5iarTM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=d//Xed7AmTwqwyuD7jNF6GcThSFms6MTymep/x8SPkwM3Y9fjyXzpjB7/l3fAi/QahahcQ7KFoX0nUY2rAaRJ2HWN8uNsAVr/6VpJfXy4qeyk6AuGrVjNJd+lHcMJ9GgIUKtsMziWo7gZxRuJRnuArKIZg2Xqnp6Jn4s80H/ASJzZXfCeOW0FW19jvtMMDRLKxA+/bbwapn1ME7Ukym/5KxBQkj6AyxpV1nwIAg3MoEAkLphLemPDx4VlcSfGbSJl05IoW1yDrFUpxOkMGvpaw/4UxupyxlZVc5tRVQ0mHrSoDnomf6Up8bYoxrMLZETpV0lS9xpjvTTOOqNl0uNYg==
X-YMail-OSG: LuT8lnAVM1nEZoptBRpIACvIfKhJTin.P1ZwBGe1zPGEiYD2ZOPaST8XiPvbDGO
 SeNN7zoADgVlrgQ7rX_CtmqcNy.KSk6oRPLw6KWCgL8LLag5_GLx8uwE.L1SJJpXjLM98lFwRXOh
 goJlGpjCeYzAGQRLIYcTJgcSJdh6at1ppH5sJOFwyLdxojbO5UlhbQbAsdz9WIBmUO9v2nzqcvvg
 sYr_MA8VoO0YJAp_i9z5zXrGLU57inhSFNPjH2s7RP3tPCkm7mmliycSaESsPvZWtt3ztrptg0CC
 xexglxtCMzJXkM_FueiZlE3F6T4E_w9eBxefPHYeIGgIoCrLdYKVmuJ0_GCl4O7F8vc6ABX157Y1
 wZkq27JpSDToc975D7J.kGwiGPkxEyq1kLoPkt.wNGwh4n.dL3mMimy5dEx366FkYBVHjN1wSQAm
 eTlQ1g7Gxq0Ukvt7N5JecI5E63tuRiBcy9b_9lqXfxdYHwxkTE7_SS7X1DE9yuTKRepnPqiXSN4O
 PGhaok2r8.69P8OuKrfVoVpw3ejK3yW0lqrub0PZDolg03VTYzTTQlbCB7_cYRovWP0Ukk52Jna2
 lqCrpDJr2DA0P9aSEHAwtbOGQW7b.DGrHa1ut0yboWqCcOyBdgbE1av_Kfsv2AASH8kUP1_lGRDb
 znDVYUojshoN4WAWSC1dJsymGJDplft5FbPxSHAmu6Zzs3NexiRnlKNtQaLcXrzrYKIusLKtodas
 xIaOzg5KVcUP6Py1vrZcZqGpD9i5Kbi.RNpvmT1LLI0WY41aDuYp3ajB4vaSZIw7daDxYbNThV89
 8dzdO65TA8PuqXujqt3zt3BmRQn1rclBiJZzsjEuzP1I9j52R9c_OO1ZMPbxXUp9kuSm26D1LIJ5
 gqYYWKENac_EpEBkOaEN38fTYk6L4F3sPK96_YMIdJfOBDRf3ickRGaooyXmpSJngyhjcPlmjliB
 4Ia65ahXfqd_5jckbC.Eigw7bX.gABeJ9F3gsikF9BtkAQ6CII45EXBC7iRe_rlJc5QeadCFdLxi
 LvRhcPi9ETznW1zzpCfxanWsqieDX5yFKn_GHkPrOTXrH_KNcH_3mra5VRGAGNQKgHkyHaVtGGO1
 1LztTlKM_Ict0GflBH5BGEzY4h9U57IMAcsAGIb5Il93tb8G7UANbjU_.yN8Luz6VuU1QedBWvoC
 SR6sDNtygO6acb98fKyh4i09IG00iSD8PEsovZWtXKGe0a.DYguT9RBg3AsciM33JKdxI9m8MyNF
 p.UffrTm9sBs2ylITeSnjEunW1butr581m1uC.5ZMqktR5PfDOhHbBrrAhju0Z9FYxcgqlrcrXw9
 FWK2NhUPbLHXFHXr93Ij4BZ73wbJ..J.A6JPhJJYrvjoI2Ns32hgWJGbs1_HyTPfSlUcRm7tQdFz
 czfFXgMbtd7op4V.FrBXiPxrJTp_yE8vvVL2dPDlEPPMAZeiYXLEB3_Aa89tvsxucWgRaARwRXRc
 pEWayQqQ78CuOPXVG293pB5a.eSDjt8_XedP39.tjb9mCCcSGxM07FCTsGf3RYZw._PoELXUAULk
 _pzZxrIIvFzX_vYV589y_W9wtOJ_bFjqN0fstBYfXZk8uCYpkln1VBvQuq0zhWIW3pLCzMjtgV4X
 YelQzxnzNjRtz_W4VjEoCHm3jvxlubLgIxVbuf.Yt8gMsSYqAz0MQrMTSfeKL.seoZOxqC1PC.n9
 81yghYGThpPCYxsNjemYZgRk_3HbRjdl8gLYNoUY2Pdrm61gPu9eAbD42WpCKNoW4EhIx74Lk1BU
 5o93mZurnOSCZGP_H6YFcJpSKH3_7Iomv4I3R5aEV4Ub0RXT..unGjLdJyZXUNbIWQ2Bc.9ves4D
 5.5D08dgK75eH36un9tizKfJqBabHaeX6RBX0.OHYd_p6GQ4Up_by1DStQDpONE0UH.bu3uND8rp
 PmRFgDPdr85_p0E7d5DQTafpmH4iIMcXvLVi0L8sRl6gdFUX5FkMPLtDmeCTI5KS1aWHDIpiUfnr
 S20i00gvy_.C2wUQhZpWk4ZGjYJe2PWvVnaDCTusl1YAMf4eXuiueiFiBi8vkoE2zsaiF_ehTbo4
 evnLUIT93KR3JJE.jpkajBON416r4AlTIWo2MzOhTh6PhFW3Nu4IJA6mXSjv6KPTpykUNKcLbtn8
 41c4HYm7bpJ1T7Bc9FYNRvtbjqCD6hTGllRwBMZVTlaMziUsyq1LwahHCfh2MQ7cigAt_iGW.nLL
 X42_NASxM7T2eBQtHQRIzkiobOZQqUZMoOLgpoiLui0swU3kqkpQl9EyCji5KZfEkgsovv8O.C2I
 _ukiPRJx4Z334LuV1mX49pEETWSm.
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 88385606-f443-4ae1-a189-0fcb3bac267e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:40:33 +0000
Received: by hermes--production-gq1-6949d6d8f9-k52jv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 154018758a06b94c4980c22812ec859e;
          Fri, 15 Dec 2023 22:40:29 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v39 30/42] LSM: Single calls in socket_getpeersec hooks
Date: Fri, 15 Dec 2023 14:16:24 -0800
Message-ID: <20231215221636.105680-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215221636.105680-1-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_socket_getpeersec_stream() and security_socket_getpeersec_dgram()
can only provide a single security context or secid to their callers.
Open code these two hooks to return the first hook provided. Because
only one "major" LSM is allowed there will only be one hook in the list,
with the excepton being BPF. BPF is not expected to be using these
interfaces.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index f2ef6032a925..3f0a4c5094a5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4686,8 +4686,14 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			     optval, optlen, len);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		return hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+							 len);
+
+	return -ENOPROTOOPT;
 }
 
 /**
@@ -4707,8 +4713,13 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list)
+		return hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+
+	return -ENOPROTOOPT;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.41.0


