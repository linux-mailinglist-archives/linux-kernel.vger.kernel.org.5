Return-Path: <linux-kernel+bounces-69080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6C85843F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0DE283200
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C11132C14;
	Fri, 16 Feb 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScwZlMbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DA130AD9;
	Fri, 16 Feb 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105039; cv=none; b=EhKUbdS2E7XsG+yVoWhS3Lb5E1t3MonxrdLyoxa6RhQ/eT8CHsSHaVQsNB2RdEbSeuiAg6cVPqS8snQsYvkMERYqRB/zgEJ+vOy4atumgX4RlVwumODbJtosUQ0PRaXQlg6NSaHKP8bLO7xO9E/YLzm+FP3JPZkl4RUA4iF0P6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105039; c=relaxed/simple;
	bh=OC26fFREj2itFzBfxgZchfezBR3HvZ1bSCOcHxrD2UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAceUT7ZB8KaiTT0B4wpxN+t/u3cDTzEpQfexSbOiiAxS2bcp4gqVs3qEZil67RlRNtC+OFShEm2HjLlGq08QsPJsCcDB+3galAQ/PvttPN7TmByl6qhYK8Pau8A4X1zz4Q43Hfr2P+DHADBuXg9IVpliWoZIrr2xC6xCZsCU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScwZlMbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA4DC433C7;
	Fri, 16 Feb 2024 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708105038;
	bh=OC26fFREj2itFzBfxgZchfezBR3HvZ1bSCOcHxrD2UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScwZlMbZNtJGG4k1frpjIRAlvNppKqfRxg70gjTTW4vty2GtK1Iz4G5cj89pXYZD7
	 f5J8M2ez9iZwHCdOygA8Z+8xEC/KaZLNwNQYu0fyGGNl1DPDADZWxfeTvIY8tBI2Ga
	 Yj5dZV4edeoLLjQQlrY0BeWws5mHOPr6ldzdRQLQ=
Date: Fri, 16 Feb 2024 18:37:15 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"i@zenithal.me" <i@zenithal.me>
Subject: Re: ZDI-CAN-22273: New Vulnerability Report
Message-ID: <2024021605-disloyal-overlying-ed56@gregkh>
References: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
 <2023102134-reflux-saddling-c750@gregkh>
 <DM5PR0102MB3477B594C9D018BC884DF3E4804C2@DM5PR0102MB3477.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0102MB3477B594C9D018BC884DF3E4804C2@DM5PR0102MB3477.prod.exchangelabs.com>

On Fri, Feb 16, 2024 at 05:27:57PM +0000, zdi-disclosures@trendmicro.com wrote:
> Hello,
> Do you have any updates to share regarding this vulnerability? The 120-day deadline for this case was January 31, 2024. We will publish this soon in accordance with the ZDI 120-day Disclosure policy if there is not an available fix.

I asked some questions to this, a few hours after you sent this to us,
yet we recieved no response and as such it did not go anywhere.

So this is all on you now.

Also note, you are talking on a public mailing list, there is not much
left to "disclose" :)

thanks,

greg k-h

