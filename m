Return-Path: <linux-kernel+bounces-58803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC384EBF1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA401C221B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DA15025A;
	Thu,  8 Feb 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tVacgHJr";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="tVacgHJr"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDA41A89
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433150; cv=none; b=Rpikm98DbSXYndCyAUHokLkL+NA5RWHM9z/lbHq4DId+YNOumX/Nz1DfGH5wYaCuSgR/Fy6pb3DUbXLDUkza/CiQXa25NFLzF+wOGsxo4FeXFeY4NR9uYUq/2QPut94nkz981Pi1T0cyx2FghqlXER8zfdrUhAjActYl9K3e07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433150; c=relaxed/simple;
	bh=OQOZWS9W4YHfzmDcw+aL384kY8AkTwp06uVnYjy8URU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MMN8H6uKsCAhNtuDhjyVmUHy2q6/945p6NELkot5xqpQbVcXt+WkztBpYVsVY8I393OemojAtBkjcANEfzvhS7D6Hx0PoD3fuEU67UnAMdA/Enka85+A+8LJiXudzyksuRnV9jQ599dl9soPHILzme/dMgpyDvhsVSoK37Jt9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tVacgHJr; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=tVacgHJr; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1707432617; bh=OQOZWS9W4YHfzmDcw+aL384kY8AkTwp06uVnYjy8URU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tVacgHJrPkFYKpZAlRvI7wmmCVxtAMcW23wyMXU00KA+PO/qdgp08wTdkueZGoDvE
	 4CMPC7CG5rFrmbNQ1t0+AUAzqgHyQGMRpaX7MMjV9oD4VFrfXvwyWo3eMLJSY9AALb
	 MYLwWH7s5fe2Zy5455AyzTeAquYjlCkSyCiMd42ENtWroSNX/QFFxfdpt+oWAStbmo
	 +mbe9On44Zq7rHqWypF9cYxLoBf2I6IXygsNi/Hysnvobxh2jWg/h53WJKF2feV4rv
	 B6BzzlLKk53H6g38574purLnml0iT7Ivn8iPQh7qeSil8GXEGL93oZ9dwG7bjZ6+L9
	 xX6xfqGQ1kbRw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 7C89644AFDD;
	Thu,  8 Feb 2024 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1707432617; bh=OQOZWS9W4YHfzmDcw+aL384kY8AkTwp06uVnYjy8URU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tVacgHJrPkFYKpZAlRvI7wmmCVxtAMcW23wyMXU00KA+PO/qdgp08wTdkueZGoDvE
	 4CMPC7CG5rFrmbNQ1t0+AUAzqgHyQGMRpaX7MMjV9oD4VFrfXvwyWo3eMLJSY9AALb
	 MYLwWH7s5fe2Zy5455AyzTeAquYjlCkSyCiMd42ENtWroSNX/QFFxfdpt+oWAStbmo
	 +mbe9On44Zq7rHqWypF9cYxLoBf2I6IXygsNi/Hysnvobxh2jWg/h53WJKF2feV4rv
	 B6BzzlLKk53H6g38574purLnml0iT7Ivn8iPQh7qeSil8GXEGL93oZ9dwG7bjZ6+L9
	 xX6xfqGQ1kbRw==
Message-ID: <b42ee1d3-f7b4-5d9d-3df2-1afddac1881a@mleia.com>
Date: Fri, 9 Feb 2024 00:50:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] mtd: lpc32xx: use typedef for dma_filter_fn
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240208202113.630190-1-krzysztof.kozlowski@linaro.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240208202113.630190-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240208_225017_541997_67797288 
X-CRM114-Status: UNSURE (   4.92  )
X-CRM114-Notice: Please train this message. 

On 2/8/24 22:21, Krzysztof Kozlowski wrote:
> Use existing typedef for dma_filter_fn to avoid duplicating type
> definition.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

