Return-Path: <linux-kernel+bounces-145122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B938A4FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050191C211DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADF84DFA;
	Mon, 15 Apr 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVuvNkIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740D84DE7;
	Mon, 15 Apr 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185396; cv=none; b=bMYv0g70FhVdcs+utd1CBaimFTRRIkv4JId9/emikwaKOcWhpJP8WT2H2tThO4VYqxtc8IAUuH2xQqsV9jqjpHJ+5PQVurfdON8oPxA4zFhWSv875ZDpzSOsFdq9CTbx8m5v3eGqFH0MojJVfcRAYGx07dZlMb0sYuu50VTYjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185396; c=relaxed/simple;
	bh=+VqGBe/1XtOVVrJVDVR7EnXU0TpsDtuKxsPJDmrqNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay1X3SLgHjbwJ1SjAKLpDkjR5upt2Pkj3AnCm0lWC76w68SD8/dMSwRMeISqb6ohXz5O0sxJm78flnEWIQCxpjeoo2biYW7Xn+F4WmXCAffT1vCw2AdoGSYsdZuC80EVZcc3x3eUPlH8mISDi39EGfAZFqE/1Zm/HqpOA6571eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVuvNkIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC6C2BD10;
	Mon, 15 Apr 2024 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185396;
	bh=+VqGBe/1XtOVVrJVDVR7EnXU0TpsDtuKxsPJDmrqNPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVuvNkIo6xBs+6yYclf14npo0X81pJzKrGPipydjcNyPbm72deXmRuH0YLNJhxT51
	 LoPciiRb2MSCE7d2FxGsJT6vWBuS0vrto9N1Ww9TD/h5fgBEIblHbDvqp0ti/fy5ac
	 aIawDL1VZj+VMHjn+Ip0rgZvjUN5owcAsNT2NqJtVH7oucPR93FZQVMcxFu58Vh5+q
	 8O2tYqmI78A0NnJ0wJLmfV3gENNsPAwubFwx40FCnB16napmssuZIkYFfWfejG4Ilf
	 4Lt2LH9UYJaV6TeGRB+ePNJj1U25CrLfFrmJGti6JoQdQ71L8/QS5/xqGaJLAnUgOq
	 qVRjcxvP1glHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.6 02/12] regulator: tps65132: Add of_match table
Date: Mon, 15 Apr 2024 06:03:37 -0400
Message-ID: <20240415100358.3127162-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
Content-Transfer-Encoding: 8bit

From: André Apitzsch <git@apitzsch.eu>

[ Upstream commit a469158eaf8f4b10263b417856d923dfa38ae96d ]

Add of_match table for "ti,tps65132" compatible string.
This fixes automatic driver loading when using device-tree,
and if built as a module like major linux distributions do.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
Link: https://msgid.link/r/20240325-of_tps65132-v1-1-86a5f7ef4ede@apitzsch.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps65132-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index a06f5f2d79329..9c2f0dd42613d 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -267,10 +267,17 @@ static const struct i2c_device_id tps65132_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tps65132_id);
 
+static const struct of_device_id __maybe_unused tps65132_of_match[] = {
+	{ .compatible = "ti,tps65132" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tps65132_of_match);
+
 static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match_ptr(tps65132_of_match),
 	},
 	.probe = tps65132_probe,
 	.id_table = tps65132_id,
-- 
2.43.0


