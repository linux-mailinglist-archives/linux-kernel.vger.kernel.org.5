Return-Path: <linux-kernel+bounces-17824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE696825339
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D0286225
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609CA2D03C;
	Fri,  5 Jan 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0mWOKyk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F762D601;
	Fri,  5 Jan 2024 12:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2588C433C8;
	Fri,  5 Jan 2024 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704456396;
	bh=771cJmS/QvQZS5wH+fF4qF6c0Cu3brr3xJExwpIAORc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0mWOKyk8NrVUi8/jFJtBL/mFSCUoIVGYI8Eapi3GsoO+FQWFrgEiicQwN+VzA4o5
	 t69q71kbLGk8B1m7GJEJunGvK8BRInjboGoSpMkDy2XAQ3yvpT9KCg9Po78WimY91d
	 gMyuIAjzU6EyQsLazYhIgwzo8jcQ2XySjA7cXAtw=
Date: Fri, 5 Jan 2024 13:06:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Niko Mauno <niko.mauno@vaisala.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaaskelainen Vesa VEJ <vesa.jaaskelainen@vaisala.com>
Subject: Re: [PATCH] usb: core: Make default authorization mode configurable
Message-ID: <2024010518-embattled-illusion-9a13@gregkh>
References: <20240104163203.7381-1-niko.mauno@vaisala.com>
 <2024010413-portable-lingo-3c11@gregkh>
 <522eb2bb-95d0-4e2f-a426-9347f14f51cb@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522eb2bb-95d0-4e2f-a426-9347f14f51cb@vaisala.com>

On Fri, Jan 05, 2024 at 01:56:35PM +0200, Niko Mauno wrote:
> On 4.1.2024 18.41, Greg KH wrote:
> > On Thu, Jan 04, 2024 at 06:32:03PM +0200, niko.mauno@vaisala.com wrote:
> ...
> > > +       The available values have the following meanings:
> > > +             -1 is authorized for all devices (leftover from wireless USB)
> > > +             0 is unauthorized for all devices
> > > +             1 is authorized for all devices
> > 
> > What's the difference now between -1 and 1?  We don't have wireless USB
> > anymore as that never turned into an actual product, so we shouldn't
> > reference it anymore, right?
> > 
> > We should get rid of the -1 option entirely, but keep the module option
> > and properly map it to '1'.
> > 
> > 
> > > +             2 is authorized for internal devices
> > 
> > Needs a "if you don't know what to select, please choose X" text here.
> 
> Thanks, submitted v2 which strives to address also these considerations.

Much better, thanks.  I'll look at them after 6.8-rc1 is out.

greg k-h

