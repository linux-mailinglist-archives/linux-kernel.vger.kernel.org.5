Return-Path: <linux-kernel+bounces-125979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCF892ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37610282399
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FA8F45;
	Sun, 31 Mar 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0K703y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA1B2F3B;
	Sun, 31 Mar 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869445; cv=none; b=URiIMmqg3vMhLCPF9eYcYfECIz/8h5qgSKfXojPEbiMli8G+bUo/fvX+lpBTbj1aiH6CQwQL8dJ9zccFG0cRs4yQ78oxewAc8GoS1DOzxry8qIkhR32aH3L2Y5e56mzkzMppb4FroBqRcSkFdb2MJDtesr3JMLzmvyK9GK9RJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869445; c=relaxed/simple;
	bh=ynEEvfZfM0Uvl7G9oYl7YDpYAQvFFwcG5qLQbWzN4Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkMeU64h4ZoduPUpE2whIoVclOwTuvDkOHkdrsJluCMckqV/Hp3rCibkHe2G7zITGDVL11AX2aPyFk/UPaLsyRdoizg/FqC6ddTOEMdi6Ee9wijxCVpQJ99BQ3Mt2dP5FkY75LzPXjLrI3NgJYiERxYBYDMgt9Zdeg7XN95Xn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0K703y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECD0C433F1;
	Sun, 31 Mar 2024 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711869444;
	bh=ynEEvfZfM0Uvl7G9oYl7YDpYAQvFFwcG5qLQbWzN4Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0K703y1ptIrBg6wSmIE2iJATRRk+tuDS7C4g0yH7VF+WjMxh4jJBcxnbmARGkU0v
	 RjK8m1E7iNw6y9t4+0Nwlgr8qM1YGbpaBKRF2+FZLztwRaEzEHsp4tGR/aosV6qdd6
	 YADyRuIiqGwQ7PLMdeFOSjvqIZctA0adkvhEEwIs=
Date: Sun, 31 Mar 2024 09:17:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
Message-ID: <2024033109-reporter-blooming-5217@gregkh>
References: <20240331-typec-fix-example-v2-1-f56fffe4f37c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331-typec-fix-example-v2-1-f56fffe4f37c@linaro.org>

On Sun, Mar 31, 2024 at 12:21:15AM +0200, Dmitry Baryshkov wrote:
> Update Qualcomm PMIC Type-C examples to follow the USB-C connector
> schema. The USB-C connector should have three ports (USB HS @0,
> SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
> connected to the SBU mux (e.g. FSA4480).
> 
> Fixes: 00bb478b829e ("dt-bindings: usb: Add Qualcomm PMIC Type-C")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Update examples to follow usb-c-connector schema wrt. ports definitions.
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

