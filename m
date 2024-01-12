Return-Path: <linux-kernel+bounces-24684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E582C0D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5FAB23734
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20136DCF1;
	Fri, 12 Jan 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkXDNUp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386016DCE4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8783C433C7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705065688;
	bh=PwI5t7phxXbT0wnMaqwLpiXQ+DNd3pFQOUypo8b+XzA=;
	h=From:Date:Subject:To:Cc:From;
	b=FkXDNUp8WllXFivZ9rCXsA6tjxNQculNwB0Q7TPr+tQ0N0gQijf4GKnSgekZIggIZ
	 pUCLDWJmckzAnH+AmbmDy0aa5ZuTM5YYyyeDCTRShQpqnosN1gfv7VhtrGhnpdtVLR
	 USyIDatLUA1zcqLOVilc7yTYQry2qL91hzliPnsx1Sj+FurFmIgVC6xMAbVwNU3aYH
	 B+D5FKp3WpKMJ9ngp7cnZR/5kqq5j+U5BhFfMPYsk/0gRS40zKuQ+bAFQQPv0066Xi
	 op/CPh3390TzsZb05Ox44VsvQ3pSN+hXLHzLRr7DuiGFa0KN/25tX9K4iIdCnDdGNz
	 dgI1+27CVtF+w==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5987c127ac3so2222169eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:21:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwuAj6UP6HkPASq6AZiQ5IdwoV8S53Sa52e5mOJgIBsJiAcGI0R
	5DHWDVsVJnuC5AWR904Tk+TL6UBK0lhZaRkgzJ0=
X-Google-Smtp-Source: AGHT+IFTBYRCOTXOpNDhDS4bq+Gythg3PDbwJqt/r/JENRLgyGy0ZnR5N6sjMxUE9P9WEccGQVc56gNK879BU5HopbE=
X-Received: by 2002:a05:6820:1626:b0:596:14e6:f451 with SMTP id
 bb38-20020a056820162600b0059614e6f451mr590372oob.14.1705065687021; Fri, 12
 Jan 2024 05:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:668c:0:b0:513:2a06:84a8 with HTTP; Fri, 12 Jan 2024
 05:21:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Jan 2024 22:21:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_JM5mnQjUQLbsEBS8kTAaFy5Z+eYveFQgMpRDhiagzRA@mail.gmail.com>
Message-ID: <CAKYAXd_JM5mnQjUQLbsEBS8kTAaFy5Z+eYveFQgMpRDhiagzRA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.8-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.8-rc1

for you to fetch changes up to f55c096f62f100aa9f5f48d86e1b6846ecbd67e7:

  exfat: do not zero the extended part (2024-01-08 21:57:22 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Replace the internal table lookup algorithm with the hweight library
    and ffs of the bitops library.
  - Handle the two types of stream entry, valid data size(has been written)
    and data size separately.It will improves compatibility with two
    differently sized files created on Windows.

----------------------------------------------------------------
John Sanpe (2):
      exfat: using hweight instead of internal logic
      exfat: using ffs instead of internal logic

Yuezhang Mo (2):
      exfat: change to get file size from DataLength
      exfat: do not zero the extended part

 fs/exfat/balloc.c   |  87 ++++++++++-------------
 fs/exfat/exfat_fs.h |   5 +-
 fs/exfat/file.c     | 193 ++++++++++++++++++++++++++++++++++++++++++++++------
 fs/exfat/inode.c    | 136 +++++++++++++++++++++++++++++++-----
 fs/exfat/namei.c    |   6 ++
 5 files changed, 335 insertions(+), 92 deletions(-)

