Return-Path: <linux-kernel+bounces-103538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C887C0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA91F2266B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9A7319F;
	Thu, 14 Mar 2024 16:00:04 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAE73175;
	Thu, 14 Mar 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432003; cv=none; b=HRVUvmjijEQV0gA/jliU40bmeihzbVLAVZ/Y3nkmJg7IGHUPWkebYmeIN+5tuQ8K6DQOeF2odZjTusN1/nFTIuzmOcsmODEuruMbzQM6AOtYNXgZ3FFeNAUumP33i++Xsk0/vs7S9EXUPYzVdDI/7Zat7s6WVndHZjBlQ8sllDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432003; c=relaxed/simple;
	bh=1vI2Q4KAWhANIk1ytm6VuIZQ3Iwhh8U/8lyXhKRLs1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJi7j8sjre6wXLiK/eD6oDzcWMNQUve7pAGQ2Eg9vlox+UjaFXkYop9vBI/d7zanHycqJYDUb3d8wdgx7SOD6qTKuuwqxmrgifVKrw6P3iFqIUbDQ6rWG9r7ER5jMSYq+xTIa1SXIgF25nrdsyIgzI8TQqhn4QiCUpns8HSt0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60cd800f396so430317b3.3;
        Thu, 14 Mar 2024 09:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431999; x=1711036799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaY2hT5rudAoaASQuIj5MP8mmMHrFfWhFtQCkYxvJN4=;
        b=dz9S36J8tZ+KNEzEOB/ILmkn6B7GPKp5VvBphUJBtACMkSmCiE7ZEALvF0tBKP7W1g
         LEkDPz/22HN5LjQ7pXWFIuSGqGlECuayYEUrXy1TQnDsCLIA0MBJTbCKUDKKyo6aRiqR
         JLK4gLiaQvmOUFTWf7gKnCgahQpNlz5K4+pTpkkmLmEGVSJm/K5vU+36qAhOEMmRHO7L
         eEg6e60tyH6xLN9gnOG8m6rDfMxB3rMVAUqSCAYhydPeFQ/i42KrCwsHGL18stuMltab
         JK/bV9tXsXzaGML86kZekN9bfKSUfh+kTPG+Ypq4FJg1OPiJ2db+i4YVuBHpakfY4g+j
         tC6w==
X-Forwarded-Encrypted: i=1; AJvYcCXw9AaDrQYlCZBdKkgbIDeifCWNwnKujeHcPDPwIOf1nMk0yirwD7rg7STZoxQJ3AmLEiePw/LY8dIpV0Rgjztw4vDC45fqChXfNalMLWWqzSYNP456YzHLBggWehlEe1ZyOH8JNR1nioJ6zmu+uk8vyBVyBvOrKW99pFFMVG7vkBF7CEo5Hk9Qzz6Y1+vjjS08adVpH1MW2oAXyx0XWz68RgynJfdp
X-Gm-Message-State: AOJu0Yzstwba34j6qzf2Lf7ldiphdgWDTVTEifWzatqolUaEneJjwmuu
	7XgHP31RSts2Y6YOZFOwz3RWhuKjeZYnPnxrISbRpzuAh9ywmfdHhOp/w6tAYLY=
X-Google-Smtp-Source: AGHT+IGtmuVvTdplXC3pvejSAGw+8EfhubAyFel7D5+UzZqeL8gJciwZQ+MK6nqYIS1R9+wEpPJ1Tw==
X-Received: by 2002:a81:6dc2:0:b0:609:8717:4361 with SMTP id i185-20020a816dc2000000b0060987174361mr2098733ywc.4.1710431999143;
        Thu, 14 Mar 2024 08:59:59 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id j67-20020a819246000000b0060a588c41a3sm324357ywg.76.2024.03.14.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:59:58 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60cbcd04de9so12467337b3.2;
        Thu, 14 Mar 2024 08:59:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnlkm4XdlilXZxjSXARM3ofp5jQnCie+0lK5i8/Pplg0JT4SODl6KTMA4jjRv4MPNCnvDo0EkQRksPl/I2eZv4UEeTTI7JmzfT0XQ6uBnGUzwQ5fC0dAHxGHvU3yzeAbo/4gBWmpMwYRUEj1F56xBZbabPkh8TTOXukIP35vR0pJ3b7MfQ4ytvZRrvR7iSAGeXVFbxpJsZAJRIee/W/MYOqhs6m71J
X-Received: by 2002:a25:9801:0:b0:dc7:4ba0:9d24 with SMTP id
 a1-20020a259801000000b00dc74ba09d24mr1740244ybo.59.1710431997732; Thu, 14 Mar
 2024 08:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 16:59:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhcSr882_jADG=F5LbByEbnS1z00XKOQ4MXVeN7_WyOw@mail.gmail.com>
Message-ID: <CAMuHMdVhcSr882_jADG=F5LbByEbnS1z00XKOQ4MXVeN7_WyOw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,rzg2l-cpg: Update
 #power-domain-cells = <1> for RZ/G3S
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The driver will be modified (in the next commits) to be able to specify
> individual power domain ID for each IP. The driver will still
> support #power-domain-cells =3D <0>, thus, previous users are not
> affected.
>
> The #power-domain-cells =3D <1> has been instantiated only for RZ/G3S at
> the moment as individual platform clock drivers need to be adapted for
> this to be supported on the rest of the SoCs.
>
> Also, the description for #power-domain-cells was updated with the links
> to per-SoC power domain IDs.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - updated patch title and description
> - kept both 0 and 1 for #power-domain-cells as not all the drivers,
>   device trees are adpated with this series
> - added a reference to dt-bindings/clock/r9a0*-cpg.h for power domain
>   specifiers
> - dropped the changes from examples section

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

