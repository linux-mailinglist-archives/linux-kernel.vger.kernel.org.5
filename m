Return-Path: <linux-kernel+bounces-126848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F1893FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E97E1F221C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A18481AA;
	Mon,  1 Apr 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="Eojp17Uj"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0666C129;
	Mon,  1 Apr 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988392; cv=none; b=iClr+h4tRDmWFE/5FeGmvNncNN275cNvCLSa5LzNZ4g6tcT4FZWX2L/Y2x9ZgFkaRpSremne/0BnTgqbhHh9InuitoscV93SK43bA0eFMtDmJg3P6C84P0bhHQgOnhdxu0pN6tUm+lv7rFjo6entS1VaO/ZUIq4e5RKNC2xOAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988392; c=relaxed/simple;
	bh=mR/cOeAw4E7C++Ggf0FcfRIhKkLkJCA2eKgJ7ORve1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvOEz5wUMf/jOdQFVgfHA6FrEnYPcUDtQnYppoDgBee7s8ORGselIOFlOAMuqyE+pk54S9JEAjHgMaAvQpmsi5O/GWxlyO2RtRq8PRw8sLswU8luy/P/nnlkbDycJP2d2Z20Riqk797aS3+UbVlNtKLSgy7spd4/DNeoFKPFNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=Eojp17Uj; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 8EC74401B8;
	Mon,  1 Apr 2024 21:19:39 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1711988380; bh=mR/cOeAw4E7C++Ggf0FcfRIhKkLkJCA2eKgJ7ORve1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eojp17Ujo/uMpf1fwFbzjNhysujUbTNg10EALJdjfAVRyC5AVKkKURjF5xuKJv9vf
	 FEVsiPPAT63k0DW5SMMjWK6EeW4DQBySzJ4zD5L76TzKckXGw+A4i8g7kTkLdEliOu
	 ShR9wGrQxaSd+9o7/R4cIn08s/SKudbqSh/u+rZMpp1WwkPj5qHsQs2f3UCauExHSA
	 AQWtOEP000HS9JfmwiXwxBp3NdbrJItZYSl6zZ/FljI9G3IPwiK7PeH8FDxgr7IJJr
	 yx0RdOhAYpu2qJ79AJIAIVl0YgpYH7/No5LYU8uhr/SOdqdOe1/SYiiCxMKx9bPt31
	 jhf9PBM8g9bqA==
Date: Mon, 1 Apr 2024 21:19:36 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: describe additional tags
Message-ID: <gkxxcernzydrduvmzgyyj22evukzhuxe7mr2nbn5p4cft23s6h@koerky6gc3bf>
References: <20240401-additional-trailers-v1-1-f472bf158d2f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-additional-trailers-v1-1-f472bf158d2f@linaro.org>

On Mon, Apr 01, 2024 at 08:17:03AM +0300, Dmitry Baryshkov wrote:
> Described tags do not fully cover development needs. For example the LKP
> robot insists on using Reported-by: tag, but that's not fully correct.
> The robot reports an issue with the patch, not the issue that is being
> fixed by the patch. Describe additional tags to be used while submitting
> patches.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..3a24d90fa385 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -544,6 +544,25 @@ future patches, and ensures credit for the testers.
>  Reviewed-by:, instead, indicates that the patch has been reviewed and found
>  acceptable according to the Reviewer's Statement:
>  
> +Additional tags to be used while submitting patches
> +---------------------------------------------------
> +
> +The tags described previously do not always cover the needs of the development
> +process.
> +
> +For example, if the kernel test robot reports an issue in the patch, the robot
> +insists that the next version of the patch gets the Reported-by: and Closes:
> +tags.  While the Closes: tag can be considered correct in such a case, the
> +Reported-by: tag is definitely not correct. The LKP robot hasn't reported the
> +issue that is being fixed by the patch, but instead it has reported an issue
> +with the patch. To be more precise you may use the Improved-thanks-to: tag for
> +the next version of the patch.
> +
> +Another frequent case is when you want to express gratitude to the colleagues,
> +who helped to improve the patch, but neither the Co-developed-by: nor
> +Suggested-by: tags are appropriate. In such case you might prefer to use
> +Discussed-with:, Listened-by:, or Discussed-over-a-beer-with: tags.
> +

This is an amazing idea!

Though I wonder if we should use the industry standard X- prefix for those:
i.e. X-Code-generator: or X-Sent-some-messages-about-this-that-were-left-unread-to:
to clarify they are extensions to the usual workflow.

I think the decision on this would be pretty obvious after reading the
current recommendation for X- prefixes in RFC 6648.

I like this change!
Nikita

>  Reviewer's statement of oversight
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> 
> ---
> base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
> change-id: 20240401-additional-trailers-2b764f3e4aee
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

