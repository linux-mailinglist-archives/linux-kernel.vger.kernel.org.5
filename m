Return-Path: <linux-kernel+bounces-55054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7C84B6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D44F28903F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4DD13175C;
	Tue,  6 Feb 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfJxICc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD7130E5D;
	Tue,  6 Feb 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227586; cv=none; b=E+aw0rMiNwCQpPvQhM2gH7Wbe43X7gKavLcOAsHJfZa2UWE3ZdTzMnGJo35rYiiQMCnHgq07JtOrXk8rAgdbbVUH7BRCUxdE8Pxi1EMfrQDX7kxIab7i6arXIfd6PuyMLHo0JJbi4YfQLswyfDqOrNAjMfUGi/DJIyLJUKxEPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227586; c=relaxed/simple;
	bh=vQKkUWbbtTuCxrQITFYAqGaNBETvaZoRexb2/a4HdUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyyBIykEUUi317+frKXKpkxIUstQ6RDI+dHVnTO+yx3ff/rfwImJ3nNsmg9B8MgW5BqyFgaIh9SaYoxECjPhfZRXX9tKpYvt8SAE/Dzf9R3zLwrrlsfxyfMzHS5TLZChx+H+ZkfPISA0rNH2X8Xn95MkiDpvrN63zScn9/ixBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfJxICc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B5DC433C7;
	Tue,  6 Feb 2024 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707227586;
	bh=vQKkUWbbtTuCxrQITFYAqGaNBETvaZoRexb2/a4HdUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfJxICc/r+Ol3SUSFF8h/HVx2ZP7G3QTCEtyPv2H7AioKl5mYziIY6ZQ5xBeCsqXQ
	 6V1pVQCFVXBKAQat+Q7tVeJZ0B9FTJDoVTSSZNm+/Ne+AuKFdzA8XNBkQYNbeC0SNe
	 y/SUMPQb//FrJvlKCdHfPRDUTZFXC+VlsozmwNCB8KN33FybGrrPif6xbUNuTsdjn5
	 +dJ8qJJo+NCrKFrGaBpdgF5qQgHC+KXfB2DlkolQ6V98imbORFjSep0CBvWdFo01x2
	 kaPdowVC+URvWrxDSOSYdCQIsp4NTVz/2obF1ktTNhdr+799TGr0It5aIzxyWRubmb
	 LTbv+BdA9CdqQ==
Date: Tue, 6 Feb 2024 13:51:32 +0000
From: Simon Horman <horms@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leitao@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/8] net: netconsole: add a userdata
 config_group member to netconsole_target
Message-ID: <20240206135132.GA1104779@kernel.org>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-6-thepacketgeek@gmail.com>
 <20240202115151.GL530335@kernel.org>
 <CADvopvb1phuPW+M3L2BQ576vJgWx2zeFN943OxcVq+iTL8_3qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvopvb1phuPW+M3L2BQ576vJgWx2zeFN943OxcVq+iTL8_3qA@mail.gmail.com>

On Fri, Feb 02, 2024 at 08:05:07AM -0800, Matthew Wood wrote:

..

> Hi Simon,
> 
> I appreciate the review, thank you for the feedback. I've addressed
> the comments here and in the other patches too. I'll be posting a v3
> soon with the changes.
> 

Thanks Matthew,

likewise, much appreciated.

