Return-Path: <linux-kernel+bounces-30047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B81831854
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A11C2234C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D8241E8;
	Thu, 18 Jan 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmvdXQpi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C32376E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576751; cv=none; b=oImbCBSZv5sn/sVdao8sMKjzHpepPZKnnHuH/myXG8UZqDrW24QVZ4IE19gcTCv5vTnSasOxOM4NjngtKhElHMyLE8xnp+6cCG1LagCCVVKvg6r0snl+Dy7ezgKFKcdbwt15Qp7KM2mbMdnJZDdcpFQzPAcj/b1SXXTFegi2TTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576751; c=relaxed/simple;
	bh=im3zEfwggW0pRsIdyfxoeIUGy9kClHNiijPnCJvVGP4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=rqdSeL3dIjBzNvIIOaat5kq+Q4FtCYkzTvdOatw+JvXrx/XKZt6bRe4Trl+sKOORDDx4j87ax1qv8VIHZSfrLfUr1J9I2jgDg6YTWXabHhBLP+AkCthGAAcGWm4Oa7e5rHGellAVYLys4yfuRIgYYjn181H7fS624supWuM/gZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmvdXQpi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso14061827e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705576747; x=1706181547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDFd66KcIbKFIIX/WcgTl2/WLahORWiu0MGU1O5cSMo=;
        b=vmvdXQpideJIylhyq9YVSeBcB2tR0IY7j+IvsSR7Wb2ubJzgEaV/BdIozko7u3Qd53
         0LsjuPBjWyXYP1WdDdplqULvNQm/b085fUA6EJCQjoHTpjNsK7kxv5nnyHCDzRqi7/AW
         Rv9dcDj1JbYMwdmnKoHKNFUiyB5cP1wT3AcLvxIPj6aQRC4EBs+RQ2oSzJIz204HZz/2
         vnWMIiWUW8R15QMbD1etZdkojf+T3G2M3bVoBMFZUH71dEWYeHenkPUa3/zIEArVeu6q
         c1ia3UDHeGBqp/qQPnJgGlZJoq6fBCI+Ab9j/W/+gDHmVnQA1dEyMkBaCH8otbhxbMDV
         517A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576747; x=1706181547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDFd66KcIbKFIIX/WcgTl2/WLahORWiu0MGU1O5cSMo=;
        b=s/VKe4pKZmDid/fWglhDCuNv3dl+QjS6x2PB/v5fMlc+6sE3jkYCr1/LUvhlRI8tkb
         MDv2bHFY85xIg+IRklx4QLd8/Mr3mUcvGiIKGf0+qVIO/kHyLz0c8PP+vm6eg//HcQrh
         tlJg8jvwllmiwJKT7/8GdMGzOP5OuXU2NB2SpXPc1WPi8vVzFSiNCZ+2iCCvD2QRBNfy
         berzyp2mCsM/dvnoWyedYl7QjsWcvca9iOGo2dn4nKzpDmLw3k3Ms2K8rcclCmLVnlw9
         QfI53I3itYa3Lw3U/xeJZqXR7D5nNYOVbqlNF2Y0TYJ2WplOk1PUP/ooqeAFU4Zu07EO
         MBRQ==
X-Gm-Message-State: AOJu0Yx8r7f/noEI4cZaFtaSyU19LaSTsFz+G7QoSDD/AazI++fjdIp2
	+UJ3aBbvpO622sJQgNRJ2rqssT45QoyyAO+g8FvfZXeaMNK22tVmlZXiiRgDEDA=
X-Google-Smtp-Source: AGHT+IHqoe2TVTZTVhMTb7zPOZYWEj/lioFMe60pwfbBpenxG7wEQKyuG3YE/bPiO2Lu8eFVuFv6CQ==
X-Received: by 2002:a05:6512:4897:b0:50e:d5ad:9414 with SMTP id eq23-20020a056512489700b0050ed5ad9414mr386800lfb.50.1705576742745;
        Thu, 18 Jan 2024 03:19:02 -0800 (PST)
Received: from [172.30.204.173] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n22-20020a0565120ad600b0050ef97332cbsm601903lfu.32.2024.01.18.03.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:19:02 -0800 (PST)
Message-ID: <4c4d7469-c28b-412d-aa30-7123d3c98d1e@linaro.org>
Date: Thu, 18 Jan 2024 12:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Update generated headers
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@chromium.org>, Connor Abbott <cwabbott0@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Akhil P Oommen <quic_akhilpo@quicinc.com>,
 Douglas Anderson <dianders@chromium.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240117203744.394260-1-robdclark@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240117203744.394260-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 21:37, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This updates the GPU headers to latest from mesa, using gen_header.py
> (which is used to generate headers at bulid time for mesa), rather than
> headergen2 (which doesn't have proper support for A6XX vs A7XX register
> variants).
> 
> Mostly just uninteresting churn, but there are a couple spots in a7xx
> paths which update REG_A6XX_foo to REG_A7XX_foo for registers which are
> a7xx specific.
> 
> Cc: Connor Abbott <cwabbott0@gmail.com>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

