Return-Path: <linux-kernel+bounces-42287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4B83FF26
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24C11F23586
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC74EB30;
	Mon, 29 Jan 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ktkcbnqt"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF264C3A9;
	Mon, 29 Jan 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513966; cv=none; b=TWqYW43BNeG2QGbScTHeuUW5uXuy8bamvoRd8SQ1r2MRxmfQ5URv0mN5P1Acgn9Noiqpj27TtY95lfMXnDEBSoQhQpEfSQ4T7/Ju2yygsMPk8Wnhm4pApQEdOdmOmrS4hObaGPx34lkHpZX4zx/dCvixJCYwRfLe2LMM/vV5i7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513966; c=relaxed/simple;
	bh=ud0/drVm7D72JBsX+4Qb9qLiI/5wcDFXfGpCKNWjTZc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C653qY+POBET2WEAPo1KsRFur/HFLXitQDIzUoUCOPI7Mfsdha5CC6/T4se1chLpyp2QXKetmWx2eKJM/SlCwZFH9a+FAFhN19AmMLYO7LEx8gpg0TiWeZPmjZAkUvbrKGHGRZp3MrctR5GjzaYcX8EbMbSucz9H6XQiAxErFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ktkcbnqt; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706513953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtL+amYsa1SIE2IJHAmNtDoN4s2BdOEcZ5ZmhpQDTJY=;
	b=ktkcbnqtnOzyLtZjoky1OOrr/ZXuVNKhAd/p8fPHS52+r33KM4d4bSvMlpO4e2a/gboOFe
	5VB25a5EK/o54vP6ReMWowJfEVUiBE1HchSgXN41EuI8u/Y6zSFnW8xf4ClXnt8P0kHxRY
	OaBKHHbAd8VFWIPz0vuTI80ua0G3u5Vn3G/brQHOZR4+Xg1muMQpL8/HXj0DxMy6NfOblR
	0jFIUjl1noVvQ1ehIUsZyG1L/mbnMcK0XgkksUkDpbx5dVvMRfCAylknkEM0hntj0dIjeW
	XBNPZ1EWx0b63ZhTkxawLfH0PAszMaqnzR2a5Hz1jJcXdjSRc9KyU3dJKIN3Cg==
Date: Mon, 29 Jan 2024 08:39:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on
 RK3588
In-Reply-To: <a5fb28fa0f973ed1393dc3edc6bc729c@manjaro.org>
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com>
 <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
 <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
 <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org>
 <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
 <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
 <5ef9bab979260884866efe30d19ba8f1@manjaro.org>
 <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
 <9fda41efe365241ce06bd58974c8e055@manjaro.org>
 <CABjd4Ywfy8zT4sJ5v77CZQ9BNC=nkB7ZQq3QQyONST7gVHq=AA@mail.gmail.com>
 <a5fb28fa0f973ed1393dc3edc6bc729c@manjaro.org>
Message-ID: <436a3e3afbd862743034ac50d1be43cf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-01-29 01:09, Dragan Simic wrote:
> On 2024-01-28 20:14, Alexey Charkov wrote:
>> On Sun, Jan 28, 2024 at 7:35 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> Just checking, running the test on just two CPU cores was enough to
>>> keep the package temperature at around 80 oC?
>> 
>> No, not even remotely.
>> 
>> I kept the continuous 6 dhrystone threads running on all the other
>> cores (`taskset -c 0-5 ./dhrystone -t 6 -r 6000`) to let it reach the
>> throttling temperature. This adds further imprecision to the benchmark
>> of course, because the governor might choose to throttle some of the
>> cores that do not participate in the timed benchmarking run, and thus
>> lend some thermal headroom to the latter. That didn't seem to happen
>> from my naked-eye observation via `watch "cpupower -c 0,4,6
>> frequency-info | grep current"`, although I admit that I didn't record
>> more granular logs of frequency states, and some quick transitions to
>> lower frequencies could also have happened on the other cores. Don't
>> think it's a major influence though, because a quick transition back
>> and forth shouldn't have contributed much to the thermal output.
> 
> Thank you for the clarification!
> 
> You're right, that might have introduced some inaccuracy into the test
> results, and it also made the tests kind of hardly repeatable.  On the
> other hand, that way the synthetic CPU test feels a bit more like some
> real-world CPU load, in which multiple resource-hungry tasks usually
> compete for the CPU cores and the thermal budget.
> 
> Though, as we know repeatability is the key for a scientific approach,
> but it also usually contradicts with simulating real-world loads that
> are of rather random nature.  Well, testing is hard. :)
> 
> I'll think a bit more about all this, and I'll come back with an 
> update.
> Maybe I'll also be able to join the testing.

Good news! :)  Thanks to Radxa, I'll be able to do the testing on my
side, perhaps in about a week or two.  If you agree, it might be the 
best
to wait for those test results as well;  of course, I'll keep thinking
about some kind of a test suite in the meantime, which we should be able
to use on other boards as well.

