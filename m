Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5287DA335
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbjJ0WLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346646AbjJ0WLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A81B5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:11:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-280208d0679so366799a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698444681; x=1699049481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BeMmTUq4g79fi5qvKPQNKqlrDCYL6ILFRVsuXdyovg=;
        b=DsXpxg6LUigg1Qh0zB/bULL+NZLfdsOuOhCpb2MtKfM36fzfG/gr7W3312N3+tOK5D
         wY52t3eWA02DTcwrSSoQQoFAqh2NTIfoAkZqoIlSOS5E6x7qHaAeze+7FXmDwR+NRcFN
         a3b/ekUva/l6VBW9Fo+MScppfwzU5HT+/zo8YDpVYA2oCjVgM4Ypg9Kppf5GGVMVktxu
         O9UXYnG37WOXEuU5mKbCNOcdjrojh2+uWTLtUAphSNaZvnwbceESpl6MPraMM0fhYJah
         bF1JFN74XwZQFyUxQHCaw7ll2fOXyayg0tgXgwMNgxPSp5pgRbEL7/J/3y8TI/rO4kjp
         risg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444681; x=1699049481;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BeMmTUq4g79fi5qvKPQNKqlrDCYL6ILFRVsuXdyovg=;
        b=gqFuspiwUFLpeFQQrPEhJY6glHlh0oGpOD8qYW1ptrmcZaT2vGVZBFku+pfOxXn4fT
         ctpoH4KnfHJ6wiyX6O9KHgtjKiwavcEMpt4JF9gncA9ur+73mtrT8rgb4qwY7Hh7VhBQ
         SOERNL6sVmwzd0X2L0OiFWmGp/+yjony5/dILNHLcft5BXp9tIVPqn9tbI/51kJr8bPU
         DlnIH7gFDOUgQZ6Jo3xTrNTqfm6TLLZSb/UEihZi8BWeTvoe9ebIMzuGz4cQb421GBCb
         XPg1f57qhse+RBgDSOJftIgTz3eUGCmizJbj/3XJKEXe1L2YcvkOGMSyCx1kHa0zb85g
         7RzA==
X-Gm-Message-State: AOJu0YzMy0RGjJpq6ABQOC0U9fV7CVGoBrST2dcJnq2wyiVvkI16tsIb
        O3xlfoPd5lUB0PdyBVn7l5jorA==
X-Google-Smtp-Source: AGHT+IE1Wiqht/oK+k4UaYWOU/6pE6Hl+IiCQQO9vWsJnMAPyBXGS9dG+jErM5PM3/N2wY/7M/7IWg==
X-Received: by 2002:a17:90b:1904:b0:280:16bb:8169 with SMTP id mp4-20020a17090b190400b0028016bb8169mr1783191pjb.40.1698444681014;
        Fri, 27 Oct 2023 15:11:21 -0700 (PDT)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002800b26dbc1sm1901952pjd.32.2023.10.27.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:11:20 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:11:20 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Oct 2023 15:11:17 PDT (-0700)
Subject:     Re: [PATCH 5/5] riscv: configs: defconfig: Enable configs required for RZ/Five SoC
In-Reply-To: <CAMuHMdVdWzK_MRz+NeZ_mx=NcH9_EF-B0At=YsOfOABLV3B9tg@mail.gmail.com>
CC:     prabhakar.csengg@gmail.com, magnus.damm@gmail.com,
        conor+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-ac92041d-85e9-4725-b61c-bc0fef5549ec@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 05:34:13 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Prabhakar,
>
> On Fri, Sep 29, 2023 at 2:07 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> Enable the configs required by the below IP blocks which are
>> present on RZ/Five SoC:
>> * ADC
>> * CANFD
>> * DMAC
>> * eMMC/SDHI
>> * OSTM
>> * RAVB (+ Micrel PHY)
>> * RIIC
>> * RSPI
>> * SSI (Sound+WM8978 codec)
>> * Thermal
>> * USB (PHY/RESET/OTG)
>>
>> Along with the above some core configs are enabled too,
>> -> CPU frequency scaling as RZ/Five does support this.
>> -> MTD is enabled as RSPI can be connected to flash chips
>> -> Enabled I2C chardev so that it enables userspace to read/write
>>    i2c devices (similar to arm64)
>> -> Thermal configs as RZ/Five SoC does have thermal unit
>> -> GPIO regulator as we might have IP blocks for which voltage
>>    levels are controlled by GPIOs
>> -> OTG configs as RZ/Five USB can support host/function
>> -> Gadget configs so that we can test USB function (as done in arm64
>>    all the gadget configs are enabled)
>>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> As I expect this to go in through the RISC-V tree, I will let the
> RISC-V people handle any discussion about more options that should be
> made modular instead of builtin.

I'm pretty much agnostic on that front, so I'm cool just picking up 
this.  I've got just patch 5 in my queue for testing, there's a few 
other things in front of it but it should show up on for-next soon.

>
> Gr{oetje,eeting}s,
>
>                         Geert
