Return-Path: <linux-kernel+bounces-55435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882F84BCAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26841C22DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70013AEE;
	Tue,  6 Feb 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtDefJ/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827A13AD1;
	Tue,  6 Feb 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242842; cv=none; b=uWNu/XHEVYl//bXVV9kOdwXrIVPfjXbyxLbTZQ/YI3sRfxM6g3iv6TAeK22j1EhxBMcrFjS+13M1QWUMMjTbXjCAIrnBW18myrqH/pVaXGsG8oxlG2KZvhUwMxs2FELCbylmXOrdeqmNuE9wc5XJJl8KU0cdmxkfIaMlCRf+eB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242842; c=relaxed/simple;
	bh=Q1RoYDpuKUXHxF7O/J6QM7CFR2u7d0pLuQ+ZSM1VApQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=m/h36zVtcJm5ngd+0bq9D9IVuc6UDNnl+omE6Z82qu+Hz6rXVZ1dQUuhbAl1Y4nSnBPDfyPNkdSWENqSV4TkUM6W/JhJVHyC2839z5Yhpn99cY0ptyHMDMsIZWABwDFbQbQvFCn5JR8iXc5MkQX9wApdsf2E7LULlL7aRRxMxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtDefJ/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6276C433C7;
	Tue,  6 Feb 2024 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242842;
	bh=Q1RoYDpuKUXHxF7O/J6QM7CFR2u7d0pLuQ+ZSM1VApQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KtDefJ/k2v/SRvAr6TiTVzLMDR1HNk4grA6lJIUZRKbRa+62NgfRDpedv8BbUxRsU
	 c03u6ft5p4/j0aqHJiUHIgYKh4ALPG0uYmYUIuCd3+Ne/+a8WQi380zUClUtIcbaIh
	 eIgRRS8iupRUbHl9vDrYo13ldVHSeXRJbGA+a+lfyz8F3WxXodVtwAmVHVK57rYGFO
	 npNY2yo1ccJKyK2+pRd2+1tJv7ojxIJWv+42ciDumQEy97H7pY0+urBZzgIE45JcB7
	 RYpfLJ9HggKzKA9z4ufgVlhvDz0t+fl7r4NCvPmGuYXnTcyMJf/PqwtI9dN5recyzL
	 isE1nKmQV0d9w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: make ssb_bustype const
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
References: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724283862.1979906.3166260702702806272.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:07:20 +0000 (UTC)

"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the ssb_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> Acked-by: Michael Büsch <m@bues.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch applied to wireless-next.git, thanks.

78092e68557b ssb: make ssb_bustype const

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


