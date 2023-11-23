Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25407F56EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjKWDNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:13:17 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BB1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:13:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb749044a2so478949b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700709199; x=1701313999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi0aE1CoZEk7o6yHZvNub+boTKgxjNTVuh11lvWZM4g=;
        b=b2ZP1mZdzt9gFRURjq+yET0C3r3VYg9X2lCymJfht8NZXKDDdsxeE7+HqrH6CSKr8H
         yztzramo77ElrtHy0BF9K8+ptxzNfjmWySeseUGOBy/6YCG583RvDjtDlt6JxNusbawv
         A9d9NNzNmYxqSAv6t/uURtEWH33NuZM/x0tW/smaMq0ovaqJBnWlv5toAF4/dYxUNIUv
         L3lQuLTPCt0s+gIY1EVgJgIo0DwdFNcYZ8CX+lqEcVD0FRQTaKTplJTc+jXKhX5h0903
         uEuzE6idcLCd5OHxaPsSdm0EWgRMis80pKUE4vgIO0ZaIMGVwbIG4JLwW2Fca2WINrk/
         htHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700709199; x=1701313999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi0aE1CoZEk7o6yHZvNub+boTKgxjNTVuh11lvWZM4g=;
        b=Xctvj1FZgK9j4s3Ya9T5Hw8vCmKvpXNWf+vFj5b1+/ReIaNLOopKeTuoG1BKcUhgbl
         e8p3W1E2dJhOElqx8TQo/vfCoIIJWSzgAMPZppqXulEXn81HqUmqaleLrwkfmCPUTETY
         FKw1a4Kj5DZiOEqz6yPz+k/tUaterrs2Td0PU2hffvrKVlAFyZTmpXvUyWxLr0B6Ed6d
         3q+nRs4ZL8ynj1veCgtiIqY0bf/mQjQl0acHSyl3PfEK25LDsWl2u3DR6D0ykJbcxuDx
         BprYsncrBD33+x2dMmgWh/BfuL+VRTaQkXzdnNvzR3cglMYZA3B34+s/ImKhiZIwNap7
         y/cg==
X-Gm-Message-State: AOJu0Yxqrd/8mKWacgxOFPVL0j3MKHZPQtQQxUCNDlwhxiADUd0Of694
        6FqRRg9YbpZxDsPWn5Ixif9U78O9lNDknaf7GME=
X-Google-Smtp-Source: AGHT+IHt4hthutASlMgvdhFoiArw0XnpaAVx8FxkQ+NPQuFgYtoa5NqV6xqOC2fb2D5pPuF7+GHx2x9gz0nIh9QCvLQ=
X-Received: by 2002:a05:6a20:e11b:b0:187:7af3:bb0c with SMTP id
 kr27-20020a056a20e11b00b001877af3bb0cmr5645234pzb.58.1700709198541; Wed, 22
 Nov 2023 19:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20231122231202.121277-1-andrey.konovalov@linux.dev>
 <CAB=+i9QFeQqSAhwY_BF-DZvZ9TL_rWz7nMOBhDWhXecamsn=dw@mail.gmail.com>
 <CA+fCnZdp4+2u8a6mhj_SbdmfQ4dWsXBS8O2W3gygzkctekUivw@mail.gmail.com> <CAB=+i9RnOz0jDockOfw3oNageCUF5gmF+nzOzPpoTxtr7eqn7g@mail.gmail.com>
In-Reply-To: <CAB=+i9RnOz0jDockOfw3oNageCUF5gmF+nzOzPpoTxtr7eqn7g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 04:13:07 +0100
Message-ID: <CA+fCnZcpLE_uR4D9eyUA9_TzF0w2GgY=yWYB63b2VL1snAQi1Q@mail.gmail.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Nov 23, 2023 at 3:58=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> 1. I reverted the commit "kasan: improve free meta storage in Generic KAS=
AN",
>     on top of linux-next (next-20231122), and it is still stuck at boot.

This is expected: the patch you bisected to still requires this fix
that I posted.

> 2. I reverted the commit "kasan: improve free meta storage in Generic KAS=
AN",
>     on top of linux-next (next-20231122),
>    _and_ applied this patch on top of it, now it boots fine!

Great! Thank you for testing!
