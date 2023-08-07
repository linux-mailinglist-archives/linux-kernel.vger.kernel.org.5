Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D256772A11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHGQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHGQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:04:35 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BD2E76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:04:33 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56cca35d8c3so2410918eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691424273; x=1692029073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00lWU5qpX2nokezLcZZ4LicPCOLtVutIYxfi78Nm55U=;
        b=pjPT/cQyzyqqarTtUX7rCamLHWtC8G8RXxPvEyklLTiaRptdK0aXw0qZnC34F/bUF5
         vzHMVmTL6WT9vhPrrko340lGHclJAwUeVt3osJWO/h7v6/nruwzeHj0kX6aQwqNKZejN
         zT9A8dqIbT57b+Jx1sjT381s+qwoLLdAT7MGczhPiwHHzDMBAtEXGxJdAOv9R3P21UXC
         YlzzA73jN0xutMNOrvJlfibS3t+ezTmbDkoiHDU4g/SMngWaynJ4NRVviKNE0ArHBIC7
         4FuLHkbVHzFFF5Vi0G5+WwEimtt888sX9Or1sKdMVoa4QnvN9zz8fWAbtJqR8w8Oi9/V
         6V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424273; x=1692029073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00lWU5qpX2nokezLcZZ4LicPCOLtVutIYxfi78Nm55U=;
        b=a18Y8C3+UbxHHdq+7/uU8utbd3cQgCeoip+WVA4GmCh3VJnpg2bW5UKoWsQzfBlm5y
         BwkkzGyFjAMKXke59hilwUYMOOZ0+vvUHUuqI66i/ZdCjzx9YUiIHfo9iDhDLzC9uq0L
         cnVmySk53/LFnBg1Unjqp1aqneF9To//Kbz2VPuEGewwpfdsQrN618bXNRX2S8g/yqgP
         wo+foQiD+oCOA5BNtuet9Y1tbphC+HAWLlNEQskRKB7wkqsnkniuk9iiKttpJ2XPffyU
         asTx6WscxrRYWMbKX8ns5ND7X00hl/r+c/bd9asjGFr82juek5jf7OS2jpablpF32bXn
         jjpQ==
X-Gm-Message-State: AOJu0YyTEJ83zMnUdj8TCE41smUBPDutXGujM7dHNCvm6Iwr/qAHC3U0
        EvQ4BGeuDQ+QjBD6MbhbJcs3mdDaEm/+eU0jOFo=
X-Google-Smtp-Source: AGHT+IGnNSql/fnXkfoPz5dfjdEUBhDNssaCcqFFDoqGJk+S0YGpZHEIx4dgcs2JClqcBtn8ccGvDYEUyOiWJ9clQR0=
X-Received: by 2002:a4a:6c59:0:b0:56c:cd04:9083 with SMTP id
 u25-20020a4a6c59000000b0056ccd049083mr7727173oof.1.1691424272706; Mon, 07 Aug
 2023 09:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130108.853357011@linutronix.de> <20230807135026.906384570@linutronix.de>
In-Reply-To: <20230807135026.906384570@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Aug 2023 19:03:56 +0300
Message-ID: <CAHp75VcR4KhhCidjjHG9d4Q65P4vbW3L-Mvkbr6Ar0FoJ=aQDQ@mail.gmail.com>
Subject: Re: [patch 09/53] x86/mpparse: Rename default_find_smp_config()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> MPTABLE is not longer the default SMP configuration mechanism.

not --> no

> Rename it to mpparse_find_mptable() because that's what it does.

...

> -#define enable_update_mptable 0

> +#define enable_update_mptable  (0)

Hmm.. What's the point of this change?

--=20
With Best Regards,
Andy Shevchenko
