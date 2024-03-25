Return-Path: <linux-kernel+bounces-117348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01588B064
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54241BC417F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947F1292FD;
	Mon, 25 Mar 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scn099pF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB409128379;
	Mon, 25 Mar 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379806; cv=none; b=G6zTMB/KT3Y1D7cVB5P9Q9/X/6eBgYfnnepYqfc6yVK3EqKZV1pQPOWn8bUykzk6svEC2kuiLf8Gj+bEPQoUxDEjP6XlDC0Bctg7S09heLiI5WgNUUSq9yh+Q5Pt/lKWdJ/nBBGvtFua0GG7cYG2iPtF/G8oKj9QGuDqnCJ2m88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379806; c=relaxed/simple;
	bh=eLGAZ/vRoljcypq3yTVbQoX8hEGDIM6eWX2TQMhK5rU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ivmig57t+GQlOlRIDhSct2Ag+DQTlSNZqnKa0EwWL2bgriGUqluT/8spt1aHlhIwHRvw6MHX7Go1K1NhsbAOlKsckfD2p2xf2kg8l4gKRoYsX7KJj72UuAJesnU9ArqmggOiiLeyIV8MPxbkEZbEBINUYPzFZBEOgr7RAZA/DYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scn099pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586ABC433F1;
	Mon, 25 Mar 2024 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711379806;
	bh=eLGAZ/vRoljcypq3yTVbQoX8hEGDIM6eWX2TQMhK5rU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=scn099pFRMZqUI45wqAnYd+1n0uina0bGoJVu+dWqPzVLGWhrSL7aUIPERdtMS3Fy
	 JEYWOim+KjvH0S5mGtCe1i5ne5HJxl8SSBit8B3Ji8BJ7ZRUF/BDq5z3fI0iEBCdKM
	 RHf2IAhIxHqMzXAvQCD3EwNclfzr3CsENBU+dqqnli+2MN4Xbk6/SqQUmz8NK95Mm7
	 FPsxUCQu6f1kG6SRrGnXWG5JaWl6KQzCds4Y9gj2WPuoZ13qcL2toqboP7stGhoDxT
	 O0LiMMwc1LmNTsAyARNZLJJC7FFK45BYIia4oz9nWQnNC5wIW5eARYk+XXy2dHmNeW
	 KpDsbCB/rDxYA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] wifi: nl80211: fix nl80211 UAPI kernel-doc
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
	<638df3bb659caef38480aa97277207b89c101344.camel@sipsolutions.net>
	<2a2d2001-f87e-49be-8f5f-fcd175c4911a@quicinc.com>
Date: Mon, 25 Mar 2024 17:16:43 +0200
In-Reply-To: <2a2d2001-f87e-49be-8f5f-fcd175c4911a@quicinc.com> (Jeff
	Johnson's message of "Wed, 20 Mar 2024 10:16:11 -0700")
Message-ID: <87h6gu1gv8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/20/2024 12:07 AM, Johannes Berg wrote:
>> On Tue, 2024-03-19 at 11:26 -0700, Jeff Johnson wrote:
>>> As part of my review of patches coming from the Qualcomm Innovation
>>> Center I check to make sure that no checkpatch or kernel-doc issues
>>> are introduced. An upcoming patch will propose a modification to
>>> include/uapi/linux/nl80211.h. My review process flagged both
>>> checkpatch and kernel-doc issues in the file, but these are
>>> pre-existing issues. So this series fixes those pre-existing issues.
>>>
>> 
>> Thanks Jeff.
>> 
>> Can you say what you're running for this? I've been running kernel-doc
>> and builds with W=1 for a long time, and not seen issues. Is this
>> perhaps checks from a newer kernel (we're currently on 6.8-rc1 for
>> $reasons)?
>
> files=$(git diff --name-only $base HEAD)
> scripts/kernel-doc -Werror -none $files
> scripts/checkpatch.pl --file $files

Thanks. So my plan is to run this in my check script:

scripts/kernel-doc -none \
include/linux/ieee80211.h \
include/net/cfg80211.h \
include/net/ieee80211_radiotap.h \
include/net/iw_handler.h \
include/net/wext.h \
include/uapi/linux/nl80211.h \
include/uapi/linux/wireless.h \
include/net/mac80211.h \
include/linux/rfkill.h \
include/uapi/linux/rfkill.h

Did I miss anything important?

Although include/linux/rfkill.h has three warnings:

include/linux/rfkill.h:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * rfkill_pause_polling(struct rfkill *rfkill)
include/linux/rfkill.h:114: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * rfkill_resume_polling(struct rfkill *rfkill)
include/linux/rfkill.h:331: warning: Function parameter or struct member 'rfkill' not described in 'rfkill_get_led_trigger_name'

Any volunteers to fix those? :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

