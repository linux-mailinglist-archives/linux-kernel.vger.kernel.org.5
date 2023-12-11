Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADE80D3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjLKRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbjLKReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:34:46 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38908ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:34:52 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9d59d6676so3560548a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702316091; x=1702920891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGzPnVe+NCTMdJ+XuET4cvoiuLLibz97osrkOtPIDJM=;
        b=mjvRERpWrzqA+Pb/ppGiG9nViP5xE44t3GFGq7dwRNeIMIDBqUGICxCAUXkYePiSC0
         Rxq/7jV4oyrXlEJl3wozVPaeQZGd1KvmiWiwCfMVgwZevBLuU5PUfkkZz54iJa83tXwE
         0AENEw6xJfhS3XSSN3lGDXe8QeLNO6yeSw9ncgLTo7v5lMNqXstBCjzZLtLsZc1ysNca
         AZMBoccvNrY42GARd+mgDVHYQYDlVHaOG3YdCrioB1Q8MpRlMZJ9qpv4STEQL/lvVYd0
         zV37dVTVLPkZBYcZywmjV9cPFlqSFmIjTwC8sWuooDknBCxopPJ3w6QY9kMtnRUVSy9s
         maYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316091; x=1702920891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGzPnVe+NCTMdJ+XuET4cvoiuLLibz97osrkOtPIDJM=;
        b=OnyoO8V/sGjmogQaEUb/kpMiJ7kXA1Brzr/ML2MopAhgivsae8vEcya+wewWxMyl6W
         7eW5wR5Nxw4Ok79+2o01g9PgaDZ0J6EsaPyDWuILoYpWcBdzjDaBe6zyPCdWA+WBwyUn
         b/LbQuXsNJ48lTMhk1LYtynSf1RCKtpu2wz8AXpvU2vB1wt8R8UiiPdCInWQBLDP6pG4
         T1sllshi2nIsi15c6j3Szu8ZMYuw5hDSWxeQjgg37TwRWIXHgaQvQwR+MrC1MHRE0h44
         g+dm8LEXHcq4mRJnNuWdxEKnkfo6mH0YVdBjKsmdOQGSzHlS+H4Zr8n+zail2mugeWop
         5O3Q==
X-Gm-Message-State: AOJu0YxgSL9PGjaviw7BM5od5v3ZGPyaVqZ8oV5QCDx4c3CKFjLx4BcB
        FjL58KkYxlOL5fs7mh7zMyeA/LxmPAOwsUSLTI22PA==
X-Google-Smtp-Source: AGHT+IHtB3TpceicLLuvdZOmAoSpInnjfpt6Co4jz7+C/8Uqcsh3PtyUf/bHJu/qoIh1rry6vWIcwpOxpVoS1NHg1JU=
X-Received: by 2002:a9d:7690:0:b0:6d9:db29:6ad4 with SMTP id
 j16-20020a9d7690000000b006d9db296ad4mr4475370otl.64.1702316091311; Mon, 11
 Dec 2023 09:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20231211110331.359534-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231211110331.359534-1-songshuaishuai@tinylab.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 11 Dec 2023 09:34:13 -0800
Message-ID: <CABCJKudbwKLj-+c__Jd6Pp7PVHHBiNPYq+rhadwRO1ykoF-Erg@mail.gmail.com>
Subject: Re: [PATCH --fixes] riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        conor.dooley@microchip.com, bjorn@rivosinc.com, debug@rivosinc.com,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 11, 2023 at 3:04=E2=80=AFAM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
> The commit be97d0db5f44 ("riscv: VMAP_STACK overflow
> detection thread-safe") got rid of `shadow_stack`,
> so SHADOW_OVERFLOW_STACK_SIZE should be removed too.
>
> Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/thread_info.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 574779900bfb..4856697c5f25 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -28,7 +28,6 @@
>
>  #define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
>  #define OVERFLOW_STACK_SIZE     SZ_4K
> -#define SHADOW_OVERFLOW_STACK_SIZE (1024)
>
>  #define IRQ_STACK_SIZE         THREAD_SIZE

Ah, good catch. Thanks for the patch!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
