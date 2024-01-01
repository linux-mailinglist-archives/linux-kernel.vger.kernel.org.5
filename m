Return-Path: <linux-kernel+bounces-13836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E551282133D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9477A2828FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85716BE53;
	Mon,  1 Jan 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcH+aD+x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641FBA32;
	Mon,  1 Jan 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7815aad83acso309184785a.0;
        Mon, 01 Jan 2024 00:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704096314; x=1704701114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5hobNbHiJGBduFIxqp6Aaia9KdLQwaNihAo6Bc8CKI=;
        b=FcH+aD+xvY7VyPOVIEDDfS3Ik6BbQn9E3A1em6rlv/W5KIQvzn+mtZvwcfr0nyg6ew
         FZ+8FF9hkoMAWggr8FT5dPcaRlUMXNRHWSvh2nXGB6DjqraxlMez37Nn2RpKin4Z3S27
         QPzp7Lq+drcjHgD75jHAiS/yZqiAQX6n49FfB/K9hZkLxeONjqqKsjpAAMIxOGPSfCTy
         xqRihatRFcvO/vyczKfSG1sF0/kEE0WTirKwuEzu2Rrq1XLl4Sylnr8JZEunl9QxWAq5
         28Zr4bAoMP91Jcqpvvjv9ku1RF4tJs9oXe5LFUiX2lVKpGffdWF017L/Rw/prh0x33+v
         VqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704096314; x=1704701114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5hobNbHiJGBduFIxqp6Aaia9KdLQwaNihAo6Bc8CKI=;
        b=ovFCm+K73NOEaEtPNUjvFSuMvpRRPBR21feJeEsROIWHJ0AmUxMO+WmKEzidnqCLay
         /nteR9wX5xQm79aK3nK1ijKgzEethU8ok4F+m8miH7tzVg7v1A/WFPWLbi6liSWc58LE
         CjxgNw40kz+oaGDbi/eUJrnV+roQPvUN6dgo+/GeLOVOwSMJeSf4Qkw3vOeIYnE+Uo6l
         e3HXDtggMhLaElE7B7tD3A3zX/Q48dNAnzdT6FwS2pVuUhHLJOoUAnzYzZWRfFx+BbNR
         lT9AYLsQhjPfTNoBejsNhUlaqDqe388kpOsI4M8IB3q1CAnI3TQxrv1+6yfYTHyyq+l7
         8QDQ==
X-Gm-Message-State: AOJu0YyO9jF918wF4HgagvqwI1i+xMM/JtAmc8CN6yuv6Nk0hKTgLnJc
	bnqpAjif9z3zMsfIPwh2ls/WpyPv0gTZzEnoDvE=
X-Google-Smtp-Source: AGHT+IF87YQ8lX/4yEbqEn9hjXnik/MaG8Ocl2RegtDACnc0ZIFiCajJyB3kXj3YzyJVu4SbENV8o1MNLuVoamKqvkU=
X-Received: by 2002:a05:6214:caf:b0:67f:40eb:bfa7 with SMTP id
 s15-20020a0562140caf00b0067f40ebbfa7mr24232666qvs.48.1704096314485; Mon, 01
 Jan 2024 00:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231050300.122806-1-sergeantsagara@protonmail.com> <20231231050300.122806-5-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-5-sergeantsagara@protonmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 1 Jan 2024 19:05:01 +1100
Message-ID: <CAGRGNgXYBM16UNcHmOVMJKa+C5R9-Hy7vamEBpp=cF_heQVX6Q@mail.gmail.com>
Subject: Re: [PATCH wireless v2 4/4] wifi: b43: Disable QoS for bcm4331
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, 
	=?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Sun, Dec 31, 2023 at 4:04=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> bcm4331 seems to not function correctly with QoS support. This may be due
> to issues with currently available firmware or potentially a device
> specific issue.
>
> When queues that are not of the default "best effort" priority are
> selected, traffic appears to not transmit out of the hardware while no
> errors are returned. This behavior is present among all the other priorit=
y
> queues: video, voice, and background. While this can be worked around by
> setting a kernel parameter, the default behavior is problematic for most
> users and may be difficult to debug. This patch offers a working out-of-b=
ox
> experience for bcm4331 users.
>
> [snip]
>
> Fixes: e6f5b934fba8 ("b43: Add QOS support")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

LGTM

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

