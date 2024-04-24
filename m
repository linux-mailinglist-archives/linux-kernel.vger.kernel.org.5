Return-Path: <linux-kernel+bounces-156393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70AF8B024C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23BD2857A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A1158856;
	Wed, 24 Apr 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CsKs7IrQ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6957157A61;
	Wed, 24 Apr 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940785; cv=none; b=ZFml+7bngS5K742NFaJ1T+Qqpipbvv55kOoJx3EZWQz93CmVt3ghXRu0FD9fdw4cr6ukq5QC2XbVoeHcHVAfgdI1Z1TI1g5GgNfnfO8cOD0PMIdFgLTmx/ZM1mEyEia3X7v/jgohpxmK0DIFbz1yX7Zsq6W5lKLuukg33h92NSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940785; c=relaxed/simple;
	bh=AAN04JZawu8pWEFDdz3fVQNCM7NmprVKAS13ylm9e7s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n/L2I4KsrcJxHrE0LmBxN6kQ1WNrZgt58PWd6Uh/XZWsA1rCi1mPpb22iF+gTVLpMI6awYHNkfuKLem4fPn1WO9PQDlx/3Obldw97+AI9EAh0U12zKLWENm+33AoNSWtPq68DNx4PXfpupV/kczcXeJuIOCMs+ok2e5AUK6E3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CsKs7IrQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713940782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sU6Lg3T730x67q5TNnFx9GR4FQZTeQCJKcEZaJjZkgE=;
	b=CsKs7IrQD0Y/5BV+OjWhOGmKH6JgniVl71Rphd1nvbXLX57PYJye0aTD2UXGjP5GYE7dCw
	32QWo0/fFmw0fo9ZSXq/fzWzLtC9BN/E3wewWFWtwRwmoschgwReHSGR/qF4fsoyYNZEny
	RRfvTw3b6WtOBrFGTXEn6L7df6xfVttRR1qAgtr4rVXs7iEvObwGCRmV9tT9EIy1wiNbLJ
	racgozgOqfVBpGdqtTqXKGC+0B/IVUTi5M0k8WvA/zC8g4AHSZquwk2G9HLAqSyQi5fWzP
	jk1uifOb2M84QK8KrfcA26zFPMJ7ro7qU70/s6Yg06FPD13gif/8N/XtqWmp+g==
Date: Wed, 24 Apr 2024 08:39:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, krzk+dt@kernel.org,
 amadeus@jmu.edu.cn, linux-arm-kernel@lists.infradead.org, FUKAUMI Naoki
 <naoki@radxa.com>, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
In-Reply-To: <171388532520.2652222.16202058595399007422.b4-ty@sntech.de>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <171388532520.2652222.16202058595399007422.b4-ty@sntech.de>
Message-ID: <c5617f5eff7c057f8ad7d591d148f20e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-23 17:15, Heiko Stuebner wrote:
> On Thu, 18 Apr 2024 18:26:19 +0200, Dragan Simic wrote:
>> Correct the descriptions of a few Radxa boards, according to the 
>> up-to-date
>> documentation from Radxa and the detailed explanation from Naoki. [1]  
>> To sum
>> it up, the short naming, as specified by Radxa, is preferred.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
>> 
>> 
>> [...]
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: arm: rockchip: Correct the descriptions for Radxa 
> boards
>       commit: d78084cdb5a959a5759efed9b3bc3182d005073c
> [2/2] arm64: dts: rockchip: Correct the model names for Radxa ROCK 5 
> boards
>       commit: 45e831033f7a00a14f64afa1e34c476a9ff0f9f0

Thanks!

