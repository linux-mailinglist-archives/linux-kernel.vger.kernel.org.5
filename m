Return-Path: <linux-kernel+bounces-111959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1F887344
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39611F277D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536EF69D04;
	Fri, 22 Mar 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV/BUCmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93A69941;
	Fri, 22 Mar 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132576; cv=none; b=kI16ypPqMh7AlzGsF5ri7rrJ8myfHzWj1ec4GY8jDyhlHGX7Mt4W3rejUCC9CpKFp6h23EB/km7RgQMX9Z4QzbQbjcSP5fHQeMZUGRU6z5Pn1df4z4EvQMxXN0Fh7jb/wql01RYOeT/vwK0k4ZGX3WMcjves+q2peHaC2vtiXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132576; c=relaxed/simple;
	bh=0y+MfSq9AjFTDKn0zQYT/v6yPp3l+ObYynFLWm8K1Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgJkR15v4mnl5Hd1ku4NVjKGwM3dD//Gst22NLaNdo2r5cdi4gpviPgSzGa4kI+mmuOz6eGc5KZmoil+RfvQwbir/TFgeJl+b7NUd8hugCKCR4z8KVt/bqMUhyqfOJRSihvAszMuMzDO4AylWuZUpL8yHqfgj7HtydM6DLWK0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV/BUCmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44210C433C7;
	Fri, 22 Mar 2024 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132576;
	bh=0y+MfSq9AjFTDKn0zQYT/v6yPp3l+ObYynFLWm8K1Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV/BUCmxtRxdyZxMgdjLHny9/yv6eMrzAecMuroNJXACO9zdPogvOZLlBF5QBcJOw
	 3S/jS7Evwa7ZZJS52jOXy1+fP9drg+E+VSyyqOoRoURr3RxvJKbIly3Ol6bEMfQkD9
	 Okfos52Z3dNH+bSc0yAHLKMNSuPKiFU6DcYkRoaszhPuew6o9n+6N5shuY9ymV+6jW
	 6YbsecN4ppKV+8HARWrPJbMzLrLQv2cwN5l9WtHI4JkawFdsuQn6kyy5RT6obWgJ57
	 14AteTI8fyVgZqrLA5j/JkFwcfGzJbTmD5/kjNAMEmbKMmODfb2TmuqldQyVLWYjKV
	 Dhew0Q6ret/7w==
Date: Fri, 22 Mar 2024 13:36:14 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port
 description
Message-ID: <20240322183614.GA1233803-robh@kernel.org>
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org>
 <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
 <CAA8EJprD3fM966pLV4QXPUu=bFTn24fvPMKOaGqtqkAbdz7sOQ@mail.gmail.com>
 <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org>
 <c0f1e898-7638-4b7b-a938-9e31e5b57e57@linaro.org>
 <0b091595-1587-421d-bb00-c00ef729d143@linaro.org>
 <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>

On Fri, Mar 22, 2024 at 05:49:00PM +0200, Dmitry Baryshkov wrote:
> On Fri, 22 Mar 2024 at 17:23, Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
> >
> > On 22/03/2024 15:09, neil.armstrong@linaro.org wrote:
> > >> TBH I think we should drop this HS, SS stuff from the connector
> > >> definition - there's nothing to say in a h/w definition anywhere HS
> > >> must be a port or indeed SS - not all hardware knows or cares about
> > >> different HS/SS signalling.
> > >
> > > It matches the USB-C connector electrical characteristics, which by spec
> > > has, at least:
> > > - High-Speed USB Line
> > > - up to 4 differential high-speed lanes that can be switched to DP, USB2
> > > or PCIe
> > > - SideBand line (SBU)
> > >
> > > And those 3 components can be handled by 3 different HW in the SoC, so
> > > each one has a dedicated port.
> > >
> > > Remember DT describes the HW, not the SW implementation.
> > >
> > > Neil
> >
> > Yes, you're right about that.
> >
> > I suppose
> >
> > 1. Orientation switches should be defined as coming from a port on the
> >     connector associated with the CC pins.
> >     port@3:
> >     orientation-switch port name goes here
> >
> > 2. Data-role switches...
> >     Again the CC pins
> >
> > https://community.silabs.com/s/article/what-s-the-role-of-cc-pin-in-type-c-solution?language=en_US
> >
> > Maybe the right-thing-to-do is to add another port for the CC pins -
> > which would still describe the hardware characteristics but would
> > _accurately_ name the thing which does the data-role/orientation switching
> 
> It's true that we don't describe CC lines. However In most of the
> cases CC lines are handled by the Type-C port manager directly. So
> there will be a connection from usb-c-connector to the pmic-typec
> itself (which looks pretty redundant).

The thought at the time this was designed was that would be the parent 
node of the connector. That's perhaps too simple.

Rob

