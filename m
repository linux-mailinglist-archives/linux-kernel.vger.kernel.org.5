Return-Path: <linux-kernel+bounces-47669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD186845101
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5FB2AC19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404F978B6C;
	Thu,  1 Feb 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Tkjh9udp"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6469D07;
	Thu,  1 Feb 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766589; cv=none; b=DjLLRyu8tFN05bnvVN8wihMy98WmfiaHeVjtHYgITVoW5pedwnaiKJDr+zOX14vIRH6nCi0nYrKyJlT4SiLdzeQ/H39VmnmcGNv3TbvSrjvwRxAX8EP6+VUhkCwRA1Gt3nIyM9sYyCg8Y6+hDwfAtTGqgc/X8TmENoEfenfhqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766589; c=relaxed/simple;
	bh=fhdSlQmPjsoJq5ND6PaKO/AKnlEbNn+p1RX7PH3gnk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1NGM0yvhRjFIgCz8gzYLIM+WOLgN69xRPqidZ2+2K8GyTQat7NX2jYt6WcimP4X8ZyZiVZE0/o7uu7oqLWOggUpCzukcXIApND7Fxk2No4tYaAeSe/T1u40NtnZMhnx56NMEjOoClG0FQQDpz9AI3B6ZZaBQcp3IBFBW1D9FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Tkjh9udp; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 74CDE2017A;
	Thu,  1 Feb 2024 13:49:45 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706766586;
	bh=fhdSlQmPjsoJq5ND6PaKO/AKnlEbNn+p1RX7PH3gnk8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tkjh9udpXYVin4F6L1ot8Jzzzjq8u5kBY4SFX6xDc//wDW10NwBjBs2B1yIasWTkj
	 dEHtmn9YSt4L7lV5SNBZE79QRmOWAhephWBsJlE48j7IDt8KaapqoZodJI6QTPYbh0
	 0r1VhqD2xagfFzWkZl31YuqAnduTNkukPJQIyRn0pHxal2fL2dZIzENXg481LLnx6h
	 b+yd8y+qKkpbYm6GPY0VxOAbMw+akg6YxQ7wjf02scK2H3Y+GHrp3c3x5IPUZ9NhZz
	 aN6wY5U/1yVFoFKvc53uzsYYffgWWIaY4o7+tsZzbD9Vr0U810R88Nif9JV7if7v83
	 0ipsspOETkscg==
Message-ID: <345345fd4475d24a015a37881eda0a4b90892179.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 16/21] ARM: dts: aspeed: yosemite4: Initialize bmc
 gpio state
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:19:44 +1030
In-Reply-To: <20240131084134.328307-17-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-17-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Initialize bmc gpio state

Why is it important to specify this in the devicetree? What's the
motivation?

Andrew


