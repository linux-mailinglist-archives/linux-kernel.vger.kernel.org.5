Return-Path: <linux-kernel+bounces-4462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E50817DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D71B221FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7B760AA;
	Mon, 18 Dec 2023 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWGfAo/7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077576082;
	Mon, 18 Dec 2023 23:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792A2C433C8;
	Mon, 18 Dec 2023 23:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702940626;
	bh=xaDz0t77rbGC6Oqii2udQGnriFl0a1oeeg/6m2BRWEA=;
	h=Date:From:To:Cc:Subject:From;
	b=pWGfAo/7yIaVRlwY6pXSYqfpeuoMvcjQVqHBjueNGbzgyBgQlpxKYiujhVSFlvcBG
	 F2eDaUndBRg4pr1UnZgCTnJWiWIB/Ziy+6HYtm04Ts5ileHXEvUrmfDm2UIKIrrS66
	 VFuVyUdw9R9duvnOWkXGgn46i6nnm4Rw7UXqBEOKXWg6YdncqXVHXNatTeGf+nubha
	 j/oN1rIFw4NGt8ftZxlguXjpZhwDbwZBhKjnlENXOgjLgYhPY54dXVj+pUaqL7x8cf
	 9KF5SxF8hHFKr311pb33PMFuKE8Eixvb+J++lY1ujOEZpN/EmINRUR1rMX4kGoPjt9
	 mfi/5nSDW0ZHw==
Message-ID: <918945b6-8959-4228-b642-396ae346b20a@kernel.org>
Date: Tue, 19 Dec 2023 08:03:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request for v6.8. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.8

for you to fetch changes up to aed5ed595960c6d301dcd4ed31aeaa7a8054c0c6:

  PM / devfreq: Synchronize devfreq_monitor_[start/stop] (2023-12-19 07:58:27 +0900)

----------------------------------------------------------------
Update devfreq next for v6.8

Detailed description for this pull request:
1. Fix buffer overflow of trans_stat_show sysfs node on devfreq core
- Fix buffer overflow of trans_stat_show sysfs node to replace
  sprintf with scnprintf and then replace it with sysfs_emit
  according to the syfs guide.

2. Fix the timer list corruption when frequent switching of governor
by synchronizing the devfreq_moniotr_start and _stop function.
----------------------------------------------------------------

Christian Marangi (2):
      PM / devfreq: Fix buffer overflow in trans_stat_show
      PM / devfreq: Convert to use sysfs_emit_at() API

Mukesh Ojha (1):
      PM / devfreq: Synchronize devfreq_monitor_[start/stop]

 Documentation/ABI/testing/sysfs-class-devfreq |  3 +
 drivers/devfreq/devfreq.c                     | 80 ++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 21 deletions(-)

