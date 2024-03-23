Return-Path: <linux-kernel+bounces-112503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53780887A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A61C20AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA5A5B5DD;
	Sat, 23 Mar 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZpKczV2m"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218A5A4C6;
	Sat, 23 Mar 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711232751; cv=none; b=Z/9fQz7f1YL4Fryb3iZ+j81GJD3PJMMkk9H/MAHLy6GbzBmFEEhUj+ypK2q7qpyQmKk0qcpYJ/H0Ld1osI5j2pWDd0s7pwX2g2ZUgCH5DW9Y5fd4ZexBb44Cyj8k/s9PfcXyxM4qxwrK8rO861oqDmwYtQHmIri4f+dUGHMZFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711232751; c=relaxed/simple;
	bh=5ywmwSOANCwvmN60cHoKWbVHRtpgvPfzhKz4OyO0kz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOXh9VGQkQg+lz0wR5OSs7UmkAHfc2HOq7rUKczlCsCMzC/vL5E5rT8oNze0sL3d5wd+hipaZ3sOPol/6oylAmPadERRxF/b173/AfTKHhQ5XXmzxRB7eAXXlldKjS6qGU53uL8S2nCr6WLX3H8TPk/EU6FDUw7fMIsHmTA3uS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZpKczV2m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S9qKN3rr+FvnUj2R5c4tNQZmaB108poPnd4hRyAjl10=; b=ZpKczV2m/VB39yMBjAqTJcrUvJ
	C56/29nH+DoG/tTV3FC8bWOVOeyUX+kI4rwjp8g5+NdBf1nBBBqW/0YwHa00OrHiuoPwGXLbuMXkH
	NWlhxQandRmtoRS1b5E8Y7ej+fW+h6aK0DFiAlGtd7MYvWUXYt+PKkXPqiOFpMU79M9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ro9o6-00B4TF-7t; Sat, 23 Mar 2024 23:25:42 +0100
Date: Sat, 23 Mar 2024 23:25:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Message-ID: <ceeefde3-68a6-4fc9-87a0-401206037855@lunn.ch>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
 <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
 <CAADnVQ+BsBcp5osqiG46gjtLViQjHStVnPsySffHsybaz7OYEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+BsBcp5osqiG46gjtLViQjHStVnPsySffHsybaz7OYEw@mail.gmail.com>

> A new kernel module just to call this helper?
> Feels like overkill. Can it be a part of generic led bits?
> btw, have you looked at net/netfilter/xt_LED.c ?
> netfilter had the ability to blink led for a long time.
> I'm curious whether folks found it useful.

This might become more useful now that we have support for PHY & MAC
LEDs. You can use the netdev trigger for the usual things an RJ45 LED
shows: link, rx/tx activity, link speed etc. But they are just Linux
LEDs, you can also use them for heartbeat, disc IO, tty IO, or xt_LED.
xt_LED would actually make sense for an LED in a RJ45 socket.

       Andrew

