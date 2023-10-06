Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6547BBFBB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjJFTar convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjJFTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:30:46 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D283;
        Fri,  6 Oct 2023 12:30:44 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57be74614c0so125150eaf.1;
        Fri, 06 Oct 2023 12:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696620644; x=1697225444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuKl5KaDg+pyNLcIMdUQdNVHBW291e75bQagS3FL0iQ=;
        b=ASbWo/TUxL0aB2oJd1VTQ9n5S1MqWZjTCthWbkwWIXBNwWEzkc3zciH+s30pY5SrPY
         DovDg2hyeq5sk245YbVCxsjNITQ1hx1RusP8WK36SBFQjbz5Vr4jT58q96sbFxkdm44+
         ApD4Y5m++og6u6s9+vP0dLIZNd6agvVdbhf7lyYA57uGmL21mDBKn2pGfWR0yrCxSYPo
         MwAefdLRgXqbsn0ScNnMC4aitRtn5VN9d5Qy6gPvL2E/xsNJ78trBy7PrvmDlE3pqU5h
         ryoILnc2EcJXWym+eMdpZH+xqI5Oi/M+EOHVieIcxL+Q1v4EfDo90Jk14FltILvslVZz
         rIuw==
X-Gm-Message-State: AOJu0Yy6iUdb92wn+KLlBJpIRLgEoS/k7SaMKOHlneCs2NYvmRHE13II
        YKfokzlGTqQhxezxMjYZG1Wv1xR7xotAsUGdtNmVsWNhHl0=
X-Google-Smtp-Source: AGHT+IH9VWGIKHbqmkdamXGHCCSy0uN+1ur6XMncRy4fDozmzedAhMeLXcDN9rZwIxsit1BOxiSi1mxoRRzUath/TKE=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr9655668oou.0.1696620643727; Fri, 06 Oct
 2023 12:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230929134010.25644-1-wse@tuxedocomputers.com>
 <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com> <5d82fcac-a360-2d8b-8f6a-9b5cecb08ca2@tuxedocomputers.com>
In-Reply-To: <5d82fcac-a360-2d8b-8f6a-9b5cecb08ca2@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 21:30:32 +0200
Message-ID: <CAJZ5v0gO77ydCfs8m4w3Juwg2B85ZZ=zY-zQptB0UmKvxBnd3w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 11:38 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> Hi,
>
> Am 03.10.23 um 20:39 schrieb Rafael J. Wysocki:
> > On Fri, Sep 29, 2023 at 3:40 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
> >> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
> >> for the keyboard to work. Adding an entry for this laptop to the
> >> override_table makes the internal keyboard functional again.
> > You said "again", so it used to work.  Do you know which commit broke it?
>
> Sorry that "again" is a bit misleading. I Copied it from here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7592b79ba4a9
>
> I actually only tested the direct predecessor of this Notebook on older kernels:
> https://bugzilla.kernel.org/show_bug.cgi?id=216698
>
> I suspected that it's the same issue and since the same fix worked I now even
> more believe so, but I actually never tested a kernel before the breaking change.
>
> >
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> Cc: <stable@vger.kernel.org>
> > What's the oldest kernel version you want this to be applied to?
>
> 5.15 because Ubuntu 22.04

So first of all Hans posted this:

https://patchwork.kernel.org/project/linux-acpi/patch/20231006123304.32686-1-hdegoede@redhat.com/

and I'm wondering if it addresses the problem for you too.

If it doesn't, the patch will need to be rebased on top of the new
acpi-resource material in linux-next and retested.

Thanks!
