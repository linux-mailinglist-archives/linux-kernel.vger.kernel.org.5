Return-Path: <linux-kernel+bounces-24809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785B82C2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2724F1C20CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32E7316A;
	Fri, 12 Jan 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAO6cpxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5aamk+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E673167
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705073688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHCaHdQEpsoW35AeZrEcwPi0ztqixhaYEeFeHDo7O2w=;
	b=zAO6cpxhadAkDesCD7NwIJxReT9I8qNmLC53lSlV7IyBxHKWGsYGEOi1/PUucnwf9aOeYV
	OZzbQsjTDXI0It9XNhRhq46mlngkboXV/TAdVti9hSXnwLXFf0dp2iG6TELRS+oI58U/v5
	yGUA1y5faJvgbEmSIkEriOP+Il8l2lDCM35LkezJFi8x4KIUuDAoLiz0rFrZrMUP4SzgdF
	Uy+YplrM3j96pTsnKI5IMHlb0FROED0Tb2I5BET5Ac3DDW96MjISMbhglSbHfzDck0RRZC
	TDiO6NIQjLzmcngZPzxYEFVB7+8l/NNKKrJa/WgfOOQdhh34J4NDXxz43jcfyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705073688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHCaHdQEpsoW35AeZrEcwPi0ztqixhaYEeFeHDo7O2w=;
	b=e5aamk+UPISoSdWaFSmcDnlJ+v6uYBFMIaQMM5beJea4B18GNmMe3dlLPDAyTV1pk6z3N8
	VIkwOfjF+SDSfOAg==
To: Yu Liao <liaoyu15@huawei.com>, linux-kernel@vger.kernel.org
Cc: liwei391@huawei.com, wangxiongfeng2@huawei.com, frederic@kernel.org,
 mingo@kernel.org
Subject: Re: [PATCH] tick/broadcast-hrtimer: Prevent the timer device on
 broadcast duty CPU from being disabled
In-Reply-To: <44fa61a6-9ceb-0ebb-141f-0e2e703db47d@huawei.com>
References: <20231218025844.55675-1-liaoyu15@huawei.com>
 <44fa61a6-9ceb-0ebb-141f-0e2e703db47d@huawei.com>
Date: Fri, 12 Jan 2024 16:34:48 +0100
Message-ID: <87h6jiimzr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 12 2024 at 15:40, Yu Liao wrote:
> Hi Thomas,
>
> Kindly ping..

It's in my backlog ...

