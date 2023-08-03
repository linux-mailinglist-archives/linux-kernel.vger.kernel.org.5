Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7515976E5D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjHCKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:43:24 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7210EA;
        Thu,  3 Aug 2023 03:43:23 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56d0d7300d9so507902eaf.1;
        Thu, 03 Aug 2023 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691059403; x=1691664203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzC8Qnuib0z5j3d/zPXRW1Uzz/BCxOapNV+gec9b/XU=;
        b=GegarbmHsu7q1i6srh8l1zWxJxTne3JGBiAo3ZcFoJm/UBMCJR5QtbD9hsdpeUshE4
         5vF8RDNEeCkQdF3bPDwZ0+TMJanfc15ORepq3/B5temQvf+jf0DNcvPrmXKTYrZ7T8BX
         t1w5DaxDcjya8DtiRicIP9hOBrtiqFNjWobdtIxdr8G/CK5iJBP3TFddyhpqOc9h5AtP
         Bgcboa6I/erPLh9bAnm6QQXXL966iVeubkOnV73wZCvvRhUXO177wINfjHPJ88Uh2EHe
         xIHgdmEfk5lp6H3Gx4oFBvGcbZhHSQJiqFtAD4VMDx8IyIhCrYfX2A7jQfNSpJQWHqxz
         Fm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691059403; x=1691664203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzC8Qnuib0z5j3d/zPXRW1Uzz/BCxOapNV+gec9b/XU=;
        b=Ec4GmttuaSEhMFP12D/WjSLmB7GCyy/znmcwv4ywQrI4m2WtQrKlljfUSXN4KDOAma
         H2Nn6+7PVuhIvhlVYvQjLbrVrH2NgZXA3rnnQnYOYAx4IlR1uxkvKXC0uGKh/lHQdQcS
         JrhY+Kj+x99jbeECFGwRxRm4dh4NS4Id1nHvzLt6CjJL8X1ycQKDloTR44pbWDEgqtZu
         nQx44eyGH13acfsE5ocGef7K1kL3FRy/PkMeECU6PmZGFBPHXRSs6yT5D3HwDF34ucEb
         lx3GfRbXF6ZqjBoNZOASVKP6n05s0imIZ9YxAHF++xDGqBsdRnkBNBlHN4wjCKB1a0/5
         JMGw==
X-Gm-Message-State: ABy/qLbKyBqxZXAqKzaoiZrR3LssDB3aI166ssaPl31qXNHWM4OEo8+e
        Qh/2gROq/l2cs7k50oFtUltmb9Cy8Kd4aRYNgnjFV3QC4H4=
X-Google-Smtp-Source: APBJJlHNQZ8ga6T4hNm6ObNQ7h4nLqhISnLKVMdLTpHZkptkZuxG7Sxg1v76gHI5ruG6Q2+WxS2bvFT1Qdu9PUpxgG0=
X-Received: by 2002:a4a:d2c8:0:b0:56c:7120:835f with SMTP id
 j8-20020a4ad2c8000000b0056c7120835fmr14724604oos.5.1691059403010; Thu, 03 Aug
 2023 03:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com> <f0cc1d69-71a2-e50d-07ea-b17ab26d6cf4@igalia.com>
In-Reply-To: <f0cc1d69-71a2-e50d-07ea-b17ab26d6cf4@igalia.com>
From:   yunlong xing <yunlongxing23@gmail.com>
Date:   Thu, 3 Aug 2023 18:43:11 +0800
Message-ID: <CA+3AYtRxEb8bY-TskrHvJ6VeB9soLL5=si0p5ZVmz4rQKvyW=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, keescook@chromium.org,
        tony.luck@intel.com, joel@joelfernandes.org, enlin.mu@unisoc.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        enlinmu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 11:47=E2=80=AFPM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 01/08/2023 03:04, Yunlong Xing wrote:
> > [...]
>
> > diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> > index 85aaf0fc6d7d..eb6df190d752 100644
> > --- a/fs/pstore/ram_core.c
> > +++ b/fs/pstore/ram_core.c
> > @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persiste=
nt_ram_zone *prz, u32 sig,
> >       sig ^=3D PERSISTENT_RAM_SIG;
> >
> >       if (prz->buffer->sig =3D=3D sig) {
> > -             if (buffer_size(prz) =3D=3D 0) {
> > +             if (buffer_size(prz) =3D=3D 0 && buffer_start(prz) =3D=3D=
 0) {
> >                       pr_debug("found existing empty buffer\n");
>
> Thanks for the patch! I'd also adjust the above print statement to
> reflect the different paths (empty buffers vs illegal one) and maybe
> bump it to pr_info, or even pr_warn(_once?).

I don't think it's necessary.
Through testing, the probability of this situation occurring is still very =
low.
Using 20 devices, reboot every 10 seconds, and only once after 96 hours.
The panic stack information is as follows:

case A=EF=BC=9A
 sysdump_panic_event+0x3b4/0x5b8
 atomic_notifier_call_chain+0x54/0x90
 panic+0x1c8/0x42c
 die+0x29c/0x2a8
 die_kernel_fault+0x68/0x78
 __do_kernel_fault+0x1c4/0x1e0
 do_bad_area+0x40/0x100
 do_translation_fault+0x68/0x80
 do_mem_abort+0x68/0xf8
 el1_da+0x1c/0xc0
 __raw_writeb+0x38/0x174
 __memcpy_toio+0x40/0xac
 persistent_ram_update+0x44/0x12c
 persistent_ram_write+0x1a8/0x1b8
 ramoops_pstore_write+0x198/0x1e8
 pstore_console_write+0x94/0xe0
 console_unlock+0x3a4/0x5d8
 register_console+0x3ac/0x488
 pstore_register+0x1f8/0x204
 ramoops_probe+0x460/0x508
 platform_drv_probe+0xb0/0xf4
 really_probe+0x1c8/0x7d0
 driver_probe_device+0xc0/0x140
 __device_attach_driver+0x10c/0x200
 bus_for_each_drv+0xa8/0x11c
 __device_attach.llvm.1835537715725466631+0xf0/0x19c
 bus_probe_device+0x40/0xe0
 device_add+0x964/0xb8c
 of_device_add+0x40/0x54
 of_platform_device_create_pdata+0xb8/0x140
 of_platform_default_populate_init+0x5c/0xd4

case B
 sysdump_panic_event+0x720/0xd38
 atomic_notifier_call_chain+0x58/0xc0
 panic+0x1c4/0x6e4
 die+0x3c0/0x428
 bug_handler+0x4c/0x9c
 brk_handler+0x98/0x14c
 do_debug_exception+0x114/0x2ec
 el1_dbg+0x18/0xbc
 usercopy_abort+0x90/0x94
 __check_object_size+0x17c/0x2c4
 persistent_ram_update_user+0x50/0x220
 persistent_ram_write_user+0x354/0x428
 ramoops_pstore_write_user+0x34/0x50
 write_pmsg+0x14c/0x26c
 do_iter_write+0x1cc/0x2cc
 vfs_writev+0xf4/0x168
 do_writev+0xa4/0x200
 __arm64_sys_writev+0x20/0x2c
 el0_svc_common+0xc8/0x22c
 el0_svc_handler+0x1c/0x28
 el0_svc+0x8/0x100
>
> What do you all think, makes sense or could we pollute dmesg too much?
> Cheers!
