Return-Path: <linux-kernel+bounces-8304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73A81B544
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D87FB24B65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE76E2B0;
	Thu, 21 Dec 2023 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H0MpPXNI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2BA6A327;
	Thu, 21 Dec 2023 11:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BDC433C8;
	Thu, 21 Dec 2023 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703159479;
	bh=s2pWFXasNFih0eZWQQYywdlJvENTgAThuqZwC9QU1Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0MpPXNIAt373oxhvbFW6jpyIRhuqUFNmd8RCJNpPhzVqkuve2OKH+iVwQOLERzzF
	 a1oBeGwaJu0MF8nNlKbpS5aSubwviKZjc44jOKDyia7b0SUrpXtqdAtssrjmSWtY2l
	 pBk+Xu+sL6fxrrhPVIQyapxHMJdg580jtChavAvM=
Date: Thu, 21 Dec 2023 12:51:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <2023122112-rigging-january-7618@gregkh>
References: <ZYQeZjN_3bPOdKKf@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYQeZjN_3bPOdKKf@archie.me>

On Thu, Dec 21, 2023 at 06:15:50PM +0700, Bagas Sanjaya wrote:
> Hi all,
> 
> Let's say that there is a content creator who submits her first kernel
> patch (touching drivers/staging/ of course to get her feet wet).
> The patch supposes to fix a reported bug, with appropriate Fixes: tag.
> But instead of using Link: or Closes: tag to the actual bug report in
> the patch, she instead writes "Link to the bug report in my bio", as
> it is the norm in social media world. Here in the context, her bio is
> LinkedIn profile (IDK if there is a way to add arbitrary link there).
> The link in LinkedIn profile, when clicked, will list many links
> (including her usual social media campaigns and of course the bug report),
> which makes reviewers confused about which link to the bug report she
> means. In some cases, she may disambiguate by saying in the patch,
> "Link to the bug report no. 99", to refer to the specific link number.
> 
> Is such practice a good idea?

No.

