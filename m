Return-Path: <linux-kernel+bounces-77829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDCF860ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C2285C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD612B61;
	Fri, 23 Feb 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wfmo3Tq/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85E125B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669341; cv=none; b=k9nKOVbqxwnjpXe590FthsWqSkcG47u3QeT/khU1rUqsHfHasaDG9/eqrJrhsy70tfw032V6uFluOrIZBmbuYV5r/gfNhG2+L6ptUuVdFKZoS4TvlYD9d09omeYReTiffdeeDTzxa3FIhEn5TcX11CpDgyuPMBnMu/yym99tKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669341; c=relaxed/simple;
	bh=UPxIa+kD9NCI/MKxvz8H6VLioO2Ntf4OMScMcbxN7Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwAr8sx9g7IeCEdSGmutElH2n/DGrnFlwrDLKTNmdkwl4hjDzFbcoW0BSdGNQQfw3LoTn8OXJO9HzbST3S3DrY1lwyDO8RzyQ8rhrjf6Yjh/Jsn7wXj3ry9co/9YsWgKtI5BbvkGQiAn6vkGM4fOTXkiwxmbDuVHtPXNV0oio54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wfmo3Tq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51751C433F1;
	Fri, 23 Feb 2024 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708669340;
	bh=UPxIa+kD9NCI/MKxvz8H6VLioO2Ntf4OMScMcbxN7Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wfmo3Tq/hiJ/iOgkdl/US6LiFhztoIAEltZMG16oHyydOWWlYpyRGGJeHkmb1/tXd
	 Y9aDz2mPnOtyFUPogrOOMz725lDqY1BcBtPvQYcUnP123SzHnFeNL6fKB7ZCd95jC2
	 QNgDGtkUCrRStFLnEOiLx+pqDzdEYzQNlMMOpVXk=
Date: Fri, 23 Feb 2024 07:22:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH vRFC 5/8] firmware: Convert minor inline function to macro
Message-ID: <2024022341-protrude-viewer-04a7@gregkh>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-6-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222180033.23775-6-quic_mojha@quicinc.com>

On Thu, Feb 22, 2024 at 11:30:30PM +0530, Mukesh Ojha wrote:
> Convert to_fw_priv() inline function to macro.

Why?

> No functional change.

You lost good error messages if you pass in the wrong pointer :(

There is a good reason to convert this type of function to a macro, but
you aren't using that here, so I'm not going to tell you why it would be
ok :)

thanks,

greg k-h

