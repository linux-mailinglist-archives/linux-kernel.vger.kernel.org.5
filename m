Return-Path: <linux-kernel+bounces-130502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BD897901
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F701F24B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F87E155315;
	Wed,  3 Apr 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtyrAN4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E716524DC;
	Wed,  3 Apr 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172537; cv=none; b=sAhzdc0v6Sy6gin28HdSDtIs5SwVNmAsQYOVwPi5bgHjUMFKg96jHG79yHAp9QeUP4r2mOE32x/6diRzJtTEMl/z1kvl66KKBW06C0MzLCf3cgx6G2f+hmtw7QbzagfK2v1Lvk6B46IoaYvGX1+lSfB2pwAEC4kYXlvWTuOeuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172537; c=relaxed/simple;
	bh=wIDvUumWu/EEWCGpQDOZb7IhXYb40cMmso2xgFWKTHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TE4Kj6nFlbATaUjfgkZxKECC4csNlPLXgI4w50mUWUD8S/6uODHHBAS7F8v6eEUbkyJGk4Hj643lpu8y+dKZfCLI85YN4Gc1e/n45+NxWbSnauFqR1BwwdLErTrOpRu+zsK2wR9R0NghIRKfKWdS8T2F2BDyFzWPM56uwVoeiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtyrAN4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C015C433C7;
	Wed,  3 Apr 2024 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712172537;
	bh=wIDvUumWu/EEWCGpQDOZb7IhXYb40cMmso2xgFWKTHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LtyrAN4FdI4WDUhTwLZovWHLjyrIHWDtABVsXdlAGf3KkXof1I6sh9KKqFI1yprVN
	 Li+qkwbNE4DvixivSVv2b2HmjWyPBaUPsWR//7y9OGFVzPQkw+wkAYQtlOn5FrFZum
	 ffHx54nXiqrawr7KcBe/I31XnMLnjRwNn74oBl0br5+Rsutna527WgAGxaw2Oyatr+
	 8IVQMfblxol0W6IQmK01Ln7CqwOu/BAHrHTmG24uLqqkm2yfiWyFFhxFSTb3Xpoo1Y
	 Ua9KC8GxGZAYVk1F2Z0F5ckEE4IfV+luLVNRU1leZAx2qj8P2fnhDCQoDt9Ld0SDz1
	 81vnVkjPWn5sQ==
Message-ID: <6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org>
Date: Wed, 3 Apr 2024 13:28:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240402184055.GP946323@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 12:40 PM, Jason Gunthorpe wrote:
> and, as Jakub pointed out, a second argument about who gets to have
> power in our community.

I think that is the key summary of this disagreement: this is about
power over what vendors are allowed to do with in-tree drivers.

Jakub is taking the stance that because the devices have use cases with
the networking stack, he (as a maintainer of netdev) gets a say on how
those devices are accessed across the entire Linux code base and its
various use cases. That the device can be used without a netdev seems to
be irrelevant.

