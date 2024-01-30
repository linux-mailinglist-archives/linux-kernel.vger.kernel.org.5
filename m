Return-Path: <linux-kernel+bounces-45426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06B843058
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D83D1C21555
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20187D41F;
	Tue, 30 Jan 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZqJ1j+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276797EF1F;
	Tue, 30 Jan 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654339; cv=none; b=fsbcTHi0Q5/ODbspcAcI1bCxo2/VcDXImeVJOs5VItjiFV5KItoqcwSEwKQHPpkCyGGoLjztXvLuRQlvQpNm2OG5r1w6IUAXLc5eQ958oFFzMOEaaqQ1y+xjRnlPbbg/Sw123svXpY7X/ysaIbsZe5RBtl9Te6yi2LhRUwsvaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654339; c=relaxed/simple;
	bh=8Eyya2MZJxron5ZGyDFt7s2SHtvsfbEMHuSW8clUuFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6lopm4OsJ/232PuZJrEbFHP2l77y39OYuiPKFAPghIalCv1IfrTtzlvgm3ZrlWmOzbupBiUcf824n4pWq00BPnhOKH5uTEg+xqFAlZNtbmFprZ0FFPk9Mji6Cu/WR8mELHHim2pI0zOX8tHLqP+quLNYtcq5IsYUj3F503Yi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZqJ1j+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEABC433C7;
	Tue, 30 Jan 2024 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706654338;
	bh=8Eyya2MZJxron5ZGyDFt7s2SHtvsfbEMHuSW8clUuFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZqJ1j+iT4U1BpRQSHn+TKtGmW+du+QKRF7/9gbYMjf0dVK8rzdEq+m7boXXeg4Js
	 1tao+CN71PidDU27iAQ+oPFCDReDWW5k6mRlBSTavzIGXIA7pnH+2fdTRC29sj9hwV
	 g2qGfiAa6yyczzBrgTDjeHPKnpH91ym6Jvko3bLlmh8UMMIM92e8IVQ283ucErsHKf
	 Q7XXGlQC2kx65ZuvP0utNzdN25wV+d1E7iPZwKFCMhRTEOozPUn3phiYp/2CPZ4gNP
	 XwTQYHZIs0nBW2aRyTIPdu1ErbFAFBnXExyt/gRbq/wbBwQj712kC/Kqz0hBe/jiN3
	 ZBVqPY2N/sVsA==
Date: Tue, 30 Jan 2024 16:38:56 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
Message-ID: <20240130223856.GA2538998-robh@kernel.org>
References: <20240126063500.2684087-1-wenst@chromium.org>
 <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
 <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org>
 <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
 <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org>
 <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
 <78241d63-3b9d-4c04-9ea5-11b45eac6f00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78241d63-3b9d-4c04-9ea5-11b45eac6f00@linaro.org>

On Tue, Jan 30, 2024 at 05:25:38PM +0100, Krzysztof Kozlowski wrote:
> On 30/01/2024 08:47, Chen-Yu Tsai wrote:
> > On Tue, Jan 30, 2024 at 3:37 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> >>> On Mon, Jan 29, 2024 at 3:34 PM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
> >>>>
> >>>>>>> +allOf:
> >>>>>>> +  - $ref: bluetooth-controller.yaml#
> >>>>>>> +
> >>>>>>> +properties:
> >>>>>>> +  compatible:
> >>>>>>> +    enum:
> >>>>>>> +      - mediatek,mt7921s-bluetooth
> >>>>>>
> >>>>>> Can it be also WiFi on separate bus? How many device nodes do you need
> >>>>>> for this device?
> >>>>>
> >>>>> For the "S" variant, WiFi is also on SDIO. For the other two variants,
> >>>>> "U" and "E", WiFi goes over USB and PCIe respectively. On both those
> >>>>> variants, Bluetooth can either go over USB or UART. That is what I
> >>>>> gathered from the pinouts. There are a dozen GPIO pins which don't
> >>>>> have detailed descriptions though. If you want a comprehensive
> >>>>> binding of the whole chip and all its variants, I suggest we ask
> >>>>> MediaTek to provide it instead. My goal with the binding is to document
> >>>>> existing usage and allow me to upstream new device trees.
> >>>>>
> >>>>> For now we only need the Bluetooth node. The WiFi part is perfectly
> >>>>> detectable, and the driver doesn't seem to need the WiFi reset pin.
> >>>>> The Bluetooth driver only uses its reset pin to reset a hung controller.
> >>>>
> >>>> Then suffix "bluetooth" seems redundant.
> >>>
> >>> I think keeping the suffix makes more sense though. The chip is a two
> >>> function piece, and this only targets one of the functions. Also, the
> >>
> >> That's why I asked and you said there is only one interface: SDIO.
> > 
> > There's only one interface, SDIO, but two SDIO functions. The two
> > functions, if both were to be described in the device tree, would
> > be two separate nodes. We just don't have any use for the WiFi one
> > right now. Does that make sense to keep the suffix?
> 
> Number of functions does not really matter. Number of interfaces on the
> bus would matter. Why would you have two separate nodes for the same
> SDIO interface? Or do you want to say there are two interfaces?

Right, one device at 2 addresses on a bus should be a node with 2 "reg" 
entries, not 2 nodes with 1 "reg" address each.

Rob

