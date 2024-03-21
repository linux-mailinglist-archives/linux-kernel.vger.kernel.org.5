Return-Path: <linux-kernel+bounces-110508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A380885FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A572E1C22019
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D112C814;
	Thu, 21 Mar 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="dlNzP8Iq"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5728E7;
	Thu, 21 Mar 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042617; cv=none; b=Q3VKFI0eZIw+6eXg5xe+Fm2cl52B+1xBSBXuNlif4OCo13G884Am2ZaLE5xLmo4URmIQMbSdMJqde+n9sfMiASujmekCrP+OENwUx4l9m2QrjCs4WUYhIpdD6K3Et2c7yNKhU9QW5IXJ449+XOtxUOtCnMXF1n57L2Fkh+ZOtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042617; c=relaxed/simple;
	bh=h1oQKriSLCqDjSLy+aBuDnCDSSYx3kAjFzFetPDxwKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBe20RufeZQ0W83Kjx28xeA9XJmUAcw57/2fmetD+sb3ZdI4cC70wmvlAobC/XDGVwNSQohFncSm2yS4N5fVvEva/MMMYf9kdRjV7/G4f++7aJgmiWFlN6oNP81mZzja2vLuAkEkCf4n/GXe65hgLWVvwTaf20g2UHwmAQcvV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=dlNzP8Iq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 320AF1F925;
	Thu, 21 Mar 2024 18:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711042612;
	bh=xGnEOdC2UWMFq3f2HadSnkInpwhH3sbmjhpwAdVYI/k=; h=From:To:Subject;
	b=dlNzP8Iqq3GcSF9XGMn/wXAGhf/SE62lCy/yTfpr1QImMvXTsM324PLeD9hVT6Si2
	 JMxYDtBA+oYshXwH8PvSc5KL+LNs/oKym0C9t/GCHplnZShbMItbmNTUvYK51MIfV/
	 WavsNJ0h9LcmXkQJAZqVTOHrCulTIddPnCRgJPpHLufiM9TRUerVr+06AwVGCry1Z/
	 9UvxrXO+Fyb9fYEqt/4lwdhJAULvr3UANxxVHJRT1pjydm6C04lQkjd/B1kqIhmsIc
	 yhLLtxkxDGpUBkCeEN+SXHOYOi1yCxFlC81JjmIICaahZDPR5zjyPBMapS2yZGeTkf
	 AIRV2F+zsYRjA==
Date: Thu, 21 Mar 2024 18:36:48 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Kalle Valo <kvalo@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
Message-ID: <20240321173648.GA12994@francesco-nb>
References: <20240321163420.11158-1-francesco@dolcini.it>
 <87y1ab8r13.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1ab8r13.fsf@kernel.org>

Hello Kalle,

On Thu, Mar 21, 2024 at 06:54:00PM +0200, Kalle Valo wrote:
> Francesco Dolcini <francesco@dolcini.it> writes:
> 
> > As discussed on the mailing list [1], add myself as mwifiex driver reviewer.
> >
> > [1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/
> 
> I'm nitpicking but the preferred way is to use the Link tag. I can fix
> that.

I can also send a new version with that fixed, whatever is the best for you
works for me.

Francesco


