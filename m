Return-Path: <linux-kernel+bounces-88499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66A86E26D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0AA2852FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8F6D50A;
	Fri,  1 Mar 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPxXy0UP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01287E1;
	Fri,  1 Mar 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300482; cv=none; b=sgx56xxmfgYC3SspzVo8QLTE6eyo0/qhQKCMz2b/8SBQ4k2odrsTLKuwv/kdiRNzgmAB7eueSOvWF6rWLbm6WdDiwlPFozIu+TJspX3uRNOIM8uAehA2oSsG2KDFvLdXSnY17eu1zUTgN1nnXSV1TdpymYSzeRxGvw5X5uhtHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300482; c=relaxed/simple;
	bh=pExN1sblACqxlgvshQeznQXOXNWaXVj5ElQb1gjEI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTh1nHpnxpq2hTcjdHL6vA4/PLc0dcUPSFvjnUPWEpPZL0dQyEuykIrXl+OrS8N0VgIluuq757ednDMJm0FXQCsTB5jeUdTmgrF2qdkwM8KndNQI0HUODVd5csXQ09AyIeaNexrz0FBh0RNY00mfPQRbtGRuwV3XBiUwW2QllqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPxXy0UP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DE5C433C7;
	Fri,  1 Mar 2024 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709300482;
	bh=pExN1sblACqxlgvshQeznQXOXNWaXVj5ElQb1gjEI2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uPxXy0UPWdA8rdQuxfxWPvYURRAoP4/KCsggEa40TsfEhl+ev3vDyNTQzgW7r3sMz
	 UdTWjOCsM/e4sRGjP7+SHPxCS+Fk4HO99cc2N8UH8fTbB6TqsPp45hR+PgOjKmRHS2
	 fykuBAGWAH0si59BIMEtvVncVruf4k/Fv/aC5l2qIo5oAQ7fGDX97kpa26wGWQdnIq
	 fjVrwuGNbxGgNGyFDt+XGpwqO33JJDI5wGWgpiJ16X+CpoZ17DBx92ktWRZOmBBmnA
	 LaEHqApsKT1F7t2tDl2Z4C8B71rd9M2eFXXV011N+YnHiFZO5lrxDKCXi7AgUuwYm9
	 7ib8RYMKWycSg==
Message-ID: <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
Date: Fri, 1 Mar 2024 15:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Content-Language: en-US
To: Andreas Kemnade <andreas@kemnade.info>
Cc: "Brock.Zheng" <yzheng@techyauld.com>, Tony Lindgren <tony@atomide.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240301133809.0d26865e@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/03/2024 14:38, Andreas Kemnade wrote:
> Hi,
> 
> On Fri, 1 Mar 2024 13:22:12 +0200
> Roger Quadros <rogerq@kernel.org> wrote:
> 
>> Hi,
>>
>> Thanks for the patch but can you please re-send the patch in plain text format?
>> Please refer to this article for more details.
>>
>> https://subspace.kernel.org/etiquette.html
>>
> for my own education, can you specify against what the patch excactly offends?
> I see no html there and
> 
> Content-Type: text/plain; charset=gb2312
> 
> So what do you consider not "plain" in that email?
> 

I think I observed the same issue as Krzysztof. My mail client shows it like HTML
even though it is not.

-- 
cheers,
-roger

