Return-Path: <linux-kernel+bounces-144117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1298A420B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A038B20F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308F37171;
	Sun, 14 Apr 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sPuV3rjF"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C91E53F;
	Sun, 14 Apr 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713093852; cv=none; b=bStW0cJMVmDq17sL3Ik7ZuvCplxupMg0c49/vGIXgJUM8zemSrCD57Z5hv2YurOzZ0Kv6g5iOpPKyIi4qmF+aTz/8K57rQ8g9WjxfUn15ggQ0A22srfeX5ggz6jHJe0snjSAMzP5w3Rl2S+kn64NZqOS1ZkHZWCqcVG3it9Vu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713093852; c=relaxed/simple;
	bh=3+14d476HF7Eg/5x5VeFkS89dhibjhDZzn1zokZIIQs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UOZCCNIhq5Ihf6GBRsQS4pg636rfWjQ7fNZ6RrLR8r5Lh0AXiE0rYn5kLH9G3EXUV4LvrqeSEiejd6D7uBsWOz6I5xYe4OVL88coVLYLHNgvHHcFnJZS3/IZTD7iLNPVf+o16RgQccbP+b2epZOE29Z7HgGKb1KwsPVD84+ZaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sPuV3rjF; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713093828; x=1713698628; i=markus.elfring@web.de;
	bh=3+14d476HF7Eg/5x5VeFkS89dhibjhDZzn1zokZIIQs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sPuV3rjFZ13FLpg+pHK+MqevD7wr9MEV9e2qzqlz0pM92Xll1MkNtp2grQ7d9aEJ
	 VxfgQmrNqXRrnTYLoOwdUUE4Ob6SYMpJjLGggfoyl160a68BN9hjQ4skArLXuQqLl
	 tKdqs3S4hKxA/FFIZkPoxwYRQ+HdelpVer/OUaTRbkSK6IgwuwljMQEZPBPxInlUf
	 COs4usTsvryshn4jti0OO5t5rdZeP4DIckOH8viDknDRwRaTny7s/JBWzMu0a3m4o
	 5tkRS3yaqsGEBg331zOVNjHh8mtdpH1fj21CNryJrOFuOMag5FMEsuGNdQXt24LA1
	 4E1O9lyc/z+DKOrp0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1s8OXv2Vj1-00MwKN; Sun, 14
 Apr 2024 13:23:48 +0200
Message-ID: <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
Date: Sun, 14 Apr 2024 13:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240412181631.3488324-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:miItyTf1xf3ZWEaZIOQ8qWrYaLIZIV63roPT3U86WeNrAhnG35l
 0N/pZT/F0BjKk/7wD+8MzIQULDn4RXjOuiZG300XIFWlmNB6XQaFHUBtkx1PrBM46Ik2F90
 5alPUYQFlYqPt6ZiWrPK3p/1Ij7mhKkNTAzoytZyjaxEb3oBAo5rtc1XcEwzXhbA0XAg0Rr
 OY9UDkKkJGNzaUsFUe13w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GIlrxNOERsg=;zur1JOD68uS+ZeqZSZo/HCSPoDE
 gLgUzmFjZ+9AQc4RtpNSjhEUNHU7IMWSYfXnhFUrbeHgfZMApdScXNHaV2rrQgG82dMZkAyWm
 PIRpFd1kEq2VjT0MtyNPYkc5797ZtvGoNcniNXiRcforFh38dEnlmrKqUiDJU/8WFVm67r82m
 Tx939w55VY6vP4WKX/LEYkrj7nS3awW6lL9REEK07L7d7IwecofGsgRVRJxvE6ueBncCL+n0+
 YyczTsHrdBoSv7upeGvZ2wb9/EJhwinRX+J06ZUPU9jMo85YpAyVWPp3+Zk1KzsVj2k66WAZ1
 z6AlCHkZJlplJ3HRIa46RsPQt4up0G3IVuzct902Q5Zv0wdLulRMmc97sAFznFy6mm/BTEGA4
 LtYaICdmIUcKqm1gWf32vkUMGF/sZl/Cd75KzywuLHrUE+PlD5UR14GMfC2ViKsSL8U76TZSy
 vtMZOTmTbrFK9FsvaY9daNshq++mAJ2HmEpAqYSQNbYenZXaSQoo8kVTisW9kmwQY2neLI1AY
 NKlARD3iDeyFcqUEeIbpD3cfTr2YTandFsn0pHk6hSWbByQcSLBZbSP8FBJAlCH5mzxvhnQfI
 UiHrwk6RksuLEhLgeapjgm0hDr4T6uR4KpfmduoJtBCea+ZbCpGV4otKnyLrkkZvMVly212kc
 C32LBSO3bf1Xi9bNFnnYYFYqgXMFYrLhURgC3QL57e0W/3nbNy/Wy1bMWfkWKWiWj4FWJ90ar
 uHzhBuaUtsjQJFmUIeFKuT1WiRNxfyV/gQfUxwt8V/8xTGTeV8quyXlLHP5XSNT9mYO55cv2n
 okvlX14CBScbKPmFvl+jSydplH++UOvJWd/nHXcj8jf+8=

Can it be nicer to use the word =E2=80=9Cinterface=E2=80=9D instead of =E2=
=80=9Cif=E2=80=9D
in the summary phrase?


> When bringing down the TX rings we flush the rings but forget to
> reclaimed the flushed packets. This lead to a memory leak since we
> do not free the dma mapped buffers. =E2=80=A6

I find this change description improvable.

* How do you think about to avoid typos?

* Would another imperative wording be more desirable?

Regards,
Markus

