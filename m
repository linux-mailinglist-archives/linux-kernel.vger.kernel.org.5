Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533C178CDF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjH2VFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjH2VFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70B1BE;
        Tue, 29 Aug 2023 14:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1530C63AB4;
        Tue, 29 Aug 2023 21:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E68BC433CB;
        Tue, 29 Aug 2023 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693343119;
        bh=JFvftynlWSpx2Z07NIHz5LNL4Jx2zBCJhehgL9bvydA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iiB+mNUpSoyWK4nP+SYz4igNO0RzsjxQPmyX06RAeDRf/ArYKrX5rGrH5mrzm6sq2
         LmOAuiLVRFvZ55jbFT+rmpPlJar3fLlKlcG5yvby52X7+P0KEDv3KvhpJHJ43xnXSc
         X/+qkaOv45GbJReT2EG9/f+bCcL9avcrtBwMrtgnnkyp6z5Kl5b0seo67HKtr1jyxt
         paqrWQzvQOjSWmxczmguuAWqlPAm0sV5SM9FUeQTLzBba5kuKJ/sGs8qU+9PNkgdH5
         4vSPqYGsmOB7zc32FcQ4T+oiPFV0/UEPzfKOUDZ2eFlY6BZ8Iwr+divQEgSHZL7gl2
         yeSfFqh7lZ5xw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso71858411fa.2;
        Tue, 29 Aug 2023 14:05:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzx1aKRVu8zD16Nl7qaH9vugvw067lbv3d5hqLNbWM1BobLfq3r
        R9Fb72bg8UdRFC7hKcHrROg7GcdrGhRoG5h5Cg==
X-Google-Smtp-Source: AGHT+IH/2nk4OWk7vLoTXXAxI4zCPN6UHpyrVHeHQbqFQEb5An/vtxt64lCxLTzYyqgWoFhn7ZDJ4hVE8qGkaKVkpe0=
X-Received: by 2002:a2e:a16b:0:b0:2bc:c490:10cf with SMTP id
 u11-20020a2ea16b000000b002bcc49010cfmr395430ljl.18.1693343117338; Tue, 29 Aug
 2023 14:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org> <20230829191812.135759-2-sjg@chromium.org>
In-Reply-To: <20230829191812.135759-2-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Aug 2023 16:05:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKVRoB4W31yuSQxc5hVt2pV6zY9y-scqdoxKLpFpe349Q@mail.gmail.com>
Message-ID: <CAL_JsqKVRoB4W31yuSQxc5hVt2pV6zY9y-scqdoxKLpFpe349Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bring in other reserved-memory files
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        ron minnich <rminnich@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add those files from v6.5 which are already converted to yaml.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - New patch
>
>  .../schemas/reserved-memory/framebuffer.yaml  |  52 +++++++
>  .../reserved-memory/google,open-dice.yaml     |  46 ++++++
>  .../reserved-memory/memory-region.yaml        |  40 +++++
>  .../nvidia,tegra210-emc-table.yaml            |  31 ++++
>  .../nvidia,tegra264-bpmp-shmem.yaml           |  47 ++++++
>  dtschema/schemas/reserved-memory/phram.yaml   |  47 ++++++
>  .../schemas/reserved-memory/qcom,cmd-db.yaml  |  46 ++++++
>  .../reserved-memory/qcom,rmtfs-mem.yaml       |  55 +++++++
>  dtschema/schemas/reserved-memory/ramoops.yaml | 144 ++++++++++++++++++
>  .../reserved-memory/shared-dma-pool.yaml      |  97 ++++++++++++
>  10 files changed, 605 insertions(+)

I don't think I want all of these in dtschema. Certainly not vendor
specific ones. Generally, if it's not something we'd put in the spec,
then I don't want it in dtschema. The u-boot stuff so far has been an
exception.

Probably a good rule is if it has a compatible, then it doesn't go
into dtschema. Though there's some exceptions already.

>  create mode 100644 dtschema/schemas/reserved-memory/framebuffer.yaml

Maybe

>  create mode 100644 dtschema/schemas/reserved-memory/google,open-dice.yam=
l

No

>  create mode 100644 dtschema/schemas/reserved-memory/memory-region.yaml

Yes

>  create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra210-emc-=
table.yaml
>  create mode 100644 dtschema/schemas/reserved-memory/nvidia,tegra264-bpmp=
-shmem.yaml

No

>  create mode 100644 dtschema/schemas/reserved-memory/phram.yaml

Depends on mtd.yaml in the kernel, so no.

>  create mode 100644 dtschema/schemas/reserved-memory/qcom,cmd-db.yaml
>  create mode 100644 dtschema/schemas/reserved-memory/qcom,rmtfs-mem.yaml

No.

>  create mode 100644 dtschema/schemas/reserved-memory/ramoops.yaml

Probably not.

>  create mode 100644 dtschema/schemas/reserved-memory/shared-dma-pool.yaml

Maybe.

Rob
