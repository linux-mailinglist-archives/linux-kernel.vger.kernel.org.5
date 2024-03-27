Return-Path: <linux-kernel+bounces-121457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3288E830
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3981F1F31EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186713AD32;
	Wed, 27 Mar 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhsGwOJZ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842512F5B4;
	Wed, 27 Mar 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550714; cv=none; b=LW+Ge+8EVItjxYnYmiR+kRXajXm8zSlOC2+dHYVEqQCl95jHJ52TAYHxn9q/HCt0JOnj+J9mAzEhjtrPD4MfcAT2Ktu6ONSTHMJzlXObqzWwzZUYm7xepNgjAAoJQFYV15OhwCWCyvHnxrnagUO+x8Vjuv9GO58wgCpF20vKeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550714; c=relaxed/simple;
	bh=G6ZV58zkX33Obd5w85Utc6DxXzyUWVj1uIRJ4W5Xwao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoRm/Y3zK99feljTAilGfv8Ri0R77HspDOGW7/Xf7wgbIjAM1+Foevr1nZeJPtaerjO0q6oRLEhONDAu9v4I+KKoui04h4i4ZFDepJJL6JV/Qloj9i/eWKhN9hBvtR4hONW5XwuPFYO0rfmK8tDWQlZ9tLiGqE2VC0CLyM7Bilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhsGwOJZ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22215ccbafeso3298504fac.0;
        Wed, 27 Mar 2024 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550712; x=1712155512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnV36qdnlfNuyZS7uSndjgNOhrMaNYjde0YXgs5g7cc=;
        b=NhsGwOJZZl0/rznnBHHcNZa0YZ13i6Gv9Gn7nBNeNZza0f/HhWwi0h/jR6sqGuQvBc
         GeAv6hR2bzjK21dRRXXn8oEP+gfaIGK7YGF/igjAvOrF0EW+pOxe2RI+rJDYP0lcT0y7
         Fg4inW0KPMB3DYJ0Eoz8+jaBxqdH5tS27PJOk/YVs160S3W/FFSsqoAtQUG6irc/pQr4
         HirGACH2qIKUtqRqewAdZyke/odSN1jHLz8AWU63KOPvFFpT+JoAlUf6NfgeTHNXFBw2
         qKdjXpnV/vOf+Dlc0TnP0Z/dkIFF6boHHSe9Pdp7aWOawBxkKoatEgPv+oRbyy20D6IH
         waHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550712; x=1712155512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnV36qdnlfNuyZS7uSndjgNOhrMaNYjde0YXgs5g7cc=;
        b=TBRNdOxfK+gRImUVP0oZoxIVj/2yw0lTpGvpU5mm+132IzdjOEomTajsZHdNj3U3wq
         EzkEea+pRGVc58EiCdy8CQAeXVAGzh/P8r6VMLpIungR8cwVqIXKc9gnuYX35MGpo3n1
         rgmCePygHUL7U/dEc62HZrNPJbFrd8Q1uxE8IAzcM1evIBdDU+4mJkuS6XNhdUSQzDZG
         asXYko5XecXkUW75bO8EAyITXlng3TQI8YzBmsgzTF4QoJBi7WT6GAmwQCOu+WqDxOZh
         gPtAHQFkrfXxd/ZhmhJ2q34UsDKn7IRIK2ypVTWlayeEsoTryiEqcCfBByHuXmO5FX/U
         bSwg==
X-Forwarded-Encrypted: i=1; AJvYcCU9sU77PNN2GgWVq0TUZM8hX0oLdkArts42L/gkHVyJbRcFCJbdlnjb9V3U8w+zdQCv6LtinoZ42Jko4IMW+lKQPRrvLg/Z0xfQImmriFBgoOZIiW4TcWoSJrKpM67dpU003B3GxcRJv2T9p5WvU7rKoWbIBJmFX+WvTzgNym5b
X-Gm-Message-State: AOJu0YxaaXM27uL4k86P68LSawqkZPoojyhRtg+9MrKUJfi5miWfVX3B
	dlxunCTtvOd4NJbNpf1uJaIWM7c/X/teNdsC708LrneWV0XF2eYLZ0DLYUTj
X-Google-Smtp-Source: AGHT+IEkWkV4lUpvnsYu7XLudbEd8vmyWcxUpYjFmWonSSskQrRN0x5sPtw6hSk+bBCwA8ltYgeINQ==
X-Received: by 2002:a05:6870:1c8:b0:229:f61d:7e52 with SMTP id n8-20020a05687001c800b00229f61d7e52mr6908575oad.34.1711550711899;
        Wed, 27 Mar 2024 07:45:11 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id fj11-20020a056a003a0b00b006eab7ca005esm3808785pfb.18.2024.03.27.07.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 07:45:11 -0700 (PDT)
Message-ID: <8ce05c2d-eb0d-4c30-8e1e-eaf22528779e@gmail.com>
Date: Wed, 27 Mar 2024 23:45:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "docs: Makefile: Add dependency to $(YNL_INDEX) for
 targets other than htmldocs" failed to apply to 6.7-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Breno Leitao
 <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327120842.2826444-1-sashal@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240327120842.2826444-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 08:08:42 -0400, Sasha Levin wrote:
> The patch below does not apply to the 6.7-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From a304fa1d10fcb974c117d391e5b4d34c2baa9a62 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Tue, 5 Mar 2024 13:23:00 +0900
> Subject: [PATCH] docs: Makefile: Add dependency to $(YNL_INDEX) for targets
>  other than htmldocs
> 
> Commit f061c9f7d058 ("Documentation: Document each netlink family")
> added recipes for YAML -> RST conversion.
> Then commit 7da8bdbf8f5d ("docs: Makefile: Fix make cleandocs by
> deleting generated .rst files") made sure those converted .rst files
> are cleaned by "make cleandocs".
> 
> However, they took care of htmldocs build only.
> 
> If one of other targets such as latexdocs or epubdocs is built
> without building htmldocs, missing .rst files can cause additional
> WARNINGs from sphinx-build as follow:
> 
>     ./Documentation/userspace-api/netlink/specs.rst:18: WARNING: undefined label: 'specs'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/rt_link'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/tc'
>     ./Documentation/userspace-api/netlink/index.rst:21: WARNING: undefined label: 'specs'
> 
> Add dependency to $(YNL_INDEX) for other targets and allow any targets
> to be built cleanly right after "make cleandocs".
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: stable@vger.kernel.org  # v6.7

My bad.

This should have been "# v6.8".
No need of backport.  Sorry for making the noise.

        Regards, Akira

> Cc: Thorsten Blum <thorsten.blum@toblux.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Reviwed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Message-ID: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
> ---
>  Documentation/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 4479910166fc1..b68f8c816897b 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -111,7 +111,9 @@ $(YNL_INDEX): $(YNL_RST_FILES)
>  $(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
>  	$(Q)$(YNL_TOOL) -i $< -o $@
>  
> -htmldocs: $(YNL_INDEX)
> +htmldocs texinfodocs latexdocs epubdocs xmldocs: $(YNL_INDEX)
> +
> +htmldocs:
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>


