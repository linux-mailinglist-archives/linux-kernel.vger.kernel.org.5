Return-Path: <linux-kernel+bounces-92568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16BF872254
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B511F21BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A5126F3E;
	Tue,  5 Mar 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqacV4E2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED76126F1C;
	Tue,  5 Mar 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650935; cv=none; b=eAIiSsbamXfaVJMoae7E1DHDxYCJMBJYTuv9vcF8E8FkBF5cfpC8nmy6N1GQ5MMjpfak/crLPvChiNuXWjEga7bKHrIdqRC6/XiEraSwz/uZkaH/v1KB+KU0E05oBQYj5rXwnKSMlavrJoTOWRaITjVu6h0qViYjdyahuNmih1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650935; c=relaxed/simple;
	bh=nSWWFkWZffGoNnwURXuRLdlN9U+xWXsWoTFoIqMgRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAxYUuBVmWQql+L92EdODiva5deKVTwn9fsX72PJmVAtI+1o0b5LWPnQ2Rp+8/swoPlaiP3D/OYA3FlgzON2OXIdcvT3xyR47oyer6tZ3qkAbZZ6CjanYj7garT7OSy3NFfaJ1iencKPtsVgfEvRv46OaTS1SlS5BhAHN8UXtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqacV4E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4680C433F1;
	Tue,  5 Mar 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650934;
	bh=nSWWFkWZffGoNnwURXuRLdlN9U+xWXsWoTFoIqMgRzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqacV4E2mAX8m3kka0wAt6DmLzjGVM6T6dyx3YJTi/F6B1PdXEtyvh2xhOdM5hZ+2
	 NjKyuS5tMldxYOwyzMqTUurifImY7x1ztuV23+TPmycCLZs+RUCCTZMRRpY71TrA41
	 MHTvmukwB8MI4oerUbbRswcZV/kgsGMhSHeENeny3oR+5y3M9GGF6wofhqrV0HClFU
	 9wI5H8cn6/nzbjNfSi191lRDVWRv87Dau5c0q4qkgz0BGjsTxu8k1ormRV7GAVR+ld
	 KUQbiJjaksVsIj6rzdT6/bi/waIC5WVYGICmc4TciR3zzOrLDzXlVpZRFJ9ull2TSF
	 yZt3Rf0vyGk9A==
Date: Tue, 5 Mar 2024 09:02:12 -0600
From: Rob Herring <robh@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: dmitry.osipenko@collabora.com, heiko@sntech.de,
	linux-kernel@vger.kernel.org, nelson.costa@synopsys.com,
	kernel@collabora.com, sboyd@kernel.org, mturquette@baylibre.com,
	conor+dt@kernel.org, hverkuil@xs4all.nl,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
	p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org, jose.abreu@synopsys.com,
	devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
	shawn.wen@rock-chips.com, sebastian.reichel@collabora.com,
	nicolas.dufresne@collabora.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Define reset id used for HDMI
 Receiver
Message-ID: <170965093218.3352342.18143623274015359038.robh@kernel.org>
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
 <20240305123648.8847-2-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305123648.8847-2-shreeya.patel@collabora.com>


On Tue, 05 Mar 2024 18:06:43 +0530, Shreeya Patel wrote:
> Add reset id used for HDMI Receiver in RK3588 SoCs
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v2 :-
>   - Move the dt-binding include file changes in a separate patch
>   - Improve the subject and commit message description
> 
>  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


