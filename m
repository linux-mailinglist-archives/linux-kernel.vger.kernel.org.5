Return-Path: <linux-kernel+bounces-28433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164982FE75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EBF1C244E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DAC1C11;
	Wed, 17 Jan 2024 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uroewi8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7281364;
	Wed, 17 Jan 2024 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455598; cv=none; b=fKzt9VzIFN1AswjWv3KTPwWNPKEHIUz5+61L+nHqmZwOU1+Datd9Vw+Xa8AElkAuMCt4E3/vE//m6Py5U5bxMjI6K1S2vmiaZ8zcG1+3AgSAtFZK/0VirysEj3yUmTzsvcV36k6jNvdMYAxhTCz760KN7MBq8+RLzF2thkJiVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455598; c=relaxed/simple;
	bh=hB5y/sW8HV1tgJU/A0+/SWh13Gm4+UlTl50T6nVUC+c=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Tz5OhA9EWFjsts0blL26JYcCC1k0pSQAhpVzWBQaOgAQmryJRuBRyV5N5Cd6Bw/CcVStB4bwm8hmpHFFsNWOgbGuKYw96fOqhsHAExLVwq30+Jh5R/VN7EwcU5syQTCYRtXcclRk4Y/ODTJ5VttKb1l+2k3p0giC+PjSRKE6npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uroewi8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF358C433C7;
	Wed, 17 Jan 2024 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705455597;
	bh=hB5y/sW8HV1tgJU/A0+/SWh13Gm4+UlTl50T6nVUC+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uroewi8ID3Qa/HGdIFtJT6/HYztLLTCUqPizamPKcyEUTOvqhVE2I7wvTAlS6cRpl
	 IiPGiXZwgnKscyVw5yE3d5iy6AVe4NVZcY6ngaqBRPK1JeP/K9pxZEKj9qczMzAL0I
	 mhZE54/WOuJ/Hb0eIduGpdU9GVt0Plb/Vd4H2zTDWrHogY6+Yg1+zpGnDLrNpntmhy
	 iz+zoUfguuo+Q8UDVIljGN1jrvR7wczOmol8K6sRvQ7hXFppJBiAau5F8TEE+3Uq4q
	 uTxHZZnxny51lqBoe8fOqazERAiNeLkEY7YQtToHJp48CTdbCvXGyUUrCaw2eYtm1O
	 X/YrNoFqGthIw==
Date: Tue, 16 Jan 2024 17:39:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, duanqiangwen
 <duanqiangwen@net-swift.com>, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, bhelgaas@google.com,
 maciej.fijalkowski@intel.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 050/108] net: wangxun: fix changing mac
 failed when running
Message-ID: <20240116173955.57ba27f3@kernel.org>
In-Reply-To: <20240116194225.250921-50-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
	<20240116194225.250921-50-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 14:39:16 -0500 Sasha Levin wrote:
> in some bonding mode, service need to change mac when
> netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
> priv_flag to support it.

Not really a fix, more of a feature ennoblement.
Let's drop it, we don't know what it may uncover.

We should probably start complaining when people use 
the word "fix" for non-fixes :(

