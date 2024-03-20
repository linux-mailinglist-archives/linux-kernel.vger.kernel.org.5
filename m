Return-Path: <linux-kernel+bounces-108686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FED880E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F71C20F72
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929073A1DC;
	Wed, 20 Mar 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkevE2d6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676B381AC;
	Wed, 20 Mar 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926287; cv=none; b=AbR4U38Ty/8AnBjLnkPKetb7V1dSau1jfuK2p3uiAYAxIR6DUTFwY3fDGO6UXPURg0RlVbJG6ccIoBBVtD2r9wB19vD6IUO+MIts/lkWeA/n3crhFtJlRdkCy1p8S383GPi138QvJF3Zpc3UgSfKMJlYBihpU7/oSVAUw1af17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926287; c=relaxed/simple;
	bh=Ua8bP3Zu3ZhRW6pVJ78wmG35ErXgM57J4eb+99Iw6mA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bTcrSmoKkbUud8Ca4L8I/4i4IMjFvzRmA+cfq6F78auT+VBqtAkpKMk0qZStA6K7+PExVIoDQAspw2X7J8x5TyAOkPTJ9DivIZ19sEye/DNCZAz3eKxjxZ1eeZxvNYcnaN4rIdpVYtmyVKeqQKud8Pqo5k7M7HSxLiwp8R0KSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkevE2d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77245C43390;
	Wed, 20 Mar 2024 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710926287;
	bh=Ua8bP3Zu3ZhRW6pVJ78wmG35ErXgM57J4eb+99Iw6mA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jkevE2d6SbeVSO/R0fC5L31xs+xPC3WUdEkV30i0Fl539olOogAPNKm7RcNmkKevs
	 3kNv696eUzFfE7LP2gTDGorQB7/Cg8AWAbGhrle0guRq5l3WJZoGhw1FgNBmIRpVHB
	 a06cs4qh4IKRsSPQ5r6ufG9j1qlA7c8zdINkLNAi9PFvhyKPXLAo4fPeArTBOitQCu
	 ca1lYGADpExR1ppTnyYvldQb3rl7P20KPjJmYWam/9nTHwvhZCgRztJig2o3SIexcC
	 VdPEHY0v3MbryAmX6d36sXmCkkWxLqOZOWwewU1V426yN+sm8k2A6DENAs12NP/v8t
	 PpoH0RaF0lmaw==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: nl80211: fix nl80211 UAPI kernel-doc
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
	<638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
Date: Wed, 20 Mar 2024 11:18:04 +0200
In-Reply-To: <638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 20 Mar 2024 08:07:00 +0100")
Message-ID: <87cyrp2reb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2024-03-19 at 11:26 -0700, Jeff Johnson wrote:
>> As part of my review of patches coming from the Qualcomm Innovation
>> Center I check to make sure that no checkpatch or kernel-doc issues
>> are introduced. An upcoming patch will propose a modification to
>> include/uapi/linux/nl80211.h. My review process flagged both
>> checkpatch and kernel-doc issues in the file, but these are
>> pre-existing issues. So this series fixes those pre-existing issues.
>> 
>
> Thanks Jeff.
>
> Can you say what you're running for this? I've been running kernel-doc
> and builds with W=1 for a long time, and not seen issues. Is this
> perhaps checks from a newer kernel (we're currently on 6.8-rc1 for
> $reasons)?

FWIW I also check for kernel-doc warnings every time I push to wireless
or wireless-next and I don't see anything, so it's not kernel version
related. I think I'll add the Jeff's tests to my scripts, once he
provides them, so that we can catch these early.

Of course it would be even better to have patchwork tests for stuff like
this. Here's hoping we eventually implement those :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

