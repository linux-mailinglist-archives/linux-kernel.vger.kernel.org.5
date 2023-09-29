Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E970B7B3127
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjI2LUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjI2LT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:19:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9DB7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695986396; x=1727522396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wd8hNfqDmjF7C1js4hPPPyB77InnQk/OjtqUahMXdE=;
  b=sYZsohgEvm/DdGnJOpSzfKL+aJUpFfdzZi/bTrIZ+GEwfFO1L8eBgclx
   XWuhbaV3Xu+iwVn+WgkgnpujLeU2kec5DNxgRN5NR2ssJGXFb6nbCu3ZM
   1eM1w8umj9KC0vPxdsNgMEUjpzFD/BAMEpYcI/c9NkyW2BaXO4F4fdmcV
   GDsZXyZ/2OP/vg2JH+ZGe8GslRIVXx2jT+xEER4g2rEomIoKrExxF4/sx
   0ZnDOVMQCUOm7cZsEqhaVPK439jj2p/5Hqo8DfdD83KTvQ2Ic73gueAxo
   jgTNlvgpibpiZLFikFwQ/HIKtJre2cnVou9pAUjwGKytNbkUqXpJFRXfK
   g==;
X-CSE-ConnectionGUID: IYH1bGf2TOSQ6Juu165OUw==
X-CSE-MsgGUID: uZW3FtkeQPCosKMKt797xA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="asc'?scan'208";a="7236322"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2023 04:19:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 29 Sep 2023 04:19:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 29 Sep 2023 04:19:50 -0700
Date:   Fri, 29 Sep 2023 12:19:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Evan Green <evan@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20230929-swarm-overhear-d3c7f69c7235@wendy>
References: <20230920193801.3035093-1-evan@rivosinc.com>
 <20230920-98a392b40f88c69e852e2c88@fedora>
 <CAOnJCUK7KTO0n_8wDYDxh2ULtEvMWF-re2dEX6nng_tX1AGgPw@mail.gmail.com>
 <CALs-HsuurXBZ2p=jYKvPq6ZMScugm5rBchttD6Wv9Mtupfx3NQ@mail.gmail.com>
 <20230920-0e2bce9821557cce8d022157@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s8A/BcJmznzPFheQ"
Content-Disposition: inline
In-Reply-To: <20230920-0e2bce9821557cce8d022157@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--s8A/BcJmznzPFheQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2023 at 11:25:02PM +0100, Conor Dooley wrote:

> Ahh great, thanks for the explanations!


Just to make it clear that the questions I had were answered,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--s8A/BcJmznzPFheQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRaywwAKCRB4tDGHoIJi
0jofAP0QFEyUKQAoRC/Kmp6Oy+LGwnwIo9OxX/4zFLNLLg3tHwEAvGw8jgsEPOcv
UFHujmQbxa/tUHBXMXcLxBne6TpNVQw=
=yL0v
-----END PGP SIGNATURE-----

--s8A/BcJmznzPFheQ--
