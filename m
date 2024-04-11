Return-Path: <linux-kernel+bounces-140325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A18A12D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968221C2150C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714161482FD;
	Thu, 11 Apr 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="VmGGNk/o"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27913140E3C;
	Thu, 11 Apr 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834238; cv=none; b=RB2xlYdREvO7og5KifFImEEurpoJJlMmxch8NU9J0fismhKkw0wTsEcoR6/+VKxfQ0iZfYAr1kdUHRRlwhvsF43t1Es8ExfWLn+vn+BOtirEOrfZgfHHZSnE2ySkkAriuxqh2+2ESPzSm0vWM33wlP3F951tcRwZexpUbBxQHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834238; c=relaxed/simple;
	bh=vpXY7LnNVL610QmrMz07iZ3PIzo3Na8vT6Tn7Zj+yB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpA//7xx3FYa/41eEpVqqgC8M+bqtDFKp4MuxEfuhrUXGeybvTthTlalEsKhnS/ud+LYMK8fleMRq1cSg33QEphXiDynjManT8aqcvPGDCoXpfgtcKNGc3qibbeuAE/n4KdOpk5LcgXhcNT3R7YnKF8ttNEOOVGuZiuUx5wfzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=VmGGNk/o; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712834229; x=1713439029; i=toralf.foerster@gmx.de;
	bh=vpXY7LnNVL610QmrMz07iZ3PIzo3Na8vT6Tn7Zj+yB8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VmGGNk/oVrhAYcb7FLfTMEbEZMg0WMxag83jvSVh2zzk4MDgYv1KlgWxQvqT7jrL
	 NFuJroCPwORoGdUarUiUUwoVWIuMp5fRaJ2ArHXvtUhmR46ze41Ie0ckfywKq50xX
	 L2RvWgltPwGARkPAHqONHSpu8cm0jsuL+CHviYPepgmW2rIuLEJ8hSuGHKQ3xLeaE
	 5+ZIqD7nYgYrqdTp/sKC1yrwKDZeh4EKJzDfzDAq7li0h+Se/El9JmTWb+UUd/CYy
	 sDP32EYQTm4RFQ1RjW6Qm/rNmCQ0Ib3sPddYI17EMY2KVsXxdARuAbTQl7snGw5pz
	 KWlNXXcLgo4PTuO2iA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.6.56.137]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1s2KfY1ACT-00AApJ; Thu, 11
 Apr 2024 13:17:09 +0200
Message-ID: <d488a8b2-d298-479b-b4b0-278301317e42@gmx.de>
Date: Thu, 11 Apr 2024 13:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.8.5 does not boot (regression)
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <3c6e6172-cf64-4230-bcc5-7682b4d64a8a@gmx.de>
 <4e2ff80c-9e3f-433e-8783-cb9729c30bb2@leemhuis.info>
 <CAMj1kXHgvv0FYZXsFm8KisXuR6t47-nXtgOs0Gyva4MJEJ_4Ow@mail.gmail.com>
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
In-Reply-To: <CAMj1kXHgvv0FYZXsFm8KisXuR6t47-nXtgOs0Gyva4MJEJ_4Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KzQKee63A7jomUR/rnl/xP015gSt3G9pNmoZxvWyAU5MYITrIuU
 oRKy4u2y5NvAJbCh34Vwy83wcNBK2Fyx4KlaF+TLiNMyUY9zAwmjcdjOGiNRSvuWpaIulGy
 1E2RozRFj7vTL1B1hx/nJUcP5A2P82rfo+nr8F7jijUB+oMbA9CBt1sYMFhd/9eOTs/QZPP
 /2vPJ3T/1JWmkVCLMbf+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2PccxC8gol4=;LfyyNX82BXm/kQ0OVGRSWjYzPUP
 jnE2saB2rGUx3vh3SLxJCEZhXqS2T2Qet1tlGXIS8ivmB0hBgL618DfP0OUfSHswzLF2meQLa
 UrPrMGEJKvUo01MNdLqmp6Rc5JoJG4KooW/k79rRrGvDLhQEfXh5ZxYl/NHW8eKIPOgqtf5Yn
 nbYtftjXs0JOYrJpJPFQsSwCw/lqJrOmsk3CoMnhGLOYTYWBLrxwxcSAuwVQ0VL1xIThEe/7O
 WOxyAIkM6wL9uwwYP0X0DnSGG/GW3e1xTSd6A6oUcNnXg59QYFJQ5qfaNfptkuTE97VkMVN7w
 nmpcbUF8W5n/Ami89pAkBqRaLuJ2o9pZnrLolYWV/c4o8wl6+jBPBzF1R77Jl9GcNUXGKRgoX
 tls2P6B6n1ApJWAkrvu3vyTE95RkKYnjEz5uOnG25Ociv/P9b2sWSmudsu+4FFrnc6kyn90jy
 V6q38vfHVPLx5a30Dw31QqDW5poPv4WVOeF2Tzd6MOSCnY6gkLYMkPH+JiJKwFAvtr3v44IoU
 UPPrWHTTn6fSkdoBRYp8Wv6z+3s4w7vT9GNGT1w5hIF256wycAFBc2g296Qingk+/g/7fWwhm
 7MgbWCdzgTecwLk6kyS4ixpoBlSPeLMZ/+AQp0RcnvuP/L7fCHm3eZ7Er0mm7YlHEKLYfJq0+
 O+w+pKfLeIYCYDs9hf8vh5THorrRh9isusA0+dT7GiQ7OmB051VGib7lGixwxRAarM9U21pE1
 HEX3g/GSvikfz7fZb3VIQ3muItnav7ThTanWECy3Jk++7vZ58D9PphZn4WkZ+Q8cgZBdiFkMR
 AyvBk4DpOHPHa2v7CDA1jFUINhdyTRBjpHFtTUPiuGPks=

On 4/11/24 10:27, Ard Biesheuvel wrote:
> This is a known issue, and will be fixed in the next 6.8.y release.
>
> In the mean time, you can apply
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3De7d24c0aa8e678f41457d1304e2091cac6fd1a2e

cool - thx
=2D-
Toralf


