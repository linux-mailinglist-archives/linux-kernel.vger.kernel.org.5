Return-Path: <linux-kernel+bounces-151419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29198AAEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFAA28244E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96898529A;
	Fri, 19 Apr 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csgdihub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D71E867;
	Fri, 19 Apr 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530232; cv=none; b=iEYB3whpfPhDTTFsuWryjC7eLQMFhzY6/l8e1CG4lYc3XAIaZ7HqZm6jmeidZMt4PrURskFN8K2BP0QPjfc+XZjSS+rN+MQthq3HHdmV7jxz+ZZhfCGri6v/+X7mAwWTm7ARbRUxAIVSV2/YaCzwHY+1nW8M1Z2rnCzjunBeY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530232; c=relaxed/simple;
	bh=aPLEYbaHgfUrN4oLaZucvtoDO/IgpJu5PPppjjqcruY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iI43NoO08gFrQNHKROU6jUD6+YmsuM6HmqUD1YwXjKmuMwhYhsWjtkRU1hKObfCuHH2cyRrY6XsMXaTsfPEjKm1f8KRCug/dYXewyC60UqAiIE6vq5FXAZ4nLsr6tIAFWpg3fX698+q+PpxIj28KiYfTdo9Z60B7a2CP0zDDeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csgdihub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A6C072AA;
	Fri, 19 Apr 2024 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713530231;
	bh=aPLEYbaHgfUrN4oLaZucvtoDO/IgpJu5PPppjjqcruY=;
	h=Date:From:To:Cc:Subject:From;
	b=csgdihubBNcZg7io1Luo3aTdhgwhjl9+/y3wS7BBjC9OqO4drHhPwHuQvxumXplda
	 nPqpDJWI7hd1Rx6IIMsGZIgENxosnMMBb1hbtgOartxhK62TZitZlgTyRIzMKXXVRU
	 XY6WaG0SdsHh72UJ71/HFXEJDT0613102mXELIGemTJil1/+yT9U9BFkgOWVHYBUYL
	 xvuEl+5wZVTpw7kl2gJXViMLxHSAPmacOw5jsfukGxi/KkFibeVWxGjaEkWIfT2LMT
	 a5WpEfH+kRXdukDYlyc3vOnBKZYvX8uSBJMUHBooguw/hL762s59AtvYwbC+d3NGbW
	 9Q0vyi6j20yuA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxnUR-000000004ec-33ZV;
	Fri, 19 Apr 2024 14:37:15 +0200
Date: Fri, 19 Apr 2024 14:37:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.9-rc5
Message-ID: <ZiJlewYVQiSSSrJ6@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.9-rc5

for you to fetch changes up to 582ee2f9d268d302595db3e36b985e5cbb93284d:

  USB: serial: option: add Telit FN920C04 rmnet compositions (2024-04-18 17:14:49 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.9-rc5

Here are some new modem device ids for 6.9-rc5.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

 drivers/usb/serial/option.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

