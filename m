Return-Path: <linux-kernel+bounces-27651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181382F3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0FDB21A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA001CD21;
	Tue, 16 Jan 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPTjWh1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52B1CD10;
	Tue, 16 Jan 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428550; cv=none; b=smc3WvGZ1ryyXpHn2CZn53iG6K9TR4DLSVRiU8zt/LM8FFtauP7qjxqGN0OGlGXp4tVJbr7Qk4YpLfF6OklU6KGTOZJ4q8sJi+hHmqyW4yYzMbTuHrK0l0MhhvNNGzzpmmVqJqGA4cDyiN9MfMVIwtRZC3w4u6nhISy5s3pOWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428550; c=relaxed/simple;
	bh=vV2jSlemMat2lHL8Yo8HaO+PLuu7AWQw4Hts6yb7Bxk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=mhZ9VnWFSqpfVy3wLpaTaqreNnFuQFg6Fulnq9JysGpqhs5zQ869+EX229mdJaEzCbxFm6iBGl6A2EvAuoSfq+54VfOZCoL5gxHcsz9PHiE9ZS2xUHGeK4shhhLKfL/70O7utrBZBmTXMRuFnG8DJU491dc92oDhFX3tdo2M8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPTjWh1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C849CC433F1;
	Tue, 16 Jan 2024 18:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705428549;
	bh=vV2jSlemMat2lHL8Yo8HaO+PLuu7AWQw4Hts6yb7Bxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPTjWh1El1cxn3/PpxNHOjXJlNcygtnECRnJ5UnJG70EdamqrJEjTCmSwf/ntp0zL
	 x8FQi5/nChYomRn5u/18iD6qm5hQudlTvE4omem/XeR3lTuVAxyXSQ5Wfr7IGS6r37
	 L9SNJHNEwvFo06PxVwtrgPHn7kNsaSNbNSWq5WM1kyUtYtuWgbsA5OJMDDag9QGVgG
	 t29WmXz3n9tdvbrbRwk1AmbyWcdifRWPv4Otqx8Kbg3wAfu+StRPqK66EIVWW22PKg
	 k8eMnwDD77DDLWmW6BGpKaSKZJf5Z9WL6wxd7m3W1tfA8ADFIeONiqxwzhNGKJMJ28
	 qOYK1yBiJzi/w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Tue, 16 Jan 2024 10:09:07 -0800
Message-Id: <20240116180907.52488-1-sj@kernel.org>
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

Hello,

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

I again forgot to join today, sorry.  I will try to add more alarms.  Let's
have an alternative one on same time of next week (2024-01-23 09:30 PT).  I
also updated the Google doc.


Thanks,
SJ

[...]

