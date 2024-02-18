Return-Path: <linux-kernel+bounces-70619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02384859A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DD628147C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53271B27;
	Sun, 18 Feb 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aRYyalIz"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D31DFC5
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708298348; cv=none; b=lU9lpPbc1ebpwZ9bm5FgaXcIYiAZy8hi77ocoBE3zUl/+I5x5q+a1A6SGNc1WW3krA6fxGFgAS6TL1A7uGrlffwmEBdHZqi1CiekuEStjYTfwUZXoJ472EwomGHhpwpqb0gULgvFz+VHX53lZCn6K8Osarfv7NfcMA5RFpq88/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708298348; c=relaxed/simple;
	bh=EwQRCgra3Pr+8vBzgcMDasWTZwEwdIK/Bjbwxfb/fYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRkG/jgs4WZBiuLnLnax3eSx8hzxHqhdKxPCkCW4fbq42b+pV1QOYezW44blh4xov18WksW0LnUOggZq9b54V1yU/2ySmb8o4GSqBOkiu6kqYc/4pYDktC5rrfqK6MqbewIfJzwqnqcMytFmHGVd8Z71RkXsWMaHDR3GUAYEPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aRYyalIz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299566373d4so600022a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708298346; x=1708903146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khrQCQyYrMhwWZqymcpDctJEiCRTGl4cp9AfajJt7bg=;
        b=aRYyalIz40uLgJChTZJ+8rH4+rytr9EOUsoFG6ibeLC1/OpS3WDWI7AzxtjYfytQWD
         uQLWmdRayJiRoEF6YExOgk+QVSPdzqzrLF3hxfnkQWU+ffK+gJSwHyaRcDkYsi0RSeZF
         sdOYdxUzYXp9KkkkZYhAgzqDOrJkg49Clqf0QKpLFt1+u2FGVWcQYQkw6OOD75zYCS3c
         rHoKy+ggGllDzoYJ/ahkU5MRC/fWR4xdsatU4jJKT2c9lXi6D7Gu4vEfT20uYopLZbz3
         iYRjroPidG2Sze+bTY4+bw59e9LI2ULQCcUqaC0Wz9jhsuqyrS+4OOfuiVkKP7wYZi4s
         fO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708298346; x=1708903146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khrQCQyYrMhwWZqymcpDctJEiCRTGl4cp9AfajJt7bg=;
        b=h6Gv3QSGFcgFhLSvJZL56cfmw+GrHBhlaZdRgDvwBLRlt5HmZC49DZx19YLu85cmjx
         scRF3qz4USHZ/BM0kX2cQ5AUK3FvSUQoB7IqvzJYNaAujk28Nku9AzrwCaVzUSpm7wsx
         QVIKJsHXmg5yv8HfHJldndWSPqpctTKeLdV1fukhARLiJqDaYNHeBNJLwkPw6KbnwxEL
         U7d45IbnEkYR1pFFJXj3YUn+SNhSeXI20IG9XtAZtNhptym+FNpMgnK0G66lnRNVd9N1
         71uKnF1c5625kfkIpjITNFzse5/ZNO7qou7QX7kFtKcaiQT94eZm4+pxn9hAty5l8qs1
         Y5kg==
X-Forwarded-Encrypted: i=1; AJvYcCXlf8ok2ZUOaKH0FlCEPrY6e1KVjglqxo5lYXH6Ee7GootOV4XH3CVAWNZdCTLcqNVRW74MbMCFJ/eRKjehdzWbc1vN2AVsA33+UQ7y
X-Gm-Message-State: AOJu0YybMtlNiwc/UukAqMwIJTotiAmgOGiKaRnCQwFIIg854zQNHgMP
	MMX6wITn7GEb7m8M/Qt7IB2WJIguLicR+hBWM8Mtm2e2FjA4cXRX1OOEKtSUzULYvnXmOarXEGw
	1f90VwaICbrULxg+k6NvJYdbfzcQ=
X-Google-Smtp-Source: AGHT+IG9hxyO5Po/xMncBWm3PvD2MYQZinYkMZ9g9ZM46oBcM/mfmqUXTjmVwwIUaT1GGENi8eKzZPOEFfUrnds8VEs=
X-Received: by 2002:a17:903:110d:b0:1d8:b51c:6b79 with SMTP id
 n13-20020a170903110d00b001d8b51c6b79mr12411783plh.7.1708298345011; Sun, 18
 Feb 2024 15:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
 <20240218174138.1942418-2-martin.blumenstingl@googlemail.com> <ec0b3dfb-3ce2-43f2-9cd4-042c3aca4cf7@linaro.org>
In-Reply-To: <ec0b3dfb-3ce2-43f2-9cd4-042c3aca4cf7@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 19 Feb 2024 00:18:53 +0100
Message-ID: <CAFBinCC0BbahEMeW9CYC+hKk0CBQ9a+CqNrOv3c92D8hDtQHdQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] clocksource/drivers/arm_global_timer: Fix maximum
 prescaler value
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrea.merello@gmail.com, 
	patrice.chotard@foss.st.com, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Sun, Feb 18, 2024 at 11:59=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
[...]
> >   #define GT_CONTROL_PRESCALER_SHIFT      8
> > -#define GT_CONTROL_PRESCALER_MAX        0xF
> > +#define GT_CONTROL_PRESCALER_MAX        0xFF
> >   #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << =
\
> >                                        GT_CONTROL_PRESCALER_SHIFT
>
> Good catch!
>
> IMO the initial confusion is coming from the shift and the mask size.
>
> But should GT_CONTROL_PRESCALER_MAX be 256 ? so (0xFF + 1)
It depends on what we consider "max" to be:
- the register value
- the actual number that's used in the calculation formula

If we ignore the usage of GT_CONTROL_PRESCALER_MAX within
GT_CONTROL_PRESCALER_MASK then there's only one occurrence left, which
decrements the calculated value right before comparing it against
GT_CONTROL_PRESCALER_MAX.
This means: the remaining driver currently considers
GT_CONTROL_PRESCALER_MAX to be the maximum value that can be written
to the register, having converted the value from the calculation
formula to register value beforehand.

> The following may be less confusing:
>
> #define GT_CONTROL_PRESCALER_SHIFT      8
> #define GT_CONTROL_PRESCALER_MASK       GENMASK(15,8)
> #define GT_CONTROL_PRESCALER_MAX        (GT_CONTROL_PRESCALER_MASK >> \
>                                          GT_CONTROL_PRESCALER_SHIFT) + 1
If you're interested then I'll work on a follow-up patch to clean up
the prescaler macros (using FIELD_PREP, FIELD_GET and GENMASK would
simplify things IMO).
I think that this patch is still good as-is since it's small and can
be backported easily (if someone wants to do that).


Best regards,
Martin

