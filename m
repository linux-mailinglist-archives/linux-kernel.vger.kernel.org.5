Return-Path: <linux-kernel+bounces-99043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC288782BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED407282E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B043AC0;
	Mon, 11 Mar 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxM2EHvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E644374;
	Mon, 11 Mar 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169489; cv=none; b=Tsdvzo+y40LFnVXjBhrL/NgJHrXDf30lk4KxrcpLoSm53rV0qZtx75Jy2EwnycHdCX5I1LMf3Io+0ndNz8xwUE30MVKDW04GF8k8rpcYJsynpetfuVqgo/WOHXohHgvb8CDvk4YchLuDU7fOtLhzODUtvzsEB/GM9pL5uFh6SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169489; c=relaxed/simple;
	bh=RIBzjNJsaIyrdNoB+PVFM7Kp7tWCLAuzeVlAvF5iU1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edrVT03EUzvUXou4z0OcHO870OHAxa7GscSprjwtg0jalpocuzqd6zos9lJfn9j35jfTPxPjYqCAfLNa7UyuQIq+FLz/Khg35hxkvfwrITgNgUGAMTKqSQqDokSRJJJbox55cZaBKgFGswRZMgsjNup62BGjv1NK2kc9SoTSt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxM2EHvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A62FC433F1;
	Mon, 11 Mar 2024 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169488;
	bh=RIBzjNJsaIyrdNoB+PVFM7Kp7tWCLAuzeVlAvF5iU1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxM2EHvxlvB0biN4SlXD0qaqe/bg1wHc/11dzlPiPrx4QL0qRKNhtjfXEx8f0sajW
	 0c1aLQSHC3fX06lMh+CQjPcuIn2ffOopYg4st+iezFYcgyv+aZo/eTcp482iAPAT/d
	 yQ0Do/VFMKovqAkaLxb1Wy1IosoXcTAf/US2SGqcCFOm4y5Nk2NV9TBWyKkMcB/YCl
	 7kw0vUmSNwhZ5buRWEtPTpYvQvd6nIvL/wN/B4tYMMlpQdV+Icw2DuMU7sBGCXD9vI
	 eTxV3IAyaXkTeR1P3H/xwsjqB3g4uDp0dr8tg/DyrZJnOk00QO59ipd4oYIuDls3EB
	 mtQYeuSGZYcxA==
Date: Mon, 11 Mar 2024 09:04:46 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, conor+dt@kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	sboyd@kernel.org, devicetree@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-kernel@vger.kernel.org, mturquette@baylibre.com,
	geert+renesas@glider.be, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 04/10] dt-bindings: clock: r9a08g045-cpg: Add power
 domain IDs
Message-ID: <171016948590.1185175.17223044706317662448.robh@kernel.org>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-5-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307140728.190184-5-claudiu.beznea.uj@bp.renesas.com>


On Thu, 07 Mar 2024 16:07:22 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add power domain IDs for RZ/G3S (R9A08G045) SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> Changes in v2:
> - collected tag
> 
>  include/dt-bindings/clock/r9a08g045-cpg.h | 70 +++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


