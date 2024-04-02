Return-Path: <linux-kernel+bounces-127492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08112894C77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B735028296D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5D39FFD;
	Tue,  2 Apr 2024 07:14:49 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305F383BD;
	Tue,  2 Apr 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042089; cv=none; b=mtPPx3SaVt4Y6X7q3qrwMBKTTQRbVwKu0xpQ+gHJ96U9Hbqo1FqDTgZp4YGhfhvV4W/BxGP/MfvLB6DtTVTza97NBQB12oM1tCBQfO0zUqFUUYyAfC5tPJ3cdNW88gIel5RFzg+/rrSkRnwDoApGY6iW/a/pZT5ZMP+fOV7XIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042089; c=relaxed/simple;
	bh=cm2IXDO6qSfwbvRvc9+A/B6vpxXLEBNyOHOQBqCAyio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVAQW+hg8IvroTAJiPy8yq2TQHWMIo+zdN3I8gD/obe/PW+6abuwo30zI4sCV3kpvZhLqc2gyH4yjVRSn3bAKZ9vzVf32pkbvodTZm5o8PR/Ec3VBzUqVa4Ql7D+mVJBTW1Z5Yvw8EGII8uJL1MlPGUxZolS/YJCRyiDCBoNRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61500da846fso9894297b3.1;
        Tue, 02 Apr 2024 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712042085; x=1712646885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G19hJVrvL8VDG3HrXUGOF5A8X8SNUBri2kW6IcrjmTI=;
        b=KrSIe4Ijy79/lhAb6TmlQ3r/U/oOOUxXspIkRhpZ6h3e0hWbUl1uIkpHfINoenwZDa
         Ygk1vlQaxjrBkV3dveBPqlxYgpISEBhXxRN0jAlyiHz37NxspEcPMM+KAhqvQsR2RqQH
         Xd2FXp4hgACa1mPxK83E0NmCDwB5t9cpAeZ7w1Bq4X4iIpYK/Z5KmWfEMYxn1k9foTwt
         TQoTtPRonVJl+YcruXYLci7Io8JN2bw0wrRQOup/Y3pTqZFreK4ZA2ZyAQWCh8tGzc4W
         18nOCgucQxm3mAKnjmtQjc7lpi5p5QNqSmKHLRhNXJi2c2ryFVQCh2zXH1xAu6Yjq0zQ
         +Xyw==
X-Forwarded-Encrypted: i=1; AJvYcCVsX6FGiwqeh/MptSY7aGpN92GTP94cTxV9NTuhcvrK0yJyo6Eu1a5Qp1l2Ba8FnZc0Qwn74Gk5MUho27dp/m3omj+7kiHSE7QN5P7PyZZ0w+BGL8ZchhtDyXhyTsVPP52h8thODxcV+vuyIfMBM+KNxxn6L4hUGzGiiDKtr/bHc58TJMLajYYq6w5c
X-Gm-Message-State: AOJu0Yx4Q6UUYPyb+sGG9KW2zaj8N8+KIp24gYzS/R5D9Wl3yjSAAhII
	gXVhN5v8zq5ld3iVROev4HYtKvx0btAQ+HEmJBXYjcHkCBRGubzvMKGmZeOjGjw=
X-Google-Smtp-Source: AGHT+IFgjSSJFvmi7IwRSfACPTt7iexRTlplZ00MKEceQJOldGaulskeNF5h2SkwE4QLyMaA5xsTmg==
X-Received: by 2002:a81:dc09:0:b0:614:42b1:edd8 with SMTP id h9-20020a81dc09000000b0061442b1edd8mr10209366ywj.2.1712042085361;
        Tue, 02 Apr 2024 00:14:45 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id s24-20020a814518000000b006150e117af2sm447968ywa.110.2024.04.02.00.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 00:14:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4185621276.1;
        Tue, 02 Apr 2024 00:14:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBuHqyMqZFw5GqwrdTVNeCCWe0zKJI+eYkdHtEL9weajQ9z5B79B4X7ue3Kq6NE7YbmaPCmNw7QQZZc3cGNxO4Wj8Nj7VRD5bCONFws9EEDMikIDmkgT/8hqiE1GHACczEZinEIj4s+KqSgUOtLPGXAH8E9tQUZIl2I2chyUnzjFU02Qiaip/tPRyf
X-Received: by 2002:a25:9a05:0:b0:dcc:9e88:b15 with SMTP id
 x5-20020a259a05000000b00dcc9e880b15mr9851953ybn.41.1712042084265; Tue, 02 Apr
 2024 00:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <137c184267faacdc3024f0b88e53889571165a84.1711715780.git.geert+renesas@glider.be>
 <4ef1eb4e-b1f8-4b5c-9280-5834f946fcde@linaro.org>
In-Reply-To: <4ef1eb4e-b1f8-4b5c-9280-5834f946fcde@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Apr 2024 09:14:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7HNsHqoE5eNyXcc6JJ6MxcpRFXQ6z4ECd-ANEY8xrgQ@mail.gmail.com>
Message-ID: <CAMuHMdW7HNsHqoE5eNyXcc6JJ6MxcpRFXQ6z4ECd-ANEY8xrgQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Make interrupt-names required
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Fri, Mar 29, 2024 at 6:42=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/03/2024 13:37, Geert Uytterhoeven wrote:
> > Now all in-tree users have been updated with interrupt-names properties
> > according to commit 0076a37a426b6c85 ("dt-bindings: timer: renesas,tmu:
> > Document input capture interrupt"), make interrupt-names required.
>
> Would be nice to see here *why* they should be required, e.g. "Linux
> driver needs them since commit foobar").

The driver doesn't use the names, nor the optional input capture
interrupt yet.

This is just part of the continuous improvement of Very Old and Immature
DT Bindings, dating back to the days when most animals could still talk,
and before DT became self-aware.

I could add that (or something simpler ;-) for v2, but as the reason
is basically the "for clarity" in the linked commit....

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
> Anyway:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!

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

