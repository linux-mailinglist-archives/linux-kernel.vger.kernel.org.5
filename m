Return-Path: <linux-kernel+bounces-21398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25F828E98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D0CB247E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92473D98B;
	Tue,  9 Jan 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2NoOc/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE263D978;
	Tue,  9 Jan 2024 20:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDA7C433C7;
	Tue,  9 Jan 2024 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704833104;
	bh=dxbOah5qhckGuCtjexbByzLyR10EFPLNDjKXHhaM1Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2NoOc/q98kamAtjgKn+ZdI4U0uY0cjgfNR1+Ry/3Ph/U6N9Geyca4eMHDY6T7Fx1
	 N1lIoeqBuOzIdELeZc4BsNIhKLeQg8gg51zNyd30jrG4z2cN/rbg9vQNERCUzUwJ4x
	 teFuBGzwQUI7C0Fma3ng55l18GZKmtO0i9lmhBC1c494yrST0g8zJNZ3yldAsk3s3b
	 xlvJcc+ycvzmpr2RPbauM8DCjQx414+ad6YSjxnZSdNHMPP/iQSDJcE/HNvitETYID
	 xzzE19O+MeSfMriURndICd0VyQ34iZ+lxXE05oLlvLnSse/hdE361XxyJzKDO3BYDJ
	 lr0axrBqVeuPA==
Received: (nullmailer pid 3189911 invoked by uid 1000);
	Tue, 09 Jan 2024 20:45:02 -0000
Date: Tue, 9 Jan 2024 14:45:02 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Raul Rangel <rrangel@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 04/24] dt-bindings: power: Clarify wording for
 wakeup-source property
Message-ID: <170483310084.3189837.7384632761496015121.robh@kernel.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.4.I1016a45ac9e8daf8a9ebc9854ab90ec3542e7c30@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140734.v4.4.I1016a45ac9e8daf8a9ebc9854ab90ec3542e7c30@changeid>


On Tue, 02 Jan 2024 14:07:28 -0700, Mark Hasemeyer wrote:
> The wording in the current documentation is a little strong. The
> intention was not to fix any particular interrupt as wakeup capable but
> leave those details to the device. It wasn't intended to enforce any
> rules as what can be or can't be a wakeup interrupt.
> 
> Soften the wording to not mandate that the 'wakeup-source' property be
> used, and clarify what it means when an interrupt is marked (or not
> marked) for wakeup.
> 
> Link: https://lore.kernel.org/all/ZYAjxxHcCOgDVMTQ@bogus/
> Link: https://lore.kernel.org/all/CAL_Jsq+MYwOG40X26cYmO9EkZ9xqWrXDi03MaRfxnV-+VGkXWQ@mail.gmail.com/
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> -Update commit title prefixes
> 
> Changes in v2:
> -New patch
> 
>  .../bindings/power/wakeup-source.txt           | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 

Applied, thanks!


