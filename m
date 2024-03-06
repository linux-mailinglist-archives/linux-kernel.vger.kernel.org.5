Return-Path: <linux-kernel+bounces-93202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C847872C4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B8EB216BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310479F2;
	Wed,  6 Mar 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Ts2xDUgc";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="WrixH0Vs"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACD6FBD;
	Wed,  6 Mar 2024 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689524; cv=none; b=YTK9PRHTaNbCf6bVOgehKFi4nRoxd+cz+sdvx6PcIwQZNKfyWtQ9K87DodY3osJrpu/GeMy36nWzg7vpYeAzCxsVn1APeZ32DpxWZUoZO6eG9RPhqiqzk3kqgS4f79cgVg5TXgqr3ak7OGzmumPCu7TcmDix+pNBhgVd4tXhkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689524; c=relaxed/simple;
	bh=8icK7I6k2ySylpR6U/utwQ5wybqz1zyNXnnpXmTq7/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BcBs6okaTIpV76RP5KOPLSkRR56UD9BFjPnyMx6eEpvtxelIGtO+OWJv/TU0e8q3OZnuoK4gBtg0Y46DgI83rodOJBpa6ic/xYIU81lhgvSAwCU/1ejCaG6lVWg7j7+XOzCqd/EVu2yBMfKG9mHSoi3/Q8XqM984VzlcrX4cyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Ts2xDUgc; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=WrixH0Vs; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 4F97EC009; Wed,  6 Mar 2024 02:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709689512; bh=24w78wFIT+tiDvHI5JiAHjNSzb2X5BqfSjmd7z6L0h8=;
	h=From:Date:Subject:To:Cc:From;
	b=Ts2xDUgci5g5MuYu3CKBP0uHW+R/CcycKJWQ8oQle2r47ROQ/5eHac4uBrH1lLGN5
	 kuIbjnylYgnZll0N74IaLpwiPbbogYXtqttN/yDqMKdRmnpNKJPJcA3MC2q09wQ8ou
	 I+F4vy6oj3ZwLVbom6TB/nCMi6QbdXEU8rg4mzo0Z8FRJHpq4qUKH+lj0ewo+2Sluw
	 ZAPidxtcze0LlmH1noRgCLV/wAe3nOJuP/QPhqTG9gOf+KGCUlzABhXPMPnkl6lSek
	 jF6muuaV9WUj4N1bBGedwkClOPtUp4WIy3LRXt4abvXVXcAKlLeLAgewtzVPRZYZm6
	 36dvphHl4mtvA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id EDE2FC009;
	Wed,  6 Mar 2024 02:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709689508; bh=24w78wFIT+tiDvHI5JiAHjNSzb2X5BqfSjmd7z6L0h8=;
	h=From:Date:Subject:To:Cc:From;
	b=WrixH0VsIj47VP+VKle8iE5Zmhp0iznWP0RSHryxDNXtFdiRyh/Qpm+xJhaqNdoTc
	 L73TvAwrKzhputsnHIVNtJ42jdbluoZPsaOyr4A4xCzeeFgljC3rZ4DtlBq/eqMqHH
	 gjmZk0XnQGcvUoG9Mg5E0AKcvWRrD4fxT59VZ5UxT2H8sy2XjUauC9pe+hAtJNvbOL
	 odohqhGCkhltsd+LO1Q6Wwp1kaeP7bnexxdICDcj4BEWbmVOkmHnFiT8AI/t5iGRxa
	 D9hk4HL41XapAObUvGozSgk7n0iGLO2sa882lOAlgeVchwpBVkKZjrtMokw59tKmhS
	 CwvzgBQWP75QA==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id cd420dad;
	Wed, 6 Mar 2024 01:45:01 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Wed, 06 Mar 2024 10:44:38 +0900
