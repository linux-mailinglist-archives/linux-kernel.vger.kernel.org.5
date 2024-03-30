Return-Path: <linux-kernel+bounces-125723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99811892B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D2E283DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8968374D9;
	Sat, 30 Mar 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eWkJ4n3U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E1EBB;
	Sat, 30 Mar 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711801535; cv=none; b=tQfsCb94B507ILNFxl4CUY/X2PUALVEM9YUYTbA2yFpHhuIOYDEQThhjlU9gTiDG3GgHEWP52pfeFjQRjH6NaVbOD2krlKbQGPaa0nHoaprhUemNNMB9/cjdB4s56dNUwYv/+SeXqMbas6vO2mw+vXQz2gqY90ut1eo4ICCFErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711801535; c=relaxed/simple;
	bh=X/1Wu8J05+GPKy/nST3sHKEZ7hVbqcR1skz2cHazK/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ak9mt4OqGC5sODuGg9gpzOKI8g/Nk6wvTdHawTE0BaMZ7xyNiqo5S0ZVVdpCvOQpjGhww7zbTU7HGfgKHF0/oycJDxYXgYcesUd+wQApzaKYy213wPNtVbIBFeR/dmdJVC+XaBmfzsLlim34ziV1Kv3XxTu1ddKPPNAJwkYBCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eWkJ4n3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF4C433C7;
	Sat, 30 Mar 2024 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711801535;
	bh=X/1Wu8J05+GPKy/nST3sHKEZ7hVbqcR1skz2cHazK/Y=;
	h=Date:From:To:Cc:Subject:From;
	b=eWkJ4n3U9CElT0uPy+naKIAdmwqbbMd9Eyi/4sGULSWTmZMLc3zLZ+XtJm8g8VVcY
	 FgkXQIjjMZURv6cfelZ3pTpCJhBnct5tWZ3046bKQ3rBMCWBnX1c1Pfidd2jqwspu9
	 skfO0LzKHqmsK/BmAX8HfhE6dcpKKFfC7LrFSpds=
Date: Sat, 30 Mar 2024 13:25:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.9-rc2
Message-ID: <ZggEu9MdSTNi-9FU@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.9-rc2

for you to fetch changes up to f37e76abd614b68987abc8e5c22d986013349771:

  staging: vc04_services: fix information leak in create_component() (2024-03-25 19:10:01 +0100)

----------------------------------------------------------------
Staging driver fixes for 6.9-rc2

Here are two small staging driver fixes for the vc04_services driver
that resolve reported problems:
  - strncpy fix for information leak
  - another information leak discovered by the previous strncpy fix

Both of these have been in linux-next all this past week with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: vc04_services: changen strncpy() to strscpy_pad()

Dan Carpenter (1):
      staging: vc04_services: fix information leak in create_component()

 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

