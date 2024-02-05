Return-Path: <linux-kernel+bounces-53462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E42484A44B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9371F29C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895113DBAC;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bS+WVFDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C821350FD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159821; cv=none; b=El4K9aSGeJMSLf9s8i0ZtPaE+3Bcdop261d5vaOlSk4ZAJaN1caT2ttet70jdQaFM6NLeg7Ksd5qJlc2wIddsglwwelhEXtCedw95eUYSTdcY9EsQ5HXIpFuXzT4X4F7syC3wz1Jw2ZrmSMeN12Mgne6DZKNrmQ8uzQJyb57cmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159821; c=relaxed/simple;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQXyBrOUGLo73w8wwknm1sqP8tPlzyX8hqbocRB91LNEweqBIldoIG57/Xd+CvuciA8X9ohibzZCSI0V8BskyCAB/gadno8CWw9ApLaAAAtAertByfjvFv8bt+lz4pjqAhcPN4vgVEaoTJJyS0/uN5XptuXQ/+8++v9iLku5uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bS+WVFDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCAFC43399;
	Mon,  5 Feb 2024 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159821;
	bh=mAFr7rgIiDDs3owlqHD04xWyLOAFyYWies7SJEVVNg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS+WVFDp+Wevvit8BWM3DdSikiKL0CJ1qOkeEHMSkLu/xIZUWqE+iwU2ErRadUH2g
	 u0aDJHl3JM4JH6d+b0S7HKJI9nZTgtI9FJepyKnYJJbM6xyBKvnzRrQSQ/sfmXRx1b
	 1zKL8iGGiscQFptbPcRKFC0VdG4+aajYTdY6FEMo=
Date: Mon, 5 Feb 2024 04:48:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mcb: make mcb_bus_type const
Message-ID: <2024020553-overtly-overreact-ed57@gregkh>
References: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>

On Sun, Feb 04, 2024 at 05:03:10PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mcb_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

