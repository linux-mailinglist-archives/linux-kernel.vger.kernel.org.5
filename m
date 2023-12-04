Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28B80378D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjLDOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:51:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E4100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:51:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1EDC433C8;
        Mon,  4 Dec 2023 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701701509;
        bh=RHSkQPErtXOGynynU6cls9Ekhhdmw6a+NWa6Doy47Vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gz5KAAHEpkA55LnHXoy2dY9ywU4FOE/FsF1Xrc3fzqeD8X74E81v1CdonGf4sYH1Q
         qcUWkfHOAuSQpLgRxGjayjvEpNbZGvoo2uH40glcD6WNJaMZTjg+e+VTzS1RvjTaz0
         7gYiCDXRRuIdzGTIbBHfDbOZu73z3AUjhgXEPFzTrT1yoMtxRIDvonmumVhp7ayWnD
         lXYk+7RshlJnVpYy31Y1kdr3bUPT70V33PCHAnUqStfBX5IxD6WjTa3f4NXNVyHyYk
         fFmhrWzMfpPGHl5NLy/walqv5jgX/HAjuueGPELgY36wefgW/5LCGQZCyzhGxQQEIl
         5f7XUR4oWC7zA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54cfd70b2dcso200584a12.3;
        Mon, 04 Dec 2023 06:51:49 -0800 (PST)
X-Gm-Message-State: AOJu0Ywdg8G+P82lW3QQykGGabU+82JQsyADly2PvueGRbPqOLEt1ryW
        6tYR7z9pTCESWNT02AMy4sjwXsc5rih5wFDNTsI=
X-Google-Smtp-Source: AGHT+IELcPLdvLiOUwtkWJqyqDDGwXbrJTEzfqOVdsfOnj1dSecZgP2VatsCQG2lhAHeBHTBnq77zxNog2lye4nv1E4=
X-Received: by 2002:a17:906:5358:b0:a19:a19b:c737 with SMTP id
 j24-20020a170906535800b00a19a19bc737mr3083142ejo.135.1701701507976; Mon, 04
 Dec 2023 06:51:47 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953669C097D9C9E24B549FFBB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953669C097D9C9E24B549FFBB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 4 Dec 2023 22:51:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkixZf6mhQjPky+81fV6a+rx32xtZ3JC90cu4iXf5bFQ@mail.gmail.com>
