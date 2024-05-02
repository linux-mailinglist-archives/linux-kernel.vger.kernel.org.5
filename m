Return-Path: <linux-kernel+bounces-166373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B68B99BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B6A1F243BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12F604C8;
	Thu,  2 May 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xch1aCry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7735D903;
	Thu,  2 May 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648126; cv=none; b=rxraOPvDiYPxmAAehG7Nfl0sV1YokpkZU9/3zuGXaXVYE/Nt3js0AM7GhafP1tIrSVfcJi0ioWvOdB5iL5e/K01f9fk96+z1gLu5dQDzoDvKJCieBbctfr0SNCqxicZj1PKmTcilwG5zbe//crPDxCqUit6H6LvtqTIwPzMVMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648126; c=relaxed/simple;
	bh=8K4ujeYhTAhKF8D1gB1WkqlDa8ad4YIK/nV9mxb+ubU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JXuPCBAnnFszEOC/c4P70DAOaTaj2k4e7+hdXzff29wKII+LmbAm8VA3TF/pMcgLD2Sg/bUxnbN+owzARNVTUfze27KRuah18ejAi5eTv9sEMaW0HM90h3WhQKzwF+83+UcijKXft7YtjOPWZz/ZUouK5eCYZbidncoVnsEITOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xch1aCry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FB1C32789;
	Thu,  2 May 2024 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714648126;
	bh=8K4ujeYhTAhKF8D1gB1WkqlDa8ad4YIK/nV9mxb+ubU=;
	h=From:Date:Subject:To:Cc:From;
	b=Xch1aCryETzgJNn5QhGZcIl+hrYm/8q+8iGpMNSEadG8jdgXj4l8beI0Va8LK+za9
	 6u6n51Xrji4oNk7v3xY3Hrhvpj/otTcmucJnfftr2ct+s1X2pJSEHYLD7dMUOsCo7j
	 Yfd3vs6csyzFhdyStor7UThIuuDtW5Mrcs6hLguygfULpyP61PMrwkA0lbbl9dYBY9
	 7woK1SdHk0yguXtN6Z1jW1tAanAuWmWT/rQo04Q9bUdlv6xIxaR78YJmA86EoZh0PM
	 PQIPy36ZfU+tTcDO3iesTFsILknaLAV5FVeAjuVZ/XI3p5rsnvcnAuU5WUNg5FcD68
	 RFZrW7SqGo7DA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5afbcf21abdso853346eaf.1;
        Thu, 02 May 2024 04:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCqKJSiIehH6/vLGJtFAFkB5A4eMzh8+vL2WarH5Xwzl/V+Rs88lOhGnkHd3AY9ECYc2wlb3rpCrQ+6ZkRH+8zGguhl7Om2UD8p7yY
X-Gm-Message-State: AOJu0YykXYEZ9HBVXEc6qEhHBXdE7H8Yxad+dgW994WidueBDCVu8kdH
	VQXozpiMy8qwemtCL06efqnVPFWUxbAEesuDg53sGA9PnwrDy6sYC4kOwj8ArbjzCjXStyy34dx
	4mTINwam63UYASkn2rg4FruDlEPM=
X-Google-Smtp-Source: AGHT+IF/nIdqFeA4jayC/Sos9U+g1FOb02A/CEFxDNMAhuoOi3HEctyS0uDfUx3Fc/O8DvAf6b84Dou4PbdImKnUN4s=
X-Received: by 2002:a4a:9887:0:b0:5aa:3e4f:f01e with SMTP id
 a7-20020a4a9887000000b005aa3e4ff01emr5105162ooj.1.1714648125193; Thu, 02 May
 2024 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 2 May 2024 13:08:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqRGw3NEOVXH4vwERcy-kO+tihXBmP74UJGEhsTMc_BA@mail.gmail.com>
Message-ID: <CAJZ5v0gqRGw3NEOVXH4vwERcy-kO+tihXBmP74UJGEhsTMc_BA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.9-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc7

with top-most commit d351eb0ab04c3e8109895fc33250cebbce9c11da

 thermal/debugfs: Prevent use-after-free from occurring after cdev removal

on top of commit ed30a4a51bb196781c8058073ea720133a65596f

 Linux 6.9-rc5

to receive thermal control fixes for 6.9-rc7.

These fix a memory leak and a few locking issues (that may cause the
kernel to crash in principle if all goes wrong) in the thermal debug
code introduced during the 6.8 development cycle.

Thanks!


---------------

Rafael J. Wysocki (3):
      thermal/debugfs: Free all thermal zone debug memory on zone removal
      thermal/debugfs: Fix two locking issues with thermal zone debug
      thermal/debugfs: Prevent use-after-free from occurring after cdev removal

---------------

 drivers/thermal/thermal_debugfs.c | 59 +++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 14 deletions(-)

