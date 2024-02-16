Return-Path: <linux-kernel+bounces-68692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AAD857E81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA71C254E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33A12C558;
	Fri, 16 Feb 2024 14:03:23 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF412BF1D;
	Fri, 16 Feb 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092203; cv=none; b=p9uGWPYZkqPgybYqyjVpaIXVsFgiaMlC9q5cKSxP1L802kz/eLrT8EH2kG/l4qHqohMWZE1A9er6us2pdDucHdcB/Fc8P8uPodvX39B6DmYCz0VY5arokD9rAkJfiAQiYAmLphnMKpBpDVO8FQTRKWv7sFyHP39TYCOd+9+MzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092203; c=relaxed/simple;
	bh=IqA6iPbr52ohftJ17rNQKE9MNX5GqPH2BBxH7B+a9fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwAzEkWCLSTc8IopnnAUOblaoztgUDbqWfFClN8XU2POIqsp3Ji0iQpEvwGzHmgDiuNgffiyM7WAcnB75oq1E/s92K6Iu237eZVDe3rtlniZ9dDE8/2ZguBtF0EIWjCoHwtL6brW+TnTB0uygEbqguhOYxCCUarfk8vOoADi6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607cb7c44a7so19370257b3.3;
        Fri, 16 Feb 2024 06:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092199; x=1708696999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNBzyjwubkX8/ViTlFw9AawEcEHUoewYtlJeFol6/+E=;
        b=CIh6qS2AZM1z2iJUsSqNtVQXMI6RLusNvTJdrHL5c3l1QSJAk7hXT5CNtNx3G8TOCt
         1ZsZERu/Rheemq2GGubJqazmOepdllLop5GYw4ZuPmcIBPjoWLDdakqto6dFb4lO2XoG
         8wbILPPYIZjp4HCrpJG2COAv9xxo/QG+Wl3T+SViu9dsRJaUeBGsPwEflCTH+OSZMcLj
         7NuJWAAYeXO7n2LO8vMNpKhpOISkYNILp/dWYlkUPedyXiiZ43bUXm95etl9IHKd2134
         o1Ff3l1VyHlWmp/Gj8/FOOkv+RI1NUQR9F+l0cyHkjzQ3JLItPPxUJcvsplc5pJ5Lbwt
         XbJA==
X-Forwarded-Encrypted: i=1; AJvYcCUOWXdbJKlO7512Xf+c9l7dmllqQzJrtq+Vt8+3hkpOP7j0J/LZo5Iorh+eQXKm59DqcpIapKs83U5IGd449cv9ZSnMVvoGIwbUg/o7WPD2u2f6M6LxmT0KvWAA26TJWK5rN61VdRQfEzUcg2UapUs2JWOvQFBuZlSil5Tz/l9x5SLAUs09KTmx+gVxgR/VUik5sfvm4JHLE1j44ga6xtRbzjlLKO9z
X-Gm-Message-State: AOJu0YzH9swDDkh2+j/OL56sZ9MJTpxtB8PjXwi1GvKy7S5BOCj04IjJ
	zwfeueam2Y03gjS0NchOEov+9H4Uue0dUiu6HYJDU3/Dp5wNfzGU4pXbeiwxk1Q=
X-Google-Smtp-Source: AGHT+IGsj9RGWd1a1oOypf0VyxwGu46OEgE4I80yeEIrKon28Ukn+spJ86QFkXtQgeQRKa08WWIJhg==
X-Received: by 2002:a0d:d810:0:b0:607:7caa:1b14 with SMTP id a16-20020a0dd810000000b006077caa1b14mr5116580ywe.39.1708092199526;
        Fri, 16 Feb 2024 06:03:19 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id o184-20020a8173c1000000b0060410ee94a7sm340349ywc.143.2024.02.16.06.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:03:19 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so1737421276.0;
        Fri, 16 Feb 2024 06:03:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyxpGd71KDPY2hYid2k6j25g5Wp4dRpFol7VDA17y2bOiXZKv0nfOONyNIjUnXMA7Cn7aNmZ2BPb0vtKK+Hv2O1X6n+AH+Z7BT3dkWWkbyciI50f3RSets9sOt8DVyqcRB89IbAptKEOz9OY8oVToRRxmbVLyoLgcNBB1te+E+C2hLXW3IUdS9AeLM2rUAJNjnymoV3yl1ZiYr/Ls1dgYB2qIBVX9s
X-Received: by 2002:a25:f903:0:b0:dc6:c617:7ca with SMTP id
 q3-20020a25f903000000b00dc6c61707camr4799409ybe.29.1708092199031; Fri, 16 Feb
 2024 06:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:03:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnOaPwyBQMxdmTEczSRHKctkaTMzs7KpnfCRoM=0GqfA@mail.gmail.com>
Message-ID: <CAMuHMdVnOaPwyBQMxdmTEczSRHKctkaTMzs7KpnfCRoM=0GqfA@mail.gmail.com>
Subject: Re: [PATCH 04/17] dt-bindings: clock: r9a08g045-cpg: Add power domain IDs
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:43=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add power domain IDs for RZ/G3S (R9A08G045) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

