Return-Path: <linux-kernel+bounces-66527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83168855E11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91629B252C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2981802A;
	Thu, 15 Feb 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTWhiq3z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFBF1798E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989144; cv=none; b=aRoP3zqjIwvlIBUNaKUumz7mVhvSd7u37KjMLfNhnldsH4ZN3cY1gM5x0tjhtr+Sf5lOts4bDtboUkAT1K5a+utBebg8UIS+vw+xS3FloqrttLcNTC1NzwZ6VqR2j2NUcwzPZ29HfxrAXuxt2YUcH11KLGJb+pVD5vJtsw/6pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989144; c=relaxed/simple;
	bh=4Q+M+8Un7Pv2mnj/m8t23ALRK0Q9SuLZmTW9NokE94I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+NAE9C5P4WG4OhcWF29JAhfENwv6afdavtAiCLhieSkqPMTssNky0w0hxDmeUv5gcCW5msOR5vGnqA7vJnTG/AHPqxnH4Tl73ZXoL7dM98FvB1/84YnBc/j3D4mw/jFgkNuMBaaeTqrcfLleeg3NfWuyHVN0TYVuUwbUTXtRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTWhiq3z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26f73732c5so79108166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989141; x=1708593941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmg4GyqE2bkdR/9vhzop5Jgy/Ivyzo3N8XAugZKeJTI=;
        b=cTWhiq3zpDGZmadB7TAlWIuLUWSkdzWIpK7CfkLv7yxie28eA1yJ6jGKwDYiQb9aO6
         gudTIyu2X49tR2uFUoHc0kZKn3zvQ0PWiGYBXpi7Ojrk+nwmGrRVxLA8ICxmiSPOXrz2
         xE85JGK50Dv+OBO7AkMLeyFcpaZ1PsERoS9EN3vHf4kHveuEUp+ukqjU2tg2d6MgZh5e
         lqGrDLY0sHLFpdFLz4zvygq9dwojjYgsq5DCN0GTzTB+Xzy/xFbEULfosAzl1ODd5DUW
         RigWOY1Ep9bDMpn/SiBvoDkm9wIhNcUfOE+X3derwzcGlO+GyUElMQNywwzzeQnY2t2h
         ZTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989141; x=1708593941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmg4GyqE2bkdR/9vhzop5Jgy/Ivyzo3N8XAugZKeJTI=;
        b=G4JStt9/lP+EvuZCamz9nOh5t65HPzRtpvKNZjUE8URgkU8rTpfM5YKfbDaNn9uUrN
         Tj2/eA5vqyhZhimJ2COFZO9160dW8dAwxtPNdmetQC5f+vG2qhtmxZXU6o0+RWkwacPi
         ZDtfMvSwTRqQl4VSlRksUbQVDDuRovG1wpQ+A4Dpt8wQuaYKSbMQcePeQRx5aO0kMMQn
         XBMkHq3OVqGUxiiXfAFEIMn+KB26u1YAL79IpswDP16exQL7kCQdHJXlj+IsW1r/PAkK
         ugCEy0FRp+Aiuts0P3GPg89RFYDIdkYHLAMz3BEKtm2wdsAJWcS+P8r98ypE2hkcTfZg
         YrfA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Q42bf07l3b8s4MaK3ySaw9GAArwpo2lTyYX6y3ZwGuLqoGFGH9Mj7QjWN4ff8d2CfVekR7vXV62NFjoYsCNJfQLDtiKZRYB/bfxw
X-Gm-Message-State: AOJu0YybyeTst/KASuvx6wdJnmRhGv3YveGYrxGpgjEt0RB9UAHhtWA5
	RgYTY78l6ZoOd6nL+rFs0ULsFoGFBi6HuirMHBlOYqKCczRvWc8QovQzC6213QA=
X-Google-Smtp-Source: AGHT+IFZx7QXYqNf+ovTF4psE466cIvMPkky9JfvKHFlSZz7hccBdnIOqgiC2SA4zAAW7qdtAbVNXw==
X-Received: by 2002:a17:906:d28b:b0:a3d:9f8e:8821 with SMTP id ay11-20020a170906d28b00b00a3d9f8e8821mr562492ejb.20.1707989140973;
        Thu, 15 Feb 2024 01:25:40 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ss26-20020a170907c01a00b00a3da9857e46sm80390ejc.99.2024.02.15.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:25:40 -0800 (PST)
Date: Thu, 15 Feb 2024 11:25:38 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC v3 1/4] dt-bindings: spmi: Add PMIC ARB v7 schema
Message-ID: <Zc3YkgrkauRcZfNB@linaro.org>
References: <20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org>
 <20240214-spmi-multi-master-support-v3-1-0bae0ef04faf@linaro.org>
 <ea9d31c4-e5c4-4869-8bf9-caef3dd32829@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9d31c4-e5c4-4869-8bf9-caef3dd32829@kernel.org>

On 24-02-15 09:54:37, Krzysztof Kozlowski wrote:
> On 14/02/2024 22:13, Abel Vesa wrote:
> > Add dedicated schema for PMIC ARB v7 as it allows multiple
> > buses by declaring them as child nodes. These child nodes
> > will follow the generic spmi bus bindings.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 

Forgot to run "b4 prep --auto-to-cc" AFTER I added the bindings patch.
Sorry about that. Will do it for the next version.

> 
> Best regards,
> Krzysztof
> 

