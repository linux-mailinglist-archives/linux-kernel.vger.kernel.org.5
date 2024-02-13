Return-Path: <linux-kernel+bounces-63368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B317852E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5580B2558A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669C250F4;
	Tue, 13 Feb 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKIcI7e8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1322625;
	Tue, 13 Feb 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821078; cv=none; b=gfD7mNzYC8fIEBYb0DetJqdxNgFdhvZYCjPqTfjomUgiFuRwciSo0Q53geNuJ/pd+aIidQzR4GpW92a8XuIGuFYuOG3itU4+jUMlA+dIyqD+EzxwW2V0j4tLDHVo0mNmV+qpScZcqa4lduwI0w6X0xesnnnyfoFF3bjCB0bwO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821078; c=relaxed/simple;
	bh=DZLXr7sorwE8AqL56wu59XKC71pXIzKxx9FPaPR8HSs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pw26mjMgYDsl1eIT9K21rLiQ6iI25ArsWAoXfnNcDtGlOzyxdq+HlK4Ce01hqE/OOmEnoN7SlnAxfYjlVNxAmPaf4FPLr4NXNqpLMvl5B8SQtcsfTYpDxE1oQpJEhuwnDHTUh4Isu3DPeIUYsKE7+WlKLilDhrscbqffaohLivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKIcI7e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BC6C433F1;
	Tue, 13 Feb 2024 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707821078;
	bh=DZLXr7sorwE8AqL56wu59XKC71pXIzKxx9FPaPR8HSs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XKIcI7e8EmEfyhvkhPy4aHdK1fwypptkv88HdyKF6AKrZLuh3QV1lu4i0Sc/qDvqC
	 pAsdKkWLbr2ITFGIczHCCMqYnxsLIYurVSQeXvfTJiy6z08P0EWeR8bJNYbvXjTxYS
	 08r/D5yAfq5a9wncn4MXXZRaJ7ME+7nKIziA/tg3/At4xd9LcrBePUTuc4uNK0Llsn
	 sdKkAtYcR4iY+VFZ381gnzRHnxPZ2orEYFMJh4TuoQchflUAiPTqdLeE4IngADfoEC
	 +0BqekiHvP7L7ExyY4ogRt3RIjeHN0Wg9l/mqExy8B8pZnl4lUpXUKtThv4Xqtcrqg
	 Pt0A/SO95AFFg==
Date: Tue, 13 Feb 2024 11:44:38 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: unused struct members cleanup
In-Reply-To: <20240201115320.684-1-jirislaby@kernel.org>
Message-ID: <nycvar.YFH.7.76.2402131144190.21798@cbobk.fhfr.pm>
References: <20240201115320.684-1-jirislaby@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 1 Feb 2024, Jiri Slaby (SUSE) wrote:

> Hi,
> 
> the patches deal with unused members of structures as found by
> clang-struct.
> 
> Sometimes even whole structures are removed.

Good stuff, thanks. Applied to hid.git#for-6.9/unused-struct-removal.

-- 
Jiri Kosina
SUSE Labs


