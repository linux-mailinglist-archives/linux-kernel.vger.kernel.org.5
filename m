Return-Path: <linux-kernel+bounces-163620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3048B6DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC661C223CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D210127E02;
	Tue, 30 Apr 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPcyRhY8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFA127B69
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468192; cv=none; b=RZu5jInefIHLqMVZnmcQx2X9aPcoqRpAJEXF7q8PWhBLIC159UmhOfRsuUpcd/03LKkuq8b78d8iwMK9mvX1rn5Iv+qHA5X96zZ+ugCZDIqO/zQWISHQI5Ua7eiYEi+1eCYJyHxh+psQYivyxdF9jWtqGX1qqhPwUdnUSRJWFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468192; c=relaxed/simple;
	bh=wv2pBeUGmcTrV9ScoLl7MPTIiO6tkfp6Z8Ix0Gf5yMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuZVPry6zlCJ1FZMHTrXcC87X1HLCaU7dDaSK3+sCXODSThFVT25HUI5wAWAk7Lv6zjdu0OBUKFA67BBKdagOYuBrnZIyZPFk6HgvM7G7vCtmTorLnUbrYv4dHUlm+gQbiTryThYpEcPtd5mRTpFROu/LqWll/ZuL79GasVuzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPcyRhY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0676C2BBFC;
	Tue, 30 Apr 2024 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714468192;
	bh=wv2pBeUGmcTrV9ScoLl7MPTIiO6tkfp6Z8Ix0Gf5yMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPcyRhY8I8fY/0akgJqjjOcxGjVYvR8qopmxJFb9IE21uQpnQ+/f86fwygSS6MZbw
	 wbfhwBcByINA9I8bBFJP5WzTDpVZrmFSOPnw+o/f+sbnTvaYWIYD5WGCVsAOybvd7Q
	 anGRIECnQY97aLB/KjO2g/3DASaDp4qPD9CPb4UM=
Date: Tue, 30 Apr 2024 11:09:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] slimbus: patches for v6.10
Message-ID: <2024043006-palpable-tipoff-1ce2@gregkh>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
 <2024043013-foil-pucker-4c7b@gregkh>
 <a987385c-d241-4527-acd5-31767c62317f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a987385c-d241-4527-acd5-31767c62317f@linaro.org>

On Tue, Apr 30, 2024 at 10:03:38AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 30/04/2024 09:56, Greg KH wrote:
> > On Tue, Apr 30, 2024 at 09:50:03AM +0100, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > Here are few patches in slimbus for 6.10 that includes
> > > - fixing autoloading.
> > > - coverting driver remove to return void
> > > - some timeout fixes on wait operation.
> > > 
> > > Please note that, I have also included a fix at the start of this series
> > > rather than sending another email thread. I hope that is okay with you.
> > > 
> > > Can you please queue them up for 6.10
> > 
> > Shouldn't the first commit go to 6.9?  If so, why include it here?
> 
> Yes, first commit should go to 6.9, Do you want me to resend the series
> without that patch or are you okay to pick it this time?

Please do so, send 2 series, one with one patch and one with the rest.
Remember, tools like 'b4' want to take the whole series at once.

> I sent the fix with this series because it was just one patch, and we are
> almost near to rc7.

It's ok, I have other fixes to send for -final.

thanks,

greg k-h

