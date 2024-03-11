Return-Path: <linux-kernel+bounces-99381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFAF878794
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949861F221BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6C55823A;
	Mon, 11 Mar 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U48bQv5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CA58210;
	Mon, 11 Mar 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182216; cv=none; b=EFuReY+JHKFP7RpefVrQSmPiVPoHHZsxFvAeiD6+5U9bkitstp8xmWA6Yac3zQ6n+nWOYglmIBIeUifSilSMV9HLajxlPXBq7k4TAw/sPTPA2MysPDgjhZ+L2y3bAdXX7DFDKBMhDTYXuMh5IwgqZymSXSEaJwZ29BW8Yxa1i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182216; c=relaxed/simple;
	bh=8jQuTq5ACahaSio8vuPgNxnJFiCeJ56BrLNxLySJcXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3/gBkQW0ZQrdy1XJtHu7XRvrmSLMZp+/RPfSkVFW7VVhf0X5ELw27rUz4kNsTxGWhbAACrEys2zvzWbF92H5GCRJc7b3fw/AYKY0uuGWHxFkIP6IeadW0gF2LJiuJgkk/qyw9Qp2j9/vlWbGvz/gpryqMTgcXkPqhDCtTbPhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U48bQv5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FBEC43394;
	Mon, 11 Mar 2024 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182216;
	bh=8jQuTq5ACahaSio8vuPgNxnJFiCeJ56BrLNxLySJcXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U48bQv5yKMyJrzbkaFd9r9xKnj3WJH/MeBoV6OlsrGoAOJNOZNE05QxnymX1HJKvO
	 HXLKQU32bFwmqLk782IeECshNIUFji/TZKI4ZR1P5EkC4YSPoT3aOSMBrkBquVVQra
	 hRl7Vh7nWAv4w+OF/0epXOvoqQmUUp+uEUOsd690M48h3gsWLRxmtDBkc41Fmj3gTk
	 q2s37L22J/6DVOc0L9J2vMH6u0OHpOwK2lIzYL10R4PCp8xCA0wnCy+T9d87VvgW3T
	 47RyBYBObqKWLE1TfnGIurb/8QvwBI/ei2sQ6FqXYL7aGh9uiJHRRXjbg2LOPpEF9+
	 VTBLJ8wUNh3Ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.7 07/14] ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA
Date: Mon, 11 Mar 2024 14:36:10 -0400
Message-ID: <20240311183618.327694-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit b603d95692e47dc6f5f733e93c3841dc0c01e624 ]

Whilst this laptop contains _DSD inside the BIOS, there is an error in
this configuration. Override the _DSD in the BIOS with the correct
configuration for this laptop.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240301160154.158398-4-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d74cf11eef1ea..2de06e3db1a9e 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -83,6 +83,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CCF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
@@ -419,6 +420,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "104317F3", generic_dsd_config },
 	{ "CSC3551", "10431863", generic_dsd_config },
 	{ "CSC3551", "104318D3", generic_dsd_config },
+	{ "CSC3551", "10431A83", generic_dsd_config },
 	{ "CSC3551", "10431C9F", generic_dsd_config },
 	{ "CSC3551", "10431CAF", generic_dsd_config },
 	{ "CSC3551", "10431CCF", generic_dsd_config },
-- 
2.43.0


