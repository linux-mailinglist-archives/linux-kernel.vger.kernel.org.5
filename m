Return-Path: <linux-kernel+bounces-29130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4D830947
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60DC1C226CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1B21A10;
	Wed, 17 Jan 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EHA4zorv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC321A06;
	Wed, 17 Jan 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504328; cv=none; b=QqKcyml5uowD8Y/3SEZEykOFkS5s+XZ8/nyhZAjd4teEXJuJQ2AB2S8AnQsDZGtlImmMptTGrya3s+VULAA/LLAOlq3TBNbCS68xeZVCpOF5QG7w7d1L8Z7j6/k0QIaH2jX+ZrvpUSp8h1kg3GwklMgexmTnmgmURTBzyAZtK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504328; c=relaxed/simple;
	bh=x1+8uF7RcxfIMN9GP9hFEOHeqmYRO26uThdUiQc+jYE=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=lY4jQFUYpIXTEFYaHN9h/gGHFkZUnsW351JXl7m1pZIc5kQGfUVzrAZ4BDkdOKzwPb9Q+hdQBwnTNtZfFHyJtox1e48CZsEvTozolg2SZSNJXCTL8wooCPj0eW6ilMqQ+Q1xpe8hJtPLndCqIMF63k3Z78/BbHnoiOVG+O5k0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EHA4zorv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705504324;
	bh=x1+8uF7RcxfIMN9GP9hFEOHeqmYRO26uThdUiQc+jYE=;
	h=From:To:Cc:Subject:Date:From;
	b=EHA4zorvTo9HZLf+qNYGMhXgSHZJjVLn+g6j/V+n2sb9GzM8Izm6S2Pk2h1ME5j2Z
	 6x5JiIuYy+c1KYcTng+yRT1SwkOYBPOQbhO2aJyJfOkGqUJBWe3wZwdkOH3Jw+Csmn
	 HzsTmGJryqCDLS+BHmyWAigvrKGpes1tBlf91AMURWbjs/YmsHfwQkkTVcaEQbr0Rg
	 D94w+4i8eAaCehaOMMXkLeyxIa/T8spxGWHbW/OPjuDEA5dbRWfE6viNPPxZwxqrXc
	 TFe0qiVELbmjI7vLAT+T0T2JJmVNUwNOh44IareAvyZQK7EeKmJbk4tleLphVJ9HKA
	 kCPEoAsxvkw+Q==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E76F63781FC7;
	Wed, 17 Jan 2024 15:12:02 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 0/4] visl: Add a tpg_verbose parameter for reference comparison
Date: Wed, 17 Jan 2024 10:10:14 -0500
Message-ID: <20240117151202.405426-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using visl in automated tests, we need to have output frames that
can be compared to reference frames or hash of those to validate that
the whole pipeline is working properly.

Make sure that a given input stream always outputs the same frames.
This is done by removing TPG information like queues status and pointer
values.

Introduce the tpg_verbose parameter to allow adding the more verbose
information that this patchset removes

This also adds some stable variation in the frames so that different
input give more different output.

Changes since v4:
 - Remove unnecessary changes in visl_get_ref_frames
 - Fix missing space after &&
Changes since v3:
 - Fix some more permissions in vidtv
 - Rename stable_output to tpg_verbose
 - Rebase on media_stage/master to include AV1 support
 - Remove code churn in visl_get_ref_frames()
 - Remove code duplication in visl_tpg_fill_sequence()
Changes since v2:
 - Set parameters permissions to 0444 in visl and vidtv
 - Make stable_output true by default
 - Keep showing frames timestamps and remove vb2 buffer indexes only in
   stable output mode
 - Make codec_variablility non optional (remove parameter, keep
   implementation)
 - Add details on used variability fields
Changes since v1:
 - Fix typo in parameter documentation

Detlev Casanova (4):
  media: visl,vidtv: Set parameters permissions to 0444
  media: visl: Add a tpg_verbose parameter
  doc: visl: Document tpg_verbose parameter
  visl: Add codec specific variability on output frames

 Documentation/admin-guide/media/visl.rst      |  12 +-
 .../media/test-drivers/vidtv/vidtv_bridge.c   |  26 +-
 drivers/media/test-drivers/visl/visl-core.c   |  15 +-
 drivers/media/test-drivers/visl/visl-dec.c    | 301 +++++++++++-------
 drivers/media/test-drivers/visl/visl.h        |   1 +
 5 files changed, 217 insertions(+), 138 deletions(-)

-- 
2.43.0


