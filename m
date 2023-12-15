Return-Path: <linux-kernel+bounces-1781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B98153DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2191F21D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBF15AD2;
	Fri, 15 Dec 2023 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XQMWrGxr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A918EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680127; bh=ZEHXiJrgb1zdL6EoMkNwkV2keMKbDFlpdJJZebncUCo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XQMWrGxrG4L3NnnVe7i8hL42HSG2x92vGiuBrb5h7861cSnJSJj6UZSocWY/Zy844umtGZqOq21NiipRm7bD/zU9DUQp1llTHQaDlosGo47pgHDGysBwpgmYkrDiVl5n4ZcX5z40y4UNTe/9mqYp/vE/ap5aAazMH0UKQ/+dnhC94W/nkCZJZOu2kxf5NlTY9IsQtkIb45A4AKd7kQqwz4xH0JaAqLgbIhUl6o5x1wmC4CvUcQWdYZRSpIYIb+OC5ZTmmclWfpc8uQN5KuTAU20+F/0RSfYHsshI4KY5QbAX7sLxlprv1t6/DJuKp2E84GQOojt+JHuhj1CL9BQYGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702680127; bh=s9OinXN4BNWiWYh6Ku+HYSjEK5Odfe0nhz7SEss2thB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=R0sXa90XNC82x534Q3cB14JE14NEArCzJICwgqtC6E1SVuOSKCiMfjl+ss0VDC929LyM/Z9lHZmoYuO6PbDbqICckBAQOs356v6waZAurZCXB+8ls4W43axMACW1KwDbjn/T6uB1dqfP64nqSjLSm/5SormCnQBaajTUCqyiKLk6WULS+6fGPbkOW4Qfksg0IK1zEY6m24+Jk4JDL4JQNy3GhwC061Ipbsjsuwh+fPBnv68Vxsqm+HuEsEa0VjLqj25sA/ftOjpnyI6gu2lEL+KwBITbz+MOh7KfyCLK/JBi/YjqTC17F9r0AebxTLdVffSYiqhyVHmYjggVINOIsg==
