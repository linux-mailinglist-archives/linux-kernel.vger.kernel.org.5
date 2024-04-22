Return-Path: <linux-kernel+bounces-153780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A98AD305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D3B1C20F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8F153BC1;
	Mon, 22 Apr 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mkD2MSnx"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74591DDE9;
	Mon, 22 Apr 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805384; cv=none; b=J2+6YHbKxYFjaAWX0lhDTugyyOZDHmevT+uaT9qh8NpCnbfOZ1hNn6xKYi4xtnZnEXR7rR3ZclB0Wt9oAo8jfrAnpJOda2+arOHqmrHPpYsgcnngUqY3k4HyGRrkkTZiQCFdFB8et2OPWl5QP+HEEQNZlWEDxSW5PhBMoeMj4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805384; c=relaxed/simple;
	bh=10BJBa6jkUvz8pnkOh9MrJQDUrHQ+NUzclsiDerdJDc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LXjYhyYA3eA2by5buMQGOHASIUfezENF/7yfQ0uyreLJVySdDOepxX60uwlu59+An+qQxldVxhLDWF/DWbmPYvgcEdPlgFLk9Q4LT4uRcY/4E8wy6aqPgjh1kyi5u3s4Kw/xXDemS1XBRzb+EwwzVNwIgrclDNe/IP/VMj63sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mkD2MSnx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713805372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kk+naKJeaAsOPU+W2tz3dUKAlOqJJISxhd/6sq9KCdI=;
	b=mkD2MSnx4vbGIpB9wqMhdrXALJf3vlah/KtJ8GJPLQ43bgfG10uSDuD+/2CQE7mGTn9uCU
	PyemwCvvRIZhDkDijuA1AFZqqe469U1Ozi6QjfTnkE8dm/CsSQI/6GMXu58B2x74mn3/G4
	jiAv/UD+mTLz/LRHlI5uBYHKs7nuoSpexa8AWV6lU/7OUmGE1Kj6g/npsY9YyFQ+xlRd2d
	Dmmt2O6aStlgwrNOdbMEfoisYL8/XsU09KH7O/BUnuNuNcfKPK/5RRJnbn4tlCSxUZTu6i
	YiIScTwUoQbJ2z/C3slP1AG9lblxtauvfRpiaS9Oil1O40ODJmID8eBLkeR28A==
Date: Mon, 22 Apr 2024 19:02:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Rob Herring <robh@kernel.org>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, heiko@sntech.de, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions
 for Radxa boards
In-Reply-To: <171379340485.1139142.4385224897520028554.robh@kernel.org>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
 <171379340485.1139142.4385224897520028554.robh@kernel.org>
Message-ID: <68920e1c33815df82f8638fbdd479dc1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-22 16:32, Rob Herring wrote:
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
>> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks!

