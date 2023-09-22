Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B67AB095
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjIVL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:28:20 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5091;
        Fri, 22 Sep 2023 04:28:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6562395dfcfso10210866d6.0;
        Fri, 22 Sep 2023 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382093; x=1695986893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rBjsVJMkSl70JhyO/ROwwTBjBNgLQgHdo0l8Z8Ap20=;
        b=WPtvcEvgvjzQ3THI1eD1tYD8iPbwXhGFToFbLt56Db1lVrokftfLzXHIInJqM5CD2m
         zoWmujud1168uC4iQj9KLutMjWULNJ/2wgIThVCxFHw0k4Er3PspNp1UV/HuqgSF1qM9
         JqhsZIipaJq1jgds8q1JXvK4S3wq0/8/CPpLFk4FKCjhlGEliIM2QienWOF7CrtYisAq
         c+OcU3KyiGE9dp/3wbNoxa3aX4Ye1bAaSp4fo2/K8mMd083Q/Im9mydh7tpbM38Dc8tj
         53Gd+h0YQBV4ymGQTYI2Xupnr8C/9iMbDe2Hh1Mo3onZwllMFgpYijrGM/AvqIEiyZdW
         p6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382093; x=1695986893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rBjsVJMkSl70JhyO/ROwwTBjBNgLQgHdo0l8Z8Ap20=;
        b=b8IW74jCuHiBxjJn/4Nqzej1OTxHU0tC/IzpuJZEB46WdEtEDM1gTsB2bpneUHl5Xd
         ozoh2gieN77760RsZpizC+2edQHNiVLDmMMMpD7cV9X7Mn2WG5OewyxyDhi4AA5aGo/R
         UUwdGR+iy7tfwB0XCY0jJ84g4ieY+/YqjRk2MgwGqMjq9kB3pieMKul5P6bZWob1CdDr
         Th09S/6xXmWFPTQ1LHHvYJicjOx6YE833zjdFXcM+CbUR0tgh82ckyrijDWyid8QBX+S
         8IR+8ggCEmGGAbyUeg1c1gpIWNiwgM9zSCLcemHJDshAVY8beql5K6GjCjm8g50cWbtH
         amNw==
X-Gm-Message-State: AOJu0YzS4grISxBhYzgGXep//1h6qhn1DnWA2v0CyTIhLzYGTBf9L4bc
        51mA4SZrTUI2mwJ+zR34bA362BVO/fZO+DDTBrM=
X-Google-Smtp-Source: AGHT+IH16tE9FAkcs9IIvvltSsOreUn2ppc6aDSSRKGsg4tg1TyBow5N2QaLxlqBYEfC3HdFQezg5y/ANNgBnt7ttjg=
X-Received: by 2002:a05:6214:8ed:b0:655:da42:b92a with SMTP id
 dr13-20020a05621408ed00b00655da42b92amr7359627qvb.13.1695382092989; Fri, 22
 Sep 2023 04:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <20230920-muppet-wad-ee76f3112651@wendy>
 <CAHAQgRA+uN2xG=imVe4fuSyGxjDQk-AOo4r5b4bvAcTuEewwiQ@mail.gmail.com> <20230922-salvation-splendor-61533091f87b@spud>
In-Reply-To: <20230922-salvation-splendor-61533091f87b@spud>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Fri, 22 Sep 2023 19:28:02 +0800
Message-ID: <CAHAQgRAvfcnsobn-ofdi=4RnHnS2me5izEkOxAyeM6iGsktKAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add Milk-V Pioneer RISC-V board support
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regards,

