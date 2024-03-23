Return-Path: <linux-kernel+bounces-112501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECE887A96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353661C20C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E135B200;
	Sat, 23 Mar 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mdwqG+3F"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF12940B;
	Sat, 23 Mar 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711232344; cv=none; b=uQZvDG6eaurfG4o0zUyyJv/6jkonXz47mrNFHYIvtykpQt3E8eXPYdE1kMx+XXhEqS/SP8GIHsQJ7g/5Y2daDEy0iDJlkfn7F2wsq/dqt4MRqYA04jPFZQ8EFkX8QEfG/HWebp6LxeaDEz7520Zfm5ViX1qQ7hzhAd29w5VUvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711232344; c=relaxed/simple;
	bh=zOnHMRE7LGC7fcqhOYhsQ1fSZQPVh1+EyyF1vqCgLrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLb0YGwuqBJcs1R9t8Jpb9YZwxquWtUS3PvYI64JQJ/T5cWWIAnrr9XCW5K1eCtMi3W+pqhe82lZ+DxMPFSZfqfUjVcVj2iPYthnRwsYzmyRsDpnwYVIoDW0RFIKfu1Hp4SdhILKxC+PvAJqY/1YGtpV4mv3CkDfavl5WWJC1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mdwqG+3F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F33wnbx3Y36tdDg+lawZFiW4Fv7MKDor5UODN7GSPC8=; b=mdwqG+3FksuYxx7/e8MH3Wp5bU
	4QoFdM3A/3u16qenQEZuOh35DPyFmWVNmeYw3kPwA7ZpH3e+kaRugfnzAmcr1fvQds7NQA4u6nSk+
	rCbjDcrwOptaGm/CITDxSLalhNdDLB7TXz5MXlwt71jxo9rfjT+KeWStdOnagboJIML8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ro9hQ-00B4Rx-HJ; Sat, 23 Mar 2024 23:18:48 +0100
Date: Sat, 23 Mar 2024 23:18:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: ast@kernel.org, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, daniel@iogearbox.net,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Message-ID: <a9662071-8050-46b7-8416-d440d45bbb52@lunn.ch>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
 <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>

On Fri, Mar 22, 2024 at 10:08:14AM -0400, Daniel Hodges wrote:
> This patch adds a led trigger that interfaces with the bpf subsystem. It
> allows for BPF programs to control LED activity through calling bpf
> kfuncs. This functionality is useful in giving users a physical
> indication that a BPF program has performed an operation such as
> handling a packet or probe point.

Don't you want a mechanism to say which LED it should blink? Say you
have a BPF IR receiver, a BPF kernel scheduler and a BPF firewall. All
sharing the same LED is probably not what you want. Each probably
wants its own LED.

      Andrew

