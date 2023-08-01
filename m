Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBF76B462
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjHAMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjHAMGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:06:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839A1FCA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:05:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317716a4622so5115676f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690891551; x=1691496351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYXM+viaYKXI3b2wBLalCMMxAL01quBkoWhoIA0YF7E=;
        b=DVylIM1I4qmIQVgui57WAhQLG9WX/L8udh/CvxU77UjUGp5ZUYaPkp2AzvHyo9eLDD
         fO5k/E04LtA4rXG+elH9RQzkSLsfbvAXt8Ucq6eohDvaSkFBPjVbZV3JD3KjUbFWj09/
         HOi4+h4bWR+eB4ywps2Kplp2xbsHn9PfAtK8B0G5lU6oeZf7FJCZ1MwxwGOLuAtJ86fK
         Y2TqsqJfbJKtYJAPyzNBF/7xZG33EWObqREn5oYkDrDf7Q3Vlgx8JqawJNUGLaiygoV1
         zhvUiy0w1pP+/OOAsv5WpM13HCrbqktrP30BYSsAAh/XhCj2ZHJeTCTjuS1KDGqHQQsa
         YWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891551; x=1691496351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYXM+viaYKXI3b2wBLalCMMxAL01quBkoWhoIA0YF7E=;
        b=iC9uUpuVhPggDSgOVmTAjCiPptysbb1aW0iny33x37S4rZdjPXka3yfhT7e3aYW8lm
         qJMnTeB6ygcGtYNJFKrqw2+BDE3pohOC5uuiHQZCDO5YXvFw5u5a0ZqGtaJNeLuFOYB7
         K77zFmpm6ySZqxRHzF4YAMrUrXr0QypraY4BPwe7PvLcla8gtCEwOJBXo/BX5lAKu5DD
         8qGhdMxLZQET2DFK/WMDCbfz0NdlPXz36Do5UXruu61dxRULFzrz3f38w/aGTQntVSu5
         G3YXxKhxbYU3eI8zUR9Fazzz3jYzgMCTPMemj9EY0EE9EhywTxFItGfimFUWZR4GP6NX
         icFw==
X-Gm-Message-State: ABy/qLYD4022WaJX50eeum4vt15DkQCxNB92/URzit2C9DMLQD3huuJV
        0793CoyB4gCw3R6aHQr/wePmDw6c28zex527YbCeDw==
X-Google-Smtp-Source: APBJJlE93xXtEN+UjaHzDpCW3afIyCrZL42w1EbToTukkXUi0VJMMFB0bE6AJHzpRTDyiovJEP3b/kNlH8CNaMchrpg=
X-Received: by 2002:adf:fc88:0:b0:316:e249:c285 with SMTP id
 g8-20020adffc88000000b00316e249c285mr1958220wrr.71.1690891550325; Tue, 01 Aug
 2023 05:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230801111014.1432679-1-suagrfillet@gmail.com>
In-Reply-To: <20230801111014.1432679-1-suagrfillet@gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 1 Aug 2023 14:05:39 +0200
Message-ID: <CAHVXubgv1xmH7ZF9WsBQ=hYYk1PpKH5PUmYnSH1QTU-Jg1=xOA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Correct the MODULES_VADDR
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        guoren@kernel.org, sergey.matyukevich@syntacore.com,
        david@redhat.com, wangkefeng.wang@huawei.com,
        panqinglin2020@iscas.ac.cn, woodrow.shen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Tue, Aug 1, 2023 at 1:10=E2=80=AFPM Song Shuai <suagrfillet@gmail.com> w=
rote:
>
> As Documentation/riscv/vm-layout.rst describes, the 2G-sized "modules, BP=
F"
> area should lie right before the "kernel" area. But the current definitio=
n
> of MODULES_VADDR isn't consistent with that, so correct it.
>
> Before this patch, the size of "modules" from print_vm_layout() is not 2G=
.
>
> [    0.000000]      modules : 0xffffffff2ff2f000 - 0xffffffffae600000 (20=
22 MB)
> [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (10=
24 MB)
> [    0.000000]       kernel : 0xffffffffae600000 - 0xffffffffffffffff (13=
05 MB)
>
> After this patch, the size is 2G.
>
> [    0.000000]      modules : 0xffffffff3a000000 - 0xffffffffba000000 (20=
48 MB)
> [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (10=
24 MB)
> [    0.000000]       kernel : 0xffffffffba000000 - 0xffffffffffffffff (11=
19 MB)
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 75970ee2bda2..7c57e17fc758 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -53,8 +53,8 @@
>  #ifdef CONFIG_64BIT
>  /* This is used to define the end of the KASAN shadow region */
>  #define MODULES_LOWEST_VADDR   (KERNEL_LINK_ADDR - SZ_2G)
> -#define MODULES_VADDR          (PFN_ALIGN((unsigned long)&_end) - SZ_2G)
>  #define MODULES_END            (PFN_ALIGN((unsigned long)&_start))
> +#define MODULES_VADDR          (MODULES_END - SZ_2G)
>  #endif
>
>  /*
> --
> 2.20.1
>

The documentation is approximative, the modules must stay within a 2GB
window to *all* the kernel symbols, hence the __end - 2G, not __start.
