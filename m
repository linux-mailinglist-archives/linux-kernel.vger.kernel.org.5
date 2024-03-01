Return-Path: <linux-kernel+bounces-89197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43086EBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25D728AB93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4759174;
	Fri,  1 Mar 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNhmOfoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624E054273;
	Fri,  1 Mar 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332144; cv=none; b=qMxIyV4eyLjTEPO+dVRmOZdjFZ7xCz39jLSrvRqXUdh4LkTUMqMWWWzbLfvsqzKhZSpcit6cdAknJF5uDttvsHnINcMaPwGCZYsvZ/NKiBZ51NmdoFjhiqildudE7tQNmMTNHnuZgf7pmjCYbBTYMwiegjTTLR8AHi8XHXNheJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332144; c=relaxed/simple;
	bh=BT6iEoXRpRZ20lKNVwZa2tRgMc1sknRgERA5/FsoaO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NuYUOR+6DCeGQEIIDszdMZUSIaQip7UxhBUaE0qnpv+Fx2d+5L82HqkGJVli03F2jCxLOuUFw9FcoIb2gV3Tx+iPXVnO2wvSQanI87aPYTW3RT/JkVnzKH5Q0e4pGFf9KgXvpNWR4+B6YE8eKr53yoAhj5DZeMfglqWLKkzUz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNhmOfoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19443C433F1;
	Fri,  1 Mar 2024 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332144;
	bh=BT6iEoXRpRZ20lKNVwZa2tRgMc1sknRgERA5/FsoaO4=;
	h=Date:From:To:Cc:Subject:From;
	b=KNhmOfoQ4K1NIsmA1yvL14s0F5t9hlfXZ3OBQXlTRw31ljsFW+P+z/x6+8GqdcAzO
	 z3sVmGLOp8cLakhIHV5R+Svyo46S+J0fG6h11VMkcN3n1o73Pl6eVbeiZ0xuPEX+qK
	 mEZN93vkqmTF/jBV9MwMCQDNmxLBTAo+V0/3tVgs8Wd2DJP8UZJUhD4mW7BRUOZDym
	 AkNrTFm3yvEid1p3SDZaUyS7K6+hgkkDFL0vthGXoqzmefnD8XSaiA6Z4J4aoczuTU
	 qYI+YALzYedYUCtwNSxSHpcQyu7oPkEYvSXfGvnyClBIeczRV+erlz1KUkJDaq1ijC
	 M2mN++ujQsrSA==
Date: Fri, 1 Mar 2024 16:29:02 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.8, take 2
Message-ID: <20240301222902.GA3168830-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull this 1 commit.

Rob


The following changes since commit 4e06ec0774f5bebf10e27bc7a5ace4b48ae0fa56:

  dt-bindings: ufs: samsung,exynos-ufs: Add size constraints on "samsung,sysreg" (2024-02-13 10:32:13 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.8-2

for you to fetch changes up to 7cb50f6c9fbaa1c0b80100b8971bf13db5d75d06:

  of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing (2024-03-01 15:28:17 -0600)

----------------------------------------------------------------
Devicetree fix for v6.8, part 2:

One fix for a bug in fw_devlink handling of OF graph. This doesn't
completely fix the reported problems, but it's with users adding out of
tree code.

----------------------------------------------------------------
Saravana Kannan (1):
      of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

