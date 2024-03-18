Return-Path: <linux-kernel+bounces-105888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13887E603
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23571F226F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498682D60B;
	Mon, 18 Mar 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aMb/fEyw"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2F2D051
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754756; cv=pass; b=RAphDROpB1k3bDpGqVFzcIyx8bdoyDQwxU/kjY8DgiT2HSOsV1XbQ2+xS5Y+YwbmzDhI6+Fkp3VMWF/DxLXwWXMs8Y8x+t1vFZ742a2kwNQHTzh/zVSCAoWgX8pgLu7htXE4ULvRGCpQkdSee391IFFQXgeSUHy1brvdmxNLFC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754756; c=relaxed/simple;
	bh=iHr6NL1I/HV8cH0Tt/67tAPuDHbHCy2Vk18m+n0EPT8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilBjwUX8GjAe0/e739InZMHJbW6xM18JXzrt00fS46HXJHs5rrCpezKH8EdTsBtAxql4X/bvkufsAKqgZU6VK/f1kfUxW0NLhJLpbCDMw+tFxOPB/Xd+5ahuXCYqC70n4CN52tREjuEfwxdtOLx6isZyImtpZ2Aj65Zhc9CmxNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aMb/fEyw; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TyqYn3wqHz49Pys;
	Mon, 18 Mar 2024 11:39:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710754749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OgK5DqvemQONZOKfh4+G8j2lgnkgsKApRAExxH9NoI=;
	b=aMb/fEywYr/sANGeS90VlNwTLaxez2DzN9jG9tQMEKZrCfJbi5vumftSoXDMpxx+LCYmy8
	XsETzc4XDZWySraQ59pt9K1XipguKYe0BVbPytW3Sg7i/UmDn54bf3fRlg2S/7t7ON5QOW
	EhR58A3joUgqpSuhGGZGNa9nGROOYlwUKC30j+rZx4DeI7weZ5akzPQZQS6cLjroT6pkIS
	YN3Q/JmSV4RP3J57ObRM6Qye1lMhkJmoZ6jZe10vOnZjRDT88/D5XmFWy1/+eLympOb7lA
	OTLslFfGY41acBywHbRO+ManXLD+n8bw5C3GsaBnbQlKaQbWfLgqiWpWV7LkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710754749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5OgK5DqvemQONZOKfh4+G8j2lgnkgsKApRAExxH9NoI=;
	b=tI7HxZJRwgEkBdWvuygMBTDF/zt72EQIXrQxmScDz5cKYZ80uMMjoIS86l9wDvgQo3W0Wf
	PHQC0Qny3NwmmbyZyy7s9X3rTJOQ+ftZ6PjPTlODkumrTLMbfrYufbdDuJnHQsJMi8eEnG
	4YpEzOhYK2gE/mYe6dF6DkR1YWONXdTvk7D1J12jpoVSnMjHUFlQ+Me2ZKS9qzLN8Vdsyd
	6pJoL/gTwm2Z2jZXXkDmQscen+df2evE6pLT7Bk10glv8dg7AO8zZOEe0UCD7N5SNsVoQ8
	wYfTQ/XkLiMcFFgzUWFhJ4VXHu8Wd94gtm36RSZfFozHMVMTqoNIb0PjKnTZ8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710754749; a=rsa-sha256;
	cv=none;
	b=i8Tr7/hs47nnI7yABO253Vi3tgiJSelL3mIMXrGaLxnyRQykXhxbIVCYQc1OsizOCOpdYn
	hhv/glkGKDv6HHg1CDaR41aDog6DUDoTTCPL2mytdQsFR5sgBnYvXE2cOuuFn9v31ce7gD
	s+qoa4v9gHHhOoGVIX/I0ibACEgbNVTni0YmNXXSNw8Zmp2ueHiKZUJKRiY4LCosfCmmjE
	f8t7QwVXgsdQDxGtq2+rk95N5nEH0+GsNeY/Qpnwpwp/LT9h32cvt1ARV5xGyxaXttLXcJ
	o+O+9sQDqqoQLY4LcTvhtew1FNqbbVgjXr2Fmyd7ynKvjGjAu88mM20VgY3yHQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 265C9634C93;
	Mon, 18 Mar 2024 11:39:09 +0200 (EET)
Date: Mon, 18 Mar 2024 09:39:08 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tomas Winkler <tomas.winkler@intel.com>, wentong.wu@intel.com,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/1] mei: vsc: Mark the driver BROKEN
Message-ID: <ZfgLvGXmyTJAZv9S@valkosipuli.retiisi.eu>
References: <20240308104614.4019592-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308104614.4019592-1-sakari.ailus@linux.intel.com>

On Fri, Mar 08, 2024 at 12:46:14PM +0200, Sakari Ailus wrote:
> The MEI VSC driver currently oopses and may crash the system on suspend.
> The other drivers required to use MEI VSC driver's services are not in
> upstream yet, disable the MEI VSC driver by marking it BROKEN until it is
> fixed.

Please ignore this patch. This one should be merged instead:
<URL:https://lore.kernel.org/linux-kernel/20240318080126.2813476-1-sakari.ailus@linux.intel.com/T/#u>.

-- 
Sakari Ailus

