Return-Path: <linux-kernel+bounces-89541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AC86F1BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561641C213C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86241B298;
	Sat,  2 Mar 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yiT2xLwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B533CFC;
	Sat,  2 Mar 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709401460; cv=none; b=kVCssaFhS3q+N/ciMGomG6cbiGKm6gmRd4PMVzcfzGcr2/NkLqH83BnH2pjFvo/mIU6/N2aa+BQp/ZpZ3BjNtDJ1dlddyTeTOwkRG9e04PgZoquThCpKaz46BXkaBEAlPjaLAjvLECZ1QskpdPQJ4SURxSWWrpgzH7JWqKN9VUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709401460; c=relaxed/simple;
	bh=96mh/ptUtj4d9FWpUouwF9oIQ1O8lFIw9HZifKOuZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTazuiitzypU1dJaOAS5uHubTqxAJDU0ppaKtvTf1g1Ibto2yZP4ETIoRQc+3CTZbannzqyHHVx/jmLvTIvJVOlMt+UNm2tj/C6xJ+N/CSR6m5Myc3T+e935UKx41IcEnWkQ44MxuxqKiDjXx3XIEJ3V8EJgqQ4sLpXEr3h8gCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yiT2xLwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD62C433C7;
	Sat,  2 Mar 2024 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709401459;
	bh=96mh/ptUtj4d9FWpUouwF9oIQ1O8lFIw9HZifKOuZbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=yiT2xLwV0Fhc82/shHM5ZSpBQwbrbMrfw/GdK0zW4kPY8Sb3AkN7A+bz0iQVO4wjH
	 9YumC3on+On7H+NI0JnCUEGennw8Pt/pROLtuKdPUhP9enP1j3+0GkZy+/qqX6EBXJ
	 oa8o5rx6OE6w/yFTv8P+9mLXgxcRObWriuzvDXV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.8
Date: Sat,  2 Mar 2024 18:44:11 +0100
Message-ID: <2024030231-stash-embark-6ba6@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.8 kernel.

Only users that had build problems with 6.7.7 need to upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/ntfs3/frecord.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.7.8

Mark O'Donovan (1):
      fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS


