Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E26782EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjHUQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjHUQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:50:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D9F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so3225361fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636621; x=1693241421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhQkl2/jykX2MZsLs+tp8WyLs5BBbqPJDrs4FQYb2Bs=;
        b=hmO/vE6elSjXfINFXrRuHiofNdtMJLybPJBFWBogg8NUXElBR9sj9sV1EeHs9ximlr
         +mCP61E6EtSKNQloFVV8zKwJxC9kNqbhs48AWlkTy3WKH4K1E1E721CdVnlVzLRQxC5z
         +5M5H6pd7DgrCyD2kvzcaS/XbXEIOo2hgILPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636621; x=1693241421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhQkl2/jykX2MZsLs+tp8WyLs5BBbqPJDrs4FQYb2Bs=;
        b=LAafjz4q1zNDg2ex0Lqge1k51pHUXICLOXMLbsG+Gl8qKl61bnQOvlwKklmfnsfAZR
         0AbKRImISFkhCe90lEHNHsKjBnuBXJz8VhT3xfqpcxZk20PN4RbSPRM11YNGlFwcR0f3
         wrmp8P+YWMxPpFbGWDYX6ieYc+vgiVFhk6GRhg39snv9LT+KuZ6aAMkkohLDdpSFy/vE
         zWkeCy8R+72qd+491rUpLZnI25eyijDwDiCIMNjY3B/XUrF9NQKtQDciAcdC/Onwr+Ib
         80pE18u4COh4qtlB4K/mMVnHn6QdlwA/R8hiDsfkVCiITZfuPdTzdNZ89UtW1PF/M9VF
         4q4Q==
X-Gm-Message-State: AOJu0Yy+lI+6TDiTBz34FO11zen7nyJaYf9e+qGlVZkXoCQJ0KQlQQHd
        bjG1gzJaoZYF3JYUC1TNGnkrBLM3UEEXEQhvsqW2tsom
X-Google-Smtp-Source: AGHT+IGnCQwwnSn6n5sDVI19F2E2KVlGrY2OAZCB4D5TQEq7V3umS6KKwk15Ec0/Dh3cUTVOuPGTZg==
X-Received: by 2002:a2e:b059:0:b0:2b6:a763:5d13 with SMTP id d25-20020a2eb059000000b002b6a7635d13mr5243330ljl.27.1692636621353;
        Mon, 21 Aug 2023 09:50:21 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id l4-20020a1709062a8400b00997e00e78e6sm6759599eje.112.2023.08.21.09.50.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:50:20 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so2565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:20 -0700 (PDT)
X-Received: by 2002:a05:600c:511d:b0:3f7:e4d8:2569 with SMTP id
 o29-20020a05600c511d00b003f7e4d82569mr147wms.5.1692636619918; Mon, 21 Aug
 2023 09:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <0e37d1f09718a6ab9204b367ff528ab02df25ac7.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <0e37d1f09718a6ab9204b367ff528ab02df25ac7.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:50:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEDCCOV9S_Vf45nee7-xqJLXmQqTp8FAM9v0jQ9X5e-g@mail.gmail.com>
Message-ID: <CAD=FV=XEDCCOV9S_Vf45nee7-xqJLXmQqTp8FAM9v0jQ9X5e-g@mail.gmail.com>
Subject: Re: [PATCH 1/6] regulator: core: simplify regulator_lock_nested()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
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

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> `lock` is only false when the `rdev` is already locked and the owner is
> `current`. In this case `ret` is always zero. By removing `lock`, we
> thus remove `mutex_owner` write avoidance, but make the code flow more
> understandable.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Agreed that this looks to be equivalent and easier to understand.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
