Return-Path: <linux-kernel+bounces-71675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C3E85A8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB2EB27112
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E43CF5F;
	Mon, 19 Feb 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m7wAZCUy"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22B3D553;
	Mon, 19 Feb 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359901; cv=none; b=Rmx25MFPwaukYwPoHkJ/KiOfdUIs6qCYQ4xgn2QC7F+L/hIX7WWiEHZFcHYO8bMbhKxD3J2yLyYwyEBsY+09V7RC5cO7YFSPzYuH/JftwCH+JrHZpCbXLIkf89UGPw0hTvjBAKZGKN7hwERawrnsG8aS+EjGbrB/lo89KIaCjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359901; c=relaxed/simple;
	bh=cFjJxouXv5NZJXPTmp/tnMpe+c8tHhVBt4C7mhJC21g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjB0+dJDYjbleD8OAam5hH0O3qqSrBkFYWOZlAijC6mCEYDg5Lg8Ikink3l1jZwpnMKefrrDWPYJdACDxRUAwbkBr3ZJGrDAS5H1KkJN34cX8VGgT7NYd7B2iGqqeUkrgmSOEUphmMLlw8f+TZWzqox3fcg3E2kztvJxBtfFc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m7wAZCUy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17EF01BF204;
	Mon, 19 Feb 2024 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708359896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7X6+O6y7A5fbGRJ2LaA18oGTtAGJIFRQoFoV1pDv1E=;
	b=m7wAZCUyxT/q4P16f+n13OjvXMouLWL0dOW2ObxcuTX9ADRcvJPunAPBSVoRQzuCphdQlR
	ynSJcn5phtdBRfOU66TCFyCZnLJhfosfYOQeJqIcaruRNsIAGv0zxYjfzw8Cl799wj2JhV
	2bFFW8Olnlxfw4ulwl0T0nXC31kX5lmwkghosj/PBFfCqK38xi8HuwIf8ZbAwCm7TIuGFT
	ZxvopUEEhbPts6b/gVwWiIf32TI8n66ceq56SSnz2Ylr1X+aVVUSOMadtj5msTBe3mwVQV
	O/5pyz/CsP6BrMjal/4I3Aexjij82u7nc06QtmVRIuvuz6LprwI9LTDAENZ1Vg==
Message-ID: <b3c31f4c-e837-47b6-bd0d-e8cf2b9964aa@bootlin.com>
Date: Mon, 19 Feb 2024 17:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: wilc1000: fix RCU usage
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
 <87h6i4mnoj.fsf@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <87h6i4mnoj.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/19/24 17:19, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> writes:
> 
>> This small series aims to fix multiple warnings observed when enabling
>> CONFIG_PROVE_RCU_LIST:
>> - add missing locks to create corresponding critical read sections
>> - fix mix between RCU and SRCU API usage
>>
>> While at it, since SRCU API is already in use in the driver, any fix done
>> on RCU usage was also done with the SRCU variant of RCU API. I do not
>> really get why we are using SRCU in this driver instead of classic RCU, as
>> it seems to be done in any other wireless driver.
> 
> And even more so, no other driver in drivers/net use SRCU.
> 
>> My understanding is that primary SRCU use case is for compatibility
>> with realtime kernel, which needs to be preemptible everywhere. Has
>> the driver been really developped with this constraint in mind ? If
>> you have more details about this, feel free to educate me.
> 
> Alexis, if you have the time I recommend submitting a patchset
> converting wilc1000 to use classic RCU. At least I have a hard time
> understanding why SRCU is needed, especially after seeing the warning
> you found.

If nobody else comes in with a strong argument in favor of keeping SRCU, yes I
can certainly add that to my backlog :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


