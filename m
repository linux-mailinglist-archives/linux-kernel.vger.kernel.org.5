Return-Path: <linux-kernel+bounces-8819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0F81BCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9491F25331
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0206280D;
	Thu, 21 Dec 2023 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUFviwBD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76562805;
	Thu, 21 Dec 2023 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-553eb74df60so1228638a12.0;
        Thu, 21 Dec 2023 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178713; x=1703783513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c7qdOK44Erw1rd2N9Dkc3C/rkBrTjfjshoie/DwZvs=;
        b=mUFviwBDk+rBD0Cigr7Ej1YqAFjUeW9dpF+t6QeI6n6ppzg3OrDoWqq4wOiWKrDMgU
         QI0bXw9Y70sxTTp12n/v86SeMKdw6qTyARCSit+yHJlNyopV2GkLcW7IwVpEDTV6mvAw
         y1BUTSs1GCulkEENA7QX7AVSPjFNt+s9Kgf5EeNJ3L+ttgt9Zck9qSCY6ieMdRrenA0P
         iYFFYRTyT0dgSxyYck4huvBZTts5Xk/PJ5Af1Ya6KByOa7xSa048a9sAp5HlFrOuqlpM
         5gMJGtArxsmU9+fodaU4Mga4JwvSl55VVyNtlUDcNYC7p1MPx2lPGJfTQZ+fbZ5u9KIT
         4zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178713; x=1703783513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c7qdOK44Erw1rd2N9Dkc3C/rkBrTjfjshoie/DwZvs=;
        b=n7VlwyqyTCc5jBAk7Xvsevj70aCd08ecfYc/ULRg0Wl9D30m/3uuVs6f8vV6HOiOMl
         QfmlGmgJ3katSmXKkSeG2L/bKz9qSUY+Yml3oiZX0lqmLAC/Pw61EwVOdGBO4E0VqJ1z
         mEaLe+NLblFaKiR6v0MYEqy/lyNOoHJqIlvqNZ1N5fKa9MFqzbc4zxScgWfWez2q3q+x
         f8WUaP2PM1YzKK24ujs5WFLMlhJDFasWo7tn3ALDNSDu5BSuIvZxKO7bfVMKaPge85Ri
         DB4Ke5UK6Mn4gsoQtV40zf0XOpQmvQvvauKcHczQyxx6U2uC/OuqsSDZuz5q69lqRyJW
         d0aw==
X-Gm-Message-State: AOJu0Yytc6zepfRDLk7Trg02x9XRskgmt8uA9z184vGJthckM/ddhU+v
	e+v4wFarTJ1nzvNZxldUVs4=
X-Google-Smtp-Source: AGHT+IHNiAZdFnzAEiUdKfNoeSk+geKiEkWgT/aPnMVG9zgCLJmSuW1YXNdZkHxCVKCqsDhOaSRiwg==
X-Received: by 2002:a50:c057:0:b0:54b:27e7:f965 with SMTP id u23-20020a50c057000000b0054b27e7f965mr12048802edd.19.1703178712653;
        Thu, 21 Dec 2023 09:11:52 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.204])
        by smtp.gmail.com with ESMTPSA id b24-20020a056402139800b0054cb316499dsm1400760edv.10.2023.12.21.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:11:52 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: andre.przywara@arm.com
Cc: aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	fusibrandon13@gmail.com,
	jernej.skrabec@gmail.com,
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
	sfr@canb.auug.org.au,
	tiny.windzz@gmail.com,
	viresh.kumar@linaro.org,
	wens@csie.org
