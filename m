Return-Path: <linux-kernel+bounces-123102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5189022F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA761C2D04D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4438172F;
	Thu, 28 Mar 2024 14:45:41 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6894E1C9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637140; cv=none; b=pVXN4Yx5Bf3rUcplyuYOSuYtYCeW+hsty6KYTRYs5xzLOacxAoL9kne1iB9HaKNgCkhLLQoQyg4kMyzlPcup2FX+rjPCxWix3YXRQgSsbQ/Ft1YlyoCAtZVkcAtBesfJ5V2IOpNdDTJ1v6Qm5haMmOEt8FARI26M3t8QnCAl+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637140; c=relaxed/simple;
	bh=oT2G2hzKBk5ZN70wX2Z/woZGyJvOk1Ns97niHF7wanE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC6F2qrh70kSRARjSxAO0A+bjb3lDPtELSH3anOuaMr++E6xa79iuvqSHVX0UDwAoOiX0KX03J3ue/cc19AQGvJ3svY4Fk0Ea353OEaW462Dj44ke99V9z0Ze+mUESCA366OoaGlESFiNbOlP2qlNa8bY1gP7BNVwCNFKLYYiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0599f631so9494607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637136; x=1712241936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fjaRGcSgf8xsTZBcLTiZ5jbt+B1Ifd5p00AndFjlLw=;
        b=jfqfxRWps1tzZF6vpqTiFungodkZDd0hzXQk/akC4WVyMH3Lv2D46wwbdhNtyVydJx
         yGY5KYh95MWbfijS+ilqzghDWLP5KN9zsaPCmI0OHxUVFdVvbRnIGG7KzQPNiZIys5Wa
         C/cMQx7XwpkeTdBjCm2nk2nebg7Qt3416u2qhwQ597f5AndyqSymHVg9LtBwtVXcwLv4
         5BJsTCTwptiGSVrcwzXUuG/z1cl10n7fGqBdVjVjB+44IDKj1yobh0vn+NWSdQIFmr2M
         QTu3MvmNRhd6WhCVl0NNzTD3I+FjQipJbggImy7d8QW4PD9vPhfaEGONu8Ypx3pLFsiW
         jlQg==
X-Forwarded-Encrypted: i=1; AJvYcCV81HGSrtiqzBD26lRoxHdubPSiUy58T64K7lHSWoLD/9HHF3wFnu70FeqlwxDBROYX3SP9yUWqVKMP6XmeEKXKpmL7+7gmWM3tGsaD
X-Gm-Message-State: AOJu0YyVPMahpCM39LsK/0YSg47jrvW2RCAnmu5awiiJ/PUiYppoDdvw
	axqc2IgjbG3Le36T3utfk7+8xnCp33JrF4Ls5LeMi9X44l/Y/yZvMMeSZVIXhMI=
X-Google-Smtp-Source: AGHT+IG2iIc6VoFUZ5ivLymGIQcfAS3Z80xV3+lwx3YzsM7nUMsQSm2oLveRRUzkvIVhzgfHwNkhzg==
X-Received: by 2002:a81:8416:0:b0:611:200c:9229 with SMTP id u22-20020a818416000000b00611200c9229mr3287517ywf.8.1711637136614;
        Thu, 28 Mar 2024 07:45:36 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id n14-20020a81eb0e000000b00610e2f00407sm324132ywm.114.2024.03.28.07.45.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:45:36 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd045349d42so988781276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:45:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkZTrZI5Y8Ft9Lmf5G5idWQhRB7JNT+LbBW1y+saQuoK7diqotJ5NyX+mXy1epSkxL/4x6pqaZr5AuF6e1s2Tmo5VZJv/8VdRLgUGM
X-Received: by 2002:a25:ff19:0:b0:dc7:32ea:c89f with SMTP id
 c25-20020a25ff19000000b00dc732eac89fmr2988417ybe.15.1711637135802; Thu, 28
 Mar 2024 07:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327054537.424980-1-samuel.holland@sifive.com>
In-Reply-To: <20240327054537.424980-1-samuel.holland@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Mar 2024 15:45:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7HoJc+67VkqZk+KH8LzauQoTofP2ZrALvbpAtnbNRtw@mail.gmail.com>
Message-ID: <CAMuHMdX7HoJc+67VkqZk+KH8LzauQoTofP2ZrALvbpAtnbNRtw@mail.gmail.com>
Subject: Re: [PATCH] cache: sifive_ccache: Partially convert to a platform driver
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 27, 2024 at 6:45=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
> Commit 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a
> platform driver") broke ccache initialization because the PLIC IRQ
> domain is no longer available during an arch_initcall:
>
>   [    0.087229] irq: no irq domain found for interrupt-controller@c00000=
0 !
>   [    0.087255] CCACHE: Could not request IRQ 0
>
> Fix this by moving the IRQ handling code to a platform driver.
>
> Fixes: 8ec99b033147 ("irqchip/sifive-plic: Convert PLIC driver into a pla=
tform driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Thanks, this fixes the Starlight boot failure I didn't get to bisect yet.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

