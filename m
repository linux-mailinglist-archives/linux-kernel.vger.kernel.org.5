Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4980E7EBAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjKOAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:54:42 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3CCC7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:54:37 -0800 (PST)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 483EA40262
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700009676;
        bh=WDpC+/TU8OYxwd/ov/BIBH/XSQn/0HPjA18j9hJej6Q=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=TPHgo+LylhDCJ8i4MFjUMv/pvzb8ZhEiGPvRop6QHIWKT+lh/+hmwRLiMSVM/iUpB
         vzWWUylpPyJfaV7nt96tY5yLgYHVRoI5QRQ2UqZyGWjq1hvm+kzxSj5bG0ydFmKTEU
         s9ophOHZsOzArppr+yCSMksv5ufBB5jerCcuebGM2rTJgxwVEkkZocUCjdxm5yGdjQ
         oaaKvJN7Ee68ZO0w8oPKNQYqr8Xi6FPqn8r3ZYQ2tTNlJksQtu0VxGiINEii2jHuIn
         Pm0TNzZV5L6+0svzy6YafJ3D0Dxg3jhwt94UnOEtgauuPC4TrxIZD6Wpuboo/Vid4a
         G9vZWdrEpQiRw==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-581da174501so5886621eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 16:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700009675; x=1700614475;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDpC+/TU8OYxwd/ov/BIBH/XSQn/0HPjA18j9hJej6Q=;
        b=XZt78mCqNPlE1DntAr3aQwqZWAfkd9JNh0dH9nxCFndPoOcPfFvrZWe/jntFyEJutP
         oI67g0hy0JuFLswD37u82F4Znwq6o3Hieg+EIPnyDoH0ZnsekMRO23iTmsQiVJYKCgYy
         PuC4yT/XSFGvGcJEVZly/u0z30tsMetIl8fph9DvYeF1EvakQwb+hZSkhXeF3TPqkFn1
         Rnadg/OJ9O+MSY421ezZNPTH0XNjyliRI0LqhP+ZUHRG0sku5lS6ukjh/dJ/+64uKCB9
         BC2vBdDJ0hSsg8IbQKstRMyq8snYnAHLMtyu/cmC5hM4kZt/MIIStXXw/cwXoLytzjMt
         BDcw==
X-Gm-Message-State: AOJu0YzEYAJvCg8kYRP+taqe3ZKgSUv0+rRbbPM+NrbGgUzSddJf/QPl
        LV2bxOTVyb7uUrye+blRXGFOeDGAUDU3PdRBnTgJdUs5oEvltKEd995vFmuf7RWlWSH0ctU2wVN
        5nblJQArzOK/Z6K20pzh2Q0ScMbElHoTwNQciMEDaow==
X-Received: by 2002:a05:6358:24a3:b0:16b:7049:e8f9 with SMTP id m35-20020a05635824a300b0016b7049e8f9mr4744187rwc.8.1700009675079;
        Tue, 14 Nov 2023 16:54:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjS1Eza3HfJ+1w5VNAFHLX0iHyrhrcjQz7hpZTmu4fpoC03xWrJ7Vip0QyJP/Ynp1eP/c67g==
X-Received: by 2002:a05:6358:24a3:b0:16b:7049:e8f9 with SMTP id m35-20020a05635824a300b0016b7049e8f9mr4744177rwc.8.1700009674772;
        Tue, 14 Nov 2023 16:54:34 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id a20-20020a634d14000000b005b83bc255fbsm136600pgb.71.2023.11.14.16.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2023 16:54:34 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 02DAE5FFF6; Tue, 14 Nov 2023 16:54:33 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id EFDF99F88E;
        Tue, 14 Nov 2023 16:54:33 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anil Choudhary <anilchabba@gmail.com>
Subject: Re: sr-iov related bonding regression (two regressions in one report)
In-reply-to: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
Comments: In-reply-to Bagas Sanjaya <bagasdotme@gmail.com>
   message dated "Wed, 15 Nov 2023 06:59:06 +0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32715.1700009673.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Nov 2023 16:54:33 -0800
Message-ID: <32716.1700009673@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> wrote:

>Hi Thorsten and all,
>
>I come across LACP bonding regression on Bugzilla [1]. The reporter
>(Cc'ed) has two regressions. The first is actual LACP bonding
>regression (but terse):
>
>> Till linkx kernel 6.5.7 it is working fine, but after upgrading to 6.6.=
1 ping stop working with LACP bonding.
>> When we disable SR-IOV from bios , everything working fine
>
>And the second is out-of-tree module FTBFS:

[... skip OOT stuff ...]

>
>Should I add the first regression to regzbot (since the second one
>is obviously out-of-tree problem), or should I asked detailed regression
>info to the reporter?

	My vote is to get additional information.  Given the nature of
the workaround ("When we disable SR-IOV from bios , everything working
fine"), it's plausible that the underlying cause is something
platform-specific.

	Interestingly, we've been chasing internally an issue with
bonding LACP mode on ice (E810-XXV, I think) when running on the Ubuntu
kernel.  That manifests as occasional TX timeouts, and doesn't happen if
the Intel OOT driver is used, so I wonder if that bugzilla reporter is
also seeing TX timeouts that correlate with their ping failures.

	-J

>Thanks.
>
>[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218139
>
>-- =

>An old man doll... just what I always wanted! - Clara

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
