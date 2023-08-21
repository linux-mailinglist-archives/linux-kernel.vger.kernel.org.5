Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5C782FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjHURwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbjHURwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:52:53 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE4110
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:52:52 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58fae4a5285so30000137b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692640371; x=1693245171;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqMfktYMcrqLgm14jQLwnwwBK0D+OoI+2vpZunSF7Uk=;
        b=qsB6uSYbSVhTlgrhY0mAV33NTCOs+CYi6pwiv+XEpTtANzs6AUFVsYkUVSKT1MUlG6
         xh8SMkcqXuX3WxQtrzNbxawJc8kpC6zQnbbXAXw0m4YsglLhnDQIb5dZHy3I/4XZTnO8
         bLiDJNO5tCC0MlzGLIMncSW2rtbEg++T3jUZELwmzlNHeym5tW03lgiHfON8NATLe9hc
         ITmNqT+XjdnxlIlzI9ZTRIqnU2ti3BpUbBh3kz/rrBtWK0j54/osb2ncWsQU9wkhNB3+
         smxI9P2N1djVHak8X740Su/sxFkMxvWkNi2t08V9i5LjL2TkmSvvVnQBLfnXu2gnvQnv
         fqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640371; x=1693245171;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqMfktYMcrqLgm14jQLwnwwBK0D+OoI+2vpZunSF7Uk=;
        b=F05iggPPlUxqwgO+n4NyFNfDXPcQENRBuPjv4gFFtqjN0wLboNYmindSM3wjnwCgVa
         howjIfcHpWiKvhb592np5WNPgjYnR9o2fAdYUstewIIa+lodCorC11LHOH2WOIfRfa0X
         oT6sy/v+nuayfwmEc6sPt6AcLqW3SW1TFxBR3fMnqlwfu5qMt4888aOqRo8l3kqvtXdY
         JaJbfgCCNWbUATX3pUjwuXN8pT0R74uvUh/RmBHOWhO47tPP5hI6GIbVuOvMdiGHZiMO
         EPdrN8XRcAa+w+QvrheSfDqwEXyfgdFbnRss4Nxq1Yy3HsqO2tVCyAMAi9sSEKvBV4tP
         1FcQ==
X-Gm-Message-State: AOJu0Yw9gVENqa3qBAyUl7RpZVHHKU3YlfDKyYJq5yLWv5wiqJgLJ2n2
        fT/4Qt53LC1xMtUixY331uYgAw==
X-Google-Smtp-Source: AGHT+IG4VzcMVfNmGoqOvLGvrxn1c9Lu30/XT1xcOaItP6jB77hpFnbFnn/0sKfW0yoqOmCnjZuLUQ==
X-Received: by 2002:a81:9289:0:b0:58c:54f8:bd45 with SMTP id j131-20020a819289000000b0058c54f8bd45mr7966589ywg.44.1692640371163;
        Mon, 21 Aug 2023 10:52:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b16-20020a0dd910000000b00577139f85dfsm2337195ywe.22.2023.08.21.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:52:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 10:52:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     =?UTF-8?Q?Franklin_=E2=80=9CSnaipe=E2=80=9D_Mathieu?= 
        <snaipe@arista.com>, Hugh Dickins <hughd@google.com>,
        ovt@google.com, corbet@lwn.net, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] shmem: add support for user extended attributes
In-Reply-To: <20230815-sensibel-weltumsegelung-6593f2195293@brauner>
Message-ID: <924ed61c-5681-aa8b-d943-7f73694d159@google.com>
References: <9b8d38f0-fd22-3f98-d070-16baf976ecb5@google.com> <20230814082339.2006418-1-snaipe@arista.com> <986c412c-669a-43fe-d72a-9e81bca8211@google.com> <CAK8sBDM5aid1vkCKhBxqUHXrG_FbDRN0noLtPkcPv=jXb7NTNg@mail.gmail.com>
 <20230815-sensibel-weltumsegelung-6593f2195293@brauner>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1288635433-1692640370=:4598"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1288635433-1692640370=:4598
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 15 Aug 2023, Christian Brauner wrote:
> On Tue, Aug 15, 2023 at 09:46:22AM +0200, Franklin =E2=80=9CSnaipe=E2=80=
=9D Mathieu wrote:
> >=20
> > So, it's likely that there's some more work to do in that area; I'd
> > certainly expect the OOM killer to take the overall memory footprint
> > of mount namespaces into account when selecting which processes to
> > kill. It's also possible my experiment was flawed and not
> > representative of a real-life scenario, as I clearly have interacted
> > with misbehaving containers before, which got killed when they wrote
> > too much to tmpfs. But then again, my experiment also didn't take
> > memory cgroups into account.
>=20
> So mount namespaces are orthogonal to that and they would be the wrong
> layer to handle this.
>=20
> Note that an unprivileged user (regular or via containers) on the system
> can just exhaust all memory in various ways. Ultimately the container or
> user would likely be taken down by in-kernel OOM or systemd-oomd or
> similar tools under memory pressure.
>=20
> Of course, all that means is that untrusted workloads need to have
> cgroup memory limits. That also limits tmpfs instances and prevents
> unprivileged user from using all memory.
>=20
> If you don't set a memory limit then yes, the container might be able to
> exhaust all memory but that's a bug in the container runtime. Also, at
> some point the OOM killer or related userspace tools will select the
> container init process for termination at which point all the namespaces
> and mounts go away. That's probably what you experience as misbehaving
> containers. The real bug there is probably that they're allowed to run
> without memory limits in the first place.

Thanks, this was a good reminder that I very much needed to look back at
the memory cgroup limiting of xattrs on tmpfs - I'd had the patch in the
original series, then was alarmed to find shmem_alloc_inode() using
GFP_KERNEL, so there seemed no point in accounting the xattrs if the
inodes were not being accounted: so dropped it temporarily.  I had
forgotten that SLAB_ACCOUNT on the kmem_cache ensures that accounting.

"tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs" just sent to fix it:
https://lore.kernel.org/linux-fsdevel/f6953e5a-4183-8314-38f2-40be60998615@=
google.com/

Thanks,
Hugh
---1463760895-1288635433-1692640370=:4598--
