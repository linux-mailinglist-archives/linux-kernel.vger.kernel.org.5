Return-Path: <linux-kernel+bounces-158208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4348B1CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B43D28806A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC977FBA8;
	Thu, 25 Apr 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1uQbAxC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938CF28EB;
	Thu, 25 Apr 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034651; cv=none; b=d5iSO94SMu8RQPhEUkZziHwpGtP88vgUeNye4MEppSiAJxdaeHpNp9d9iNz9IIdi59SMaXzjTTPttgSmTlnn2EofLOsp7DVQJ6RcgWHL2n3b5/sXazo7EVLRVh5pe0Dcmf+qjRohFVkLLCezCY5KLUqc3uXTk1PMZ9QCq/3mAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034651; c=relaxed/simple;
	bh=4QxqiEPlGW9aJY2EPSyuY0kcyIQtsKDUIt8l0I/G+uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoSFOoTT5TbbBXXOvQhjwrxy0RfhH/fgmcUQL0I8q8ag/oDm/0OZiOvnmGd/AGB/+ptLtPqoVvKj5NRvgC98/bqpwi+T11LKz6TXpjlm6vTOurmevhtHQhKF30vA+nuhi3DRrr/3vv78eTki+a9RFS+3YGatOYlP74ur3tZ/S4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1uQbAxC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a0d09e6ffso3497075ab.0;
        Thu, 25 Apr 2024 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714034649; x=1714639449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObComE1Po7slwCNo6ZQGEQaPwizCdyr800XDwnlIYmw=;
        b=D1uQbAxCcja2t69p8d9dBxkmPdgng/4smwabFY9MDpSBfANMWu1z7nNwT8afrWYi3Z
         xyzFLmvV7Id3lnNkFGnYmCeynf5TpEAVAfMGX4P0aHs2GKOY53QF/s51vMplokp29vU6
         mgFjq8EftBveCHo/RAwKcbJpY+XoVQoc10WUaQr0Y51rSlnYKGPvByTJxdO1AW7/YG5N
         JL7egSvmVfPF5IBIgtLwdd0d8Uw2fWsI6hN4l+0qVZLD1fEmpnS2oSrR8DNnxAydQeiv
         /2iMosl7QAtp0cC+mYJep8p+0PMyIj74D8vwNPHe8w7Kk9i8rqDScpu0Ap8TlczVgYN2
         EjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714034649; x=1714639449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObComE1Po7slwCNo6ZQGEQaPwizCdyr800XDwnlIYmw=;
        b=uuG3rgtpORWCb3qc9V0SHCo0CCbeHV7K8HSb+/+62XHfzTCuRPL4ZeR0ONU7ZBAD80
         /QW1Stehaxfi1LgzvRuVZUj+Jlyrf5L6PLXjgST6lGBpOhCPGbZXDPBpv9BKK9tUW33D
         J6LCaiQuhwdaYRs3qHgCL3dLJn6F1lYUDuchNKnj9WURgxA1amIimvvjroVqCI0vMT0L
         uXsWADHtH/ToOu2YMZxB2jkbP4p12hSH5qYOHWT6RtCzJ4/wcGSzH9f5fg055L23wslp
         qagmT+xa2lrYAjymF3mKkxPuszYgM3CMCjA7G4LcNbVg/A7o1xDfG6j9odaO8ZYQLOz6
         ADEg==
X-Forwarded-Encrypted: i=1; AJvYcCUSUc73Ui3uuk6GmA2fLM8ufWr7YQ5u9Fe4CiS1qzVia0oy/Y7LNwiWOSoIGen3VtAl7MVubqLqtkCUrr8F8Q5iNFUsDEzCuwiSS3zf3Fls5Fg4+WiBF5YA1O5GgqJYGVa0zlmDf5Lk
X-Gm-Message-State: AOJu0Yw5UPXeAsorx4LRpM7vb9vNmqvhCz2BKZ7R3vWmSF9ZctiBSjqW
	EqjO8hZ+gM9k3foNZ903wuOM4IYLxYLAg/eJE0IOuz0Ru4a/LHzZphPozCrm3FzoJVpnXIpdDU2
	RFnJZv0U7qHYSB2KGAH52Lzkgark=
X-Google-Smtp-Source: AGHT+IEKkt80Zxj13na2drMQtjsLKW++rG0Qa2TYDv1Sf/OKqne4MnwCqCDDVIGc8mEobpNM4xU5eNT48IgnjQMiXp0=
X-Received: by 2002:a05:6e02:1561:b0:36b:26df:ccec with SMTP id
 k1-20020a056e02156100b0036b26dfccecmr6268829ilu.16.1714034648684; Thu, 25 Apr
 2024 01:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
 <20240424164725.GA18760@francesco-nb> <CAA+D8AMxcAOdeSUhLnFdX2tjXSiWKg8-oxfZ8oT06-qQPnNKqA@mail.gmail.com>
 <20240425083214.g6xplxql4g32zxud@pengutronix.de>
