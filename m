Return-Path: <linux-kernel+bounces-80014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054948629B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3011E1C20B76
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786EEED0;
	Sun, 25 Feb 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrwdVzOf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6CDDC9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708850005; cv=none; b=i5I+lvrkJmmek58gwRGklIg7DqrkOPeegs5RWdd0NCX+3AihRfiYDwbvZjUvqPVy72gbt9rSzfTIlPH2fVheGRxT9wZ/Vttm5oqU3Z2AWnluMjxU6XtSIV8QGND3OXEo//dTS89h0tT9RAbPtdJZCyHH5zb4sY/nKtkWnBIN0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708850005; c=relaxed/simple;
	bh=6hgAzKoh0X8Vc/PxuhnIWRzdvMEeWy6T9l/qi5QFODY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApKyY9yZtFEpbDliFWP6QkOjnwkBlLtiwl4sjVI6ikizni3ot14aI9x23jA7ix9sQsAY6IWeLmahXK6PzFsTiYr2QVy8D0iGW3HKDDPVXNQZMMRpHJncirUK2YswFlB4wqneIc9b8vBpV/DK6aR20WZph3aQkFLV42TdkOcQsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrwdVzOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B3BC433F1;
	Sun, 25 Feb 2024 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708850004;
	bh=6hgAzKoh0X8Vc/PxuhnIWRzdvMEeWy6T9l/qi5QFODY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrwdVzOfqd39q8MknfoPT1MJBqXSmE+Jqa3cvGdq571eBG8OqIpJ/+3NR2koZdB99
	 Kg0OLwXYXR2wUthYisXnjlweeu0+Ahb73Hp0iprI26+t3Nfnsy9if0y51jjm4vWfeh
	 kgvJErhgUrN3nRiRrEMlCDHK3XW/c7ja6kpCX+HA=
Date: Sun, 25 Feb 2024 09:33:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Alex Elder <elder@ieee.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Message-ID: <2024022553-deepness-sublevel-73de@gregkh>
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
 <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>

On Sat, Feb 24, 2024 at 05:22:39PM -0300, Ricardo B. Marliere wrote:
> On 24 Feb 09:43, Alex Elder wrote:
> > On 2/19/24 6:40 AM, Ricardo B. Marliere wrote:
> > > Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> > > core can properly handle constant struct device_type. Move the
> > > greybus_hd_type, greybus_module_type, greybus_interface_type,
> > > greybus_control_type, greybus_bundle_type and greybus_svc_type variables to
> > > be constant structures as well, placing it into read-only memory which can
> > > not be modified at runtime.
> > > 
> > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > 
> > This looks good to me.  Assuming it compiles cleanly:
> > 
> > Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Hi Alex!
> 
> Thanks for reviewing.
> 
> > 
> > On another subject:
> > 
> > Johan might disagree, but I think it would be nice to make
> > the definitions of the Greybus device types as static (private)
> > and make the is_gb_host_device() etc. functions real functions
> > rather than static inlines in <linux/greybus.h>.
> > 
> > It turns out that all of the is_gb_*() functions are called only
> > from drivers/greybus/core.c; they could all be moved there rather
> > than advertising them in <linux/greybus.h>.
> 
> I guess it depends whether they would be used somewhere else in the
> future. Perhaps it was left there with that intention when it was first
> being developed? I agree, though. Will happily send a patch with this if
> desired.

Let's clean the code up for what we have today.  If it's needed in the
future, we can move the structures then.

thanks,

greg k-h

