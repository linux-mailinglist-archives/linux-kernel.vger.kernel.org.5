Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE067D7276
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYRiA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJYRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:37:57 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBDB181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:37:55 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e99b05c8f4so595261fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255475; x=1698860275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgnP6sRKjtsw0eyoGkM/oxKWHVsXQhLZa9uKQ+VKj7g=;
        b=MrO7DVCN9M2AqALdIAsrlLn9zSZ3LHGEza2gRMjECcQmiDYVZBOMY5WOV9uKfTRcwW
         ntvDd8YUa0h8VB4BDuG48dIb0dWCnPWI3ahf7zSC7JBzvZdV4/NFRBFfzFzfCuy4CCK3
         t1srLs1gegN2LF710mBBY93pAZylBfxaJVH0x7CcBME6uM07md3bqkiIV5M1k2/gbClK
         330gvqd5YkLwx6JH7JJQ5a8E9tMcV+AxszEZrlBNhfE/ZaeHOXS0ic5+2m7ACI+qBJGa
         W4tfkPxeLojd+dMtcsDJEhod9n6+9TTL/5xFWc8vv1fP0nhODxqUTSnmCAHUR3Tnhj4u
         Bd/Q==
X-Gm-Message-State: AOJu0Ywh1PtwDX1UoVCbKaZ+/Xa0rgIHVcyUDLw52uxSNL/v5hxrgI4v
        stwSnLX5cqa+EmXWSXnNZ0Xk4Ra8N6PQiC0HdOw=
X-Google-Smtp-Source: AGHT+IFJMil7pFFO7TwFVb92Vb/j02jLmMuDXJwdCiJMhYyVC/zPHOdLjJ1y39qbP2asrkZc6TRUULyhmFwiaCCkL58=
X-Received: by 2002:a05:6870:9f8a:b0:1d5:1a99:537f with SMTP id
 xm10-20020a0568709f8a00b001d51a99537fmr18854775oab.2.1698255474892; Wed, 25
 Oct 2023 10:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com> <878r7z4kb4.ffs@tglx>
 <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com> <87ttqhcotn.ffs@tglx>
 <87v8avawe0.ffs@tglx> <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
 <ZTkzYA3w2p3L4SVA@localhost> <87jzra6235.ffs@tglx>
In-Reply-To: <87jzra6235.ffs@tglx>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 19:37:43 +0200
Message-ID: <CAJZ5v0gS8c75ar2E1kg-h5rDGoXXxM04Vs1y8gt+ro5ZjEU2+w@mail.gmail.com>
Subject: Re: PIC probing code from e179f6914152 failing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Lazar <dlazar@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 7:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Oct 25 2023 at 17:25, David Lazar wrote:
> > --- On Wed, 25 Oct 2023, Mario Limonciello wrote:
> >> David - can you see if the below helps your hardware?
> >
> > The keyboard and mouse work fine with Thomas' patch.
> >
> > I've uploaded the debug info to the bug:
> >
> > https://bugzilla.kernel.org/attachment.cgi?id=305291&action=edit
>
> Let me write a changelog then. Unless Rafael has any objections to that
> approach.

I don't have any, thanks!
