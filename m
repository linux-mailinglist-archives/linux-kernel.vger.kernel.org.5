Return-Path: <linux-kernel+bounces-150744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636AB8AA403
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4258B22B24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671394503A;
	Thu, 18 Apr 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eLZRCfz8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D61836D5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472022; cv=none; b=Q1qw98CtsVpLs7kCpHejRkP/4gxVp9DKQwo8Md9nDoaB9Ckb18btUbdX2TMKqq6Jh4iHQ07lAG9A7meb+ZX5uYzu+YDdql5OwbY0XoTvG3rjWTrwlLa3kUI9e/epAzYVHZ6me1aZ+DnQNQmGPaV63fTOO4n0SITzm0nGgwN5dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472022; c=relaxed/simple;
	bh=i1nsXZNNVdGZQ+WI56DsLxzYTH3siYkc6S9FPhLunoY=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nYZL+olC78wf1MVcmTOwGXMqsFBPPhSMlnHVqU1AXV2viRVRhxB8YQ2NHX9hohXpVNtW2j9K6Al3QvsLR79ywdL61dVG/nzRZHd9WuyDfhX328lPxgq/xqdVLnjyzcJpWlIW7sZi3567zfO+9TA7HDQuKSjMLXwNyH2Fwk/LyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eLZRCfz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E663AC113CC;
	Thu, 18 Apr 2024 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713472022;
	bh=i1nsXZNNVdGZQ+WI56DsLxzYTH3siYkc6S9FPhLunoY=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=eLZRCfz8+fJerKMKCzuW7KnuRGE0I628GYja6TWa+iz0pbUCbcoFWht/iAP1nvz9Y
	 TgtRLobwNwoCC3pyfAVYUlcO+6m3c0Tw1Sg/yLWImitJygyrVmN6cCuKxQ4QTkFxxe
	 d1yPeoeqZ8Od8S5+wn+jXLaw6m7QUBD5JTliJ07A=
Date: Thu, 18 Apr 2024 13:27:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>, tglx@linutronix.de,
 peterz@infradead.org, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: memoise number of possible cpus
Message-Id: <20240418132701.ce6c769652b5c5f78f9cfd7b@linux-foundation.org>
In-Reply-To: <20240418132600.ffbf4d53b39eaaeaffc28198@linux-foundation.org>
References: <20240418041927.3903-1-adobriyan@gmail.com>
	<20240418132600.ffbf4d53b39eaaeaffc28198@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 13:26:00 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> reset_cpu_possible_mask() appears to have no callers.  Kill?

oh, you already did.

