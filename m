Return-Path: <linux-kernel+bounces-65734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1C8550F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFD21F22A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6A1272CE;
	Wed, 14 Feb 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="cXgGDjnz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B91272C1;
	Wed, 14 Feb 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933396; cv=none; b=lTO1AD+GB4tgTDwWWdM2wWms4uzbjypcdPVrodS6LCx7Wlzm5VcXnM2bS3aznJ4mTeetflRLt7Qq32Nwlmdg05jwjb7ycEQ6PIeRnr/wZz/LdYvTLAmNJ93GAQ6EeQfVAjiwAsQsZzLlGY9oCaEoKKj3O93oFl++ZMWC/U/hGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933396; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MudqNiApihLg8wTttOErkaJAsZtFOAJ0QzVY4AM3BVZbrGjl8P+gkQbip9u09CNcAJ1Vh6F3tfEkqavvZ83+FE5e6A4QAlMCehW8g2h1NBM3xWJ8xFUixS6j/vr0vwvgkz0c5SdiTP1Ti8bydG+N8oQKSN6yCcr6shUDTsZCC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=cXgGDjnz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707933391; x=1708538191; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=cXgGDjnzoEb5SpEpFcWxrF8sJ9/yPMJf5330cQ9YPN0aKyyqPUTs9f4n3wTebCuc
	 D4KjmEjlnLglI1cOuVYrM3v0OBdNjdrMu5BDYKoZUr56JY+nbtgpR+Z7rNUUCIIxw
	 ia4q4nN4XRK7dZ/zA+CungZ6+oIP/aKlqy6a5vDuOntm7jKnVsRrrYI2pkZcFZraN
	 RgpRZhhXz/AjUjpyD9kdY6UE+ZM20NGG5Oh10KTJcd58jtPuNSFPBkyMrzy0iVFFP
	 yM8zKMuSPILVbPZDP5EtmES7+F6Qn/QLSyqFi/zmMNOIhZdyUYUKIpwsNLsxh8TFO
	 uLnvkYv4ee5DBd5eLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1rIvCY2GbR-00Hto9; Wed, 14
 Feb 2024 18:56:31 +0100
Message-ID: <06410db1-8e61-426b-b204-fd2bc6b8a1ec@gmx.de>
Date: Wed, 14 Feb 2024 18:56:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qaZ/0nh/k1WhowqGYe/anG+vLQAhVKj+0i4vPCvQlchzmlkIRcW
 S1EwtF00Wgl/f5c2EeKoXMkT1QxTnoLwHfJyNj0GvUEeFjKvCPPNvGQZGeHuJM27pA4gMYp
 lt3MayhBjm+aE2HURcWiBsF02jc4lhdcu9Z9i+5t/v9YA0FPy3rDb44WoZ9NOrPutRsTGBK
 XEeEZ2kOYA2miABl30JxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZNAMGBlmx3I=;ph1Rc/1kF/RcPK5c+Qs4yl8dt5e
 /TfotRLSR3p1MRhamnwDaMRxnkoxUjjgPiTkT5Oo1E4/nNtausSfF2haT4qXlB4PW3lJtfLJl
 SNr5u56MIHfZm5ZS/WXGqf3Enk5mqTPdH1x+x2eeHH4knJ0Uicj3XbBSGoSPHxWzFtsqs164U
 HqPBp9/xzbSr7n6rcdwlTGHXIOsW1aoEwtiharUO09gv4OPbs9wKvgZgUHtwHRt2z3kvE8Wad
 O3sp4EDdJd0p/hE62rDEZHIr/AkiCic64B1tGkVu4XpMBO3gxnqb2CL2vaTaC6FuHQgalUKdp
 tNvs+iJ6e3Oi0vHfZ/zzpN0tXKaVqBBHGF2ebvrkcRzFvoJmgJTXlVX0hqafiBAjyuZzb0GiX
 kak83jG5EYpNEcKIGbzhgsskpnEV+B+La0aY1yUBAhm06ek6yea2MuN+AMXJm3jXbEKnh9aZo
 IIEnKbAB+cz3DCMzzHI7vk8evXO4UDYrs9z341OmgnoWSaAF5JOzfbpTEUYQ81eNMRjfnnpVp
 HzN+uOucIgalL5o//yjFBE7lQH2bHpwYuccTI6iPGR4MLspvd7xdfrBK8OpL6SqJNfBIs+qxi
 dswEcZguo3aiPiIncxwtQ1y0lO6/YIY3Yvlpqtsq7B6mu7fuWF+Wh5OhMB3HMqk4C4ues39Od
 ebjIczmrS6Eqpht76u0mVs0+JOwF5X1ynYuDC0chymGx4jCeuP4WEryqKmLAhe87VoaYvo1tE
 lwQIsyleEqyFOg2ms9vl6nsFxop8VjjTg/Tf/aZmRpvMI1nV+JDUhUJGO2Mjc4meJAyAJ6tFb
 e5jJdbJPoyrqUDMY00GSPSj92nl2aPw8iwF3rglg5PNAY=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


