Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF679C96A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjILINe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjILINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:13:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051E10C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:13:28 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7e904674aeso4563723276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506408; x=1695111208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0wTIBjz7kND/AUdb88zaZ6X4O2w6qaMsynEQ4VEpl8=;
        b=epfwlzndbg8iN6IKpVOONhQux0Y+bcRHa+QZa+tSab7mp5H/8xUtMLwZlIyHESK5CR
         dHbZRTnLBE8AGhBfsGKKJfrD4WffVD6Yzjub+aPvCjuUFH9EQKi9KsMPF8Cf1kCqpfeF
         qr6+BSI0PqJ3Qcc9P9sVTtUN8QlSxzDqDg39TrjMT6Tw4UB2pLIKO1GPU8EzCMurtSb6
         fmh17+Q78dIvBRhPqRQ04KgcGfMfzDq91WBvoes8VemaC4/SnRVocfKwYN9xRQk+6U4q
         M7Xy/H4j8GJO3sqG/pHQZUn0LCCnVfD3MaAdPaKFw9D2hYn1hSEn1AGV3OoTWrKipdoO
         Tmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506408; x=1695111208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0wTIBjz7kND/AUdb88zaZ6X4O2w6qaMsynEQ4VEpl8=;
        b=CPz1gWYZEMc4YwUJvAjXmHTbxu/B+i0ZznVkPE5/3hgYLZSwnBjdf0h0syk6sEHoCf
         ldDTIGoYght9660oEcvTn0RZZ6N6P4+3JiBx3O9AXPXK9ModTak9YN6Emq8a2DGiMm8N
         mPNJ+jCM5mY/sqmwNmIjhFe8G5PMEho6Y87pS6A6assjds5oYXMZ9JeVvfoGmBl3LJ00
         li5RBpas2FsQr5HmKizxWcio6uqmPaVQ2AHiyfiGhIgARIesdG99Vjx0ntxGITslHrks
         1F41+berr98c3QvXqveE4HYOL/OEzlC/SnkEytoiSyVSQTd0MAC8JVUJQaLqdFY7lw5C
         2eSw==
X-Gm-Message-State: AOJu0Ywh0xbEeyMLe9Y0TBX0I9p+Oj4cyBfUH7EadeA79b0w2TZcGZx0
        J9cUVEEoTfMLsQ4pksBPKhij/yGfrF9QikSjLDa15w==
X-Google-Smtp-Source: AGHT+IHuRDjHz/DsWcBLoVAM4Op0qIFV+tGRyxcDnwHyZP34sJun1mYbuiZ2BQt/IoBMXyuIY/jdhrKEYgWyinOH9/A=
X-Received: by 2002:a25:8451:0:b0:d0a:8973:b1c with SMTP id
 r17-20020a258451000000b00d0a89730b1cmr9957810ybm.12.1694506407900; Tue, 12
 Sep 2023 01:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230909110459.12453-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230909110459.12453-1-biju.das.jz@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:13:16 +0200
Message-ID: <CACRpkdbcb9iPZ68dF48gHFzvQsZ_-SnhUJmVRoYv_UArEg_EOQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sx150x: Simplify probe()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 9, 2023 at 1:05=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:

> Simpilfy probe() by replacing of_device_get_match_data() and ID lookup fo=
r
> retrieving match data by i2c_get_match_data().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Patch applied.

Yours,
Linus Walleij
