Return-Path: <linux-kernel+bounces-91420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DC871149
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175E11C219B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE907D3E3;
	Mon,  4 Mar 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRIsSCwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A47D077;
	Mon,  4 Mar 2024 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595870; cv=none; b=Ykb0MKueMYg+gvQ5+8nK4yYGDtxHFCYX+j+AHUNqMpgP25Bdn8yat6uoG7wRCg9/G1r73W7R9hjgfJoznyKJexh2OP84bPs7BWPO5eVDCPCqkImaaOKhH9Mu7tmlIZgL/3slV1S3ucXTgrVDv2/KjiNGKffmi2u8wDcVvLTlsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595870; c=relaxed/simple;
	bh=MLwVgMiS9MXpSzGX1zc0uxa5SCct/8aqMgcl2/E/HR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdY+mNaFSE81Bk8o4jOH1iqnQYIT2hE8K0W1c9DUK7qVNNQCNfjyAQLBZrznDtOlRQ7jKoGPKukXXWQEDO1b55KCE6y/HH6K/WacT4iBSoUdeFcZCpkhKnUP/uUDQxUiiM5kedksq0SPY+vMcCedLqfpH63cUTVVAg4EUSr2NA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRIsSCwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4986C433B1;
	Mon,  4 Mar 2024 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595870;
	bh=MLwVgMiS9MXpSzGX1zc0uxa5SCct/8aqMgcl2/E/HR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DRIsSCwQNmRKaCQlUTQflisG+76M/OHZgr3iwCGv3EUOdj9BZ9jxdbI8QFLMuuEXa
	 fVfVcCoY0+CQlY0Efn7Ic6afZXXh28UH9WTBfa6ZTfGoOdKve+VMIgjyFD1EvYtDwO
	 J8Y54AhGFIjTVh/96p0WKxnnok9dM/d7IblJXtdjfBWtTu6DlQmSVL/cLEUpKBdHfx
	 nbhT5AV+gpCVo2z2ZT6o/+1CIVQLJhaO8772zOsz8SQIuQGMQhTvaRwLNggYwWfUJS
	 uqEoaSr+gPtEytQLOglxmlspmssyosl5Xxop2qKaunZtyjjUJealD4D18PYggbzxYc
	 acl/x5Q1Lw6gg==
Message-ID: <b86d6e62-ac57-4bd4-aeef-de37766a12f9@kernel.org>
Date: Tue, 5 Mar 2024 08:44:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: add Canaan K230 boards compatible
 strings
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_919C60B8F6882311AE464C66C86223041F06@qq.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <tencent_919C60B8F6882311AE464C66C86223041F06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 06:05, Yangyu Chen wrote:
> Since K230 was released, K210 is no longer the only SoC in the Kendryte
> series, so remove the K210 string from the description. Also, add two
> boards based on k230 to compatible strings to allow them to be used in the
> dt.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


