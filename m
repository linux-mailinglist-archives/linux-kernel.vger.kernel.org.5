Return-Path: <linux-kernel+bounces-39980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03883D80A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5676D286678
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D181CD2E;
	Fri, 26 Jan 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiwJDXGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F441427F;
	Fri, 26 Jan 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263424; cv=none; b=Xo9WN1oI/1AaqhlW0RHvclQO69jyNx1Hp7jLr9MqiyYjEGKeCdlu/XSrXFu1+3Eu5kQ5wawVdh5gHBqGnynios3026TDX9dr1DIhJTFJNuegwk3mU2p2EqqdICVoiAiBwQ7gQNo81dAAtjm5NiWpOHVgw0bZjCg11PfBfZ0wXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263424; c=relaxed/simple;
	bh=6nM2zIopIoKUNJDEU+EOLVsurv60/XzN/SwLNO2V8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WqpUY40yPfwpW1sfuXU41LwjI7VOdLWusBOQ7qRxQ85m7qDN+WLwn9CM6v5lwoVZddfMgsU2pggoLbfzl9pz0bo61ZFNt4sKqvDjuQvACPkUNQMtC8U0ICl5yx2VySKvG0bOSIFVkdfUVcWGAs8LI/fN9jSPUG8T0JwDCB0ChOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiwJDXGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40958C433F1;
	Fri, 26 Jan 2024 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706263423;
	bh=6nM2zIopIoKUNJDEU+EOLVsurv60/XzN/SwLNO2V8WA=;
	h=Date:From:To:Cc:Subject:From;
	b=XiwJDXGui8uSslzAC48a4X/5Va/0hntMeTYXhLnJekT3z2uhG6HYH/0TkB6FvXNB/
	 v5iy7HvGdKeYzl0FE2G6k3hLRhxK6OOQmIkH5aFopSp7Q6H0CUsXLgm/mFovthR8DO
	 uMMLNV8vZqdBpE8ssIkVmd4EuZ7f+h61TP6RfNzBRYzWSCKyIW2fpmtP3cuzoMX8RT
	 a/R0G2a5tz79B2GL9yWDZhwk+MKudVHVjdyjHsZsYMz7Bmr8y5jEl5a16gNTKSagsN
	 v7W1DILGZ9tZIiHnn4quwWi4zkBlI2p0MHIPM5adR8Am10P+vv3hGLcd+eIseFkLNq
	 RaAhB3zCeexSw==
Date: Fri, 26 Jan 2024 11:03:38 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.8-rc2] media fixes
Message-ID: <20240126110338.2d1063f4@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-3


For:
- removal of K3 DT prefix from wave5;
- vb2 core: fix missing caps on VIDIO_CREATE_BUFS under certain circumstances;
- videobuf2: Stop direct calls to queue num_buffers field

Regards,
Mauro

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-3

for you to fetch changes up to b32431b753217d8d45b018443b1a7aac215921fb:

  media: vb2: refactor setting flags and caps, fix missing cap (2024-01-24 17:27:51 +0100)

----------------------------------------------------------------
media fixes for v6.8-rc2

----------------------------------------------------------------
Benjamin Gaignard (1):
      media: media videobuf2: Stop direct calls to queue num_buffers field

Brandon Brnich (2):
      dt-bindings: media: Remove K3 Family Prefix from Compatible
      media: chips-media: wave5: Remove K3 References

Hans Verkuil (1):
      media: vb2: refactor setting flags and caps, fix missing cap

 .../devicetree/bindings/media/cnm,wave521c.yaml    |  4 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |  2 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c    | 55 ++++++++++------------
 .../media/platform/chips-media/wave5/wave5-vpu.c   |  2 +-
 4 files changed, 30 insertions(+), 33 deletions(-)


