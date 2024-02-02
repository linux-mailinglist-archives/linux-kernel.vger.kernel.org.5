Return-Path: <linux-kernel+bounces-49692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07F846E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3861D1C23EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67D13BEBA;
	Fri,  2 Feb 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0ND5eKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB41426A;
	Fri,  2 Feb 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870741; cv=none; b=c+syU6htV6UmfWaiFotls6tb7vmCf+JM6HQs6huR1a0+zf6A7NSXCt8xtRdwRtWHHFE2fOLCdQwT4hm8pBQodBMG1/ldqm80x0g6bwK1LAQ26KQBc60+MhWAOrVJKJu+T6IYEjDAxT+WSWrYCmOXgdBd3klyFBGp9/TuetA3IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870741; c=relaxed/simple;
	bh=hMlT+02qZo3h68LxyJIVLv2jA0reVr/0LdCJMMpMQws=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tPwBuV2h9acvcyjDadGM576zcTmo9tuPvirSX3IxarYIuVi7uuvCkZEcHFA3LNNLU/SL5inCCbKdaHcvZs5FuaZcwyDSDPwV/S2EBSn+aTLSvpsicF0/W0K3msy7dj6Fktl7153Yo3T5n6rSHje4wPF0XPRtXzflWh7TFI9Efz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0ND5eKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD0C433F1;
	Fri,  2 Feb 2024 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706870741;
	bh=hMlT+02qZo3h68LxyJIVLv2jA0reVr/0LdCJMMpMQws=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=g0ND5eKyoeUCL4Zow/tg6k1k3/rj74cPXAa1Do+CgYzgeios52dhC+h6l0NWxZPxp
	 MoD+TZ6kwiYQvacc/RgaxILcVaYFEDfPu+phujkXFmjiW/UrYAYq6R6OL3NykEh5bL
	 b/IOHEujhJJDMBlCcZ/eswyPGXah+l9JvMLOhTYnbHO5NgObj1JqBbOgCBlq+NIzQR
	 5eKTpZbq2MTWlvC0BGFybwDgiDMzvn5Fuyvnoc43p4lYThHJPwnAmSrvJhGqz9hLYi
	 0vwwqjcCCNrzurNLCZNNTdugN358+5T7Nvu5PijTh7L4goGdhKCMQCFqS32C9MnLE6
	 w7LahMRkeVznw==
From: Kalle Valo <kvalo@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: ath11k@lists.infradead.org,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
	<878r4lg3t8.fsf@kernel.org> <87jzo13jmf.fsf@kernel.org>
	<94150b26-bdd9-49c2-82a1-26ff46c9d32a@leemhuis.info>
	<87fryp3he0.fsf@kernel.org>
	<0253854a-e5f9-4316-bec3-61aaf3ebfd1a@leemhuis.info>
	<871qa0xtk6.fsf@kernel.org>
	<ccbb3aeb-daa1-49ba-b729-964bd97748bc@leemhuis.info>
Date: Fri, 02 Feb 2024 12:45:37 +0200
In-Reply-To: <ccbb3aeb-daa1-49ba-b729-964bd97748bc@leemhuis.info> (Thorsten
	Leemhuis's message of "Fri, 2 Feb 2024 09:14:55 +0100")
Message-ID: <87r0hvta9a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <regressions@leemhuis.info> writes:

>> So, in the new interface, how should I handle a situation that a
>> regression is first reported on the mailing list, added to regzbot and
>> later there's also a bug report opened for the issue?
>
> You will have to options: reply to the first report with a "#regzbot
> duplicate https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542"
> or add a comment to the bugzilla ticket pointing to a report already
> tracked by regzbot, e.g. "#regzbot duplicate
> https://lore.kernel.org/not_relevant/msgid-423423423423423423/"

Oh, regzbot also follows bugzilla comments? Didn't know that, very nice.

One more question, I promise it's the last one :) When using the Closes
tag in patches does it matter which URL is used, either the original or
the duplicate? For example, do these both tags close the issue:

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=325423423423542
Closes: https://lore.kernel.org/not_relevant/msgid-423423423423423423/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

