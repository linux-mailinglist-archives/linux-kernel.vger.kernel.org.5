Return-Path: <linux-kernel+bounces-119706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569188CC46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B645B1C61E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BDF13CC5E;
	Tue, 26 Mar 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXCqt4kr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496813CC50;
	Tue, 26 Mar 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478824; cv=none; b=o4qG2gupoAXK7oRphiKMcM6ayMuBYQS2zHGQPMQ7I9nF1Xmi/AC0IVSXHQFSe0wFR3bruHVj1wFrvPizmerU8Wx0SjoOdBhM2xwK41/NdwHlhcbapa8Dt9ysEiW7v1UG+jSvLdPqm48oLP5UZJQkIQNSdo14fuoBdkzyiuB6EDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478824; c=relaxed/simple;
	bh=+m5w9ZM24MSo7RPB7OCGEmqnBbsu4kUdknPv9kU7wvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnOKcoJVN4vhSdp9YKGRrFyEbQtByM5/nxmVdYFZTOZeYdi+EtYe7QZGw3smjVFyX6wB/JxoyKbvLcipf1KgmTzdOHqcDbvwwcuMWUhh0pF8Ein8Jg+k8qOtDSPN+jSWB3Nr2KO4tUbztgqbrtVUpLeQqhZkqioFCXpc5E9vaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXCqt4kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4627C433F1;
	Tue, 26 Mar 2024 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478823;
	bh=+m5w9ZM24MSo7RPB7OCGEmqnBbsu4kUdknPv9kU7wvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXCqt4krvw2SPsIA0K8cakevNt1asnTohQoJ3fLNowN394w31T23YiYbMZ40+XE9h
	 XVIZWAzF40wysD/1lKnZlmg1Viz2MLzTxT7m88ptePneZ1RQNiZLj93nwbyOMzDH69
	 3Lsjc8Z5+ZkVbVJlHp+u5wW2W23qGOG6KhwvID5jksCzHp8ErCX2pac7ZvWQLDNKgy
	 axaRklp1UCRjWIf3AKIexrFCL6htI/gX4ozubsSACLmJxJvwDuIQz/1ThCaRpHnjJA
	 gLNvcq6gaDHLEtRvjyJtQrajmfCyU+fzbf2ImLOolT8q/l0/Rd9OzrAs/OwoWOY7Cx
	 qd7J0giXF698g==
Date: Tue, 26 Mar 2024 13:47:01 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: armada-380-rtc: convert to
 dtschema
Message-ID: <171147882104.3181803.12032534798839949801.robh@kernel.org>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
 <20240325-rtc-yaml-v2-1-ff9f68f43dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-rtc-yaml-v2-1-ff9f68f43dbc@gmail.com>


On Mon, 25 Mar 2024 22:10:08 +0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> This is a direct conversion with no additions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ----------
>  .../bindings/rtc/marvell,armada-380-rtc.yaml       | 51 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 24 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


