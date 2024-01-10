Return-Path: <linux-kernel+bounces-22536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E1F829F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F73E281091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA4C4CE19;
	Wed, 10 Jan 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBarvP5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC24CDF5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A763C433F1;
	Wed, 10 Jan 2024 17:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704907789;
	bh=bs26RKWgi7kqNcbQdz2YXo3TwzsgW9dgH547QBX5bPo=;
	h=From:Subject:Date:To:Cc:From;
	b=qBarvP5Bv8UVYmar7xviZ+TB/2xX57G7D0DNZrNj4MwiBFoyRj1A9IZlGwU62AfE9
	 RoNOkNQPIOjU+SnQgY5OjK7jBrJ7yMmVcwDR8CCeIxyfR//I0PF82PGRd+/YspgvJ+
	 IA+CQA7GR1k5h7ZO0yv4tQo7aStYbU3MhfK2jPoQr/F3gGdr7Z8aIvYpAolsbuNxOC
	 rCoMvG4DPUryI5xr372YlRIgo7bEeVTIpGUepyWFROBkoN9cWeXV8AAAK/k6B+Cqpu
	 rN11ahfFwYBG0ne5EG9AAz7O7Eb4iuBBovHuN4PtL/QqpZPfqhhhuhZfNOeO6oA9Of
	 4Do6XIh1j+T3w==
Received: (nullmailer pid 2134034 invoked by uid 1000);
	Wed, 10 Jan 2024 17:29:48 -0000
From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] arm64: Cortex-A510 erratum 3117295 workaround
Date: Wed, 10 Jan 2024 11:29:19 -0600
Message-Id: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/TnmUC/x3MMQqAMAxA0auUzBaaqoNeRRxCjZrBKqmIUHp3i
 +Mb/s+QWIUTjCaD8iNJzliBjYGwU9zYylIN3vnOITpLelhWpZss9dW+DcHjwAHZQa0u5VXe/zj
 NpXyTmFQXYQAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

This short series enables the existing speculative unprivileged load 
workaround from Cortex-A520 on Cortex-A510 cores which are also affected 
by the erratum. The erratum number is 3117295 and details are available 
in the SDEN[1]. 

Rob

[1] https://developer.arm.com/documentation/SDEN1873361/latest/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (2):
      arm64: Rename ARM64_WORKAROUND_2966298
      arm64: errata: Add Cortex-A510 speculative unprivileged load workaround

 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 18 ++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 21 +++++++++++++++++----
 arch/arm64/kernel/entry.S                   |  2 +-
 arch/arm64/tools/cpucaps                    |  2 +-
 5 files changed, 39 insertions(+), 6 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20240110-arm-errata-a510-23cc219ec1e0

Best regards,
-- 
Rob Herring <robh@kernel.org>


