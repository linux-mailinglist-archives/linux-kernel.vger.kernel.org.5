Return-Path: <linux-kernel+bounces-51569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B5848C9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C525C2828C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE91B5A0;
	Sun,  4 Feb 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utPpMcZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C41B592
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040651; cv=none; b=aXeNVnBAXq4Q+tCoCiySqEtQ/qQAXfskxL61swfVV09ebDcWVCBCDUlH++zEc+kveyBLJy42DhMziNCw26k6+Lh9yn0bBDlrZwn0duBqUWalGlS3ykfd3Tx0xaqqd9l0IN1zP3UvnipKsDDwx/PFoE7XO1E5Iu+u5swNXxP2+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040651; c=relaxed/simple;
	bh=1a/18m8aWACDG3JH7A3osAHapKeJBpsbrh6a8Bw7mDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDux02uAsnCiJjGE1ZIuJ5JpyTswd4/tVQTjvDlWAOcFUSXN5ZtZzmaRPmqaAI68/Ok26O/BAQ1UaUUpdw7gJeIRg2JG0OmkwmyCxhrE/cbzWpeofNltx00PRYAAUZLaxoAz9T5yKurri9AtqKzjc65DQpUpE9dSCzlzGLEy5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utPpMcZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483CC433F1;
	Sun,  4 Feb 2024 09:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707040651;
	bh=1a/18m8aWACDG3JH7A3osAHapKeJBpsbrh6a8Bw7mDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=utPpMcZSrIfJKn/VOqwSZid26sdGLBT7jLF7djuLRlF6NonziJBO34m66M8HW55AB
	 1zEZdExTzJ94IySse+rTvEaJF3P5WU+hITF2DIZckoEmPaLS2tcR4jIFSFZwJ7V7e7
	 eHB5RY1Aq9ZgMe4mZGAgTeAMSCEGt+d1iCY9rG+wWd4bp7jN11bkCKclsvIeiWjkl5
	 kZRSHe1A66BasJrW8nq32I6mX4BVaLXtxLUVxDTNjII8SBR8W279cw9Nkvm18JKFLh
	 rbgzGRooiouKV/N7TwrEXmGZtN308HEmWBTEvzg55d51H8yYIjBE++KIuccTCjzIeg
	 LlscORnplMkNw==
Message-ID: <22bd1968-5ab1-4f4c-843e-03e4b74d7023@kernel.org>
Date: Sun, 4 Feb 2024 17:57:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] f2fs: sysfs: support gc_io_aware
Content-Language: en-US
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 liujinbao1 <liujinbao1@xiaomi.com>
References: <3b2852b3d404ecbb53d9affa781d12d0e9ea3951.1707022643.git.liujinbao1@xiaomi.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <3b2852b3d404ecbb53d9affa781d12d0e9ea3951.1707022643.git.liujinbao1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/4 12:58, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Currently, IO can only be ignored when GC_URGENT_HIGH is set,
> and the default algorithm used for GC_URGENT_HIGH is greedy.
> It gives a way to enable/disable IO aware feature for background
> gc, so that we can tune background gc more precisely. e.g.
> force to disable IO aware and choose more suitable algorithm
> if there are large number of dirty segments.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

