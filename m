Return-Path: <linux-kernel+bounces-57084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09684D3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257E71C224D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF93136980;
	Wed,  7 Feb 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh9ZZwya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23BE136669;
	Wed,  7 Feb 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340941; cv=none; b=Vg4/dKuZn4AOhxOl1gOOx6/u/R6lHl4v5weUrVGa6gUppZp6xLPjIoRzglEnrDa7h34RR6Z7zr33dCR4YqQC9KMdkhSDnnv7ez25kl9ycwLpBenO/77pZkWuQ0na8mcQf4Tww/J3DpdadjIMI/s17FchUKBxUn+uwTc7NqGRMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340941; c=relaxed/simple;
	bh=hx0NIquIStvIVqnK2ueS87oqXDRKn5bR+M5RcazlOwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWDinPYGyHLi2ygf8rF5zR2myQODsKk4floUqPXA/tuXIuEfvzSeSimc99f3hnrzc45vk8NmoXMay9uNiA66m7ofRQ/7XQhFr4GFBNpQoSZkIWg5SuRtJQW0eNJTuBHJdeOY4uzIZnIUZtYlU1mTMDzbxLIsp4ss/k8jnjWN6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh9ZZwya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED3C433C7;
	Wed,  7 Feb 2024 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340939;
	bh=hx0NIquIStvIVqnK2ueS87oqXDRKn5bR+M5RcazlOwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mh9ZZwyaMox510p11hjJfZSakFaTIX5b93Nc9IHWMPHK7U7FZ7Bcn4KaZ3kQ5nDDs
	 FY0uHTYP5Oefm4HjHBUUT1CdeQ7qVnx2JUs9iVop+hHUvtzc79zYdR7dq3YIcqk7jW
	 WBv1YS6pcNUBQ7xuEE6pAXfeQBgFRwuN1+HmGdPyV8drx20rEtNnW9ksWosr2IUxrf
	 tUjzXqu1kn6cJlXLah8860MnznCLRWcGZ8fh4wSzRM18Y1OBlivGvEjbEJ8PlmgW/k
	 OWpEyb/0UnUZYvnLM5N254QrCeZNJxjjeItX6YUXQv6a1bs95PrnyP0Af0wxHKN4OA
	 Wult3ggF77RWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chhayly Leang <clw.leang@gmail.com>,
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
Subject: [PATCH AUTOSEL 6.7 18/44] ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
Date: Wed,  7 Feb 2024 16:20:45 -0500
Message-ID: <20240207212142.1399-18-sashal@kernel.org>
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

From: Chhayly Leang <clw.leang@gmail.com>

[ Upstream commit be220d2e5544ff094142d263db5cf94d034b5e39 ]

Adds sound support for ASUS Zenbook UM3402YAR with missing DSD

Signed-off-by: Chhayly Leang <clw.leang@gmail.com>
Link: https://lore.kernel.org/r/20240126080912.87422-1-clw.leang@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 59504852adc6..d74cf11eef1e 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
@@ -411,6 +412,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "10431683", generic_dsd_config },
 	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
-- 
2.43.0


