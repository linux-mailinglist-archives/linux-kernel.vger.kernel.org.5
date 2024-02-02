Return-Path: <linux-kernel+bounces-50007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9C8472F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F991C21439
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87FA1468EF;
	Fri,  2 Feb 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQcOhnUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3E145B23;
	Fri,  2 Feb 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887116; cv=none; b=G2bplsQNtpitIw5UFLVJjAOhO3EQPY021BxsL+Yvfm2Y2osOLe/ohf504NC+FUwkD4PY8Kf24Jqgm7e1JTOMUDDbR2aS/GKiery9obpRHcOwM3ClS6wj0eteLp86Tx/GSa4kOnxfDiagkF6oPXHwZG06EzzShPfrhtEVlIpjbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887116; c=relaxed/simple;
	bh=6t6R5CJEHME/IBmZS0DVoNaz0FLeEZ3QHw8W3A7sirE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KxE9gQ93BpcIqVDPiDLT8AFZyuC5hsGJWxnVurPvXGqLlh6pjfGBLRsMIuzjrELlyhFcSZDMuWBm0v3bramZiVdVZFTRQ3gnaeLjHF9KpRdyX8w4tW4REVVfmz9yeqfojQLYkYyn2l6JkFKXEHcl47cK2IpPC8JPDUgRO37hPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQcOhnUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A6C433F1;
	Fri,  2 Feb 2024 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706887115;
	bh=6t6R5CJEHME/IBmZS0DVoNaz0FLeEZ3QHw8W3A7sirE=;
	h=Date:From:To:Cc:Subject:From;
	b=cQcOhnUqaRHNLwnS/VIxrw6cM2q7hu9TBkTRE4Pc66xipugRLgRobqaXuOlAd32oa
	 r3x1qmEyxyWbSgLnnzob01cBpXHSuamIwBb1wCG3STrXcmZSFAHH8rsmvCztByKvzv
	 RATSLmRFxD4A1HcBjX5oEfKl8EzVa71Nh56XbHng9ue1FB/oYvoRPnpUuSL1eqC/0h
	 AAMGYdENJnvnITCEvh49IXRsrg35lNaOzbNd7Z046x8u/eVlXYxrn9cq9M4QDnCxn5
	 WAMbSjf8YYiQwO4fgHnsdiLb9ix65+F938vBPtLMr3THE3hrT7mCpm+jG3sO8iIxAj
	 ZacNhbK7dDVrg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rVvJP-000000003qK-1PZ0;
	Fri, 02 Feb 2024 16:18:39 +0100
Date: Fri, 2 Feb 2024 16:18:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.8-rc3
Message-ID: <Zb0Hz0dFStw_bcrh@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.8-rc3

for you to fetch changes up to b4a1f4eaf1d798066affc6ad040f76eb1a16e1c9:

  USB: serial: option: add Fibocom FM101-GL variant (2024-01-31 10:21:20 +0100)

----------------------------------------------------------------
USB-serial device ids for 6.8-rc3

Here are some new device ids for 6.8-rc3.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

 drivers/usb/serial/cp210x.c   | 1 +
 drivers/usb/serial/option.c   | 1 +
 drivers/usb/serial/qcserial.c | 2 ++
 3 files changed, 4 insertions(+)

