Return-Path: <linux-kernel+bounces-89881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D0686F6D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4863A1C210B7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B279DAB;
	Sun,  3 Mar 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nHiOiVnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EB43AB3;
	Sun,  3 Mar 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494216; cv=none; b=s8Eo6vCOU4EwaJbLy67rSdU7yuYOhlfFm6DowwRmrA1eHBtmoA06lbtDVuHQuvHs51fmOBPbb4lg5eC5MM41w5fnuTKI3Jf7uzgMaE8R2KrmbN687jKTDSt/5vB/O4ACRAzx4yfjQOPpsnAL/zAieJVMuXNZHcWPZbew1y45YVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494216; c=relaxed/simple;
	bh=46JwgXrEklHBQiYijE3VUlymVjcXwjasc5RJAJRLQAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ9H+FP+O7MWexe9W9omt/g6dbkshRi1LkPPJMQjRCfy48qCX2MCBulU/v73AyrWQSTq7Meo8REzmhl/LcJeC04xrauY4cebMDag97PIzI8JbKeGw/an67a9u3oBu3sinYCI/HgwC/v/IxlP+Iaidr6CXiW4LpmbAChP5E+TzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nHiOiVnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F95CC433C7;
	Sun,  3 Mar 2024 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709494215;
	bh=46JwgXrEklHBQiYijE3VUlymVjcXwjasc5RJAJRLQAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHiOiVnJ0qbixyCdW8LZw9OYPWM9/UHCL/Zun5a48HDDcfFcnEJZFiogOMJj1OgM+
	 CYFabd6wdGQIS/4FhUIZnkncoKAInQ5ObuYXYSdOkhPENhmCZafbtSRKxaQ0YIvaQP
	 IerVuT/xvbLPBBw/44DxLJwD+tr6VymMRfZXf11o=
Date: Sun, 3 Mar 2024 20:30:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dorine Tipo <dorine.a.tipo@gmail.com>
Cc: forest@alittletooquiet.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Match parenthesis alignment
Message-ID: <2024030317-multitude-pelvis-bcb2@gregkh>
References: <20240303065640.11651-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303065640.11651-1-dorine.a.tipo@gmail.com>

On Sun, Mar 03, 2024 at 06:56:40AM +0000, Dorine Tipo wrote:
> Align parameters in static void calculate_ofdmr_parameter()
> 
> This patch aligns the parameters with the opening parenthesis for better
> readability and adherence to coding style guidelines.
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi,

You sent 5 patches with all the same subject line, yet they did
different things :(

Please resend these, all together as a proper patch series, with unique
subjects so we can review them easier.

thanks,

greg k-h

