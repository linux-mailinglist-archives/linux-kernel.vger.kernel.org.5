Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793577D9B89
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbjJ0Oet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbjJ0Oer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:34:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3A1AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:34:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E74FC433C8;
        Fri, 27 Oct 2023 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698417285;
        bh=IX8RQzfBXRS9SUhkV0bs9/Q66pPOiW3I4YrGYJ4QTi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MSNOWnU3uKVPyR9/AeEL+cASKCWc5sEWV65CK2AIxppGvtI1HLwZ+mj/JgpJUozbT
         qp9vEkP1R7cJrzzQ8o5g8JSYCbBiYAdtqDUjs0nNdFMrOFwYmVE9Yo3BRbp0AUJcPj
         RFN8N4JOfMLJQBQFFKQ2XyCXedfjsNhx/Y3D0sQVK8NYJ2CpzaL0LDm9ro4VoWT9Io
         tN6iXe1i8PVTx/3Ul3n3vSeaMW6YBgXHJPIX3+JhFIXjQV0lC04V+TqL7cv7KvWBNW
         gMreM2ugfaI4spL8pThxH9IGDp1WT3UH0434bxK65AEshve5DJteIOjFcFxYZzTZvi
         UYxN35m08995w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c5629fdbf8so30427401fa.0;
        Fri, 27 Oct 2023 07:34:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YwVHgP6AOBeDyh/dPKmyGRZavTqR7BkGKx2yg7ASoqBPOSiCMqu
        F2saVX8RyZ9vOv47bCD6ycJJdYm2/coW3q4t1w==
X-Google-Smtp-Source: AGHT+IEwPs4ftLrpjangHs/vILf+n9YLkbRAd9hunvQjilnJqxRLp2SDdGkmA9zsKNV+D+MgGagRugSfBzhct3Ayc0k=
X-Received: by 2002:ac2:4850:0:b0:507:a089:caf4 with SMTP id
 16-20020ac24850000000b00507a089caf4mr1962824lfy.60.1698417283688; Fri, 27 Oct
 2023 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698328110.git.geert+renesas@glider.be>
In-Reply-To: <cover.1698328110.git.geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Oct 2023 09:34:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqtGWYD=eJ2CWJ2MxcGfYVJ6roVsyDou6p6GLeyDti4g@mail.gmail.com>
Message-ID: <CAL_JsqKqtGWYD=eJ2CWJ2MxcGfYVJ6roVsyDou6p6GLeyDti4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] scripts: dt_to_config: Fix nul-separated compatible values
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
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

+David G

On Thu, Oct 26, 2023 at 8:55=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> Due to a not-so-recent change in dtc, the dt_to_config script no longer
> works well when used on a DTB instead of on a DTS file.  The first patch
> fixes that, the second patch fixes the rather odd spacing in that
> script.

I just sent a fix[1] for dtc to restore the prior behavior. I'm fine
with applying this too though.

Rob

[1] https://lore.kernel.org/devicetree-compiler/20231027142901.2536622-1-ro=
bh@kernel.org/
