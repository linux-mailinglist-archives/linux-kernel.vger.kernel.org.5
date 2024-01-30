Return-Path: <linux-kernel+bounces-45312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDA842E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842C41F2488E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64086A02A;
	Tue, 30 Jan 2024 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgAo6Y9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2355E57;
	Tue, 30 Jan 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648738; cv=none; b=qsmTW3mNVXH0raYDw5UweA5wIYuQstqZfp6OTzqOdxXLMtDcxctUvp+KZ333zt2wzL6CUhkFmenokjLUkiT/EBANTO+QW9i3NNBuktRFUZcwPXVshoZ8jVL3SDIREOJRSyTCPjkUuLwAL3oJsY7mcBbhQwFyh3ebVl5xBFzSTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648738; c=relaxed/simple;
	bh=ZOjytVEzrFk2XHjiQxQdUmGqDFYMmh735tgNNxhSuio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2JZdKXmnynUFDegouBwu9obCYUUWHg2EObpMtUiu3O+auY6+lBGsf2OPRpfYf1HUdLRCvHU8NgOB9aDOj/+1RDwRUb4wZt+uikDWSL4mlgWkT2tdMiiUnO2Z8jKnkV/1skDXkKkAvxx1ImpZZaqWFqFH9werwrOE4mKtRAvQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgAo6Y9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A468C433F1;
	Tue, 30 Jan 2024 21:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706648737;
	bh=ZOjytVEzrFk2XHjiQxQdUmGqDFYMmh735tgNNxhSuio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgAo6Y9+sFPZbz49IZLliTD2XE69WII7s9CMV1loCchBHzoiH81ChCJi6WIPT8ck/
	 hCn566bWXCYhpbPbqNJcyrUduS2720oJxLMDTxU3Y1f/mjGn5lrYpf6CuRygTcjOKC
	 2R2b3iuIb+aDcn2BHTMUOvX2yBF/ncjE4TZ4uE2f/ctnn+DcqBfeRMs8M8p8+MPbxA
	 MD7ts8l8X60CdWK5mGtQdJfjmJNJrm3unOsHtQDiPLEJlVf6AwYwYE6OTprBOnQpFb
	 azg16I12z4ayETCtrBHWj9wbCRV6OVD6/EtH4TLWcDTMhZHY7EWTNvEA+Ql8xrQzRE
	 PcwG3kSwUTkVQ==
Date: Tue, 30 Jan 2024 16:05:35 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	bleung@chromium.org, tzungbi@kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 5.10 3/8] platform/chrome: cros_ec_debugfs: Fix
 permissions for panicinfo
Message-ID: <Zblkn9lNZXQUQQuc@sashalap>
References: <20240116001457.214018-1-sashal@kernel.org>
 <20240116001457.214018-3-sashal@kernel.org>
 <Zabq2PKJwsllm9zk@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zabq2PKJwsllm9zk@duo.ucw.cz>

On Tue, Jan 16, 2024 at 09:45:12PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>
>> [ Upstream commit 0706526ec7704dcd046239078ac175d11a88a95e ]
>>
>> The debugfs_create_blob() function has been used to create read-only binary
>> blobs in debugfs. The function filters out permissions, other than S_IRUSR,
>> S_IRGRP and S_IROTH, provided while creating the blobs.
>>
>> The very behavior though is being changed through previous patch in the
>> series (fs: debugfs: Add write functionality to debugfs blobs) which makes
>> the binary blobs writable by owners. Thus, all permissions provided while
>> creating the blobs, except S_IRUSR,S_IWUSR, S_IRGRP, S_IROTH, will be
>> filtered by debugfs_create_blob().
>
>This needs previous patch to make sense (according to changelog), and
>we don't have that. Please drop.

Dropped, thanks!

-- 
Thanks,
Sasha

