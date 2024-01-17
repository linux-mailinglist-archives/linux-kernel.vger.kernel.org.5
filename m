Return-Path: <linux-kernel+bounces-28474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2382FF00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA031C23F03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA833F2;
	Wed, 17 Jan 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpv1sHHY"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596D7465;
	Wed, 17 Jan 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460062; cv=none; b=RLzrBJckM0z+dsthANlFNUBMo97bn3GA4bMSeDpMqvDibQJ7m7eWix0L23vlqY2ZNVAiL1GpkMBawDkUeOQGCeqD+YjAQrIByANVsOGD4KTEcnn6PHt4OpzwQSSnaBBN6vMDYb9mdtSrgr7qFlEzHtJjoYOrV3hFAShaDnWhvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460062; c=relaxed/simple;
	bh=/83gYU93Ud7vq7nPKEsjM1w405LiBKzvVyjOm7Hg6cA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=tHF6l325QJTIIhIgzZTIVuEJgDBVPaD7WmJefG34R+3GWUVwUvyU4hOSZ6cpW7nwb772O+9y9EMy33YlwLJ45/28o/9eHyUHNkq2o1DGkqFPD06BkLOPfGHbcMySudVtFmeVqPl8uwObAAvYJ/97IUsuMbsZFYKtfiW2wdcsUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpv1sHHY; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2046c724383so3991578fac.1;
        Tue, 16 Jan 2024 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705460060; x=1706064860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVGBKHbsW+ID/DGxBqN0PHCQ5oLBwlOUaceCEBaO48g=;
        b=Dpv1sHHY8+pScVve4j5+J1lT/a3/IIy4YoRQdJhw6iu49uDsX42CIBtz0z9qe0LVyg
         sxTHInjmA8hrUkt79L5dIvgUL0LoBRNOsAYXPUBjlmm4qJ2x8q8ujMto4i75XUL+4vnN
         EbhX/OugklxUsUXXF+ki7W9XM2Zbt91JkgSnEDJw3LW/XuaC7SH99YyW/hi2fmfwQamO
         c9c2//xbriFOYVn0Rb+vAqQO4RjbHHaxWRlyVNCfbHMxSH/X7U2nR4AXP1CVUtrZmxSC
         rn+dhfAlf0ONiRqrVxtp3oAKnI5TD4i1CVq9yD0iC/JblcN/A7O8FUFdyEA74pDSnXDm
         9bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705460060; x=1706064860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVGBKHbsW+ID/DGxBqN0PHCQ5oLBwlOUaceCEBaO48g=;
        b=aL8pBEMRPGbtWC/ukrNkQC+7sZAeQd9X5tM/ddGqzNNQtA7u4AH6J5PMq6TSMXrZP2
         CxlC9QXZZ6qlkfPfcSWlXnLPORlmV3Pt5eTTbUYq3g/oO/W/cYuL37CHBgkV9cRQ3vGm
         NKR7D8oOgz12z/dQP9bw+Kjc/Lju6JjwXUryVXQ2qXemy8kP7BQhjMJQNzm/Rj3ea0CB
         QwUE+ThYnQCiK85UuZ4pt2YpRpA5pqgsF3qQ8J1e2NH7BcVO25eRbVPL/1J4jGoqrSGC
         l54Gqg0RVu/PjiEwMP1oBEiT/qamQWeVc6c/16/xk+f9WERVf058SAixnuJZQx+v+wHE
         DZPw==
X-Gm-Message-State: AOJu0Yyqs7+FXq0Dgr5wqOJN9yzOqoOAHdEk9ku0Vui9j1SIyfmrQKQa
	x9imoSYtX67eDuUEvnLsRg280h8RIUuoref4zJM=
