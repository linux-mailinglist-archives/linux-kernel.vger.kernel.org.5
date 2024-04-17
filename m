Return-Path: <linux-kernel+bounces-149281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C42F8A8ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF441C2137E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB515FA7A;
	Wed, 17 Apr 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXMbGQ0g"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C688F4A;
	Wed, 17 Apr 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713392951; cv=none; b=DyaqZk2MBOyROzZJjAq77XVCwjpnUUzznzl0tM5ugUhI6RP70rYNts+QeZHbf8PjjPEyxg3g/VJcHVFPFE68GIPcnvmQXvAQkhTNXlk6t1t8FYUuGRP1JBIEuwiiDEdun8/Oz1HgfF9DqpW/ZDiKneZwm8IFKxfvDdhwcpKANxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713392951; c=relaxed/simple;
	bh=DXFECNrG2LGr6f2bqxaSK5gJ6KTEgYxluhyh9soI/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgSUS1tPIiujIo+NtC518GhxLSiIFp5qr8XaGQe/EGAJkcHupIxckFiV2WLi6KuH9CVnPuZ0bcZfrPiETYmyHY7q8izkYUs9o1GtMN80R4/gacHqDCNWS3kfUE/Fs+6Ehf/KPBMrrvA8w62PVS/QeBlKlDgHCA3zR5DsFcwehvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXMbGQ0g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so2216085ad.0;
        Wed, 17 Apr 2024 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713392948; x=1713997748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sdToBI2qrP2UM7XDTtIjy3FZrvOlQ2+KSl1qhuMvq8=;
        b=mXMbGQ0gIsf+fF96whyyQ3mNu4usE8N1fXfVBTusao3EfiLawpZhDtZbgNIJPuFX4l
         HfR0bZZxrqVju6KrMqcKO6b2pvONGZakU3gwKXb6KeR0+0dIwChBbRsAgBPhz82N5T8A
         s4H+lCPM+9mo02n1T4w/p67wYiApdAVHfeO/Rcj6uzFwxMHiKxyv9HdNlzNTphbBDmrX
         yP4qlnfY9rz+B8+ZVkXh3oYSzjqnUpua3pEbcu5kZa+kXD9FfG3yPGfg0LIn/ep9L+/M
         KKRwOGb4gWp7Nx/bpQxn6osOghP4pQs9WgcgrRTkqDABh/pb1udLcOklzF1rwJOurUuq
         Ud8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713392948; x=1713997748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sdToBI2qrP2UM7XDTtIjy3FZrvOlQ2+KSl1qhuMvq8=;
        b=pi8X5Wye0xV3JKsMjs7DFeG8Wb1zBVW7HvdUdHUcDgG1iWk1Ep0xDg7j+1Ri6tJ0oU
         uq+H/Qo2yniE61hGVT8G1JcAs0rKQdTOejc4ekyaM3U9rv09AZGYLGFLXQAdP0HPJILq
         TMiAwsgrpI+2coGFulm7+0hOuQiaIvPTd8dw1jqlJYHUZCKoPUPZFkbxRRRtP/pdN7s/
         Kctsl/R4e/DZCRD88RUc1uIkvoqGcCCbjlRreSIYABmw4+vsBMvbfqFeNOA1S+IFmRWN
         a9QyqculeF5TrgXI0jyw13JF0sQvRtndIxnT1PX+H59595z8yjabZCvJkoKy9jlSIBrW
         l2rA==
X-Forwarded-Encrypted: i=1; AJvYcCXqgsj0T9qSvkDG6ABOIam0XwhZhhG3p2zTPrrzW39DwK6nha16kDFqZTmbRlVNHphKe0Lv4D1326EAQTwIFEUlr/JGWIGZVliBCzRKGleiAibXxD4DST5QroQXfb2m3Frp4iVVkoFohCmdCB2EcrDMjJL+GjklPiN/GIrAOFvQpSYA5TMBSvfnkg/d3a/ODZMgPPbAKnNEmgEOSEixfI5eUYRApQ==
X-Gm-Message-State: AOJu0YwWKVMp7yBkFEuKazqM6p7PXIpahIKhOu2sBVoIA+0XigypnUJ2
	hzTzAGjtex3pBCaYEz7weQP9oow3izEh6XxNKDawhRM+prrHHeOZ
X-Google-Smtp-Source: AGHT+IFak3Y+ewGewlrJJrqi9KjmRUiOX4GcEera9tw5FnLyEXzLUtRYNdvtE83U8Q9pkC0fZOqmtg==
X-Received: by 2002:a17:902:da85:b0:1e2:a5db:30d1 with SMTP id j5-20020a170902da8500b001e2a5db30d1mr655194plx.13.1713392948436;
        Wed, 17 Apr 2024 15:29:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7417:8229:31c2:2f30])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902b41200b001e446fe6843sm144639plr.79.2024.04.17.15.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 15:29:08 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:29:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 0/3] Add support for vibrator in multiple PMICs
Message-ID: <ZiBNMUrNbxx5NPg-@google.com>
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>

On Tue, Apr 16, 2024 at 10:44:31AM +0800, Fenglin Wu via B4 Relay wrote:
> Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, PM7550BA.
> It is very similar to the vibrator module inside PM8916 which is supported in
> pm8xxx-vib driver but just the drive amplitude is controlled with 2 registers,
> and the register base offset in each PMIC is different.

Applied the lot, thank you.

-- 
Dmitry

