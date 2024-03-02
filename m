Return-Path: <linux-kernel+bounces-89445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E286F077
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F5F1C20CEA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2FF17567;
	Sat,  2 Mar 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuEwhutf"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399E16FF4F;
	Sat,  2 Mar 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709384498; cv=none; b=MVEzafWsPVCeqWf9vz+c7xVpP7k5dSwm02kmOFgEFYLPH096OHkJcv9tLFTzNGGxa923raE5Bzh/hJrlbNCWo/wI7amrVOGBLHfPRnlmnnsBo/3tm8uUtF+sDLihWEAO8xpe5crgN26V+aJlcfj6gx4DIuQIiLlRpiq5UeMR5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709384498; c=relaxed/simple;
	bh=dTzVTT93MvJmB6dUMpu0bgvbfU11aRsQYfQsVpV/L1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsSksosgacvkn1dmErbmdwWr7dfZTKff1VlEaXXR/qNjI0RjuQx3e9mGLl7rOOo6zvAoXutCrdZFr+lMyZ29kUygvkVtwFc97FPxtVjW6JdATReOefwLKboMGmM3NiPzMomcDOscBt/VsEMtqmhG/4zyE1RFVwxmVu1qMkBxeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuEwhutf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e56787e691so2751736b3a.0;
        Sat, 02 Mar 2024 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709384496; x=1709989296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVmVL5YrXpWHRLK1XFyRKMzkU2VAClqTeRHrYOXLxi4=;
        b=cuEwhutfdwc6vNgomtYdIYLEJ8M7cS5YsJK3gVzkSmOGCwtoF9463iwhXPPllXi0TO
         Va66MV7t2zR3sF9GKCdaBrWLnhrZvr9LmIOvcmoDdv+wGLcgxnFJ9yEKBJW5VneQcDpa
         ylFSgtILl4o0r4ohmA7P5EeCn/O+9yY/XaE/lm9Xo/XX+6gg3onUvK8jrCwko2XVwFtl
         mUpW3CqFwtXDEc2yIcCxBf1V9WDYXneKU/AUuIqPfc6kjEgsfUz8hkOnnlb3y97vG600
         NnNWgqpr2NUEu6Am+xHC8aqO+IcFxt7t9URTSs8v/ZLMp+XAMl4WLWnwpqrgTerbvSmY
         7r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709384496; x=1709989296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVmVL5YrXpWHRLK1XFyRKMzkU2VAClqTeRHrYOXLxi4=;
        b=BT+WzEX8KGTDjf4FG9bDBg+A3NAxz2bpe+f9WqfbfkrpQBJJ0xP1oeXuJTowPSWdvx
         LwSYxTsPlbvpADfd3UIHXxXP3tuoc4moE8tvOQwAxYxJ2FgiHBuxsLfcfCuhBcsWRUav
         ahT8qAjetnUrdYcFe9nr0UOLn9eGltrm0litRYX4poKId4T/F5Aw2JvMLB1iFjqx9tCp
         Z4TF9j1yin6xrZ8H9zmOwBacpBJnpeP9dLmFgSMm3QW5ApT3DNpc6OUnX++Z1/2OlPW0
         JfS2gOF2KrWC7MpVwGWVfHgkQYoX11ypgQ1P1c0SnKmppkNW+PbeDaGH0c6xSNQbsTUQ
         lvJg==
X-Forwarded-Encrypted: i=1; AJvYcCUh0uAQ98D2BCB474qUI+9ma0JmVJWPX5W9j1PBqmbD1cZeZKB3QC3YGJdAUqe+xV7cuZXTBEI39915XUEshfRIp+pVLIWCwVsEffg6TaoEL5OfAjhIrbTuLM3kiMRgAu2agNHutjd7OsZ28WgalAnJkU+cFVxfl11FBAnGwelztsmgXKFpkHs=
X-Gm-Message-State: AOJu0YwbkNSLOhYPBsUSjaKaI5H4QvVx+EUsB2gmRfUwv3UQLw5xyVe6
	DWuzpb/EabTe/8eCza/785yvM60SfW/2jEQdqXamFJHPqkPU3ro5
X-Google-Smtp-Source: AGHT+IH+gxN9E8fHWuSmMXocPzJ9T2AXgJcjYgzjKONVLCGLJxcRC0vmmheNtdWY/aIRZcG7z5RM5w==
X-Received: by 2002:a05:6a21:348b:b0:1a1:480b:2565 with SMTP id yo11-20020a056a21348b00b001a1480b2565mr1296139pzb.11.1709384495841;
        Sat, 02 Mar 2024 05:01:35 -0800 (PST)
Received: from HP-Probook ([2409:8a6a:542e:2bb1:eecf:f4e3:bed5:7eef])
        by smtp.gmail.com with ESMTPSA id lp14-20020a056a003d4e00b006e5eb3cba7asm1087061pfb.96.2024.03.02.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 05:01:34 -0800 (PST)
Date: Sat, 2 Mar 2024 21:01:37 +0800
From: Jianhua Lu <lujianhua000@gmail.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd
 negotiation support
Message-ID: <ZeMjMQtQbT7sUX6x@HP-Probook>
References: <20240227124529.12926-1-lujianhua000@gmail.com>
 <2f6a5c83-69a4-480b-a235-c0d51feac31e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6a5c83-69a4-480b-a235-c0d51feac31e@linaro.org>

On Sat, Mar 02, 2024 at 12:58:57AM +0100, Konrad Dybcio wrote:
> On 27.02.2024 13:45, Jianhua Lu wrote:
> > Add usb pd negotiation, but charging is controlled by pm8150b pmic,
> > so it can only charge battery with 5W,
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > index 6f54f50a70b0..ed103b90f4e6 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > @@ -636,7 +636,8 @@ &pm8150b_typec {
> >  	connector {
> >  		compatible = "usb-c-connector";
> >  
> > -		power-role = "source";
> > +		op-sink-microwatt = <10000000>;
> 
> Is 10W really the minimum value for this tablet to function as a sink?
> 
After testing 1W, 5W and 10W, 10W is the minimum value for this device to function as a
sink.
> 

