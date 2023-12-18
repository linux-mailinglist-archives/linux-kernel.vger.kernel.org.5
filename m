Return-Path: <linux-kernel+bounces-4452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60993817D59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F023D1F23236
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4D74E3E;
	Mon, 18 Dec 2023 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+NlULa/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413072077
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D2C433C7;
	Mon, 18 Dec 2023 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702939229;
	bh=Eb6zwsfXpmmtyu0jcGWNM2iDOPHOYv7lEQv0ZpkeiXk=;
	h=Date:From:To:Cc:Subject:From;
	b=J+NlULa/yRFR3Kbp0BvQlK8pcnHJSvN5I/qI7KP2KProYPHNrbrWWxLXBAxy418bR
	 YGMgg7myyn37N62fY/L2MusS3nrOOY515g8G0+drQhosgjG3C5nZRDLF4zioJlOgZm
	 iu8jLpRvywRordaXG2mMQzau42+a5VJZ3JXScw/VEhW/1sLijGrWM8Yd3UXSPS5YvC
	 lMC1xa813kX04sI71V9ahEsgpPm3mec/Fo6mL/YjgVw7nh0Ac2uVAdIvoVODU25FDG
	 YQeXE3CIgK6doESyvT1Yi6jjKbdBtdXkZ+qHrgvSUDSgtuk1OeC87hm8YV3VH6fHLK
	 9weDNLGMi9kaQ==
Message-ID: <fee142e1-ac58-477f-b8d7-51e108dddbf6@kernel.org>
Date: Tue, 19 Dec 2023 07:40:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for 6.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Greg,

This is extcon-next pull request for v6.8. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.8
  
for you to fetch changes up to 7803680964c025f598f827b7ea7433467ef21a56:

  extcon: qcom-spmi-misc: don't use kernel-doc marker for comment (2023-12-12 09:33:47 +0900)

----------------------------------------------------------------
Update extcon next for v6.8

Detailed description for this pull request:
1. Fix possible memory leak of device name in extcon_dev_register()
 : Fix memory leak on error path of extcon_dev_register().

2. Set interrupt polarity based on device-tree for extcon-usbc-tusb320.c
 :Remove 'IRQF_TRIGGER_FALLING' request which is not allowed on
 every interrupt controller (i.e. arm64 GIC). Replace flag by a
 request that depends on the actual device-tree setting.

3. Fix the comment style according to guide on extcon-qcom-spmi-misc.c.
----------------------------------------------------------------

Lukas Funke (1):
      extcon: usbc-tusb320: Set interrupt polarity based on device-tree

Randy Dunlap (1):
      extcon: qcom-spmi-misc: don't use kernel-doc marker for comment

Yaxiong Tian (1):
      extcon: fix possible name leak in extcon_dev_register()

 drivers/extcon/extcon-qcom-spmi-misc.c | 2 +-
 drivers/extcon/extcon-usbc-tusb320.c   | 9 ++++++++-
 drivers/extcon/extcon.c                | 3 +--
 3 files changed, 10 insertions(+), 4 deletions(-)

