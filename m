Return-Path: <linux-kernel+bounces-110056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF188596D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0681F22441
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6058405F;
	Thu, 21 Mar 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLvncpF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DC83CC3;
	Thu, 21 Mar 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025519; cv=none; b=vGFEZ3DVAfnrUwq+Ib8o8KNOWOXWHeoxq5OXVpLEeLK/LPBWIuI5CbTW/uypEj5rruE6ZGMuR3kwA/oSXkPbS1He17ByntJ4RMfHRHkfoPqSlHT1P5aeGMZNK7xMZVtF3Q8f0lxjiUaaxHS6U/bNC6Sm8L7oaU2/fFHTK7Eya1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025519; c=relaxed/simple;
	bh=AJeureSQ7z+1aHfZed2T9ZG9lVLmPdFGaRIni9f2ZfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhKWbPig7tTFa6k9axYqO0lgTvNrqbDBK9wArI3v0OCcn//tFo5pUq0M74SIr6OJOAsrbN4D7wFKTZrHEpIK7YCQG0olCUJn/MtcNLi0xn01noaOemxQUWJ8tuBET3+cJ/HUY8nmFWveiOZftf22c3XvYjRmed+s/cz9M0GO60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLvncpF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB82C433C7;
	Thu, 21 Mar 2024 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711025519;
	bh=AJeureSQ7z+1aHfZed2T9ZG9lVLmPdFGaRIni9f2ZfI=;
	h=From:To:Cc:Subject:Date:From;
	b=iLvncpF9M/tSdfTl2yltcI5YnPeMoNItBlui+RKCLCEkpWBWyG4+HQYLu2l1Un8nR
	 xTJz6KGeESHDWvfSmCqFr5dW/jeL5C4HD85n6sBYInljhUVUk6SzTXNtodZeGkbDbP
	 O9g1526Tn1hpz04e+zH04kvOEnIKx1MQva/wXnTAxYNuAVqu06+5R7trJsWzdbiQOm
	 huEiDLLpY3kzq9mJl7M5szxJO7EXurQ3ZHrai12GkeV4/Pxf/r0yVrYJJUeec/9010
	 o4bVCfZ7cv6qfFr1EbwcuHkPp/026dvt7Uw8lZXCis4WpBRdCO9WU5R9rJot0Cqkgq
	 lcohumOxzNEzg==
From: Bjorn Andersson <andersson@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B . Marliere" <ricardo@marliere.net>
Subject: [GIT PULL] rpmsg updates for v6.9
Date: Thu, 21 Mar 2024 05:56:51 -0700
Message-ID: <20240321125653.1676534-1-andersson@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.9

for you to fetch changes up to b03aa6d4e9a74c4289929b6cf3c6bcc80270682d:

  rpmsg: core: Make rpmsg_bus const (2024-02-05 13:43:22 -0700)

----------------------------------------------------------------
rpmsg updates for v6.9

This transitions rpmsg_ctrl and rpmsg_char drivers away from the
deprecated ida_simple_*() API. It also makes the rpmsg_bus const.

----------------------------------------------------------------
Christophe JAILLET (1):
      rpmsg: Remove usage of the deprecated ida_simple_xx() API

Ricardo B. Marliere (1):
      rpmsg: core: Make rpmsg_bus const

 drivers/rpmsg/rpmsg_char.c | 12 ++++++------
 drivers/rpmsg/rpmsg_core.c |  2 +-
 drivers/rpmsg/rpmsg_ctrl.c | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

