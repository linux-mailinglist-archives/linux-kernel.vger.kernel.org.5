Return-Path: <linux-kernel+bounces-138111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB289ECC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8442AB23DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BF13D511;
	Wed, 10 Apr 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hEdarTcD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E613D292;
	Wed, 10 Apr 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735725; cv=none; b=p56sNMyn7k6cX/s5aQk54fBM6g2jxDZ0iOnjI8/DVlgB7ANE6vNfGMHcK/GpxBh/2Hj7yXsYwTLT6O6/MHP2EnK5B7+1ZasBmEDo0XJn5WFHcMLcVvApEcEfIHLf5rngmUY3G6pPu8ax/Ljuofh6ZS5WUG3b+WGd4iqTo4KnOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735725; c=relaxed/simple;
	bh=mWC2OIQVqS3CRHhrFCocKF0GWvMunSSSbhV2Hxaoe5o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pNjCZQPg55lLAYe7WKOvSBYAuFewk4rYY1NVHzEIEYRElt2J78URm1+h2VO0Ybgt0pGSA/HWpnWoZUTheeE29tWH1aeL3zyC9Rrvd2ot1QRhNBwj+XS63qbI/cnKC07DEFQhjutOCncc1BASoJfk5gb/GKhy7WRnNqMpaMlophs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hEdarTcD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3C07C000C;
	Wed, 10 Apr 2024 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712735720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDI/zeKH+yD7jjNfXUrLM7ZD8dXBkFQWz20udRtTqdM=;
	b=hEdarTcD4lflcfgPdpLzn00x8yijybteucx6Umk2XvH8uJdr3aO5EKQ5QqznlyHVDQP54v
	loZm6iZzFbmb1eBMNXmFbcUeK0IoSYGoXs83eM9wWrUvbWds9obRxe17Vf+hLv6S2oeZWc
	BMn1Yc4IFQiCjZ6lsF/V0yzewFneSs8CgbRnRnuq1auUOzNEgyrlraBlm1xdQLdfX7R1WD
	2kKWDViI/MaF1qsnSwckokZpKIupYq5aJeZfU43r8pneT12Z/aqVvaCMmoYzbl2+LejUve
	lTYu5wwOGYvI+srveEzjK9jaYSpMceuvu8eGoKqLRss5eMQOIgX6UL4ZVlxGCg==
Message-ID: <115662f6-a390-497e-903e-5a9bbb15e08b@bootlin.com>
Date: Wed, 10 Apr 2024 09:55:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
To: Inochi Amaoto <inochiama@outlook.com>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chao Wei <chao.wei@sophgo.com>
References: <20240410062254.2955647-1-michael.opdenacker@bootlin.com>
 <20240410062254.2955647-2-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532EC9B654B5B1C2538851BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <IA1PR20MB49532EC9B654B5B1C2538851BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Inochi

Thanks for the reviews!

On 4/10/24 at 09:19, Inochi Amaoto wrote:
> On Wed, Apr 10, 2024 at 08:22:53AM +0200, michael.opdenacker@bootlin.com wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> Document the compatible strings for the Milk-V Duo S board[1] which uses
>> the SOPHGO SG2000 SoC, compatible with the SOPHGO CV1800B SoC[2].
>>
>> Link: https://milkv.io/duo-s [1]
>> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
>> index 9bc813dad098..1837bc550056 100644
>> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
>> @@ -21,6 +21,7 @@ properties:
>>         - items:
>>             - enum:
>>                 - milkv,duo
>> +              - milkv,duos
>>             - const: sophgo,cv1800b
> Why not adding sg2000 property? They are different series.
> IIRC, it at least a cv1813h not cv1800b. I suggest checking
> the vendor SDK to get the right board compatibles.

Here's what there was in the vendor provided DTB, if I noted it correctly:
compatible = "cvitek,cv181x";

Cheers
Michael

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