In-Reply-To: <20240425083214.g6xplxql4g32zxud@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 25 Apr 2024 16:43:57 +0800
Message-ID: <CAA+D8ANyQwmS+sp-mo22zi4imSL9APHg5dY3-9yXMQSY_MMziA@mail.gmail.com>
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, peng.fan@nxp.com, s.hauer@pengutronix.de, 
	sboyd@kernel.org, festevam@gmail.com, mturquette@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-imx@nxp.com, 
	kernel@pengutronix.de, shawnguo@kernel.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-arm-kernel@lists.infradead.org, 
	abelvesa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 4:32=E2=80=AFPM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> On 24-04-25, Shengjiu Wang wrote:
> > On Thu, Apr 25, 2024 at 12:47=E2=80=AFAM Francesco Dolcini <francesco@d=
olcini.it> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > > > Add pm_runtime support for power saving. In pm runtime suspend
> > > > state the registers will be reseted, so add registers save
> > > > in pm runtime suspend and restore them in pm runtime resume.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > Is this introducing a regression?
> > >
> > >   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
> > >   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, co=
de 0x00000000bf000002 -- SError
> > >   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/=
0 Not tainted 6.9.0-rc5-next-20240424 #1
> > >   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdi=
n iMX8M Plus on Dahlia Board (DT)
> > >   804 13:50:19.747157  <4>[   16.535431] pstate: 80000005 (Nzcv daif =
-PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >   805 13:50:19.758468  <4>[   16.535442] pc : clk_imx8mp_audiomix_run=
time_resume+0x24/0x48
> > >   806 13:50:19.759372  <4>[   16.535456] lr : pm_generic_runtime_resu=
me+0x2c/0x44
> > >   807 13:50:19.759587  <4>[   16.535465] sp : ffff800082b8bb90
> > >   808 13:50:19.774512  <4>[   16.535468] x29: ffff800082b8bb90 x28: 0=
000000000000000 x27: 0000000000000000
> > >   809 13:50:19.775367  <4>[   16.535482] x26: 0000000000000000 x25: 0=
000000000000000 x24: 0000000000000000
> > >   810 13:50:19.790567  <4>[   16.535495] x23: ffff0000c0f7a4e0 x22: f=
fff0000c26922f8 x21: 0000000000000000
> > >   811 13:50:19.791308  <4>[   16.535508] x20: ffff0000c2692000 x19: f=
fff0000c0e30c10 x18: 0000000000000000
> > >   812 13:50:19.794834  <4>[   16.535521] x17: 000000007e4712cb x16: f=
fff80008296f800 x15: 0000000000000030
> > >   813 13:50:19.807341  <4>[   16.535532] x14: ffff0000c00b8080 x13: 0=
0000000000003f9 x12: 0000000000000000
> > >   814 13:50:19.810740  <4>[   16.535545] x11: 0000000000000000 x10: 0=
000000000000aa0 x9 : ffff800082b8bb20
> > >   815 13:50:19.822528  <4>[   16.535559] x8 : ffff0000c00b8b00 x7 : 0=
000000000000000 x6 : ffff0000c00b8000
> > >   816 13:50:19.827173  <4>[   16.535570] x5 : ffff8000836b0000 x4 : f=
fff0000c2f3a488 x3 : ffff8000813660d0
> > >   817 13:50:19.838446  <4>[   16.535583] x2 : 0000000000000004 x1 : 0=
000000000000001 x0 : 00000000ff777777
> > >   818 13:50:19.839321  <0>[   16.535597] Kernel panic - not syncing: =
Asynchronous SError Interrupt
> > >   819 13:50:19.839983  Matched prompt #9: Kernel panic - not syncing
> > >   820 13:50:19.840155  Setting prompt string to ['end Kernel panic[^\=
\r]*\\r', '/ #', 'Login timed out', 'Login incorrect']
> > >   821 13:50:19.854524  <4>[   16.535601] CPU: 2 PID: 1 Comm: swapper/=
0 Not tainted 6.9.0-rc5-next-20240424 #1
> > >   822 13:50:19.855261  <4>[   16.535609] Hardware name: Toradex Verdi=
n iMX8M Plus on Dahlia Board (DT)
> > >   823 13:50:19.858660  <4>[   16.535613] Call trace:
> > >   824 13:50:19.870455  <4>[   16.535616]  dump_backtrace+0x94/0xec
> > >   825 13:50:19.870763  <4>[   16.535626]  show_stack+0x18/0x24
> > >   826 13:50:19.871258  <4>[   16.535635]  dump_stack_lvl+0x38/0x90
> > >   827 13:50:19.874714  <4>[   16.535647]  dump_stack+0x18/0x24
> > >   828 13:50:19.874964  <4>[   16.535656]  panic+0x388/0x3c8
> > >   829 13:50:19.886551  <4>[   16.535667]  nmi_panic+0x48/0x94
> > >   830 13:50:19.888318  <4>[   16.535679]  arm64_serror_panic+0x6c/0x7=
8
> > >   831 13:50:19.888531  <4>[   16.535688]  do_serror+0x3c/0x78
> > >   832 13:50:19.892592  <4>[   16.535693]  el1h_64_error_handler+0x30/=
0x48
> > >   833 13:50:19.902540  <4>[   16.535703]  el1h_64_error+0x64/0x68
> > >   834 13:50:19.903437  <4>[   16.535709]  clk_imx8mp_audiomix_runtime=
_resume+0x24/0x48
> > >   835 13:50:19.907712  <4>[   16.535719]  __genpd_runtime_resume+0x30=
/0xa8
> > >   836 13:50:19.918505  <4>[   16.535729]  genpd_runtime_resume+0xb4/0=
x29c
> > >   837 13:50:19.918770  <4>[   16.535741]  __rpm_callback+0x48/0x198
> > >   838 13:50:19.919372  <4>[   16.535749]  rpm_callback+0x68/0x74
> > >   839 13:50:19.922715  <4>[   16.535754]  rpm_resume+0x3cc/0x680
> > >   840 13:50:19.934495  <4>[   16.535762]  __pm_runtime_resume+0x4c/0x=
90
> > >   841 13:50:19.934784  <4>[   16.535769]  clk_pm_runtime_get_all+0x58=
/0x164
> > >   842 13:50:19.935344  <4>[   16.535780]  clk_disable_unused+0x2c/0x1=
78
> > >   843 13:50:19.938873  <4>[   16.535793]  do_one_initcall+0x6c/0x1b0
> > >   844 13:50:19.950539  <4>[   16.535799]  kernel_init_freeable+0x1c8/=
0x290
> > >   845 13:50:19.951360  <4>[   16.535812]  kernel_init+0x20/0x1dc
> > >   846 13:50:19.951585  <4>[   16.535821]  ret_from_fork+0x10/0x20
> > >   847 13:50:19.954803  <2>[   16.535831] SMP: stopping secondary CPUs
> > >   848 13:50:19.966688  <0>[   16.535838] Kernel Offset: disabled
> > >   849 13:50:19.967221  <0>[   16.535841] CPU features: 0x0,00000040,0=
0100000,4200421b
> > >   850 13:50:19.967360  <0>[   16.535845] Memory Limit: none
> > >   851 13:50:19.985117  <0>[   16.788060] ---[ end Kernel panic - not =
syncing: Asynchronous SError Interrupt ]---
> > >
> > > from
> > >
> > > https://storage.kernelci.org/next/master/next-20240424/arm64/defconfi=
g/gcc-10/lab-broonie/baseline-imx8mp-verdin-nonwifi-dahlia.html
> > > https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com=
/
> > >
> >
> > Sorry that I didn't use a clean community kernel for the test.
>
> :/ I have asked you if you have tested this feature since I was aware of
> bugs regarding PM.

But the issue you encountered is the "clock-prepare lock" as I remember.
I think it is a different one.

>
> > On my local side I added delay in drivers/pmdomain/imx/gpcv2.c
> > so there was no such issue.
> >
> > But according to drivers/pmdomain/imx/gpcv2.c, seems that I need
> > to add delay in this driver, like this:
>
> "Seems" shouldn't be really a "The root cause for this is".

I should not use 'Seems':)

