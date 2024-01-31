Return-Path: <linux-kernel+bounces-46612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAB8441FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815CC1C21A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106183CC0;
	Wed, 31 Jan 2024 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km9NPWGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7383CA6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711945; cv=none; b=s+cKRKFQ+ybr6iqSMYGfgNqq+A2ZfA9I1OKl0N8R1ylnKra/InZF/S9/sBNV1mbHF2NPet0zuqVnx7JAohaodfNIhUX3XHhmZG84JLcB1j0U044y2onYcxslcx7FYxf2kgaIDeMcBa8cxCh5ue6NZ0hN0Vhh32bQKD/yREHTVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711945; c=relaxed/simple;
	bh=IFUWShPBA+aoz+kyGKyOGFJSwIc+vqjvZgQ2cu7Ce6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+4yvKECuoJDtNDF+d9kqDV63dOz5EAfYWB2HxdvhgH1uAeknCTlxbzcMt2PPWbyHuQHKH9qyWpiHl8h50Klw+baX8YuJTB9aZgtW5UfI+F9WRY/Q1HxvifC+kyZ/AFy3F0yfoi014SFbW1JsH2LdtNozUte1+/t4MlogxH3asU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km9NPWGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C223C433C7;
	Wed, 31 Jan 2024 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711944;
	bh=IFUWShPBA+aoz+kyGKyOGFJSwIc+vqjvZgQ2cu7Ce6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=km9NPWGDUYDytisHiwr1MjgrvdxQ5nEpdBOqx5vHLx+ADgAz4SW3bBc/ZOh5P8TR2
	 eyWqjXs2iyRCCuRmcvzAoqihqjk3M68mnmWZMyVuZjWuzh+Ab1WYXM8fRfn5ZuZKaA
	 k5dwF91w062jQudABkFntFXwoVAebsxOM5oKgBLUIcpOoiuHgJxHzDhDCdGbDR9zA2
	 rVDMDMMw43X5sHx64f/FHN6VGBqAie8LW+zACSrSQ+kWeeoij5tDhSgaLEMfyuKsiB
	 +wMKU6CmPee8BtQqaHSC+yRP8ik/ixAST6VVJ7QH9oxEnR8ZIs5A1pzYZrc0xWdL4s
	 v/NiHlRkT2paw==
Date: Wed, 31 Jan 2024 15:39:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131-engel-entern-9b5c96659948@brauner>
References: <20240131132541.GA23632@redhat.com>
 <20240131141204.GA24130@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131141204.GA24130@redhat.com>

On Wed, Jan 31, 2024 at 03:12:04PM +0100, Oleg Nesterov wrote:
> Before I forget this...
> 
> After this patch we can easily add another feature, pidfd_poll()
> can add, say, POLLHUP to poll_flags if the pid is "dead".
> 
> So the user can do
> 
> 	poll(pidfd, { .revents = POLLHUP });
> 
> and it will block until release_task() is called and this pid is
> no longer in use (pid_task() == NULL).
> 
> Do you think this can be useful?

Yeah, I think this is something that people would find useful. IIUC, it
would essentially allow them to do things like wait until a task has
been waited upon which for service managers is very useful information.

---

Btw, bigger picture for a second. You probably haven't kept track of
this but the fact that we got pidfds - thanks a lot to your review and
help - has made quite a huge difference in userspace. Since we last did
any meaningful work we got:

* systemd completely relying on pidfds to manage services to guard
  against any pid races.
* Extended dbus to allow authentication via pidfds.
* Extended policy kit to enable secure authentication of processes via pidfds.
* Language support for pidfds: Go, Rust etc.
* An endless number of tools that added support for them.
* glibc support for pidfd apis.

There's a bunch more. That literally obliterated whole bug classes.

I think with PIDFD_THREAD support it might make it interesting to use it
for some pthread management as well.