Message-ID: <CAJF2gTRkixZf6mhQjPky+81fV6a+rx32xtZ3JC90cu4iXf5bFQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: separate sg2042 mtime and
 mtimecmp to fit aclint format
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 5:51=E2=80=AFPM Inochi Amaoto <inochiama@outlook.com=
> wrote:
>
> Change the timer layout in the dtb to fit the format that needed by
> the SBI.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tr=
ee")
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
>  1 file changed, 48 insertions(+), 32 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts=
/sophgo/sg2042.dtsi
> index 93256540d078..ead1cc35d88b 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
>                                               <&cpu63_intc 3>;
>                 };
>
> -               clint_mtimer0: timer@70ac000000 {
> +               clint_mtimer0: timer@70ac004000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac000000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac004000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu0_intc 7>,
>                                               <&cpu1_intc 7>,
>                                               <&cpu2_intc 7>,
>                                               <&cpu3_intc 7>;
>                 };
>
> -               clint_mtimer1: timer@70ac010000 {
> +               clint_mtimer1: timer@70ac014000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac010000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac014000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu4_intc 7>,
>                                               <&cpu5_intc 7>,
>                                               <&cpu6_intc 7>,
>                                               <&cpu7_intc 7>;
>                 };
>
> -               clint_mtimer2: timer@70ac020000 {
> +               clint_mtimer2: timer@70ac024000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac020000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac024000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu8_intc 7>,
>                                               <&cpu9_intc 7>,
>                                               <&cpu10_intc 7>,
>                                               <&cpu11_intc 7>;
>                 };
>
> -               clint_mtimer3: timer@70ac030000 {
> +               clint_mtimer3: timer@70ac034000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac030000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac034000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu12_intc 7>,
>                                               <&cpu13_intc 7>,
>                                               <&cpu14_intc 7>,
>                                               <&cpu15_intc 7>;
>                 };
>
> -               clint_mtimer4: timer@70ac040000 {
> +               clint_mtimer4: timer@70ac044000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac040000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac044000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu16_intc 7>,
>                                               <&cpu17_intc 7>,
>                                               <&cpu18_intc 7>,
>                                               <&cpu19_intc 7>;
>                 };
>
> -               clint_mtimer5: timer@70ac050000 {
> +               clint_mtimer5: timer@70ac054000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac050000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac054000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu20_intc 7>,
>                                               <&cpu21_intc 7>,
>                                               <&cpu22_intc 7>,
>                                               <&cpu23_intc 7>;
>                 };
>
> -               clint_mtimer6: timer@70ac060000 {
> +               clint_mtimer6: timer@70ac064000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac060000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac064000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu24_intc 7>,
>                                               <&cpu25_intc 7>,
>                                               <&cpu26_intc 7>,
>                                               <&cpu27_intc 7>;
>                 };
>
> -               clint_mtimer7: timer@70ac070000 {
> +               clint_mtimer7: timer@70ac074000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac070000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac074000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu28_intc 7>,
>                                               <&cpu29_intc 7>,
>                                               <&cpu30_intc 7>,
>                                               <&cpu31_intc 7>;
>                 };
>
> -               clint_mtimer8: timer@70ac080000 {
> +               clint_mtimer8: timer@70ac084000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac080000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac084000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu32_intc 7>,
>                                               <&cpu33_intc 7>,
>                                               <&cpu34_intc 7>,
>                                               <&cpu35_intc 7>;
>                 };
>
> -               clint_mtimer9: timer@70ac090000 {
> +               clint_mtimer9: timer@70ac094000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac090000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac094000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu36_intc 7>,
>                                               <&cpu37_intc 7>,
>                                               <&cpu38_intc 7>,
>                                               <&cpu39_intc 7>;
>                 };
>
> -               clint_mtimer10: timer@70ac0a0000 {
> +               clint_mtimer10: timer@70ac0a4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0a0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0a4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu40_intc 7>,
>                                               <&cpu41_intc 7>,
>                                               <&cpu42_intc 7>,
>                                               <&cpu43_intc 7>;
>                 };
>
> -               clint_mtimer11: timer@70ac0b0000 {
> +               clint_mtimer11: timer@70ac0b4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0b0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0b4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu44_intc 7>,
>                                               <&cpu45_intc 7>,
>                                               <&cpu46_intc 7>,
>                                               <&cpu47_intc 7>;
>                 };
>
> -               clint_mtimer12: timer@70ac0c0000 {
> +               clint_mtimer12: timer@70ac0c4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0c0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0c4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu48_intc 7>,
>                                               <&cpu49_intc 7>,
>                                               <&cpu50_intc 7>,
>                                               <&cpu51_intc 7>;
>                 };
>
> -               clint_mtimer13: timer@70ac0d0000 {
> +               clint_mtimer13: timer@70ac0d4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0d0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0d4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu52_intc 7>,
>                                               <&cpu53_intc 7>,
>                                               <&cpu54_intc 7>,
>                                               <&cpu55_intc 7>;
>                 };
>
> -               clint_mtimer14: timer@70ac0e0000 {
> +               clint_mtimer14: timer@70ac0e4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0e0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0e4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu56_intc 7>,
>                                               <&cpu57_intc 7>,
>                                               <&cpu58_intc 7>,
>                                               <&cpu59_intc 7>;
>                 };
>
> -               clint_mtimer15: timer@70ac0f0000 {
> +               clint_mtimer15: timer@70ac0f4000 {
>                         compatible =3D "sophgo,sg2042-aclint-mtimer", "th=
ead,c900-aclint-mtimer";
> -                       reg =3D <0x00000070 0xac0f0000 0x00000000 0x00007=
ff8>;
> +                       reg =3D <0x00000070 0xac0f4000 0x00000000 0x0000c=
000>;
> +                       reg-names =3D "mtimecmp";
>                         interrupts-extended =3D <&cpu60_intc 7>,
>                                               <&cpu61_intc 7>,
>                                               <&cpu62_intc 7>,
> --
> 2.43.0
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
