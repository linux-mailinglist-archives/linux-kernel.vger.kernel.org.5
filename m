Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737E47DC182
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJ3VDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJ3VDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:03:46 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25753FE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:03:43 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-457c82cd837so2055292137.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698699822; x=1699304622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crwNbqxR7nPOodoWp7WUIXqNMkXcMnjDYt1yU/ik8o4=;
        b=lKZE3AaITXAyrxY3lwszx2239avcI3TT1dr+PD6c4bQ3H0mQnLwrbIQ8QnYCoRdB2z
         yCVQ6Z5AgsmFmiBoDWrX4p8FuWcmefM+h5Y0s9DNUzm/GfxGry/3jOEsTPoj8XRWgaqX
         xMb8SSqqiUX6BNjmJSQqa+1q30IMPHxziX1Tv6l0k9Yz79a5u/2QPwEiZ2Tt2NQrpNHl
         LqJkdPWwI4uFP7f7f50sfiugrT2DJqhZJkKmcD1nGHcLm2MMkv8XJcoh/lXpkeW3FcbD
         1isgpp0G++iS0l3KnMdBjsZr8GGmUSnDhu9J1Ed0TKCNlOWCSgU+c6qe+KBM2aiTt09f
         4BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699822; x=1699304622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crwNbqxR7nPOodoWp7WUIXqNMkXcMnjDYt1yU/ik8o4=;
        b=PQE1aP6fbeL883gRU3sDlGSWsNIgV2HpPw/Ve8V5FspUSQ4wI2FBZgODJBw8954DSe
         EP895cxCYtq6HrKPH1X5F16x5IGIZl7eqw5V2/7Tl5WeKCwDZHgozhQA3TxPgZMpuXDa
         WHv7+3pP3Vtabl54072LS2pBvimpZUtLgOuSmzwq5HwfMWl+NOqGIkqVTPyVG1snGIYm
         NuS/T+aAV5lhzHa5rOmjsJrI4tziAk8tptyMVnR1PpJ/ihm5VUUS5z9BmTesMzFtAsvw
         KRZUMXaxpNQj/4ng2e3pXtaOp0wlQoI8VGRog9IJ1NvkvjHknlg4M+VCyeow68ENE6XG
         yERQ==
X-Gm-Message-State: AOJu0YxLqAPZhcNDznkpaLaYAL9p374AWlgCQSckSqusaDCZ6kMLP2Ko
        1WYzYF6f3Ptxw+KzCcrHO8XSPhgBA6Mp9I5vOjgs8A==
X-Google-Smtp-Source: AGHT+IE27AtGQAnI6mD9u8wH2PTCU0NScHW3t3xIQ53Au2GwdiVTo0h7dvbMpnuD1si3WLIMeYny0lkRKxY1fVBW5Hs=
X-Received: by 2002:a67:c295:0:b0:458:11dd:87aa with SMTP id
 k21-20020a67c295000000b0045811dd87aamr10199144vsj.22.1698699822074; Mon, 30
 Oct 2023 14:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231028164650.4f5ea18a@rorschach.local.home> <CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
 <20231029091408.0179cee4@rorschach.local.home> <CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com>
 <20231030104127.6f32c932@gandalf.local.home>
In-Reply-To: <20231030104127.6f32c932@gandalf.local.home>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 31 Oct 2023 02:33:29 +0530
Message-ID: <CA+G9fYuTGmjQZM4x28yWREnKVd7Q0iNt4mSoCZa0L62MgUEV3w@mail.gmail.com>
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing ei->dentry
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave
        <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew
        Morton" <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 20:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 30 Oct 2023 12:37:08 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> >
> > I have tested the linux-trace.git trace/core and run selftests ftrace
> > the reported kernel panic [1] & [2] has been fixed but found
>
> Good to know. Can I add "Tested-by" from you for that bug fix?

Please add,
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> > "general protection fault"  at  kernel/trace/trace_events.c:2439.
>
> Can you test with the below patch?

Applied this patch on top of linux-trace.git trace/core and test passed.
All the reported issues have been resolved.

>
> Also, can I ask what are you testing this on that makes it trigger so
> easily? As I'm not able to trigger these in my tests, even though they are
> indeed bugs.

I use following build artifacts and running selftests: ftrace: ftracetest-ktap

   kernel:
      url:
        https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/bzImage
    modules:
      url:
        https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/modules.tar.xz
      compression: xz
    nfsrootfs:
      url: https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.tar.xz
 kselftest:
          url:
            https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/kselftest.tar.xz


Steps to test:
==========

1) Boot x86 machine with above bzImage, modules, rootfs and
copy kselftest.tar.xz from above url and unzip.
2) cd /opt/kselftests/default-in-kernel/ftrace
3) ./run_kselftest.sh  -c ftrace


# selftests: ftrace: ftracetest-ktap
# unlink: cannot unlink
'/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file
or directory
# TAP version 13
# 1..129
# ok 1 Basic trace file check
...
# # Totals: pass:126 faii:0 xfail:1 xpass:0 skip:1 error:1


Test logs:
https://lkft.validation.linaro.org/scheduler/job/6985018#L4742




>
> -- Steve
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 7ad7496bd597..7a0b54ddda24 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -609,7 +609,13 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>                 entry = &ei->entries[i];
>                 if (strcmp(name, entry->name) == 0) {
>                         void *cdata = data;
> -                       r = entry->callback(name, &mode, &cdata, &fops);
> +                       mutex_lock(&eventfs_mutex);
> +                       /* If ei->is_freed, then the event itself may be too */
> +                       if (!ei->is_freed)
> +                               r = entry->callback(name, &mode, &cdata, &fops);
> +                       else
> +                               r = -1;
> +                       mutex_unlock(&eventfs_mutex);
>                         if (r <= 0)
>                                 continue;
>                         ret = simple_lookup(dir, dentry, flags);
> @@ -743,7 +749,13 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>                 void *cdata = data;
>                 entry = &ei->entries[i];
>                 name = entry->name;
> -               r = entry->callback(name, &mode, &cdata, &fops);
> +               mutex_lock(&eventfs_mutex);
> +               /* If ei->is_freed, then the event itself may be too */
> +               if (!ei->is_freed)
> +                       r = entry->callback(name, &mode, &cdata, &fops);
> +               else
> +                       r = -1;
> +               mutex_unlock(&eventfs_mutex);
>                 if (r <= 0)
>                         continue;
>                 d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
