Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEEA8035CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjLDODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjLDODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:03:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF24E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:03:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c671acd2eso3559820a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701698603; x=1702303403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZl9fhFqbyUE2QAE/hn5dn7UESqFuFxtWyhwIBYWh68=;
        b=C5IGklQJhRwnYi30921QUPkD8R0hEDufd4lDoBEJ6AWG3CnSIy5MncFXEbpm/2t5YV
         3wikMiCYnJ7RLG4VLMmIkeX5evG3okKtirwDUwVyCAyRo+jk2t+eKqf2jN0Nc2udwMSq
         SDRh6l4V5vzgFadWHi159FlEWiNqKRyGv/5CxEZ29sUJOxyeQOABp8rf0y99bkrD5izI
         3xJpqQJO4NoT/Cox/wpL9d9xhy/DWusM/GZL8vlWDdNhnKnANEUugvvs6Zu8RvW5xyvl
         4xefNI0BreP+B9r1n8KSY7wcKo1eJBWczHfAONV9iE82FzAbDtPQ+BFfQLS2DVZQLLbN
         4KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698603; x=1702303403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZl9fhFqbyUE2QAE/hn5dn7UESqFuFxtWyhwIBYWh68=;
        b=OUD+9eSdOZeJuITseV+0Wyxc9Vfi/JJE0z8W1joluiY7MVr2mtjfuvWBspkNhBnNrT
         uaq4pmpaIgB4ylZ26wqWYpexEQCCckJr+J74HAvvMNVl9dHMcOlUJhZHbor25Livpf8Z
         yD70LWjAuc72qhIn6nQf/ArmngUE0HgEnC331v2x6vHOT0mYXSjErgzg70OEk9At7UWD
         4kDBzGttTXCjqWJYmJnJmFst4KOHq+Y9zMEUc0P4JzLPnsaUW+kF1OBu2bCU7TM1hTzy
         LfneP16T0n/ajcyBkDzA69JUgVqf+WgJxWXZazRZi7Lwz1hSpfFE0UfRjiOOnz6uKaUL
         vIEA==
X-Gm-Message-State: AOJu0Yz7WauhWHx1VHmTUL5IaOr5o+gZyCW1GM6C5KAuYsHOIqm/Sf6i
        ee0IvAquFRr5M9oVLAfoqPd6Y2nXjx65rJRtPhI=
X-Google-Smtp-Source: AGHT+IHapyPGWDrdwM8q/14CfWC1MGm3nFhXi1RE1H768BLInmNVt4rdmD69rm96hFX1iTvjmmXLCe0s9kEjK1qfc+8=
X-Received: by 2002:a50:999a:0:b0:54c:4837:93f1 with SMTP id
 m26-20020a50999a000000b0054c483793f1mr3229384edb.56.1701698602856; Mon, 04
 Dec 2023 06:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20231203232017.994963-1-ubizjak@gmail.com> <20231203232017.994963-3-ubizjak@gmail.com>
In-Reply-To: <20231203232017.994963-3-ubizjak@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 4 Dec 2023 15:03:11 +0100
Message-ID: <CAFULd4aPtQ4YmBunxYf_jkSkw50rLgYqD_upnYqt8PH3NzYNWg@mail.gmail.com>
Subject: Re: [PATCH -tip v2 3/3] x86/percpu: Avoid sparse warning with cast to
 named address space
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 12:20=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Currently sparse does not know about __seg_fs and __seg_fs named
> address space qualifiers. Avoid thousands of warnings about unexpected
> keyword at the end of cast operator by removing named address space
> qualifier from __my_cpu_type() when __CHECKER__ is defined.

We have discussed this issue a bit on the linux-sparse ML [1], and the
proposed solution is to define:

+#define __seg_gs __attribute__((address_space(__seg_gs)))
+#define __seg_fs __attribute__((address_space(__seg_fs)))

as done in the attached patch.

[1] https://lore.kernel.org/linux-sparse/CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS=
6PQd1Bec-2NicUiwQ@mail.gmail.com/T/#md048c918cd2145c822727e3aa401326e166084=
2f

Uros.
