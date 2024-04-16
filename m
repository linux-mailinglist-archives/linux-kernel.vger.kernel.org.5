Return-Path: <linux-kernel+bounces-146790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6C8A6AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDC51C215EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E133811F1;
	Tue, 16 Apr 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxPlLjZ5"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512885959
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270736; cv=none; b=tUqr+I2Yzn0SMPtR58bmqurZN5r7Xm23ovn5Ba1M9lqYeeM/cBsaR0riscbBaIKeMcnNSWn+XofPhAMdDkyFL2v4pe8Bhqj7HimZ72Vhr3L1V9edvz1f/zWlv7sc/tYUt6Zs9QPd4Qg5+snue38ctH4FqhqH0gKvW7MWGil0UlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270736; c=relaxed/simple;
	bh=Pt5/vGHuhGceeo+QpbsK2XpxTMgmfSIqSNFU1JiurME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVeNnBxDoFKPhnMFS5l7nCiFhqSmWgdcd05tElWCE8It0qIovx/In+0eA51dkKDGMrZksQHsR7ieV3OQ/oD17bxw1c67pdEvu/hcl6VBLkhtUtk3laW47pB4HMYn3LurlF3TblYGBYWUnJYlj88shpuvR4mo9ziGHp0tKVPQchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxPlLjZ5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61874a5b8ecso41083807b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713270734; x=1713875534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFzNumwLL/PShEK3mtGPwjGln1YmU4ULHeA3GQnXIh8=;
        b=sxPlLjZ5GCGhLrxd9XBWpj/89hu9GSM/WsGPuHEsYI6fuMPDZvBklz9i9rm3A//m7N
         BqNqVOCg32CkqQwHMuNYLcmuTUAAqqBRXBRFRe7gsknq7Z2H2QhZ2m+kaEXT2/kaS0YS
         3ApxjEXH51bBG7n1LdHPFQbAcaeByGEmuITFBRUa94BED/cdqkknpyepqqkqdVrsQRiO
         8eTdErEl/tkZ+NZoldn1p4EkrCIYW2YuCnU9wHkxYyfnRZZLhOZG6Na4pCCYM0/XyLX1
         8gf6iiqayylIGEC6smp/9tC3508NQHncAL8vKxl2S6yxLeq6UBw/Tm4aPfz+SuxMxsuw
         dQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270734; x=1713875534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFzNumwLL/PShEK3mtGPwjGln1YmU4ULHeA3GQnXIh8=;
        b=O+142SPWej4ioUIif0stPoaJTh+upEgevs3BS4/Tkwr+trGo8x9bbhKcmJ6u3W5IRX
         zmxwnhassupyT6AuuEZojAVNNtRNjUoFyPF4mIk3zQKVDwmmd33U2uw4QSlmQh3RVGwR
         6GV8q+CZ923K8NCn/grnLINNDNO/c13NujtAZbNJ5T/9KUx/pGGzLmDlB/A1RXjXG08X
         TplyTpVbJ9P3xrNrbyv5k51zElwScOf0DDrybjC5VDvalKsHXCRHbufVo6Ba0v9eD+5f
         v67AidBIZirnksdJl9SkV3CPQrYJ5ef/Sajm1b5FsbjAwMznnCBstkNnrtXWfloIASR0
         bAqg==
X-Forwarded-Encrypted: i=1; AJvYcCWIYAb1ktPS5bpjzTDf1bafoizdO7ykBkSZAnZzYHVWYCYutU/sCJI49dbmDkoR4ydyzqyBn+hYVIEVU/xcdTeN/NfqzqhRNaNVJRH4
X-Gm-Message-State: AOJu0Yz0I+Y2VndTs4/7vlFvb4acavKlyejEx2ONAwIt+JIx4pOKcfeN
	XwJlpo/r2KYp12RBgLlPpLUWM8GO6r6j7xgQtW+8BdAVI8WtCglzPr3lWNHul5x0pRtODx74jNY
	h9CXFn/HT41M/kitU/3fqUhCYUgVxhLu3B/nMJQ==
X-Google-Smtp-Source: AGHT+IGV27KS53nGXMmiHjntrt3Z5nGpbgyi0jBS2Pa+b7xJatvlhEtb1vxhnn5pvUEhuRd3C8c95o+slvde3TTPid0=
X-Received: by 2002:a25:1687:0:b0:de0:fb80:5c6a with SMTP id
 129-20020a251687000000b00de0fb805c6amr10814478ybw.60.1713270734122; Tue, 16
 Apr 2024 05:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com>
 <20240414-arm-psci-system_reset2-vendor-reboots-v2-2-da9a055a648f@quicinc.com>
 <Zh5FKtLVhIH-6R-I@bogus>
In-Reply-To: <Zh5FKtLVhIH-6R-I@bogus>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:32:02 +0300
Message-ID: <CAA8EJpqHOWCLg65TSrpy6eh2kFL2=5uu8Kp+WKqu8dLZdowfZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: Document reboot mode magic
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Melody Olvera <quic_molvera@quicinc.com>, 
	Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 12:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Sun, Apr 14, 2024 at 12:30:25PM -0700, Elliot Berman wrote:
> > Add bindings to describe vendor-specific reboot modes. Values here
> > correspond to valid parameters to vendor-specific reset types in PSCI
> > SYSTEM_RESET2 call.
> >
>
> IIUC, PSCI SYSTEM_RESET will be always supported, so the choice of using
> SYSTEM_RESET2 sounds like a system policy and must not have any information
> in the device tree. All required support from PSCI is discoverable and
> the policy choice must be userspace driven. That's my opinion.

Well, we are talking about the vendor-specific resets, which are not
discoverable. The spec defines them as "implementation defined".
For example, PCSI spec doesn't define a way to add "reset to
bootloader" or "reset to recovery" kinds of resets.

I think the bindings at least should make it clear that the vendor bit
it being set automatically. I won't comment whether this is a good
decision or not.

-- 
With best wishes
Dmitry

