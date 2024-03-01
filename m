Return-Path: <linux-kernel+bounces-87948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A886DB62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451491F2570C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FFA5F56B;
	Fri,  1 Mar 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uzREwIOw"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826D2AEEE;
	Fri,  1 Mar 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273865; cv=none; b=BHP7dhkVU6edjnR7mi486OpTAeb5XkWTBd103o2Vm0Sdm8zJNJ6LeeW+rAn3u/9K6clkBeKriTfhYvTZuQzXtpwwn4Xo+U5vkiNaf3qoxqs51pxxS5+E0VegmsTPrTvI7RKLc57wRp1NDNyFaU8M1RQp0/hMnHKuNvmPYUor1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273865; c=relaxed/simple;
	bh=KDiNK9ricjIdH+Zaz3zhKZaXBNTwDcNlfRac4jYt/mo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RrCENulCU0U/ZKh6B48X+58PM3LAXW4RLPzcL/lQbyf3ERdapulJd3vk1+GLGX/lem0WPBQGMzpjIwCNjNjYFY3wU8qit0zbRAifVI3fDczzq8s4uF2h1UvLXZBQsnVKM2lILPuvSsI3Si0DfeSfbQpTHvH3ACzJzna3TfB7jWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uzREwIOw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709273861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsTeKM3b8pZiKwqdo+adsEaeHoiS6ettDlA19pqJem4=;
	b=uzREwIOwtJxK3R9slO4dYFrLEHEgUdVJiB/FnCVs9/Ff1+sd7br+LKBWocMPESjrC0s2A2
	jq+THKQYYQIMZMYYEovcr8kxY7tpwkbEHtYppYZdTniBh24k0aguUxvcGcX3uEu2ru811x
	XclzRAslMNARSFa5gWkUxqGWiDQraNtBokuUrmWiA309By/tqkVbdv7s4+wNJ8i5WJCviv
	7R61uhUJ83tGndfYT7mMGpgyyfx3qBCd7dDhsZJnaMD/2PnB4cD9UwhVblwk0cTK0GV91a
	FEjiUJkK1cj2WD5uPjiRdNvP4qcTXnvl+6dhe4kWbWzkuVybNRKfoqDp0llDrg==
Date: Fri, 01 Mar 2024 07:17:41 +0100
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
In-Reply-To: <CABjd4YybaQnKm+VpU_xVrCb=pxQ7oQXPHGZzn_u1w_h3yn7gwg@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com>
 <823379825559bb76088c31f44f998dd3@manjaro.org>
 <CABjd4YybaQnKm+VpU_xVrCb=pxQ7oQXPHGZzn_u1w_h3yn7gwg@mail.gmail.com>
Message-ID: <a8ebe39b28a34c3544481a4e43e61d2b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-01 06:21, Alexey Charkov wrote:
> On Fri, Mar 1, 2024 at 1:25 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-02-29 20:26, Alexey Charkov wrote:
>> > This links the PWM fan on Radxa Rock 5B as an active cooling device
>> > managed automatically by the thermal subsystem, with a target SoC
>> > temperature of 65C and a minimum-spin interval from 55C to 65C to
>> > ensure airflow when the system gets warm
>> 
>> I'd suggest that you replace "automatic active cooling" with "active
>> cooling" in the patch subject.  I know, it may seem like more of the
>> unnecessary nitpicking, :) but I hope you'll agree that "automatic"
>> is actually redundant there.  It would also make the patch subject
>> a bit shorter.
>> 
>> Another option would be to replace "automatic active cooling" with
>> "automatic fan control", which may actually be a better choice.
>> I'd be happy with whichever one you prefer. :)
> 
> Sounds good to me, thanks!

I'm glad that you like it. :)

>> Otherwise, please feel free to add:
>> 
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> Thank you Dragan, much appreciated!

Thank you for putting up with my nitpicking. :)

