Return-Path: <linux-kernel+bounces-48175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882984583F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86C9288199
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FC8664C;
	Thu,  1 Feb 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPxFXXmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFC8663B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792095; cv=none; b=bB19CxLvuZMgEwPi2pkCkrSKu5oh4C5US3mP/7N3LtWcdnmrur/b5tw+ng+qlZQoGcvuejhCK+bkwX3aNwOf7NxnzrUtzVlUe9kEULRfp3USzcD81roVSJQp+wzdwfQO8sb/XUG8IdpGSZ+RB3sRm5kiw8Nn5fzziAVtaBluMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792095; c=relaxed/simple;
	bh=2y7CbDzTpQzkOvThYnBnSLOklaoR5dazKT+V9eJXstI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MK8yQvwiS4rqDA8sQ1QdzlQETSBGn9tbcG0mFTJnqRai73yVyyIYYDO9w7xsa0NunX6OolmZArKnNInW7WM8HyQjYx/d9scR3Qh/ng3eDx6uyuGrLxjf37ffmwt27fFKnuEp2Cu0YAUz4g7HbP6t/SOw9HeLnIKraNCMjTBdrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPxFXXmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F56C43394
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706792095;
	bh=2y7CbDzTpQzkOvThYnBnSLOklaoR5dazKT+V9eJXstI=;
	h=From:Date:Subject:To:Cc:From;
	b=dPxFXXmzy+ZcUSonO3yZjyJN8VOYRZrUJehJYteuSmYd9+caFaIBQwETQPyyNDYHE
	 f2LMtHWlmybPS6JMG/H7qxJlGn61XEKipQM3siPDub4pqRChlxk32/gf1Z0FRUtpeg
	 EqyjfLuHgEqbel9CB83OnWJJIf6QK/RFJdwRf6M0vu0VN6tQF0UdORBDDAIR6kYhEn
	 pHR4TWithhd7WC1gY8bbpeVr9o0PbGe6d6scUVrlhVXZLwJJz7SfeRQAIkLdJbP+I6
	 SNJQoYrQAoY+Euu+IGhrfpofhQ1ELuTM7wBu8YNMk9t+6zifwWL64PIEPLGF6CAU4m
	 DdmB9InrPjTvw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a58ef4a04so467008eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:54:55 -0800 (PST)
X-Gm-Message-State: AOJu0YxjaX2lPepqHkfmhTV52epH5kq8FB1jRmKnkth8cMgecDUEpts8
	cceA+uKqEMxWFeUS6rzCPIxxjYLH1wKoH7CZu9pwtjWgi2nxW5bIC5FyoXOKh4wmja7TrE01uK1
	CjASEPhfkD8Uxc6r4bWQyNAvMTro=
X-Google-Smtp-Source: AGHT+IHEyZK/0RIwuQsHuVg6wPxM6JOtZCd2kUv+r8s9iICHikTtDEyDB6fqUV/pvH4aG53A3RtdkuRGvOyHehbQRF0=
X-Received: by 2002:a4a:e2c3:0:b0:599:c1cf:ea6d with SMTP id
 l3-20020a4ae2c3000000b00599c1cfea6dmr5015375oot.1.1706792094465; Thu, 01 Feb
 2024 04:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6692:0:b0:514:c0b3:431 with HTTP; Thu, 1 Feb 2024
 04:54:53 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 1 Feb 2024 21:54:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8hypJfgauRpzQ3-oHr9CybwWe406sxjKp8U=icU7=sJw@mail.gmail.com>
Message-ID: <CAKYAXd8hypJfgauRpzQ3-oHr9CybwWe406sxjKp8U=icU7=sJw@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.8-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat fixes pull request for v6.8-rc3. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 296455ade1fdcf5f8f8c033201633b60946c589a:

  Merge tag 'char-misc-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
(2024-01-17 16:47:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.8-rc3

for you to fetch changes up to 0991abeddefa118479b0af32c28bcd662dec1561:

  exfat: fix zero the unwritten part for dio read (2024-01-18 23:01:51 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Fix BUG in iov_iter_revert reported from syzbot.

----------------------------------------------------------------
Yuezhang Mo (1):
      exfat: fix zero the unwritten part for dio read

 fs/exfat/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

