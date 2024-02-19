Return-Path: <linux-kernel+bounces-71963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79A85AD23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1333B24B03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60725535C4;
	Mon, 19 Feb 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Nn6oRj52"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339563D38C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374445; cv=none; b=ItIZgHug2xVZBEfJB+zvtlw/Yr5m0XsHymRHfaJVId984miSrGs3aTZRaoOjyjsdWdSrte6g53IXxwn0IVuG85N4IGb8HBjK9oXnpxp/feYueNPwANTbbZKBcq7OpIKVQ4ry//URYNl6D8ey6Cwj/2KF9AfKZ4Q3T8OpaA05Q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374445; c=relaxed/simple;
	bh=2+aoCwOd06/v1RwfWjtXRvkTzvzg3Gip4JPINzS5zGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5zKRaONF1q0812ogaVUp5v29rsXv1U82sOHLE8byfOwGi8rlK9rJOQvQP+K4B80+Emc7CO9ToJpUTzjctHFInFxSoxfBxuqRODsNA9kkqHWoSvpIQVjR+vicD/sTluN8gOLy2qXPCP6zAabel0NA738AY5apSN3wMAK5swAvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Nn6oRj52; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708373975;
	bh=2+aoCwOd06/v1RwfWjtXRvkTzvzg3Gip4JPINzS5zGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nn6oRj52uOevfeinneNNvv6zz5iNu4l5SM6k0SPBlWNKzB+XAtRQbp2qom68SVsmc
	 +Ld3fukJ0WuH9QLVzXYl+DCatXDgPKScmW59/5xWJOkwXc0HOUdopR5Pt2Je1YvUx9
	 Vl25Uu+s81Wph/veKdYwujymErvsj21BzWOU+Tu4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 19 Feb 2024 21:19:23 +0100
Subject: [PATCH v3 2/3] ipc: remove linebreaks from arguments of
 __register_sysctl_table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-sysctl-check-v3-2-6940d5ff747b@weissschuh.net>
References: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
In-Reply-To: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708373973; l=797;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2+aoCwOd06/v1RwfWjtXRvkTzvzg3Gip4JPINzS5zGw=;
 b=4a1lYJ1PBMTeJ+6XFqt0TOA2ayoWIl3GQxZ8fy2AU3RjjsgobW0N8db4rYq9EkMvbSHXaa8/w
 IIHgKKGd4BLAjxli2DumdMyGGqqf89gO1OGf+heF13ZUPDvVx3mto5p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Calls to __register_sysctl_table will be validated by
scripts/check-sysctl-docs. As this script is line-based remove the
linebreak which would confuse the script.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 ipc/ipc_sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8c62e443f78b..e4008288a3ba 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -259,8 +259,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 				tbl[i].data = NULL;
 		}
 
-		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set,
-							  "kernel", tbl,
+		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl,
 							  ARRAY_SIZE(ipc_sysctls));
 	}
 	if (!ns->ipc_sysctls) {

-- 
2.43.2


