Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A77B154E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjI1Hsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjI1Hsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:48:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C692;
        Thu, 28 Sep 2023 00:48:37 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65af1037ca8so54080976d6.2;
        Thu, 28 Sep 2023 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695887316; x=1696492116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kuf9lKPBLXFO99XEA7Zpn0AwyKHANLiyZjv73Ko4GuQ=;
        b=L1YYVoHm+2gs/30uQ7zEFqRzS/4oQNXXbN/3MgKOFN61jMVkBlzSpNLrin+boq9p6f
         319SWjMtnXG1uzXi+Gaq0VuQuA61MfPvEKcW0paBV1R17VdqGpIOMVn+lARlhY4m3iEA
         +JR0HLBDOvAK0Z/mBpurogE0/jVd2SG0Y6eAaeEz/l03VCqgD0+TPK++AO0oZYuzuOVg
         fXaKKDQMYTqVQccNQG8f2LKtfOxfQjU0Gvp8O4sJHdWgewz4ZkpLW+zgD07LaFB/Zpzf
         IQldq4IH2so8mE6onBaLIP8xSOUhS6zFXuUZjW6JBIYPp3/H+Z32IgypL01lL5UaKfqO
         LIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695887316; x=1696492116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kuf9lKPBLXFO99XEA7Zpn0AwyKHANLiyZjv73Ko4GuQ=;
        b=p8BGkEV32fNfTw4kZuUt5WWOpivHolwhUQJbO9vxcNlbw7oW4mwbeiedmI2chYqC6+
         7Hm8GB0JFzoQMkw0V7XGTFmTTMkve4VOLyuZAtBzyjhDvyk7CgdqHZ4l711cDRW/jMYR
         W3FM/tADxUT5flBpxuG7E4XPQdCSTo4hxpQ+s+VePW72IBj8qTeXTFMKb1tKlo9kYgX1
         ynovKUUn9uJAbOub1vBpyAJnJaLMJvD4wjp3U8/xB+EdQ92bQnTflsjsYDA757oadeb9
         68JbB3+IZg/fIbeD97pUs4C1m8tcL2yaJCthIqqSJlRuX00XOTGhKddWshy30MJjSmk/
         /45A==
X-Gm-Message-State: AOJu0YyiNkPv5b1g2n1u/MJXheP3HmDSrnuLJCDqUUgvf5ECpnenxgKR
        EiFg48IQJZUH7rWNNmiZtPRVmgHLtpohop2eIcQ=
X-Google-Smtp-Source: AGHT+IF1bP1VCr5f+pdcsycs9fnFccmUeuSWQpBqzPdqd7DS7qCrPbNO06XQFpq9hTt55EwSzuhf9h8Z6tpiUSDKSfY=
X-Received: by 2002:a05:6214:5d8f:b0:65b:1c7c:5ad3 with SMTP id
 mf15-20020a0562145d8f00b0065b1c7c5ad3mr471467qvb.15.1695887316024; Thu, 28
 Sep 2023 00:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695804418.git.unicornxw@gmail.com> <20230927-ebony-duress-44ff45d3d253@spud>
 <CAHAQgRC2xeqUu4mDZRJd3brcPNT4KovX65rNE7YXm+ku0+eERg@mail.gmail.com>
In-Reply-To: <CAHAQgRC2xeqUu4mDZRJd3brcPNT4KovX65rNE7YXm+ku0+eERg@mail.gmail.com>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 28 Sep 2023 15:48:24 +0800
Message-ID: <CAHAQgRDz=Gp45ZkyW1fZiZW7+EyxDzbqKkc56XOpCpZ7x1rJeQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add Milk-V Pioneer RISC-V board support
To:     Conor Dooley <conor@kernel.org>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Wang <unicornxw@gmail.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8828=E6=97=A5=
=E5=91=A8=E5=9B=9B 07:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:09=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hey,
> >
> > On Wed, Sep 27, 2023 at 04:54:38PM +0800, Chen Wang wrote:
> > > Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 =
[2]
> > > in a standard mATX form factor. Add minimal device
> > > tree files for the SG2042 SOC and the Milk-V Pioneer board.
> > >
> > > Now only support basic uart drivers to boot up into a basic console.
> > >
> > > Thanks,
> > > Chen
> > >
> > > ---
> > >
> > > Changes in v3:
> > >   The patch series is based on v6.6-rc1. You can simply review or tes=
t
> > >   the patches at the link [5].
> > >   - add new vendor specific compatible strings to identify timer/mswi=
 for sg2042 clint
> > >   - updated maintainers info. for sophgo devicetree
> > >   - remove the quirk changes for uart
> > >   - updated dts, such as:
> > >     - add "riscv,isa-base"/"riscv,isa-extensions" for cpus
> > >     - update l2 cache node's name
> > >     - remove memory and pmu nodes
> > >   - fixed other issues as per input from reviewers.
> >
> > v3 looks better indeed. I had some comments on the bindings and dt
> > patches, but none were particularly major.
> >
> > Thanks,
> > Conor.
> >
> Thanks, Conor, I will continue imrpoving according to your commnents.
>

