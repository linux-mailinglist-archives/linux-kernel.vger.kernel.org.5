Return-Path: <linux-kernel+bounces-117804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465288AFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664CB1C61E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4A17995;
	Mon, 25 Mar 2024 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSJvs0IV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E8134B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394490; cv=none; b=OBTrV6JOYD+LCVUmhvDsO+fifqFREhnUmuFU1J3lQPGSbvMR8wXWafIVM5v88GbgRtZDyWaVmuBMojcWVVyHgwHq0ufjkN/ShJ65jzUQshMPfonqjpjccRoSUvj0PjUsfjVIKd5sXp1eg1qefvsfpEnWVi90Y42rTcFXgeWWBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394490; c=relaxed/simple;
	bh=VYRIildENsaBXvR73Y1yIYCKG+Egv5wNELgCKWLzyUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgK66cDEKVRM/uM2fGFLxBh5OLFm1nFCr153GOTOw4tzxX3MAPMre5c61G5z42JgIRvUasnWF///VHDFhOfsZsJzOuOPncL3/XRu8PJumU4kxoURLCFWQo9HkXdmG9Ek3BSv5qPHlkW5K2YMVP/zisv1LhK9b6Bkqoi7yKDmAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSJvs0IV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513d4559fb4so6375345e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711394487; x=1711999287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7aRdVW7qgX5bNi5oK/bW7TDpJ2AMVEjlX5d8Z7H+qH8=;
        b=aSJvs0IV/g9UFspWMEOVVg4EVdV307eripfZBG6FHJ/LgDFtDnyHyer8K+n4WEVe9U
         En2TzRJszJDRkVRWZ3A8uuh0gDbW2kRz3QL9u+n3RRDJ/5T8Vgn++0ECmWiigB0M2Ldb
         3fjFMKF1gSCJKPCHJ69cPKcNn46j4WkGOwZqKT/cTWVJKh/sYsMemVBTtocdFK721ty3
         GLfJ7gl5ThPAJZP4SNhpluP9DmrqvZM/lQrADq25i76Zq6FOErS8vxlHo4BIgTZ41FrQ
         pHfS67pWHkNOoWUxksCEO0kouXHqzgwj1ItrmFtWyFVx+1jUNoakYyVhmK29n4WRhnGN
         VMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394487; x=1711999287;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aRdVW7qgX5bNi5oK/bW7TDpJ2AMVEjlX5d8Z7H+qH8=;
        b=SzXr/7a0+8WnIhvdQcGlUjQ2IbkLT3CfocYNrZiuh96rDji+HcswaDdoIbSFnsnu6Q
         nxVQAUmQvC6/i+xKZ7IEziMEHx647bzhdLoEylzmQAPeaeJYI7N+C2fFcoSdgyYrUc84
         WGuD+kMALVOXv79j30yhA77DCfiTDYPweZdVYS/7kyUOyElXnJvZS4GL/WwaxiGvdHTu
         6Wf8iPN/NZjJ+rYeV58aokDVbfZLh9qw7VdqZIYn77ucsNkjEePeKgsiJW3oVZbvJLV4
         rf77w2U4RGniTmCK5JSZ8lDRGnN21fj8+t1Dbd/kybxDMf2Yxzb+y2KHJgOx6aaVvJqj
         8bFA==
X-Forwarded-Encrypted: i=1; AJvYcCXZFlkHfRDfRrYWC3N2FZ/3CTRGurypQzDO0c7hAHkGUJFD3zgCFumVDTJ2LC0IaGmCYjO+mJ9Wpmj/cWEbETzHfAHOU8P+oHjmqwei
X-Gm-Message-State: AOJu0YybFXfsX7Wj/RV3lrfbR8BUU4o/2o/screI+BkiHBLirIqCBzQw
	adpBOBBkauPU7ZoiMvTny6gOJd/W6nb/Az1jx16KECO9tvw9R17igonTxgT83xs=
X-Google-Smtp-Source: AGHT+IEyItUn9hdMpAk8rPYqPH5OSZ8RVw98PyI0tvTq+a/OYosBp+4XMzaXdqBEC6fwQvPpHMe5aQ==
X-Received: by 2002:a05:6512:6d3:b0:515:8653:80d9 with SMTP id u19-20020a05651206d300b00515865380d9mr6475912lff.57.1711394486439;
        Mon, 25 Mar 2024 12:21:26 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906708400b00a46da83f7fdsm3368114ejk.145.2024.03.25.12.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:21:26 -0700 (PDT)
Message-ID: <bf2c507d-2320-425e-8bc2-8a2858281559@linaro.org>
Date: Mon, 25 Mar 2024 20:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325081957.10946-1-johan+linaro@kernel.org>
 <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
 <CAA8EJpqvYYCFRJVr732VORyHgpU-H2nif+n6hB6pJbXsqCH3_Q@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpqvYYCFRJVr732VORyHgpU-H2nif+n6hB6pJbXsqCH3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 3:10 PM, Dmitry Baryshkov wrote:
> On Mon, 25 Mar 2024 at 16:01, Mark Brown <broonie@kernel.org> wrote:
>>
>> On Mon, Mar 25, 2024 at 09:19:57AM +0100, Johan Hovold wrote:
>>> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
>>> supply for GX gdsc") the GDSC supply must be treated as optional to
>>> avoid warnings like:
>>>
>>>       gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
>>>
>>> on SC8280XP.
>>
>> Can this device actually run with the supply physically disconnected?
> 
> On SC8280XP this is supplied via power-domain instead of the supply.

I think Dmitry is asking about this bit:

if (ret != -ENODEV)
	return ret;

which is basically repeating the difference that _optional makes

Konrad

