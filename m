Return-Path: <linux-kernel+bounces-48307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D3845A14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E755E286831
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CC85D48E;
	Thu,  1 Feb 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fL1Dlw7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161D5CDF5;
	Thu,  1 Feb 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797335; cv=none; b=CAKa+EohCvNtBnNW6WKjvDFqGmFIhXoxWoHvBuKJwfFbl6IbS0pNMWpPi6896Mh5u/5BcTap2FylxsRsTzGrehzI5ZtPrXQ0EN5F13MnylQ/FvCAgXMJEcGPYviOkjix9vltbO1CjMt6/NkcCfUnc48BvkupOOS9CD232ZOSWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797335; c=relaxed/simple;
	bh=WNRgXpK3cyTcLjrStmAedyAdHp3cF8ZyWMJ/8P4PCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u10cZUDJ/vkNcRv+GUMqTjooqPgTC7zNKzdFJ2bzytgBPi8bsI2j3cyLwHC8/NJavqzeIlARGksZJRuLBXoTTouU2F/Zrd1srYTpoBc2dgxyj/zCh2SZ8x47Lbo4VsLSJY+UC14MqgKny7B8mN1qBy1QOx77z6dhCIZU76Ng6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fL1Dlw7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F19C433F1;
	Thu,  1 Feb 2024 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706797334;
	bh=WNRgXpK3cyTcLjrStmAedyAdHp3cF8ZyWMJ/8P4PCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL1Dlw7gOwnCWJ78CU0EbGE9YEyAiqiAq5Ep1QhAxQ06DxnpnNMxPugkP1BO/K15X
	 ZyzG/y+WN56MiCvYz8ReuKAC98WVeSMka6b2NMqa+ViWplfqqNvYlPCHcsyEDzQxg3
	 ltSDtZEK667nul9fTNVcStlIUBKU+GJu+jFkA9Y8=
Date: Thu, 1 Feb 2024 06:22:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Hegde, Suma" <Suma.Hegde@amd.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Message-ID: <2024020144-duplicity-nuptials-1cd7@gregkh>
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>

On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > + Cc Suma Hegde.
> > 
> > On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> > 
> > > The use of devm_*() functions works properly for when the device
> > > structure itself is dynamic, but the hsmp driver is attempting to have a
> > > local, static, struct device and then calls devm_() functions attaching
> > > memory to the device that will never be freed.
> > > 
> > > The logic of having a static struct device is almost never a wise
> > > choice, but for now, just remove the use of devm_device_add_groups() in
> > > this driver as it obviously is not needed.
> 
> Hi Greg,
> 
> Could you please hold on merging this patch for a week? I will push a patch
> for converting platform specific structure's memory allocation from static
> to a dynamic
> 
> allocation.

Push it where?  Ususally we do "first patch wins" type stuff, why not
just do your work on top of mine?

Also, when you do make the needed changes, please remove the explicit
call to create sysfs groups and use the default groups pointer instead,
that will make things much simpler and avoid races in the code.

thanks,

greg k-h

