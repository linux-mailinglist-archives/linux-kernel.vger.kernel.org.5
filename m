Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4E75BDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGUFXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGUFXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:23:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7EBB4;
        Thu, 20 Jul 2023 22:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 835D160C8E;
        Fri, 21 Jul 2023 05:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2856BC433C8;
        Fri, 21 Jul 2023 05:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689916983;
        bh=7TI6tqB7E156y5x5qr+a0YCtqayJkxGxgLppwFI6wGc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hoZvho3/t8C4yvC1181/KnR0Dorlwx89i8XjOkchiHrzslAp2gnwdBvWw5KzTPyyS
         b4cTGyVVh9IYcDCvejanjDZ6xN23qDa5edotrxNxzEtj1wtsy3CrDEze0GcW6H82WA
         bxi+vw+qk/GCycXczgkIi5MybagHwDZ+XB8YNefxME0aKuwW0qqMpc6X6LfOEn15v4
         1+cfCP/mbD9CiaVHcyVvy2C8vGVGdOkkhNnZ9DStZ9ssX+nAdd7XdwQMeWX3sHQg65
         oQYd73/ZbSKCALoWMHC81ovpKLvLhXrc5x6T5/0yhpbLdue79zsqI0OdHsSOeWsYiP
         veGSpA7y22tyg==
Date:   Fri, 21 Jul 2023 06:23:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Samin <samin.guo@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
Subject: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
User-Agent: K-9 Mail for Android
In-Reply-To: <42beaf41-947e-f585-5ec1-f1710830e556@starfivetech.com>
References: <20230714104521.18751-1-samin.guo@starfivetech.com> <20230720-cardstock-annoying-27b3b19e980a@spud> <42beaf41-947e-f585-5ec1-f1710830e556@starfivetech.com>
Message-ID: <A0012BE7-8947-49C8-8697-1F879EE7B0B7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 July 2023 03:09:19 IST, Guo Samin <samin=2Eguo@starfivetech=2Ecom> w=
rote:
>
>
>-------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
>=E4=B8=BB=E9=A2=98: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH=
7110 SoC
>From: Conor Dooley <conor@kernel=2Eorg>
>=E6=94=B6=E4=BB=B6=E4=BA=BA: Conor Dooley <conor@kernel=2Eorg>, Rob Herri=
ng <robh+dt@kernel=2Eorg>, Krzysztof Kozlowski <krzysztof=2Ekozlowski+dt@li=
naro=2Eorg>, Paul Walmsley <paul=2Ewalmsley@sifive=2Ecom>, Palmer Dabbelt <=
palmer@dabbelt=2Ecom>, Albert Ou <aou@eecs=2Eberkeley=2Eedu>, Hal Feng <hal=
=2Efeng@starfivetech=2Ecom>, linux-kernel@vger=2Ekernel=2Eorg, linux-riscv@=
lists=2Einfradead=2Eorg, devicetree@vger=2Ekernel=2Eorg, netdev@vger=2Ekern=
el=2Eorg, Samin Guo <samin=2Eguo@starfivetech=2Ecom>
>=E6=97=A5=E6=9C=9F: 2023/7/21
>
>> From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>=20
>> On Fri, 14 Jul 2023 18:45:19 +0800, Samin Guo wrote:
>>> This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
>>> and has been tested on StarFive VisionFive-2 v1=2E2A and v1=2E3B SBC b=
oards=2E
>>>
>>> The first patch adds ethernet nodes for jh7110 SoC, the second patch
>>> adds ethernet nodes for visionfive 2 SBCs=2E
>>>
>>> This series relies on xingyu's syscon patch[1]=2E
>>> For more information and support, you can visit RVspace wiki[2]=2E
>>>
>>> [=2E=2E=2E]
>>=20
>> Applied to riscv-dt-for-next, thanks!
>>=20
>> [1/2] riscv: dts: starfive: jh7110: Add ethernet device nodes
>>       https://git=2Ekernel=2Eorg/conor/c/1ff166c97972
>> [2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac and=
 phy
>>       https://git=2Ekernel=2Eorg/conor/c/b15a73c358d1
>>=20
>> Thanks,
>> Conor=2E
>
>
>Hi Conor=EF=BC=8C
>
>Thank you so much=EF=BC=81=20
>
>There is a question about the configuration of phy that I would like to c=
onsult you=2E
>
>Latest on motorcomm PHY V5[1]: Follow Rob Herring's advice
>motorcomm,rx-xxx-driver-strength Changed to motorcomm,rx-xxx-drv-microamp=
 =2E
>V5 has already received a reviewed-by from Andrew Lunn, and it should not=
 change again=2E
>
>Should I submit another pacthes based on riscv-dt-for-next?=20

Huh, dtbs_check passed for these patches,
I didn't realise changes to the motorcomm stuff
were a dep=2E for this=2E I'll take a look later=2E

>
>[1] https://patchwork=2Ekernel=2Eorg/project/netdevbpf/cover/202307201115=
09=2E21843-1-samin=2Eguo@starfivetech=2Ecom
>
>=20
>Best regards,
>Samin
