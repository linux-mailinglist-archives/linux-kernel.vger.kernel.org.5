Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E667FE338
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjK2WeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjK2WeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:34:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC6DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:34:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso359761a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701297264; x=1701902064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=KTrYV2XrgEq6Y0xhsYvEtODc3OYjvcnGdBnNFddj9x8aODKgp0rpfJYkOYAF97O7bv
         D6Up8iAvTKhyKoK6afJ66zT4Wu+3FzGG2JspoRTehID7Pf/TUuauCeesha79L5DsG4NV
         seHDM2sf9l21JbhPkMyPelTpHCcp6VXYNmBlliJk7Zv4hQ+YRS5N0h5oQ3+ayZ1ud0WU
         ym35x2haZrD2j5yy1CKzj8UylMC/EQAMJ8nY2D1QkQhOU1DCf9n1vn7m1zAjIn5cc1an
         0CPcJyDfblzaqJRaFuNgQbmIHIRuFWheFiWhTfzwtDfRSX0D8GOH/acOdcZHsJWQ22+M
         Vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297264; x=1701902064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnm99jqQ5LZRgPNiiPzVL+B5VKBQnQt/eKM5uqfnZUU=;
        b=umgAFtF3t2N5+6SiHkh/RS0RoDCL7gaGbqxQU1UEecXdXJa9jfzLu4sCEX0ayfwieI
         yK6km/Gk9KGhih8heUan2tfz1saC58XMJRcM04abfAOKF1vet/JarStCW8RipgjAZkin
         PvsXeNfv9u/Lv8reZCGhV3MEIUOuCC3hvDkuy01RRllWBnT11C/PzZcjRp0fzugebOaa
         i6E00nHwfhGO2ZG380k0A8N9htHI7ongMfJ4s4t+L60yr8NgUifWGQBs6wk6XEOqUQHA
         3161EFWw5itnPl7WN1l6YlSlykxT1JHkvn3oWK7GgLQK2cTA/8ywd5Lcmj6F5Vo4xrmC
         UyHw==
X-Gm-Message-State: AOJu0YyDK1JIFPQff9HFyHvh8vTVSwHOy5MpO8bXIcYbP7qTODh32UhM
        OS86XvZamq1MM+0v/lNlHszvAhJcnAE6iodKFfHWVw==
X-Google-Smtp-Source: AGHT+IH0alFbhyux92V1WZYTs36CZIO0U41SCJZeLRz21ETmzAJqO7Ml6enLVYzem3Tj55K02bcXJQG+91mwi5Wj52I=
X-Received: by 2002:a17:90b:3c2:b0:285:772b:91a3 with SMTP id
 go2-20020a17090b03c200b00285772b91a3mr19810082pjb.27.1701297264563; Wed, 29
 Nov 2023 14:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20231129220409.55006-1-ignat@cloudflare.com> <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 29 Nov 2023 22:34:13 +0000
Message-ID: <CALrw=nF-zfmT+JNk9OKe7P3oRa7q820ATy3x4yc2A0z8j6_+AA@mail.gmail.com>
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
        agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:23=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com>=
 wrote:
>
> > Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> > Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop =
select of KEXEC for CRASH_DUMP
> > Cc: stable@vger.kernel.org # 6.6+
>
> I doubt if anyone knows what the two above lines mean.  What are your
> recommendations for the merging of this patch?

Hmm... I was just following
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#opt=
ion-1
and basically wanted to make sure that this patch gets backported
together with commit f8ff234: kernel/Kconfig.kexec: drop select of
KEXEC for CRASH_DUMP (they should go together)

> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
