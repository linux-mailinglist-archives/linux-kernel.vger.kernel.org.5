Return-Path: <linux-kernel+bounces-93353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25972872E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577791C220B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7961B80A;
	Wed,  6 Mar 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKh6m9nb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB281B7EA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703180; cv=none; b=Tpf4cXl62F3w31wopDCKkRQA/2ayzFfo41KRmssx3V1ueB6yvxUoCIE02Y+f86ujBDqjBKJiDaHuLaRG6T47nCv1dmssqprb+Fe4fHWvN4Zh9fju929/ZTL1rWS3hjMlu5wyvjSH04vdnDSuO90stXyVWtMs2tF9T7kJn30l3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703180; c=relaxed/simple;
	bh=NPtg5u6shB7HJm+VpcBl+duxc8j3bwh6Dd+pBnp/ENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPvSxlKDmkT6/hU+m3lZVJ1TcERak4sellkzIA7N9EkJFmBfSnuidIm3SkoPeiskHSxUi/xyf1681b4uhC/kHG1E0hvCr8UWnYdTbZN37O1BAoFje3nKvEYqBakvBGSJ684vpdU6rqocE45seRKT+mGjtfpLXuPbd5QyBAREbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKh6m9nb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso47915935ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709703178; x=1710307978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsU79jzbblRigvRorhI+92ujcnlpzSVj2T28tfZa5xc=;
        b=jKh6m9nbr8YhHYlAYr+zVm/kfhQekxWT2BP58ENVP5c1w/Tg6gxv5Nf7RJQLsE5qGS
         HIp5rB63sh6nPRUi1qpoqclX3o4NJj3nOTkThbn3F6U/zM9fY8avXkk1Nk45ScUCrB2H
         f5TklfQyjaQsRyUrcNVM6vDW3dJjhaw744tj6KmprTrnZsKpaEOa3VTdGZcyRk4tsjlm
         2qBLtEvKoi9nYGv4cPWGtwxsPD4aogKXXs8RlmP395qY0+l1yyf7MbhuEWqoCLE4gKL9
         KqjsLS4Df6buccUydG/sdCrVi1D2QyVS8H0VJH74Qh3M0u6KmtqvEWPJJD6T1nb/ZG3b
         I5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703178; x=1710307978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsU79jzbblRigvRorhI+92ujcnlpzSVj2T28tfZa5xc=;
        b=RL2SDP1OXvIF2o6npOxXUsOkyfkaAetsjpQtFoK88sS8k2ewEgnUQeAa3mppm3Vzhj
         nxHwE/2YlvZRW9lVR9Ub+eMd7nIpCDMEellwxuGd0VVB/FIL5cfN/KSzWWa3wa7XX22m
         zDdtSO4q04KK5VvXFo4zZZMZPQBBuVYYRUzrEEKygScMZ5HCtFeJRyQIBC+06BETsXgw
         WXooxE2uHWLq9plbRwpKIM6wh/tu0AI6ujgJN+2INr5zLxVEyWwyFi9gnqeE8WCwFe+u
         ahrynNG390XtYMQdQeBVYbklyn/vglRnJdTBVuXvc0sEmOxEzbcfceYHLX9jwdHti5Lo
         cQhg==
X-Forwarded-Encrypted: i=1; AJvYcCWek8N8HcSlmyvHUbmCftoBOwFqO4dBlDScg092Sy2yapzmrd6YhsFYHK9GYazGko4sTuX3g7luLEfAfGz+rf1rWQrpTdXVtjz/9xFD
X-Gm-Message-State: AOJu0YxPQ5LYFj4FuE4aBfwr+i0E4FoE+sjJV9IxjHkhnHvj/FCa0Z7G
	H9CMPp2meEi3rXsWenoCX73vI7o8tJwzUOiyS7yck7C/Sz+jFbgvkRfNodd1qxs=
X-Google-Smtp-Source: AGHT+IF14LEVdHjiOwzABEbNGDOy2jdHiI07m2JQM3c2nD6CTbneowRQFBSobR5vG8K/Dil8Hc24Yg==
X-Received: by 2002:a17:902:d58c:b0:1dc:d116:1a3a with SMTP id k12-20020a170902d58c00b001dcd1161a3amr4708936plh.62.1709703178053;
        Tue, 05 Mar 2024 21:32:58 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001dd091cbc4esm5947105plf.181.2024.03.05.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:32:57 -0800 (PST)
Date: Wed, 6 Mar 2024 11:02:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Heidelberg <david@ixit.cz>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: drop maxItems from inner items
Message-ID: <20240306053255.azuybu346fybjwn7@vireshk-i7>
References: <20240304234328.382467-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304234328.382467-1-david@ixit.cz>

On 05-03-24, 00:43, David Heidelberg wrote:
> With recent changes within matrix dimensions calculation,
> dropping maxItems: 1 provides a warning-free run.
> 
> Fixes warning such as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> 
> Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  follow-up of https://lore.kernel.org/lkml/20231229191038.247258-1-david@ixit.cz/T/
> 
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index e2f8f7af3cf4..b1bb87c865ed 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -57,8 +57,6 @@ patternProperties:
>            specific binding.
>          minItems: 1
>          maxItems: 32
> -        items:
> -          maxItems: 1
>  
>        opp-microvolt:
>          description: |

Applied. Thanks.

-- 
viresh

