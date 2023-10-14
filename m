Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1043F7C9295
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjJNDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:41:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0224C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:41:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d9d8284abso1084295f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697254877; x=1697859677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+uqdmO4xgns3ugpSGvOEmhx6xIg/OI7rgx8ycNmbLk=;
        b=ItjQ00PPlEnDC1tcuUDvWUvLQiOPtpY9hnAMUolMg016ZmvKA3bHMuTlpC9/1kab67
         xZe04ZPxEBL9H53b2SXfYlV70dVUgC0/Osz8V3fc/REn203VKD33RiJrXBXCxfhwztH2
         RpMP8tFUB67UHKHPBkqJbqq1LU6+xIpnZFRSXWphwJKq2aG5dHNlI34nFVZMy3Vk1yz3
         RmdnJ3ELRmHFt7b53x9TSHjzT5khf6wzCn+V6SoXXDx9ZA5xn5oQljyZXqTKBaRkn9Rb
         QLbdKPbpN1lP5twI8nLKIDVaQm3PhPa2tnbqiRpXxts7/yU3oIIyWEyJinyscvQNHeGx
         Z+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697254877; x=1697859677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+uqdmO4xgns3ugpSGvOEmhx6xIg/OI7rgx8ycNmbLk=;
        b=K14qAPr65rk2GElEYbZFx1s4HfRuSD7j2ymYF6Dk0Gq0cbDdL1ZrLByxf5CH64mfH8
         Ae+yNi4RgkUgeY7eVbNXkOAy3GfvaEIHfP9EkmDgZD928AG3d71hqZPM540PlLWr2wGp
         IH0KPs2P26r6DAt9q3hHLH6yel0ZUKlmFC40loOc98OsdmYwH58fHPawCHC1vDbVGKwX
         8GTjuCp6UL+uZgjFe/ApS/p/nROnJhiZdy8Zhrq0goFHcltLQD5BOfMv+dWi99FunyfC
         AgCiAz9ADkaBkUcU4BTtUKqhQ5TZLbUMC6dzhzkThdxhLpd/CreL5dui8D1Vctg3k2p6
         v6yw==
X-Gm-Message-State: AOJu0YxATDADIk1UmDwMlJsPe3eJdRv/NY4KSJmMmffJm8NlBLDgaHyz
        FrhTt2NtqyYVBw64xhR6WQXCyS06VUhb2gMnI+rPAg==
X-Google-Smtp-Source: AGHT+IE7iLanycP/oqIhjHkrP56/fLQX49HZv8wbRAs004f3GzJmu2RKZ2sKkYWjuCblXh4FuZwT4KqsBRbMfm2LvT0=
X-Received: by 2002:adf:a4da:0:b0:32d:7615:372b with SMTP id
 h26-20020adfa4da000000b0032d7615372bmr8604025wrb.12.1697254877240; Fri, 13
 Oct 2023 20:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231011065446.53034-1-cuiyunhui@bytedance.com>
 <87sf6gcyb3.fsf@email.froward.int.ebiederm.org> <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
 <87r0lyad40.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r0lyad40.fsf@email.froward.int.ebiederm.org>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Sat, 14 Oct 2023 11:41:06 +0800
Message-ID: <CAEEQ3wmerA8p2qpEAn9pGW5BW35777VFwabusyFTAEyaf-0JPg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] pid_ns: support pidns switching between sibling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric=EF=BC=8C

On Fri, Oct 13, 2023 at 9:04=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> yunhui cui <cuiyunhui@bytedance.com> writes:
>
> > Hi Eric,
> >
> > On Thu, Oct 12, 2023 at 11:31=E2=80=AFAM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> >>
> >> The check you are deleting is what verifies the pid namespaces you are
> >> attempting to change pid_ns_for_children to is a member of the tasks
> >> current pid namespace (aka task_active_pid_ns).
> >>
> >>
> >> There is a perfectly good comment describing why what you are attempti=
ng
> >> to do is unsupportable.
> >>
> >>         /*
> >>          * Only allow entering the current active pid namespace
> >>          * or a child of the current active pid namespace.
> >>          *
> >>          * This is required for fork to return a usable pid value and
> >>          * this maintains the property that processes and their
> >>          * children can not escape their current pid namespace.
> >>          */
> >>
> >>
> >> If you pick a pid namespace that does not meet the restrictions you ar=
e
> >> removing the pid of the new child can not be mapped into the pid
> >> namespace of the parent that called setns.
> >>
> >> AKA the following code can not work.
> >>
> >> pid =3D fork();
> >> if (!pid) {
> >>         /* child */
> >>         do_something();
> >>         _exit(0);
> >> }
> >> waitpid(pid);
> >
> > Sorry, I don't understand what you mean here.
>
> What I mean is that if your simple patch was adopted,
> then the classic way of controlling a fork would fail.
>
>         pid =3D fork()
>         ^--------------- Would return 0 for both parent and child
>         ^--------------- Look at pid_nr_ns to understand.
>         if (!pid() {
>                 /* child */
>                 do_something();
>                 _exit(0);
>         }
>         waitpid(pid);

okay, The reason here is that pid_nr_ns has no pid in the current
pidns of the child process, and returns 0.
Can this also support sibling traversal? If so, it means that the
process also has a pid in its sibling's pidns.


>
> For your use case there are more serious problems as well.  The entire
> process hierarchy built would be incorrect.   Which means children
> signaling parents when they exit would be incorrect, and that parents
> would not be able to wait on their children.

Therefore, support for slibing pidns must be added to the entire logic of p=
idns.
Do you have any plans to support this, or what are the good reasons
for not supporting it?

Thanks,
Yunhui
