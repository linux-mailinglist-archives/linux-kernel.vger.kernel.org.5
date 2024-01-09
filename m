Return-Path: <linux-kernel+bounces-20686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4582837E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846A428660F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE035890;
	Tue,  9 Jan 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI9g4fEZ"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85A36083;
	Tue,  9 Jan 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bc09434600so1297547b6e.0;
        Tue, 09 Jan 2024 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704793919; x=1705398719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPUv3QW7n483OFe/6FoSL+QHdD2N0HZP4qwddKfjG3g=;
        b=NI9g4fEZR/3AbxqX+zsWNgSSu19AtD5NwI39Qvi4agu7yY6fKWwO5Xctj3CCET7sAh
         +YMUp8FKZjRyps685HQtGpXIJu9N6ddtD2vT0Hu2Z/wtvVvWe19GMkbiXVZM2MyWqTUG
         aANbIJkVQfSNB0OdjbB9j909lEwI2ivAMmlgtp4Eb+0pO3Saegl1AbaxP8pssRb3bidr
         +4OO52FEOO2FgAJxLXEGRJFwHuA4h1fB7yzOhPOdB63AmKjAm9SoQ6a5+3o+OxWY3voH
         i1SiDV+JaUP/XWvgF/l3HJ5ngSO4D2ICr7b86VfdaALsrF8SsVm8dtQNL3vMs/CvFtr5
         CMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793919; x=1705398719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPUv3QW7n483OFe/6FoSL+QHdD2N0HZP4qwddKfjG3g=;
        b=pPSfOtIw94zr1ZQSU4cOnDBwC1B2LSFg+PIoA1/9C+EWxnI2yn0tteOx5TtRWN+kY/
         /W0weTKLz+IWc0FGrRfWdY9RcdiMo7RbJC8rCzJMV2g+jvLVHQSkcyxc1mc6sF2bOkc5
         5rPVAP3BZvAgiE7c7lorDE1GJOiU+Ucuy675h7j2Iget8MWx+gmFyZHTKXdOIRaHM0vk
         4AD5eRgpKOm7YcDl35U9C6SfbfYquUgVpkHPArYuERcQOt2fZojottcx0m25hy3RTqWu
         qfeoJtI4ans2daWqRE5K2jqTR6g2S7rO41BBUSiqwD2REKaJpTviaf3ygWz4SoHE3apq
         wZVg==
X-Gm-Message-State: AOJu0Yx/u/PRlWrvq04rTAzpv3AqrD1y9j288N/elvYHVb6eNxLfvIoi
	ebhNO2YHAA5XUB3k4a6vrZX7Wf3h9RNKAWOm7I4=
X-Google-Smtp-Source: AGHT+IHQqkc7BIeln2onubKw0WHBuz69qRZSLNVyH2G06VXYslDMZgE+1lgS7IToN4DVHq446e93GbI+AvSdLkJRmGA=
X-Received: by 2002:a05:6808:1a0b:b0:3bc:28eb:882a with SMTP id
 bk11-20020a0568081a0b00b003bc28eb882amr212777oib.9.1704793919014; Tue, 09 Jan
 2024 01:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <20240108072253.30183-2-qiujingbao.dlmu@gmail.com> <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
 <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com>
 <7ceb8f61-6929-4ca0-83e0-c6534241ca5a@linaro.org> <CAJRtX8QSoS72rUj7vu3CLgthfneG-RudUygcZEsw-sBFKw99tw@mail.gmail.com>
 <086e568f-b9f2-417c-8f94-ebb97fbffbfe@linaro.org> <CAJRtX8Ran+MuhtUXyxm0stQJrkzksPeNEnWViOQjfE2QgsCOmg@mail.gmail.com>
 <a6ee48ad-f4c1-4d75-956b-a5283ee92eaa@linaro.org>
In-Reply-To: <a6ee48ad-f4c1-4d75-956b-a5283ee92eaa@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 9 Jan 2024 17:51:48 +0800
Message-ID: <CAJRtX8SBEXBzjs4sU+zOmsGUDF+K+TFw4S4x-f6WR5f2K5h6yw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 4:02=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/01/2024 03:26, Jingbao Qiu wrote:
> > On Mon, Jan 8, 2024 at 11:24=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/01/2024 14:47, Jingbao Qiu wrote:
> >>>>> So I wrote the following in the changelog.
> >>>>>
> >>>>> - add syscon attribute to share registers
> >>>>>   with POR
> >>>>
> >>>> Where is this syscon attribute? Please point me to specific line in =
DTS
> >>>> and in the driver.
> >>>
> >>> I will explain in the next version of DTS.
> >>> Thank you again for your patient reply.
> >>
> >> You added some syscon attribute. What is this?
> >>
> >
> > This RTC device has a POR submodule, which is explained in the descript=
ion.
> > The corresponding driver of the POR submodule provides power off
> > restart function.
> > The driver of the POR submodule just uses reg to work.As you mentioned =
in your
> > last comment.POR  is empty, so there is little point in having it as
> > subnode. we need
> > share the reg to POR. RTC driver and POR driver will access this
> > address simultaneously.
> > so,I added this syscon attribute.
>
> Nothing from above explains what is "syscon attribute", but if you
> cannot explain it, at least point me to where did you add this syscon
> attribute? Changelog said you added it. Where?
>

Thank you for your comment. I will add it in the next version.

Best regards,
Jingbao Qiu

