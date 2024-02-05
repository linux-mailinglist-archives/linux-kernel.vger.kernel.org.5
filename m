Return-Path: <linux-kernel+bounces-51974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF484922A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA11281A60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D663D72;
	Mon,  5 Feb 2024 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sChZ/gIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7E7F;
	Mon,  5 Feb 2024 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096382; cv=none; b=qVmgPoi1XGnS4u22zouCHfxaiznwB2GelSmRfNzlC5+h3aECFv4p5Y08HIGUJ9+CMD01UpqB8dwz3OOWgOLL/7iBOutKFT8lWBWfEXUC1Slj60s/R9H8vlGTLzer4RDnZ9yaUmZMaG1n9WH9/Iibvk/AgzsFDq04jyBn9jBmn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096382; c=relaxed/simple;
	bh=sLqGwmY9/sMaBWWDGYHWY/5f+/4Fzj0046owOU2yyx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI+KYg3AwtIQfJusXS56QAhOA7buO6ugJH2mEETfPLIl0f3zsjbGyiu272eGAf1dEaJ099F+GqYOxtKLGNFlE4ATt8Qqjjvvo4PNGDv3GcbMaI/SfkFCdNNvOyC+3L1h/oPWtsvJRPLNk8BGH0fRkLRarvKWP0qdO+MwnlGQ7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sChZ/gIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26E8C433F1;
	Mon,  5 Feb 2024 01:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707096382;
	bh=sLqGwmY9/sMaBWWDGYHWY/5f+/4Fzj0046owOU2yyx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sChZ/gIJPF6QwmEfVQlAVpxSMejQEYAjahvLCCgIqGm93iWEre68L5ahnr5Y+5v8g
	 wY6R5FB7LRVwmY14BqsPTEjggfZeyw6mJ9E3o2NYO4hNSxHoalzN/VadGL89ODWVRM
	 sSRPcBpmisaPVQUlOosjBmHzrdcvtf/BdfCIL6w8=
Date: Sun, 4 Feb 2024 17:26:21 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <2024020413-mauve-bundle-e5ba@gregkh>
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <2024020410-bungee-number-f643@gregkh>
 <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>
 <2024020427-trio-clubbed-37b2@gregkh>
 <CAH37n11Tr9_2A=nFG7N8gi9DoC0ZdEQBGH3herTuP+C-s+3isg@mail.gmail.com>
 <2024020433-universal-resolute-024d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024020433-universal-resolute-024d@gregkh>

On Sun, Feb 04, 2024 at 05:25:06PM -0800, Greg KH wrote:
> On Mon, Feb 05, 2024 at 01:08:47AM +0300, Стас Ничипорович wrote:
> > I meant that there is no place for the patch in the stable branch
> > until fix. In 6.6.15 there is no issue.
> 
> I understand, but again, please work with the networking developers to
> get this fixed otherwise this will happen soon for newer kernels.

Nevermind, I see the fix now, thanks.

greg k-h

