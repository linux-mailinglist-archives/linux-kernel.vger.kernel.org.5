Return-Path: <linux-kernel+bounces-94190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A171873B17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069862807BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51665135410;
	Wed,  6 Mar 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttL9H21N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA561EF1C;
	Wed,  6 Mar 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740028; cv=none; b=ZRWQVZO9UrY3WFpgufE0EEvFvD5a4icOaHE3bh9gt+MygmhQLM+m+a0dKA+w26Xxya7xQhhgFoSNPZQZgEootq4xCeS5p3/xNJ8gdKYnGYHLw7gXIuYoZTgpkxVTrj3Zr2ARizJevzISjgGiEO1UirBH3bxUqWaRau5WJAUb9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740028; c=relaxed/simple;
	bh=9DOihWQw0xuRTLjGIEQbHnRXdG9fyUWdY9YNVRIcx2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7idwTluXTtA6p6ZiR15sgyxCkUJOQ7bKrrPuiVC0uZSONvNwwfGndUKoVYMgRXPjQr/skal9L/BKWPpbpJz407A306ouFCUrbTd172A1HuG+UgcM5bx4FXFdAB/B/tsYnYMZUKOaooxAHTfXwpaUcfqwbf+l5RwsjrOdKAe+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttL9H21N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB8C433F1;
	Wed,  6 Mar 2024 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709740028;
	bh=9DOihWQw0xuRTLjGIEQbHnRXdG9fyUWdY9YNVRIcx2o=;
	h=From:To:Cc:Subject:Date:From;
	b=ttL9H21NSL2imX2DI0HYqy6nx9UlnZI55BzxADMtnM0o+/Fu10kzkerlNOxafY3HZ
	 DVA89wjxIR804P0/gHDAsykFUrWZx2XEFpVrgoLDFSKc0zu51rc1lXepryUVSI2xdd
	 u6jpZ/NC4gOpCk7PoxLtbwjjy7lLClV8Ack3j6q13j7/dZsvoVOLQhcTBNjwNDAStu
	 s40RFGICmri6J80r19tBz9EcG0CCxmO5HMu9z00jKgLOg57Ver5MqzWznlkiDQnqPJ
	 yXN9E/hXyHK8m6HC9EYgAock0xatww+lYOMevWjHrhIzMP0JCW+qcLup9JELwRXzUJ
	 fzRK87hoaNEUA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] Add Jeff Kirsher to .get_maintainer.ignore
Date: Wed,  6 Mar 2024 07:47:03 -0800
Message-ID: <20240306154703.1392919-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeff was retired as the Intel driver maintainer in
commit 6667df916fce ("MAINTAINERS: Update MAINTAINERS for
Intel ethernet drivers"), and his address bounces.
But he has signed-off a lot of patches over the years
so get_maintainer insists on CCing him.

We haven't heard from him since he left Intel, so remapping
the address via mailmap is also pointless. Add to ignored
addresses.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jesse.brandeburg@intel.com
CC: anthony.l.nguyen@intel.com
CC: linux-kernel@vger.kernel.org
---
 .get_maintainer.ignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index c298bab3d320..7d1b30aae874 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1,4 +1,5 @@
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Christoph Hellwig <hch@lst.de>
+Jeff Kirsher <jeffrey.t.kirsher@intel.com>
 Marc Gonzalez <marc.w.gonzalez@free.fr>
-- 
2.44.0


