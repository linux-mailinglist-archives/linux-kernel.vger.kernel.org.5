Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513B7564F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGQN1w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 09:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGQN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:27:10 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0B2680;
        Mon, 17 Jul 2023 06:26:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991f9148334so93197566b.1;
        Mon, 17 Jul 2023 06:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600387; x=1690205187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohB61xyllzPXwj/8LtXeAWQLPmy/KSKb5tmX/Q+HtlQ=;
        b=lEdlQh/pE7JCc0C67Xc8P/k8MJMgxOFChdQo2j+4nw3IEGFsSJdEieUUbZPDBLduqz
         QYQdcXSm+f4EiUEZ8WYfP8+HSxd9AMNfUevpgONhHdXjIFyjTLZ9tjes6cLKTCb432W6
         2X/44LglRkrM8BUn2qmbJ/K6wSu0luVivQw3x7S/28GJXPQoe+MyQLINSDa+2hWlZb8l
         etmASTOFyuEMMHj+4wOESMRg5hoV2/XXUdzg9tgrRCfvjg6LG9wvKCVY+s22WsZuWNLU
         JjQ0MBFQtjHVlV2CEgc/4VnTFjoU+EM0QySq12JqdyZYXFDSqoBktwPJJHneg36CkB8F
         b9jg==
X-Gm-Message-State: ABy/qLa8js09tP+bxO66GGkzJt0XHZpboNHvGQsdUl0aPYTWzUr/337T
        /F48pcFmhLBSviGf5V0lfyngWLWRWq38Pk94YlEr8vfJ
X-Google-Smtp-Source: APBJJlHI4V+c4oSRC4S5KV43u0itswzv6czVwqEfYTPwDnNuBlXf5NyejrvLbj6h29jwBsTHRD5sqdPI4WhYVy3qrEA=
X-Received: by 2002:a17:906:2205:b0:988:73e4:b781 with SMTP id
 s5-20020a170906220500b0098873e4b781mr8878889ejs.2.1689600386979; Mon, 17 Jul
 2023 06:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230712172459.20275-1-mario.limonciello@amd.com>
 <CAJZ5v0jDpMNsWztgPDfLG3eGw3YOxK_ygWRLgHmbZUoMh97tbw@mail.gmail.com> <0a8351e9-a9f1-bec4-1542-2a456ca76d93@amd.com>
In-Reply-To: <0a8351e9-a9f1-bec4-1542-2a456ca76d93@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Jul 2023 15:26:11 +0200
Message-ID: <CAJZ5v0iqu-Dpyw-u64e+S=mQY1tCJkoU1NZmfbs0nUQy9MyxQg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Drop nocrt parameter
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 5:40 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 7/13/2023 10:31 AM, Rafael J. Wysocki wrote:
> > On Wed, Jul 12, 2023 at 7:25 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >> The `nocrt` module parameter has no code associated with it and does
> >> nothing.  As `crt=-1` has same functionality as what nocrt should be
> >> doing drop `nocrt` and associated documentation.
> >>
> >> This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
> >> thus didn't function properly.
> >>
> >> Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > Stable material I suppose?
> Yeah I think so.

OK

> >> ---
> >>   Documentation/admin-guide/kernel-parameters.txt | 4 ----
> >>   drivers/acpi/thermal.c                          | 6 +-----
> >>   2 files changed, 1 insertion(+), 9 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index a1457995fd41c..2de235d52faca 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6243,10 +6243,6 @@
> >>                          -1: disable all critical trip points in all thermal zones
> >>                          <degrees C>: override all critical trip points
> >>
> >> -       thermal.nocrt=  [HW,ACPI]
> >> -                       Set to disable actions on ACPI thermal zone
> >> -                       critical and hot trip points.
> >> -
> >>          thermal.off=    [HW,ACPI]
> >>                          1: disable ACPI thermal control
> >>
> >> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> >> index f9f6ebb08fdb7..3163a40f02e30 100644
> >> --- a/drivers/acpi/thermal.c
> >> +++ b/drivers/acpi/thermal.c
> >> @@ -82,10 +82,6 @@ static int tzp;
> >>   module_param(tzp, int, 0444);
> >>   MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
> >>
> >> -static int nocrt;
> >> -module_param(nocrt, int, 0);
> >> -MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
> >> -
> >>   static int off;
> >>   module_param(off, int, 0);
> >>   MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
> >> @@ -1094,7 +1090,7 @@ static int thermal_act(const struct dmi_system_id *d) {
> >>   static int thermal_nocrt(const struct dmi_system_id *d) {
> >>          pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
> >>                    d->ident);
> >> -       nocrt = 1;
> >> +       crt = -1;
> >>          return 0;
> >>   }
> >>   static int thermal_tzp(const struct dmi_system_id *d) {
> >> --

Applied as 6.6 material, thanks!
