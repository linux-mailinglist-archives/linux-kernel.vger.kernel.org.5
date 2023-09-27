Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC647B023B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjI0Kx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjI0Kx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:53:56 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50D81AB;
        Wed, 27 Sep 2023 03:53:54 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57bd4e4ada6so2721963eaf.3;
        Wed, 27 Sep 2023 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695812034; x=1696416834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC+DWEITqSL8GkrJdto7nTn4KEukFZl6/fUzFsn4eUk=;
        b=loTCEmE5Jfe1YGOKkTtvKHjIqLFmAspXBtu9po7G57a/NS/wOhyLOSzUANSGHKC25p
         am7dZKTAFmQc/P2G9q4HTphW2xXfyUNuEUA557obWIpl862ua0p0+er6Xjxd2uUaPqrA
         C88OXjdZcAtlf2Krg7Z4axwFbwgPlnxjqVJYtmezCNrY7uYDj7vjtMQC2syTOMYtFipG
         SOYRtCA6+dexI3uBR3i+Z5Uv5F90aACyicgKVuIFL4Y8wwiSPM3QxKxmzRi0YsX9Kzpc
         FbET1wKXyHqIflDVMhjsU58hRZfJ2AAjX8BVJFx1pnVKmMgEBZCr8NwVHxKmwhIvQ5KN
         nsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812034; x=1696416834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qC+DWEITqSL8GkrJdto7nTn4KEukFZl6/fUzFsn4eUk=;
        b=YwpCnO/WUrcXz4v5nMPzAIThIaq8rveqF9cfYv/SO6DLPNGWFavYgG2di+9Mq7xJdc
         cyHOk/eCr8iD85n/DpZCVe2sTv2EasC1es+tUIk2lyYH/tcdQ3/PVrcp1fJdtkyCnJd4
         VCIL5rrFlQvut9Ht3DYx3vk/Ptj8jDRSMmuHscorcV5/S6DGuaKfqmdhmXzJgAEd8x1c
         sGa6ILhFN7Piu/dCmnWGr7NptogbZNqad3l+j2Zi0MLRFoBimjaPfCJv692QRGZ/Fwer
         a69ufEccJMc+IBsJ4cQvt3FUSj22kUVUerwiyCEFWivNrvIg6BlfmWqAi0V5SpruXQ9s
         zeog==
X-Gm-Message-State: AOJu0YxS6FnNRNqkU/Knv3286AxBqeQj+UkZWH1VcJTjubCnCgjjbhaq
        WqKxixmU+UnFKbYTjoIF3G28/A769n8prB3EVcM=
X-Google-Smtp-Source: AGHT+IHamR3q9ZXN2veiRZDdZQEZi6lSrz3XxhiC6QxsshhEAx67flTeu8j3OCGSKxgQU4UyhR5S0pbiVCZrbWRaCUU=
X-Received: by 2002:a4a:270c:0:b0:573:4da2:4427 with SMTP id
 l12-20020a4a270c000000b005734da24427mr1711761oof.7.1695812034146; Wed, 27 Sep
 2023 03:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
 <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
 <CAKPOu+-yUOuVh+3818iJ-GH968EHHQ0Pc3d8Rj4veO3k-xLk+g@mail.gmail.com>
 <CAOi1vP9QdfB0uxd64XcpREWFTqrJm0QNORYzrGvQBLOu4CrDWg@mail.gmail.com> <CAKPOu+87ka3z6haYXystbHFCUMRh4mtvOEFmEPsJ_vCW9_81RA@mail.gmail.com>
In-Reply-To: <CAKPOu+87ka3z6haYXystbHFCUMRh4mtvOEFmEPsJ_vCW9_81RA@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 27 Sep 2023 12:53:42 +0200
Message-ID: <CAOi1vP85hF6qbch-mpY+NN5bS4p_ta=WG_b=cfKNOJLD9CrNag@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venky Shankar <vshankar@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:09=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Tue, Sep 26, 2023 at 10:46=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com=
> wrote:
> > No, "ceph" command (as well as "rbd", "rados", etc) can be run from
> > anywhere -- it's just a matter of installing a package which is likely
> > already installed unless you are mounting CephFS manually without using
> > /sbin/mount.ceph mount helper.
>
> I have never heard of that helper, so no, we're not using it - should we?

If you have figured out the right mount options, you might as well not.
The helper does things like determine whether v1 or v2 addresses should
be used, fetch the key and pass it via the kernel keyring (whereas you
are probably passing it verbatim on the command line), etc.  It's the
same syscall in the end, so the helper is certainly not required.

>
> This "ceph" tool requires installing 90 MB of additional Debian
> packages, which I just tried on a test cluster, and "ceph fs top"
> fails with "Error initializing cluster client: ObjectNotFound('RADOS
> object not found (error calling conf_read_file)')". Okay, so I have to
> configure something.... but .... I don't get why I would want to do
> that, when I can get the same information from the kernel without
> installing or configuring anything. This sounds like overcomplexifying
> the thing for no reason.

I have relayed my understanding of this feature (or rather how it was
presented to me).  I see where you are coming from, so adding more
CephFS folks to chime in.

Thanks,

                Ilya
