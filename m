Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337A7F79B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjKXQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:49:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6730D60
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:49:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBBBC433C7;
        Fri, 24 Nov 2023 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700844561;
        bh=Fkv7S7T1c3p07xBeyAOIkgcnZBtOBErEbzabrMqijuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s0ZiCfq2SxmdqlKvYoVPt2US2SeGksv6h7U//ZkEIU47MVVxNDOEw4a3UHXf+l4f+
         NPT8ncWmIRTQDsMhTAPVbaZpYVaAkMwiDN5XFPd87aH6g2c8/zpnLhSAfG/Xvgbt9i
         AAVLgpaSYsrRiucrbLTUvfk2/uJVzf3AGh9EMdZd1YcJDMJwbVnoil6ZjtRWoAXg3Z
         h+gJazM/aJKcEw8rWXxtr7fLNj5elRChYuFC8EIasIcJy6jthEmDODTV90Ld0cY4lr
         0caEaVM0DUqz5tzhXUqQG9fECU86px647MlYrIu7Ca6fzxvfzowGAiUNmRRdR7jOre
         Q5/iQQ/3LWO+w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso2981173e87.1;
        Fri, 24 Nov 2023 08:49:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7JKdAjhJNgfPpCPQ1w/oeUN+eudlj4riftblwNfG9MRu/jWMU
        WTEl6NvffQVtFxW8DL4EEQ/eI2YxyW5PG6TLkw4=
X-Google-Smtp-Source: AGHT+IGeK+8nt2GDtNKqNhYU2TqqgPt4FdEDMQwF96TjonxqToicZMjEM0/E5/eXz31EA1YEiLQiVPH94s0CWVt5Af8=
X-Received: by 2002:ac2:5a59:0:b0:50a:a6d2:b631 with SMTP id
 r25-20020ac25a59000000b0050aa6d2b631mr2516579lfn.53.1700844559515; Fri, 24
 Nov 2023 08:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
 <20231021102059.3198284-2-yukuai1@huaweicloud.com> <CAPhsuW5=fDpsAofik+4jHObFkRMcTTeQPbtXSBG_KAes0YgQGA@mail.gmail.com>
 <1f3080ca-cde6-2473-4679-a79fa744eb70@huaweicloud.com>
In-Reply-To: <1f3080ca-cde6-2473-4679-a79fa744eb70@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 24 Nov 2023 08:49:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4d4mHQ9C=3gGKOG=QuXVH11ZtksQV3WV3CbYANgq7FYw@mail.gmail.com>
Message-ID: <CAPhsuW4d4mHQ9C=3gGKOG=QuXVH11ZtksQV3WV3CbYANgq7FYw@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/6] md: remove useless debug code to print configuration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 1:12=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/11/24 16:17, Song Liu =E5=86=99=E9=81=93:
> > On Fri, Oct 20, 2023 at 7:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> One the one hand, print_conf() can be called without grabbing
> >> 'reconfig_mtuex' and current rcu protection to access rdev through 'co=
nf'
> >> is not safe. Fortunately, there is a separate rcu protection to access
> >> rdev from 'mddev->disks', and rdev is always removed from 'conf' befor=
e
> >> 'mddev->disks'.
> >>
> >> On the other hand, print_conf() is just used for debug,
> >> and user can always grab such information(/proc/mdstat and mdadm).
> >>
> >> There is no need to always enable this debug and try to fix misuse rcu
> >> protection for accessing rdev from 'conf', hence remove print_conf().
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >
> > I wouldn't call these debug functions useless. There is probably some
> > users who use them for debugging (or even in some automations).
> > How hard is it to keep these functions? Can we just add some lockdep
> > to these functions to make sure they are called from safe places?
>
> Okay, I can keep these debug code, and since these code are
> dereferencing rdev from conf, and they need new syncronization:
>
> 1) dereference rdev from mddev->disks instead of conf, and use
> rdev->raid_disk >=3D 0 to judge if this rdev is in conf. There might
> be a race window that rdev can be removed from conf, however, I think
> this dones't matter. Or:
>
> 2) grab 'active_io' before print_conf(), to make sure rdev won't be
> removed from conf.

I think for most of these cases, we can already do print_conf()
safely (holding mutex/lock), no? We can grab active_io when it is
really necessary.

Thanks,
Song
