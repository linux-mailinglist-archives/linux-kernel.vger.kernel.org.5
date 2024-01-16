Return-Path: <linux-kernel+bounces-27763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027882F57D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017CF284973
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BCA1D540;
	Tue, 16 Jan 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0xBrptU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9061D52B;
	Tue, 16 Jan 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433862; cv=none; b=gs4JX7uI3cFr16dIqtP3aFi+mmTKHRv1BZmLs6FopXCk2U9vHWresRNkqv6xrb2J8tHOJgVc05mRSYsvPhfWOSfOQ81bZyKS89NxjYJI8rzemEEajZk+oii739cf8GarKFpO3Oaw3R5ZumrocstebHDDP7LQpdoY6JOTNbVc9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433862; c=relaxed/simple;
	bh=XdQ7WzNDKpvau3vdk/AGXntBjvVQmDV/vPmkgieP+Jc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=OfWrvayl4S+QD9/C7W0bKHV/LlLQySpo1hQJX2hMTmFYSPwlgYibvYUfnrXhtceKxqi49gOaCL7TpG7KTVAc5cP168o2SJLzJyPdbUGIFzYGCFEBi/aulAbz6ihWbiFVUrAz7NSCXIWhq7dEWGb2ezgWSYxQT9pT7iV34LMMB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0xBrptU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E4C433C7;
	Tue, 16 Jan 2024 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433862;
	bh=XdQ7WzNDKpvau3vdk/AGXntBjvVQmDV/vPmkgieP+Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0xBrptUbFjR4G7MCXOtysXoOyrc51Rdo5evNHTPRyqIDytxEJrJ7T2QmovRO2btS
	 EuNRGQ3Bp+ABBrwayhX5AwU67o0Ag4sVZ5sWLKTkWY8tu2qVkTQ9xPXAEf02r6LhCx
	 1fldhny+tCKfC+0XiM0h3oAr76i9lKiWhrfhzCvnpUWN6mZqKog8O7p3n92PgXkXwO
	 a/NFAHsoJT5YrJl1+JgWvWprZoJtHBBhWysHd80fzkk5ebNtaStm0IXXUnBA9lC6xp
	 JcBTHNt8hxd8FyFPyoMIJst1bkfyVDAs/2LboJXhPSFrgoRRoVOn7drq/kx3a0Gq9/
	 5kTqM0Lrug60A==
Date: Tue, 16 Jan 2024 13:37:40 -0600
From: Rob Herring <robh@kernel.org>
To: Tim Lunn <tim@feathertop.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: rk809 fix compatible string
 in examples
Message-ID: <170543385965.291741.2100641423770592209.robh@kernel.org>
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-3-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116084618.3112410-3-tim@feathertop.org>


On Tue, 16 Jan 2024 19:46:17 +1100, Tim Lunn wrote:
> Fix typo in the example specifying wrong compatible string
> 
> Signed-off-by: Tim Lunn <tim@feathertop.org>
> ---
> 
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


