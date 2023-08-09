Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D109776298
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHIOgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHIOf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:35:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C31FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:35:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc5acc627dso26733665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691591757; x=1692196557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcSxbBrOV0WBg4EP6zgcLtNj8tR0tgK0git/8kLh/8g=;
        b=iFBxTWYgQIrj4gYHg7URBl9Kl5xOAcVL0HH5/QkB91x4HS9lNi6Ivla71SdJlNRENe
         3POAlQzTPJPQ3Azft+nt3ZFkUvTC+xctOQt7sHY1FIU0BybjtoelE8jK+/csTHOg/CWw
         2LFJwu2hoXwkJ5OXWlBnZfRa6XQpodvXkymXFF7uXChA8KsGQUP3o3K4uA3Yac5it+YT
         TkzwpivjCIFNw1gAxYzFN792eKnjLxRFDxu++b1KjVk2aFVcYvDpWDg/+JSaFdaZ9Xl0
         LSAMZdvIKAJiXQTHAkaBYCV/kZXwBTnDfIkYTt6GkbmW1vqzbTxx8vR5hREY4ztHK3xB
         HUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591757; x=1692196557;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcSxbBrOV0WBg4EP6zgcLtNj8tR0tgK0git/8kLh/8g=;
        b=g0eDIgyDjha3f48URSr03dZPJxi+R7RYrpZ/3MpjTR01LUp3InTrMbdrZQAyRjC/Gn
         nwSzobVOfZfeQenIobhOvsgMWMjiSGE0tqF06FPQ1d4E7SmGAOz+OzEbFGKzK2ha/pNj
         T68JUy2CX1GKTrGD0eYforhlpO7A9xP1P3jfTaoYQQ1v+lmCVYY/8lOfzrNuHwijGMNa
         mIDibCADKJzoz7BUnCNZdR79X6HyM7C8AnBjBjhFRaIHx3HLleYW3Sx9J+Ae25SYSAB8
         0HCAuk7qUmm8+dIm/D4DcF5O61INpz+vG68uWRFf3zzqaEg82wrEf0EW53a7aGVohCqH
         ZIRQ==
X-Gm-Message-State: AOJu0Yyz9taU9r3X3/2jyqD80d5sDpneeaEHielysqAhooCwJuZrnmJB
        x8osip9zcqc11iPgvYq/HcDNNQ==
X-Google-Smtp-Source: AGHT+IFdVVu7L+xm66m6ILijRF86owhaQpuq4lcg6v7Vht4/WBr40AzWMsdamMMfe6osPRY5H6pnVg==
X-Received: by 2002:a17:902:d483:b0:1b8:a3e8:51d0 with SMTP id c3-20020a170902d48300b001b8a3e851d0mr2328259plg.45.1691591757300;
        Wed, 09 Aug 2023 07:35:57 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001bc68602e54sm7307984plo.142.2023.08.09.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:35:56 -0700 (PDT)
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
Subject: Re: (subset) [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2)
 failures
Message-Id: <169159174235.20984.13290949121654917312.b4-ty@rivosinc.com>
Date:   Wed, 09 Aug 2023 07:35:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Torsten Duwe <duwe@suse.de>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Alyssa Ross <hi@alyssa.is>, Li Zhengyu <lizhengyu3@huawei.com>,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Petr Tesarik <petrtesarik@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2023 11:53:58 +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> [...]

Applied, thanks!

[1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation type
      https://git.kernel.org/palmer/c/d0b4f95a5103
[3/3] riscv/kexec: load initrd high in available memory
      https://git.kernel.org/palmer/c/49af7a2cd5f6

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

