Return-Path: <linux-kernel+bounces-109680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11121881C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400581C214C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E015C38FA0;
	Thu, 21 Mar 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="Yy0wI8oX"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2176FBF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001117; cv=none; b=AFvS52++Hlj8gA8qnrsazUlkSs8kWSTL3mEqxj5PnRS1dE6UaRO9Iqhtz9BcvCrL+e0g5keXbiYEejc3e6J9ijHfUX0GzRktU2ZJLyhZS9vvPi9SinCK05VuaWJ0JfyXoL7dgPeZcZx/PRZDP+0hyolDQG6q0bI1oWUMXs/mKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001117; c=relaxed/simple;
	bh=StZmMs66SfWq8CwwIVYc++zjL8fZH2/JsVrrOJRAohg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTNiouMOnOmS6Dx//mEj4TQ9CFYbg1i1vp7qC7WRZI/gHi9TdEdI6RGGcwgFWm/GxGiwdBtFf6xT7PqtGIQFYPysogJs58qTmRMmmW0JrkY94tQzvGtWe9eRPaok4Ju99+IMbsk4H1zqVjyIaNCYNUrbRMobB8KTyrbbKd4BlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=Yy0wI8oX; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Thu, 21 Mar 2024 17:04:22 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711001111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d79X7C80TteblSlj5M4NQLdb1p8hYHeGek74AtPCLrY=;
	b=Yy0wI8oXHAZDzgmXzyemOn349vpfVjQx6VWtdNgzmMnfMG5N9/pVUyym2gvg3oik5Y/kVP
	ae+xfNgqI5gX4f9LvTEylvgfCajCDnO8oXoajS6D60z+ViT/3u4f2/R17x6jYFTpv3xsEp
	f8YJfS2PMDpFy7+Z56h6k7CQBRKwvG7tlgoykc5OuQ0sYqfQqoIAmaGBl+U8hBStp2AsTN
	yCvd3J6+PY1VNRBUFur6b8dtPVWWzrLRfmFoCInQnx3758M/N8huOtJMGhJUbfoi3IAmEp
	RTjxzAl61hdi8f7Esmt3LcjLVhF2kofj9v49Czn9CGI5GVXhXyWflj9baAkjiw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <ZfvN5jDrftG-YRG4@titan>
References: <20240224052436.3552333-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 23, 2024 at 09:24:35PM -0800, Saravana Kannan wrote:
> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.
> 
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a remote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Using Link: instead of Closes: because Luca reported two separate issues.
> 
> Sorry about introducing a stupid bug in an -rcX Rob.
> 
> -Saravana

Hi there,

Could this be reverted? It breaks my audio-graph-card2 setup:

[   17.116290] platform 2034000.i2s: deferred probe pending: platform: wait for supplier /sound/multi
[   17.125370] platform test_codec: deferred probe pending: platform: wait for supplier /sound/multi
[   17.134257] platform sound: deferred probe pending: asoc-audio-graph-card2: parse error

/ {
	...


	test_codec {
		compatible = "test-codec";
		prefix = "Test codec";
		#sound-dai-cells = <0>;
		port {
			test_ep: endpoint {
				remote-endpoint = <&card_ep_2>;
			};
		};
	};

	sound {
		compatible = "audio-graph-card2";
		label = "CS5368";
		links = <&i2s2_port>;
		multi {
			#address-cells = <1>;
			#size-cells = <0>;
			convert-channels = <16>;
			port@0 {
				reg = <0>;
				card_ep_0: endpoint {
					remote-endpoint = <&i2s2_ep>;
				};
			};
			//port@1 {
			//	reg = <1>;
			//	card_ep_1: endpoint {
			//		remote-endpoint = <&cs5368_ep>;
			//	};
			//};
			port@1 {
				reg = <1>;
				card_ep_2: endpoint {
					remote-endpoint = <&test_ep>;
				};
			};
		};
	};
};


&i2s2 {
	pinctrl-0 = <&i2s2_pins>, <&i2s2_din_pins>;
	pinctrl-names = "default";
	status = "okay";
	i2s2_port: port {
		i2s2_ep: endpoint {
			format = "dsp_a";
			bitclock-master;
			frame-master;
			remote-endpoint = <&card_ep_0>;
		};
	};
};

John.

