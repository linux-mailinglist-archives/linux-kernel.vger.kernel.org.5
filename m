Return-Path: <linux-kernel+bounces-88437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7877186E198
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15762820CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F46A8D9;
	Fri,  1 Mar 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="a3hs1+1f"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D640BE5;
	Fri,  1 Mar 2024 13:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298673; cv=none; b=dHd5AW//tn5waFxRpYUu4i7fSzIaK7YriN6OG5J78o1/BqxzmKZxMJ5CiwXsP+lCFA5+WlLb8gd7PF9T+o2vsDUy0fHztRbl6TDGZsLtF8dcyIcQaDF3VBBiXfJrXmVt9TguWvEBPjiikRs3rDmH8rrirgCXA/i09DpPy3ST0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298673; c=relaxed/simple;
	bh=2vqK4pQX7osqKFRNzAZNRnfWBu5U2CJo6jIYRgshkyk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Eik9VBtQpB+n/cVhpvgUf8wn9NtPK4C2cSNC8Bl0b87C5Qapk0NycNCzUv3ElYMBjFytfv5/7jizdCMOnfnJraD5ijmlfDF86eXPrdnuzru4n+aPw6ftSKuTQqwApFps62t6cVuWZRzuT58G9+NqaEkdsvj3/tXd/cWJ7d5iyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=a3hs1+1f; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709298667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pARlF+NGAspV2QL6E9uhUMg1sZQdY7U/4Iec0zryMSA=;
	b=a3hs1+1fIzU53wCY3lb6T6qn4rGB+TdDENM0Zz7Be/qBbAACfIHP4/G+MvAgciRwK7jnCa
	JrFf0HAEWf2Y0PRr29nbKdW2/tADdqRbV0eFUsR+1A5q8/RKxw6BnH1oSeRQjSWD9zw4By
	sSSwOTAZ6N3C5dsvdn3v9hX+dQFQMBz1d9P+hk3uaQBaDKCmp0TCPZd/YjfAnNO8hlRMxQ
	QNW87CXgXDA17ZLl72ikMEOSOof0asGr/k6kv5y4fOy8PbSbPeAW5wTDD50IUOFUepfTN5
	4Y4AZMaBTYkokM/WdBX37CJhBiW0zeqr1Cfd+DVre0H8VMRrsL7rpkdRtfBidw==
Date: Fri, 01 Mar 2024 14:11:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: wens@kernel.org
Cc: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
In-Reply-To: <CAGb2v66Fg5dA_p+O9o=1+jkqdGREi_AD73o-J=e3dQ4EoEArjw@mail.gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
 <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org>
 <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
 <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
 <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
 <CAGb2v66Fg5dA_p+O9o=1+jkqdGREi_AD73o-J=e3dQ4EoEArjw@mail.gmail.com>
Message-ID: <c58ab785f5d6176fe0e1843f151e7f1d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-03-01 13:02, Chen-Yu Tsai wrote:
> On Fri, Mar 1, 2024 at 7:10 PM Alexey Charkov <alchark@gmail.com> 
> wrote:
>> On Fri, Mar 1, 2024 at 12:52 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> > On 2024-03-01 09:25, Alexey Charkov wrote:
>> > > On Fri, Mar 1, 2024 at 9:51 AM Dragan Simic <dsimic@manjaro.org> wrote:
>> > Thus, who knows what might (or might not) go wrong if we don't reset the
>> > PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
>> > things aren't that straightforward.
>> >
>> > On top of that, some boards, such as the Rock 5B, use a few additional
>> > discrete voltage regulators instead of a master-slave PMIC
>> > configuration,
>> > which may actually introduce some weird power-related issues, which also
>> > may be intermittent.  Actually, I've already overheard that the Rock 5B
>> > experiences some issues of that nature, but I don't know the details.
>> 
>> Those discrete regulators seem to be out of scope of this discussion.
>> 
>> I agree that a deeper power-cycle with proper power-up sequence to
>> follow it is better when it's available in the respective hardware.
>> I'm also happy to provide a follow-up patch to switch from CRU to PMIC
>> resets for the boards I found to support the latter.
>> 
>> The question we have at hand is solely about the default behavior for
>> a hypothetical new board with minimal .dts, or an existing board where
>> we can't determine the wiring of the TSHUT signal:
>> Option 1. Let them stay nice and warm at 120C+ under load, because
>> they should have known better and should have enabled the TSADC in
>> their device tree before putting the system under load
>> Option 2. Get them passively cooled at 85C under load even with no
>> heatsink, then force a CRU reset out of abundance of caution at 120C
>> unless they defined PMIC reset in their device tree
>> 
>> I'm advocating for the latter.
> 
> FWIW, the CRU reset is what the kernel uses for rebooting the system,
> either during a reboot or a kernel panic. So it is already used for 
> both
> normal and abnormal scenarios. And yes, it sometimes leaves regulators
> or other parts of the system in some weird state that the BROM isn't
> expecting.

According to drivers/mfd/rk8xx-core.c, some PMICs (RK809 and RK817, to
be precise) already support taking over the board resets when configured
with "rockchip,system-power-controller".  Perhaps we should do the same
with the RK806, to avoid any possible issues with CRU-based board 
resets;
I'll see to investigate that further.

Not all Rockchip PMICs (RK808, for example) support software-initiated
resets, unfortunately.  According to the RK806 datasheet, it seems 
capable
of that;  see pages 27 and 28 in the version 1.0 of the datasheet.

> Why should a hardware triggered reset be any different?

According to the RK806 datasheet, resetting through PMIC(s) causes the
PMIC(s) to cut the power rails in a controlled way, i.e. with the 
expected
ramp-downs and sequencing, and the SoC then wakes up in a state of the
regulators that's exactly the same as when it gets powered up on cold 
boot.
Doing it that way should be better.

The reset procedure _should_ be virtually the same for all Rockchip 
PMICs,
but please don't take my word on that.  Resets are described quite 
poorly
in some PMIC datasheets.

