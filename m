Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A517C8FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJMVzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJMVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:55:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D9B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:55:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so3034108276.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697234116; x=1697838916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKGSCOVLbkYhGYoq+rtlt3uTKCf4verh3lWQ8sV6E5A=;
        b=P1WAcFezEm1NvXvZtbYJCwmZeudvXGnk1C4nrNAWPQcchDGRu8o60gX93BCGMUyyDr
         2Ond7dftnmvBmmi/F9j7w3wldMUXfyfTgCEPQQynYKtGlUgXjfddnSJZ5Ljqp6NMXf5T
         aM2WULrobajmf22xevmho4VZMv4M8CKUkmaMqqKbrO9TJ5rCvQ8xnM7hPg8aRdRZsR9r
         si4OMsMCJqZxkKQj89zQwXwK3Z/sRmnU/MYMJv8/BnvznnU5WX3Q9VO1+rd1McsJawQ9
         52HjduOd1/tKPfr+cO9bQ0L8UO2Tml/spW6B51s/nqVsgctgqPtYwPs8nW5Q8znIv154
         lJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697234116; x=1697838916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKGSCOVLbkYhGYoq+rtlt3uTKCf4verh3lWQ8sV6E5A=;
        b=Kljf9zIqn050d2Odk7nQy1XYUz9vIWLCxk13KArmUtndc7KGIeZTrtj08tRo2Pgw0A
         rw/SW1BtK9Mt21wDT514BTEjfbGraPK3OzLo4Fe9xduZBFoKlSZkSwjjK9sZ2TLWKsyp
         wpgbloRRMwDXq2AWJBXL53ad02I9kSkFDA8noO3EAcXuZBKkG8Wr8v2heiFoQrq6N9bo
         Z3saLw6gSokthiN4zofRnUlnOfblW2vfIfe9pwe0iejsVj7vwZbIDGJL9qrcmZJbn4qW
         pkU12lMCpSztIxHN+/RZcEwpaDCxnbFd7Bqgcb8sZ9+S5MFxhhtF+ivqWtWprPloLU83
         UZIw==
X-Gm-Message-State: AOJu0Yx41RUFc3ZQJbzEl2hK2WOdgtMmX9U+2niPS/st1lzvK4xVB49r
        502yD184gHikpLsV5QFqnKEQt0Sk3u4C+du3yldK5rj20LabLws=
X-Google-Smtp-Source: AGHT+IG7mv21RwUbd4s8yApgHo1oFDE2XPy+OCLcTrQN0/TOGlzUdlKn7So/TOy+xlC76NBVGDCjNC3AbSNbPwuT8pc=
X-Received: by 2002:a25:ae8b:0:b0:d9a:d20d:7d5a with SMTP id
 b11-20020a25ae8b000000b00d9ad20d7d5amr6426451ybj.1.1697234115842; Fri, 13 Oct
 2023 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
In-Reply-To: <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Oct 2023 17:55:04 -0400
Message-ID: <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 6:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 4:57=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Add three system calls for the Linux Security Module ABI ...
>
> First off, a big thank you to Casey who took it upon himself to turn
> my pseudo-code syscall suggestion into a proper patchset and saw it
> through 15 revisions.  Thanks also go out to everyone that has helped
> review and comment on this effort; I know everyone is busy, but these
> reviews are important.
>
> I'm happy to say that I think we're in a good place with this revision
> of the LSM syscall patchset.  I only see two outstanding issues, and
> neither of those are bugs/showstoppers that affect the API, they are
> simply areas where the implementation could be improved.  With the
> understanding that Casey is busy for the rest of the month, and my
> desire to make sure this patchset gets a full dev cycle in linux-next,
> I'm going to suggest merging this into the lsm/next-queue branch soon
> (likely tomorrow) in preparation for merging it into lsm/next once the
> upcoming merge window closes.  Those who want to help improve the
> implementation, as suggested in the feedback on this revision or
> otherwise, are welcome to submit patches against the lsm/next-queue
> branch and I will merge them into that branch once they pass review.
>
> If I don't hear any objections I'll plan on merging this patchset
> tomorrow, I'll send a follow-up reply to this email when it's done.

Since it's been *almost* a full 24 hours and no objections I went
ahead and merged this patchset into lsm/next-queue with the intention
of bringing them into lsm/next after the upcoming merge window closes.
For those of you who have suggested changes, please feel free to
submit patches against the lsm/next-queue branch and we can get them
queued up along with these patches.

Thanks everyone!

--=20
paul-moore.com
