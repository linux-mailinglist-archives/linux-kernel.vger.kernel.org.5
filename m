Return-Path: <linux-kernel+bounces-54617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF684B18B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A08F1C22764
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0912D74A;
	Tue,  6 Feb 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWZCqv2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8D12D145;
	Tue,  6 Feb 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212757; cv=none; b=eGQJ0zHzZ81I9TG/O2L4ujoxFQagBucY7wliSzxX5+xAfEDwBjcVJ7nZ7jRJsBETy+GN8k3NBKXn8GT+Xnu6NDGOGiOrFjJYT0k4ve600tAbZKE9n/Q9o7YN16YJKFy/2xTCI6xJcxs/dQfr/LfCHvE1y/IjqSrD182LdDMozI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212757; c=relaxed/simple;
	bh=wgqjFzC6wpBcy6cF1ZBRiJKqR9saGMFNfQ8Y3CoUsQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STZ40SCShM1qwUFxnXe/JpiZ7zK6Rj9rrabnh4SHHyZT4V1r2gz72RA5Ig93fvHbV+RFhkD3KqdsPcp6EPlpvXBhU9yzajFGGj+hkkEU4wKct/ea7d5XfkNjiPjrGa3EugtHhexqORorKwiawNL+SvD0J9tK5+a6U5mqW+xl45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWZCqv2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC2BC433C7;
	Tue,  6 Feb 2024 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707212757;
	bh=wgqjFzC6wpBcy6cF1ZBRiJKqR9saGMFNfQ8Y3CoUsQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWZCqv2qNQEeIFsRpb6wRuesw0FXjxvQ+eTD9QgMOAW+j8h64HT/MSoECyquYAxEB
	 iPsmKi1VcDi3VCXbsEBDQ3nsqKX39Zk89Vmb38AjmYDEO5g30E4WDBVNPtEL4I9s7+
	 I7ZLt7PqMOxTyJPwJM45tahyM22MXXpw0qL8dYZQ=
Date: Tue, 6 Feb 2024 09:45:54 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: make ssb_bustype const
Message-ID: <2024020626-oasis-reactive-2e1a@gregkh>
References: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
 <2024020543-footsie-unreeling-1cd2@gregkh>
 <87cyta9k8f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyta9k8f.fsf@kernel.org>

On Tue, Feb 06, 2024 at 08:31:44AM +0200, Kalle Valo wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Sun, Feb 04, 2024 at 05:44:21PM -0300, Ricardo B. Marliere wrote:
> >> Now that the driver core can properly handle constant struct bus_type,
> >> move the ssb_bustype variable to be a constant structure as well,
> >> placing it into read-only memory which can not be modified at runtime.
> >> 
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Greg, I saw your Reviewed-by email 7 times. Not sure if the problem is
> on my end or your end but wanted to make sure you are aware of it.

Yes, sorry, happened due to writing emails on a plane without a fully
working internet connection :(

My fault.

greg k-h

