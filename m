Return-Path: <linux-kernel+bounces-99042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE78782B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E51B21EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918741C79;
	Mon, 11 Mar 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RveneW4D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D164436E;
	Mon, 11 Mar 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169477; cv=none; b=tOi90olZNetIz/6EBvGkQWu1x6wRzIeTpXz38asNVdyTU1ZJGFap3czg+lAMj520yU6ab3QBTylxZzF3jQNfG824VFGGVno7YDMJPYMzpoqvrqTi56me261ec30LuKyzPVI1NQOpC2U8CTH6pgL5wZ/E8hSvE+4v6Z2tyxEpCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169477; c=relaxed/simple;
	bh=1ORzfxUQcsPCqavsnXA0PsDo9UtHxHz2dlTqD6ZhGMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSTqVXtNPI7Pg6N/NkgR4sqE+qT7iTZkaADP4Xa1+sJh4OEr4O3q4Bl7euZjlxx6Y8TApcugs0V+3lUbrZ8r3RUw51CTMn8pnPlriueaTkVdywh3//ZcB6Giv0wZQBO3vSvp94UnO5KaKJHbOHh87JQEKAiAMWVXbAVXkyfa6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RveneW4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B75CC433C7;
	Mon, 11 Mar 2024 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169477;
	bh=1ORzfxUQcsPCqavsnXA0PsDo9UtHxHz2dlTqD6ZhGMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RveneW4DzqzPQozuNVX5bHULUvl3Wb65x5gx+VwIo9/2Liix0Z7P2GmC9n5rN7acN
	 N6JuWNf//zdf6Pj8zHFDYnGK3fWiBTl6iJfkpzybk2NKU9YX3UoDHgvxlw6VU65V7m
	 2veY/sVdfyYtbYqYhBbnuyDoRWkBkNEI548aKEiO6kNsh/nlaSeqxZKgKjszH+tkVd
	 Yk5ZuCrIHjKb70Dcoo474Tt1oe2Wlgf9gDuilUbcYd5dfnZqWitrJbN/1KpprHbYjr
	 epH5BJfCQghTuPhbPM+aSs9opvyJtGAiFtjYS6OlV9VvhkGFbR6ar3Vuc3NizYX5WD
	 n1yBEhLnS6IWQ==
Date: Mon, 11 Mar 2024 09:04:34 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	geert+renesas@glider.be, mturquette@baylibre.com
Subject: Re: [PATCH v2 03/10] dt-bindings: clock: r9a07g054-cpg: Add power
 domain IDs
Message-ID: <171016946870.1184784.9293804876602382445.robh@kernel.org>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
 <20240307140728.190184-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307140728.190184-4-claudiu.beznea.uj@bp.renesas.com>


On Thu, 07 Mar 2024 16:07:21 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add power domain IDs for RZ/V2L (R9A07G054) SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> Changes in v2:
> - collected tag
> 
>  include/dt-bindings/clock/r9a07g054-cpg.h | 58 +++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


