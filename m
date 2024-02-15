Return-Path: <linux-kernel+bounces-66569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89C855E66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC811F2426C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE41B978;
	Thu, 15 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKs045jm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCB1B952;
	Thu, 15 Feb 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990027; cv=none; b=nFP+eOmLuUe+ccfkCy3B0u8Rt6dx13qAXQ9BW03lk9vP8mwWIVLRZIGlY8jVvBJXdw1WfiPWfDBi1ProhCI0+NJ2pQGvTrw7IacEtFWfVjgk40bpPYiN//uVNhnAr7+/qViJW0no+I4vl/nJJnhrYyDVtd2Z6Zp0I3lIxluoKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990027; c=relaxed/simple;
	bh=jF7g/BNY1ew/ksUnMTv0LSyOc1c7mlln2aCKdpP95RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hxg8CN7OYT4lFSnQF0AdfPtzi0+/OSRx31/RRBSQeTDjt6BNZu1czF9f1RP4AlU/luKrdGfh/BK2mqMT8OaxFAj38+okS7M5GIWLkaOJpOuSjYAjBpzaHn4hKU9PtbgZ261M0WPP6OdWYsAt5c77zIX0j8Itb+oTC0kZWMBF5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKs045jm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso733302a12.2;
        Thu, 15 Feb 2024 01:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707990023; x=1708594823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jF7g/BNY1ew/ksUnMTv0LSyOc1c7mlln2aCKdpP95RY=;
        b=BKs045jmn+XPcC/qtrGRgFGrFwNEC0woHPLcpU/7OaLvR8VgoqUT0i7BO190op+bBi
         iLfJ3KDngIiqppHnasK4i2wOtgycecq2Fzlo5pdJa/5HpCO4Ex9D2QRZnfbqWE0/2iEm
         sA2QGF45wPORWmM/mkK8UVVuyMhcpik7ju3/4Sh7al+XZyupsmqtlgLBWK6tXt++Zp18
         2x+a6wTnkLXMJPQopjWa2OYAQSUTnGsS6cKpCwh2KWr4BDJhtKfDwqlMxLW+gtK+J9mY
         alboXoTWcBU7E//JjaRsjQNN/uF52bgNHktY/95oCPBAfGLlqDS+6ksFXD73jxvbWf8X
         ZQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707990023; x=1708594823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jF7g/BNY1ew/ksUnMTv0LSyOc1c7mlln2aCKdpP95RY=;
        b=G67JKf28V8Q5NJCIuoPPBK0uz2bS+gOKw1Q+QgQr1uY6sC6NGcQK5qRF5X8CCNXJHf
         HNEUf8MYxkWT/c0iYBstNHQAtSbqILWud3qP2oP7V/vqxyfa5I2nw1fOg0xZdwXxBcA9
         NcVhVRhRInge8QAtGJ4jvhwdBmzbEToxDPE7ChLp4IhJYyHw6eNU86rEJiVTitT0oO7z
         qNufWbDHRtkTXQorNi3E+ohtfKMb+V8snVV/lT60tubED0JTQtM01Gu35WLGM/C+vEvb
         IQdJmLaSnKMPc0B3O2ft8rrncLSLtxtZD5ntps+IpOi7ZxLZL5NeeN5zJFQ0hortmEL7
         MHGw==
X-Forwarded-Encrypted: i=1; AJvYcCUDw1cKFZWpp7UAYepkWTIONkl0384r2VX9XVslDllVfuRZxLJrpjnxEFT9kxAEKVUiHUQj24V4l2LSTphO5+/4Z8GNw343Ip/VAV401nnrTHDrI+J9GYw4II5gc4ALy29AVDWXnFmWH6yrqKq9GrQ7TItXDblkUMAC/W+NlNdPxJ5C5auUWFQ=
X-Gm-Message-State: AOJu0YzHzrGn7IF4hTYPyTQx2wHnRJDDvBK0sWpeHCa933JJPZE+Pfga
	T+nij0QYBVwoX3zj2Tszptfyr6pLRHZR7JtK4+BsKG3ehOlX/8EC
X-Google-Smtp-Source: AGHT+IF7eZeenH3Tp8rtyK0+O82Ksc4ZZLSvY+q0z2/DD+UkdP7PUH+0s6Pg+tGjJfC9XxbAIPoU6Q==
X-Received: by 2002:a17:906:da03:b0:a3d:1249:25dd with SMTP id fi3-20020a170906da0300b00a3d124925ddmr780139ejb.15.1707990023176;
        Thu, 15 Feb 2024 01:40:23 -0800 (PST)
Received: from [192.168.3.32] (cpe-94-253-164-151.zg.cable.xnet.hr. [94.253.164.151])
        by smtp.gmail.com with ESMTPSA id v28-20020a50955c000000b0056003b75400sm396834eda.44.2024.02.15.01.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:40:22 -0800 (PST)
Message-ID: <db20d64b-cf76-4a93-896e-e501f0e1720c@gmail.com>
Date: Thu, 15 Feb 2024 10:40:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211202700.17810-1-ansuelsmth@gmail.com>
 <55fded4e-1c14-4f1d-a1b7-08fdbf05bfe7@linaro.org>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <55fded4e-1c14-4f1d-a1b7-08fdbf05bfe7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12. 02. 2024. 12:05, Konrad Dybcio wrote:
> On 11.02.2024 21:26, Christian Marangi wrote:
>> Add QCA8075 PHY Package nodes. The PHY nodes that were previously
>> defined never worked and actually never had a driver to correctly setup
>> these PHY.
> Missing Fixes tag?
>
> Also, could you please give me a link to the series that fixed this
> on the kernel side?

Hi Konrad,
Support for this PHY and PHY package concept was added in:
https://patchwork.kernel.org/project/netdevbpf/cover/20240206173115.7654-1-ansuelsmth@gmail.com/

Series has been merged couple of days ago so its in linux-next already.

Regards,
Robert

>
> Konrad

