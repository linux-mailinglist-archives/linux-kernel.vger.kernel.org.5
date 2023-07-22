Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61C75DBA6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGVKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGVKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 06:11:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96842128
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 03:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83FC6602E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 10:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289D0C433CA;
        Sat, 22 Jul 2023 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690020713;
        bh=CY2wwyfFb6IJuuRXqd2Kr1CgQXNc/xPGT/i6muDXP14=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Qa94rRf3Q5Brz+ydLXbi5N3Bt60qMPGuq1eODHKMU5uwl/ia1DL76BolCXzfIukkF
         Zsv7PXUnkhW5lMUw7a5NaS7VkPPY0Ax1i2ke6XKuTE6wXyLhe3Dw9DfVCa5OQQq3r/
         VoKz+QDrLgLTCqAuAD274/pD9eM1qTA3nCBudXWRepOQERiWEZkN/6UcOPcFS/kpJj
         UgyUg7oU05F8U7ufiHUPzKF5LldlNyxXG2AnH7dQcQnD2jYLo1q2lcx6fTbj5XwDvg
         7pyeQIKdp5QMEU7TN6aPOe81V9yLGvEGZtnL85whfZG6Wkux+sIgPUyEcF7th1RwZU
         UBsUgE8bcujjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [regression] GNUmakefile broken on v6.5-rc1
References: <87lef931x3.fsf@kernel.org>
        <CAK7LNAR_pO_47yiKdGY-4m7es6Y-Tj_Vwo26_+xJYd3L0dfhXg@mail.gmail.com>
Date:   Sat, 22 Jul 2023 13:11:50 +0300
In-Reply-To: <CAK7LNAR_pO_47yiKdGY-4m7es6Y-Tj_Vwo26_+xJYd3L0dfhXg@mail.gmail.com>
        (Masahiro Yamada's message of "Fri, 21 Jul 2023 22:49:56 +0900")
Message-ID: <87h6pw2r2x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> On Fri, Jul 21, 2023 at 9:05=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wro=
te:
>>
>> Hi Masahiro,
>>
>> For a long time I have been using GNUmakefile in the top level source
>> directory to change compilers, enable ccache etc. Here's a simplified
>> GNUmakefile example:
>>
>> CROSS_COMPILE=3D/opt/cross/gcc-13.1.0-nolibc/x86_64-linux/bin/x86_64-lin=
ux-
>> include Makefile
>
> You need to export the variables.
>
> The following should work.
>
> export CROSS_COMPILE=3D/opt/cross/gcc-13.1.0-nolibc/x86_64-linux/bin/x86_=
64-linux-
> include Makefile

Indeed, that works. Thank you.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
