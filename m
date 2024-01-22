Return-Path: <linux-kernel+bounces-33093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4B836468
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB81F23477
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0B3CF72;
	Mon, 22 Jan 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I1Hboj50"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E73CF5A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929929; cv=none; b=KuyZeNzmAxcAl5uheQq+ZFfrs/RvWdAClvroBEDC0iml78nYZM0NlkwigbewyPU0buhPCzaOwzaHxMRNmHrTATHEB1udmH6rN6NagIyQ/Q1Ew0CpvmfSxIfpX2HC/a7H748ehCHQdzTNHZiPhhnlm5jzGsDIWwHFFIUceged+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929929; c=relaxed/simple;
	bh=8/ysmW7ZNCwST64C+OGZnecZkpP9Ivshlxnv2xaANtk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyOcdQ+0umz399bWHf77gI8GBe2Sff+wqmRhjCMOyiP8JRlos9wDXWz3D5vz+wByMWao6Mj6lL5mM3AdbcJlx02z/MWvl4uNdxMBvFhcx1pjjtC7GEAK9G/FPf5y1Q7At3D7Bl0BdvPWt4S/oz2Dcsylgwic3cztLkdU1LBn8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I1Hboj50; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B63F43F270
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705929919;
	bh=YH8oe3j90TqC6EUcRLoZewEzXWg7T54K4/yaoqW2dG8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=I1Hboj50NBVRf/Ancb9KRXF956ETQXZNPO0JDlxxHjjusimU1dMIAgUOaTGi7rbeU
	 yyhdvSFpTwGzqujEl7EgXZHXdbjMHXD+8mBBZ8wqG1W2v5f4hTsRpeU0/neapPH+RH
	 MGpDYU6mYa0w2wPUhVfhvi+qRN8WhNSd2k92BUYLwNxeYiJVneY7cCY6WVIOcVcnQE
	 lVQn37VFP2UkwONCD+YdOMJG2GK3P2blXQsek+wOALpDSxKfwQr4JWIpmL7X4zn2s2
	 vlo1/qIkR3GNrVoOjSr+9VYznTgtSWFJFvt1IZCChGbi9mPBATyBSlaQan77hRnWAa
	 9z3m1+udseGWw==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42a4660fae8so6285051cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929919; x=1706534719;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YH8oe3j90TqC6EUcRLoZewEzXWg7T54K4/yaoqW2dG8=;
        b=mYfa9Lyn/528bJrnzlpdioYU9LrRZsTufj+R/7WZNMBksPr+ZrTkNWkJK29MnwSBbM
         wkEBJzDaOUsKDNVDHamHRKzwsNSPYS844tUSR/UkbqSBotcG5NRG3GT9CRkKdOuAxaa/
         UjpaaCbUyCfK09ZFF6svnGPUekUMu/75cQu3s6i0AsuKuj+fHRFvzrsckLGKiNHIHxMd
         53An+e485QaARfe+mMYJVnsVxR0OhoSVX4v8quWtkJtBI+JCm9RMtHCHGkBhgK6XbGGs
         Pf0hOn/nJP8J5GvpbJedIujVbP5WxFUMkDKNXZkfnWGidre9gn0oyPUtMjCr2pfFtsHT
         KHLg==
X-Gm-Message-State: AOJu0YxDYcBxkTX35OIFQ1DsYz9VPkM+PySZHvEPFa3m8jBBc6PhQpl6
	ZNUdeIjF2lVXTtyGL1uGax8+tj16C1BkZ2WSI2Ch6HsVL8/7n3D9RsHybS83vyX+9tTDd9Ie6y6
	YddOXQnGl1eX+T0Ia9N9uAuJ8CCe9Q2jiWbdtOcqazZDrido1hlzJbM9MNK6Ow8FZsYpO/c+lfL
	OG6sO2W8fUSCFxnUy1EK3TnMS0zpsoEHFK+IGYpWqhRRCNZA4Anpbe
X-Received: by 2002:a05:622a:303:b0:42a:49e4:b37 with SMTP id q3-20020a05622a030300b0042a49e40b37mr119062qtw.3.1705929918832;
        Mon, 22 Jan 2024 05:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7+muAaQtx9j7uChxp/TBkqVQgMiOi15ISY7W8przRxn8y+BBacZEXgLJg7UZEG/dbFasUGtdYFB6HCnf8ULY=
X-Received: by 2002:a05:622a:303:b0:42a:49e4:b37 with SMTP id
 q3-20020a05622a030300b0042a49e40b37mr119041qtw.3.1705929918598; Mon, 22 Jan
 2024 05:25:18 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jan 2024 05:25:18 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240122080631.2880-2-qiujingbao.dlmu@gmail.com>
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com> <20240122080631.2880-2-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 22 Jan 2024 05:25:18 -0800
Message-ID: <CAJM55Z_DFox9c_eDeHtx9H+9e4A6pjkCkt7po94j_mu-tQWywg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, alexandre.belloni@bootlin.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"

Jingbao Qiu wrote:
> Add the rtc device tree node to cv1800 SoC.
>
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index df40e87ee063..0cd7eb9a3048 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -119,5 +119,12 @@ clint: timer@74000000 {
>  			reg = <0x74000000 0x10000>;
>  			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>  		};
> +
> +		rtc: rtc@5025000 {
> +			compatible = "sophgo,cv1800-rtc";
> +			reg = <0x5025000 0x2000>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc>;
> +		};

Before this patch it looks like the nodes are sorted by their address,
but this would break it.

>  	};
>  };
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

