Return-Path: <linux-kernel+bounces-128214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC818957AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2644E1F215CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BE12BF35;
	Tue,  2 Apr 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR2qyju2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781B138A;
	Tue,  2 Apr 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070154; cv=none; b=K1kCppnQpLrd9sX6C+IOJnXpyMahbeUEuNf9wspeTF6do0TgLTgfCJeM0tNps+td8MMFZ0gZ/SKNJdpJVVf2i87sP8OMwYLCs/aeNvGmYwtElPwXnqfMuLLRNdZyWBiZQt1XnC1cw6B8pebOdJvtS/DYQlQS4d/cwVxAXYxYjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070154; c=relaxed/simple;
	bh=YciNCD/SmOI+nte4r46sRXnbRMfaduXTUgvXEc/mGg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNb5vn0xB2pf/RA+wg8GvdH2b6SeYVVYECx87OSlOWTZU4Zxxo/iRQg0+OSe1VQXhcqTl7/GinmALVGx8aJZyQDFiAzjtSvJK6WdiYAybRseQQBd4OKH93lsTLOKONRiSGR1MqJ5IbxCVVQejFdt5Os6/GAJhli5C73y9e+8On0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR2qyju2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8464EC433C7;
	Tue,  2 Apr 2024 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712070154;
	bh=YciNCD/SmOI+nte4r46sRXnbRMfaduXTUgvXEc/mGg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hR2qyju2pdfL+HUyxiZN983AK2Z8Simucr7G5W3rEI1cVgN8zLEP1JWV7Kb6cQgx+
	 9QDQt2VfPEPLJ1vh0Aw2hFwD5B8CbGNXdo01J20YJlsYR2+0+vCfHZ/ydh5mDhWyBt
	 uVDCur9xl7euWfuGjBQ0Sqyow4k8EI9jerg+vNmHFUTEVtZG5Y7GWTWRC3B9IBmJpu
	 CidKXx5Dawb3NyoH9XK8tqXRYb9DWPTtm/o+FVMZp7bEv03dRRO/Rdnqc5Mwd7gOUf
	 yPPmoEPi2YpjOm6uowdJBLWKtojL5SMiqLkkJ4eddh1M1YVm+9Za9m+be3aW0C4Y43
	 NuBSarwIMYvww==
Message-ID: <2893a096-c07d-4ba3-85a8-db18616810f3@kernel.org>
Date: Tue, 2 Apr 2024 09:02:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: route: improve route hinting
Content-Language: en-US
To: Leone Fernando <leone4fernando@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
 <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
 <4bf87e9a-71a4-4586-a112-43f8ce20eb46@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <4bf87e9a-71a4-4586-a112-43f8ce20eb46@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 4:08 AM, Leone Fernando wrote:
> Hi David,
> 
> I plan to continue working on this patch, and it
> would be helpful if you could share some more thoughts.
> As I said before, I think this patch is significant, and my measurements
> showed a consistent improvement in most cases.
> 

It seems to me patch 1 and a version of it for IPv6 should go in
independent of this set.

For the rest of it, Jakub's response was a good summary: it is hard to
know if there is a benefit to real workloads. Cache's consume resources
(memory and cpu) and will be wrong some percentage of the time
increasing overhead.

Also, it is targeted at a very narrow use case -- IPv4 only, no custom
FIB rules and no multipath.