X-YMail-OSG: 4BWwR2EVM1n6hAHa6QGlI.yY8SH2x_io_qTXv0EuYNulesBo29F8UhoKLmK6sOe
 7b4yXWzQUh8sei9zAmlZizdpVrv7o4Cg2Mi9gYbeG9KhZyi05Xx89X8klJOBvjYcnQLyxad3nESb
 sUpiwS_jEst2OAP4gG730TJPdTl_KTqNux_1pvskC2qxgwDknZOLemxJSZb80OGP8RVtmGh9QFMi
 WOUEH7iIapC8SCKyqhjIuJP3CF6gsyyresT00MwXe64_9LVotZRCciyi9eGyPHzqTDIyzACONkDY
 y6O7cm7epddA21bePLsVutH89mSCF28Nuc1lPokhhYlwmIT4FVPzWeXO4jteItGUKradKT.LOscz
 JZBtP1OWInVb1Cy16R8hNXi6BXXuBs8kstyrwl7w8CZT7AuEcmwMzyoA0bGIoHX4nnM.ear5DqX6
 ..EFjD5jkUjdCvFPU5HgLBTfxz1ruMSe2MiHKP4VrEH6tUWOdieOag3Ew1roLvU9.FaSRVVpuXu.
 N1LfiDaTeBJK_pJT7Wqxvq7X3D4ASs4WKp4azhXKB4oY.XSz3nrEV40ncgHkl9hPf.9UNxsuKLVY
 ZPTRHoDtFRWGf4XgQPZfGNZPK64l322Im7OiU4xfjHkCdbunyvlsuJuWrfxqEs5mrS0oTrMN9lGk
 NWybrMaS7kqzA2xn9JWc9HQHwBb8s0h3APCC0DTN9KkOlQMZrtf8nS9BcdSDMYDHUE_KsyLocwlA
 hFCpx.rdLAyFspNJD_8FhyDtDwYG1AL9aLyalw6UuevWQAs9M41Cb3VOO_ftvdlrjsmtYk2FiRhC
 ZMUixPTnbFvZQhk.qI_uUoHh2J2fEDro2Mf1_3.E9_gy89UxvlFghhUWmrHsnlK9kzuc0rrMzfpm
 DvJgK5eW0YnbX6JJaheIfsHOVY7wTryI4LjUjzJWxgtpiL0GfQ4.0181CV8MzrY8aaAjoQBtzml5
 itiVeDYRT1KV4_7Fz0WA7mmjnGNSyWM.0PkqZ08mqr1yquN9AvUwIpFIx6YRHi5kz6hqwJuOxSHc
 v9dIUfVpzmnbLQe0cQ06rH9rlAqNJmfAlWlJiAw3XlkTOq7G_oJ2ZUbJ1j6ewIjXijap5A2Clnk4
 Xh7vEuEWD79rgIWuZj31cuv3OSVFKvfws2vYi5msF0h8EiRJup.fbqo8ZvoNlvAyKyaZBuaeHAJm
 _NGrC6ehPPDmtMjhTrfk.R44CW.nOdZFAohAVS9PkVIekuAyrBo3MACrZ4OVQcVN_yfyneVD8TbD
 Ie0_1vNC.Xr92BS2t070ntUnfq5gRk08eOlWtGb.bQv.v3z8D1h4fEX2YGAxKdaXxfKtVhCFM53D
 JDm102kBNAFCzupinn_49rH5KKfKLI71nMhOv0tb_gqRF7iQwGpHfW.7vTF9p647y1q6oyExKUPr
 BxR0lwaXnmPom6.cqLPV97SGDb2fE76pBpUCRAIgcTO3aOzyrlcADP8oQvPvu_Hf0FUNv5q99Cc3
 JAZE2LuPPUXUEgvvI1jR47W_ShHN92GTqT_4GRWIkiWnkjUnxT2Y_gfYUIP8h6N2w9Zcws2ScEZE
 vaHdrCDFiIPmlST1p48Rw1nWr9r0A_9AioRPSNn9ISV0LnzjHWgIkSIEj8on9IqBCu34DjB82Zla
 3hMgh8RbmPCFICJJMadhtTdUEbFjJjILdzyhKVSPRgxQsF4MpiogIFBAHSHEhJa24ah5aKdggqkc
 r5JShu6IjWYBBQzSljNkgzaX4DeZQQnyvnCiF9K1tYauH3ZCOG2wuSY7v.GuC0yXzolVN4OSar4K
 J4hHXwWFAwE9nHrRqmiCM41CqiY26fWvirjiuDTbMO6C4DpSK96w35egSxPM3lzkMS5K3bNgvU_s
 lN9W2IF7l9qoBlXYjtMxlEtvGEzpWW8nVzol.ifaGDk.KJgCF2QKqlewTVLLgX.lVMajsXrD7B1O
 N8kwf7b.Ekr9KHYxmavVPnSmwHkZ8jKvM7dBUzxssB78V7UZJoDoxExcls3HT9ES6A7kX._yJGfb
 Ov_Yf0NkpFrRbjlEdk5pHy_opS4EfZ.vKEQPgdwXih_6WUvdkhRRYHPwl0BHdX4nD9.VxO4htO1z
 UBHmKoAqdNZQ3giK05rHc.WEtJKXzIsEx97ZyNoLeH8KINMGXOcktjnYQU8i0TmF7XCcjyrF6v95
 .RKla44Hse6Euwd2aPeYDcpu_6bcVl4AdVfln0ssz4obkvM6cBCUvFdjp02xw3kpdt3SqC6V0.nV
 G0lH.L40i9H.BZYPLvKGWdKPRH.zvuzDfknHfhimnyfaIc06kTh_kBRyDFMd.4rWhnlx6d1ERzNL
 z4boCUtjlfXAjS2R56UsyG.v._0w-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e8cd937a-6ca5-488c-acac-5073aa4e5ddd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Dec 2023 22:42:07 +0000
Received: by hermes--production-gq1-6949d6d8f9-bvfr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7cf3dab1b010cdb86f7a13f4b7451804;
          Fri, 15 Dec 2023 22:42:05 +0000 (UTC)
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
Subject: [PATCH v39 33/42] AppArmor: Remove the exclusive flag
Date: Fri, 15 Dec 2023 14:16:27 -0800
Message-ID: <20231215221636.105680-34-casey@schaufler-ca.com>
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

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index ab9b0b37f1f7..d47816e91bd3 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1385,22 +1385,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1510,8 +1494,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -2296,7 +2278,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.41.0


