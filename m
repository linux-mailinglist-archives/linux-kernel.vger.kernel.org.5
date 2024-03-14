Return-Path: <linux-kernel+bounces-103667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE987C2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1BC1F2209A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27474C0F;
	Thu, 14 Mar 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SFJsvWAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1874BFA;
	Thu, 14 Mar 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440912; cv=none; b=mZ4BAwaWAjbPWaRcdaZgCINyH42JBpIqASiywkx+gZ/bTQoh6xf6Aapc8FLwaEJ65FYiVGsdqoTJ49D8LDP76E77jUFDkZu9/DbsHvUinbtd8P1flEX70o8RVf3Ih/5FFOoc8TL60LYl+9+83M0PrBFBjVtmmyT28B66Otq/Y+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440912; c=relaxed/simple;
	bh=AFztmRQ7od/p16ks6Y4lRSBnAMBr/FxYYEhI7aUOTwU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M1fPpjxGps5Ss1Zwy34E5P0WZmp8tkLbweKvJHnGMckro9uJIWEmgqAadngT8echOkCVBAJfpSB8IxsiMpzdAqFrRxfFyv+7KaOvVyrVoNcQ/EuupepyC8fyTcWgJem8/bzgWh49fBLOpLr3BrBKozPdUYCrRuW0on4IJzrH2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SFJsvWAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E117C433C7;
	Thu, 14 Mar 2024 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710440911;
	bh=AFztmRQ7od/p16ks6Y4lRSBnAMBr/FxYYEhI7aUOTwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFJsvWAKQCtaSc907suY5pXQrbS9T//BJF64zLAbsd7OiYiE7ATJaRMjr/npHf+wR
	 IF9QHkRLJPzygSc9CaWzlmoe4NKt1Iu7KT8nv6dIHU15LtZGmFXx/E0EcQJp0H4K86
	 sCb7t9gKdh1bNkER8CmjHBTZbPaD18XlSs73q0Lc=
Date: Thu, 14 Mar 2024 11:28:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Cong Liu <liucong2@kylinos.cn>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/Makefile: Remove cgroup target
Message-Id: <20240314112830.29807b1fe2905929b00ca39c@linux-foundation.org>
In-Reply-To: <20240314122533.419754-1-liucong2@kylinos.cn>
References: <20240314122533.419754-1-liucong2@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 20:25:32 +0800 Cong Liu <liucong2@kylinos.cn> wrote:

> The tools/cgroup directory no longer contains a Makefile.  This patch
> updates the top-level tools/Makefile to remove references to building
> and installing cgroup components. This change reflects the current
> structure of the tools directory and fixes the build failure when
> building tools in the top-level directory.

Please provide a copy of the error messages for the changelog?

I think it's this?

hp2:/usr/src/25/tools> make cgroup
  DESCEND cgroup
make[1]: *** No targets specified and no makefile found.  Stop.
make: *** [Makefile:73: cgroup] Error 2



