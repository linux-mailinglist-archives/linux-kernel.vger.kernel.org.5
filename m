Return-Path: <linux-kernel+bounces-137682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0CB89E5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEDD1F22A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE4158DBD;
	Tue,  9 Apr 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRYkmkzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CE158D9C;
	Tue,  9 Apr 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703913; cv=none; b=uAHKNR9+Ta99QhvtFZBgW0pwG6iQB5FcPx0y8HrKxFiO/MPEnfMTvlUgXFN51uyxW3j/hl2zgPXy4+2TGsj6Ez/KPEaqG5eHBRCjTWnwAy1zrS0XtP6BoqTiE3QyhS9htaY5Mu87kCltT6WZ9kIXrH15YG1ppb6hTMd22e92eEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703913; c=relaxed/simple;
	bh=JpiDdYF+w6gmwqQJ37NKkF9DXGvg/Cm8SjNiCArVRFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqz5gai/l4Zd9ZbC+/bEQxxjcX2kL6rImaf/w6VLdJy9StQKg7wxQppDFxR2j5WCHD3wDaIeEWoHFY2Ujo/qK/Z7UVn1ohRtEEOvhgLQVmRjkKVCdicwUA9YrW6r/8wGt9AxuMLFqA+iNMR+b6lzPbPc6dH0yJIdQ92PVKoVHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRYkmkzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE3C433C7;
	Tue,  9 Apr 2024 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712703913;
	bh=JpiDdYF+w6gmwqQJ37NKkF9DXGvg/Cm8SjNiCArVRFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRYkmkzu0SpZIT3Cmp7T6WKaPrI47XIfmURZ7LbmhFv8BUzR+Tt/au4Kwder3xPBB
	 wWCins93lPAjUPblcvKZdc41f+Uk2omSqvNFLJKI4HoPFnu/fqiifxfYLPuP48DFKN
	 sY93h3H4HoMBwYH0ZfjhsnAfCCLDg1gEhCBiJ0VGuOhEYfK3dqlUZ93ygd91eg9xjJ
	 +9bpNRvmzzn5QefWTZqY/q1PQCnagkWEnUxrbyW9KoLsAYsV/ErCxLUhoN4I5suWnQ
	 JEOd/jxNakMq5zIkLtAWNMdgViQ8d/9qxLBk6AlF47nYIYruxTe7v/tu/7RSgRro/0
	 NRh1vru6unBhA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue,  9 Apr 2024 16:05:10 -0700
Message-Id: <20240409230510.74265-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello community,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

If you tried to join today's meeting and if you were unable to join, it's all
my fault.  Sorry, I again missed my alarm.

I was about to schedule another meeting instance for this on next Tuesday, but
I realized that it will conflict with OpenSource Summit NA
(https://events.linuxfoundation.org/open-source-summit-north-america/).

So let's have yet another meeting on a week after that.  That is, 2024-04-23
Tuesday, 09:30 PT.  My apology again for anyone who were unable to join the
meeting due to my fault, and looking forward to chat with you on the meeting.
I also updated the agenda doc
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing).

FYI, I will also attend the OSSummit next week in person, and DAMON will again
be presented there (https://sched.co/1aBOg).  Looking forward to meet you in
person if possible!


Thanks,
SJ

[...]

