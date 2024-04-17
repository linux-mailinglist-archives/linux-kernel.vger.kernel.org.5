Return-Path: <linux-kernel+bounces-148122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E218A7E06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C58DB24C30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909237E0FB;
	Wed, 17 Apr 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUVAjLy3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E927D3E4;
	Wed, 17 Apr 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341950; cv=none; b=V5Kx8Gglp3J6y3m/z0HdtFASb0cZPjE+URmZtMQ1LvtMiYvaKSfPV8F1l7LMgcBOWtE9IsgY6X6Y13JKLrztN57NZHOP9KWG+SPYiBxr0axe7RxOsyerSJrpyY7ptx3vF26j1khyLv4DA7YsPSKiXfPmi4DqiEEsbAMnnre0dBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341950; c=relaxed/simple;
	bh=vQ0bSBSXVcW7woDznB4l2mZtCtQ6d2dmKIq6OArUyRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcY0QiAievZcd3h9BMMHy5gu3ZMWQIVwR6G/rMZzhISypZFVxrH7G5Xg8VcUuywsQhjQhbdqAOandvo1YKI+F6XGLmAhzgI5aJ+1uX07nEnP7dWv/1KVFuvhsdItnilILL6nbbRXeiTJbbmOPX+LZi3ehoTbbBXMV2yXIUjJjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUVAjLy3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518c9ff3e29so3962449e87.0;
        Wed, 17 Apr 2024 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713341947; x=1713946747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WVqvTWkSJuMK42oCBd4QTeLpoVUswiSt5bNCxSQhCk=;
        b=bUVAjLy32mUGt//z1Tk46VDz+ZN2Yuvc+bHMeeVtOHuyEBOwT2Y8TBFF/WRz6ueCHR
         pjJ/AbXKq2FBuE7JEr7UYMUw0GpcjRv2Gt+PXq2IuUZjWJv13suPvldwGTpgLE96STSz
         jkue8eH/ifoA1mEloAL9zE7vx0jCIDGYHk77ZZ4q/BkDumXN15SiMQ3uYMf3J7yIIWvB
         RW/3nYU5w9+YI3kNaSualwwbLVaPqweUdVTWd9py9iXqd2rScZS7TKe98CUOSyxy8Fiy
         bUn7FG3nw6mOiE80SzeDHKfXtYv80cHB7uwp19Mda+MmXy/jSHNReSoN+zkrkLvPR6Jg
         vCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341947; x=1713946747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WVqvTWkSJuMK42oCBd4QTeLpoVUswiSt5bNCxSQhCk=;
        b=ByKaG5cRV0KEuOca7gIRiD+nMXrnmXu+R1w1aSbi7a0lgbJJZ2rcqyhqVhTUfBiP+7
         KrgW7LBB1PFot+VjgSwpr1qD/leyVdzXjWUhfqRk2GE8qDDIJrRZomRKsT2+QA5xDIh5
         4jgp+xevJC9cKVmbYKf8t/A4Y//RgXovrDHz9OLSEQaEMdSgrrcKi8/r9eX9NP/kGLQD
         d6rAMLwTTmJn0/GsSTLJbKCjyVKCNCH6hPgIxbfEE+Vc8zLkRqnf6T8d5AtMuAYLu4Bo
         8gMkBk1c67E1J3aY/5Hao3SW1IFoY6FjWtSE3CbcfbHbZCKOQ+WRyoq9U4V6wtceHSt9
         GBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc/hLOsnm3L8SaSr704x4BdY26H+mDQk+MqDRTHn5iaFg6IkvvHcSViMYQ7qsU1Ry1Ooa2ANXWLTMsylHAnQR8e87I5BmBO8doskfajLOFIF54D49EsnjVxs3J+S16S/1ybQSOKbfqVm/H9oPvo1AxWBsjnoAgRqT6bVx5IAdmCN/j1A==
X-Gm-Message-State: AOJu0YyvsY2iZoRFpd4XDi6MbJVPO6gwp5SJS8NJJ166++NmLwaOent3
	dSax1kQl4Xgq5P3Wom3lyXK1ITkR1yWzq37OYa7Il9POiMNcXrKP
X-Google-Smtp-Source: AGHT+IEZH+ylq78IQkJNfP5FDxkXscm3aRgH3ubDyx46wNRqQbkl2T+2tyX+4h0ejdbXrQysINo+Vg==
X-Received: by 2002:ac2:5106:0:b0:518:8c8c:db33 with SMTP id q6-20020ac25106000000b005188c8cdb33mr8624693lfb.7.1713341946952;
        Wed, 17 Apr 2024 01:19:06 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b00518948d6910sm1446525lfo.205.2024.04.17.01.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:19:06 -0700 (PDT)
Message-ID: <04f71d99-aad2-4e56-8f92-89469c159b48@gmail.com>
Date: Wed, 17 Apr 2024 10:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to
 trivial-rtc
To: kernel test robot <lkp@intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240408-rtc_dtschema-v1-2-c447542fc362@gmail.com>
 <202404170656.LoL9eBYs-lkp@intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202404170656.LoL9eBYs-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 00:45, kernel test robot wrote:
> Hi Javier,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on fec50db7033ea478773b159e0e2efb135270e3b7]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-rtc-orion-rtc-move-to-trivial-rtc/20240408-235612
> base:   fec50db7033ea478773b159e0e2efb135270e3b7
> patch link:    https://lore.kernel.org/r/20240408-rtc_dtschema-v1-2-c447542fc362%40gmail.com
> patch subject: [PATCH 2/9] dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
> reproduce: (https://download.01.org/0day-ci/archive/20240417/202404170656.LoL9eBYs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404170656.LoL9eBYs-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>    Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>    Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
>    Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
>    Using alabaster theme
> 

This issue has already been addressed in v2, which was sent a week ago.

Best regards,
Javier Carrasco

