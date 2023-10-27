Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEB7D9CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbjJ0PcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJ0PcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:32:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733131AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:31:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d8e2ac2b1so1721900a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698420714; x=1699025514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maQJijvrXIo+//hdL4s0bEnIoKNcGIK6OT+NU47ze5c=;
        b=NZcYXdXD7JvnMx2ftquH6WB3NWxD9wUfSMFutXr3hlRnFXrQ00Oo1T6ZRvQB+eaUmJ
         iR+sk+yEeop4F6Dk6acEH9xBZsInmnNZo3UET4D9PxYB2PEvZeUfk+M2cu95mSvwH6C7
         HzKKkp6scIXHMsDD7pa0cO+qNWZfT6OS/2LHX3pYF3V+PnwoLVycMKgqpdlpc5wLlVUr
         dYZ5cnnKxsrr0QD6/6tT2uvtl5RJUK6/tocZVdUUp3eUrXtW/E36JDNtLdhqdLapv6HE
         B30tyEaSBCV+f7WkdfSHTSXXSt7+p5ecrE4Z7iT9BkpSdxTk0ZONFFe2IPsjScR9ZRZo
         FzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698420714; x=1699025514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maQJijvrXIo+//hdL4s0bEnIoKNcGIK6OT+NU47ze5c=;
        b=qZixiHa5qWN7r0/1lFGhaiCOoNBfrJ2W5e4mFCOoDFh0V0GKt6hXhOJn/LpocJk5SB
         +GFE893PcZNMHtXtEW0tgrWoc/TDEenVf3O+JQnvuH+kcqSETE+3J1KWJwGaA6vh1ne7
         LuML0ZsFUaMKnOn43Dl60qGdaohFruKfcbIbR9G8mnS1VKAJynnUR1reW0uhEDJ9OzNB
         3fEo6GjzLEzbUHiEWx3cfEnOhbCC9gqGhxLdTE7bD74TVAcAtlHV/3Zokh0urYQBD/Cl
         A0zxSFjlXtBCM+BeMAHel1ymE+4Ws7sCTA3JfB4fjVN52VA8AGlnocULyjDV13XmYgv1
         OWaA==
X-Gm-Message-State: AOJu0YzIDJ2kUqUHZbvAOy/8vk6hgniA0kAbCIsf9u9zDDE007q7G/dl
        jiHrogqLcbjQ92ln7zdRljjjCG/WAaAnFawGsaZPYA==
X-Google-Smtp-Source: AGHT+IF7qOK76X37XYD3CQdQE8+KlnVfCDjte3STl/rzIVGxkqqhce9iU31fitYSyKrgl/A04RLugurjz9yHJTTksag=
X-Received: by 2002:a17:90a:5381:b0:27f:fe79:eb6c with SMTP id
 y1-20020a17090a538100b0027ffe79eb6cmr2782051pjh.29.1698420713657; Fri, 27 Oct
 2023 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142820.390238-1-apatel@ventanamicro.com>
 <20231025142820.390238-3-apatel@ventanamicro.com> <871qdg4hvm.ffs@tglx>
In-Reply-To: <871qdg4hvm.ffs@tglx>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 27 Oct 2023 21:01:42 +0530
Message-ID: <CAK9=C2VRNJGySLT8_oN=U9Pe9C9mOdPjOUr24ugXciT0Hx9pqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: property: Add fw_devlink support for msi-parent
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Oct 27, 2023 at 1:27=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Oct 25 2023 at 19:58, Anup Patel wrote:
> > This allows fw_devlink to create device links between consumers of
> > a MSI and the supplier of the MSI.
>
> How is this related to the two fixes in this series?

The first three patches of the v11 RISC-V AIA series are all
fixes hence I sent them separately for the 6.7 merge window.
(https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.c=
om/)

All three fixes are unrelated to each other and were discovered
during AIA driver development.

This patch fixes the probing order for platform devices having
inter-dependency based on "msi-parent" DT property.
For example, the AIA APLIC (wired-to-MSI bridge) platform
device depends on the AIA IMSIC (MSI controller) platform
device.

Are you okay with this patch going through the RISC-V tree ?

Regards,
Anup
