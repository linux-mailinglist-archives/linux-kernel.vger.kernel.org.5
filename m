Return-Path: <linux-kernel+bounces-9237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47681C2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376B1B22215
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D502913;
	Fri, 22 Dec 2023 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ysisfb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711651C06;
	Fri, 22 Dec 2023 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso43224939f.0;
        Thu, 21 Dec 2023 17:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703208448; x=1703813248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy8g0lzs7eaKHdXsmVjSrLQ8rBtR4re0URoEliy+E2c=;
        b=J3ysisfbARrGvLP5hd8lrZevjnmGNJwuFUmWWzxyMaT0RSs3ZZRlygfhLiwbUdJawd
         Mjkly+AU0ksHDRLeV4psUpMJLSonLGA/cA/Z0loshvcnIfGeYrjwS++a5X9h90ZL9Hwe
         Y2IEoYr23zPqi4d4wDEq947cFcgdsNscKtFZvuOcszlfHCXZ4hRxvuMCAdSSdgcHaQdM
         SxaExlhGGG8xNwg+VBZBmqUSP/7Xj86jifAlOCvsRS0a3dW0NFzp6GRJF252YNSKFP4f
         NU8JeBBPRu1v6/C3VYSIYFz8DdmohCyCJps/qNLXfGgNvRJgOxCeojx2KmncmNKr3sBv
         36Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208448; x=1703813248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy8g0lzs7eaKHdXsmVjSrLQ8rBtR4re0URoEliy+E2c=;
        b=VJPGfbMyHxPa5seI+v7n2vUKbRYM+usoJmwTykamTd1LeboZMT2ZzfQkaRl4d/ejbt
         tMYyrgWOxk2SV0HCAGH5Jb49DZW+ljObd/N49cueoKDoxp1ZG4pHE3tdlXle/Yp9FsBG
         aX9AktAW/eg2dX7+/UHNLc7QzZyg5uigZZeXMRfgmPqI1x6M+zuW9X86T1NzrwiCEjGi
         a15HU6shArzd7TW0ZRxI7NzyfmacNa5QvRtjZEw+dYNHyn+gTRqniEXcfCZHlRZfIIDx
         glCE8xcO2ANsSQshXRjOX18tPuQhzAIceFLG/Ew50MTCysk080raelsxe1T2fc6zZn2j
         f8Tg==
X-Gm-Message-State: AOJu0YxU671PYNq81iAY8AJz1H+I0uC4N6Hqm0mKfhyfkNJ49UFH/tkP
	Bq80QM6uHLl0ebqnGTKu3ESyHrw/kVwopxgG1wKUEUx3aek=
X-Google-Smtp-Source: AGHT+IENIdhp+wVXGkDYH0RYIkfdROfEfqzYbfyIxwYeq1Y0iQANbD+H6pXUx/iczB5ACQ1EdYKX3pHgiXMN2c3RPe0=
X-Received: by 2002:a5e:da4d:0:b0:7b7:f9fb:8766 with SMTP id
 o13-20020a5eda4d000000b007b7f9fb8766mr607985iop.14.1703208448542; Thu, 21 Dec
 2023 17:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219080021.2048889-1-kcfeng0@nuvoton.com> <20231219080021.2048889-2-kcfeng0@nuvoton.com>
 <170297774900.1297817.5593278746406765111.robh@kernel.org>
 <CALz278aJ08fOU2XZMZJJ2Ocp+XwovJ0+nHK-=0dWqbXf+522OA@mail.gmail.com> <9035aff7-49e6-49cf-a8f8-619d3b53c4a5@linaro.org>
In-Reply-To: <9035aff7-49e6-49cf-a8f8-619d3b53c4a5@linaro.org>
From: Ban Feng <baneric926@gmail.com>
Date: Fri, 22 Dec 2023 09:27:17 +0800
Message-ID: <CALz278Z-KF+NurdXhOQjoP-RMhQfrshEyU=KkumN8Peus7Wdew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, corbet@lwn.net, 
	kwliu@nuvoton.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jdelvare@suse.com, kcfeng0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org, 
	linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org, 
	Bonnie_Lo@wiwynn.com, conor+dt@kernel.org, DELPHINE_CHIU@wiwynn.com, 
	linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Dec 21, 2023 at 4:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/12/2023 01:44, Ban Feng wrote:
> > Hi Rob,
> >
> > On Tue, Dec 19, 2023 at 5:22=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >>
> >> On Tue, 19 Dec 2023 16:00:20 +0800, baneric926@gmail.com wrote:
> >>> From: Ban Feng <kcfeng0@nuvoton.com>
> >>>
> >>> Adding bindings for the Nuvoton NCT7363Y Fan Controller
> >>>
> >>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >>> ---
> >>>  .../bindings/hwmon/nuvoton,nct7363.yaml       | 62 +++++++++++++++++=
++
> >>>  MAINTAINERS                                   |  6 ++
> >>>  2 files changed, 68 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,n=
ct7363.yaml
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_che=
ck'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > Our design is based on [1], and adds fan-common.yaml to
>
> Nothing in the patch or cover letter described the dependency.
>

ok, in v3, I'll attach a relevant patch and describe it in the cover letter=
.

Thanks,
Ban

