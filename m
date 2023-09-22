Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9A7AAFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjIVKup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIVKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:50:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39042122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:50:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C63DC433C7;
        Fri, 22 Sep 2023 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379835;
        bh=II1IpALtM+CSWP4ja3PIzra3ILdt436ZbfinoMTMIBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLhUR8HytmqIL6L7V2IptxGBAHMpWlG/SdlcnIe5/tu0T2mNLPDil4HaXIjw6I1Mh
         7+bGG0GYtCLTIvbCrbX1vdVztobulbCE9jWjMOXJRLAwVEpmvWWDefiRlLFkeh82Q0
         JcXQIVQQk5orRD6ffbhKTlju5V9bhSfxN0+VA28OT5fiodI6Si/VoGNWsR8s7873Lt
         v1vJZjwF3eueuk1YVMrJNHgIYD4CTYSL9lkG6v0odcVyblQySaIi5RpkMir4dQ8PoD
         fCDhmbVI+J8znUxYa4dmomcPr6MUOL7UNLulbqja026MzcA/Q83KZfqx/570ZpIari
         DsNwp+FOEh0Vg==
Date:   Fri, 22 Sep 2023 11:50:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 00/11] Add Milk-V Pioneer RISC-V board support
Message-ID: <20230922-salvation-splendor-61533091f87b@spud>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-muppet-wad-ee76f3112651@wendy>
 <CAHAQgRA+uN2xG=imVe4fuSyGxjDQk-AOo4r5b4bvAcTuEewwiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DtwC+yOilvVlaIfy"
