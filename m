Return-Path: <linux-kernel+bounces-113163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34948881F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49AC1C221A0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7C1741C2;
	Sun, 24 Mar 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3pgStxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A616F1304B0;
	Sun, 24 Mar 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319965; cv=none; b=PEERwcdZb+oZNQPFxptDxVnKjS2TuzaPdbcnW7jqyJ6/tl5v1a8niPYVNcFH07OpZhotiA5p6RrdKNxqR1OTCN7AIEXbZn1wx9X3ahxMTaUCwfVCEXSRgiTBz+QBcFixNYKwrr/FJwLeBlQnLY0IGuqpOvAIQ8otKzXGuefBmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319965; c=relaxed/simple;
	bh=XDtBQWhsDplhQAGI/ZUTgS2XDcZOfYklpJ8bHYM4Src=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB3TSmLLIsYVuV6IvWx9ff+60lk8n0s+tHl2bE7qv2TbAfshSbu+baRF3sI3ZMW6tjjAbj26zT/QPxZWyeqpWyuRu8jamXwHurFns/PiWvODvzBqTH8/l+BJB8JtYq9YImBE8qo9ON9kVh6VF9WtFOWsfusA6V4I26XFUVFrsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3pgStxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8971AC43394;
	Sun, 24 Mar 2024 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319965;
	bh=XDtBQWhsDplhQAGI/ZUTgS2XDcZOfYklpJ8bHYM4Src=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3pgStxgRJPhrw3WZuGxQ7wtP54+kPTSslMFWrhbBjREaGg/NPKLWqYdV4QuBJWsy
	 6VdaVXrvn8Oku5LCdM6PTFsA5Nzbwn+vnLDIU80iQ+dlF4EdqcsjAsMKyqYS4mktYc
	 04pKsYuQCQvd5unk5jdkE6cq26732d0EPJ24E310xvuCLwfdlVqWkqqFKfb7466E6R
	 0lClz5egOHub8319wTsdYNsd1zwOuWVVGYTlovQ5JuFF6rsG5TfkptIHmTLo7t71Ye
	 T7HN24zw3R/lPGpAJvbom7UCAfjuynVZr+gyIopOuZ+ov25YopZGvjka8joS4/UFAt
	 1qE1v7Lt/2zvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Kudinov <m.kudinovv@gmail.com>,
	Maxim Trofimov <maxvereschagin@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 272/715] ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override
Date: Sun, 24 Mar 2024 18:27:31 -0400
Message-ID: <20240324223455.1342824-273-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maxim Kudinov <m.kudinovv@gmail.com>

[ Upstream commit 021a67d096154893cd1d883c7be0097e2ee327fd ]

A known issue on some Zen laptops, keyboard stopped working due to commit
9946e39fe8d0 fael@kernel.org("ACPI: resource: skip IRQ override on AMD
Zen platforms") on kernel 5.19.10.

The ACPI IRQ override is required for this board due to buggy DSDT, thus
adding the board vendor and name to irq1_edge_low_force_override fixes
the issue.

Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com/
Tested-by: Maxim Trofimov <maxvereschagin@gmail.com>
Signed-off-by: Maxim Kudinov <m.kudinovv@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 3ebb74eb768a5..c843feb02e980 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -602,6 +602,13 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
 		},
 	},
+	{
+		/* MAIBENBEN X577 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
+			DMI_MATCH(DMI_BOARD_NAME, "X577"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


