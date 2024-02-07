Return-Path: <linux-kernel+bounces-57082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247284D3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6553B26C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C613664B;
	Wed,  7 Feb 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHulLat9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38A135A6A;
	Wed,  7 Feb 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340937; cv=none; b=f4q6NozDrcUuo4GfSiy3np3HToSA+mDDfoONsdO4lGIVDBzvgjcS4UYAdYh+UZm83BZ3REJUZOH9uXrq3izBu1nfn/HZy+9W7KrSXhO11s4kjRrd49P45kfOKApFTqNAmk8OB3P7rhE7P9smGmGbopF2StOBhNfvVEe/IoBvBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340937; c=relaxed/simple;
	bh=lMIHaODZjwFLt53I0Ipnm70RQWp0dIWSiREstu+346A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPPZSCVEC8bsi9nm7QCqyip/nStdBuYTV60yZHWQCdMkmwgYlBqu/4nKYcezxyvpfbXB+xxGZMu9Im19YQAD1E6/u7iBGR/glZrfNr7G2PdfnmJOQ4k+S+PnI1+KwZJ1eBfCGMoFzHanFSAPImjW/PfVCFxEhG4DHOgdkCcKedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHulLat9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA907C433F1;
	Wed,  7 Feb 2024 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340937;
	bh=lMIHaODZjwFLt53I0Ipnm70RQWp0dIWSiREstu+346A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHulLat9mSw6SWUE0aUL6JbghORS6saQGD+2qA+10p445pJQXNfQX8dvKyiPxeyEW
	 xvSqk3jVtD2sDhEVoz1T3P+64jltd/B6PAThCwXdnugkhonW+sJb4M+b/QWJqD0Grb
	 4On444rDvcyNqQZAYvRPWkZdcUOilsQoQNRhN/45p6t0EodO8NCZWFN9kugb7Owusn
	 iupmwhsAHBeE7PcwjYxuvBkWR+G6q82HkANyllJQpR4QtN+Qv1j0E98Xo834FJZ/rK
	 5ygH7vmklY+J1XyHQaMKilFFi2ytEBmtVITx+d6OCeNIovjUFZEPZtz8LWFvbSX9DR
	 NMRpXy2bk52zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenzo Gomez <kenzo.sgomez@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 17/44] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Wed,  7 Feb 2024 16:20:44 -0500
Message-ID: <20240207212142.1399-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Kenzo Gomez <kenzo.sgomez@gmail.com>

[ Upstream commit c16dfab33f99fc3ff43d48253bc2784ccb84c1de ]

Add new model entry into configuration table.

Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>
Link: https://lore.kernel.org/r/20240127164621.26431-1-kenzo.sgomez@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a4..59504852adc6 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
 	{ "CSC3551", "104317F3", generic_dsd_config },
-- 
2.43.0


