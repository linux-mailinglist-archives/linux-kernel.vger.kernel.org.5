Return-Path: <linux-kernel+bounces-92757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2D872593
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771641F26384
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5B14F98;
	Tue,  5 Mar 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrNdYMDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CB944F;
	Tue,  5 Mar 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659459; cv=none; b=qrA8qMkyX558VbRh60H2uVwaAkkpESuwPGrDncUMHw9ar0ma1WI3WACOfCFRTcJlIcDy7+il9MzFrwOyiBZIGZmqA5r1QGXa7jl/iqxT4rJUjUBwm3lv3ACptjUTGhjloQpcFzYvJbmzCR9qWu2Hnv9w2FedHErTeNjeJQRJHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659459; c=relaxed/simple;
	bh=ulWrTp+lCV+gMNzuEsMt7+NdH9m0bIisaeuCfQ/H8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=flSugAaGgIw4eTyqox2Vbdeh/ORZ+IUHUGZSoTfWEo5CgEMVKw+KNQF59XwsK9XgfWKPYa2p/PeK1D1GVmR//KPsNN46HeWMa0MIV/s78jb3erV8BfnBaSJnK4fOeROPhNfYD/XqVFGAMPO9J44Y14NpCbfivDgz49WXlPJ3yKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrNdYMDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE591C433F1;
	Tue,  5 Mar 2024 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709659458;
	bh=ulWrTp+lCV+gMNzuEsMt7+NdH9m0bIisaeuCfQ/H8QE=;
	h=Date:From:To:Cc:Subject:From;
	b=QrNdYMDPC/2tFJec41XasQKtNc041wNjuL5OO8PQ1hxCSb/ldGPYzjb0+xAueLtB5
	 QyGGFFB3eXPzuD8MP59Xwfh4Q5HbPZ8mqASpYcTd/uywW43rD4H0J6Y2l6jP+aH9Uz
	 03CnagADHeI4OrUvpjlxgEASx3VuVKCwrrhQOEKaV79BM2FUL/npnEXTRwFEVStAk+
	 KZDzeX71Cfeehmxe/IkcDIVpGK5wnQChaFYQc8HqYHKfZqCElrcT+MmF5Kd+FYfu1c
	 Q3jROYzeJxzSaf9T4pG53d9VHi2Cy9BP1G15pbrsOa9L7MgDEd0WXxq/+tRS7S1poW
	 iu/QSAT4pDzlA==
Date: Tue, 5 Mar 2024 11:24:15 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <cover.1709658886.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally. So, we are deprecating flexible-array
members in the middle of another struct.

There are currently a couple of local structures (`u` and `template`)
that are using a flexible `struct fw_iso_packet` as header for a couple
of on-stack arrays.

We make use of the `struct_group_tagged()` helper to separate the
flexible array from the rest of the members in the flexible structure,
and, with this, we can now declare objects of the type of the tagged
struct, without embedding the flexible array in the middle of another
struct.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which the flexible-array member can be
accessed.

With these changes, we fix a couple of -Wflex-array-member-not-at-end
warnings.

Gustavo A. R. Silva (2):
  firewire: Avoid -Wflex-array-member-not-at-end warning
  ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning

 drivers/firewire/core-cdev.c  |  9 +++++----
 include/linux/firewire.h      | 16 +++++++++-------
 sound/firewire/amdtp-stream.c |  8 +++++---
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.34.1


