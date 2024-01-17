Return-Path: <linux-kernel+bounces-28680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4C8301CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D703B24FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A1134BD;
	Wed, 17 Jan 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fU3OzOqE"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF512B87;
	Wed, 17 Jan 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482071; cv=none; b=my5ztI2NoGxhTsRIJ3Tg+Lia1Ig6RjPsinPrxi9lJmbOZDps5x9caL+zFLrfASwrTUf9gKd8x6jP5GJ142rUIu79f76kPggcZGILgWrn1zPg5j5lbm1HWOkDv1MLe0lFBwcnrlm1tHTf5X33t7kU0POe10dysYUaAmgp3sPGVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482071; c=relaxed/simple;
	bh=La95r08GMz9oH6CnnrtX4VcPxFLbCfFjHrViRhSROk8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-GND-Sasl; b=Pk5RAmPWiMpOrAvq8eZs6hlnWw3RV8W/ESkbxjC5CYaSjxq8LCnWBf7vndY5j5zcCWklCLO5Gx7ZS4SRzqE8Y0s9XnxCKQz5uLnz13jUTuYhPB13VxLGpL61obtCyjxtip8n7vkWXecuQfyILMXPNiUpChNXRPJTyRPYeZ/n8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fU3OzOqE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E19F420007;
	Wed, 17 Jan 2024 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705482065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuZ4Un0BLQoRBChJAdwuRDvUgI+N0jme5H6MO6JTRFE=;
	b=fU3OzOqETpVFcXb3/GD+j0na9pcmogonlSJTPxORlkIAt5Uzd81H1ugw6pyookKIewUEoM
	fK4U17jZZkMPT/vS0RWwrDuqtm16gx0pjknvQSVPpfeNNZ/ECYiTRQ+5lIaNa8cagEASrk
	lBMNMwsh4s8HeDZrvE3u0FyaTteWBkgzkzdp4iQHOvoRQEQe/mMmOM893UItPgrn3yRR0Z
	J3Io3VgwS3nkrsA/CbbqOdv2YBdIOwV93yAbD3isfdYt8g6B60B18R7BSKHogKLj2tvJBN
	7ThJLsQj0hU7vN1J8W6Spi1fGr0tSTnptNCXjKXnJGHFblca7ryB4Q/M5NKb2w==
Date: Wed, 17 Jan 2024 10:01:02 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Message-ID: <2024011709010227b73d33@mail.local>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com>
 <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
 <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
 <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org>
 <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
 <20240116165356eaa221fe@mail.local>
 <CAJRtX8S9dQddoxWv9T36i852ZgX6x-kjYvrGvRNd-2cXD8B=wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8S9dQddoxWv9T36i852ZgX6x-kjYvrGvRNd-2cXD8B=wQ@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 17/01/2024 10:54:08+0800, Jingbao Qiu wrote:
> On Wed, Jan 17, 2024 at 12:53 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 17/01/2024 00:29:28+0800, Jingbao Qiu wrote:
> > > On Wed, Jan 17, 2024 at 12:03 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 16/01/2024 16:51, Jingbao Qiu wrote:
> > > > >>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> > > > >>> module has an OSC oscillator
> > > > >>
> > > > >>
> > > > >> I am not going to read pages of description. Please write concise replies.
> > > > >
> > > > > Thanks, What I mean is that this hardware includes two functions, RTC
> > > > > and POR. How should I describe their relationship?
> > > >
> > > > Your POR does not need to take any resources, so no need to describe any
> > > > relationship.
> > > >
> > > > ...
> > > >
> > > > >>> Your suggestion is, firstly, the por submodule does not have any
> > > > >>> resources, so it should be deleted.
> > > > >>
> > > > >> So where did you delete it? I still see it in this patch.
> > > > >
> > > > > Should I completely delete him? How can a por driver obtain device information?
> > > >
> > > > Delete completely.
> > > >
> > > > Device information? What is this? We already agreed you don't have any
> > > > resources for POR.
> > > >
> > > > ....
> > > >
> > > > >> Device is only one thing, not two.
> > > > >>
> > > > >>>                     reg = <0x5025000 0x2000>;
> > > > >>>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> > > > >>>                     clocks = <&osc>;
> > > > >>> };
> > > > >>> However, in reality, the POR submodule does not use IRQ and CLK.
> > > > >>> Please do not hesitate to teach. Thanks.
> > > > >>
> > > > >> I expect one device node. How many drivers you have does not matter: you
> > > > >> can instantiate 100 Linux devices in 100 Linux device drivers.
> > > > >
> > > > > I understand what you mean. A device node corresponds to multiple drivers.
> > > > > Should I completely delete the POR device tree node and add it when
> > > > > submitting the POR driver?
> > > >
> > > > ? I wrote it in previous messages and twice in this thread. Completely
> > > > delete. You do not add it back! Because if you ever intended to add it
> > > > back, it should be added since beginning. I don't understand what
> > > > submitting later would solve.
> > > >
> > > > > If that's the case, how can I explain that the rtc device tree node
> > > > > uses the syscon tag?
> > > > > How can I describe a POR device in DTS? POR is a submodule of RTC, and
> > > > > it also has corresponding drivers.
> > > >
> > > > I said, there is no need for POR in DTS, because you have nothing there.
> > > > Why do you insist on putting it on DTS?
> > > >
> > > > > It's just that his resources are only shared with RTC's Reg.
> > > >
> > > > What resources? Reg? That's not a separate resource.
> > >
> > > I'm very sorry about this.
> > > But I found a binding file that only contains Reg and Compatible.
> > >
> > > rtc@80920000 {
> > > compatible = "cirrus,ep9301-rtc";
> > > reg = <0x80920000 0x100>;
> > > };
> > >
> > > Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> > >
> > > >
> > > > To summarize: Drop POR from DTS and never bring it back, unless you come
> > > > with some different arguments, which you did not say already.
> > > >
> > >
> > > You are right, if there is no por device tree node, how can the por
> > > driver obtain the Reg?
> >
> > I guess the question is why don't you register everything from the RTC
> > driver?
> 
> Thanks, POR provides power off and restart functions as a child node of RTC.
> So, I think it should be placed in the power/reset directory.

No it doesn't, have a look at the jz4740 rtc driver

> 
> Best regards,
> Jingbao Qiu

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

