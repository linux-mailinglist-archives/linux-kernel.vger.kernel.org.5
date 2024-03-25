Return-Path: <linux-kernel+bounces-117919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290F88B63D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B4FB657E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768B481A3;
	Mon, 25 Mar 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENM5X+VU"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874454597D;
	Mon, 25 Mar 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398310; cv=none; b=dJEBgZtWPpKM1x2oV8bVKIMtE6VdkZgWcwdOmRHGqNF0u45IPSuazC7+ziE5kmR8CwBTc37kKgsMnpjfSNdY2KekfH7nLw79hkjao8YAgOSGsEphh2J6iqfG/5zmTNs11oN/YO9iNZLgFsIERqtueEyK5r5WXS+qjzNLo9P5BwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398310; c=relaxed/simple;
	bh=DBk0mGRrqs3fXNbMGeMFrYvbKXWx16IUFmAGJWlOobc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTZHj5GXcpkpVjlQmauUagHt2kc+ndX4rWiI0aDU3WUce6gcC9E7F8B8ILKexJ1mjDgSiI4GfOjxDGAGR3hD2WBqq2g0bC8Js+grlL5ztpmD91PT/eonCvcKgCx7RbCTtxyScFGdisM08CpF2+xmeffXvk6rR+CI38FXCR5A+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENM5X+VU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46de423039so274387966b.0;
        Mon, 25 Mar 2024 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711398307; x=1712003107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKap+w2F/mavcZpUAHIDLIPh2s+384u67vVZTtB6BQw=;
        b=ENM5X+VUEZFbxXuDnMO9uulUHLWG+w2RulePa3K6m1e8te/PVHIe0f8jww/i6u653m
         95QZ5qOLfppntJ5ORq/2WqKCOY/PE49nUE2hS3CUpGs/4wyRA/nEyDtMFRfuzEKRXcy9
         PiNlGhgAiU20lHTYcVGx4spRwD1yvYkF2ZM+y5SL93Jov+tX1UajAbvF2HR9zQwxflFW
         XQ5Gip6HREEFeQkGAdB++kZIewKIz6J0I85qEMTpnNAsWBPYikT3F07Q5DvDOctaYK8p
         T3h6XBp6Oa7Xdln3ghOsROBOTvUbne7NgfU5HMHln0sv0jpqJ9JBc49WvtODKka5pJMA
         8U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398307; x=1712003107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKap+w2F/mavcZpUAHIDLIPh2s+384u67vVZTtB6BQw=;
        b=ejyVRxE3fTCyFbKgQGv1sa6rJa8Rhmm4BlqiSYHmoaOTxOFTVZB4QAv3UH0NRLP77x
         7WLEXwcrTSjNmi4+tJOvzLkbygS1giSURf84goVPafuIkLWXn9ctal28WqLTDO5jW+KW
         Oj0/l/NcBzzMNaqf+MNOHiRzCyyWrmqZcpp96/LkyTXdsof93l6KgYUMfQ+Jwm2y+WRR
         qZsTU24AbbaakD48G4I+JZCfB9lQfNTk4z+NSS7hIyVrUc4etz1sy4GvOfsAekN3KQ4k
         ihWzrU7RQddC3E5x9vhvMyCgeLisDV3nxJthcyMVC0EIQOhx8/RcJzXZkUujqzSLzsRX
         bOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXulkDdGLnfICWW4/W1N+CqGYmUxEjMh6BbRs7IdM4lnmX2/If5VG03Rk1aM6ghJeQO4mXWeKos+q3DET445QehPa/ZT1McqGIyBTcK623U7SALpHNcLilZVxYHejVXc5rFJO2IJpfr8uGtkOhvpu1SujnbjWlpMzOXLpWHVBez140MlwFn13etcpvt+3nWwzlZyeR3NeMkirpt2n7DUa99CFyusQ==
X-Gm-Message-State: AOJu0YxOh2fB0pHKHkbjMiiDkgP6Emzzh7DOuXI+bo4nyFADrOydYxRa
	UUIqX2jj2f+/sNTvLtXFdDszQGZ12z5Ycfz8y2ESBQOoq5IkThy5
X-Google-Smtp-Source: AGHT+IH3MYHwbMtQtubhWVjxi/2gtr5wMVHSj9eDzomJs3JTaxIPbZAKJDw+94DvZ7YPRH86G7VJGg==
X-Received: by 2002:a50:d484:0:b0:568:c6a2:f411 with SMTP id s4-20020a50d484000000b00568c6a2f411mr5723974edi.32.1711398306520;
        Mon, 25 Mar 2024 13:25:06 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id c36-20020a509fa7000000b0056bdec673c3sm3456565edf.38.2024.03.25.13.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:25:06 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:25:04 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: qcom: Add support for Motorola Moto G
 (2013)
Message-ID: <ZgHdoK6luxRcKgRx@standask-GA-A55M-S2HP>
References: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>
 <b35ad5ff8a13f9df415b6e6700b3b5d3f13bfce8.1711288736.git.stano.jakubek@gmail.com>
 <ffa93b4a-608a-4cf5-b111-0d1f8520afdd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa93b4a-608a-4cf5-b111-0d1f8520afdd@linaro.org>

On Mon, Mar 25, 2024 at 08:28:27PM +0100, Konrad Dybcio wrote:
> On 24.03.2024 3:04 PM, Stanislav Jakubek wrote:
> > Add a device tree for the Motorola Moto G (2013) smartphone based
> > on the Qualcomm MSM8226 SoC.
> > 
> > Initially supported features:
> >   - Buttons (Volume Down/Up, Power)
> >   - eMMC
> >   - Hall Effect Sensor
> >   - SimpleFB display
> >   - TMP108 temperature sensor
> >   - Vibrator
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> 
> [...]
> 
> > +		hob-ram@f500000 {
> > +			reg = <0x0f500000 0x40000>,
> > +			      <0x0f540000 0x2000>;
> > +			no-map;
> > +		};
> 
> Any reason it's in two parts? Should it be one contiguous region, or
> two separate nodes?
> 
> lgtm otherwise

Hi Konrad, I copied this from downstream as-is.
According to the downstream docs [1]:

HOB RAM MMAP Device provides ability for userspace to access the
hand over block memory to read out modem related parameters.

And the two regs are the "DHOB partition" and "SHOB partition".

I suppose this is something Motorola (firmware?) specific (since the
downstream compatible is mmi,hob_ram [2]).
Should I split this into 2 nodes - dhob@f500000 and shob@f540000?

Stanislav

[1] https://github.com/LineageOS/android_kernel_motorola_msm8226/blob/cm-14.1/Documentation/devicetree/bindings/misc/hob_ram.txt
[2] https://github.com/LineageOS/android_kernel_motorola_msm8226/blob/cm-14.1/arch/arm/boot/dts/msm8226-moto-common.dtsi#L258