hi, Conor, one more question, what base should I take for next v4? I'm
still using 6.6-rc1 and I see 6.6-rc3 has been released out.

> > >
> > > Changes in v2:
> > >   The patch series is based on v6.6-rc1. You can simply review or tes=
t
> > >   the patches at the link [4].
> > >   - Improve format for comment of commitments as per input from last =
review.
> > >   - Improve format of DTS as per input from last review.
> > >   - Remove numa related stuff from DTS. This part is just for optimiz=
ation, may
> > >     add it later if really needed.
> > >
> > > Changes in v1:
> > >    The patch series is based on v6.6-rc1. Due to it is not sent in th=
read,
> > >    I have listed permlinks of the patchset [v1-0/12] ~ [v1-12/12] her=
e for
> > >    quick reference. You can simply review or test the patches at the =
link [3].
> > >
> > > [1]: https://milkv.io/pioneer
> > > [2]: https://en.sophgo.com/product/introduce/sg2042.html
> > > [3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mi=
nimal
> > > [4]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mi=
nimal-v2
> > > [5]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-mi=
nimal-v3
> > > [v1-0/12]:https://lore.kernel.org/linux-riscv/20230915070856.117514-1=
-wangchen20@iscas.ac.cn/
> > > [v1-1/12]:https://lore.kernel.org/linux-riscv/20230915071005.117575-1=
-wangchen20@iscas.ac.cn/
> > > [v1-2/12]:https://lore.kernel.org/linux-riscv/20230915071409.117692-1=
-wangchen20@iscas.ac.cn/
> > > [v1-3/12]:https://lore.kernel.org/linux-riscv/20230915072242.117935-1=
-wangchen20@iscas.ac.cn/
> > > [v1-4/12]:https://lore.kernel.org/linux-riscv/20230915072333.117991-1=
-wangchen20@iscas.ac.cn/
> > > [v1-5/12]:https://lore.kernel.org/linux-riscv/20230915072358.118045-1=
-wangchen20@iscas.ac.cn/
> > > [v1-6/12]:https://lore.kernel.org/linux-riscv/20230915072415.118100-1=
-wangchen20@iscas.ac.cn/
> > > [v1-7/12]:https://lore.kernel.org/linux-riscv/20230915072431.118154-1=
-wangchen20@iscas.ac.cn/
> > > [v1-8/12]:https://lore.kernel.org/linux-riscv/20230915072451.118209-1=
-wangchen20@iscas.ac.cn/
> > > [v1-9/12]:https://lore.kernel.org/linux-riscv/20230915072517.118266-1=
-wangchen20@iscas.ac.cn/
> > > [v1-10/12]:https://lore.kernel.org/linux-riscv/20230915072558.118325-=
1-wangchen20@iscas.ac.cn/
> > > [v1-11/12]:https://lore.kernel.org/linux-riscv/20230915072624.118388-=
1-wangchen20@iscas.ac.cn/
> > > [v1-12/12]:https://lore.kernel.org/linux-riscv/20230915072653.118448-=
1-wangchen20@iscas.ac.cn/
> > >
> > > ---
> > >
> > > Chen Wang (9):
> > >   riscv: Add SOPHGO SOC family Kconfig support
> > >   dt-bindings: vendor-prefixes: add milkv/sophgo
> > >   dt-bindings: riscv: add sophgo sg2042 bindings
> > >   dt-bindings: riscv: Add T-HEAD C920 compatibles
> > >   dt-bindings: interrupt-controller: Add Sophgo SG2042 PLIC
> > >   MAINTAINERS: add two files to sophgo devicetrees entry
> > >   riscv: dts: add initial Sophgo SG2042 SoC device tree
> > >   riscv: dts: sophgo: add Milk-V Pioneer board device tree
> > >   riscv: defconfig: enable SOPHGO SoC
> > >
> > > Inochi Amaoto (2):
> > >   dt-bindings: timer: Add Sophgo sg2042 CLINT timer
> > >   dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
> > >
> > >  .../sifive,plic-1.0.0.yaml                    |    1 +
> > >  .../sophgo,sg2042-clint-mswi.yaml             |   42 +
> > >  .../devicetree/bindings/riscv/cpus.yaml       |    1 +
> > >  .../devicetree/bindings/riscv/sophgo.yaml     |   28 +
> > >  .../timer/sophgo,sg2042-clint-mtimer.yaml     |   42 +
> > >  .../devicetree/bindings/vendor-prefixes.yaml  |    4 +
> > >  MAINTAINERS                                   |    9 +
> > >  arch/riscv/Kconfig.socs                       |    5 +
> > >  arch/riscv/boot/dts/Makefile                  |    1 +
> > >  arch/riscv/boot/dts/sophgo/Makefile           |    3 +
> > >  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi   | 1880 +++++++++++++++=
++
> > >  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |   19 +
> > >  arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  325 +++
> > >  arch/riscv/configs/defconfig                  |    1 +
> > >  14 files changed, 2361 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-contr=
oller/sophgo,sg2042-clint-mswi.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.ya=
ml
> > >  create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg=
2042-clint-mtimer.yaml
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.d=
ts
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > >
> > >
> > > base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> > > --
> > > 2.25.1
> > >
