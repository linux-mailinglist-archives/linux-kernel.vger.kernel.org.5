Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8413D7EB7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjKNUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:20:31 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1B110
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:20:26 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7b91faf40so70349967b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699993225; x=1700598025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=GKLM3OrEWexNWfLbZuR6+wv0E04AjERDIHBiH/TBUC9fPUcF/c2Lkkub0/1ukgpK3/
         lPH2Ea5fnAnqv1QCjdz53rCuiKyQCgooM6r2FmyJOv2PNI6WnPMVGW/N5GIUB7OLK4fR
         EqaDd7babuLJG8P2wn/Oq1CymBv6GUwKiTLncSsoCWUuhwNeC+/BR2w9If6dJ+eBv5d2
         AtBFsugP7iZ2W1zdwl3Bx3Gw9CRGkFsck63HcueJ6R2ygxQlLE6VqJN9fhJGdB9gE6tm
         GORi3Xa3ggMSOoBqL5IeEvw8KzTUaa9frAYxfdCP9mjuyVRs+JD/T5ZpIEtSju5I0674
         CyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993225; x=1700598025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgIMZhFr5ANe/opk6rHwzR0Wea+pDhCr2RohibRDeJI=;
        b=nvCBAL+e4rX3M9yKsvIJ25dLdSk9yI9a3PJCn9167dgpvh8cAzhYGeLX/ujQqFjLz3
         Ka3d1H/B3TYTD8lsTiV4F1e1kylEBRhWOkVg2/2raibJDTL/9AQ08lS5ASMoX+OwJsFU
         NEVOhCzqf6u/lRAyNQRRRDuyL1PC0+dpaXQQ0JxcN1gZICRMCt61I0PDnZuntNv3pZdf
         dcJS3ldjXUnij4mOsaoWQE1pCWfG5AL09xcD52JvKuMR0C9BCqSPFwRoRGHHwRpqkdQ4
         +FSe5LfVO84sSJ/35CXg8wooP6upgCvtIcmu65lvfcNiFkQf5gZNX83ML4BYZcva7f5j
         Me8A==
X-Gm-Message-State: AOJu0YwbRw9yHVyS3QZBTZUYJAXbC1gjM1Fh2fkg0T4c9Pi5onMZFg6m
        EXEq/jj5SMqtJ7oOSnE40DUBY93JvG3qhVDFECPTNQ==
X-Google-Smtp-Source: AGHT+IHDLBa3i08U+nLN0OG3yu/iiLd302obDuxMCccsocWSzYdESyvlcJkxV2yuKipJLTHkRfWr3hMnsJhJHv5hRTQ=
X-Received: by 2002:a0d:c505:0:b0:5a7:ba00:6dd8 with SMTP id
 h5-20020a0dc505000000b005a7ba006dd8mr9813769ywd.8.1699993225750; Tue, 14 Nov
 2023 12:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org> <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
In-Reply-To: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 21:20:14 +0100
Message-ID: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:

> I am not an ACPI subsystem maintainer, but my understanding is that the
> files in include/acpi/ are copied verbatim from ACPICA, so any change to
> those files will have to be sent to the ACPICA project and wouldn't be
> accepted here.
>
> More likely, we'd want to do something about the circular-include
> situation between linux/fw_table.h<->linux/acpi.h.

I agree but I have no idea how to fix that really, should I just send
a revert instead so the authors can get some time to figure it out?

Yours,
Linus Walleij
