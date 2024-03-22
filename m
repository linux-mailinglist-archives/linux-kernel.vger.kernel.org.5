Return-Path: <linux-kernel+bounces-111698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A4886FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1904A1C21DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA55101A;
	Fri, 22 Mar 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K44jhEqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E64644E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121071; cv=none; b=pgZBreQuEN7Wlh6pycceKMjdsBStErMqHHATAWyS8wewjqD7LlIWf1FWaMMgWozY+rd7096vjf3s0mmHguDnMRKzU1PHIKxhEmG/7iO0wL+bP0NLLKW+gTrhd0NDUffXJEO/GuBEKX3ynUuNvg13bmpdJJipZHVjeUi85jbOV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121071; c=relaxed/simple;
	bh=4bc612VXAc2AsZ+PgolgNOWHPmU2xA/cgSPzznX2uM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kitHjcLfSUwDD4N6zpvXfH7Y2GS0LQTIYB9utrCNFIsEJ2xfKC00r6AC++NSyHq/Ufl59FUOWkYGb9a6mIcjzjGQY5W2/omZ+wRkczAOpT8Kv7Ny2i857oloDIofMhBb/33qHGWMVmM/3Hjw7m3lvBgFrcMLqo8bP8QEYw0NkEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K44jhEqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84319C433F1;
	Fri, 22 Mar 2024 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711121071;
	bh=4bc612VXAc2AsZ+PgolgNOWHPmU2xA/cgSPzznX2uM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K44jhEqd8bJ9sYinHvEMd/RC1QM0zVPGp01f/wHFtqkbTX+ehXRjV16i6Ej+xoFRG
	 HAWrbE7Oa9wMv/Wzz19tVUYe01xIMDXTAq/424Vcvzci6Bu5f3EBbdHftwZEe0ajCK
	 Y13k1gpjHWPxQ3PEGBTI/3sBSnPq7P30l/H2Xp1ZSyU60TokSuBFJ8ueWklkcp6j9C
	 L/Oclp1UxDkYc98ELPeO582Sf3EQ/BEqrWL5K08uLJo4Up5/fYjfI5wvBJeS0m7k0V
	 mpZPfKaWsw1T98xname32MagwKBYxh6jxECDgh/YqqcSc/qxN4QnGJMAzi5neOo5fA
	 2HPns8vMNH/RQ==
Message-ID: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
Date: Fri, 22 Mar 2024 09:24:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com> <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <2024032248-ardently-ribcage-a495@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 1:32 AM, Greg Kroah-Hartman wrote:
> 
> It's the middle of the merge window, not much we can actually do and
> this patch series itself couldn't be applied as-is, so it's hard to see
> what could have happened on my end...
> 

The proposal was sent a week before the end of the last development
cycle, and I believe the intent was to motivate discussion around a
concrete proposal to converge on an acceptable solution before sending
patches.

On your end, what would be helpful is either a simple yes this seems
reasonable or no you don't like it for reasons X, Y, and Z.


