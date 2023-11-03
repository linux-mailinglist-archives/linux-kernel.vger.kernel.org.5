Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC47E07EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjKCSJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:09:08 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE2CF;
        Fri,  3 Nov 2023 11:09:05 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45d955fcabdso354071137.0;
        Fri, 03 Nov 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699034945; x=1699639745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGLlL5spY81cqVy4x7DOzEYruuO1Kblfx9KL9KmbIWg=;
        b=mUuv2rnkPwN5bKYLpkLIuxvyFK+hqTJoO+McpKmzCw5gD4fLls7P6LXUN0WC9hwyMk
         UGTtm3c4Ua7tL0g1f2+XsobRQ61F9FtiC9Tfbk6rVbOqFCag+0wngCRYsHXeZK9lvoq0
         Z+IFxdZJQ+ieZW0TwYN+wZ2exCL/64/+E+czBWgqV9qbHVQ+9aFNLFc+lMRJ8tSHKJYX
         qteUPHjRqhoKc/2618EF3SihxOYXml6uwUK78QweWX/bI+4sY479G5Un9OS5HLeqBTGs
         jschS34WFR1/ozsyr9lrm07okp2jBzp7JICbB9SaaSEo01vTVJ4BOFWbRcVxbZjMN3XG
         rlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034945; x=1699639745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGLlL5spY81cqVy4x7DOzEYruuO1Kblfx9KL9KmbIWg=;
        b=QMw/+J5F1SIcMLX1352RRL9cBIZ7wa4Hs2paputBl5vg632tSjM44oLhuqLgSa5uFo
         i9m5EN0VR7KoqtK1FAVHn8IUaL3RhPclGas8GUHJi58MwC1RNLlERpY0iVbBP+ewA91Y
         WDdgmvBa0nehHETpPFAkp5/+jR1RogaRaP8b2I7jL6R2jiCOB5wes6Z5Y4txRYeedmeD
         tMwpoW+ApmWT1kev+OZicXE3UCvUPBdLuoSSZVZQAtRjJEgvHVS4pIvPGUzAPjrtK3DY
         f660kFAQwKAF5hN/g7uhQ+k68DjVBZEEEuPkalX1AlL5UqNcVQ7kAgyRMrsNT+g6M+R1
         Lkvg==
X-Gm-Message-State: AOJu0YzqdVMUHUtREGxN8QsRPBEKpB7pZoUn1Y1myuxsr9al6EqSCjEL
        uo9imq4wzcI6VyBc5KSeIKJ4sF/TAD6fCPN+z64=
X-Google-Smtp-Source: AGHT+IEoycj2jgmlH4pfGN5KGdT9fnWYQSgwREN1B2qQZAp3bnWMzm9iYhm1g5s9NikHt5f/kIRc0NksBf1xS8NnN5s=
X-Received: by 2002:a67:a248:0:b0:45d:6d96:62f1 with SMTP id
 t8-20020a67a248000000b0045d6d9662f1mr4729949vsh.9.1699034944808; Fri, 03 Nov
 2023 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231102183751.47413-1-pstanner@redhat.com> <CAKFNMok9WTV5uX3BBfr8eYiuJXvUY6TuYW=tQYvBzdCUYsxcwA@mail.gmail.com>
 <437ec6fa34af1ccfadee2d62770e52d99ebf75c3.camel@redhat.com>
In-Reply-To: <437ec6fa34af1ccfadee2d62770e52d99ebf75c3.camel@redhat.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 4 Nov 2023 03:08:48 +0900
Message-ID: <CAKFNMokwjSwzT3T6vQZ_-6evPNUqNUuk+D=LGA5cuOm3-xx0aw@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: copy userspace-array safely
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
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

On Sat, Nov 4, 2023 at 2:56=E2=80=AFAM Philipp Stanner wrote:
>
> On Sat, 2023-11-04 at 02:44 +0900, Ryusuke Konishi wrote:
> > On Fri, Nov 3, 2023 at 3:38=E2=80=AFAM Philipp Stanner wrote:
> > >
> > > ioctl.c utilizes memdup_user() to copy a userspace array. This is
> > > done
> > > without an overflow-check.
> > >
> > > Use the new wrapper memdup_array_user() to copy the array more
> > > safely.
> > >
> > > Suggested-by: Dave Airlie <airlied@redhat.com>
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > ---
> > > Linus recently merged this new wrapper for Kernel v6.7
> >
> > The following overflow check is performed just before the usage of
> > memdup_user():
> >
> >         if (nsegs > UINT_MAX / sizeof(__u64))
> >                 goto out;
> >
> > This was introduced by commit 1ecd3c7ea76488 ("nilfs2: avoid
> > overflowing segment numbers in nilfs_ioctl_clean_segments()") to
> > avoid
> > overflowing nsegs * sizeof(__u64) in the subsequent call to
> > memdup_user().
> >
> > I learned about memdup_array_user() this time, and it seems to check
> > for overflow when multiplying two size_t arguments (i.e. the number
> > of
> > elements and size of the array to be copied).
> >
> > Since size_t is 32-bit or 64-bit depending on the architecture, I
> > think the overflow check that memdup_array_user() does
> > is included in the above upper limit check by UINT_MAX.
> >
> > So, for security reasons, I don't think this change is necessary.
> > (Am
> > I missing something?)
>
> No, I think you are right. My commit message was very generic =E2=80=93 i=
t's
> more about unifying array-duplication.
> I should rephrase it.
>
> >
> > In terms of cleanup, I think the clarification this patch brings is
> > good, but in that case, I'm concerned about the duplication of
> > overflow checks.
>
> Alright, so would you prefer a patch that uses memdup_array_user() and,
> consequently, removes the preceding check?
>
> Regards,
> P.

Yeah.  If you could revise it as a cleanup patch, I would like to
adopt it for the next cycle.

Regards,
Ryusuke Konishi
