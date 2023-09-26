Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0B7AE926
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjIZJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjIZJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E23CEC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5212DC433CD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695720435;
        bh=f1VR1cPsKiZEfMZ4xmQmf1dSo/TmQTqpOYPK0gtgMWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qJM6u/ydoUUlSTcDZCJ5RvpbD+zwPn4JUk0BqY+u7WHOUdCVCq/DzMu6/ToueXAT8
         mPEQwo62KGty+r+QPeslko/YBLrzLRHV+Cz/IWMdAAVIVh8GaXgy83jrjietvM7pD6
         iQYXlcn7vGnmRJYJdBRCkSVXyP2L7/BF0Y5xzGWPtNLrBi40xy0qMGw0anbjOxvXL3
         8vhSMwDFJh+TLFMX92xo70V7GT7oM1BVoPZBprQW4Ad/y0mVQAwnPqRQbpZrF4q7uA
         cZCa7lmVDlJp8VwE7ddF9fFkUEegCA/SMAcJawoGpGMuaRHf41ZKVv2Bq95EMAY10/
         zyi1gxBb+9yvw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5345a3dfe3bso1442861a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:27:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxhDkGRDUPXduys6iL6I1OINO2HJSwgx9pfMA5VugtsaFdnB4UD
        aOtwznFR/IuybW6MJMncT9S5bsOggLyhwZh2CaE=
X-Google-Smtp-Source: AGHT+IGH5mmzJnX8yukfh9EAV11DcIjqWDnDfW/6ZG+lDlbrYo8U8qt0Bt96vUVymM1cAyk8EfcXfEnc1a1+/P0tqgQ=
X-Received: by 2002:aa7:d584:0:b0:522:3849:48d8 with SMTP id
 r4-20020aa7d584000000b00522384948d8mr7371489edq.9.1695720433743; Tue, 26 Sep
 2023 02:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <1695715852-15902-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1695715852-15902-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 26 Sep 2023 17:26:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7B7ZZvUHS40WgBkXhxhdMDhOr=MGTi_75OSAT_zU_=cg@mail.gmail.com>
Message-ID: <CAAhV-H7B7ZZvUHS40WgBkXhxhdMDhOr=MGTi_75OSAT_zU_=cg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add support for 32/64_PCREL relocation type
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

Queued for loongarch-fixes, thanks.

Huacai

On Tue, Sep 26, 2023 at 4:11=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Tiezhu Yang (3):
>   LoongArch: Define relocation types added in ABI v2.10
>   LoongArch: Add support for 32_PCREL relocation type
>   LoongArch: Add support for 64_PCREL relocation type
>
>  arch/loongarch/include/asm/elf.h |  9 +++++++++
>  arch/loongarch/kernel/module.c   | 22 +++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> --
> 2.1.0
>
