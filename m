Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C77800BA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378976AbjLANTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378947AbjLANTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:19:17 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5713E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:19:23 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d279bcce64so23823337b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436762; x=1702041562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV4RE4cHNpakye744+P99xHdpE2/iAr/FBdxm7x4r+g=;
        b=k7+YvcLWgiIpFeZv4E6dFYbAwzp6qzf0OwdULmKHfCwnOeKRrERw+/fncxBdnWu6Mg
         k+VFF/Y1hv4iGa+4Eo5VMZQEJin0y9769rCzYfwBL0W/u8UdtOn+5JLGKsm8E22hCObQ
         QPwQFoZ1fxi2LvbyRfzKGfT6MtPqSAvdoPqiKbOLHusiGlyafxS2SYWz84N3jc5DaMys
         gCeOQdQv3mEXA3hA699C5TpZU8tU6n2o/EJb1JXHQ1uqF0GUbQCf9X0m7nW1Dh6uZx2i
         f5MX9ohIUwVDObiOcxD2zx4H8liQ2STNYQ6xvPLA9TCgvKsfNtpYRAedINwSORJlkoBn
         a+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436762; x=1702041562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV4RE4cHNpakye744+P99xHdpE2/iAr/FBdxm7x4r+g=;
        b=WMYyjXlt3sygajpO4COlyR4QBj7vaOB6SuYSlAyUNGLWT8t7Q2bkfIfHtFYnE+kAlf
         I+hXfFclaLNQCUNvNTU3EPFZkHDH/J+3Stx/M93yONRRdFGYg1h6etOWVPW2FLUuuesk
         QhRIiF4gdZpKIoZsPDKB0+Py37ZV0smBJODQS5DctErI6j9pvkvu/sJ2rPgd4Da4P3NH
         BSEHpF60FNpb7eCzoVs66jyYEcR2lzsKsYXWZ0AYWQ9f+T1oEXdlhkX1O3PGu4KPaUCC
         vhVF2lUdARnpVTfH1xwmMRjBho1mH1q/RwMmYOicrzU7tm5RtFzSFWAbs3qs3+DR7Ji+
         yI+w==
X-Gm-Message-State: AOJu0Yy/FRirvAJR/pYlX9ANCe2+MFIGvmSOat/st9olSVywU3a6K0ET
        VhoLWPD7u6CBwZ9I1we2qbC0yThmlQDynk/xnbx9BQ==
X-Google-Smtp-Source: AGHT+IFEWzRE5D+JX5v6BYxdEGsQDVSfXG3gspfyC4M3wp8CNF5TLeciexwuvK9psgzwpfJl7ggu9HKOx77eKmwNPuI=
X-Received: by 2002:a81:9242:0:b0:5d3:cfc1:2df2 with SMTP id
 j63-20020a819242000000b005d3cfc12df2mr3380112ywg.14.1701436762501; Fri, 01
 Dec 2023 05:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20231201100527.1034292-1-jorge@foundries.io>
In-Reply-To: <20231201100527.1034292-1-jorge@foundries.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Dec 2023 14:19:10 +0100
Message-ID: <CACRpkdbbV_mCT-P6mK8=S4rR7=ZKV=LKYmoH1dGsG3PAR2HjaA@mail.gmail.com>
Subject: Re: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 11:05=E2=80=AFAM Jorge Ramirez-Ortiz <jorge@foundrie=
s.io> wrote:

> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
>
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
>
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
>
> This commit fixes that regression.
>
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Cc: <stable@vger.kernel.org> # v6.0+

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
