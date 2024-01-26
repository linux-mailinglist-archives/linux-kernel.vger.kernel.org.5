Return-Path: <linux-kernel+bounces-39495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C56583D213
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3171C2423F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E984138C;
	Fri, 26 Jan 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQX2Ffn6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C710EDC;
	Fri, 26 Jan 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232512; cv=none; b=ioiGW/YfAYBMTqsDUlTOVV4EzDB+jFOLN+ook7aOKt/ye3d+Xm3ZsDgKt8Uo+MNTMYEvfweo9LAquvCnKrPDzo/f3ZDkU78p+qDASjTeHH/em1w/SfYv0bSg0jtVWwcS5WodgC6HCVyBzr/U559nGuvtjgTyRe/Tuo9u9LnD/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232512; c=relaxed/simple;
	bh=MXHrNMwIXxXC2zkbi7yyUvT18qCcisD+QCAYXgVEWA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv8/au6hLBtcu+VVLVw1l8kY8ORiwHkyOeXAhT3vPQSXD0bO7uGD4xZujZLTlVD0wWG3/UgZ/C2bxEQXleWomsf9VAXHf+/mZuo0gOmuoPYIICpGePoaRVxYn3hHL7dRS/V1QXw7vDLBoKFDIQvLTNVEYU+RV6tGrVFHZWFDl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQX2Ffn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F5FC433C7;
	Fri, 26 Jan 2024 01:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706232511;
	bh=MXHrNMwIXxXC2zkbi7yyUvT18qCcisD+QCAYXgVEWA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQX2Ffn6k1pcaRnw+jJVmMFdr9GrLLoX+5tMV7En9LVxpNYz8GECkM+UvWrWJAQSH
	 b/2p5YbcBFxxEHpVGzFaj5CB87nCMCPADzoGfeOQaJVcRJLzTBv58AA3ROZlbxEQHx
	 o4WDupZhUiCDV67AZ7f9Mun1pFNG15jPAco8eMEo=
Date: Thu, 25 Jan 2024 17:28:31 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH] coding-style: Add guidance to prefer dev_dbg
Message-ID: <2024012521-magnetize-dowry-8b05@gregkh>
References: <20240125165311.1.I8d9c88e747e233917e527c7dad1feb8a18f070e2@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125165311.1.I8d9c88e747e233917e527c7dad1feb8a18f070e2@changeid>

On Thu, Jan 25, 2024 at 04:53:11PM -0800, Abhishek Pandit-Subedi wrote:
> During review, it was suggested that drivers only emit messages when
> something is wrong or it is a debug message. Document this as a formal
> recommendation.
> 
> https://lore.kernel.org/linux-usb/2024012525-alienate-frown-916b@gregkh/
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

