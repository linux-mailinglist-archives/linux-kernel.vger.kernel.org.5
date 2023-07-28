Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710ED766580
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjG1Hkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjG1Hkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:40:33 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50D88B6;
        Fri, 28 Jul 2023 00:40:32 -0700 (PDT)
Received: from localhost.localdomain (xry111.site [89.208.246.23])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 083111C1DA0;
        Fri, 28 Jul 2023 07:40:26 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690530030;
        bh=RsaZgVR72uwvhOw19h0Tmdmp2am5vB3ljes8R8nOeJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=VH0F+7bg9jMJ2mLI5Hos6uu27l4tdeae8MAIvasLxDH9v7UBPlXJ3/h+TA2fxTx4A
         di/pSQTTcIJTx1/weihtxBJdCMDEYU3ts9boYB2SZnMxzF0ZKxJ3Ul6Y5QS4Kqdkev
         ijf18AWqmAlKPMaPLqNXOW+IVoc+UrxBN8+ns4NVR0/cSeOcpNuUgL0MlBSxHH0OU0
         i/x1sFyYPFMXazcx5YoosGZhEHw41JhV9cnwWqkoajE9OFA4DO2Fjj0mdb8myDKRug
         ZUTg4XP3sxcVpQen8BiIRUm4YheoYiK1zRTc6Ns8BEubTUnWbK36Y0F0A9IjaPP9kq
         aNyxJGJt12IGA==
Message-ID: <af41edfe515373530d3d1ffc43c581131e6f6038.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Drew Fustini <dfustini@baylibre.com>
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
Date:   Fri, 28 Jul 2023 15:40:21 +0800
In-Reply-To: <ZMNojqwLxcG8FcHN@x1>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
         <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
         <ZME1J4mpVf5yth32@xhacker>
         <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
         <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
         <ZMKXQpreSr47MFj6@xhacker>
         <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
         <ZMNojqwLxcG8FcHN@x1>
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

On Fri, 2023-07-28 at 00:04 -0700, Drew Fustini wrote:
> It seems like your kernel config is the problem. I used it and I saw
> the same result of a panic in riscv_intc_irq:
> https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
>=20
> This is the config I have been using successfully:
> https://gist.github.com/pdp7/ecb34ba1e93fc6cfc4dce66d71e14f82
>=20
> Could you try that config?
>=20
> Linux 6.5-rc3 boots okay when built with it:
> https://gist.github.com/pdp7/580b072f9a5bf9be87cf88b5f81e50e3

Yes, your configuration works.

I'll try to figure out which specific configuration item is problematic
in my origin one...

