Return-Path: <linux-kernel+bounces-27596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3082F2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36777B236B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7BA1C6BD;
	Tue, 16 Jan 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IqlFBjCP"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E51CA80;
	Tue, 16 Jan 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D3A724000F;
	Tue, 16 Jan 2024 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705424038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDyxxPBWASolnrw6aGy7NIdq8Al0r2BJ6k5gaCOPFq4=;
	b=IqlFBjCPvjbP+0obF3YLWMwVTCrrKFs+4+Y+zMfcO5kgJ8f4UIXOwBmLYpDIH8lmcL74nv
	wM8MG1uCTl4p9Vnp1xVfi8ut+EBMtPnhcPKZ/IEtKt3lbVCoaJD0PoEdOF+70WE0NhqOFn
	iwUV7sSusENcH7+qULDhnq+YGIVrMCMCtVharXSW6erFGu7BbBtOMMr1pMcb7RZ1rzRxgu
	G+tDZsIPW4RpJSG02Rsp8dCfpItzSAJcwtOHTl0S0YYtXAudFip1C9KfQi0a4MNfYj+NmF
	Li0xVRIVUJHqt7zZ+V8illQ3RgVBJl4UbtznAUpsDtb2yi7rtODiqlKBN7oXhQ==
Date: Tue, 16 Jan 2024 17:53:56 +0100
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
Message-ID: <20240116165356eaa221fe@mail.local>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com>
 <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
 <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
 <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org>
 <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 17/01/2024 00:29:28+0800, Jingbao Qiu wrote:
> On Wed, Jan 17, 2024 at 12:03 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 16/01/2024 16:51, Jingbao Qiu wrote:
> > >>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> > >>> module has an OSC oscillator
> > >>
> > >>
> > >> I am not going to read pages of description. Please write concise replies.
> > >
> > > Thanks, What I mean is that this hardware includes two functions, RTC
> > > and POR. How should I describe their relationship?
> >
> > Your POR does not need to take any resources, so no need to describe any
> > relationship.
> >
> > ...
> >
> > >>> Your suggestion is, firstly, the por submodule does not have any
> > >>> resources, so it should be deleted.
> > >>
> > >> So where did you delete it? I still see it in this patch.
> > >
> > > Should I completely delete him? How can a por driver obtain device information?
> >
> > Delete completely.
> >
> > Device information? What is this? We already agreed you don't have any
> > resources for POR.
> >
> > ....
> >
> > >> Device is only one thing, not two.
> > >>
> > >>>                     reg = <0x5025000 0x2000>;
> > >>>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> > >>>                     clocks = <&osc>;
> > >>> };
> > >>> However, in reality, the POR submodule does not use IRQ and CLK.
> > >>> Please do not hesitate to teach. Thanks.
> > >>
> > >> I expect one device node. How many drivers you have does not matter: you
> > >> can instantiate 100 Linux devices in 100 Linux device drivers.
> > >
> > > I understand what you mean. A device node corresponds to multiple drivers.
> > > Should I completely delete the POR device tree node and add it when
> > > submitting the POR driver?
> >
> > ? I wrote it in previous messages and twice in this thread. Completely
> > delete. You do not add it back! Because if you ever intended to add it
> > back, it should be added since beginning. I don't understand what
> > submitting later would solve.
> >
> > > If that's the case, how can I explain that the rtc device tree node
> > > uses the syscon tag?
> > > How can I describe a POR device in DTS? POR is a submodule of RTC, and
> > > it also has corresponding drivers.
> >
> > I said, there is no need for POR in DTS, because you have nothing there.
> > Why do you insist on putting it on DTS?
> >
> > > It's just that his resources are only shared with RTC's Reg.
> >
> > What resources? Reg? That's not a separate resource.
> 
> I'm very sorry about this.
> But I found a binding file that only contains Reg and Compatible.
> 
> rtc@80920000 {
> compatible = "cirrus,ep9301-rtc";
> reg = <0x80920000 0x100>;
> };
> 
> Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> 
> >
> > To summarize: Drop POR from DTS and never bring it back, unless you come
> > with some different arguments, which you did not say already.
> >
> 
> You are right, if there is no por device tree node, how can the por
> driver obtain the Reg?

I guess the question is why don't you register everything from the RTC
driver?


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

