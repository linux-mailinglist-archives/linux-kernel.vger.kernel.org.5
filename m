Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB979BC79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377621AbjIKW1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbjIKULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:11:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB69CD;
        Mon, 11 Sep 2023 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694463047; x=1695067847; i=frank-w@public-files.de;
 bh=HHmkmeHxY0x6YELBcMZPjeob1XxmshaXuwNwkwj92vI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:Referenc
 es;
 b=Iap7nAKROgCwPmgSJaT8FhHs91+z7oHAU69G6ls+/qVzqNoGrfyDZHaBLgx/H0FGpaKzJpR
 LYFmccw0XPcDmlv15+9lVD5UaJxwg/yANyTP4UKS42eepBTNUqqvd2JWz7BEToMGHGDe13rAb
 if4GTYf7GIrqXmfTvw9GSB21OHBjOjrcJZAHWdFK9sq7F4UrTeDynd7ctyNTxMyQTjd6ZUO2X
 AYLgHe3grA1iXG1ve5r1xNUuVJRK6B2l+LCLSIFfa/Fn4g7BbAhXQX1jASr579QhyXL0SuTxH
 O5Rq7DC9fU1oVHEF9udVIk3na59vHtsKw7k8n1kupn7etcgk+ipA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.151.158]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1q4Ghb3kSX-00bwPd; Mon, 11
 Sep 2023 22:10:47 +0200
Date:   Mon, 11 Sep 2023 22:10:46 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Wunderlich <linux@fw-web.de>
CC:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_arm64=3A_dts=3A_mt7986=3A_add_?= =?US-ASCII?Q?overlay_for_SATA_power_socket_on_BPI-R3?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
References: <20230901072730.13571-1-linux@fw-web.de> <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
Message-ID: <76060BF0-B432-4BB8-A5C8-39EFF3D628EA@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9L+xgTcJUdckurYVAOzn9vZIma2+w/AOEA09dsu3M0K0DzZShi7
 VMW6t5/tANLoeS4Hinp4N/v7pvljhATwL/lTUV/rWrxw3eO9SLDmTwd/tyPbl4mZdG0reVe
 FUUu7oR3lsutQgDwNwXNRkZOredEJ6fbpp0/IhKyC9+oGTFjX9rG/lwaJXUfDMbl/4z3J1g
 q5ARG/5K+J9M6iOYXFHxg==
UI-OutboundReport: notjunk:1;M01:P0:Ss/nr+jQw9E=;KQ95qghdY1pu9I5xgPu52kh2iwU
 5qVj231gP+5kSSXN4Z0SJ5EsFE2m0mpGMqEqdyxUsSFy8MIn3oCTG3z0OYRKlp7YK38y64GW2
 DHLibRH5iTfl5rjCWTuw76PdbctbUkQmJ6E/76dzmMSoKSGrsjgDE1wz6BGYOVN9wK0TbGn5H
 T05pICixPkzfU6ETBzAtcB3106/duTjXsDRdgG8cC1QTEUIKpHeBf5lYIN5Ts0dVH7hKu2OkT
 ZCgaEejYh/XXOxckIX3S6AJH6cTWPEz2H7JwNb+swKSl66QrXb6Kg99U+IsrM+D91aqnF5dQD
 N/6XMSdHuMzTjQ8BvEiqD+JxzETcvIrFKSCu6pEceRSeUaAtCRqLAjP26IL/Ap61MdmGSNynv
 LfJlVGWdD6Y+4ba65zu2qecPGJ5Ij+51rXT9eICi5upd3z3mcn+Ur2mVDYGbSAfO9NT2/+KxQ
 LMCVEGfG/fjVpE/zqVoxg1i1MZDwTSX8icHod80r5GyF265w81nz6pul4J+944YAPXtBfe7hS
 4X2hvFB7UZG8wvwPV3rBU6jYwRHb6I0faSayNUvkMn4ln0P+KVQ7spZ17tvlJB+ZkDYPmXjfX
 3nhH3+tkTnrWXQyihRESXgacVpkcfMfnSmLSudCDq8R9Lgk8eJ+m+gwvXDgVOjHERq17jF8oU
 CJX1CJD+hcmw4JD2lBHOwujuJrqpapRh3T9eHRwRaVY259Jj/wcDi0fcpYrPMdHjoE1ep/0KB
 Fjt5eI1tFaUoLFLeXyXL1cl34mAVpuNFhFqJtBcO0ngQ2311tgZX7UNm+ejJNep+3t53KucCb
 FKtRgI09Dphvz/QhN6R7fySZcgavIFgYPcJssLFRsqSGNgEnMUwkLnY3LpkAW8iy4qgOiG9YY
 N/SdjSjuMXbH76KKn5ty2cWu+zabHnhKu0Amqca77mvKJ36pwNGldiZznteKhiXTsX2lxtbBr
 lD0MtA==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11=2E September 2023 21:51:42 MESZ schrieb Rob Herring <robh+dt@kernel=
=2Eorg>:
>On Fri, Sep 1, 2023 at 2:27=E2=80=AFAM Frank Wunderlich <linux@fw-web=2Ed=
e> wrote:
>>
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>
>> Bananapi R3 has a Power socket entended for using external SATA drives=
=2E
>> This Socket is off by default but can be switched with gpio 8=2E
>>
>> Add an overlay to activate it=2E
>>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>>  =2E=2E=2E/mt7986a-bananapi-bpi-r3-sata=2Edtso         | 39 +++++++++++=
++++++++
>>  2 files changed, 40 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r=
3-sata=2Edtso
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
>> index c99c3372a4b5=2E=2E822d3e36d3df 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi=
-r3-emmc=2Edtbo
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand=2Edtbo
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor=2Edtbo
>>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd=2Edtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sata=2Edtbo
>
>The requirement for overlays is they have a target base dt in tree and
>that you apply the overlay to it=2E All these existing overlays have the
>same problem which I pointed out when you submitted them=2E Please fix
>the existing ones before adding more=2E
>
>
>Rob

Hi Rob,

i do not understand the problem as there is a target base dt=2E=2E=2Emt798=
6a-bananapi-bpi-r3=2Edtb=2E

Do you mean that overlays should be merged with basedt at compiletime?

We pack the base-dt and all overlays into one fit image and let uboot dyna=
mically select the combination to apply=2E E=2Eg=2E check if emmc is availa=
ble, if yes apply emmc overlay else the sd one,same for nand/nor=2E

Else i do not know *how* to fix as i don't see it as broken=2E

regards Frank
