Return-Path: <linux-kernel+bounces-46129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85559843AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBE1F29577
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974964AA5;
	Wed, 31 Jan 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODfvF77J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BC60B92;
	Wed, 31 Jan 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692948; cv=none; b=uLiH5vydtaUCxjcUjHm5nY7XOwutTl3vx5+aGL/2cyvm2YelJredUn9/RNnmFPD3avPvf2sDPpA/nOr25I22lTtRK4hrl8MxxQxEPWucBtf0rAyqOZp5uzO5kTqz2hwg3adsxE0f0qDNVR3zgbBXhOXSXIq2q4IZhKjTQY1pXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692948; c=relaxed/simple;
	bh=7uCNS8ZF/Auzjom6uu9TsSxTk/2Jclq1JY93w1lCN+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUvvVTcjwfZYVhR+pOhmP9yciaJLLqRUFZRhd1Bw/vOInSkiWd9UMB5S8cyD96FI/4JzRgUVCoh4Uy+njJWp5x64JYvFKJziV0+HwZB/vjsRPRkLSZHtcuvZOlvn4FKCNRWgfRCc/nokybmUGozl7eDFNDzsgGAG25Vr+B7Pcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODfvF77J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8658C433F1;
	Wed, 31 Jan 2024 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692947;
	bh=7uCNS8ZF/Auzjom6uu9TsSxTk/2Jclq1JY93w1lCN+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODfvF77JGkLF6m2DYd8w4dtVVoq8y4oQ3c0J7SinxA3QB2AomQRAFOb9+UqdhPq2n
	 +NCC8ZUPMnmhKSERKIuJPR7ImNcxNWZOmMREkoW0DjYB7JVj8XQ53C8KlWKC5vMWjY
	 scy7aeDWZfp0xqIDYC5Vr4flWWf9YMnrNkvHCzusXPZTmAtDQP0+mwY7SK+X5NN25X
	 +ReBfjRTJJkKlVsJh1phTx7fFkL/4toVdT81qjNRdF4Cx/zuek4vxvz8db/OASwgrB
	 8NsI0Ndq6T0y26CshkpiNMVxXX7EQkg8l/K5CxaqDEJK/cAsJx/KcIh1TtQylIIQ98
	 mL3o2/wkNC+PQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rV6na-000000005OG-07PB;
	Wed, 31 Jan 2024 10:22:26 +0100
Date: Wed, 31 Jan 2024 10:22:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Puliang Lu <puliang.lu@fibocom.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM101-GL variant
Message-ID: <ZboRUjTnovX871ht@hovoldconsulting.com>
References: <20240131091224.30064-1-puliang.lu@fibocom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131091224.30064-1-puliang.lu@fibocom.com>

On Wed, Jan 31, 2024 at 05:12:24PM +0800, Puliang Lu wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a3, FM101-GL are laptop M.2 cards (with
> MBIM interfaces for /Linux/Chrome OS)

Applied, thanks.

Johan

