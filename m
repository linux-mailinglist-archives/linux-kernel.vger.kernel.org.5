Return-Path: <linux-kernel+bounces-100396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2258796E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2805E1C21566
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DA7BAF7;
	Tue, 12 Mar 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz7yF82n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C37B3DF;
	Tue, 12 Mar 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255130; cv=none; b=jzSUdewBWgQWdJ+1F0FCTVPVzjmSPgbEBGU8sYPPuIelN2qcqjAa7BYCteFvYbZkofJg8CvWyfKmnYjPk2LqOBwl6IwNIRkSdikvauNLwvy5cyH1kBRs2wDiznD6Dpihq79frqJoLAOixeM2wDEg0qgU1ABUtlcB3PiQfGRAYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255130; c=relaxed/simple;
	bh=Jv2PORTKaTF23dwg+ewXMfp1ou6sNes8c5NYOe+2dxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxJ5GI+0dqHHR2ToTFbEfAIxTySnWQ+hMIpk42lsYGf3k6IVtJPZDDNdDwhvR//P3HzoZ2Ag5/cJsQi0APbySEUZYVoiW+jBJsTzISbJaIHHyO3nfs9Me+Oj8n2sSsnjyZSQWEcZ4PPXEsvEs2xUlJiKvsTaIv9TtGBA9N3nSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz7yF82n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCB4C433C7;
	Tue, 12 Mar 2024 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710255129;
	bh=Jv2PORTKaTF23dwg+ewXMfp1ou6sNes8c5NYOe+2dxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sz7yF82nevobfS2rfW/p9ofRfHddMl3I89tLn2ph2Mw5bfl0Pdndx6s9/PsVS/Eag
	 JvTmh5JNB/WPTuLBk4d1Ei2fau6jHsvtug+dg5y0zzvCMjUCGLXYD7xeMmon9+/8JG
	 mnSMwaKvRzOToQsLUI/ZJ8ebLquxJeVwyD4RMRcgvUNhukt/I3Jtr0zkdu/ih4sITE
	 BeSmWsqnan28HDf4RbFidc/VMu/O2w6KqxJrAxE0GwgtVfLKwbPJgBBAmygqADgqCf
	 EBafandELL1jVO06GI97laX7jEKTOQqQrzLiRh/B3uoc1cR7lUE/ifKbm1mAORGukm
	 8fA+sZDYIGlrA==
Date: Tue, 12 Mar 2024 08:52:07 -0600
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: conor+dt@kernel.org, jun.li@nxp.com, linux-usb@vger.kernel.org,
	robh+dt@kernel.org, linux-imx@nxp.com, festevam@gmail.com,
	peter.chen@kernel.org, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v8 06/10] dt-bindings: usb: ci-hdrc-usb2-imx: add
 compatible and clock-names restriction for imx93
Message-ID: <171025512464.2219529.2822170265480300536.robh@kernel.org>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-6-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312091703.1220649-6-xu.yang_2@nxp.com>


On Tue, 12 Mar 2024 17:16:59 +0800, Xu Yang wrote:
> The i.MX93 needs a wakup clock to work properly. This will add compatible
> and restriction for i.MX93 platform.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - no changes
> Changes in v3:
>  - add clocks restriction
> Changes in v4:
>  - use 'contains' rather 'items'
> Changes in v5:
>  - rename clock name
> Changes in v6:
>  - new patch based on ci-hdrc-usb2-imx.yaml
> Changes in v7:
>  - no changes
> Changes in v8:
>  - rewrite the restriction
> ---
>  .../bindings/usb/chipidea,usb2-imx.yaml        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


