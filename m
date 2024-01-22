Return-Path: <linux-kernel+bounces-34233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57183760C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2C81F254E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF374487B5;
	Mon, 22 Jan 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pSLL7Qw/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688B48791;
	Mon, 22 Jan 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961926; cv=none; b=dSh+MnH9NZe24nGamOcTrmaH5PTsGSmonfZBkKXJDiLyTjVqKvcsVaxs2+OYENXwLwYyGnOhsC/fKnb69eWQ6vVXIZ6rwFf3VSi/cZUWG8lBFcODFqo7bzqb5xsnsDfJkN+jtKuV7Ap5DAtUqr2xg/9p/WVrTDSrTy3ZhmxEejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961926; c=relaxed/simple;
	bh=mG5F7SUsP6kKkF9smZNF8bWdG0CxZ7Yyt+hCYsTEz5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o02AlWhoG7ZEWKZMBGcSPhUJnsOfAEB/3/PARQ3+lBRmBijemlB8xlnyEOSooI63ea1TkqTdqZp7ioH5GLVrwFIQ4IlnILSfY9KmxClGmiLMfuDnwyk4dTuCZ5b4WU1gHyeVhXW8O3S9Xjqk7mJnApT+2p5UxdoXVPfTfChqjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pSLL7Qw/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8599C7AE6;
	Mon, 22 Jan 2024 22:18:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8599C7AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705961911; bh=pPubC4Tc/qioeTfzHE0ZV6nqaXDRWuZN7VqWyXjBsGo=;
	h=From:To:Cc:Subject:Date:From;
	b=pSLL7Qw/fkxTNf/tDoC0C51wggAoNI8BKIGIniIvDsBrD5cCmYm8Ufb6nCCb5J/g7
	 X0EPs0CaWryLirf4tgfPmAe7q/Di/b7gCvECnV3v/HJP7iaDHeOqlQ4mNLbjdW/U96
	 Fih37z01w0ZHjknKEU5LQRI4e13wvsH9YxDziaSDWm6JhyMsxyj1ua+cxDjuN0erD2
	 S5PJvOWhBvDgxzkBaa9U5WzuMeST5+v2BRZ9QgKHBg3J5yn/e7ZxWsEJ8SYjNcmYUv
	 KzCNfzT59n8ppI3TeWxNmEZzxWCxji1/HQ84aMDfBh0lFnWviwunlWi7xpM5WE2VN7
	 VJ4oomkWkWukg==
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docs: rework the userspace-api top page
Date: Mon, 22 Jan 2024 15:18:30 -0700
Message-ID: <87ttn5m2q1.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add some subsection headings and reorder entries so that the page makes a
bit more sense.  With luck, adding some ordering will also reduce merge
conflicts due to everybody adding new entries at the end.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/userspace-api/index.rst | 48 ++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 09f61bd2ac2e..99a388fdefb5 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -9,31 +9,55 @@ While much of the kernel's user-space API is documented elsewhere
 also be found in the kernel tree itself.  This manual is intended to be the
 place where this information is gathered.
 
+
+System calls
+============
+
 .. toctree::
-   :caption: Table of contents
-   :maxdepth: 2
+   :maxdepth: 1
+
+   unshare
+   futex2
+   ebpf/index
+   ioctl/index
+
+Security-related interfaces
+===========================
+
+.. toctree::
+   :maxdepth: 1
 
    no_new_privs
    seccomp_filter
    landlock
-   unshare
+   lsm
    spec_ctrl
+   tee
+
+Devices and I/O
+===============
+
+.. toctree::
+   :maxdepth: 1
+
    accelerators/ocxl
    dma-buf-alloc-exchange
-   ebpf/index
-   ELF
-   ioctl/index
    iommu
    iommufd
    media/index
-   netlink/index
-   sysfs-platform_profile
+   dcdbas
    vduse
-   futex2
-   lsm
-   tee
    isapnp
-   dcdbas
+
+Everything else
+===============
+
+.. toctree::
+   :maxdepth: 1
+
+   ELF
+   netlink/index
+   sysfs-platform_profile
 
 .. only::  subproject and html
 
-- 
2.43.0


