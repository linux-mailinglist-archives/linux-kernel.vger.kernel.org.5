Return-Path: <linux-kernel+bounces-108747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1478880F82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D4283B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81A3D3B8;
	Wed, 20 Mar 2024 10:19:14 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493483C47D;
	Wed, 20 Mar 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929953; cv=none; b=BL18FYRkwqMk2ZaH/uQOjm7QZXjSCnOQlb8xOa8aH3IGU8eRmgp5km0KCR0nHuRJrL80KxzoVgP84dN2c6n1CEG6osj/Ynn4nu/Z/5lxOBY6fsJogz2iRZ/QryTRlmP+q5n5/ptvIURZoogAwWHyj+y60673YRk9KCMsWUwIlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929953; c=relaxed/simple;
	bh=XguMGdlSMAGPR3rW813ta3Q8khQXQn25r7ej7jRywJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbd1ZveqaKdUKuNeTXKSYnim9M1g5o9ci0qgxE5YaTWd8Ws0+8KYwimeq/hFGt5wZqB8AEayET9gXZJGooWnhEXkrWZjaWZeQ0BVpkZ3IKAMD2KQ9pnMhvTA2WVRjDGvgowWLcBOcH5yj6ecMacOGtrkK2ReocAmINL05wd2iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60cbcd04de9so62834537b3.2;
        Wed, 20 Mar 2024 03:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929951; x=1711534751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdcM8od0fKihez6wVABy4EIvVWsKf76vtSIaBDoRYRA=;
        b=gfQv3Nu4MQxMKJ9eOLc2NKiz7nGHqRqpfNX7U7TwYjUUGBWBZ6oT3xJUTmH5xpILEr
         WjGBIgf8i45BJSbCrHBQ4L67hrm1cWbIQ1uBfHjDwHdQynEzPM3Bg3/ICwITP+J/gqCQ
         Fvp6/QLm9uRLtPYE5GjtUyR90UHxDizSEZXWu0k42h8JqjFWcfDxaqh/PfFTogLsXwHO
         zT6ZhqV98AyHbz48KwxHDqlGyoDojAJFpDvZHdRb0y/kD9HvqMyCjO8+clG5N0QDlsyL
         Va+3rBt/07qlfxUZxveAn9Vkih/I8fJp/w4yAMexZgv0PAmYvdzHBxO6nSStHa/lICDV
         wtSw==
X-Forwarded-Encrypted: i=1; AJvYcCWhUPKqGb6d1x/Ch/B3R5N667NFgHCt4nZcoWdnDRhOlue3DvGDdb/xaDttTi9yW/vk8sYEAo+1FWXu/KTEuC6URd85VhksAAz3IS3TFH3DzufuXELzMT3eRuSFeJXs4q0BTmU7lscnQvqRySuie4LOWy2To9yRNfhaDGTgbBXg37JQIl5zStY/f2wH
X-Gm-Message-State: AOJu0Yw4tq24waUqNgEQdqzTTYgFzZqEgH+BjC3V8yBJuZw4B8YDIdzl
	vlq1R8H415uSuLvCfqo3BH2JBagvjpanODugSkcfLjvpNHxn3QgOZQKDYHCKBOg=
X-Google-Smtp-Source: AGHT+IHFPD+Ci4c51tH1k/AyxFdBExyx48cBkHtfTpyCz+MZTIuTcGARHRBU4zN1uMRrV+vWhUaV1w==
X-Received: by 2002:a81:ab53:0:b0:609:a55b:805c with SMTP id d19-20020a81ab53000000b00609a55b805cmr16277422ywk.46.1710929950901;
        Wed, 20 Mar 2024 03:19:10 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id o1-20020a81ef01000000b0060a304ca3f4sm2687970ywm.19.2024.03.20.03.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:19:10 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60fff981e2aso44194097b3.3;
        Wed, 20 Mar 2024 03:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoXMLJEntCPi9/HQGech03MqR7ipeVxVCB1bJ9g2Xrzfo+GRmLbBNsO0L+j5xtq+wkwo3+1nGCESYXd5qI9ItlrQEgQ1Bdl+54fHHF7VsgYuF8v8AY55XyU/YDiCXIuJKSirmwDTCcqdlarhnthur73XabB35Yv/+kqBeZSVAQhgZ1s7MuBEO6LlAB
X-Received: by 2002:a81:9403:0:b0:60a:422e:c4 with SMTP id l3-20020a819403000000b0060a422e00c4mr18353503ywg.25.1710929950493;
 Wed, 20 Mar 2024 03:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240318174345.46824-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 11:18:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVVhYs3iQfLMwwBx6vYF3m9_C8n9gHkFPioBjFgqJPUA@mail.gmail.com>
Message-ID: <CAMuHMdVVVhYs3iQfLMwwBx6vYF3m9_C8n9gHkFPioBjFgqJPUA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: r7s72100: Add 'interrupt-names'
 property in SCIF nodes
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 6:44=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add 'interrupt-names' property into SCIF nodes for clarity.
>
> This allows us to update the DT binding to mark 'interrupt-names' propert=
y
> as required for all the SoCs which have multiple interrupts and also allo=
w
> us to validate the DT binding doc using dtbs_check.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.10.

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

