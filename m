Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31A760CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGYI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjGYI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:27:37 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BC972688;
        Tue, 25 Jul 2023 01:27:09 -0700 (PDT)
Received: from [192.168.124.11] (unknown [61.150.43.67])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id DBBB51C1D53;
        Tue, 25 Jul 2023 08:27:01 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690273627;
        bh=3wKBJknl28jX8dkxKDD1cetC+NZBYD4bobGI4n3fNXs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Fg6Xmz4+D2Zi8+clxXo/HI51CxqO06TGtb2ZIPbxibycD0flc8IQZS67Yc+nSqgtX
         1wNDG0aqtVN9jHLa10Kj2PhFNeGzakE37RqNc/ahsQ0w/t8iGqswSJ5rZW5SHLnmkT
         aHcOEL0wUfzd/XWSk4w+brCivAnAnq6OQIkMtCMdiaTRzRMsIlpslWehQwkHh9Td+w
         u1l/TqJhp2WuoMWxP2lZpBR6glzOeGra28S7/v6kGSnTVABx4++7apy8jNkWm8FSiM
         HpJAGaWPVaLMSrW+fEPe/mVJci1qPCNXbNNR3t920RGqRHOw3AfmkDGIRlu3XgF3dV
         b6iSvKWNit8ag==
Message-ID: <6361277fb2784ef7eef88e19be23ad022f77e483.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
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
Date:   Tue, 25 Jul 2023 16:26:54 +0800
In-Reply-To: <20230725-unheard-dingy-42f0fafe7216@wendy>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 08:52 +0100, Conor Dooley wrote:
> Are you using the vendor OpenSBI? IIRC, and the lads can probably
> correct me here, you need to have an OpenSBI that contains
> https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9f=
b31623a42ced45f38ea6
> which the vendor supplied OpenSBI does not have.

I'll try OpenSBI from the upstream.

> > And this line
> >=20
> > Memory: 8145304K/8388608K available (4922K kernel code, 4786K rwdata, 2=
048K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-reserved)
> >=20
> > does not match my hardware (my board is a 16 GB DRAM variant).=C2=A0 So=
 in
> > the future we'll need multiple DTs for all the variants?
>=20
> A bootloader stage would ideally patch the DT that the kernel ends up
> getting. If you're loading your own dtb, you can do it easily in U-Boot
> after you extract it from your FIT image or whatever. I have no idea
> what the vendor U-Boot does.

The vendor ships three DTs and in uboot there are some fancy logic to
detect which should be used.

