Return-Path: <linux-kernel+bounces-110114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A1885A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932801F22270
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916084FAB;
	Thu, 21 Mar 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spA4CirM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A583CBD;
	Thu, 21 Mar 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029305; cv=none; b=iok/kPYjnFCZ3A0iPKKviCYelYI9IZAwSJOJcXYewOkB+9TdX0uIcw7jCVeo/4B+XLkmg+MUPiL9aiFefWfHO/H/cCGtEIAoZTooGNRCNt8MrvjXcmPLJhVAAiF3SRUMQDyLVQLVNpuQacX9dGmeT5Cir67SfFHctEDyq5NO6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029305; c=relaxed/simple;
	bh=4FopJU+JNO6LoIJxAvKso5OCBi4WM/l1hySE/+Jb+Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaPmeWpkZRzi/CbmrsUhVGRtm9XfiF4E2SYsj7hmE/HTDflQjUN5MBYf/TI+0mxZWMJHViaxPwjpBM95VDl3uIC+CWjoiikQ4hC2Fe0gNO4ttvcwD/xd1qXCiFMIkL3t++1/WnXCIYDG+LJTzpwNdfBsOIIxFX89vSzR4CsNZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spA4CirM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A17DC433C7;
	Thu, 21 Mar 2024 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711029304;
	bh=4FopJU+JNO6LoIJxAvKso5OCBi4WM/l1hySE/+Jb+Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spA4CirMMiU7BAJxyR9k9lEB/aZ6+SYz5kgj3tC9d0cOQxCClnnjeLbVK27Ji8U0A
	 Vl2Ly4Iuj82KAAbivyQ25HunnjDsL5mvYb1RxLGDx+mGqzrIt7GPPGltXgq13vu2bx
	 S7reJQaQGYFCoh1vRnWO/wytxIy2DuxBVseKP9DtnLba8D/Zrx/Dq0n0Ep8XNhmGlg
	 Wu0iYM6y2TYKalK1oK/xRuBmdJKYqTDdXELgHHEWOuUu9crA3/W2ESPZB0jZFfk5mE
	 U7VfJv9BqSFGurxG0Tg/d1V05ZlfsscpzsMrKpjRQpxdjisoftHmSgIyogM40zf4Ba
	 XQlk7bU3NV9qA==
Date: Thu, 21 Mar 2024 08:55:02 -0500
From: Rob Herring <robh@kernel.org>
To: INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: pavel@ucw.cz, lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for
 mobile network
Message-ID: <20240321135502.GA1637678-robh@kernel.org>
References: <20240320124431.221-1-musashino.open@gmail.com>
 <20240320124431.221-2-musashino.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320124431.221-2-musashino.open@gmail.com>

On Wed, Mar 20, 2024 at 09:43:16PM +0900, INAGAKI Hiroshi wrote:
> Add LED_FUNCTION_MOBILE for LEDs that indicate status of mobile network
> connection.
> As an example, "Mobile" LEDs on IIJ SA-W2 indicate status (no signal,
> too low, low, good) of mobile network connection via dongle connected
> to USB port.
> 
> Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---
>  include/dt-bindings/leds/common.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index ecea167930d9..d4b8498bde7f 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -91,6 +91,7 @@
>  #define LED_FUNCTION_LAN "lan"
>  #define LED_FUNCTION_MAIL "mail"
>  #define LED_FUNCTION_MTD "mtd"
> +#define LED_FUNCTION_MOBILE "mobile"

Why doesn't "wan" work?

>  #define LED_FUNCTION_PANIC "panic"
>  #define LED_FUNCTION_PROGRAMMING "programming"
>  #define LED_FUNCTION_RX "rx"
> -- 
> 2.25.1
> 

