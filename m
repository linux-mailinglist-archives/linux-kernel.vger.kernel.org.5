Return-Path: <linux-kernel+bounces-60872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5078850A66
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32201C21F44
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCD5C616;
	Sun, 11 Feb 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5DwrBVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2E5B681;
	Sun, 11 Feb 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670761; cv=none; b=ttsIPKvh2wq9Z6hAyjBAKEBRIPrzpnYN87dU6Zgy+LTcczXO5A06886Mjppfj1JQHUCnOSGqF4EbDiC7PgAwIm34/i5D+rJpnHW1mMm2aFFv/XtoIbxGqv+w7lgoK9sAZXQEQg9hGDLGi3z2eZcj7MQZ1hWjffVjiEPGml5WXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670761; c=relaxed/simple;
	bh=tWajLxkLpjlSl0BwK5EiC3LNBNa+4WaPAw7y0wd1l8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa+HKTxgMz1yQfSotdalOfebt+O/+FJDl6vksJR2OcAidzd2UfPT09OlC0xMgmSH8DALpGN22r9W+5RDL1xIP8OYqc5eutGvmrlorm5vLZGuv2Y/TK8xo+oMbjumBsDZPxJ0wpFj1FVep6G+CezishEAR3kwezMoLKk9QJ/M3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5DwrBVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF56C433C7;
	Sun, 11 Feb 2024 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707670760;
	bh=tWajLxkLpjlSl0BwK5EiC3LNBNa+4WaPAw7y0wd1l8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z5DwrBVs3ODUEJKweEzi7KzXcsU35NBQLN0UghwPoCdrHsExChYroeRjHKewaDXH1
	 CB2uai1YKRocCvrTWl1v2jCLqUWxV4jyBrw6FIiZzo0t7/Zpmw5fUvRIePArMxNDY7
	 8LSOHgk6AuJUpZ7xjZwwPYFfhFCEhk6s0Pk9r43lEZiOGLTzX7MrSJzp9HCAPN1XtK
	 3Ig3uuWlVtjMxj5fAf8OBmfVkCpol/61qWFW89q99xzvRTkWmvtH+jjbwEvA8REOoP
	 hAOwGvlENifvnrn3qv8wSI7m5i1hItU3jPyWWHMe8M83foYcSfrsaPUdgmm/IWynJq
	 dkFQrVGF1TlaQ==
Message-ID: <2880b448-2431-44be-94ba-32eb46526c66@kernel.org>
Date: Sun, 11 Feb 2024 09:59:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org> <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240210010129.GA1010957@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240210010129.GA1010957@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 6:01 PM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 03:42:16PM -0700, David Ahern wrote:
>> On 2/8/24 7:15 PM, Jakub Kicinski wrote:
>>>>> Ah yes, the high frequency counters. Something that is definitely
>>>>> impossible to implement in a generic way. You were literally in the
>>>>> room at netconf when David Ahern described his proposal for this.
>>
>> The key point of that proposal is host memory mapped to userspace where
>> H/W counters land (either via direct DMA by a H/W push or a
>> kthread/timer pulling in updates). That is similar to what is proposed here.
> 
> The counter experiment that inspired Saeed to write about it here was
> done using mlx5ctl interfaces and some other POC stuff on an RDMA
> network monitoring RDMA workloads, inspecting RDMA objects.
> 
> So if your proposal also considers how to select RDMA object counters,
> control the detailed sampling hardware with RDMA stuff, and works
> on a netdev-free InfiniBand network, then it might be interesting.

Response at netconf in September was mixed. As I recall Jakub for
example was shaking his head at 'yet another stats proposal', but since
he has referenced it a couple of times now maybe it is worth moving
beyond slides to a POC. The uapi discussed was netlink (genl) based;
driver hooks were not discussed. Perhaps I can get a working POC for
both stacks by netdevconf in July.


