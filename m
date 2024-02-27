Return-Path: <linux-kernel+bounces-83457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D558699A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D02292CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922F149DED;
	Tue, 27 Feb 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DoNs7ATA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3C1474D7;
	Tue, 27 Feb 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045885; cv=none; b=A+b9eM5dGPaX4/p4hT0zaOnLrDiw1b1SQvK1DGGLw1cmA6Edx8pjtnRgzWxs/c2oygudTiF2YyUo5U2uaVMLK8HPZRwO5j/cXjDTcQ0wBWc1WQz8qfsBnJjj9329dg/J8F3tANBaxuqZt/jUB1zRdAYdylLIOwAhW68nAn6TRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045885; c=relaxed/simple;
	bh=y1Ygv47ECIb/VfxJUSJLmULU1TrWL/0eo2q14QVsgbw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qSdtThfUbQh13PrQ/90MOrUmmCBjXsKP4n6CrB35ggrelsia4f3Ql8EwI71vZdfMtq2Z0zcdSjIQmu3+4WcpdaHzjhddRWx4n0oEx5zjo82ittEPY+hWuab4I3oCNo7aSPyA8TKJ0OzAQ2MvnITWaSmeMYrMDGMaIiI62hMBWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DoNs7ATA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709045880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTZuVi0d9uvRZL4My10OcZy9FBePsZQVwsZhJKzdOL4=;
	b=DoNs7ATAI7kNuKmqWQm1bN1fJwd8ZKY0K+/yD1DzuW7xgfvgw085ZOa2rLbXEDfuKVk5eg
	srCPtSdxKNKeetNpEEgERqTKNRJhl01qdjIWrF6mqwLnL911EQzC9pOB2B0RB+RhwGfI+V
	aClodNXyGmn3uX4EbE1IaAdiJWLtv8l0sFoBva7b/FMoo/kEbvZNDXIKly3UXMPftKJCA3
	LiOFFyDaOYXrbbcvBKBC+Ea9cL63jHxLMlniykE9TxQWcgADEZg2IPCCc77GRE4P5HcYUN
	aq/ErBLdPaNAPly9K2A59/SrjU2IsgIiVHHqLGWNkvBc9IzHVL0bVtOb9MVyuA==
Date: Tue, 27 Feb 2024 15:58:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add cache information to the
 Rockchip RK3566 and RK3568 SoC
In-Reply-To: <CANAwSgQnoBx+th6s254sML+Zw+RZQC6WU9TjfMoWgHxmCqbDcw@mail.gmail.com>
References: <20240226182310.4032-1-linux.amoon@gmail.com>
 <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
 <CANAwSgQnoBx+th6s254sML+Zw+RZQC6WU9TjfMoWgHxmCqbDcw@mail.gmail.com>
Message-ID: <4676da62ec0fc0fe89318baea0678e0c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-27 13:49, Anand Moon wrote:
> On Tue, 27 Feb 2024 at 00:39, Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-02-26 19:23, Anand Moon wrote:
>> > As per RK3568 Datasheet and TRM add missing cache information to
>> > the Rockchip RK3566 and RK3568 SoC.
>> >
>> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
>> >       32KB of L1 data cache available with ECC.
>> > - Along with 512KB Unified L3 cache with ECC.
>> >
>> > With adding instruction cache and data cache and a write buffer to
>> > reduce the effect of main memory bandwidth and latency on data
>> > access performance.
>> >
>> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> 
>> I was about to send my own patch that adds the same missing cache
>> information, so please allow me to describe the proposed way to move
>> forward.
>> 
>> The way I see it, your commit summary and description need a rather
>> complete rewrite, to be more readable, more accurate, and to avoid
>> including an irrelevant (and slightly misleading) description of the
>> general role of caches.
>> 
>> Also, the changes to the dtsi file would benefit from small touch-ups
>> here and there, for improved consistency, etc.
>> 
>> With all that in mind, I propose that you withdraw your patch and let
>> me send my patch that will addresses all these issues, of course with
>> a proper tag that lists you as a co-developer.  I think that would
>> save us a fair amount of time going back and forth.
>> 
>> I hope you agree.
> 
> I have no issue with this,.If you have a better version plz share this.

Thank you, I'll send my patch within the next couple of days.

