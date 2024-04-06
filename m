Return-Path: <linux-kernel+bounces-133934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D389AB17
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9AA1C2101D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519E3715E;
	Sat,  6 Apr 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUxr/uJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C80364DA;
	Sat,  6 Apr 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712410069; cv=none; b=JatzLg/k/Qkk/hs01y1mm9chJSdYeQoQCM4cnQTHnLIsUjltzmV9PX8GSN0QIIzzXXFH8sYfftdIbfrxSPjjOTqD9fO4pAPXYJLHVuZmYfIDG23am6Jn9M1tZd18PUMfNLkfGg2QkjRyY1zE1TdsAbFvgcozTtzAYtNAU8tE7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712410069; c=relaxed/simple;
	bh=uyYhGpzWVAkKGMNMK7FyCYvczFp5qaboPv9extJ+xW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRuPPlAUI7zqKJ7OzxcdGVsCwEUGOtQEd5VXRRhXc879rIvWQrjvm11H+WPx/ABMqMZz/CdBovrJWmch79NIbd7YFNySUPG9wp/x67+YlMTl/VIWxSFwk16M58vMzHmhZITAlesryVyLbwXOIXKr6s9tEDkE1bReTcqgv92bHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUxr/uJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC66CC433F1;
	Sat,  6 Apr 2024 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712410069;
	bh=uyYhGpzWVAkKGMNMK7FyCYvczFp5qaboPv9extJ+xW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUxr/uJ4T1Vxr8R5pxJrAwXtdYnbGzVOmzR6fLkqVysPW2udXg25cMZjGPII4iYKM
	 DrKV1iRfEwwQ2R6J7tTUxGyPLDvcXFFC9b8J8NDUx+QaRy2YwIpg6qpubxbLD9pNyT
	 cDH/3o+zQR87r/7+vzNpWi4oXkpX8sZ0ORQi0z8I=
Date: Sat, 6 Apr 2024 15:27:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: torvalds@linux-foundation.org, lwn@lwn.net, jslaby@suse.cz,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: Linux 6.8.4
Message-ID: <2024040629-bullfight-wind-54f0@gregkh>
References: <2024040409-attentive-raffle-d9bc@gregkh>
 <2024040409-disliking-mammogram-096d@gregkh>
 <41c2bdd3-9b66-404a-aecb-8633d4aa98fb@gmail.com>
 <762f7ace-7fee-4f61-823b-54a1b7d5bdce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <762f7ace-7fee-4f61-823b-54a1b7d5bdce@gmail.com>

On Sat, Apr 06, 2024 at 02:42:07PM +0200, François Valenduc wrote:
> I also get the same problem with kernel 6.9-rc2.

Great, can you run 'git bisect' to find the offending commit?

thanks,

greg k-h

