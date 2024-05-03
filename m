Return-Path: <linux-kernel+bounces-167713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89838BADDA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D6A1F233CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79C153BE6;
	Fri,  3 May 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hj4XE+y7"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA515098B;
	Fri,  3 May 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743574; cv=none; b=ew0nzqYHbLHUpKp6h7sYjYEHtlvnLNVXSXtQOkvxi2bodL9Qq4nYyk60n6cjefDqW/HYxU1rVoogzoxORG4v8DOcBRUIkLVXjg45DfgeY5biUn76uXlwxu5/TyDGKV9J0+1ar2E+1+T1xsXAsdNsgj9eLvYPh6FpwLE3rwHPh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743574; c=relaxed/simple;
	bh=wo0QU62gAcbFwDG11bIh1nXKjLRrclnV6zmqslwIfeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWZ5b2Ycr492zhS+w6YM/19dR/X4BfEYyf5Hm42HO1cYXCs9If/tp84rGFjL9jYn4/wDLG6rTo2nM1MNir4uN6wOcTxwSonMHO6CBfObf9EQX1q8Iw9B+KD22UsYYDJdn6s90KgcbGWuxR7ISNVYaGtchhRAUGYnrgwd9gEIpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hj4XE+y7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714743543; x=1715348343; i=markus.elfring@web.de;
	bh=IGI0qz3dQ+k6A0uofqhrJJ6evY2iyX3SxlzugUF9+xc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hj4XE+y7o7C/GGnH6feTPHHSTb5ZeeZanw9AfycUnW3EUCwkR9guSftjaySEEAzk
	 fSXVjDe/uWDzNfRp8vul2zb7alMn0argtyLEmTfwEh1oPtPJBpdcVt298qcJ9FgW8
	 cyshmHA71QySuJre0VUCQQddtsVcDPBUK1UhTtBpmpjvrC0/WoSlNbaS+So5zgNNP
	 3a9nYJw5JJm1I2cr9YIQ1MgQflHV70N864pHxhzow92e+iGY9CP/f2exD1nu5FePm
	 BDE5mVCzCAtzS04DXMzKW48ENt+uF/Q9r18EiZ9MZAbututpUi+Rd73brFBEgE6LZ
	 MfOkqjtNPjoqHjrbBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1sJsHI3kNK-00Hhez; Fri, 03
 May 2024 15:39:02 +0200
Message-ID: <86a187fc-f5c1-4dd2-b04f-4bb645312778@web.de>
Date: Fri, 3 May 2024 15:39:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 2/2] ax25: fix potential reference counting leak in
 ax25_addr_ax25dev
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?J=C3=B6rg_Reuter?= <jreuter@yaina.de>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Lars Kellogg-Stedman <lars@oddbit.com>, Simon Horman <horms@kernel.org>
References: <cover.1714690906.git.duoming@zju.edu.cn>
 <74e840d98f2bfc79c6059993b2fc1ed3888faba4.1714690906.git.duoming@zju.edu.cn>
 <6eac7fc4-9ade-41bb-a861-d7f339b388f6@web.de>
 <e471ec93-6182-4af0-9584-a35e2680c66d@moroto.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e471ec93-6182-4af0-9584-a35e2680c66d@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nd2DQJfArES+9w/0Cx8G6oyBYfgMbxDGGon9AdjSeBibAva6QhB
 ARFO7Opz/0DOWAqwFPikyiG6wRJU6a27FBubqwGweudrWiVWgh0G1PB+0zqr5b8trETu5xR
 p+ps/e8YWVJpqEhsnFR/yKVxF04WJBy6rn0HH4rI4xTEnQAMHc4Jd7xOdjUvO0vSWNLNoE3
 PQZdAjTASvjJe9nbGpr8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YAgKMjnV/vk=;4QojFnJh2CxI5YSQZDmt8TFAuzI
 rYqA6sJ9XCNZBMDMtBkxGEyU6IBAg6pZmUET1sWt+pC5ezTEyfdX2+xZpS5N4XNqTZtzDY88j
 VQDAytfii7sqz/WR22PwdqgKtl3M6SQZrpWwbwT0SfrH0lhNO9pT958hO81fnz/DMJrkyR06+
 tuTcHsU4SKQQATUs5qAZ/0JR3Tbwv4mscPfreVywrj+QVs0Ix8M6vELNRfZuR9QHNT5IsbUXM
 2l/5jmK9p/vYatVx0ly9ak2atfkfZVmGL0/WQ+XIJMnC7xqiOa9FT02KKylFihiBe/BWnIKj/
 Y1X6JaaDDiQV6ITk9uJj9Ttrdl4Ji0E2gicEVh2nKBM+triopNoUOWKSZLbN5kiejtbuVZ0UY
 Cv+/a+B8o5/9D2bUO5jo18MN/6pd84xmaI/YT06ctX8tGNlb+EXwLZZmo3lWo90U4xE+ptWZS
 4fHa8mj7XSXTW+K4tb73f6f5u2+dFCPB3Umi7KJqoCl0/lLxv89/drW2VuJjX8TvJyu6u0HK+
 /A4gGQ8oEFYSaSXQff6c1/MbfFst7Bnyb8B/bFVxeTl62EDtbOeBw9oDPofqtvHi0XPRFllfN
 FL5PxLoB3y6/9bNe8pajVU3kaKpZSE9SW+nD/FtQv0enD4bpxkksPCmOJqiw63/BQT7J9S1BF
 WFT+zRfjeBJs4dGMr4iXpTbN8wAc7XIu8FuAQaoclx90SAW3osOoV8lxUvMiAFcX9VXkpfGtA
 BN4zHuZruPPVnZOUMGdo/6qSQtsiPYuC3djzI/4rsXPcNGvQgGSGBLZZt/wxtiWusrFENxOe1
 9UHhkjC+oV8JqlyNBi/YCykMa0rZ+ufUGiV9G2qqekLGYXsMzZs0bQEQnIz3TjZsID

> The commit message is fine as-is.  Please stop nit-picking.

I dare to point recurring improvement possibilities out.
I became curious if the change acceptance will ever grow accordingly.

Regards,
Markus

