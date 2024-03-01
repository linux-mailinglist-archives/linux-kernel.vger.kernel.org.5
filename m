Return-Path: <linux-kernel+bounces-89031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333A86E9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5611F22E49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC4F3B289;
	Fri,  1 Mar 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRRMK7SK"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6B18646;
	Fri,  1 Mar 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321651; cv=none; b=KnoJ9TNvKR0ihluNDS27c23Esqq0vlc9+OnrW57dr6oPM+5geDWdXDc1Sud8lUtvqcHKlqB5fFuxzQPuSHsdDgjTyK2H3DBtWoKUN71rtxW0kBLnyh8y5gUPHK55cM/FjJGrwmDGkshec2mupFsLIyXoThmWligBYTdPQxKFy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321651; c=relaxed/simple;
	bh=tKPP13w0S/es7dczIvoHpFkDhA0GDQYA5cpuCZ40U9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9SC856UTweDw19rBUW+dv+DWNENGTkneTQwwCiYTiJs1Zgd+vAL4InZMr9qeFqo+bXHYCoAGNtq3COEcNT2ZpXXwDMQ7a2uC6wZLSRRw2I4Ms0/v4YLMKR1iCQphx7drBRS8OX5oG1RoK+lWrcwjEYxleNjbUxC6fs6NOW9xIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRRMK7SK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4cb26623dc1so865196e0c.2;
        Fri, 01 Mar 2024 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321649; x=1709926449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clkowwMKAx4MUU7Jk4DWpFVQeMV0QdJ1TcNJ9LdfGvE=;
        b=VRRMK7SKCHjnGXYpFjadLrdB1xKpUL2SGRBtAo3cll/xo8FmiEeZwl+OiJnPzf2vDj
         DhBGKTy6RM31SZdmlHKmwof5NM1WDtQbWBQnySpPI3ktzIZ37GKbHNjS8hdi0NrZWs+e
         2Yi+FOaJJPaGNYp4YvLhWZRnKNel9XV4Mk5/tKe8w53l10NCF0yeq42j62T/n6fF87hx
         9If8q4uKbo25Uk398Hv/BBYVuGwia/ztEEzOR2ScqALztq38r3tM/r9BFDUFe5b4A0Ka
         2KcCyRZ6mW5cdvD4U+AVAx2vuRi20LJw24RSQwADc1aQVjg8CNcNMUDg9Va6zYPDcL/Y
         3veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321649; x=1709926449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clkowwMKAx4MUU7Jk4DWpFVQeMV0QdJ1TcNJ9LdfGvE=;
        b=lADQ4+QeNstqekbieC4E7KUXsMPRbwVpODareYH6x2+OFza8kRo7FusWUgQyvaoi1Q
         dZU+djCmZ8StzjIPvwNrOkvNV38ND8jDN5IkKUDGh7xkttTgMXCwJLjrDg7fGbbuLd5I
         cSovUhIc8J3PCzuS2jLk4WM8m/6Td6CeGsnktmfVSzgkzznuBTX7qbL2UPgdfRUCZAc+
         e6WdoYuC0rGZumyNew1Sw25qNTxwZt4XV3ZZk1JclLf3Y2Slhp8rJWwbEgie4QIzi9RX
         FlOfahwlJAZmzOAHsUkxf9kzD/GnAZ2RQtr2PeCF3z8aQm0uGy3htAojqExen0WW1431
         RiAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4LXKH+vZUJ9TmdG0pjMioOy1kkqQCUrWqDjMuMp+nSkaYnwziUuf2d8U6Hjv0z13nemvU2qB5y8Db9cwCbYYwTLsxtVAimeMrQgQX
X-Gm-Message-State: AOJu0Yx6B1bOsodpflf22+tdvXxmQN/g3zvY1uyLuRjVPhcWqA2tnCWp
	qJeSM6upZr2wNDZ9s/nywfHGQFu3Yzk3WUuyrBfGs/Uyt7UEs56q9O6crx5CeY+jo5Df/FfH7YW
	VCSNZsmy2HagEQZLx7HkDP0/tjbT4rAW2pz6N9w==
X-Google-Smtp-Source: AGHT+IGRjiCrncRk5FrpKV6Kqnhm4k3Hywivc5sQjNYo4L06VRP8unCCt+u/Sv1u4elxyKYngbcDOHMpvrURdiksrDw=
X-Received: by 2002:a05:6122:2709:b0:4c7:e255:728b with SMTP id
 ej9-20020a056122270900b004c7e255728bmr2668401vkb.12.1709321648840; Fri, 01
 Mar 2024 11:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229101449.227921-1-21cnbao@gmail.com>
In-Reply-To: <20240229101449.227921-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Mar 2024 08:33:56 +1300
Message-ID: <CAGsJ_4w5eYwtc8k=-52JxKAEvTJuahq=kV2a9okbiNPoHAxhkA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [PATCH v2 0/2] crypto: fix missing
 CRYPTO_ALG_ASYNC for async drivers
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:15=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:

Hi Herbert,
Did you miss this one? hopefully, this can land in 6.9 so that
acomp_is_async() can
safely land after it. Otherwise, I might break intel/iaa and hisilicon.

Thanks
Barry

>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Fix missing CRYPTO_ALG_ASYNC cra_flags for hisilicon and intel iaa
> drivers.
>
> -V2:
>  * collect Acked-by of Tom and Yang, thanks for reviewing!
>
> Barry Song (2):
>   crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
>   crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
>
>  drivers/crypto/hisilicon/zip/zip_crypto.c  | 1 +
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 1 +
>  2 files changed, 2 insertions(+)
>
> --
> 2.34.1
>

