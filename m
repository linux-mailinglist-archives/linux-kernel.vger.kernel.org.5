Return-Path: <linux-kernel+bounces-20691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B3828388
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A49F1C23DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF235EE4;
	Tue,  9 Jan 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiuI+wXG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CB34CFF;
	Tue,  9 Jan 2024 09:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA3AC433B1;
	Tue,  9 Jan 2024 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704794204;
	bh=Qj1F7vQXR5INGTzBCvV9vm+Os3PkCrPsecSk0gcowD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uiuI+wXGOgQCsJfodVvD7TtSKMBAuyi1UAeRMEURbK/Ahluvoa5pRYgbG+mUkceAa
	 ftvRGzM9D5qOPUuDdRXyRdzgnlAQtnfwh8sTmkmCjXkhxeytOWurbIq0JGAZFyMkeH
	 nXB4GAZG6Q2rfGHE0jzcZNqpBes3dL6iK9+DNN/QkiNAFhiSFxLJO0qluBNfAP4ZOV
	 Mhtz+ljnpSDLiSUNqKEEr0a79WuGsk4pPbM8WzhDDBOM+rfnu+XAdcrraHtC6nhh4j
	 x8k6DE6wE75G9OL0IHwjZtA/pCiYon6jVooeJ2fkPSEsTmwMkpbdvyBo+BCc0pKdXl
	 o3B0bTN5RSq1A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28bf46ea11so483159966b.1;
        Tue, 09 Jan 2024 01:56:44 -0800 (PST)
X-Gm-Message-State: AOJu0YwB0MqKKkQY0shBAJ9XeZ/A95pyKe1G2FTvJxU7xvOMLIoaVFmA
	8XhSV4CLal2jE+hE/AJZgpbGOmFsu2uqQZteiCw=
X-Google-Smtp-Source: AGHT+IGDZ/SZJpnUYzFx9G1HRdVTWUBV4U15+SGj/OVohDcnnqrlVNy+7QIKS/khbP7ZYDsPMVjRIsIZ+zQBmKjnTI8=
X-Received: by 2002:a17:907:77c1:b0:a2a:a3dc:621b with SMTP id
 kz1-20020a17090777c100b00a2aa3dc621bmr597168ejc.4.1704794202753; Tue, 09 Jan
 2024 01:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701933946.git.zhoubinbin@loongson.cn> <CAAhV-H4yS5nW9Xg1D+FRRa4jv8vGB9auim74NzTjmkw-CC6yZA@mail.gmail.com>
In-Reply-To: <CAAhV-H4yS5nW9Xg1D+FRRa4jv8vGB9auim74NzTjmkw-CC6yZA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Jan 2024 17:56:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4dPHqA5naqowOKxALWsXWHSVMoUqDC_1F_DE2t9=S28A@mail.gmail.com>
Message-ID: <CAAhV-H4dPHqA5naqowOKxALWsXWHSVMoUqDC_1F_DE2t9=S28A@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] dt-bindings: interrupt-controller: Fix some
 loongson,liointc warnings
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, lvjianmin@loongson.cn, 
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to loongarch-next, thanks.

Huacai

On Fri, Dec 29, 2023 at 11:08=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Rob,
>
> Since this series doesn't touch the driver any more, I suppose that
> this series will go through your dt tree?
>
> Huacai
>
> On Thu, Dec 7, 2023 at 3:29=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
> >
> > Hi all:
> >
> > Some liointc-related DTBS_CHECK warnings were found when trying to
> > introduce the Loongson-2K DTS{I} for LoongArch.
> > This patch series attempts to fix those warnings.
> >
> > Of course, these fixes also apply to MIPS Loongson-2K1000.
> >
> > Thanks.
> >
> > -----
> > V6:
> > - Drop the 'parent_int_map' related patches following Rob's comment.
> >
> > Link to V5:
> > https://lore.kernel.org/all/cover.1700449792.git.zhoubinbin@loongson.cn=
/
> >
> > V5:
> > - Add Reviewed-by tag;
> > patch(1/5):
> >   - Just drop 'loongson,parent_int_map' instead of marking it as
> >     deprecated.
> >
> > Link to V4:
> > https://lore.kernel.org/all/cover.1699521866.git.zhoubinbin@loongson.cn=
/
> >
> > V4:
> > - Add Acked-by tag;
> > patch(2/5):
> >   - Just add 'maxitem 2' instead of duplicating the list;
> > patch(3/5):
> >   - Rewite commit message for 'interrupt-names'.
> >
> > Link to V3:
> > https://lore.kernel.org/all/cover.1698717154.git.zhoubinbin@loongson.cn=
/
> >
> > V3:
> > patch(1/5):
> >   - new patch, 'loongson,parent_int_map' renamed to 'loongson,parent-in=
t-map';
> > patch(2/5)(3/5):
> >   - Separate the change points into separate patches;
> > patch(4/5):
> >  - new patch, make sure both parent map forms can be parsed;
> > patch(5/5):
> >  - new patch, fix 'loongson,parent_int_map' references in mips loongson
> >    dts{i}.
> >
> > Link to V2:
> > https://lore.kernel.org/all/20230821061315.3416836-1-zhoubinbin@loongso=
n.cn/
> >
> > V2:
> > 1. Update commit message;
> > 2. "interruprt-names" should be "required", the driver gets the parent
> > interrupts through it;
> > 3. Add more descriptions to explain the rationale for multiple nodes;
> > 4. Rewrite if-else statements.
> >
> > Link to V1:
> > https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongso=
n.cn/
> >
> > Binbin Zhou (2):
> >   dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
> >     warning for reg-names
> >   dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
> >     warning for interrupt-names
> >
> >  .../interrupt-controller/loongson,liointc.yaml | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > --
> > 2.39.3
> >

