Return-Path: <linux-kernel+bounces-35040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B88838AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8881F23372
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF485C8F2;
	Tue, 23 Jan 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJdMncaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22535C8E2;
	Tue, 23 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003394; cv=none; b=K++U8XaEVJ8UsFJQYFLPtElFu7NMYPDxnCaILy+jf46F/e13dpRVwwBE0h+YzIh2Qygei6y5seqxxHW7Uf/FmTb0RgU8aVOaJYkDbadOP2UtLcGChZYfV8vU3qMQkvf4/gbc7sooGN5vvX2gKqkznW4LUh9dqkklLxeDkw9/lwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003394; c=relaxed/simple;
	bh=oafaka+k/YuoznuEZx2paL1IH8gYbOVl6HqzshxYwjY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lIZdkVHEUN0/+R/6AmXwwKoi/FRjtK1qC3KTtjbZlmJfN2OnbeV2oFDofYF95I+VzrSDlXElTB/5zvg2jSpGdHndIUbCONvx3WwaegHaM1EhRFXW4HZI9L9G2F3DwNFUDZ3XAiZTOsjQi+1+JRu1lbs/ZCJO94JdD12Cfj1fwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJdMncaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A8AC43390;
	Tue, 23 Jan 2024 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003394;
	bh=oafaka+k/YuoznuEZx2paL1IH8gYbOVl6HqzshxYwjY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WJdMncaH+kZziw373npdlH1RQ6Hc0KnLc6REKh0KtUydYVlo2JuNDBoGokUUv1HYh
	 eUtDmC/87IXt2/JKyOXchq9UXvm454k0ZRlDg95V5GFncsUJxEfXKEWKRH4AZ2O2zj
	 momePPCLBX0zvmzLy8GrAE+lH3nOkFahU9ZAV9TTE99Ic9l5OBhkyp9aXKAslfMJK9
	 9Kdq9m9DgVkxMSFhdB6LETIhY/cBljEjSWuS3jAqRxRiWElnBJd3gpsbamFhd69zoM
	 0qonF2A57DFei8cA8wib6ba+fPv+kxDPu4R4qcwCRPIChFFaDnEPrdPmPtaPU4TZpj
	 NBSPzeJafY31w==
Date: Tue, 23 Jan 2024 10:49:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "sandeep.cs" <sandeep.cs@samsung.com>
cc: 'Joe Perches' <joe@perches.com>, 
    'Benjamin Tissoires' <benjamin.tissoires@redhat.com>, 
    gaudium.lee@samsung.com, ih0923.kim@samsung.com, suhyun_.kim@samsung.com, 
    jitender.s21@samsung.com, junwan.cho@samsung.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix
 the checkpatch complain.
In-Reply-To: <020e01da421f$c0d20660$42761320$@samsung.com>
Message-ID: <nycvar.YFH.7.76.2401231049150.29548@cbobk.fhfr.pm>
References: <20240108091917.1552013-1-sandeep.cs@samsung.com> <CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com> <20240108091917.1552013-3-sandeep.cs@samsung.com> <486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>
 <020e01da421f$c0d20660$42761320$@samsung.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Jan 2024, sandeep.cs wrote:

> >> -	} else
> >> -	if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0 &&
> >> +	} else if (*rsize == 203 && rdesc[192] == 0x15 && rdesc[193] == 0x0
> >> +&&
> >>  			rdesc[194] == 0x25 && rdesc[195] == 0x12) {
> >>  		samsung_irda_dev_trace(hdev, 203);
> >>  		rdesc[193] = 0x1;
> >>  		rdesc[195] = 0xf;
> >> -	} else
> >> -	if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0 &&
> >> +	} else if (*rsize == 135 && rdesc[124] == 0x15 && rdesc[125] == 0x0
> >> +&&
> >>  			rdesc[126] == 0x25 && rdesc[127] == 0x11) {
> >>  		samsung_irda_dev_trace(hdev, 135);
> >>  		rdesc[125] = 0x1;
> >>  		rdesc[127] = 0xe;
> >> -	} else
> >> -	if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0 &&
> >> +	} else if (*rsize == 171 && rdesc[160] == 0x15 && rdesc[161] == 0x0
> >> +&&
> >>  			rdesc[162] == 0x25 && rdesc[163] == 0x01) {
> >>  		samsung_irda_dev_trace(hdev, 171);
> >>  		rdesc[161] = 0x1;
> >
> >For this block, I think a rewrite using memcmp would be clearer.
> >Something like: 
> Okay . Thanks for your valuable feedback. We will promptly address your
> suggestions and enhance our code accordingly.

I agree with Joe's suggestion here; are you planning to send v2 of the 
series?

The rest of the set looks good to me.

Thanks,

-- 
Jiri Kosina
SUSE Labs


