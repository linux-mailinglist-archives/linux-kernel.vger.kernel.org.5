Return-Path: <linux-kernel+bounces-126750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F56893C43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC31C2150B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F21FB4;
	Mon,  1 Apr 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="40UYC/w7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FE383A9;
	Mon,  1 Apr 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982243; cv=none; b=eJpoDSCL7SBHE/QwGo+IK83Pfxf98MZWw9vTfIpngXrdGVCAvaU5LFySY3Bwmxb7ycnyBoac2XnOL8RYg7d3kAMdlwreEioPIlLO/NHppBeuk6U27U7Lhk7QOMB1nN9wpqmUNkFPnS862KD/UDTmIYzgi9gDTMNZEG0ZVhze7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982243; c=relaxed/simple;
	bh=P2NFwWy8eX92gRNiHWuyZ8dpp2QsHcK8guouvXoVhbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2MyLww6GgFnMHfOsiyA7HXSjpP0/cR5XlzJEakCWNR+J00ihViWZYj0CEMsk+eaexXwCbvBXXNVV1Q/TYbdUuEEQtOFsn/lALcKCeo3fLaFw7j1C2fwAymux2Ae7K5Tkg81/LESZQCPwAmbIYXVkRfpJsN4eiQfmLz0ak00C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=40UYC/w7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uFnolVt4xH3Wk9qnKE0r3GzXl7Bfg24ioZyyPw2jx+0=; b=40UYC/w7WpLdTnOJ8uccJRdL5C
	QJtcBx+z1C0lKSyvoo1zUwh+Euj4awH/q0fb7Kdki/IiXWNmenMnAt08scIUktN49jNqFUeYrl3ca
	1HKwu4kIlooZoTVtTTafQaKPGjNLPtZoevPySUMty5WG4pTJwjDpTKf9ai51Phm1FR7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrImb-00BrXN-6r; Mon, 01 Apr 2024 16:37:09 +0200
Date: Mon, 1 Apr 2024 16:37:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: marvell: ap80x: fix IOMMU unit address
Message-ID: <9040178a-9e1a-4ec5-8cd2-7f46ba87e0c0@lunn.ch>
References: <20240401141051.98233-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401141051.98233-1-krzk@kernel.org>

On Mon, Apr 01, 2024 at 04:10:46PM +0200, Krzysztof Kozlowski wrote:
> Correct the IOMMU device node unit address to match "reg" and fix dtc
> W=1 warnings:
> 
>   armada-ap80x.dtsi:64.24-80.6: Warning (simple_bus_reg): /ap807/config-space@f0000000/iommu@5000000: simple-bus unit address format error, expected "100000"
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

