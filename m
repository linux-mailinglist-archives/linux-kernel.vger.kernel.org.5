Return-Path: <linux-kernel+bounces-152587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB18AC0CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3348DB20BD5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F73DB9A;
	Sun, 21 Apr 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NmdeSaFS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46329422;
	Sun, 21 Apr 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725714; cv=none; b=Bn2Q1MHM3aTwKH4iPbIM92TScyUX2DjfNhGve6YZw9+zpn5goyHhOjGTsyPyloI9xls13uTRmVPV7G3dI51S5a3DeGeU1AqSfJrj+EnVDcSja42wW2j3D5iTDsWcR0exkH7pCAclcYXQjwGmKG3BHTJqmZKHgs5eIcSoHV/a8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725714; c=relaxed/simple;
	bh=7QMnYzVo0rA4PQigT68uIjeqE+sBk+cwQdKjzoerh9I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kRPc9hyAE8vND1Tlqa9bhFfQ9ui45UvdT8MIbr5seVayEQq2byZf+eMj46pCyrPgOd9vXCcy1lFJnzO/pIUkI8Fgdaagx0L+xss55bff/z47M94w4Juhfm4CkKrbbzl+ab/xobh3aZzY5wxmErddwQZL3y8VVKAUVY929yiKd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NmdeSaFS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3273E1BF203;
	Sun, 21 Apr 2024 18:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713725709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUNbORL/3INaIWPSTEZc9brKWOzN/OqC04ZQVfTjKGg=;
	b=NmdeSaFSkHrSuC+jBAghlH7/fb1qwiTuDrlhvcFsch5yTj489Tx9YmKXSYvsTmBqukdNrh
	cnNX8nWcxEDEh1POvtwxRczpxMVsoodN4yojiKOcTbcryyyBM066escRQmZjNw+iFxrpug
	nbBJ3obYzem/kXKVN9yyJjW2ZrdgjU9GDEJOOLHYkCROjqlmyVpYIxRQ51pxMRVL4BfLQ7
	qKsI0CIEo1zRk3D4nN9onyUQckw0t9h3tUL0X8SNj6/bAIpHeETgatpk7w157fEOCKz0mx
	XpbV4LkOiyndTfldpH0o/8N26+WkMT9nrnvJtt0eGESvt7BT3OwgCItHMirWgw==
Message-ID: <b1f59075-f2b0-4f2c-aea3-bc596ac45f1c@bootlin.com>
Date: Sun, 21 Apr 2024 20:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chao Wei <chao.wei@sophgo.com>
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
 <20240421055710.143617-2-michael.opdenacker@bootlin.com>
 <c30cc11a-209a-4919-a382-7588daff0d71@linaro.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <c30cc11a-209a-4919-a382-7588daff0d71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com

Hi Krzysztof

On 4/21/24 at 16:12, Krzysztof Kozlowski wrote:
> On 21/04/2024 07:57, michael.opdenacker@bootlin.com wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> Document the compatible strings for the Milk-V Duo S board[1] which uses
>> the SOPHGO SG2000 SoC, compatible with the CV1812H SoC[2].
>>
>> Link: https://milkv.io/duo-s [1]
>> Link: https://en.sophgo.com/product/introduce/cv181xH.html [2]
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> ---
> Where is the changelog? It's v6!

Oops, it was in my cover letter 
(https://lore.kernel.org/linux-riscv/20240421055710.143617-1-michael.opdenacker@bootlin.com/T/#t), 
which you didn't get because of get-maintainer.pl. As the recipients are 
patch dependent, am I supposed to describe the changes in all patches 
and not only in the cover letter?

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


