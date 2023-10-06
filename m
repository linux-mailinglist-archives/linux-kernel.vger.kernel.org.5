Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F037BBE83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjJFSP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjJFSPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:15:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720BBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:15:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81afd5273eso2605690276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696616122; x=1697220922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYLhV8RKvbCInhnzqZ/HGBAbLzuMZXeZ10wGn+QIDt0=;
        b=agZMnV/HJlJNR+eXnUqkrCNrnhdt8cTuH8KPxM8I0UlHzDgSB7yZOnfEzjuFFKmcys
         px5mNgUlWMDvOhhIQ0tlHY+8PJ6lEWdjJPSApcLl/imzQggHqLnKYP1xPJpvbKX7Pxv/
         8kR/kNwBWBPMQjEU7AXu3y2seqJXmjp4CTdY4oB1MHnwBAD2awuAUZPZnHR4vh0brRey
         GhZvL/kPa8oQLPzBPzQ1kfkPRDz7LJIeNOKK/15bFxj9KCs7KIWsjDEqTIHOSh+IwdEf
         ag4eZsxXhkYwVL5qydQ7mcnxfV/I44GhPcxTxAOWs1vxEnC+e8YwG+HGK+zixX8m9djt
         T7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696616122; x=1697220922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYLhV8RKvbCInhnzqZ/HGBAbLzuMZXeZ10wGn+QIDt0=;
        b=pP/jW2hjOm2HS5IVM9Z8TVM16SrfixcPN3cfXzErGlYMvpuyU6fb2sBtHx2eFARStY
         f+AhSVKCfP3eC6Oixp4tPLAmGz/ippQcgTinMt5SOheQNIN9f2allb0/tPCpJWPxInbD
         jwKYJmF4TbbGCiCCnA2N/eTuIlhJZXtQlWCpgTSzRkGx99E5wOT7/zdhSaUmODoOqmxh
         cbrcCRrMwZCYYH8lFnvoSZSLw/84pw4TAQIhv6RwdtVWpj8vC2E/OAnRB2pk067sF6Z9
         O3sFud3vR+0CdReW2gwKS0yk6w2OKjGFyJSJfV9bhSXG/VKzE+is70KGlzGl2l1fjMaD
         K/fg==
X-Gm-Message-State: AOJu0Ywfqxjmc/xaiQWzerJA8KbVLRCtTtkllVisHV/kCo5psZTYB9qL
        PICfWnNrC9fgWzvSR2wMZkXTxPpkd7SpW268bGlu6w==
X-Google-Smtp-Source: AGHT+IHzqypY4NdUT7zu05+MFHgfnxNiLO+3lSgUozk3D6Rhta9XqDneUgYhohjCWFkKwZkcLQmr90WO9qHqGTSh0Io=
X-Received: by 2002:a25:509:0:b0:d7f:cdc8:e184 with SMTP id
 9-20020a250509000000b00d7fcdc8e184mr8607707ybf.49.1696616122514; Fri, 06 Oct
 2023 11:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-5-john.g.garry@oracle.com>
In-Reply-To: <20230929102726.2985188-5-john.g.garry@oracle.com>
From:   Jeremy Bongio <jbongio@google.com>
Date:   Fri, 6 Oct 2023 11:15:11 -0700
Message-ID: <CAOvQCn6zeHGiyfC_PH_Edop-JsMh1gUD8WL84R9oPanxOaxrsA@mail.gmail.com>
Subject: Re: [PATCH 04/21] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic
 write support
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is the advantage of using write flags instead of using an atomic
open flag (O_ATOMIC)? With an open flag, write, writev, pwritev would
all be supported for atomic writes. And this would potentially require
less application changes to take advantage of atomic writes.

On Fri, Sep 29, 2023 at 3:28=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>
> Userspace may add flag RWF_ATOMIC to pwritev2() to indicate that the
> write is to be issued with torn write prevention, according to special
> alignment and length rules.
>
> Torn write prevention means that for a power or any other HW failure, all
> or none of the data will be committed to storage, but never a mix of old
> and new.
>
> For any syscall interface utilizing struct iocb, add IOCB_ATOMIC for
> iocb->ki_flags field to indicate the same.
>
> A call to statx will give the relevant atomic write info:
> - atomic_write_unit_min
> - atomic_write_unit_max
>
> Both values are a power-of-2.
>
> Applications can avail of atomic write feature by ensuring that the total
> length of a write is a power-of-2 in size and also sized between
> atomic_write_unit_min and atomic_write_unit_max, inclusive. Applications
> must ensure that the write is at a naturally-aligned offset in the file
> wrt the total write length.
>
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h      | 1 +
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b528f063e8ff..898952dee8eb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -328,6 +328,7 @@ enum rw_hint {
>  #define IOCB_SYNC              (__force int) RWF_SYNC
>  #define IOCB_NOWAIT            (__force int) RWF_NOWAIT
>  #define IOCB_APPEND            (__force int) RWF_APPEND
> +#define IOCB_ATOMIC            (__force int) RWF_ATOMIC
>
>  /* non-RWF related bits - start at 16 */
>  #define IOCB_EVENTFD           (1 << 16)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..e3b4f5bc6860 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -301,8 +301,11 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND     ((__force __kernel_rwf_t)0x00000010)
>
> +/* Atomic Write */
> +#define RWF_ATOMIC     ((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -                        RWF_APPEND)
> +                        RWF_APPEND | RWF_ATOMIC)
>
>  #endif /* _UAPI_LINUX_FS_H */
> --
> 2.31.1
>
