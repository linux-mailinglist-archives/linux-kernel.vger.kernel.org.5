Return-Path: <linux-kernel+bounces-92215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DD871CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C01F2705B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C825B5B5;
	Tue,  5 Mar 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXme+5hK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B835B20F;
	Tue,  5 Mar 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636690; cv=none; b=qT2ME+Nl+uw7paY9EKFF3Oi5ciJYUmmxPBP+EleUd7tNu9zb2SXFeL7KtcXjZQ5yNJRdsGC6dBU5jf2ODQhPw+K6C8mBqUTpFICiwYT1mPyK/joiIE/Q7pZ4drGtMg7IOQMtrtprXJM0AlQrfLlGaOQNhppJbXLxM6ttLWr4PVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636690; c=relaxed/simple;
	bh=SR02P7ZjycQ0WA/qACfPhFmEuLcrv2LV85aCKTnWlH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l29ckcQAYpK4sJlUH2RuNvtraAZvGEn/pBSSrmvjG2Rbc+a+2Ha0g8O+9dfOiM9a+3cdEgxIOsKWbB+p6f5KIsApH/ejsQlFCj/NVj+7866SnwgEKrv9oeBrp/COXqcLKVLFJMecd1FdjKkJuGyvw7AKalt6fpmmXfYMva1THpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXme+5hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F26C433F1;
	Tue,  5 Mar 2024 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636689;
	bh=SR02P7ZjycQ0WA/qACfPhFmEuLcrv2LV85aCKTnWlH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eXme+5hKyN1CbU61OeHxp1d2p0O5RSx7DZMvgYo+Hqu/FTB7o9qiLCkPlnoBpld7S
	 u/A4yhPVwEyhHsRXlK6l/ymSXixiEdE3udYKDkjsAYeR9mrHQULdZ7b7frdAi0+eCM
	 Aekf0mY/Xwr+UvcvWGeScDhZ31P5c413e4d8SOwf6t0YFY8rgVkeaqSJibgMjpMn6a
	 5tTIEZXOpoK5sbBtQhit2fg23N2wflaBs8Ehxiwsv0WXvVtm35j12/q2ZIg4wiqefy
	 E25YUUEUJBDHO+dz+iNsuGzlwdMuuq/CgwyqnCO1Z9GskxnRhQtx1u7J0yyDwTaS6n
	 rGGXCVtdDZAhQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 12:04:32 +0100
Subject: [PATCH net-next 3/4] mptcp: set error messages for set_flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-3-c436ba5e569b@kernel.org>
References: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JweTqcXP1xdyvdf6NgU0IrJbdbJn8RoJdxUpyS0t0pM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vxDUoyU0GvJ2GdK9lieXgEEjzXeT0i5SznEP
 XWBPdoqfuGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb8QwAKCRD2t4JPQmmg
 czFKEADHOui264xrXbXWVU5Q+NBiKp2u3AXg9P0PERZdK81hNtahMdUnuNtAgCi1+SdWGqXoIC9
 R8SJCGB3MRd+KJS2xX+Qj++JhGcMrDVr3/DKjX2lOU0vF23NstPOkX00FvVqib3zVxyoIdsJcXl
 JPrgLiBpF8Ss7rtwT0ugnWHyWFw7nbh9djV1Y3O9LUaV762Mezr5bPJtOKaVLRCuHztuiRh4uSL
 fKTLTDHr4yfxg/rU0pZqqkFcbApJqkbe13h+CWDlNs5IofXpRemy0I7M/R7rfpRNZIop863Gs9K
 nuXMbBAKwun5bCrdSVF1YrfSowaGcwzb5Rd7oS50pQ0roAyhO04FEd/P92VJVwBs9Tf4BWmsFw7
 +o42nl+79xiya4sNUphVWN0cIw1umGLMdwORBv+m/g/N6gS5siJm1SJjDc5Nsg33FI4cvUaGFXy
 H7qXTaeIF77Kc6vdmKfnZjtgd3vIJ3Wkb2aneRZ1QeUWJHTVOFNElx1EqcBp5IX+njGohXznueH
 cR3dlvWzAYCqm7JG9dC68ZsoJeDjRRPyvxFaFmS83nQMqTe2WCWPrZ6qjcGrjTx2Zs7040hnaua
 DpXXP2LIv+LHRtTYhP6fczjqL652SEwsy567q0e9QLYlqwxyQKEyI7zkglNsn//ITaMxzFibJq2
 IWVF2dt8Vagf6PA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In addition to returning the error value, this patch also sets an error
messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
and pm_userspace.c. It will help the userspace to identify the issue.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 6 +++++-
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c799fe84dfd3..354083b8386f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1908,8 +1908,10 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id)
+		if (!addr.addr.id) {
+			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
@@ -1919,11 +1921,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7ef3b69852f0..9f5d422d5ef6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -563,13 +563,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	token_val = nla_get_u32(token);
 
 	msk = mptcp_token_get_sock(net, token_val);
-	if (!msk)
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
 		return ret;
+	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk))
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		goto set_flags_err;
+	}
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
@@ -583,6 +587,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}

-- 
2.43.0


