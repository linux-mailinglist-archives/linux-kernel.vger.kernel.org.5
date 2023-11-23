Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B347F59DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjKWISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjKWIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:17:58 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D21B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:18:03 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5c08c47c055so5922977b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700727482; x=1701332282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=ywYR/1HXWq4++wDj5eemMv/6QtWRWPoqX9MM6XzyU0G4LrwZ1Fsvlz7iw04FroAMLR
         +/5bpq/ZR4zRxG5l0Jed9gsT1AdGk0FNNDiXpM+hxrWgA30ciDNBVzE1tsrcF37vrFTO
         Gm00lmlKs/g7i5/KsyCZz+RvVhaxPbBoSGSA0pQ7wbTDJgrFFu5ttBNKI65aJORL35RQ
         6q+uN5V+LqstUGbeZ8nqYJpV8j3Uln6cU8E4JLUQUg583LYTZoGOJmkkv4OJeJ+idlIS
         Jh3y5fuFc/oC5QHaEAtc7Ba0gtpXPqZxafEUH4WVBy9EAI1QNDRK4Rr2xNc1Pav2Xh/Z
         r6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727482; x=1701332282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQyz8WUbCXXcHlGWxMEoDuZxvoCOtrHTLLemanVJpw=;
        b=U40nyT/GEooKD/hVcgfuMbq+98OjvDXiWv2INYzAo0GBkV7005RSx9QO1RPE58ndXB
         uT1kOxmls1F7yB8GAp/iQWrktcEJVfNagRPESaQ93uZMEfIPw01SQNCjIW6v0vRMv2t8
         51Mns1ijgI3e1gci9anwALiFhxSqr1oUqooKWm+eGc1g9bZFhJIm8eBFvlisDRioMdC2
         H4EN+kvYV0pmwBOU3eGr0XcQvalTURHYhtGWXSBTsztxw3Tz5aeRGne9kqf3XiGK6K/x
         2vnjivdMl6nBlKkYNwqXBZTcuI46W4sWFFEYW4YHF2J03LqV5n/F2CHSNV3N6IEX2Qbv
         Zxlg==
X-Gm-Message-State: AOJu0YxaPSnS1JqhzHeONjm1+cGTCSpIMqddxp4CbwmZaLK5o/7p6U+I
        5EJRvJEu/VZm6sGR2qEfxvy8y+QCK/wYP+cr8UMtlQ==
X-Google-Smtp-Source: AGHT+IEwql/FgZ2i8ySsNVBR/Nowgs8VsmzDvaDcvugx+PF9f25ta/GIkylxpBoLVtMa8WZ+CpZvXGDmbeZBOafDiZ8=
X-Received: by 2002:a0d:df0d:0:b0:5c9:e7f8:ba03 with SMTP id
 i13-20020a0ddf0d000000b005c9e7f8ba03mr4532566ywe.4.1700727482614; Thu, 23 Nov
 2023 00:18:02 -0800 (PST)
MIME-Version: 1.0
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3> <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 09:17:49 +0100
Message-ID: <CACRpkdYjEgsyCznNwkSaStk+DMtjH3_oGeX4f4BJzpo5eXHm2g@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, rafael@kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
        robert.moore@intel.com, Jonathan.Cameron@huawei.com,
        guohanjun@huawei.com, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cfsworks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:32=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:

> It concerns me that neither linux-next nor 0day robot exposure reported
> this problem.
>
> Does ARM32 require manual compilation coverage these days or was this
> just a series of unfortunate events that the build bots missed this?

It's not just ARM32, I saw it on ARM64 as well and I'm pretty
sure it appears on any bare metal "none" compiler.

kernel.org host "nolibc" cross compilers (Arnd makes these):
https://mirrors.edge.kernel.org/pub/tools/crosstool/
and those WORK, because they use the kernel minimal
libc which defines __linux__.

So a "nolibc" compiler works but not "none" compilers.

I think the test robots all use Arnds nolibc compilers or the
compilers from distributions so they don't see this.

A typical example of breaking compilers: ARMs supported
"none" compilers:
https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads

Yours,
Linus Walleij
