Return-Path: <linux-kernel+bounces-1203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF29814BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48603286F93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C99374D2;
	Fri, 15 Dec 2023 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu67xkrN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083633A8E7;
	Fri, 15 Dec 2023 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so665613f8f.0;
        Fri, 15 Dec 2023 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702653554; x=1703258354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMReaTbQ3mhpSM37nBgg+G+dvqzrCE9o1IcxtKQzbVA=;
        b=cu67xkrNdj5cnzNgLgKNL+l6bmW0M4QKGw/wFA3zKdydTAepTwwpIdrU/0kmsNq8M+
         REG8gtppZS64/Pv/AWdrZCFopE5IYT/peti+ndgVZQFl4w7PKN80hvmP31rFb1uxud2e
         mp+gFdiPluurxxTUizjzSDb9v847rNEiAER8uJumNrDMiY+deWmNK9DCqya19/JQYNsE
         wnQ2VnrU6uVjKZUaFeDjGr+D4+hyGFu9e0OoZxg+RNb5SsaXK68j8SOMtMOwjDCTCeT5
         1zxRcGzHUHrvQSr/hDxwI35nYp/nfamFkNIURO9Yo+dIf5br4FwBcObM9bsUmR6M+MIi
         zmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653554; x=1703258354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMReaTbQ3mhpSM37nBgg+G+dvqzrCE9o1IcxtKQzbVA=;
        b=MYTm4oyfbqTAdqNTqUIJ36gAedaVi6RktV+vWYQGUja/4dgBni2J/s+Lv+GxIWg5pv
         WqLyGf1vANosUr79GHghwFR9i7wIbqMJKJF4qlCkW0MYUAOYHDWcRUt1gGZiEZ3fbtvc
         dL3lxtxKmmgRKz5V8L4tUS7qjGojQeY1mNHB2Vw1kPJOHvqi6iKC1cWXV5QIv1ATSy56
         U57PE/hztdXXwjc4k28oQI7c/1OSpwi7WtMh/GYcv63v8m16PbAdTmXMBvl0rixRFD3U
         tvQHukBv+j0fqLaiX12PAbQJzqxGhJcZjKhE5+rip7xod2ZfilTvllaST1EuL3o/I2TC
         k6Rg==
X-Gm-Message-State: AOJu0YwWMQ+/ODVP2reF6qFvpEXdIyJ6xf5/zdsJc6twD5aYZT5TU032
	1xlU6Krh6WEqfCI5ulqqECM=
X-Google-Smtp-Source: AGHT+IGKqTqBRSWdn71ojaWth20HbPUm9gy+BpxlK4y7dtRj5sPpy5aey1MFNTP111CfVFovxNGCrQ==
X-Received: by 2002:a5d:4573:0:b0:336:595d:d201 with SMTP id a19-20020a5d4573000000b00336595dd201mr291256wrc.19.1702653554178;
        Fri, 15 Dec 2023 07:19:14 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.212])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b003364360839esm5891186wrx.81.2023.12.15.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:19:13 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: jernej.skrabec@gmail.com
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	fusibrandon13@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	rafael@kernel.org,
	robh+dt@kernel.org,
	samuel@sholland.org,
	tiny.windzz@gmail.com,
	viresh.kumar@linaro.org,
	wens@csie.org
Subject: Re: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU frequency scaling
Date: Fri, 15 Dec 2023 16:18:35 +0100
Message-Id: <20231215151835.46492-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2177637.Mh6RI2rZIc@archlinux>
References: <2177637.Mh6RI2rZIc@archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 14, 2023 at 5:37 PM Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
>
> On Thursday, December 14, 2023 2:47:14 PM CET Conor Dooley wrote:
> > On Thu, Dec 14, 2023 at 04:44:46PM +0530, Viresh Kumar wrote:
> > > On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
> > > > Two OPPs are currently defined for the D1/D1s; one at 408MHz and
> > > > another at 1.08GHz. Switching between these can be done with the
> > > > "sun50i-cpufreq-nvmem" driver. This patch populates the opp table
> > > > appropriately, with inspiration from
> > > > https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi
> > > >
> > > > The supply voltages are PWM-controlled, but support for that IP
> > > > is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
> > > > which seems to be the default on most D1 boards.
> > > >
> > > > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > > ---
> > > >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
> > > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > > index 64c3c2e6c..e211fe4c7 100644
> > > > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > > > @@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
> > > >   };
> > > >
> > > >   opp_table_cpu: opp-table-cpu {
> > > > -         compatible = "operating-points-v2";
> > > > +         compatible = "allwinner,sun20i-d1-operating-points",
> > >
> > > I don't think you should add a new compatible for every SoC that needs
> > > to be supported by a DT bindings and cpufreq driver. Maybe you should
> > > just reuse "allwinner,sun50i-h6-operating-points" and it will work
> > > fine for you ?
> > >
> > > Rob ?
> >
> > The driver can definitely just reuse sun50i-h6, but the binding and
> > devicetree should have a soc-specific compatible for the sun20i-d1.
>
> Correct. This is to avoid later regrets if it turns out there are some slight
> differences or additional functionality.
>
> Best regards,
> Jernej
>
> >
> > That said, the compatible does need to be documented, there's a
> > dt-bindings patch missing from this series.
> >
> > Cheers,
> > Conor.
>
>
>
>

This dt-bindings patch will be available in v2

Thanks for reviewing.
Brandon.

