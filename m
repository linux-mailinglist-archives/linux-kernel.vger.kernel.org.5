Return-Path: <linux-kernel+bounces-161496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE88B4CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD57228174E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67A71B48;
	Sun, 28 Apr 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RmNTbBV6"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA06F083;
	Sun, 28 Apr 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714322335; cv=none; b=ejUj9UEvWPQhxe5Aumh3qEbjoucJTMzpxk5OO5jxcZkFnswIgGRqM15ExeXZDuSWe2oA7EW6mN/xPSDJAl2BxA4UUPnaWDLQwB6hfSarmwCArJUtHKM5/4wdrHJlhv0UItAr0dUlOJ7sZrZuXG4xLenOCdEc/FNu8RPF2Wxd1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714322335; c=relaxed/simple;
	bh=F9IAuojiJRJBdMfdXolE1CKZT+516XOdcs3LxcFaXlQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aSmZW/kTBL+yo/ryaHp8kmqr4ezhjnkArFAfeb3n9VNStQdHCx4fEfkoAiMx0c/fZqr1Jr9+KOkvY1X0Va9kF52+lsBM31ZlrF51ooQKQrFqoDPWxKH61glErqE8V5kKjzwu7aP0BzIMqreN//VQ+PIPPAPRxyVmRFiBwY1YgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RmNTbBV6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714322317; x=1714927117; i=markus.elfring@web.de;
	bh=F9IAuojiJRJBdMfdXolE1CKZT+516XOdcs3LxcFaXlQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RmNTbBV6emQQxkKqg0S1hFN72jQ6StcSvpnc882kBNBj0LiasbzhmWtcgYcL6hog
	 jBf3wG3C8wOBaATeNyegYOZ6FsNSb6ysehGgwdTw0IqrHWaSXvWVa10TLjHqxxYjf
	 cvZ3GIMVG37yrPsXibS4nhfYiLSDO6xEBZRD/6qqcbPAyYEm8Oy6llzU03T47L0lo
	 QZMVAKW0+2j9vSzjC0QDsqg3zrB2oFwVTuO8BxaFqRoxfxE91kFYqpkjkWmQZkqZm
	 t52ahIncuxl6hqB9J22LpmL3rte4t4yYnLHCQ6pois6k2tCwLLknRh5TAsdOE2gwh
	 YpncIYl+HdUJuCS3Lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sbr-1rzkMs37zz-00DNys; Sun, 28
 Apr 2024 18:38:37 +0200
Message-ID: <c9bd5c39-ce8d-4c4b-8a1d-ae90298c4f92@web.de>
Date: Sun, 28 Apr 2024 18:38:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sungwoo Kim <iam@sung-woo.kim>, linux-bluetooth@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Dave (Jing) Tian"
 <daveti@purdue.edu>
References: <20240428015834.2485653-1-iam@sung-woo.kim>
Subject: Re: [PATCH v2] Bluetooth: msft: fix slab-use-after-free in
 msft_do_close()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240428015834.2485653-1-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KgATldkKNdd0yMfd/hsnoSA3khz4WDL7eZ1c45p78WC4Se1AaAj
 P9LodVlemdun9GSJCHLkVYTdsLRiVVzIlhtd00WOvIfvkXCzhFKxrEPfDjvyyXmLCpURju/
 8KZauxsqG/dmQ+FsUMlrvfy3Ek8JCU9uB5Vzk2ss70r9u6tvvDY2z3NpTg24A9+GXMVWOhZ
 PDSR6Ws10psFmd/PDBgVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+wVU6gULitE=;kmnn2v4nHZT0auwpAOQM25RTioh
 dcUiA/naPB7nnWm+4mFrrjILOP7VwKPsgNa/fHW9MxfM+PVCvgvRUwtB3Me4x6YYuvLqnAoUp
 3PA37tLJdvsPwKK/ynWiuO4RAjlK3UooWEoNLm4gHGm3JG8UTnlmgTeIvxfzuUF2UhBWnNff5
 X3PkiBPYuVVnv8ODORmJVYyAxoYqk0HE1JAqEXWN7z/pHOjeDHSJipwfawtzpI3izUEqndFNb
 xkN4diRLDA8j9dAMB7UH9Idn71sAiFrfE0AT1cu/GwINcQNwDMgLWWmFrHXowagCUTj9ox6tC
 HNIxW3HvYnmDYTL9jF+KuDgeQqyG8d8wSDg49GHDe7cXhlwGU6kvMrYnaQSZ9mgicdWkzE5df
 bF/PujDUiOQfXTeWPrWPEzN9FvbjCdF8uvyJPCzaOzoub1rRLq1zB1wkBEkFHHHN1acD0h6eh
 83s2T2eqZFosxeHzuZTY9ZfmKiQxG4YyMP59E3MUuVRfFoyYfA+Vw+W3uz4wIxa8LJ/D5J4F7
 HxI/uybwbDlCc6Iejia4pdu2e3LQtH+mDQlz3CeTD0ZVqXDBKuSfzPv48qfR3JdM7wEV/NvdY
 z2qjfMFsz+4lIu7v19O8Ys3J6sxY6jpFyDBlA2qOX++8olTBTiEZM7VB2ns7kdRymFmMYIQEl
 226nvTJlXCYyGRuGOVP4NUMY0/NoJa3CPF3hQVmLb5GuiLQutT33RqDTL7G3LknQJG4PTf58w
 Cxg9PWdckLAg2+27jl4NtA8ODaK1X6Sl4J2LXnbIIye2R55oRmD1tQVq6SYYs4TqSKfZCZSnh
 Sbm/68HBAUgbc/ig3xteyKBT00qJTBzvLsMjOtIhNUPFk=

Will an other distribution of email addresses over recipient lists be more helpful?


> Hi, could you review this patch?

I suggest to reconsider such a question once for the final commit message.


> Now *not static* msft functions hold and put hdev->msft_data.
> It prevents from potential and real use-after-free bugs.

Is another corresponding imperative wording desirable for an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc5#n94

Regards,
Markus

