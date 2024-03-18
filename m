Return-Path: <linux-kernel+bounces-106131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24987E992
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC6B1F218CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934B37141;
	Mon, 18 Mar 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YReeFoj7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814638DEF;
	Mon, 18 Mar 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766190; cv=none; b=XnPFpe3mFKRMnfFjRzInvutlqWn8WRLx6PSpd6d2ygBao/yRMaslQEOXio0PFDetObyX1pWu/B6vI7xvNrvnojZE+DQM4KaNOLBC4gTn+vaPbAFvir1A0erSKjxJq6/QM99OUIuXNdGd8TPrCdI7FPMQG8Gc9qkECDFulKtFvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766190; c=relaxed/simple;
	bh=pnw8L0MNVMd/tH7o0U2AgWQ3mCUlzbF10paSUT8SIv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub9eMFcUHMe+tzaudSQtDmTjn4uCRs2ZrGhJQmxHRdOSO+qwV0dLyEzmaSI0l74hw8BJTNsGn/bc3XYkYR/Nx9961TwpoBqI1ssIv4SuNss5p9ymNJlJUkNK5eTX1KZrjqmyZfCZZJ8JN8mlmN7oD/YI/DbNFOfkcnkLnFxfYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YReeFoj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B7C433C7;
	Mon, 18 Mar 2024 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710766189;
	bh=pnw8L0MNVMd/tH7o0U2AgWQ3mCUlzbF10paSUT8SIv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YReeFoj7iZ3Ac+JFI1bQFdZ7qayaK3YaEXbMa5iR17TRY+jcv81UmRFr0aE9OMkoM
	 N5LohlmVpmugJo3nzeci1EQUz3XZXJ5+hja9wIEO58fiA6jwwQzaw0j+qeo08or022
	 wOSkQ/Kuv9YNvr41NbKAWf8d5E3m3r+Ss88AkkD3jq2taoje9+sNNmjTv+wVZvKHLu
	 OVmwaiqHZCkF25GztQzHu9S95r7y9tFAXn0jRCCAaAzHMZh5FyPe9phEpNio6bWj6/
	 L43SnZTAEBTBAFrdPzGgkotyaEb8xb69kPlDl7E4G28QxnDXR3RVPMMzJTgHPVgZFz
	 KLmYoatt4cX7A==
Date: Mon, 18 Mar 2024 08:49:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 1/4] x86/mm: Move is_vsyscall_vaddr() into
 asm/vsyscall.h
Message-ID: <Zfg4a5Y1UnFO3O1m@sashalap>
References: <20240229204208.2862333-1-sashal@kernel.org>
 <Ze9zol7kZucywfOy@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ze9zol7kZucywfOy@duo.ucw.cz>

On Mon, Mar 11, 2024 at 10:12:02PM +0100, Pavel Machek wrote:
>Hi!
>
>> Move is_vsyscall_vaddr() into asm/vsyscall.h to make it available for
>> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.
>
>This seems to be just part of a patch -- it does not move anything --
>and we should not really need it for 4.19, as we don't have those
>copy_from_kernel_nofault_allowed changes.

Yup, looks like it's not needed on <5.10.

-- 
Thanks,
Sasha

