Return-Path: <linux-kernel+bounces-31615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AC8330EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C2D1C21B05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA5D5A0E4;
	Fri, 19 Jan 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKhpov33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA159179;
	Fri, 19 Jan 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704619; cv=none; b=XMgFsNwtMdQj4v+QQCShU0ZNps+5KrGnk8OItEtIjyuIqKdvlTyxrb0ZuxIz2K1D3xOh6iTbFVFEO+BM3GZFJ5Yej0377rl1V1bg0Iwy2V0m+js2KAl5gBWI8EeFl8OfPyDbLfuZO0jge+N886gSTbsxRDawcigxfFkikmZ+qG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704619; c=relaxed/simple;
	bh=+OlQiNp9QW4DNVyycmadAwKFEc8zhfDv08CT4QC9UNE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cX7zTANgxrEY5If9DQGzF19MdTAav7aRrm0jzHbfxaYZAcuSWHB2fWNuVjWiTLKuQyAT96gsA/TSQYJvZowgkhPBcpV4GI4xxA0Jiy4W8yOtvNHoxo/vc+4K7TIhW6K4iNUqJ2nGr1j+w7b7sgByAEqLqmTDBGxpocouHRpK4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKhpov33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8311CC433C7;
	Fri, 19 Jan 2024 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704619;
	bh=+OlQiNp9QW4DNVyycmadAwKFEc8zhfDv08CT4QC9UNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bKhpov33o2MgkYnYPrKeWYh97tVQfl2EjUg7NibP7D/zW1Rr0OKEAHagC8Bpzwqru
	 uhWq8epxDjzzGG5TrkYy54SMwdezHk0TGNIujmzASzlhLzr92DniAtPDcq6i13n2Qa
	 5DJHmWuQuPi9cuJY1oJvWTS8YJn36t1FmgbpordGusxzUrGg8L++miSeALQKo4RuzK
	 VGzcV+ytpr5vJAKRZltRDFQiLzu7aiXfYnO5mIpR7vDI6btmMlBEU87L1jrATIr5w1
	 Vbp6gj317YMG/j7l/scGEGpXXJufee9RTvx8r1lK2nzRScDnSdKGoQYqJmRTZKzjoU
	 JG8IS0mCu9JUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E2ADD8C97A;
	Fri, 19 Jan 2024 22:50:19 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools changes for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240109222804.28583-1-acme@kernel.org>
References: <20240109222804.28583-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240109222804.28583-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.8-1-2024-01-09
X-PR-Tracked-Commit-Id: d988c9f511af71a3445b6a4f3a2c67208ff8e480
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
Message-Id: <170570461943.3214.9911927855445066684.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jan 2024 22:50:19 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Ammy Yi <ammy.yi@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, Chengen Du <chengen.du@canonical.com>, Colin Ian King <colin.i.king@gmail.com>, David Laight <David.Laight@ACULAB.COM>, Disha Goel <disgoel@linux.ibm.com>, Guo Ren <guoren@kernel.org>, Hector Martin <marcan@marcan.st>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Inochi Amaoto <inochiama@outlook.com>, James Clark <james.clark@arm.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Kan Liang <kan.liang
 @linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Likhitha Korrapati <likhitha@linux.ibm.com>, Marc Zyngier <maz@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Nick Forrington <nick.forrington@arm.com>, Paran Lee <p4ranlee@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, Yang Jihong <yangjihong1@huawei.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, zhujun2 <zhujun2@cmss.chinamobile.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  9 Jan 2024 19:28:04 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.8-1-2024-01-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d64bf433c53cab2f48a3fff7a1f2a696bc5229a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

