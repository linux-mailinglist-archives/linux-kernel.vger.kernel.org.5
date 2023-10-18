Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C67CE5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJRSAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjJRSAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:00:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEC1705;
        Wed, 18 Oct 2023 10:59:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7b92cd0ccso89023377b3.1;
        Wed, 18 Oct 2023 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697651971; x=1698256771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlNVWCi4tE73KJBUGhTGPmq/A6sZ0EfC9I/MgZZhxjI=;
        b=Ivo44lRY4SQth2GmoEFWR1n9WqSv5s+EVSv4Es1Q6RoNe1JId2iytw7Jv0ReRQCcYz
         AvSHiMsKel0FFRfW6Dnx5Fcu4pDCLYf9iSMh9mNJIvxPbEPYHdseDBI+JjE1g41bW+A2
         L7PFnoM2CbXybZfc+NWB4AXzRrR8lXbl6qyoGgXzqGNaj2rLo56any2oQD1BZa1l0PVI
         yGl83XQiUsLeHBNa/ZK2I6QumPeXeqmMAkmKyDReFlFwzu7MFWZ/KnXg327Gu3p0gQ6V
         NuVPxlK+gp9ADR4+IjLbEHcHPmPc8PdTTGdzupSzfAP4bS6BD83phz9wlj0YuxKTxl+M
         VQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651971; x=1698256771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlNVWCi4tE73KJBUGhTGPmq/A6sZ0EfC9I/MgZZhxjI=;
        b=NNtRaSCgKexKwS3Di6u+HmP3tnH0dsdIJn9kLDsNFMxGycBVzaJW2oW31D0ADfG7BG
         Tmv18Re1rfde+yAyeTXtu9h5WMuJglTXCL/70Bvt/J3YrASqMT6VDhiz+RqI5qTLFm9t
         YaP8mCwTQd3OZ/SsoDZQIaMU5ZGwuEu1EBFSuAJcNEZi+fZE2wuikJD2CJX0Ev8/t2IR
         GJ0EXmlbKoJhqvSK/1pWrpnmMnruDWF8+GvCCQiqWTRorrGxjW4o6M2qXMWgVNaPrj9D
         m/ekLcYOyNDgFpwjZEklkD540uz7VOQrHaZHu6sZO0/9Gs0FGGTQzX1o5Gm9DQA2gPuC
         cJaA==
X-Gm-Message-State: AOJu0YxA2U/2zcayiQugMSYxa2deKcbjaAAJJ6LA+V6Wy7CKsgnvY+T4
        vKj7Sh3fTj1B4gx+c+HjJSs/JKCwhjzuXyGuzUM=
X-Google-Smtp-Source: AGHT+IFMyKYl82McilUEskZqL7Dc31EK4FlzSOjTjDfmE9ABll/uYNWrGeOW76WuNKalR/CJUMgf/LwJVFwHxxZg+rw=
X-Received: by 2002:a0d:cc04:0:b0:5a8:277f:b378 with SMTP id
 o4-20020a0dcc04000000b005a8277fb378mr15878ywd.1.1697651971126; Wed, 18 Oct
 2023 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <1a0c4378-29b2-43b4-982b-0d92dfb8ed4f@kernel.org>
 <20231018005220.2551586-1-lihaonan1105@gmail.com> <8332cf70-1451-6903-562f-1d16e4c243ae@omp.ru>
In-Reply-To: <8332cf70-1451-6903-562f-1d16e4c243ae@omp.ru>
From:   Haonan Li <lihaonan1105@gmail.com>
Date:   Wed, 18 Oct 2023 10:59:13 -0700
Message-ID: <CAE4BR8L-SODeOa3OAV9Z5h5jMfLpRnKwDnSMx7y6nXH-M2NkUQ@mail.gmail.com>
Subject: Re: [PATCH] pata_lagacy: Handle failed ATA timing computation in opti82c46x_set_piomode
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

Thank you for pointing that out. My main concern was the potential
for ata_timing_find_mode() to return NULL, causing ata_timing_compute()
to return -EINVAL. While this might be rare, I thought it would be
safer to handle such cases.

However, if the common practice in drivers/ata/ is to ignore the result
of ata_timing_compute(), let's drop the patch as needed.

Thank you for your time and feedback.

Best,
Haonan

On Wed, Oct 18, 2023 at 10:15=E2=80=AFAM Sergey Shtylyov <s.shtylyov@omp.ru=
> wrote:
>
> Hello!
>
> On 10/18/23 3:52 AM, Haonan Li wrote:
>
> > The function opti82c46x_set_piomode utilizes the ata_timing_compute()
> > to determine the appropriate ATA timings for a given device. However,
> > in certain conditions where the ata_timing_find_mode() function does
> > not find a valid mode, ata_timing_compute() returns an error (-EINVAL),
> > leaving the tp struct uninitialized.
>
>    Looks like it's very common to ignore the result of ata_timing_compute=
()
> in drivers/ata/...
>    Mind sharing the "certain conditions"? :-) I don't think the set_piomo=
de()
> method can be called by libata itself with an unsupported xfer mode...
>
> > This patch checks the return value of ata_timing_compute() and print
> > err message. This avoids any potential use of uninitialized `tp`
> > struct in the opti82c46x_set_piomode function.
> >
> > Signed-off-by: Haonan Li <lihaonan1105@gmail.com>
> [...]
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> MBR, Sergey
