Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4057A96E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjIURDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIURCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C2E64
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:01:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405290ab4b6so4795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315616; x=1695920416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu8S1LBasF2ZhEspa4c1U6bTj1yYPvFYUvyFdE5+sh0=;
        b=DBKEBBi3H+XhRBJ3SF52v85y+9R/yvJyS9lp1iw4V6FiMfTkjJFDd1yIXXEVnIU+6Y
         Lk9tkvo4O2JCECa5bOTrLHC9kqU3YvNo7uShGlYdtI9LFHupfnrv0917JMP4dpjjXTmW
         ZwXinYdEjNAcEceeKU5t+teT4OszoAjbsvoNZpP5qfq7EB6spg9Or+QpZ74lKN3ltbK3
         zavwzcqHo8lJKHFA7g48xBC2pSyIQbArl57kQfB7pfao9rIJPMEgHUasLy1/QyOp6KqQ
         qiL0TX30xbtHIK1vzgT9qCD62MksaEeOXKymW6NKFD0p2Zs/A9Wha/fdmtpXIyfxElxn
         Xagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315616; x=1695920416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu8S1LBasF2ZhEspa4c1U6bTj1yYPvFYUvyFdE5+sh0=;
        b=gmyZULQUXJrMyA9lYwsJDY60d8E45Onj8DMnuiGpIGg2xH+UuSurEcYnwcoY4eqr6R
         tVLUjwuPItIyHdDmuLAGWP6madgk0ne7R1V0FdiuVwimXtFHXUfeiX7CoyHGNSORB0jx
         eeRNZVnsOBasGT6j0P0TCFxXHY37+9X/hBZbiZpjZh57hNWKq7HLmaPQXgB7WNwL5ePW
         AwRQZIQbQ+hlp95ccAtmfORch6oLfIEKEzrNJ/mCuDr7iOouGGhieq+T0uyGk8olAqaH
         lTg94BlRzV/biI2eRorhnEyMBCRQff+NI64ip6rVNY8dLIq53hj+3WP/IetyGEb+6e3W
         PVdg==
X-Gm-Message-State: AOJu0YwLAiLlREVM9s+tH40fSroIKrydo2DV/1qZEXtmQOOJgM8yXW0O
        9Gokcodo1lKmHu4H3J6unmXkLXhY7SWV+2WqO5ieFg==
X-Google-Smtp-Source: AGHT+IEsCsrSbKfig0oNoRzoceXo3paYU9sVVaDSOMikZhbSNVKsbvQENPu2CUkyElIndXJBCQ7CbIY2CAmctRCJmqI=
X-Received: by 2002:a05:600c:5006:b0:404:74f8:f47c with SMTP id
 n6-20020a05600c500600b0040474f8f47cmr91268wmr.5.1695315616287; Thu, 21 Sep
 2023 10:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com>
In-Reply-To: <CAG48ez0gN_nC8NrMOeq44QmUDT27EpT0bFuNu1ReVKDBt3zy7Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Sep 2023 18:59:39 +0200
Message-ID: <CAG48ez1kBzoeYAvXVneuQqU_0zXKWV7UZGef=WnyNc32vNQLhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:28=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> Though, uuuuuh, I guess if that's true, the existing
> vma_is_anonymous() is broken, since that also just checks ->vm_ops?
> I'm not sure what the consequences of that would be... Either way,
> vma_is_anonymous() might be the better way to check for anonymous VMAs
> here, and someone should figure out whether vma_is_anonymous() needs
> to be fixed.

(Not really relevant to the rest of the thread, but just as a
sidenote: Turns out this is not an issue; since commit bfd40eaff5ab
("mm: fix vma_is_anonymous() false-positives"), VMAs where the ->mmap
handler does not set an operations pointer end up with a dummy
operations pointer.)