below is I find in drivers/pmdomain/imx/gpcv2.c.  the commented code:

        /* request the ADB400 to power up */
        if (domain->bits.hskreq) {
                regmap_update_bits(domain->regmap, domain->regs->hsk,
                                   domain->bits.hskreq, domain->bits.hskreq=
);

                /*
                 * ret =3D regmap_read_poll_timeout(domain->regmap,
domain->regs->hsk, reg_val,
                 *                                (reg_val &
domain->bits.hskack), 0,
                 *                                USEC_PER_MSEC);
                 * Technically we need the commented code to wait
handshake. But that needs
                 * the BLK-CTL module BUS clk-en bit being set.
                 *
                 * There is a separate BLK-CTL module and we will have
such a driver for it,
                 * that driver will set the BUS clk-en bit and
handshake will be triggered
                 * automatically there. Just add a delay and suppose
the handshake finish
                 * after that.
                 */
        }

Best regards
Shengjiu Wang
>
> Regards,
>   Marco
>
> >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> >  {
> > +       /*
> > +        * According to the drivers/pmdomain/imx/gpcv2.c
> > +        * need to wait for reset to propagate
> > +        */
> > +       udelay(5);
> > +
> >
> > I will submit a patch for it.
> >
> > Thanks for reporting it
> >
> > Best regards
> > Shengjiu Wang
> >
> >
> >
> > > Francesco
> > >
> >
> >

