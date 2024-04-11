Return-Path: <linux-kernel+bounces-139790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1C8A07C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EE1C22A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189F13C837;
	Thu, 11 Apr 2024 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0JqCL6r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DA13C677;
	Thu, 11 Apr 2024 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813499; cv=none; b=rpcYjFB3gkjyzrdXLlu4s14WbpSSZVd4Fo6yC1KObhyo+kfuHv1OqQOZCe6aMRmWQLGdNeeWG/6+bOU/Vf/xi/7XmfpJacU1FhrCgpqTFk6NOPS9winPEDIEVwUCmDSepKfsqaHZzkefZmjP3por4dYGigcNkp9yrVkkfWwCbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813499; c=relaxed/simple;
	bh=BHAdbUGahiL/8Ihfhkd5xAXGv841HuhuImx2iW47BWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrouCpnl5F3R6vp+4e7Lp2ehoo3bXHa8/oPcOq9AXYVz2sOw3GvKpomCZIMM3jY8VFmEepGH+9kyt3a6aROETgJqysyTG24VAYg5YLZNb2iu3mIVHTv7Rb9kUtuwZb0vi2n1YEulFjK4tVRjt2vwCsdFMMs0jt/vZumQTe9brdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0JqCL6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B8BC433C7;
	Thu, 11 Apr 2024 05:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712813499;
	bh=BHAdbUGahiL/8Ihfhkd5xAXGv841HuhuImx2iW47BWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0JqCL6rsumK3GShba47xsAO2IPtVsDveodL8A6PYw+eoiBKECNqKBgBNCY+7OSsf
	 LVbkok/LzS22Ltk96ypaIK91t6jIYFWSNiDtz2qm9Ya2xsoPP5Ne4S7GC2WJr9moki
	 jjxs+6neekaWnnsg1x9x6UYpPEb0R2uzSSooEGiY=
Date: Thu, 11 Apr 2024 07:31:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] docs: stable-kernel-rules: remove code-labels tags
Message-ID: <2024041108-disprove-spur-8362@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <82e9304d61a1ebebfabfae86b386d2547a8479ab.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e9304d61a1ebebfabfae86b386d2547a8479ab.1712812895.git.linux@leemhuis.info>

On Thu, Apr 11, 2024 at 07:25:06AM +0200, Thorsten Leemhuis wrote:
> Remove the 'code-block:: none' labels and switch to the shorter '::' to
> reduce noise.
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Assuming the output is the same as before (I didn't run it to verify):

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