Content-Disposition: inline
In-Reply-To: <CAHAQgRA+uN2xG=imVe4fuSyGxjDQk-AOo4r5b4bvAcTuEewwiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DtwC+yOilvVlaIfy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 06:24:25PM +0800, Chen Wang wrote:
> Regards,
>=20
> unicornx
>=20
> Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 18:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Sep 20, 2023 at 02:33:48PM +0800, Chen Wang wrote:
> > > Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 =
[2]
> > > in a standard mATX form factor. Add minimal device
> > > tree files for the SG2042 SOC and the Milk-V Pioneer board.
> >
> > Please run dtbs_check with W=3D1 set & fix the below issues:
> >
> > sg2042-cpus.dtsi:1600.25-1607.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@0: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1609.25-1616.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@1: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1618.25-1625.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@2: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1627.25-1634.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@3: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1636.25-1643.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@4: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1645.25-1652.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@5: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1654.25-1661.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@6: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1663.25-1670.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@7: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1672.25-1679.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@8: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1681.25-1688.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@9: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1690.27-1697.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@10: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1699.27-1706.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@11: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1708.27-1715.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@12: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1717.27-1724.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@13: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1726.27-1733.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@14: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:1735.27-1742.5: Warning (unit_address_vs_reg): /cpus/l=
2-cache@15: node has a unit name, but no reg or ranges property
> > sg2042-cpus.dtsi:256.15-275.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@0: duplicate unit-address (also used in node /cpus/l2-cache@0)
> > sg2042-cpus.dtsi:277.15-296.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@1: duplicate unit-address (also used in node /cpus/l2-cache@1)
> > sg2042-cpus.dtsi:298.15-317.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@2: duplicate unit-address (also used in node /cpus/l2-cache@2)
> > sg2042-cpus.dtsi:319.15-338.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@3: duplicate unit-address (also used in node /cpus/l2-cache@3)
> > sg2042-cpus.dtsi:340.15-359.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@4: duplicate unit-address (also used in node /cpus/l2-cache@4)
> > sg2042-cpus.dtsi:361.15-380.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@5: duplicate unit-address (also used in node /cpus/l2-cache@5)
> > sg2042-cpus.dtsi:382.15-401.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@6: duplicate unit-address (also used in node /cpus/l2-cache@6)
> > sg2042-cpus.dtsi:403.15-422.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@7: duplicate unit-address (also used in node /cpus/l2-cache@7)
> > sg2042-cpus.dtsi:424.15-443.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@8: duplicate unit-address (also used in node /cpus/l2-cache@8)
> > sg2042-cpus.dtsi:445.15-464.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@9: duplicate unit-address (also used in node /cpus/l2-cache@9)
> > sg2042-cpus.dtsi:466.17-485.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@10: duplicate unit-address (also used in node /cpus/l2-cache@10)
> > sg2042-cpus.dtsi:487.17-506.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@11: duplicate unit-address (also used in node /cpus/l2-cache@11)
> > sg2042-cpus.dtsi:508.17-527.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@12: duplicate unit-address (also used in node /cpus/l2-cache@12)
> > sg2042-cpus.dtsi:529.17-548.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@13: duplicate unit-address (also used in node /cpus/l2-cache@13)
> > sg2042-cpus.dtsi:550.17-569.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@14: duplicate unit-address (also used in node /cpus/l2-cache@14)
> > sg2042-cpus.dtsi:571.17-590.5: Warning (unique_unit_address_if_enabled)=
: /cpus/cpu@15: duplicate unit-address (also used in node /cpus/l2-cache@15)
> >
> > Thanks,
> > Conor.
>=20
> I find the rootcause is due to following code in DTS:
> ```
>                 l2_cache0: l2-cache@0 {
>                         compatible =3D "cache";
>                         cache-block-size =3D <64>;
>                         cache-level =3D <2>;
>                         cache-size =3D <1048576>;
>                         cache-sets =3D <1024>;
>                         cache-unified;
>                 };
> ```
> To differ 16 l2-cache controller, we add <unit-address>, but due to
> the l2-cache controller on sg2042 has no address, no reg property is
> added here. That's why dtbs_check warns "node has a unit name, but no
> reg or ranges property". I just double-confirmed with sophgo
> engineers, they  told me there is really no address for the cache
> controller for sg2042.
>=20
> One solution I use here is to provide unique name for the l2-cache
> node. I learn this from  "arch/arm64/boot/dts/hisilicon/hi3660.dtsi"
> and seems this work and pass dtbs_check with W=3D1. For example:
> ```
>                 l2_cache0: l2-cache0 {
>                         compatible =3D "cache";
>                         cache-block-size =3D <64>;
>                         cache-level =3D <2>;
>                         cache-size =3D <1048576>;
>                         cache-sets =3D <1024>;
>                         cache-unified;
>                 };
>=20
>                 l2_cache1: l2-cache1 {
>                         compatible =3D "cache";
>                         cache-block-size =3D <64>;
>                         cache-level =3D <2>;
>                         cache-size =3D <1048576>;
>                         cache-sets =3D <1024>;
>                         cache-unified;
>                 };
>                 ......
> ```
> But I remember as mentioned in
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation,
> node names should be generic. So I have two questions here:
> - Should I use "cache-controller" instead of "l2-cache", though I see
> "l2-cache" is used in many places but not listed in
> devicetree-specification.
> - Even if I replace "l2-cache" with "cache-controller", I think
> "cache-controller0", "cache-controller1" ... are not generic name, but
> due to sg2042 does not have address for cache controller, how to
> handle this problem?

I would go for "cache-controller-0" "cache-controller-1". Close as
possible to the generic node name while having the required differences
between nodes. There's already some examples in-tree (eg renesas) that
do this.

Thanks,
Conor.

--DtwC+yOilvVlaIfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1xdQAKCRB4tDGHoIJi
0rSqAQC2q8Eac9WHZ0kwmpDStSPneHIuoD6unVUY6au6JrndOQD/f9i5UVKVZog+
HOK//YsxjVXAktCB3VITwmlLJ1eOPg4=
=NU7b
-----END PGP SIGNATURE-----

--DtwC+yOilvVlaIfy--
