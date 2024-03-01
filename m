Return-Path: <linux-kernel+bounces-88071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACA86DCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EFE1C22B21
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AE69D28;
	Fri,  1 Mar 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aexe0ZLN"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44B69D25;
	Fri,  1 Mar 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281511; cv=none; b=ixQJIui6eeL5woPjJDOn5fHdvroVDBIHY+ExjcA7IgTbg1x0uBj1hSVRo++R+KRGiTWzgIPEgIHtO9viNLzeMgxPAEJ2WyQSzJCkp2nSSA9fq2QENS5OeuyTtDiTkQGziH2c/1zZOYDTJnYRoDj+3SQWlWKDLAj36OV+nYDVUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281511; c=relaxed/simple;
	bh=X4RuAEbCwi7LK+wrIeZK9w07Qub5Uxb8j6kTg3iOLfI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZHEkuOJ7V1g7+Nip2+Nyi8lkiXfR33Onq25XdjFs25GiYKkCkiip0K5LB/eO7UrSANGo/tOT/sYsnr02VMDTwHLdbSer/1OlIGftcn51bR64AR4i4k6PvsJ3/bpYw3L1Fi/2EXgAIrZIKxHCdvGHs0FpHc1joPXVFq7OqwucQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aexe0ZLN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709281507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PML2KXW2NNHKig0QUJIbOqrTp9cjXhSc3Xi08SDJ2+4=;
	b=aexe0ZLNbDKkg3CyRRdMeFW2hP8JVq3Si/3axw4AXvBM5sKWsTH0ZeW8kptyRFqeP7y/gl
	SuX1UIlzo6PjaFE17g7+ohi8JC+ld5kGeyiAJOYBl6BzJIfPDJQy4WnbL4S6bLSwb4gQnL
	hAuk0bf1UcQb9BUGltiQytmPW+uyBksKZpcoGVuRgsHdqpVOn/IJhX+cuSszim35vG0cXN
	oFo7Nmex0agyQnFEyrXqcSredmgCUzcO87JTcoDZxPjGiwovxLiGihVAQ3PJToCMad2M/7
	LNsD2KCiWBqe1lGazWjpUxdye3+DAf4661WuIdh/YTnqMok+IyaRehDPaHcpog==
Date: Fri, 01 Mar 2024 09:25:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu
 Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] arm64: dts: rockchip: enable automatic active
 cooling on Rock 5B
In-Reply-To: <a8ebe39b28a34c3544481a4e43e61d2b@manjaro.org>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com>
 <823379825559bb76088c31f44f998dd3@manjaro.org>
 <CABjd4YybaQnKm+VpU_xVrCb=pxQ7oQXPHGZzn_u1w_h3yn7gwg@mail.gmail.com>
 <a8ebe39b28a34c3544481a4e43e61d2b@manjaro.org>
Message-ID: <b16f1d40549554598a3658679ceba9bf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 07:17, Dragan Simic wrote:
> On 2024-03-01 06:21, Alexey Charkov wrote:
>> On Fri, Mar 1, 2024 at 1:25 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> On 2024-02-29 20:26, Alexey Charkov wrote:
>>> > This links the PWM fan on Radxa Rock 5B as an active cooling device
>>> > managed automatically by the thermal subsystem, with a target SoC
>>> > temperature of 65C and a minimum-spin interval from 55C to 65C to
>>> > ensure airflow when the system gets warm
>>> 
>>> I'd suggest that you replace "automatic active cooling" with "active
>>> cooling" in the patch subject.  I know, it may seem like more of the
>>> unnecessary nitpicking, :) but I hope you'll agree that "automatic"
>>> is actually redundant there.  It would also make the patch subject
>>> a bit shorter.
>>> 
>>> Another option would be to replace "automatic active cooling" with
>>> "automatic fan control", which may actually be a better choice.
>>> I'd be happy with whichever one you prefer. :)
>> 
>> Sounds good to me, thanks!
> 
> I'm glad that you like it. :)
> 
>>> Otherwise, please feel free to add:
>>> 
>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> Thank you Dragan, much appreciated!
> 
> Thank you for putting up with my nitpicking. :)

Perhaps the following tag would also be deserved for this patch:

Helped-by: Dragan Simic <dsimic@manjaro.org>

I hope you agree. :)

