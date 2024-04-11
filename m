Return-Path: <linux-kernel+bounces-141442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDB8A1E52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE98A1C25153
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410247F51;
	Thu, 11 Apr 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIA+dJTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62F3F9CB;
	Thu, 11 Apr 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858738; cv=none; b=U1Q31EpeoGpDcuwy9OFs0r2HHbkjeMo5kYPy9zUmLyY6HQSyAfxk1DnOsDdczHfKTCa7K253Q9kcel+NlDiCliaF8blDc0JoN3wU25K2Q/VOZCxXKbzDGqxbBw1WVWSYTXfWTK3iojJWjTV9RWxcVeqL3Tyz0un9ES5H0Bdnnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858738; c=relaxed/simple;
	bh=Po6fGcLwrJPZP+lyaV/Dz9zY4SdnZLRnO8QH7Qa0QN8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KWbJItcBQ/8ydutIGl47smc4t9r2rOaJbpcKSlzr3534TygXB963QfD6v5vhqDFM6DcksPWzuKFixBJ997ixHejHkKzX4E2I6OMFStg/U4eJQ+G4Su0S4d8eMNtC3i7CJr0gWbH2p/+mP7+lBu6Fa4IZFLxxHyUrDmL98Oxi1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIA+dJTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7FBC113CD;
	Thu, 11 Apr 2024 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858737;
	bh=Po6fGcLwrJPZP+lyaV/Dz9zY4SdnZLRnO8QH7Qa0QN8=;
	h=From:Date:Subject:To:Cc:From;
	b=dIA+dJTKwPKgM0A4xLFrrF0z1bbzAMaN3e9RK0sRmiKS0k8fqsCEnoZpDcnjzsD70
	 7Z1x9e7cHY9GIDUoLkEv9je/3IRU6vvGhhOHud6I8UPEXiLzSWRHBZoctF27u/BTEM
	 TdwMgdR/Me7PphDc6NnFa/IhgpVw9Mme/vJTtNkek2BRy+zBZ2a0YTEDYJfjAUeqtN
	 HKThy6qi1pSWDUrvZB6IBQAOzKX2COO/JguyGRmPcbRc5qK06ufZcVBE6sFuMrcZpp
	 53U/7Jq8BbN3O/ImVYSvLIEvDZLFaBLPAZSElyWB499GiTjs6UFRVZTEhisiqCzICJ
	 lrTKH/LThnvqA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22ede5f7e0fso19094fac.0;
        Thu, 11 Apr 2024 11:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU113RLLkYORShARXCG1UZjo94faMixyr0uH94ZFJfq3waLNA1tz88p99ax8B4l0ye+2w5CKOA+peIS8w1BABOnXeQa1ADEAlUM7zy8
X-Gm-Message-State: AOJu0Yx9Fly0dgvr3WvDf0x++aVS6PqsPuie5qiuQtQNVj8zvOSt+Nba
	oAdcnCeBoZ3qlcars0g9sMqw0gRc6U5mqJqW9RT5RWx0oZg/MT8FdA2hr/MO89b48fCtwJXLogp
	pvHPNSPgSqG0GwSDH8q6dFEAilBk=
X-Google-Smtp-Source: AGHT+IHnGp1VDFRsIZBhnbclgmZybGtmOyXZ59XPZFm4wZRkd9aL9Lio8U1EpYqrOjjxKWAG4OhtOttBqyTMj2LMSXs=
X-Received: by 2002:a05:6870:e9a9:b0:229:e46d:763a with SMTP id
 r41-20020a056870e9a900b00229e46d763amr306351oao.0.1712858737159; Thu, 11 Apr
 2024 11:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Apr 2024 20:05:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCwmi=c_HC26APBEayNjzP4zepy9dMTypYz_Nh6fYk0w@mail.gmail.com>
Message-ID: <CAJZ5v0hCwmi=c_HC26APBEayNjzP4zepy9dMTypYz_Nh6fYk0w@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.9-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.9-rc4

with top-most commit 3c89a068bfd0698a5478f4cf39493595ef757d5e

 PM: s2idle: Make sure CPUs will wakeup directly on resume

on top of commit fec50db7033ea478773b159e0e2efb135270e3b7

 Linux 6.9-rc3

to receive a power management fix for 6.9-rc4.

This fixes the suspend-to-idle core code to guarantee that timers
queued on CPUs other than the one that has first left the idle state,
which should expire directly after resume, will be handled (Anna-Maria
Behnsen).

Thanks!


---------------

Anna-Maria Behnsen (1):
      PM: s2idle: Make sure CPUs will wakeup directly on resume

---------------

 kernel/power/suspend.c | 6 ++++++
 1 file changed, 6 insertions(+)