Subject: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAIXK52UC/x2NywrCQAwAf6XkbGDtQ8RfEQ/ZGN0cdi3JooXSf
 +/W4zAMs4KLqTjcuhVMvur6KQ3Opw44UXkL6rMx9KEfwxAumDPjTFb9p5UT8kBTiFO4jiTQokg
 uGI0KpyPL5FXsELPJS5f/6f7Yth3UctOueQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=w9OlutTB4nTqNTkTKcCGg2BC0kAnzLlfIIcxRubstHw=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBl58qd3EDKJquFQVqr5C+PMXOYo5Oak5/nQwXwg
 nESjIyMMY+JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZefKnQAKCRCrTpvsapjm
 cJTtD/9ambGPqZXUPyn6wOQAiJYvaqw+Kslr2NYKgb0gtcgO04dvPR6s8y2oWuJtiUlo/jHeFb5
 i/IbFKmyyHnybn6Vg3MQUErtGV3CsiZgFsfKH2/sXU0N6tz/YtPhbhaoaTynE3+FHWmspQut9iR
 TGxwTUbiYQ2p2IlEm0gTO/WbuONIsJRQggpSEfBgmjtHFVPnZvp5bTxSXTRldO/D6tIvwCDNezM
 6OdyyyqmGPJUEUriLQJnOtnNaYW+8hEh2bTCxHNmAG2otSeWt5ZU+4JCKtn69IJHRI7HD+FSSoA
 OMuHwtauN7/TKGXAUwyJVR5gL9WHDIKIzVBOX6x6qtVNnqcFZcOkAN3yXeRAD8NttJJWy0D10XD
 NDO/2NHC0GBmY40v2sZsQB69ceMaLSwWgAuG8FL01cyTxnt0bEVEfqWdytSGs8uIVqzQ1fdwqMi
 LjUvhHTBEMAqqoQhHchSvi2beaHynRAbxZh7dD9bU07+jqCbAcpQgFyaRF+nfJ2m3aSsUYrJmRR
 k+B45Ob2yysWoP7QUlbAiWmNQYHIGcc8G0C8QKBvi8/tU7UN9VXNt4q101qNxX3EMFLw1Lhm2CZ
 WEdItVMXNs0zM8051B8TB2/CSNUS1j9TokJgfjP7MJhh0pkk7PKKV3Rz56Em6Ycf3htm74ZUJfw
 KeTdfI0hVC2EJzA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

Commit e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB
partitions.") added a mask check for 'part_type', but the mask used was
wrong leading to the code intended for rpmb also being executed for GP3.

On some MMCs (but not all) this would make gp3 partition inaccessible:
armadillo:~# head -c 1 < /dev/mmcblk2gp3
head: standard input: I/O error
armadillo:~# dmesg -c
[  422.976583] mmc2: running CQE recovery
[  423.058182] mmc2: running CQE recovery
[  423.137607] mmc2: running CQE recovery
[  423.137802] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
[  423.237125] mmc2: running CQE recovery
[  423.318206] mmc2: running CQE recovery
[  423.397680] mmc2: running CQE recovery
[  423.397837] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  423.408287] Buffer I/O error on dev mmcblk2gp3, logical block 0, async page read

the part_type values of interest here are defined as follow:
main  0
boot0 1
boot1 2
rpmb  3
gp0   4
gp1   5
gp2   6
gp3   7

so mask with EXT_CSD_PART_CONFIG_ACC_MASK (7) to correctly identify rpmb

Fixes: e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB partitions.")
Cc: stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
A couple of notes:
- this doesn't fail on all eMMCs, I can still access gp3 on some models
  but it seems to fail reliably with micron's "G1M15L"
- I've encountered this on the 5.10 backport (in 5.10.208), so that'll
  need to be backported everywhere the fix was taken...

Thanks!
---
 drivers/mmc/core/block.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..86efa6084696 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -874,10 +874,11 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -892,10 +893,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
-	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_MASK;
+	const unsigned int rpmb = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;
 
-	if ((part_type & mask) == mask) {
+	if ((part_type & mask) == rpmb) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);

---
base-commit: 5847c9777c303a792202c609bd761dceb60f4eed
change-id: 20240306-mmc-partswitch-c3a50b5084ae

Best regards,
-- 
Dominique Martinet | Asmadeus