X-Google-Smtp-Source: AGHT+IFSGHRpCVQA62jHLl6m+lSQpDalayWj0ftExpE546suQA7WbA16GhWj8z2tzy33hf/KF4MJfnuQBLkmEcxqk2c=
X-Received: by 2002:a05:6870:d0ca:b0:210:9824:1335 with SMTP id
 k10-20020a056870d0ca00b0021098241335mr431492oaa.81.1705460059658; Tue, 16 Jan
 2024 18:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com> <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
 <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org> <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org> <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
 <20240116165356eaa221fe@mail.local>
In-Reply-To: <20240116165356eaa221fe@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 17 Jan 2024 10:54:08 +0800
Message-ID: <CAJRtX8S9dQddoxWv9T36i852ZgX6x-kjYvrGvRNd-2cXD8B=wQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:53=E2=80=AFAM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 17/01/2024 00:29:28+0800, Jingbao Qiu wrote:
> > On Wed, Jan 17, 2024 at 12:03=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 16/01/2024 16:51, Jingbao Qiu wrote:
> > > >>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> > > >>> module has an OSC oscillator
> > > >>
> > > >>
> > > >> I am not going to read pages of description. Please write concise =
replies.
> > > >
> > > > Thanks, What I mean is that this hardware includes two functions, R=
TC
> > > > and POR. How should I describe their relationship?
> > >
> > > Your POR does not need to take any resources, so no need to describe =
any
> > > relationship.
> > >
> > > ...
> > >
> > > >>> Your suggestion is, firstly, the por submodule does not have any
> > > >>> resources, so it should be deleted.
> > > >>
> > > >> So where did you delete it? I still see it in this patch.
> > > >
> > > > Should I completely delete him? How can a por driver obtain device =
information?
> > >
> > > Delete completely.
> > >
> > > Device information? What is this? We already agreed you don't have an=
y
> > > resources for POR.
> > >
> > > ....
> > >
> > > >> Device is only one thing, not two.
> > > >>
> > > >>>                     reg =3D <0x5025000 0x2000>;
> > > >>>                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > > >>>                     clocks =3D <&osc>;
> > > >>> };
> > > >>> However, in reality, the POR submodule does not use IRQ and CLK.
> > > >>> Please do not hesitate to teach. Thanks.
> > > >>
> > > >> I expect one device node. How many drivers you have does not matte=
r: you
> > > >> can instantiate 100 Linux devices in 100 Linux device drivers.
> > > >
> > > > I understand what you mean. A device node corresponds to multiple d=
rivers.
> > > > Should I completely delete the POR device tree node and add it when
> > > > submitting the POR driver?
> > >
> > > ? I wrote it in previous messages and twice in this thread. Completel=
y
> > > delete. You do not add it back! Because if you ever intended to add i=
t
> > > back, it should be added since beginning. I don't understand what
> > > submitting later would solve.
> > >
> > > > If that's the case, how can I explain that the rtc device tree node
> > > > uses the syscon tag?
> > > > How can I describe a POR device in DTS? POR is a submodule of RTC, =
and
> > > > it also has corresponding drivers.
> > >
> > > I said, there is no need for POR in DTS, because you have nothing the=
re.
> > > Why do you insist on putting it on DTS?
> > >
> > > > It's just that his resources are only shared with RTC's Reg.
> > >
> > > What resources? Reg? That's not a separate resource.
> >
> > I'm very sorry about this.
> > But I found a binding file that only contains Reg and Compatible.
> >
> > rtc@80920000 {
> > compatible =3D "cirrus,ep9301-rtc";
> > reg =3D <0x80920000 0x100>;
> > };
> >
> > Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> >
> > >
> > > To summarize: Drop POR from DTS and never bring it back, unless you c=
ome
> > > with some different arguments, which you did not say already.
> > >
> >
> > You are right, if there is no por device tree node, how can the por
> > driver obtain the Reg?
>
> I guess the question is why don't you register everything from the RTC
> driver?

Thanks, POR provides power off and restart functions as a child node of RTC=
.
So, I think it should be placed in the power/reset directory.

Best regards,
Jingbao Qiu

