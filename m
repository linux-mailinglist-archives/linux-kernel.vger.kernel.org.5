Return-Path: <linux-kernel+bounces-43999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8B841C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFFF287BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9243D393;
	Tue, 30 Jan 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INM8781O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B539FC1;
	Tue, 30 Jan 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596635; cv=none; b=Ir9RGd+319rebbwkoq3QT0QmOaJecIgokIGPwldQrPbBL6MmGuSIRSTZwQqxgmT+BMzuEwLsj6+BwotXGkxxDQkT9DfjZkr/u5GbiUtH6qpwODJdOh77aQfv5EaHkI+B8xqZIr9KjDIa2p1Er2WQFu9eHtH2JI6K0TdmU2AbfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596635; c=relaxed/simple;
	bh=ocd7CtyJUXOYKX8nrVVCi4rWZbk47Swv1h3/8sjcQWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnqmsPat8YfwL9llB4jYNdU3DLnG2tIxf+L7RCkJQzv1EiGQNI/eNVxLNQPoJkg66tZGdx0Vi8LmtiUMkAt5H1c1Ald3fvIE6yEStNRoqxCSHjR98DDTeiPyKkyVNTy/DvL1E2/TmgDITDYAVlUPebPCHstkridyAc5TQh8FNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INM8781O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742B2C43390;
	Tue, 30 Jan 2024 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706596635;
	bh=ocd7CtyJUXOYKX8nrVVCi4rWZbk47Swv1h3/8sjcQWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INM8781OMSNPsB1j6nBqzZNn6KnUY8X8fVHLAXqjAuich3nvI2Et9oIypWnMcfIJB
	 Q8t8MHPvFqGfo78UPnYkTVA2xITj9C30Q3M0+qe/YJAVnoweXAbsb7o5lGF2Fz/3zB
	 BRyHefHvCeOgg1I1PDiKjrvWGj+l50QzBr/WgygEuf778ujcpjx3++4elxsdMAID/M
	 V0a6jgzGsXqwl2FkytcCq7/v2AizXmVGD9uFSQXU+y6v7Qdo9SxYSMiL3XdR17fQRk
	 wpoiTikH7tfNVtcvipdR/jZSPK0tRltd3A9u0fBaSabom7d99RxHLBI7n1MxkEGrQ+
	 zxWdx1LqXBzsw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso6200892e87.2;
        Mon, 29 Jan 2024 22:37:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7JZSFkb9gv1ivRblsZKKdMgwQQB8cokfMcgvSlMA6ed+SR1AQ
	nMnYg5KDlLt0NIomI5KrJ1ydFIS4csMKOr4UOcoJrBikjotXmBVFHntKt9ZrTT4RljFTSdk0UZa
	or+YQZmbvO04mUkQGeVQIuLQXOHs=
X-Google-Smtp-Source: AGHT+IHcm0+jtj+r9oSmYfrZiBtnwQsEY0Ta32XhNMfT22BCmdEtq9D40hDq6QRns2586neW8SNqBOvzuNTkaIUjfgw=
X-Received: by 2002:ac2:4c34:0:b0:511:19b0:3f23 with SMTP id
 u20-20020ac24c34000000b0051119b03f23mr636305lfq.44.1706596633609; Mon, 29 Jan
 2024 22:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125553.2697765-1-yukuai1@huaweicloud.com> <20231228125553.2697765-4-yukuai1@huaweicloud.com>
In-Reply-To: <20231228125553.2697765-4-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 22:37:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ck33wdFznkpXzZmyW3ux3gCf-yhQnevdirjVJkmzmEA@mail.gmail.com>
Message-ID: <CAPhsuW5ck33wdFznkpXzZmyW3ux3gCf-yhQnevdirjVJkmzmEA@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] md: use interruptible apis in idle/frozen_sync_thread()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai3@huawei.com, neilb@suse.de, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the late reply.

The first two patches of the set look good, so I applied them to
md-tmp-6.9 branch. However, this one needs a respin.

On Thu, Dec 28, 2023 at 4:58=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Before refactoring idle and frozen from action_store, interruptible apis
> is used so that hungtask warning won't be triggered if it takes too long
> to finish idle/frozen sync_thread. So change to use interruptible apis.

This paragraph is confusing. Please rephrase it.

>
> In order not to make stop_sync_thread() more complicated, factor out a
> helper prepare_to_stop_sync_thread() to replace stop_sync_thread().
>
> Also return error to user if idle/frozen_sync_thread() failed, otherwise
> user will be misleaded.

s/misleaded/misled/

>
> Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadl=
ock")
> Fixes: 8e8e2518fcec ("md: Close race when setting 'action' to 'idle'.")

Please add more information about what is being fixed here, so that
we can make a clear decision on whether the fix needs to be back
ported to stable kernels.

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 105 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 60f99768a1a9..9ea05de79fe4 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4846,26 +4846,34 @@ action_show(struct mddev *mddev, char *page)
>         return sprintf(page, "%s\n", type);
>  }
>
> +static bool sync_thread_stopped(struct mddev *mddev, int *sync_seq)

I think we need a comment for this.

> +{
> +       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> +               return true;
> +
> +       if (sync_seq && *sync_seq !=3D atomic_read(&mddev->sync_seq))
> +               return true;
> +
> +       return false;
> +}
> +
>  /**
> - * stop_sync_thread() - wait for sync_thread to stop if it's running.
> + * prepare_to_stop_sync_thread() - prepare to stop sync_thread if it's r=
unning.
>   * @mddev:     the array.
> - * @locked:    if set, reconfig_mutex will still be held after this func=
tion
> - *             return; if not set, reconfig_mutex will be released after=
 this
> - *             function return.
> - * @check_seq: if set, only wait for curent running sync_thread to stop,=
 noted
> - *             that new sync_thread can still start.
> + * @unlock:    whether or not caller want to release reconfig_mutex if
> + *             sync_thread is not running.
> + *
> + * Return true if sync_thread is running, release reconfig_mutex and do
> + * preparatory work to stop sync_thread, caller should wait for
> + * sync_thread_stopped() to return true. Return false if sync_thread is =
not
> + * running, reconfig_mutex will be released if @unlock is set.
>   */

I found prepare_to_stop_sync_thread very hard to reason. Please try to
rephrase the comment or refactor the code. Maybe it makes sense to put
the following logic and its variations to a separate function:

        if (prepare_to_stop_sync_thread(mddev, false)) {
                wait_event(resync_wait, sync_thread_stopped(mddev, NULL));
                mddev_lock_nointr(mddev);
        }

Thanks,
Song

> -static void stop_sync_thread(struct mddev *mddev, bool locked, bool chec=
k_seq)
> +static bool prepare_to_stop_sync_thread(struct mddev *mddev, bool unlock=
)
>  {
> -       int sync_seq;

[...]

