Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3A7EAE98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjKNLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:08:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F68D9;
        Tue, 14 Nov 2023 03:08:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso8205288a12.2;
        Tue, 14 Nov 2023 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699960127; x=1700564927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzs3uuTisLyxpNk0sFPtfWNx5rmtQhYXvAqVvctScpQ=;
        b=hG6P/4RJO59CZGs2YWXIcCQsNji5FGNFAdkc38eGb0LOIIer4kJV/Pl78sZt22C23I
         RsbW+L4fj1INyZKlwsX85sqc/fdbLH0TtLNiBYhCb6ubn1h4LYyF0+pqhJHboZCs1mis
         vEI08eHy5QrcCRxbhkLxIB4aNuSiUGM3j1ogd/mZ/YPgW6giRkQjd46su+UdqGvEsIl5
         orgElOHfzAt0QjK9iBE1cddjSEJzq0c1g74vtzIZufWiP20w8L84UA/BJDAmiPbdpJ3h
         Uj2KmOwITc1JyWzmvbHSzeykjwYGN+ta5ku38h4OTA1hedb6caAxLCxQLLzgc1fMpNuJ
         I6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699960127; x=1700564927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzs3uuTisLyxpNk0sFPtfWNx5rmtQhYXvAqVvctScpQ=;
        b=uS8UD58nILEhy8B/lnoQzSHPjfqiq0qYmMqJJ/yKdPsUJK7ZV0kFSWyyP3nqWEYpPS
         zklKMeahM9sJrFwt8R2Ux/B8tuuYv3wP9C/qU0LvKKRnLmRpWKVEmTMXowVlrPGDE1Sx
         KbaEDmmqwte6KqeyBFzfhwrX1/WvkzfJX2IfNcLpO/cXs4sFrGElO1rot5uILlWViBkF
         cgtIeIIZG5kFMJvf6W+6c16pXdNkipesJB5PqEMdySE38y3LqOmL9e1xB44QJfKvsMA/
         O9oOOaNtw6OaCoiokaHz5GpqYxoj4dyZaAx++DHdLFC5CQ2NZJZ19yk3cFRi0GiHBTY3
         iRFQ==
X-Gm-Message-State: AOJu0YyQycl7HALi4RaUflrPtfP+3q9bdA+XJ4iAKWxRegkdUyw9NjJb
        KNY/c3qSYFg0D/vt2OYk6g/WqdKv4O9rlg/4RL4F6zuffK8=
X-Google-Smtp-Source: AGHT+IEmG8ogdTgM+rzKuvJKTvA6JmjQFCcEhPhvWKRyEQhn+7fJFh68XJKVnZ5KSpYJDxpQpOFVtJtegbCvfQGEepI=
X-Received: by 2002:aa7:d809:0:b0:530:7ceb:33c with SMTP id
 v9-20020aa7d809000000b005307ceb033cmr6925369edq.4.1699960127073; Tue, 14 Nov
 2023 03:08:47 -0800 (PST)
MIME-Version: 1.0
References: <CAD+OKUp=MA6VahvoM0cXgrM1uSwGtqaTV80-+x2VBLgN1RPzag@mail.gmail.com>
 <MW3PR11MB4522629E00039943AA0C6E9EA1B3A@MW3PR11MB4522.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB4522629E00039943AA0C6E9EA1B3A@MW3PR11MB4522.namprd11.prod.outlook.com>
From:   James Hutchinson <jahutchinson99@googlemail.com>
Date:   Tue, 14 Nov 2023 11:08:35 +0000
Message-ID: <CAD+OKUqg-Bp0_+kgaWNRhAx8nG8Ep=kY8CDp08+dvaVg=R3b2Q@mail.gmail.com>
Subject: Re: platform/x86/intel/pmc: regression found in commit 804951203aa541ad6720c9726c173d18aeb3ab6b
To:     "Box, David E" <david.e.box@intel.com>
Cc:     "Pardee, Xi" <xi.pardee@intel.com>,
        rajneesh bhardwaj <irenic.rajneesh@gmail.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problems - have logged this in Bugzilla as #218143:

https://bugzilla.kernel.org/show_bug.cgi?id=218143

Regards,
James.

On Mon, 13 Nov 2023 at 18:04, Box, David E <david.e.box@intel.com> wrote:
>
> Hi James,
>
> Can you file a bug at https://bugzilla.kernel.org/ under Power Management? Let us know what the bug number is. Thanks.
>
> David
> ________________________________
> From: James Hutchinson <jahutchinson99@googlemail.com>
> Sent: Monday, November 13, 2023 7:42 AM
> To: Pardee, Xi <xi.pardee@intel.com>; rajneesh bhardwaj <irenic.rajneesh@gmail.com>; Box, David E <david.e.box@intel.com>; ilpo.jarvinen@linux.intel.com <ilpo.jarvinen@linux.intel.com>; hdegoede@redhat.com <hdegoede@redhat.com>
> Cc: platform-driver-x86@vger.kernel.org <platform-driver-x86@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: platform/x86/intel/pmc: regression found in commit 804951203aa541ad6720c9726c173d18aeb3ab6b
>
> Running here on an Intel NUC 8i3BEH Coffee Lake machine under Arch Linux.
>
> Connected to this machine I have 4x USB DVB Cards (2xDVBSky S960
> DVB-S2 adapters & 2xGeniatech T230 DVB-T2 adapters), and I stream TV
> Channels around the house via Tvheadend.
>
> Since linux kernel v6.5 onwards I noticed a bad performance regression
> whereby the streams are basically unstable. There are tons of
> continuity errors in the Tvheadend logfile, and the picture and sound
> are badly broken up as though the system is throttled or does not have
> the bandwidth to cope with the streams.
>
> Sometimes the stream will work for a minute or so after reboot, before
> then becoming unstable, and then seems to remain unstable until the
> next cold reboot.
>
> I dropped back to v6.1 LTS (where everything is fine) and re-tested
> following the release of v6.6...
> ...the problem had not gone away so I performed a git bisect to
> identify the culprit and found this to be:
>
> 804951203aa541ad6720c9726c173d18aeb3ab6b: platform/x86:intel/pmc:
> Combine core_init() and core_configure()
>
> I can work around the issue by either reverting this commit or by
> disabling CONFIG_INTEL_PMC_CORE and rebuilding the kernel manually,
> either of which results in perfect DVB streaming once more.
>
> Happy to test any potential patches or otherwise provide further
> information as required.
>
>
> James.
