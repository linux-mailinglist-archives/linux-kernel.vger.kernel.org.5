Return-Path: <linux-kernel+bounces-78630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE18886161B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697CE2844C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A8823DE;
	Fri, 23 Feb 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQjwj/f4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30282863;
	Fri, 23 Feb 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702990; cv=none; b=m1SpQYXmfsxfGjMgtmMYLiPlBCRjiwfp/IbYr9J/2zSNS8b3X+gOGdSmcsnBLNs3vDnT0k6Oo0O5lTDWKcw7mCzBgSHwIEiwswTPBy1xuAI1qzid4MGlCflgqw9qzN5A6HJqBoEBil5Zc8iMseJo/qoZZuyzl7pR67opZJM4ApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702990; c=relaxed/simple;
	bh=VulX/bEzC0bjQkYNIhonnatB3A8d1Ksmk/boghxkEaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSgNEn7kBgDQMyPrdTaxucjLWoY0BLMjfF9Dfn2ksYldzk2PcpUvMifThWnhDHOKAmc06aBR/scqwvtCp63EWvPCWM9c0AJmDI2f3JuqGfJzB+OlTwuzPLVT3mUELMQyxRDVxxbvzHtWHapvu6TF1KA+Ddqt9/fH5DqxC25Ex4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQjwj/f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A83AC433F1;
	Fri, 23 Feb 2024 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708702989;
	bh=VulX/bEzC0bjQkYNIhonnatB3A8d1Ksmk/boghxkEaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQjwj/f4dQ98xd0fo1xB7lPKHDUxOPTz4UCfTpUlcO3fbM2pMRC5mbsn5wYzc6rDD
	 51uWyKM+IuiVDK2E6sGleOjE4ZsaOJOa3vbCbt6v/wVzWTs31RQzHI/sTkgUqgFYb+
	 ZshFgXTcKhqqO79Bhqa8Ew3u7kv6xoTNcOI5ZyZlow+rl9FMGi/jQ2s9WopDWz6zLu
	 Minrw3mN+v7mOtl6EYUxzqQdocc5rHQ/+oxAX7R1qJQ6SMpOfdevtUD6Mtk6NrBwz4
	 JWRddU8W+MjeIH/6+bO+lCksqNglGMD34q1Vywql1Zj4a+UcKPQbhG1ycypNEQhhwf
	 mKz5ecVg3Su8Q==
Date: Fri, 23 Feb 2024 15:43:04 +0000
From: Lee Jones <lee@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low
Message-ID: <20240223154304.GE1666215@google.com>
References: <20240213-verse-clinic-e6de06e1f18d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213-verse-clinic-e6de06e1f18d@spud>

On Tue, 13 Feb 2024, Conor Dooley wrote:

> From: Conor Dooley <conor.dooley@microchip.com>
> 
> active-low was lifted to the common schema for leds, but it went
> unnoticed that the leds-multicolour binding had "additionalProperties:
> false" where the other users had "unevaluatedProperties: false", thereby
> disallowing active-low for multicolour leds. Explicitly permit it again.
> 
> Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low property common")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> I'm just assuming this is intentionally restrictive, if its not, we
> could easily just change this to uneval: false.
> 
> CC: Pavel Machek <pavel@ucw.cz>
> CC: Lee Jones <lee@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> CC: Christian Marangi <ansuelsmth@gmail.com>
> CC: linux-leds@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> index 5edfbe347341..a31a202afe5c 100644
> --- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> @@ -41,6 +41,8 @@ properties:
>  
>            pwm-names: true
>  
> +          active-low: true
> +
>            color: true
>  
>          required:
> -- 
> 2.43.0

Neither checkpatch.pl or Git appear to be happy with this:

ERROR: Does not appear to be a unified-diff format patch

total: 1 errors, 0 warnings, 0 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
WARNING: Missing commit description - Add an appropriate one

ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Check the results (hit return to continue or Ctrl+c to exit)


Applying patch(es)
Applying: dt-bindings: leds: pwm-multicolour: re-allow active-low
Using index info to reconstruct a base tree...
M	Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
/home/joneslee/projects/linux/kernel/.git/worktrees/for-led-next/rebase-apply/patch:28: indent with spaces.
          active-low: true
Checking patch Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml...
Applied patch Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml cleanly.
warning: 1 line adds whitespace errors.
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
Please commit your changes or stash them before you merge.
Aborting
error: Failed to merge in the changes.
Patch failed at 0001 dt-bindings: leds: pwm-multicolour: re-allow active-low
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

-- 
Lee Jones [李琼斯]

