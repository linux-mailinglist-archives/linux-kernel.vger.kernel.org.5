Return-Path: <linux-kernel+bounces-156402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43D58B025F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB101F23722
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B2157499;
	Wed, 24 Apr 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mazz3bcL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B336D;
	Wed, 24 Apr 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941208; cv=none; b=e2qQBoFBw2lEFy1DAUoOKPuA0CWPkL+QG3N3qu9kr0TDWPKDnjlL+Vk0kIx2dKzYUcPpU4RJlXzvQ80psTaO3kCZ5UZw9fuhRkqP99oAhrJ+oem55lgdQlAvm2yFAIOErfvHN8l7ZxvQBhcbLFF+zTvOCCz2pH4tTyibXi8ru9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941208; c=relaxed/simple;
	bh=JzRlsZzTpW98MwFDr2zX5jBbDNQdobqqGsy935JoHRQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=d9YAdIViXkhYCOrVWvzrp+50ELFgF1B2wFJ+t2xHlB8al+VUNnB1xeyjyLBL5/e7WcHpcNAA3B9AaWLnHILgd9m+BcU8xdmb6p0VCaeCZL7PTt7DIR+K6pUxONYuN8KxEzE3Ivn+b8KO6Q7kKKIxL2GGGoh4NmZ3JRYarIouMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mazz3bcL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713941205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bi0F1JRl8mqsIdjFylCLGdQWmTMb9OhvsZ+CofSBtE=;
	b=mazz3bcL61oC9OueattYVTBjaoj2ibTA3yRvybk01cFYL91V1MMIm5NPYomF2PejCuMZ1a
	hQ7KhBMOP3iYaOm6/EaduiRyr6iZEH3xt1DLHMdc8fIECFfu3dNm+jZpH3XZ9vinkPRrgN
	nQwR03JYhfQGDXD/mTSS24h9iUwn6tltYLoWBt8HrDL39mS2314+pf4PIerMW6pG6DBQTd
	FigPGzgOpsYAvtT+6NMPsO2Vc1n3NNIjKi5n+bJ765oCnhP0iMXjj0adA9DqJR8giTg7Am
	dQKJvGZdqmrQygCCKLqUj5DoHoxBD5K9N4C/7iXpCh6xWTqjPBRS00WYRd3eBA==
Date: Wed, 24 Apr 2024 08:46:45 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Marek Kraus <gamiee@pine64.org>,
 didi.debian@cknow.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Pine64 boards
In-Reply-To: <171388532521.2652222.18024517612743377604.b4-ty@sntech.de>
References: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
 <171388532521.2652222.18024517612743377604.b4-ty@sntech.de>
Message-ID: <28507b03e51842fc0392171aed902ec7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-23 17:15, Heiko Stuebner wrote:
> On Tue, 23 Apr 2024 02:43:43 +0200, Dragan Simic wrote:
>> Correct the descriptions of a few Pine64 boards and devices, according
>> to their official names used on the Pine64 wiki.  This ensures 
>> consistency
>> between the officially used names and the names in the source code.
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: arm: rockchip: Correct the descriptions for Pine64 
> boards
>       commit: 433dafc7b4f9f9a1011d72b32e138b598faa4807
> [2/2] arm64: dts: rockchip: Correct the model names for Pine64 boards
>       commit: adbc5e6b457e773f1afa11fdb9b667cd492a7f82

Thanks!

