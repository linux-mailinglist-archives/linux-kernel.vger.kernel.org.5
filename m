Return-Path: <linux-kernel+bounces-138992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1E89FD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3DB1C21534
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368B17B500;
	Wed, 10 Apr 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiO5gWg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AB17A918;
	Wed, 10 Apr 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767137; cv=none; b=u+5s206kLmryz1O5bfY/nVJ+MS7sVHNO1ghe4oUFvzRUuXD7gLvSmFKGuqRIxNEtUi5S9jrt3A0WnxyAAt/v4/Wi7ghWVuyWEriVHQmSiGIt6sFyLFL3ipmRTsPC+95uQaIXWXb69HA8lEHZbhbKrp/dwyiFc38oqNiMnG8X1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767137; c=relaxed/simple;
	bh=PWUjcyPX2DktRM5y9jGxIMSJTLsCA13jA7S9gEzHpeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jFwtC4FQ8NDFWYRaPvgBMkAz5KLkAomGfrFshycu70Yb7GnYLv6869yXOp+zX43CLAqDl9kekihaVHMfy9rQcnumTuWoQov8/+0fwC9AXfEWLeV8ULeQ5fWIkgHAgZakxPv2f0OXz9j+89BynroKKWO65RuL5kCqznQbqNY37lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiO5gWg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49148C433F1;
	Wed, 10 Apr 2024 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767136;
	bh=PWUjcyPX2DktRM5y9jGxIMSJTLsCA13jA7S9gEzHpeo=;
	h=Date:From:To:Cc:Subject:From;
	b=KiO5gWg3GwuasrXJmH8VTXunrabNuWQBr2y3Ki+FX6ssA+1CkXuIcS73YgmS9hu7i
	 SCQgVdyWBUCLUnx3KLjW+HW2EpOHRI21xclq6gej6ghSE/DJvncDjL9OqP4uPZwSxF
	 E3XBlREtxIvYoDTILz6M3yh1huJlwE/x29o7PkA2/l0KW18Y5+7xA+vCqtHTUIC6Yc
	 5lMQeTPWOFh2FJ6WNIIAs6MeZ543ycvsLQvxF5JZvvo2yWi88x58ZfbMo/QvNWQslO
	 qjRzp2ii11PAceriRokU0L+7MrQnRgO3+lEC9CPe9RIrzzOCFEHLzsP3L71MLMpLOI
	 mXCBja0oSXmiA==
Date: Wed, 10 Apr 2024 18:38:52 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.9-rc4] media fixes
Message-ID: <20240410183852.6df5011e@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-2

For:
  - some fixes causing oops on mediatec vcodec encoder/decoder.

Regards,
Mauro

---


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.9-2

for you to fetch changes up to d353c3c34af08cfd4eaafc8c55f664eacec274ee:

  media: mediatek: vcodec: support 36 bits physical address (2024-03-26 09:52:59 +0100)

----------------------------------------------------------------
media fixes for v6.9-rc4

----------------------------------------------------------------
Irui Wang (1):
      media: mediatek: vcodec: Handle VP9 superframe bitstream with 8 sub-frames

Nicolas Dufresne (1):
      media: mediatek: vcodec: Fix oops when HEVC init fails

Yunfei Dong (3):
      media: mediatek: vcodec: adding lock to protect decoder context list
      media: mediatek: vcodec: adding lock to protect encoder context list
      media: mediatek: vcodec: support 36 bits physical address

 .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c |  8 ++++----
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     |  5 +++++
 .../platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 ++
 .../mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c     |  2 +-
 .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c |  2 +-
 .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c | 11 ++++++-----
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        |  4 ++--
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c  |  2 ++
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     |  5 +++++
 .../platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 ++
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c  |  2 ++
 11 files changed, 32 insertions(+), 13 deletions(-)


