Return-Path: <linux-kernel+bounces-49325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881818468AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB11A1C24C34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD61B274;
	Fri,  2 Feb 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo2gf6ep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5081AAD7;
	Fri,  2 Feb 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856986; cv=none; b=U+fexmCs01GQu2CmG4jvNrq76Ch5WQIf3s8vSG0MDmZ3PHAsGA81Q5x9lDyUfWhWbIsKS4udn0TS/zJ05pzd1ZyFnKT9hRjDJj7bB8u9IctU84PejC2+vbII0qOJxuSChPy+wmrX8XxhEVrtcKwost7WEAb08Q0H7ucX/eUe8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856986; c=relaxed/simple;
	bh=k53CFJFMOZQDpOcxwZ7H0r8hlFfuSR0Pgv3cmw8obIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTHv36C795uX3gxPV3d+xwnGl9lBvl04RoMBLKX55rnDbtz4tGaOe1qw/UMNexLgBBH7BASZxc6bJAhPprX9umeIKeROnzBvoirS5SmcE3DAMm7mBQRAFkcfRJYktVHOZTkq4fqHcXklh/T1LysLS6dRkTPYyHrrchCUxBjRUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo2gf6ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A63EC43601;
	Fri,  2 Feb 2024 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856985;
	bh=k53CFJFMOZQDpOcxwZ7H0r8hlFfuSR0Pgv3cmw8obIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jo2gf6ep1g1L1uoWylXncKHKTwLanexUMlfY3+AlIwoZqrEz/pN5zORvJJe7ssrn3
	 2uaVFAbXJSht34Ho3DYxDgciSaPztclqo3+Xfez3pIVHjO6mBXjDY+lQHRoRZ23DoS
	 Y/Bte72KDyBz7lBXDHP3ETGMlNDKxMVH6fhWnhtUa1T0ok6gcQuiBjK1zvgf9dEPrL
	 zG0h/ScHc800hNOZ6DlbLGCUIg5L2U31339PA3MTDecfZJjy1ywIxpgINoGgxEeetY
	 ZUXAlL5pNfD0ZheKPA8W//PCidyHAuPGd6xvVbQ/dqRvCOaYMVHyLskk7gQRDudzix
	 9PU3qZnvffTew==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/22] tty: vt: put cases on separate lines
Date: Fri,  2 Feb 2024 07:55:55 +0100
Message-ID: <20240202065608.14019-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some cases of the CSI switch are stuffed on one line. Put them all to a
separate line as is dictated by the coding style (and for better
readability).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c072007807e1..42bc0957a654 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2437,7 +2437,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			return;
 
 		switch(c) {
-		case 'G': case '`':
+		case 'G':
+		case '`':
 			if (vc->vc_par[0])
 				vc->vc_par[0]--;
 			gotoxy(vc, vc->vc_par[0], vc->state.y);
@@ -2447,12 +2448,14 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 				vc->vc_par[0]++;
 			gotoxy(vc, vc->state.x, vc->state.y - vc->vc_par[0]);
 			return;
-		case 'B': case 'e':
+		case 'B':
+		case 'e':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
 			gotoxy(vc, vc->state.x, vc->state.y + vc->vc_par[0]);
 			return;
-		case 'C': case 'a':
+		case 'C':
+		case 'a':
 			if (!vc->vc_par[0])
 				vc->vc_par[0]++;
 			gotoxy(vc, vc->state.x + vc->vc_par[0], vc->state.y);
@@ -2477,7 +2480,8 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 				vc->vc_par[0]--;
 			gotoxay(vc, vc->state.x ,vc->vc_par[0]);
 			return;
-		case 'H': case 'f':
+		case 'H':
+		case 'f':
 			if (vc->vc_par[0])
 				vc->vc_par[0]--;
 			if (vc->vc_par[1])
-- 
2.43.0


