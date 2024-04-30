Return-Path: <linux-kernel+bounces-163234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB548B6780
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29703284F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1479EF;
	Tue, 30 Apr 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNxDRsNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE41C33;
	Tue, 30 Apr 2024 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440992; cv=none; b=XFmv5cc2vYnSN18h6uf164bXMYFV0h62C5WR0bPFcS1g6mA2/JEBlI3+RFi7oRYHRz04FtVooJnxqnoeSru1LqRLLOUhUBGUTJa3fvPyfW9mAEI35eVwP9pHN0Lixb49pWoztJipUCuP6AO+K6rAQhpplSayu2lVZ7R558XhAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440992; c=relaxed/simple;
	bh=hLCqbm6aIHgWboKq7U6esLVQy2ezFjYgNfa+jq86Qms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb5Q+33yOGuM08DiujyVAQi7ioHFQpmoP82yR2TIbLgbJDHQb8QisNgHbOy8ui4OF7ot97RZX/qgdsLII1eaWsJGzKISZ+kBQL006ABIU52nA+Q+CiGv7sqKP3Gx7qCBcEAmgU8Hn0Auv7E7XVE/zXD9PDks9RK6toE0e2eC2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNxDRsNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCAAC116B1;
	Tue, 30 Apr 2024 01:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714440991;
	bh=hLCqbm6aIHgWboKq7U6esLVQy2ezFjYgNfa+jq86Qms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNxDRsNth4mCdKAE8SCUUduLz58XEHWRJ66Ejp3clOgJy6mzJ66rHye7Ww32vrueX
	 +Th/oK03WOn40YOaiCrz5qQB2Xw3qTO7I1VUl7wXc0yL+aZI1GssRgLA9/eTm19IWz
	 eR6yy9Y9gs6eWkBaAighK+dJYYYSi/wCgrQZTnehBOQAGhJKFocjdXw+qdICOgSiHH
	 frwN6LiFL//c27KEwY47qWEBUl4NUMx4e1dGm6NHxKV3h88yYl+b5UL34ZUgxhCRQx
	 UmHBalOoNLAiTWNa5yuzQ6BDN5c9kg2SKWs8eLzAAYhAOPDtG1WjsVIcHASP/2UIjB
	 jHDfQS1Xo0Tlw==
Date: Mon, 29 Apr 2024 18:36:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
 netpoll_send_skb+0x1fc/0x20c at boot when netconsole is enabled (kernel
 v6.9-rc5, v6.8.7, sungem, PowerMac G4 DP)
Message-ID: <20240429183630.399859e2@kernel.org>
In-Reply-To: <20240428125306.2c3080ef@legion>
References: <20240428125306.2c3080ef@legion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 12:53:06 +0200 Erhard Furtner wrote:
> With netconsole enabled I get this "WARNING: CPU: 1 PID: 1 at
> net/core/netpoll.c:370 netpoll_send_skb+0x1fc/0x20c" and "WARNING:
> CPU: 1 PID: 1 at kernel/locking/irqflag-debug.c:10
> warn_bogus_irq_restore+0x30/0x44" at boot on my PowerMac G4 DP.
> Happens more often than not (6-7 out of 10 times booting):

Could you try with LOCKDEP enabled?
I wonder if irqs_disabled() behaves differently than we expect.

