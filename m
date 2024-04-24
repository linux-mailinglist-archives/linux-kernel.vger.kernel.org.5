Return-Path: <linux-kernel+bounces-156389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A885E8B0246
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC771C2283D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00A158D7D;
	Wed, 24 Apr 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DiOyv9zD"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531A36D;
	Wed, 24 Apr 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940733; cv=none; b=Fcn6l1Hq/k1V0R3E5xe+/k6Pin7/NCjCI0c+K2GX4vuipLV4XPin8+04sXdRmJW3kpqskkBfdF8LSe28BCNNh0VGrJKyFg2XFxUa/t9B3ztM8htRB1S9CwPnf75OfJCgnr4xzu2c4IzxN3EivJ/ZvavjXc85Fqf68CQ7E8VMZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940733; c=relaxed/simple;
	bh=rC5tzq4Cf7BvDJ7FwCyol72j79dOirBMRNP7eb69s6c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MqXDdUxz0SqN9QBYyIiPwZkXwyldEgkMnPuFbt2+2MJVelpeC5L5TxMQrW7uFj4FjsaJowEr6QBCHy5Rp/atMAPghg2eaV2k1vUa2DXufD0l24KWd5qYMf/L2AZn8hx7sLvg5KzE5U5lz5UZdBdYcqbRitRiWwHEN53/wyWoiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DiOyv9zD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713940730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1Vyu63Q32QupR65EIJSgXlEhYqlOuM5tRxkdyCNnd0=;
	b=DiOyv9zDyJ/aamVdfT4tePMfcY2KersMVVY9qgLWqzG2BYz4ldDtGia/O9Ed4yyuGg+B07
	+3+Y4fuhKHWpnfj5vRCXecc+ToniL6+1nF/0OHnHtrW9rbTmuHKFgyr7fJaW1NE7MpADTd
	uHjKIXmhQH6WR1nfBdBaaW/crpNTCG+SbWOV2LS4+pjUtX7IffjMUMFhuRy3X5f+jWLhE0
	Gx9halomoRA1gQKLmMNkRG+ejrHxj1DyaALcYMrA7ttfp5fWY21qrP1WNMnAumbib2+wor
	Mq6t2YNo5NPA1E8AqAs1kT9g5h1BuNspcwIcFjzlA8AghJsHR01ktbWVYLyOag==
Date: Wed, 24 Apr 2024 08:38:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, samuel@sholland.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, robh+dt@kernel.org,
 jernej.skrabec@gmail.com, wens@csie.org, Marek Kraus <gamiee@pine64.org>,
 didi.debian@cknow.org, krzk+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions for
 Pine64 boards
In-Reply-To: <171388501868.266715.5097987585598723774.robh@kernel.org>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
 <171388501868.266715.5097987585598723774.robh@kernel.org>
Message-ID: <23b4798c1e116706f6b48cdd4e05e9ef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-23 17:10, Rob Herring wrote:
> On Tue, 23 Apr 2024 03:00:19 +0200, Dragan Simic wrote:
>> Correct the descriptions of a few Pine64 boards and devices, according
>> to their official names used on the Pine64 wiki.  This ensures 
>> consistency
>> between the officially used names and the names in the source code.
>> 
>> Cc: Marek Kraus <gamiee@pine64.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> 
>> Notes:
>>     This completes the correction of the descriptions of the Pine64 
>> boards
>>     and devices, which was started with the Pine64 boards and devices 
>> based
>>     on Rockchip SoCs. [1]
>> 
>>     [1] 
>> https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org/
>> 
>>  Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks!

