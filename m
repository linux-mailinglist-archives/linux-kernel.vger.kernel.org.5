Return-Path: <linux-kernel+bounces-20625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31492828292
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA676B2210D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC829433;
	Tue,  9 Jan 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqy49XeX"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF8250F5;
	Tue,  9 Jan 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36082f3cb05so10168865ab.0;
        Tue, 09 Jan 2024 01:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704790828; x=1705395628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgMEw0q4WwV2JumGUYsCtc6USbd39YZOyTk5WPojixQ=;
        b=Pqy49XeXom17JEkH7V1h7k3tO5sj9DSZD07mLb31iU5byzR/XIyekctk45nXRnKFBZ
         7G5yKlBfpapQg8YgmSbHl+finkBNFA5qSuchDafxTkDrBZCsK6SIYBkQdZbqC/w4s6hd
         IlkUhGKWnx30edqIe+GoQGp2+vYQvrbhAvDdPCX7PJEWKiFIS+i0n2Q4aDxYZSow2wrK
         VgCOtfTtlrhOY9vN/esDE+SElovUEwlb7mUlBBKxOT/eVhuyFCiXmcwN2OsTfMFjprwa
         jGiHxwFIIZy6L2X1ByV2HfbdSa3gnEeIlze1qVv1EPQ5EkBXZ3KWZpobKq+Uv8rNp8PK
         RxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704790828; x=1705395628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgMEw0q4WwV2JumGUYsCtc6USbd39YZOyTk5WPojixQ=;
        b=ioaWL3CwbydN3dnJEVV/DQAe4aq19dl8SLTZwvmOXtkoSqOj4bSIQmDxtFpucBccI5
         L1lyh2/Bqu3hzg6RHvm4DMYmd1PrLeSJUnUsIlDJJMpMyrShHedhPDOwc6/YaivCvA6l
         tazmmbxk48lLadpK35/ui4LtLTxvlwvZ4QmABhd4A7cEfGAEPQMehIokiaRgJIdpE7mW
         heYok9aZ++Kyo7nz+v1AMvOrWyXr5Aee9D3WVcIfveipcoCBn5/wMpzfFdN+rHIZDvli
         Kdbtj6FoR3VGzIGAbZGxd0zYBkzdsE9hfN1VqYZ6ZkAxE2+LvaRfhHQ67Kz6jioQzqy/
         ZrfA==
X-Gm-Message-State: AOJu0YxEnm1S4/IfHDU9v08Kg7Gpx2iT2bHWN/b6o1xCRUkbnsTsGMZt
	JJI/3bqXFHnG/yFW3uXiQStePWSOaJBZjsUtGqk=
X-Google-Smtp-Source: AGHT+IG9rmegvlzOUYbFciwQULzLSP/qGqK+RLbjVXhQgCS8VFINLPoQ1fOr7bSQCaGxxHgwQbLcmpm6+YCoDXmC/5w=
X-Received: by 2002:a05:6e02:2387:b0:360:7403:3cca with SMTP id
 bq7-20020a056e02238700b0036074033ccamr6766345ilb.51.1704790827874; Tue, 09
 Jan 2024 01:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com> <20231222013352.3873689-2-kcfeng0@nuvoton.com>
 <20240104001552.GA2096243-robh@kernel.org>
In-Reply-To: <20240104001552.GA2096243-robh@kernel.org>
From: Ban Feng <baneric926@gmail.com>
Date: Tue, 9 Jan 2024 17:00:17 +0800
Message-ID: <CALz278bzoQEUS+NMP=Xt9+4n4NovBR6bCucbvQp_FhHuMP0bnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To: Rob Herring <robh@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, 
	kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 22, 2023 at 09:33:50AM +0800, baneric926@gmail.com wrote:
> > From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Add common fan properties bindings to a schema.
> >
> > Bindings for fan controllers can reference the common schema for the
> > fan
> >
> > child nodes:
> >
> >   patternProperties:
> >     "^fan@[0-2]":
> >       type: object
> >       $ref: fan-common.yaml#
> >       unevaluatedProperties: false
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
> >  .../devicetree/bindings/hwmon/fan-common.yaml | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.=
yaml
>
> Please implement my comments on v10.
>

Hi Rob,

I saw Aspeed Billy has already added enum to below patch:
https://patchwork.kernel.org/project/linux-hwmon/patch/20240108074348.73501=
4-2-billy_tsai@aspeedtech.com/

Thanks,
Ban

