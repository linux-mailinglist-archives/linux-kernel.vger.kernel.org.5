Return-Path: <linux-kernel+bounces-146670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5B8A6903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B064282C59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A3128828;
	Tue, 16 Apr 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps13Ao5p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9012839F;
	Tue, 16 Apr 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264640; cv=none; b=fayh7vSNNZMos14stfsNTU/+EXqnJcww1ER3DGKLEcpgD8l1oeUBdylaHFltb1gbEIGW0XmsUablDsbWAsVICWt8bdr+dijFpe7QiBr/9QbNMv5MdusWYyWOBAa891DmRSbzekyyveAocy5Mnpr4GraFDmAMyri/8AJQDgjyz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264640; c=relaxed/simple;
	bh=VGTWG/vBXuvEV6+9ARdx5dcmf9g+Ly8+3/hYzr+P298=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmUKUOJzmHP9jKzn5ZfLTZGVHXOocq2xdVcgT//BR9v95CtlMGIjOc+5nBqwNUrwWyaKh89ey74pHmX0rSnBYYJjyJn/KSdTEl/m/L2FaH2qCIcLCUkTB7hLyAKjyhixR/1X1OZxGknY5kJmngFugO/RfOvry1rMVsCqTn0zeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps13Ao5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F98C32781;
	Tue, 16 Apr 2024 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713264640;
	bh=VGTWG/vBXuvEV6+9ARdx5dcmf9g+Ly8+3/hYzr+P298=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ps13Ao5pwl8TlKtA0SIwrc2SVatH/m3sZ3saWl8UF4seBT09fcZQuoJeQahJ8n3Uj
	 KUsvYAFV3iBuPf7uhV8lNADankMUUc8iuv3RMTY8iwvY6ZznkS5Km/ytLLxUHV8JKB
	 fkcwzo1MQAzm4wcWEPBBhh5m8FsgozyMhpQ+46VNm9132P8jOF0hBq+SxHNKmgsLCC
	 EuWEPlECUaDSxcqu/9vUCdYVKMTHKqpN8pRFX7TDdNEwPAG67LhvVczNxfiICc9CSG
	 pyS5q3+9KDDG8NlKk54mFIaAwOdpLSNVtW4ebJgXkqqqJrfVc8tG5eqllLiDK1JaAN
	 l4TL8CHPAf5lA==
Date: Tue, 16 Apr 2024 11:50:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: elder@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net: ipa: Remove unnecessary print function dev_err()
Message-ID: <20240416105035.GJ2320920@kernel.org>
References: <20240415031456.10805-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415031456.10805-1-jiapeng.chong@linux.alibaba.com>

On Mon, Apr 15, 2024 at 11:14:56AM +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because
> platform_get_irq_byname() already prints an error.
> 
> ./drivers/net/ipa/ipa_interrupt.c:300:2-9: line 300 is redundant because platform_get_irq() already prints an error.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8756
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Hi Jiapeng Chong,

I don't think that you need to repost because of this,
but when sending Networking patches please specify the target tree
in the subject; net for fixes, and net-next for other patches.

e.g.

	Subject: [PATCH net-next] ...

That notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