Subject: Re: [RFC PATCH v2 2/3] cpufreq: sun50i: Add support for D1's speed bin decoding
Date: Thu, 21 Dec 2023 18:11:07 +0100
Message-Id: <20231221171107.85991-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221124957.27fa9922@donnerap.manchester.arm.com>
References: <20231221124957.27fa9922@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 21, 2023 at 1:50 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Thu, 21 Dec 2023 11:10:12 +0100
> Brandon Cheo Fusi <fusibrandon13@gmail.com> wrote:
>
> Hi Brandon,
>
> thanks for the quick turnaround, and for splitting this code up, that
> makes reasoning about this much easier!
>
> > Adds support for decoding the efuse value read from D1 efuse speed
> > bins, and factors out equivalent code for sun50i.
> >
> > The algorithm is gotten from
> >
> > https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/sun50i-cpufreq-nvmem.c#L293-L338
> >
> > and maps an efuse value to either 0 or 1, with 1 meaning stable at
> > a lower supply voltage for the same clock frequency.
> >
> > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > ---
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 34 ++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index fc509fc49..b1cb95308 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -29,6 +29,33 @@ struct sunxi_cpufreq_data {
> >       u32 (*efuse_xlate)(u32 *speedbin, size_t len);
> >  };
> >
> > +static u32 sun20i_efuse_xlate(u32 *speedbin, size_t len)
>
> I feel like this prototype can be shortened to:
>
> static u32 sun20i_efuse_xlate(u32 speedbin)
>
> See below.
>
> > +{
> > +     u32 ret, efuse_value = 0;
> > +     int i;
> > +
> > +     for (i = 0; i < len; i++)
> > +             efuse_value |= ((u32)speedbin[i] << (i * 8));
>
> The cast is not needed. Looking deeper into the original code you linked
> to, cell_value[] there is an array of u8, so they assemble a little endian
> 32-bit integer from *up to* four 8-bit values read from the nvmem.
>
> So I think this code here is wrong, len is the size of the nvmem cells
> holding the bin identifier, in *bytes*, so the idea here is to just read
> the (lowest) 16 bits (in the D1 case, cf. "reg = <0x00 0x2>;" in the next
> patch) from this nvmem cell. Here you are combining two 32-bit words into

This is true. Not sure though what the 'in the D1 case...' bit means.

> efuse_value.
>
> So I think this whole part above is actually not necessary: we are
> expecting maximum 32 bits, and nvmem_cell_read() should take care of
> masking off unrequested bits, so we get the correct value back already. So
> can you try to remove the loop above, and use ...
>
> > +
> > +     switch (efuse_value) {
>
>         switch (*speedbin & 0xffff) {
>

Shouldn't the bytes in *speedbin be reversed? 

> here instead? Or drop the pointer at all, and just use one u32 value, see
> the above prototype.
>

I was uncomfortable dropping the len parameter, because then each
platform's efuse_xlate would ignore the number of valid bytes actually
read.

> Cheers,
> Andre
>
> P.S. This is just a "peephole review" of this patch, I haven't got around
> to look at this whole scheme in whole yet, to see if we actually need this
> or can simplify this or clean it up.
>
>
> > +     case 0x5e00:
> > +             /* QFN package */
> > +             ret = 0;
> > +             break;
> > +     case 0x5c00:
> > +     case 0x7400:
> > +             /* QFN package */
> > +             ret = 1;
> > +             break;
> > +     case 0x5000:
> > +     default:
> > +             /* BGA package */
> > +             ret = 0;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
> >  {
> >       u32 efuse_value = 0;
> > @@ -46,6 +73,10 @@ static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
> >               return 0;
> >  }
> >
> > +struct sunxi_cpufreq_data sun20i_cpufreq_data = {
> > +     .efuse_xlate = sun20i_efuse_xlate,
> > +};
> > +
> >  struct sunxi_cpufreq_data sun50i_cpufreq_data = {
> >       .efuse_xlate = sun50i_efuse_xlate,
> >  };
> > @@ -54,6 +85,9 @@ static const struct of_device_id cpu_opp_match_list[] = {
> >       { .compatible = "allwinner,sun50i-h6-operating-points",
> >         .data = &sun50i_cpufreq_data,
> >       },
> > +     { .compatible = "allwinner,sun20i-d1-operating-points",
> > +       .data = &sun20i_cpufreq_data,
> > +     },
> >       {}
> >  };
> >
>

Thank you for reviewing.
Brandon.

