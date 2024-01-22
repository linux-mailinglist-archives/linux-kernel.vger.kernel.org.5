Return-Path: <linux-kernel+bounces-32279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D283595A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB41F2108D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6857DEBB;
	Mon, 22 Jan 2024 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyH2fHqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45781D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890590; cv=none; b=SJiHhUjgDA+cXwrqkLaUPbaf9CSVDPioZHX0h6k9c3a2NKrheD5v8ZZL3qrFQVCwt1uzzn/1xjnEcJjiEKFTwlJMGKANvG8WwU0Dpnao3fcWsbhUq/noLzyIHhwWAyo8cI7irxrwzK/h8atrAjCkBvVGkj3t3x+yZQKlD2Y7Fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890590; c=relaxed/simple;
	bh=0ndaqSJHXHsabTfP/R6mMY5mO1aB0RONGWu88rSVFrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZD0vYcv8kCVXcz5mLLVfSIyl2JTtdxB6A9kCour9e91XXFcpF44BrqKoXtt3BRAnHD8HnD0yjkG/WspMJIns0UJdQyz7ohVb06tonZc5e0ULeXqSisu3t5lnNIpFcpTHhEXaGQjMuAbAAhVc9VLjjA7Z0S3+cA6WmUuKOvI6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyH2fHqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71701C433C7;
	Mon, 22 Jan 2024 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705890590;
	bh=0ndaqSJHXHsabTfP/R6mMY5mO1aB0RONGWu88rSVFrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VyH2fHqL4rtXTlbrKqV/CQAHPFjT+x/WLwXIbwyQKQNhdVwGHt51iPeZzfCGNRThA
	 o+6VzSOJyMw8EA/QImJG8pUKPuEz6yVsnLbEkWWkf8TEIt9oK/kJ1jozWQLYEKLbH5
	 9iF9axcOrGFdh6PR99rIadmHxZYTdcwtAv9bnvCTplHcpFe7tUPEP7jdesiFwGTP6+
	 g71G2NhIQF3ebRHvIOzOVgylT5vWDyVhTJOxr7TzbysPxcQ+xS9dHUpYrRdBOTKKVp
	 dPVy4UiJ18az2lyRbrPdnWFLpXsFv7oSrDrlZDCGDBQjBp/BOddtIVjl8Bj6TNjBYB
	 5w8HFJvJGOJRQ==
Message-ID: <20ad68dc-beb4-4de3-bece-95231135c881@kernel.org>
Date: Mon, 22 Jan 2024 10:29:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: compress: remove some redundant codes in
 f2fs_cache_compressed_page
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/18 13:48, Zhiguo Niu wrote:
> Just remove some redundant codes, no logic change.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

