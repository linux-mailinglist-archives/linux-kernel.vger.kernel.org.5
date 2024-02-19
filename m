Return-Path: <linux-kernel+bounces-71939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209285ACC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F8B1F23812
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BDF52F68;
	Mon, 19 Feb 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cAWui9vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E0374DD;
	Mon, 19 Feb 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373240; cv=none; b=YGNrDO7ieq3n2zJDIKa3oPEoVqFRs71UuS+xiYLFYNv7RKMpoXcMeiv/uph1eBU5YcZJdrT5gCSnVyVIg1NHL2l5OaI4yh8ZeDvK2e0bwibRgU6kLjPtoZW9GSizaDjRPaGyS6pJdkv+/mkr0kroopYnRm00mJkuea2YlEOliL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373240; c=relaxed/simple;
	bh=aNEcQiXoV4afv/M+136E7/8ESPor1nnFBNzWVogGSEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzpkQwqIsUf9nbpXjvvTuhNd/Q+zedWtZyC0QiYnPy7qr6nAUCyCShzwXhgkkPmCv/9HwiMG2gbZEvwlj1W3esRLicFi+/kXXQWHz7sw4TSMOrRgxZxM4R/Inr0SB0Am7vXimm8O2Za/xcKSVtTFxiqGqg38rkf1EXUb0JH2/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cAWui9vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB520C433C7;
	Mon, 19 Feb 2024 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708373240;
	bh=aNEcQiXoV4afv/M+136E7/8ESPor1nnFBNzWVogGSEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAWui9vBghjT4PJXtaXla7JmOHz+cZ4byaP61zxzYbzrycn7+e1jGzuzrokiFHU7z
	 +zXQfUiH9DJ07uOfgmc9iDaggKTeUPpbYwIw7Bgct/2yL0wM8OuiK18aMFfplN4cjt
	 /PNpGqjrBx/t6ccfb2QIDujVLQr37Tf/vURKs2FM=
Date: Mon, 19 Feb 2024 21:07:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] usb: gadget: legacy: add 9pfs multi gadget
Message-ID: <2024021948-reformer-silly-fe48@gregkh>
References: <20240116-ml-topic-u9p-v2-0-b46cbf592962@pengutronix.de>
 <20240116-ml-topic-u9p-v2-3-b46cbf592962@pengutronix.de>
 <2024021757-geography-hacksaw-3022@gregkh>
 <ZdKze80oFj0PRkkZ@pengutronix.de>
 <2024021911-facelift-graveyard-0760@gregkh>
 <ZdOz7mc-NbiEe2Ei@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdOz7mc-NbiEe2Ei@pengutronix.de>

On Mon, Feb 19, 2024 at 09:02:54PM +0100, Michael Grzeschik wrote:
> Okay, What about the rest of the series? Can you just skip this patch
> then for? Or do you want me to send the series again without this
> legacy driver. There are no dependencies to this in that series.

I don't remember what the rest of this series was, it is long gone from
my review queue :(

So yes, please resend.

thanks,

greg k-h

