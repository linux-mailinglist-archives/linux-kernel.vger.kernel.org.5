Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F76D090
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjHBOtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjHBOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:49:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12E2103
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:49:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so6613912a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690987771; x=1691592571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKHkYl6IMr8QnTnvT30Nci/brg8p0pHZBfK3BKGZxuI=;
        b=Pq+bTdD5N+DD8rAc1KC2k90a8XMV7LkhjQxc3v2pKh8PnyU7kWBUdsFCQYpNZVV6EC
         hzVPKhAtO4Dpsdb/K/SlkDd+P9SNEHV3MuzO6agsVMjk+NVzIYXSPtfWY+zU55J+LMFw
         U4vErh2k/QNPBEBRDrUuqt7etJP9KBld9i0PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987771; x=1691592571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKHkYl6IMr8QnTnvT30Nci/brg8p0pHZBfK3BKGZxuI=;
        b=VwdrWriqjlP0MPtgWcOGTdHDe0po8S40tvnjAtKvyAQC3rQUleDpYF13Qyd4YcIR54
         vWDErY85I+8UZ7yPon5SAoEgPvey/0L/OIHdsi4hcIoHm5NM94L9vzZ85Ek5dnWyENSc
         5/kVyLm6YH0Ax1MibSXoN4lsdy4Wji1QxpJ7v25lLeTiMHGHbR6DSzEaVK+7Nn4ZgSDA
         /+OQbGG7/cgFPVzusTgxmRKr20wuKz9GCZJly2T3uCUTfIHWcvbs+i2JHb3OWLSy01oY
         LOxPGn6wztmUcYKJ/MX15MLbhSwEBg+2hZiuDZPyZMGO/YA580HSlTlH2oHENLLX0+9Q
         Z/vw==
X-Gm-Message-State: ABy/qLb93SbF0jsqzPgIyXdBQvLsgSdUF42zk6Uzl8kp3a/BQ5dQKiap
        C07IFYY4waDdXSnM2B6+rx483vmGgMj9oqeGsYih6dg4
X-Google-Smtp-Source: APBJJlH5ZCiCsvyeEPPPoYQLXF5nNse7NnhmiE9G/mIrkz4YVPn2t+j7uS/KSJ+6CnVOjIaI6YPkMw==
X-Received: by 2002:a17:906:53cd:b0:993:ea6b:edf6 with SMTP id p13-20020a17090653cd00b00993ea6bedf6mr5529423ejo.0.1690987771053;
        Wed, 02 Aug 2023 07:49:31 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906830a00b00992a8a54f32sm9229454ejx.139.2023.08.02.07.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:49:30 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so14235a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:49:30 -0700 (PDT)
X-Received: by 2002:a50:9f84:0:b0:521:f642:7183 with SMTP id
 c4-20020a509f84000000b00521f6427183mr415975edf.1.1690987770404; Wed, 02 Aug
 2023 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230802141724.0edce253@canb.auug.org.au>
In-Reply-To: <20230802141724.0edce253@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Aug 2023 07:49:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4RmorrEu9oGrW+ovBXn+nC_APVhH-M+mHHXYoYLYRPQ@mail.gmail.com>
Message-ID: <CAD=FV=V4RmorrEu9oGrW+ovBXn+nC_APVhH-M+mHHXYoYLYRPQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 1, 2023 at 9:17=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/gpu/todo.rst:469: ERROR: Unexpected indentation.
>
> Introduced by commit
>
>   d2aacaf07395 ("drm/panel: Check for already prepared/enabled in drm_pan=
el")

Thanks for the report. I've posted:

https://lore.kernel.org/all/20230802074727.2.Iaeb7b0f7951aee6b8c090364bbc87=
b1ae198a857@changeid/

To fix this one.

-Doug
