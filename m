Return-Path: <linux-kernel+bounces-156905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B28B0A24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC0B2788F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31E15D5AD;
	Wed, 24 Apr 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="D2kdgSKP"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D515B12E;
	Wed, 24 Apr 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963250; cv=none; b=Oln61OYMYYIRwwmO5NdZQkm5yZDMYgD1HQby6GkmQmZyedjZcq23iUqMiF4hLbO11G3OVmzADnyK+uxVnwx8fxOVTvw3NuSMMA1fCurv5PHUUnrI4nRkKIumb3C64MawI4JMhRwWPxi/Y+JzBhP4ji5dlGFnhn5VM5WhtMuKJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963250; c=relaxed/simple;
	bh=spHRJnpxm4ltwTrNamDMm3cZ/Ft8kFmxS/nYJAtGSYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR5TPDys/t3s2FR5161qASE8EElgVnRoDcjXdfg4fk4JkBg0Ql3tax0hl4yvP0ZNBbH2pw15NkPpmHGll+uzSKYlpLcLrXJxK1C7PXC05cnDxfsOPc6FieXgUI1bIOS7pIZs5dOWRUkrjEQxrHyO+Hdtoul+RmZNRenbhnFTM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=D2kdgSKP; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6F806600A9;
	Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713963245;
	bh=spHRJnpxm4ltwTrNamDMm3cZ/Ft8kFmxS/nYJAtGSYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2kdgSKPgFdZlyIJQptx7LcQcJe9l2CiJRu/gkXZzQxJmCRCPXYiuRgLgXszHI9qW
	 jOgaNAlvOxtuZpVsK3fM7Y/dRXdFf0uOKtTXSR+hgHH0rRIQ86o/9Ic2GyN1392oS3
	 VyNAhpH+qSVr5iAr2L/z1HmgtCHUbAxYCLRWcz+8SOEFqxdqpOnVt4S/zAe0J/QCTz
	 SkcbRCZTV3KbLK8Ls76sE+dU17VeHmpJb/pNIIrulZZNd7Dgcuk3RUI3UMuGy1tSrU
	 CIn5GkqEhf+zefv7y7YgogADjbOYl2gigxsOURMoegAMHcCX6gZsV6BndbigXEmWPt
	 cAbqPKV8qO6ww==
Received: by x201s (Postfix, from userid 1000)
	id 1C6DE205831; Wed, 24 Apr 2024 12:53:52 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 1/3] net: lan966x: flower: add extack to lan966x_tc_flower_handler_control_usage()
Date: Wed, 24 Apr 2024 12:53:38 +0000
Message-ID: <20240424125347.461995-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>
References: <20240424125347.461995-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and aid future users.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index d696cf9dbd19..a63b83fa2823 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -45,6 +45,7 @@ static bool lan966x_tc_is_known_etype(struct vcap_tc_flower_parse_usage *st,
 static int
 lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 {
+	struct netlink_ext_ack *extack = st->fco->common.extack;
 	struct flow_match_control match;
 	int err = 0;
 
@@ -80,7 +81,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 	return err;
 
 out:
-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
+	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
 	return err;
 }
 
-- 
2.43.0


