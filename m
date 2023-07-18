Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E2757DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGRNnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjGRNmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558AE52;
        Tue, 18 Jul 2023 06:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5586159C;
        Tue, 18 Jul 2023 13:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10070C433BA;
        Tue, 18 Jul 2023 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689687760;
        bh=CIo8pG+uBoaTu6IZrlQTmAWUKfADY8nWxWu1Fm//gPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l0IErWhTHFHKuY2xhpVJqT03Ic3LVRZkuIg5P0jqrOdWhXaF1SpTlSS6DjLLYYYDS
         O2En5SwQDvmZr+wpEsTSeXe22SljKfqjAwz0c/vGxBx+M4MDnuJ/xRIGUxNNQsEHE0
         xgAZ1HrG7k0hbAS23hk5fZYCSie3jJhu2D6ylwsAxMgB7s+qgoP2UWr5vRegOvGgTU
         jNRtJXCKb1xx5C3Pl8nuDcTvZPYhTzhFD8zP2hByWeSKDIYM8DaMrpjFIHTNCElcE6
         HU+BQtLJ62Q9O5OtqeFLaRs81L17LBi72wM4Y0atYbYSj+sSOr6zggoZAyjAvb12H2
         iBg4wNms3xrwg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5701810884aso55035467b3.0;
        Tue, 18 Jul 2023 06:42:40 -0700 (PDT)
X-Gm-Message-State: ABy/qLbiqDL6cUBKzTyBrZ7+LmlI411w7YkFpE179Cr5QLvUlGmmnwhS
        1tDHgZRCIkiMNbCzKC+uwXQkLQkGQG3RqnBZ4Q==
X-Google-Smtp-Source: APBJJlH+hV4+f7SxcituMNPnf04wyDSy22RgnyhSEviW6hADWlJtAxsSRnvCuYTIv6GuoHp9dSREaMT+VMSRGw1cckU=
X-Received: by 2002:a25:b216:0:b0:cba:dd41:612f with SMTP id
 i22-20020a25b216000000b00cbadd41612fmr11408755ybj.9.1689687759094; Tue, 18
 Jul 2023 06:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_C2E29E92E4A5FCCF6F6BB14E2ED98DC6C309@qq.com> <40586276d1294a4d8c81db3cd5dcd4ac@208suo.com>
In-Reply-To: <40586276d1294a4d8c81db3cd5dcd4ac@208suo.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Jul 2023 07:42:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLRsdZ4wRUvkUpFNLcZkL7WS+dLWMGX30gAF8+T6je6A@mail.gmail.com>
Message-ID: <CAL_JsqJLRsdZ4wRUvkUpFNLcZkL7WS+dLWMGX30gAF8+T6je6A@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Fix errors in yamltree.c
To:     shijie001@208suo.com
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jul 17, 2023 at 7:38=E2=80=AFPM <shijie001@208suo.com> wrote:
>
> The following checkpatch errors are removed:
> ERROR: "(foo*)" should be "(foo *)"
>
> Signed-off-by: Jie Shi <shijie001@208suo.com>
> ---
>   scripts/dtc/yamltree.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

This is a copy of upstream dtc imported as-is into the kernel. If you
want to make changes, you have to do them on the upstream dtc.

The YAML support is likely going to be removed, so I wouldn't bother
with style fixes.

Rob
