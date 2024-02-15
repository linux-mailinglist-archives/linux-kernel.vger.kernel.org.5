Return-Path: <linux-kernel+bounces-66901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7985635A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B42A288BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A0612DD96;
	Thu, 15 Feb 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVt56Hh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1312C53F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000691; cv=none; b=L6pdBpV1ZPHUonZilVg3Y3g+hZedtIDaZ8tK/cc28ZU1I3B1WWpb3WWJNrQvUShCZNAg+/dikhXF6n1MpI8sEF2adroZ0DtyU6ZkcdVNkRz03Qb9JlmpBPp05F2ZxlYWO55UHQrkDzJE53irRNdbrTit4P4xnvm9MmzQmi4lb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000691; c=relaxed/simple;
	bh=+YDv/UVW9GahoPsSU0vjY9QtDCOt4MHJf1o+Lr+1AaQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=t9JI0iOI1vF0ty3JWvqtdJ6eZ7x4n81kDJHP5PeYUJ4M3C/JyHp1WiuZQP+cbssnoygn9ani8gtCSrAgqFQpGZyQW3UV1FgfrLT3fbrxvbi/UAz/yVfl0/xRU0QeKpIHApCudjVfSaEcLWp76ttWtFiZURoBvT6vooszeu3HBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVt56Hh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B6C433F1;
	Thu, 15 Feb 2024 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000690;
	bh=+YDv/UVW9GahoPsSU0vjY9QtDCOt4MHJf1o+Lr+1AaQ=;
	h=Date:From:To:cc:Subject:From;
	b=AVt56Hh/4LB9ZLN3K4rrPNea9Djud73tkWbuxzuoQ9SDjKPEw9HIRF69cHQXtvNRf
	 IIIqs8tGjMYUdyrLFV5kkFgSZGIeGZ32igb9Zcwoee+0FDycER5CHnc0VaQHBevJCl
	 Ndo+3lNfIM/eTYE/HBiuhaVjs/cw9pc2i2bnzshhBMfesyw6V5zDBI7sO2Q5cjatVN
	 sz0JfE0cui+WNAcr7zyX9P/2eqtPPBjLwjAAljwY3gbyBT4V0yW7I55cqSjGNwAiQz
	 e5yu7ZF3szPHAO7gGUI5dUyBFT49pU9ijWzNUcmJ6dCBgVY1bYw+EFAUiwg6U8Bbly
	 wnTYXgCZbWM9w==
Date: Thu, 15 Feb 2024 13:38:10 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2402151330460.21798@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024021501

to receive HID subsystem fixes, namely:

=====
- fix for 'MSC_SERIAL = 0' corner case handling in wacom driver 
  (Jason Gerecke)

- ACPI S3 suspend/resume fix for intel-ish-hid (Even Xu)

- race condition fix preventing Wacom driver from losing events shortly
  after initialization (Jason Gerecke)

- fix preventing certain Logitech HID++ devices from spamming kernel log 
  (Oleksandr Natalenko)
=====

Thanks.

----------------------------------------------------------------
Even Xu (1):
      HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI S3 suspend

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Manuel Fombuena (1):
      HID: multitouch: Add required quirk for Synaptics 0xcddc device

Oleksandr Natalenko (1):
      HID: logitech-hidpp: Do not flood kernel log

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

 drivers/hid/hid-logitech-hidpp.c         | 13 +++++--
 drivers/hid/hid-multitouch.c             |  4 ++
 drivers/hid/intel-ish-hid/ishtp/bus.c    |  2 +
 drivers/hid/intel-ish-hid/ishtp/client.c |  4 +-
 drivers/hid/wacom_sys.c                  | 63 ++++++++++++++++++++++----------
 drivers/hid/wacom_wac.c                  |  9 ++++-
 6 files changed, 70 insertions(+), 25 deletions(-)

-- 
Jiri Kosina
SUSE Labs


