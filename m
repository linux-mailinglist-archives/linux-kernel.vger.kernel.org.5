Return-Path: <linux-kernel+bounces-97889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AB877133
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E16B281DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86C3BBCC;
	Sat,  9 Mar 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2SCYTE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD038DF2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709988275; cv=none; b=iNhuMnEC2RD5Jn8VSciqvhBWMxpSh0pOvFPACgjrxk1/208f/SNpRbACrUxTS+9rILF6XzK6gL/LTdNyOhK48/DFC9lih1I9QyM6Hq85Ztb3ne27NL3kGs1gK0L29kOl0TF9J/GRkWhJTu4dBiu9FD+8cGj6eu44nrnSXzBCRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709988275; c=relaxed/simple;
	bh=pnzh3b3pOFh7MARmEVAMjS+PE/Oxh23soOswQGF0o3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH9oAse2r+AIhmr10DKgzB73D6YfAg5g5zn4uG65qxw3qRNGsmbINULebpJLW1bijszLo5164EJsiA5sA+UZfA69/sVweT2E253VDOm2ip8adWIiw2GCsYmeQVKFNxWBCqIq5AfLSSj+KXOPNkGIE19amZhjiBk7zwjCghJdtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2SCYTE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BB0C433F1;
	Sat,  9 Mar 2024 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709988275;
	bh=pnzh3b3pOFh7MARmEVAMjS+PE/Oxh23soOswQGF0o3M=;
	h=From:To:Cc:Subject:Date:From;
	b=U2SCYTE4kbb4XZmyFd81WRjQ3tSaEBZEVAulv6QSie7JfaPf79b8m2HmsJsw4eG2b
	 10A6orVwQrSeEeP8BQDRQFkREbEDTFp0Cq3H7cgFuUSJByfO605tDSdKROlJmUuGxQ
	 cJ4aoiJqn8g7SeOSmp+uAqTYgYeE7i+a5nmLmd0WjY6BSr00fS+S4ElFRChUEYCAeh
	 kBohvPoXWf7T+W6irCHbDj7sBA59K0aBDZt52rWv9yRbgNKS+GRg1bjd4FNZ+MYttj
	 4gr4QzIhjXFIweSq7tnoMgyEBUDk/8GF3IIRgVGa8ilXYs9BuFWVq2v4xy8e4ci2cx
	 zzpL7n4tj1TUQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v6.9
Date: Sat,  9 Mar 2024 13:44:23 +0100
Message-ID: <20240309124423.326574-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

A couple trivial changes for Compiler Attributes.

Please pull for v6.9 -- thanks!

Cheers,
Miguel

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-6.9

for you to fetch changes up to 2993eb7a8d34aee6165e1f6676e81cdf1d22aa62:

  Compiler Attributes: counted_by: fixup clang URL (2024-01-23 20:38:18 +0100)

----------------------------------------------------------------
Compiler Attributes changes for v6.9

A couple trivial changes.

----------------------------------------------------------------
Sergey Senozhatsky (2):
      Compiler Attributes: counted_by: bump min gcc version
      Compiler Attributes: counted_by: fixup clang URL

 include/linux/compiler_attributes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

