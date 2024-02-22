Return-Path: <linux-kernel+bounces-76175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5A85F3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA122853F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BD381CF;
	Thu, 22 Feb 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="P32lxeo1"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F177364C1;
	Thu, 22 Feb 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592663; cv=none; b=I2XN88FT4pnTHx6d+/9VsqiPY7C7vWumlpmG64udQqlBJYGVk7apgSw9XUDq1C9XaeznYaGzpj00E3bKspNJ62IfryV87kQ8gODXxTvmx6OKyMDWpagBeY5a8fs9cdrzTGFQP3AIbMXwwG4lgD9vZSRoquhA/1ZHm2ModLGANH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592663; c=relaxed/simple;
	bh=rktYPar//0iKWagVEAXjEGawgr778Hk9WkEJv630Kt4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=KeCusXfsB9jQhECTAUj/aCtSfG4SAHJzCB0gHFNJYk3vZ/x9e5OS0eOOGZOO1RdrnfwzHZAgf7y6UDy/fIdvtMhclad+Myniuqza7vd9qlmbuMVf3kPHBu6f5p5LXIpudj9s0LvXZqf+isxV+u2VUheIyTZgRaRHMC8f60NhSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=P32lxeo1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rktYPar//0iKWagVEAXjEGawgr778Hk9WkEJv630Kt4=; t=1708592661; x=1709024661;
	 b=P32lxeo1KpkOrUEXXNY/fDtAP/8JtPVBQxsWBE6xQ3Rk8wLIvW975T+wcs1DGQXEWJ+G1445Zh
	xKw5ljafi8mRB/YQ0+Nus8B2E56Uk6a7lyqsxjUXducRw2c5Yz1U5U09D+Oc4oEMwfyrAI2IHV0GC
	MvjvxTgEhYBhiyuWmAwrlW04Q4eSnuWHnvi9cHCk2YHSnIeuld+KecGGXX13Tk0iJmywe9j/dmcDB
	eiGKsb9ffUbiCBAaeYKx3n3qmtIP9Xf+Qyn5lNrGWatyKQUQo3HdmjALElBQ+r/JMbE7nDXNwBJYM
	WbP5+id8cMvcoY6NV2jhyVPamhSathNiZTliw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rd504-0006qf-AA; Thu, 22 Feb 2024 10:04:16 +0100
Message-ID: <b743d91f-5e7d-4701-b515-5c2a84ebd291@leemhuis.info>
Date: Thu, 22 Feb 2024 10:04:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Please pick up 3a9626c816db90 ("drm/amd: Stop evicting resources on
 APUs in suspend") for linux-6.7.y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1708592661;94c7bcfc;
X-HE-SMSGID: 1rd504-0006qf-AA

Hi Greg! Could you please pick up 3a9626c816db90 ("drm/amd: Stop
evicting resources on APUs in suspend") for the earliest convenient
linux-6.7.y release? It together with another commit (91636168531909
("Revert "drm/amd: flush any delayed gfxoff on suspend entry"")) that is
also queued for 6.7.6 fixes suspend problems that apparently bother
quite a few people:
https://gitlab.freedesktop.org/drm/amd/-/issues/3132

Both come from the same series (note, patch 3 of that series was deferred):
https://lore.kernel.org/all/20240208055256.130917-1-mario.limonciello@amd.com/

Mario, who authored 3a9626c816db90, forgot to add a stable tag and ask
me to send this mail:
https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2292543

Ciao, Thorsten

