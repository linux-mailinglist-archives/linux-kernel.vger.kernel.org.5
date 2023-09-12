Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA979D400
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjILOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjILOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:48:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4404118;
        Tue, 12 Sep 2023 07:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC7C433C9;
        Tue, 12 Sep 2023 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694530122;
        bh=cmSPSl39QvQWa9g5ChH12ssAtfBX5/uCF9PBN3Ez2xQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BnT6P8bqM5sL2QvwI+sVkJr7+ekVJ4PXmyVU1PffoAkwPm+tYCH40tWcw7Bzux13x
         6Cd3lBCVzIkfXm9cJz9GsXTIIA6GN7GHlykWQnWhXHPA24PKstr/Q3tWnbi5zbTzpD
         5cFJUNy6AGtRXZO4gLxHEE2JMTejmzgRVahYWoopckgqA0He8ihkoMoiNt7r75SoaS
         kqsUbiJnuzBSkjhXfPVzr+KNGzDgQ5Qs7eYBu24hEm0afOjJSrSlih5N6iQOpr09G8
         CycpQGOv0OF+ed1ptB8IfErA5e+WFWYAK+kPPQiFGNc4QdLuAb5mMOWlafz9eAey1d
         zxqB6kd25mpsA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso7266507a12.0;
        Tue, 12 Sep 2023 07:48:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGsTduYXqZa4v6jviZ0nbhgbi2G3lf8gLQ1FbxAU5P/2iXpLi9
        cQ7Tq97kuFsqNn3sxITFMi7v4iox76hJ1nTBL4U=
X-Google-Smtp-Source: AGHT+IG5b9zswugD4X5oIlujI6tqxSFWVLDmzPCygGnoR2Bhh7duf8BjBTB7sDtNDcWWXUa0Jy3dQCQyrCCHqkXwCL4=
X-Received: by 2002:a05:6402:795:b0:52a:1d9c:83f2 with SMTP id
 d21-20020a056402079500b0052a1d9c83f2mr11415348edy.23.1694530120667; Tue, 12
 Sep 2023 07:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230912072232.2455-1-jszhang@kernel.org>
In-Reply-To: <20230912072232.2455-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 22:48:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSLabt4WFgkDoHWpTuv=KTcQTK7gfNVhS-d7yHOe2fRw@mail.gmail.com>
Message-ID: <CAJF2gTTSLabt4WFgkDoHWpTuv=KTcQTK7gfNVhS-d7yHOe2fRw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 3:34=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> dma coherent, so set dma-noncoherent to reflect this fact.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Drew Fustini <dfustini@baylibre.com>
> ---
>
> Since v1:
>  - rebase on v6.6-rc1
>  - collect Tested-by tag
>
>  arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index ce708183b6f6..ff364709a6df 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -139,6 +139,7 @@ soc {
>                 interrupt-parent =3D <&plic>;
>                 #address-cells =3D <2>;
>                 #size-cells =3D <2>;
> +               dma-noncoherent;
Reviewed-by: Guo Ren <guoren@kernel.org>

>                 ranges;
>
>                 plic: interrupt-controller@ffd8000000 {
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
