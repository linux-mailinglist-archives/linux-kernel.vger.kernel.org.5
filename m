Return-Path: <linux-kernel+bounces-26909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFAE82E7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E03284F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBFF1118A;
	Tue, 16 Jan 2024 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZlXKQLsh"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CD10A37
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Jan 2024 20:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705369571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r6/n0XiF/8/YjROtnAGW4lI9P3RjbqlOQAnxgBHRLTc=;
	b=ZlXKQLshjOj9RqbUmtlp+8VOGvS/N6fDqya5t0KpJazJL/CAWeAMKFzfCgm4qkFYTv7AJy
	GvrLXVCMEIDoPVlreB7aQWQbwS9Zd4T21z4jTCWupHHpx/CEX1zgARn2xL60ltIhEzMofC
	gItiwSCdpW/iKZoj2Vqh3/Il504zjic=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org, 
	arnd@arndb.de, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.15 05/11] arm64: Fix circular header dependency
Message-ID: <hevfrjvifsaglbjta3ut6og54wcy6bu2ymjab5wly3a7kawrn7@6ctlgbhpfhso>
References: <20240116010729.219219-1-sashal@kernel.org>
 <20240116010729.219219-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116010729.219219-5-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 15, 2024 at 08:07:05PM -0500, Sasha Levin wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [ Upstream commit 04bc786d663543512d08f1b86c7bcefb5144afe3 ]
> 
> Replace linux/percpu.h include with asm/percpu.h to avoid circular
> dependency.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch doesn't need to be backported, it's fixing an issue that
occurs with the memory allocation profiling patchset

