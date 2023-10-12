Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD27C7846
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjJLU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344176AbjJLU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:59:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146AA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:59:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53406799540so2527792a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697144389; x=1697749189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCC/dYmMqHRaR4te/Bo8/FimzrWr4aPFE83miAoEsEU=;
        b=m04TvLsBskzZln5GgCax4DN+uBQALevN++fN05RpkWsnTIKjPZW80IK8MTQwidULf+
         /dIhl8uPLVCkVf26dEwmDcq89yRDjLxeV9E/fE0TXTNVPCyzWyKkm4DAoEvYT48IbieP
         SZ2qkJtluSSZdDKt3mcgsWFJeBgzPbymcnyKNOFJHoO8XwPZn3XFYn1yp0MEoLdaPHJ0
         TEfRyL70MSt80daw1ZeKjvFExpU7LKFVhDHhINd9F29RK264N2aYnTVHFqgZkLrIUL+w
         +YIA3VoDHxBwihijocL0uIFNNmpCRh6DmJTLYfwD9TMAvAyWJrqMfuy49z4qDpxzbkbz
         egQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144389; x=1697749189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCC/dYmMqHRaR4te/Bo8/FimzrWr4aPFE83miAoEsEU=;
        b=pXKK239vcbwepoSg/R9g1Sya4RalgIfCR4htCWlmnFxh7haycB95dYN8oeP/LbJ2hX
         zkt2k27Zf7DuGezXBm8aaCYnvlQ+X+D1lPdqIKuTv4deR9eOJnW3yVk7T78bLO2hI6A/
         lqoKXk5pkC9vplIFZDDIlhFOlWsfXpfYvtksiz7NsSFIQF5AxQQcHk+6YTMylvdSglY1
         szVkGB+UXG9KpwVIhIaEEE7SpmSIhhrcrOp84XS+ZEOfm7w3WBrAnXmjMietsiiHRGpm
         n0JeNxZypqMJR9NEfhKbMvGHTcvOqOemT5YH0a9T6XK5GPDXXkRRDRr+WLvb+YKOYUba
         V/sA==
X-Gm-Message-State: AOJu0Yzn1z8oWqdjsn6iOBwYuMkQ2bmJwhmH+Cll10pLShKkigcwkR3K
        9LUy++Ff3B6MUcenxzpFgJjKqXjvyleYsZfI1oM=
X-Google-Smtp-Source: AGHT+IHZwMvd2wgWbNi1gGdYLOSduJ0nYCAO57TK6PS6Rx2dIRYj1pM6S3C+nzgoUWkC0bS4WzGbE3OYqm4XYpZhvuY=
X-Received: by 2002:a05:6402:520b:b0:53d:9471:76b3 with SMTP id
 s11-20020a056402520b00b0053d947176b3mr8876672edd.7.1697144388617; Thu, 12 Oct
 2023 13:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231012201743.292149-1-ubizjak@gmail.com> <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
In-Reply-To: <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 22:59:37 +0200
Message-ID: <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce %rip-relative addressing to PER_CPU_VAR macro
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Thu, Oct 12, 2023 at 10:53=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 10/12/23 13:12, Uros Bizjak wrote:
> > The last patch introduces (%rip) suffix and uses it for x86_64 target,
> > resulting in a small code size decrease: text data bss dec hex filename
> > 25510677 4386685 808388 30705750 1d48856 vmlinux-new.o 25510629 4386685
> > 808388 30705702 1d48826 vmlinux-old.o
>
> I feel like I'm missing some of the motivation here.
>
> 50 bytes is great and all, but it isn't without the cost of changing
> some rules and introducing potential PER_CPU_ARG() vs. PER_CPU_VAR()
> confusion.
>
> Are there some other side benefits?  What else does this enable?

These changes are necessary to build the kernel as Position
Independent Executable (PIE) on x86_64 [1]. And since I was working in
percpu area I thought that it was worth implementing them.

[1] https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgro=
up.com/

Uros.
