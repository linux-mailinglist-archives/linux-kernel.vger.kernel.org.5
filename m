Return-Path: <linux-kernel+bounces-82730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657338688C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD378285BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B075053369;
	Tue, 27 Feb 2024 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUW6Z0Ds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43601BF24;
	Tue, 27 Feb 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013141; cv=none; b=LfWtRh03g0GicCR+bkizdbJiigP7iGNG8aA25x//p1ivdOjZUYKTG/kIYwpQSUazx2fZTm248HVEtPFbpTAFIYdQGr+Ydr14FRAKZuMMrh6CBk83X0NO8ZpmITFN+K2qUD26r9qcVPOO2W1mvazzQMdUKTpDhX3jXc89xFXTgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013141; c=relaxed/simple;
	bh=SKtZVEghFKlVuZB2ezpdNkxvnXXddwMNQ1UG0qhBejA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g57hO+To5o61IshZ2Nhe+6cmOIOHiUJZLa4VjRSQigzuE+wX/JEn9sZJWQlsBXf7Znevn/PBksi6FHfE2+pH3BY5heaPZ/rom86mtHsdtPDLGMg4g5ToMlwS621+a9gjP/OSVO402eRcZAn7yQrO33laJ+UCZY67cGwV78Ce88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUW6Z0Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F68C433C7;
	Tue, 27 Feb 2024 05:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709013140;
	bh=SKtZVEghFKlVuZB2ezpdNkxvnXXddwMNQ1UG0qhBejA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUW6Z0DsQbd1MgceBoncrG0sCiG+TKijFv/Da+31fIX3A/+ZuEnCCsqmcH4IUyYz8
	 MjxjDpKQv1VIFaGbASOf2EHXNsi9yu+SlHX0UdMte3kM1C6aIA9dR1YnbSsWIuCBrs
	 IN0C93v7mbO6unujDz+NieGjxPWofdwx3xmpIbPM=
Date: Tue, 27 Feb 2024 06:52:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] sticon: Allow to get max font width and height
Message-ID: <2024022755-viewable-breeding-0bff@gregkh>
References: <cover.1708011391.git.legion@kernel.org>
 <cover.1708960303.git.legion@kernel.org>
 <07c0cb7f0c175460561957190e48a6e01a74a676.1708960303.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c0cb7f0c175460561957190e48a6e01a74a676.1708960303.git.legion@kernel.org>

On Mon, Feb 26, 2024 at 04:21:12PM +0100, Alexey Gladkov wrote:
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

For obvious reasons, I can't take patches without any changelog text at
all, and you don't want me to :(

thanks,

greg k-h

