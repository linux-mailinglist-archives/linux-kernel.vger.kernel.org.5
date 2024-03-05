Return-Path: <linux-kernel+bounces-91663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7418714CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B9C1F214A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAD3FE5D;
	Tue,  5 Mar 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNgosjcB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B153D39A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613336; cv=none; b=T7i7PIq611NpftTvXk3DSDGCsSnQmYTN/d0u1Xmw6c9KRXLOY/PMUsPSPHPgtroLDNs5HClWDcCRqY9XVOTxlapK4xEmLcOqpJekeVlAcsHrEYM4fkBoGloEL9GhK/lewKIel6bNEyYfzvJe1yFZMUnWIpQZD8qr5zeyIZMHPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613336; c=relaxed/simple;
	bh=asko4xyRiFAMzyuyOz9L46wLJOHHpA8t33DB/iA4nso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoMPbvv4Q03Ojj3AmGduY3QRlmP9AASOHfFPFoWWR5Dd2tnjrNPxiDmb91+xPyQXHZCaba2IRnE4R+fsMqs8nQKZf9EJqxaFjd3XV/4ddgh8L29PMQbm8CAD7YrecfhePpxTzuqwWs/iUcMvvrqQTM+DovSHZb+eWXS4Qfk/Hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nNgosjcB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so2180381b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 20:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709613334; x=1710218134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+cJ77QUjFvy52iS4N40eKiVLlok+nrPIGL+OqwFVkI=;
        b=nNgosjcBqbgZ5iF1d0p05jyhe+I+xbkbqH1/AQMyGbhS6v8iBXNIzJvIH/thmaIKaN
         2+U6qAuTcP3V8vUmiq6Wac1VNeJpCDsOmoSsjI6WyafJzNGk8qtpd42dxuc70DMLZy4u
         OJ2E/r9SWUTAmotTmSBn4nM/Bawm8QlqSBI+wlYfvzxQtUCC8lDt5gr9qWiX2pB+y3Ek
         e0m0I5CmrAW+6jjG8SsQQOpGncotIFzI2rXOxoNlikL8T7Nxru/k87mjffTO6dK51+1N
         X3NdJ6fB9blyvFcmUYW8u8jUPsyHs6QG57cXtpiV0/lzyJFPhQnOzzGr22PDQHKWIQxD
         /z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613334; x=1710218134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+cJ77QUjFvy52iS4N40eKiVLlok+nrPIGL+OqwFVkI=;
        b=FWiR0S0NEwys016fxchmLxzgWBiMVmoywmL0DLDlnagkt1exGi8qIChohI/wRwV86Q
         Tsnt7QYXAq/kKs9m4Bolj8C3VQoR20xZ7L6CILXS+1G+Efi1BHUAFblGf8oKlUgoH5xE
         0Y0Gkbr4Cy0iYUVGLVxM5bpsg0kWOiH8TTu6aFR83SZQBNJoa44yw6IXhqkcMZdZyk8U
         asKZuPRPl3infq21RbhXHwJvJmsCSVBaou8O4NGr2nTg2aTJ5LvYukz23lrWDJ9ETswO
         9rdUUwGWuUPvakr36eG6dRE8I+PTMzfoSlS5T+WNQj/bfY3RVQyWOf3F0kUuKsfeLstn
         PyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMJxxaIgiCY8+s960gFdwDI5gnxzA4UeiLCXiU5q9VCOKwGhTX6HNyqixYJBzGgiJRbKjT51Y4Z509Q6eSWXIdH5RqaecppaW69y/L
X-Gm-Message-State: AOJu0YyIuBMuV+nTmvg4T9S8J1HemPNVNoIg2eAJZlZOkVGago2qLEMd
	0uSVxBXQswAOTJnia6qu4QYFyIWuJpOhEjYIR1FpjIEBvRnXaYB+Bgv05RNDvs0=
X-Google-Smtp-Source: AGHT+IFmsqctG2F0e+DwL/+iKElFo8vsOSL/VgfrJGEJ1PK1BW1N4F1HSiiWpIqpVyCdKNpW2+EDfA==
X-Received: by 2002:a05:6a21:1707:b0:1a0:eb42:a708 with SMTP id nv7-20020a056a21170700b001a0eb42a708mr943561pzb.18.1709613334025;
        Mon, 04 Mar 2024 20:35:34 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id d15-20020a63fd0f000000b005dc87643cc3sm8236234pgh.27.2024.03.04.20.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:35:33 -0800 (PST)
Date: Tue, 5 Mar 2024 10:05:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cpufreq-arm tree
Message-ID: <20240305043531.anlwwmlu6hwogxxa@vireshk-i7>
References: <20240305110914.69ed133b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305110914.69ed133b@canb.auug.org.au>

On 05-03-24, 11:09, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cpufreq-arm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/cpufreq/qcom-cpufreq-nvmem.c: In function 'qcom_cpufreq_kryo_name_version':
> drivers/cpufreq/qcom-cpufreq-nvmem.c:194:14: error: 'QCOM_ID_IPQ5321' undeclared (first use in this function); did you mean 'QCOM_ID_IPQ5312'?
>   194 |         case QCOM_ID_IPQ5321:
>       |              ^~~~~~~~~~~~~~~
>       |              QCOM_ID_IPQ5312
> 
> Caused by commit
> 
>   006af7c6958e ("cpufreq: qcom-nvmem: add support for IPQ5321")
> 
> I have used the cpufreq-arm tree from next-20240304 for today.

Sorry about that, dropped now.

-- 
viresh

