Return-Path: <linux-kernel+bounces-89539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEA86F1B7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2948D1C213FC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D314B36102;
	Sat,  2 Mar 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ABmVsbmm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3C2C6B3;
	Sat,  2 Mar 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709401048; cv=none; b=mmyrEYB488HWf8zwp/o9TjhRh9tYi8QRYivTOkvA8l4+wY9xfMBdvneJriyJv/senM7qfiyYcyUnCjqNePGbnlCyY9M9oORSFamPJFfQoLEOsfkiBXk65nWsazsdOrmbjv15rqtPfTLBMLEaUET5HvR8OJbvFj5gOTP2Z9q5SlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709401048; c=relaxed/simple;
	bh=08aVx2wxAe2tBGjrOLWXlwHXTU3vLXbbPEsbEUzpgbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vd2NVEa5U6d/jBbLcU2Gjt1IMMaSzv01U5nAcIF700u8RJ/DKnAMRhDqZ2SKxGLdKMiDV4xD9k3bkWmSCh7pxNl3o3Bznk+KuYo46buVEDnZ41TrHUcLxmhrj9BqU1DzLTSJ5cQIu4lQVNr5xHE4z778cud71Ej4SxcoqI5ezrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ABmVsbmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A9C433F1;
	Sat,  2 Mar 2024 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709401047;
	bh=08aVx2wxAe2tBGjrOLWXlwHXTU3vLXbbPEsbEUzpgbc=;
	h=From:To:Cc:Subject:Date:From;
	b=ABmVsbmmS0sT0n6dKs/HU0OttL+yIcYDnB2qPjaoMc3KiblzqUV9D9JpjgFTqiMo7
	 IMt8xDEIvUA6CQs7kKJBxi0QeYh50m4KINzhbpe2D+KT5CN9Cvl5HF9kmo8x2cjEXH
	 IHhXp3eqlG3aynDBf70ohWBjYjNQeH8k1tzxAIDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.20
Date: Sat,  2 Mar 2024 18:37:19 +0100
Message-ID: <2024030256-unpledged-wrinkly-084d@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.20 kernel.

Only users that had build problems with 6.6.19 need to upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/ntfs3/frecord.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.20

Mark O'Donovan (1):
      fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS


