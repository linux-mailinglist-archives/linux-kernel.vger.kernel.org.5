Return-Path: <linux-kernel+bounces-96707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFC876057
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5AC1C225C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14451C5A;
	Fri,  8 Mar 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDrrbjFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C12C85C;
	Fri,  8 Mar 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888074; cv=none; b=Ft1v5UuirTP0QVqqdvbREPXyZ/GZBSK+IZIZ+VJS4NfmQLecIeJZIvru6ZE26FsWDzoew3wXVaR8rLx9007Hhs3akojYPRdqWmIYEKtjPbhdfEAoDVo9rwMAGi4/nL2CSaq2oFa16O7ya6QbpnMRvH6tM0p3e2aRAZL+x3raUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888074; c=relaxed/simple;
	bh=moZkvF0tm7ypsU/YxEwgD/VcLzXyep6t+cMV1ld2+Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3xZ8xq5G0aTDC4jZ5wHf1Kw1aVj4hQKBpsdtEMzsJo+uR/zFUldjA/3PFUqiEkqv5Wp6dQ0r2tIZTjWMJDQQjD8TcOqWM1LPR0vIO410N10a+eFHn5v6oynBlkV8Dk2UyckdE8LEMTVjLPY+Z/KbYad3Ue6arrbSFvB5ApOeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDrrbjFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF038C433F1;
	Fri,  8 Mar 2024 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709888074;
	bh=moZkvF0tm7ypsU/YxEwgD/VcLzXyep6t+cMV1ld2+Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDrrbjFQpLUh+c4lODfo1NjJa1uaaJYat/ShQ9q4dPxF+1kFWT60KjR8R5IT3sDcA
	 pwniwGxKvaXvodewWNYrXI54N+OWKdAjvEJpSxzwUp8HaTHGtzdVNc5MZmOx12BDo8
	 2eGJiClJUHRJZYktsBFuYAT5qjmDn2TZ3BpzZpuE=
Date: Fri, 8 Mar 2024 08:54:20 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.9-rc1
Message-ID: <2024030813-doormat-swiftness-1bce@gregkh>
References: <ZerHovZ5jaE4NcWj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZerHovZ5jaE4NcWj@hovoldconsulting.com>

On Fri, Mar 08, 2024 at 09:09:06AM +0100, Johan Hovold wrote:
> The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:
> 
>   Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.9-rc1

Pulled and pushed out, thanks!

greg k-h

