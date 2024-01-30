Return-Path: <linux-kernel+bounces-44742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235028426CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5698A1C25DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE66F085;
	Tue, 30 Jan 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bUiPb6WF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBC6E2AA;
	Tue, 30 Jan 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624538; cv=none; b=ZvEzhtSeLYB7f//ZwbPX8u01SL8HZOSDdj/iKx87FKI7RNW1otoqhxNoPkO24elZPlaWUmSReitC1G8lwV0ilwhPNnJvfCKscCVx+VG0PjLf4rsnuCRQJN1OVp+NOTPN5VoxQoBgChf3YZ6yzimEIhlSq+tcB85bHIyanTOdJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624538; c=relaxed/simple;
	bh=kFWxblNSjHD+cbzRAEcBA2MhN+GXikvkOgx5Epvujdc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLZhq6Z+9V0Nhum5Wt8FK54n1uhSp5NACxJGV7CbDPU//8CFWFfZw4u87XcIx5bLoTl4+3iMB/6o9JO9gThN+0ufNVuZglEnjkVFIMh4wCoGHpjFjPZWBS1z0LqRThZdTbq950abwpl9Qm4LE5AFvJFFUQg0ZwixJ7yxmBk3Y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bUiPb6WF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8C58E47AA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706624529; bh=LRJd8PXbeyglrfd0aYEb8xott5XUDLLLBejxVX91ujI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bUiPb6WFkF+jj18AUbYpvNSHoLPwgJ5iw3M6uKAKA9ZzTbkFs+tLl4SHbRizrNo6Y
	 B6nrxy2R8Jh9S0UhqVm/cXODSvf6g5N2AZBfv8WPKfgwR4QHP6XHtBGzOR9EJgO+ca
	 8vqetC3JjOQm0rsf0qhPAA+j7W5KH9J0DMq6NwU/f2brynxv8r1xMtib9O8sQnN1Kq
	 EIONzTR/BSIHtH3xDaZJTarfzaa3lQHXe1SaU6k+r009+s553geLu4IxjErriGBNNG
	 Pm012VaQfb/9enJTcU71Z4F6E6ppaE3Te2DykGbt5uF79gYwyoKVK1lHtn2bGN7UiQ
	 Cr8RkE33tn/Zw==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8C58E47AA5;
	Tue, 30 Jan 2024 14:22:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Breno Leitao
 <leitao@debian.org>, kuba@kernel.org, "David
 S. Miller" <davem@davemloft.net>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
In-Reply-To: <874jevjgvo.fsf@intel.com>
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com>
Date: Tue, 30 Jan 2024 07:22:08 -0700
Message-ID: <87jznqewa7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
>> This is a simple script that parses the Netlink YAML spec files
>> (Documentation/netlink/specs/), and generates RST files to be rendered
>> in the Network -> Netlink Specification documentation page.
>
> First of all, my boilerplate complaint: All extra processing for Sphinx
> should really be done using Sphinx extensions instead of adding Makefile
> hacks. I don't think it's sustainable to keep adding this stuff. We
> chose Sphinx because it is extensible, and to avoid the Rube Goldberg
> machine that the previous documentation build system was.

So I feel like we've (me included) have kind of sent Breno around in
circles on this one.  This *was* implemented as an extension once:

  https://lore.kernel.org/netdev/20231103135622.250314-1-leitao@debian.org/

At that time it seemed too complex, and I thought that an external
script would lead to a simpler implementation overall.  Perhaps I was
wrong.

I worry that a proliferation of extensions adds its own sort of
complexity and hazards - look at the things Vegard has fixed recently,
for example.  Relatively few people can work in that environment, and
extensions can make our version-support troubles worse.  So I'm not
fully sold on the idea that everything should be an extension,
especially if it can be expressed as a simple dependency and build step
in the makefile.

Some of the uglier makefile stuff we have is a different story...

Anyway, I apologize for my role in making this particular addition
harder than it needed to be.  Perhaps, for the future, we should put
together and agree on a document (of all things) on how we think this
sort of functionality should be added.

Thanks,

jon

