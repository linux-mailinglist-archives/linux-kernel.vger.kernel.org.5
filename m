Return-Path: <linux-kernel+bounces-8431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883E81B709
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699A31C23CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCC73186;
	Thu, 21 Dec 2023 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VByLrBbg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84E73188;
	Thu, 21 Dec 2023 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4B9C433C7;
	Thu, 21 Dec 2023 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703164223;
	bh=+CCOLFjUWuo0kMo+F94tzNDUXNANIfRX23p7wOIacn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VByLrBbg8keQB7qy7zRDT869faoZCf4CXilzHPdPd56zll+1QysujiZ5IOsTESxUQ
	 cOppswM6obNmC47w8tcBRtFR5C7VhRHDYgdnImQW/uiWgcLrm7K6bxM9MDWfG7AmUr
	 RG5tBSofVHCKkQa1KCOcwZXdcgufaUb5mYfbvTjg=
Date: Thu, 21 Dec 2023 14:10:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/surface: aggregator: make ssam_bus_type
 constant and static
Message-ID: <2023122109-winking-stature-a487@gregkh>
References: <2023121957-tapered-upswing-8326@gregkh>
 <7f763191-2148-42ad-b1ce-afd1a6d478ff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f763191-2148-42ad-b1ce-afd1a6d478ff@redhat.com>

On Thu, Dec 21, 2023 at 02:03:03PM +0100, Hans de Goede wrote:
> Hi Greg,
> 
> On 12/19/23 18:18, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the ssam_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > It's also never used outside of
> > drivers/platform/surface/aggregator/bus.c so make it static and don't
> > export it as no one is using it.
> > 
> > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> > Cc: platform-driver-x86@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Greg, do you plan to merge this yourself (fine with me)
> or do you want me to merge this through pdx86 ?

I can merge it, thanks!

greg k-h

