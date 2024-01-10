Return-Path: <linux-kernel+bounces-22169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A95829A68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F921F21751
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DE482DB;
	Wed, 10 Jan 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CIw97ZXI"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330D47A55;
	Wed, 10 Jan 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704889484; x=1705494284; i=markus.elfring@web.de;
	bh=bXp9XOuj6G+aa6cVL5p/nkG2HouNiljoh8dMsE9hawc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=CIw97ZXIc9n7csZuHa9z4MMezFc727wM79+WbJaWTxJEjJ5GQ8p2j90Rc8g+adWW
	 gZfPzaB1tSy5wVXgIZf3O11XSXQ0qvWyd7RaSEP+CmiizYqLgXA9dUy4b5E+KZJ/8
	 1bDe2Gwzf5U03Grb/ZiHwtY6zvmI+QzGe1ngjy3sO8OlUsUW8ZUxvB9MinNR2tNGk
	 QPzf37nt2lJHab1UQk8U1uz71gyF690f3DJ5rXv6oaHmzyv33ue9C9LOV3UOKb1DA
	 9pZhfgJtWLAV4yGLXUpdUXBT99OQVCXPweo8sG0rvpv6dhBE4ai8ao3U+nz0h0rDP
	 aiVsCYi0vHkf0hMW+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1rGwzs1r9U-006mUy; Wed, 10
 Jan 2024 13:24:44 +0100
Message-ID: <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
Date: Wed, 10 Jan 2024 13:24:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] overlayfs: Adjustments for ovl_fill_super()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
In-Reply-To: <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EFc8wEm4ecn7ET0ZeDrJeCmtaQ5q+qZHT1q9bxX2hqXmf59juQz
 frV7MfqpX+Bzk+dQoiJQ7bji0glMW281Q3d61kktmMMpjqNwr1eohcdiOt+1L25fdpi39ip
 GKjxeAMKwnicNKOCmCnDbMr0RR0ag3fIC50Vq5fNN/dCsr9wLnHKJDZzOxnAYYq99kJl7nK
 lD9TisiwPinlJS/RRU2OA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kyXWa+brFZU=;uE/SlU8sSswPYj8UlkyLq93xLiN
 meQAsWIocCtqAM8u2LzFrosS8O29zsmjByZt4Vdge7z+Vom3rJE+fHrgWsfje8aT4Or9HZVER
 NWatVPVjlYoe89VcNBtm46Z6OmjI/oPlrsCmcQjqbyFEUec0fjfBQGyMhwsqUxhjT39rkIumq
 JIr97/NHFXpGQE9ODo9HQxaPiM3G04hajufhhnLevIw04VJcAykER6v2VgpiC+AL6mmWRf2Be
 KBe4UiGzSGTY1fhbuvrRl1jPnu1Sh7/19JzfOZk/A4BAvuvchNBtpJvq/HGbizJ+CP+IgWapt
 3d/fVpmRS9WG0vLYPTnS68ULA5vXIRc1yksCezPCj3zd9SSwpUV7HhyHe+LT0rF58LPvimhBn
 HgrSbbvQhpW6JdCnStPsvmgfgHLJbIn8CnP2lMLHR9v04fNNIkhklIVFPW2XNlPKruC909cfZ
 r+/I744A/oFJGOsQ4GtpsMe1CQkrXoe2tNKXHAVoh86jraggNR/B1h8s6ly+KogsmH/Ph9dOO
 shwHU2WGxTgHRWGQIh7uEVCEIjFue6gv97g0wCqqqgfjw8kfqYSjR5874UTg/lPpwy1Vm9reH
 u4wMycbD4GBF0lH9WLTb94DwvE5Ti08GB1fcUkg+elxn6cyACP1wKNJDjXD0KJavAIH9O6pJR
 wDbLCp7aKntT+VwTOqcdGLFuoJDpC379kQ1vWNxG+VaYn6c6fiKptxhbGpdjoxqplvrb4K7m2
 2MtDTR8f89pHwfxftrq/stZD+y2t9qIBGCNV7gC4pcjJyihwnU+bqR+KdVhLdW4bWQyhwoBAP
 iBBYfASNbWMh1ccejUyq5rtVpIoKaz+HpdtXnX2xWHZFI2Hv4IvIQvS7NAmCM1XKZ4BkZT/gK
 tR7wQxvKjUTdkM9U6JY6Ggws/jovMlTWqsyZ6zzfNFAfODJpoGBIn8GsDeZAsdaZ+FCqu7ISg
 6rAaLQ==

> Date: Thu, 30 Mar 2023 10:38:23 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Return directly for two checks
>   Improve two size determinations
>   Improve exception handling
>   Move some assignments for the variable =E2=80=9Cerr=E2=80=9D
>
>  fs/overlayfs/super.c | 72 ++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 33 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html

Regards,
Markus