unicornx

Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=BA=94 18:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 22, 2023 at 06:24:25PM +0800, Chen Wang wrote:
> > Regards,
> >
> > unicornx
> >
> > Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 18:01=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Sep 20, 2023 at 02:33:48PM +0800, Chen Wang wrote:
> > > > Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG204=
2 [2]
> > > > in a standard mATX form factor. Add minimal device
> > > > tree files for the SG2042 SOC and the Milk-V Pioneer board.
> > >
> > > Please run dtbs_check with W=3D1 set & fix the below issues:
> > >
> > > sg2042-cpus.dtsi:1600.25-1607.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@0: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1609.25-1616.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@1: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1618.25-1625.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@2: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1627.25-1634.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@3: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1636.25-1643.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@4: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1645.25-1652.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@5: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1654.25-1661.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@6: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1663.25-1670.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@7: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1672.25-1679.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@8: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1681.25-1688.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@9: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1690.27-1697.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@10: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1699.27-1706.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@11: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1708.27-1715.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@12: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1717.27-1724.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@13: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1726.27-1733.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@14: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:1735.27-1742.5: Warning (unit_address_vs_reg): /cpus=
/l2-cache@15: node has a unit name, but no reg or ranges property
> > > sg2042-cpus.dtsi:256.15-275.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@0: duplicate unit-address (also used in node /cpus/l2-cache@0=
)
> > > sg2042-cpus.dtsi:277.15-296.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@1: duplicate unit-address (also used in node /cpus/l2-cache@1=
)
> > > sg2042-cpus.dtsi:298.15-317.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@2: duplicate unit-address (also used in node /cpus/l2-cache@2=
)
> > > sg2042-cpus.dtsi:319.15-338.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@3: duplicate unit-address (also used in node /cpus/l2-cache@3=
)
> > > sg2042-cpus.dtsi:340.15-359.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@4: duplicate unit-address (also used in node /cpus/l2-cache@4=
)
> > > sg2042-cpus.dtsi:361.15-380.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@5: duplicate unit-address (also used in node /cpus/l2-cache@5=
)
> > > sg2042-cpus.dtsi:382.15-401.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@6: duplicate unit-address (also used in node /cpus/l2-cache@6=
)
> > > sg2042-cpus.dtsi:403.15-422.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@7: duplicate unit-address (also used in node /cpus/l2-cache@7=
)
> > > sg2042-cpus.dtsi:424.15-443.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@8: duplicate unit-address (also used in node /cpus/l2-cache@8=
)
> > > sg2042-cpus.dtsi:445.15-464.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@9: duplicate unit-address (also used in node /cpus/l2-cache@9=
)
> > > sg2042-cpus.dtsi:466.17-485.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@10: duplicate unit-address (also used in node /cpus/l2-cache@=
10)
> > > sg2042-cpus.dtsi:487.17-506.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@11: duplicate unit-address (also used in node /cpus/l2-cache@=
11)
> > > sg2042-cpus.dtsi:508.17-527.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@12: duplicate unit-address (also used in node /cpus/l2-cache@=
12)
> > > sg2042-cpus.dtsi:529.17-548.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@13: duplicate unit-address (also used in node /cpus/l2-cache@=
13)
> > > sg2042-cpus.dtsi:550.17-569.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@14: duplicate unit-address (also used in node /cpus/l2-cache@=
14)
> > > sg2042-cpus.dtsi:571.17-590.5: Warning (unique_unit_address_if_enable=
d): /cpus/cpu@15: duplicate unit-address (also used in node /cpus/l2-cache@=
15)
> > >
> > > Thanks,
> > > Conor.
> >
> > I find the rootcause is due to following code in DTS:
> > ```
> >                 l2_cache0: l2-cache@0 {
> >                         compatible =3D "cache";
> >                         cache-block-size =3D <64>;
> >                         cache-level =3D <2>;
> >                         cache-size =3D <1048576>;
> >                         cache-sets =3D <1024>;
> >                         cache-unified;
> >                 };
> > ```
> > To differ 16 l2-cache controller, we add <unit-address>, but due to
> > the l2-cache controller on sg2042 has no address, no reg property is
> > added here. That's why dtbs_check warns "node has a unit name, but no
> > reg or ranges property". I just double-confirmed with sophgo
> > engineers, they  told me there is really no address for the cache
> > controller for sg2042.
> >
> > One solution I use here is to provide unique name for the l2-cache
> > node. I learn this from  "arch/arm64/boot/dts/hisilicon/hi3660.dtsi"
> > and seems this work and pass dtbs_check with W=3D1. For example:
> > ```
> >                 l2_cache0: l2-cache0 {
> >                         compatible =3D "cache";
> >                         cache-block-size =3D <64>;
> >                         cache-level =3D <2>;
> >                         cache-size =3D <1048576>;
> >                         cache-sets =3D <1024>;
> >                         cache-unified;
> >                 };
> >
> >                 l2_cache1: l2-cache1 {
> >                         compatible =3D "cache";
> >                         cache-block-size =3D <64>;
> >                         cache-level =3D <2>;
> >                         cache-size =3D <1048576>;
> >                         cache-sets =3D <1024>;
> >                         cache-unified;
> >                 };
> >                 ......
> > ```
> > But I remember as mentioned in
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devi=
cetree-basics.html#generic-names-recommendation,
> > node names should be generic. So I have two questions here:
> > - Should I use "cache-controller" instead of "l2-cache", though I see
> > "l2-cache" is used in many places but not listed in
> > devicetree-specification.
> > - Even if I replace "l2-cache" with "cache-controller", I think
> > "cache-controller0", "cache-controller1" ... are not generic name, but
> > due to sg2042 does not have address for cache controller, how to
> > handle this problem?
>
> I would go for "cache-controller-0" "cache-controller-1". Close as
> possible to the generic node name while having the required differences
> between nodes. There's already some examples in-tree (eg renesas) that
> do this.
>
> Thanks,
> Conor.

Got, thanks.
