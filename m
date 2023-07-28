Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F392076608B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjG1ALP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjG1ALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:11:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599BA3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:11:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbc06f830aso10113865ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690503070; x=1691107870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqNRWVrOFVBkH+VSmfu09hLMLUWIZedxHx1Mg4rsMuQ=;
        b=d2OF3EM9KD1Gz+cvj2pCUh/1Yj5q9pjk4yeRolGJ5YrTetpr/fOe8CuP+jxce2Ukpi
         Uly+gxlwzxpflH6nRUYG5wuOd8oDmFsPt1zUs6vw0EMfQ2aLHSY4M35IW/9uFEfDiHLA
         iAOVYMVPUu8E2/VQwufyh94Gprvod9xICH9rwpwpkOwpjAGghf5ui+eulfS/tyZDKU6b
         vsp550qP7XgPuYI7mzx10za+Z73Rqj133QVRDXeyg9l49Kz3o14NeljzexJVo5CkEAoo
         YUHwS98wLbaOM0u+mKrRiI5t8sTOcEwSyHO9y/OW1Tuqinmo7beDX3HALza/PlNc1ZnB
         cFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503070; x=1691107870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqNRWVrOFVBkH+VSmfu09hLMLUWIZedxHx1Mg4rsMuQ=;
        b=XMluAsKKWZx6RvWZW8oPr/4HEkvOKx5NjbLWpbn3hs0Mt6PSEMUBqCqF/+xG3hdquX
         6xFJezoEgCznJcFQdwQT2AZyEHFsuZpU720Mf2bvfYB+udhrdGHYR1vLA8lUkIQpnQBn
         BQKGO37f4QAfnwQ+8/TZU4xxLGp+JmUtu6sgUMEKDFdbebyLEW4kHm3/bThnvbpyrp5R
         Y0fdsijf96E6s8xrjHmL7INKJPFesefP0yuuq49UrRGgZ1PYbMsrvATaakP2k82HyFeJ
         7lyW+5gSclQI4MRyH/xI/h1zS51qBg0DyCurESNWT9HNGu9ZeefFt3Z0NC1eniJepu7p
         w8EQ==
X-Gm-Message-State: ABy/qLZrXN3Wj2BHbx3aj7xJhqB0INXNdnKiM5bNHCnAodk99o4bUHCI
        mObIPVvds+aj1h3aVtcwB+oouA==
X-Google-Smtp-Source: APBJJlHiOMKTmPn4xexa7u68szd4odgOExv7eGQ9Eaq77/8uCykPj7QdZYFF40DGQ4hv5SQqsug33w==
X-Received: by 2002:a17:903:32cf:b0:1b9:d38d:efb1 with SMTP id i15-20020a17090332cf00b001b9d38defb1mr290557plr.8.1690503070496;
        Thu, 27 Jul 2023 17:11:10 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:dacb:3a1a:fcaf:c0fc])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001b8a3729c23sm2230932plg.17.2023.07.27.17.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 17:11:10 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:11:08 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZMMHnPQ5xkY2+fB+@x1>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
 <ZL/jMYL3akl78ZZN@xhacker>
 <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
 <ZME1J4mpVf5yth32@xhacker>
 <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
 <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:54:59AM +0800, Xi Ruoyao wrote:
> On Thu, 2023-07-27 at 08:14 +0800, Xi Ruoyao wrote:
> > On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> > > which dts r u using? see below.
> > > 
> > > > 
> > > > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) can
> > > > miscompile the kernel?
> > 
> > /* snip */
> > 
> > > > Boot HART ID              : 0
> > > > Boot HART Domain          : root
> > > > Boot HART Priv Version    : v1.11
> > > > Boot HART Base ISA        : rv64imafdcvx
> > > 
> > > what? I don't think the mainline dts provide v and x. 
> > 
> > I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb
> > into /boot and loaded it with u-boot "load" command onto 0x46000000, and
> > passed this address to the booti command.
> > 
> > But maybe I've copied the wrong file or made some other mistake... I'll
> > recheck.
> 
> Hmm, and if I read OpenSBI code correctly, this line reflects the
> content of the misa CSR, not the DT riscv,isa value.
> 
> The log of successful boot provided by Drew also contains
> "rv64imafdcvx":
> 
> https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6

In case it helps, the thead fork of u-boot contains an important file
include/configs/light-c910.h that defines the boot scripts for each
board. Here is the BeagleV Ahead:
https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-u-boot/-/blob/beaglev-v2020.01-1.1.2/include/configs/light-c910.h#L361

It might give some clues as to want commands to try.

From the lpi4a config:
https://github.com/revyos/thead-u-boot/blob/09e2c3f93f1a64c10ca51d9b9c0c22fbc0947c43/configs/light_lpi4a_defconfig

It looks like it sets:
CONFIG_TARGET_LIGHT_FM_C910_LPI4A=y

And that corresponds to:
https://github.com/revyos/thead-u-boot/blob/09e2c3f93f1a64c10ca51d9b9c0c22fbc0947c43/include/configs/light-c910.h#L425

Anyways, I finally got my Lichee Pi 4a out of the box, and I am going
to try it out too.

-Drew
