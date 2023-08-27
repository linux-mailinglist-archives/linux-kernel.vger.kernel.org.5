Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096B789CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjH0KX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjH0KXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23936AD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA941611F9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1262AC433C7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693131827;
        bh=QBRDRBbqDa/upH/bdJD6MbeIGMoQVvNZQPfx/+FLwSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1yC37l2EwRehoSHQKHCxwLwBOgU60Sx/rKRr4ANQuKmX6fnF3IIhCxBgZotfIOV8
         gqFDVsLH+Wg08k/S2KcJfn74C6YobycU2kVa0yTxR9B6i6n5sLTq32K9aglschmPtz
         AhZ67TqvJinl57pKSu4a1KQTuiqDtCW5zHz0BrAk3fL7X23iducdYBnl8u/RQYKU2/
         438CVePj0MdIJfXMY1M7/szaXISc0+cJ6T79zzLRPOVtJNhXv/v3gffLBSC9fWsRHT
         sRH15xvjsqfsfeZHQsgh+VQ6CS7VWecOo2VHYdMVlp+ZT9q7gh/Pchaw0Q0vhfTzz6
         GCVv+JPWQllEQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50098cc8967so3665751e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:23:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzw5BhBLlR4ocW7onmEIdg8BH9qxJqTeC7YcTiQ8PUN1tJ5NALi
        40hMfYuWaBOUilvmryNgwOFvCTj7HiIotpY6b2U=
X-Google-Smtp-Source: AGHT+IGP9dTtLzyu4x9TSrMzTh25JOmvSlF8WmRS6bAorcnux5lKJqBeTg77Om0k0ciGcnB6Sm5SKjYo9wpo3n31do8=
X-Received: by 2002:a05:6512:32cc:b0:4ff:7e1e:b4b4 with SMTP id
 f12-20020a05651232cc00b004ff7e1eb4b4mr18759432lfg.39.1693131825050; Sun, 27
 Aug 2023 03:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230827090644.1318-1-jszhang@kernel.org>
In-Reply-To: <20230827090644.1318-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 27 Aug 2023 06:23:33 -0400
X-Gmail-Original-Message-ID: <CAJF2gTSC18XVsH+X7sn4RC_j-pWNmO+4oWz0OWtQp=vKSPC2tQ@mail.gmail.com>
Message-ID: <CAJF2gTSC18XVsH+X7sn4RC_j-pWNmO+4oWz0OWtQp=vKSPC2tQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: update T-Head memory type definitions
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 5:18=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Update T-Head memory type definitions according to C910 doc [1]
> For NC and IO, SH property isn't configurable, hardcoded as SH,
> so set SH for NOCACHE and IO.
>
> And also set bit[61](Bufferable) for NOCACHE according to the
> table 6.1 in the doc [1].
>
> Link: https://github.com/T-head-Semi/openc910 [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 7a5097202e15..9a2c780a11e9 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -126,14 +126,18 @@ enum napot_cont_order {
>
>  /*
>   * [63:59] T-Head Memory Type definitions:
> - *
> - * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-share=
able, Non-trustable
> + * bit[63] SO - Strong Order
> + * bit[62] C - Cacheable
> + * bit[61] B - Bufferable
> + * bit[60] SH - Shareable
> + * bit[59] Sec - Trustable
> + * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, No=
n-trustable
>   * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-tr=
ustable
> - * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-sha=
reable, Non-trustable
> + * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareab=
le, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | (1UL=
 << 60))
> -#define _PAGE_NOCACHE_THEAD    0UL
> -#define _PAGE_IO_THEAD         (1UL << 63)
> +#define _PAGE_NOCACHE_THEAD    ((1UL < 61) | (1UL << 60))
> +#define _PAGE_IO_THEAD         ((1UL << 63) | (1UL << 60))
Yes, SH does not affect D1, but let's keep th1520 & d1 & sg2042 with
the same definitions.

Reviewed-by: Guo Ren <guoren@kernel.org>

>  #define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL =
<< 59))
>
>  static inline u64 riscv_page_mtmask(void)
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
