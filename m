Return-Path: <linux-kernel+bounces-46401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83265843F28
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228B51F2388A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834678690;
	Wed, 31 Jan 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV2uhGNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEE762C3;
	Wed, 31 Jan 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702964; cv=none; b=WRYFyf+U3myn2GL+FFdwxT6aGoABd0R/c0mJaKljCc8mG8ncGRgfIcG/9E6MgQdS+qhtMdp4/ZVrSv+Khy/sec89Ma0JLd0bX2zuIOW6TwxANhJGmbEUAGCrwqDDPykhags/3dRIJcq50nVjlJvc6h72BEM3DVDHl4EJGy7+UN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702964; c=relaxed/simple;
	bh=PWXEkDBmgfns3y+gOHYV28uZXiALR0vjz4diVLcD8W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMmE9tMvTlBowbjd+IqxHhF3ARkHpCZsNIVlMZMf0y8hl4gD1zskurtV0csyMI3naLHK60ejn8Uu013XHiD2J+7xeWsJVSqORQxtIvEHmrWS2gMVvuuBBPydq3nLl3sWKYNpHELFdzj888vJ5c+iPBQYS3zmLsf9sO5SE885l3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV2uhGNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669A5C433F1;
	Wed, 31 Jan 2024 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706702963;
	bh=PWXEkDBmgfns3y+gOHYV28uZXiALR0vjz4diVLcD8W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BV2uhGNQ7Z/KWyWtRey5xXstwmubqp+sw7Fp/dLMohffpsiQburpe07LBuQqikBED
	 PQZzLg1Lrc2lsGZt9CZxOmFsEq0m1ZeUoLl+aWZ34+3njtmqsS5Acox4KKsF8PvM+L
	 gXWfUBJFM+lCgV1wfbfyx+xYooTu7rk7wR88bf0XjbzLg2l4tDHfbFMJN5sRwm+usL
	 x0rKnyEqBfyit9BzA/3dja16i/v0ofYqrTHpczUDgSdsl1TKfUE4X1kHGywKhvjgJk
	 C6baUsNx9kddJmwWPGQVk5LRuEADp/6y7rtZDqKcaBr7JkLa8vm/upMSVe3pTigDP9
	 t7i7Hxs7wi9rQ==
Message-ID: <b23beee6-348d-4f04-b5ae-7d881896a578@kernel.org>
Date: Wed, 31 Jan 2024 14:09:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131085351.25103-1-r-gunasekaran@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240131085351.25103-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 10:53, Ravi Gunasekaran wrote:
> Update the list with the current maintainers of TI's CPSW ethernet
> peripheral.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

