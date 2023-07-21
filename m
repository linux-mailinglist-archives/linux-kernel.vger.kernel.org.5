Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836075CC41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGUPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGUPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:44:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C3430C1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:44:00 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D4613FA79
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689954239;
        bh=1s5oYUJ8OXtji5eAB+Ru06SCFp+i+BjXOikzlarYyx8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=oOPCjQj+7AVWlwU4/4l0MjD1SYaEvEOx366G2neSbhLjaSAZ+pNTZf7liTaYBMOUg
         D4Z5XAKi4sOi5sPceAEO5eN4eGBn92bpChcTKpv2KaYpZQk9EE6xJRtYF1Ux3V/0L/
         dCPkhZ5rG1t5m4Lr8luu5ZPrhbHAXJJyFLdkCehxX/Z0zHcbjezITAaxu3ZhA+PnUK
         ZeXwiNUaUBJ4sVABerJoGUBNRKAVqCP/058B9uVSh6bRyBbZcJoX5hyJpZpfaMiUa7
         FFHFFqvYvDvlat6SZoMFZnr7kGIz6wOPGNp3F7guDGWD/P9MjtqU/14CrJ9T7dMPpg
         qHgR63+uTNoiw==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d052f49702dso422733276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954237; x=1690559037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s5oYUJ8OXtji5eAB+Ru06SCFp+i+BjXOikzlarYyx8=;
        b=ITvXCUK4X0ySVFHAgoHgv0VufQEUPDByGC/nLZmcrbYXj+t4/8O/y55YfxcUa7eF4t
         RKaKwspLgb2dsxBHGB2dx7/fOSeE6n+xwZNEkgZVt90fhp3qLAZ1NM0dT9ucTpDXLGlI
         Wx2m/4v5VoUHRfZOjVpX0HkCifvi/OtajbgiXHlO2msw/yoQ2Tb/tHjRvNzfy1ZmpQCI
         Qm3hYvykPuWw5fYIYMOkc6I78jpCoSwDiUJb3JAugiI2V3ciHdr4qgm9Lt0IxCb14uuo
         fOUSHZj0jExX9L8Lquqmft5r//0sHBqOHP4YokyCybPtPQchdZH3ixrjjHIlKO0PZDVj
         demQ==
X-Gm-Message-State: ABy/qLbCCALI8rT99wbSghWN0MfKu0DR8lMY8ilK8jKIs3GMDDjRs75W
        2mks7qgtIdhZOdW8+mJjV7sUtl3RLyfr6e8JOM92LRLhPRMjzoDxSQtKFahxb0qtVeW3lUSXk2E
        BA8RUsGcJ/tjIbDfhfRuEDIk0YNmfz74Qwx6wZaELBUdYMfJoLWQVFjeqyRqD/UiWjuCm
X-Received: by 2002:a25:c85:0:b0:d05:7af:9893 with SMTP id 127-20020a250c85000000b00d0507af9893mr861943ybm.18.1689954237143;
        Fri, 21 Jul 2023 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAr3BYL57bhLDZG9B3Na0oOEK6CJ34vDEGmUkKeDsMOxWFm8qYNAWscLNj9y0yHxqjplNCYfV3UtfkxwYAPMs=
X-Received: by 2002:a25:c85:0:b0:d05:7af:9893 with SMTP id 127-20020a250c85000000b00d0507af9893mr861925ybm.18.1689954236837;
 Fri, 21 Jul 2023 08:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
 <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com> <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
 <0a42c5d0-0479-e60e-ac84-be3b915c62d9@redhat.com> <CAEivzxcskn8WxcOo0PDHMascFRdYTD0Lr5Uo4fj3deBjDviOXA@mail.gmail.com>
 <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com> <CAEivzxcaJQvYyutAL8xapvoer06c97uVSVC729pUE=4_z4m_CA@mail.gmail.com>
 <CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com> <3af4f092-8de7-d217-cd2d-d39dfc625edd@redhat.com>
In-Reply-To: <3af4f092-8de7-d217-cd2d-d39dfc625edd@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 21 Jul 2023 17:43:45 +0200
Message-ID: <CAEivzxcM2=nwtTJ7ZUwubk0m4Fr+otuqzJhp+bRAYLMXuEYZgg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:36=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 7/19/23 19:57, Aleksandr Mikhalitsyn wrote:
> > On Tue, Jul 18, 2023 at 4:49=E2=80=AFPM Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> >> On Tue, Jul 18, 2023 at 3:45=E2=80=AFAM Xiubo Li <xiubli@redhat.com> w=
rote:
> [...]
> >> No, the idea is to stop mapping a caller_{uid, gid}. And to add a new
> >> fields like
> >> inode_owner_{uid, gid} which will be idmapped (this field will be spec=
ific only
> >> for those operations that create a new inode).
> > I've decided to write some summary of different approaches and
> > elaborate tricky places.
> >
> > Current implementation.
> >
> > We have head->caller_{uid,gid} fields mapped in according
> > to the mount's idmapping. But as we don't have information about
> > mount's idmapping in all call stacks (like ->lookup case), we
> > are not able to map it always and they are left untouched in these case=
s.
> >
> > This tends to an inconsistency between different inode_operations,
> > for example ->lookup (don't have an access to an idmapping) and
> > ->mkdir (have an idmapping as an argument).
> >
> > This inconsistency is absolutely harmless if the user does not
> > use UID/GID-based restrictions. Because in this use case head->caller_{=
uid,gid}
> > fields used *only* to set inode owner UID/GID during the inode_operatio=
ns
> > which create inodes.
> >
> > Conclusion 1. head->caller_{uid,gid} fields have two meanings
> > - UID/GID-based permission checks
> > - inode owner information
> >
> > Solution 0. Ignore the issue with UID/GID-based restrictions and idmapp=
ed mounts
> > until we are not blamed by users ;-)
> >
> > As far as I can see you are not happy about this way. :-)
> >
> > Solution 1. Let's add mount's idmapping argument to all inode_operation=
s
> > and always map head->caller_{uid,gid} fields.
> >
> > Not a best idea, because:
> > - big modification of VFS layer
> > - ideologically incorrect, for instance ->lookup should not care
> > and know *anything* about mount's idmapping, because ->lookup works
> > not on the mount level (it's not important who and through which mount
> > triggered the ->lookup). Imagine that you've dentry cache filled and ca=
ll
> > open(...) in this case ->lookup can be uncalled. But if the user was no=
t lucky
> > enough to have cache filled then open(..) will trigger the lookup and
> > then ->lookup results will be dependent on the mount's idmapping. It
> > seems incorrect
> > and unobvious consequence of introducing such a parameter to ->lookup o=
peration.
> > To summarize, ->lookup is about filling dentry cache and dentry cache
> > is superblock-level
> > thing, not mount-level.
> >
> > Solution 2. Add some kind of extra checks to ceph-client and ceph
> > server to detect that
> > mount idmappings used with UID/GID-based restrictions and restrict such=
 mounts.
> >
> > Seems not ideal to me too. Because it's not a fix, it's a limitation
> > and this limitation is
> > not cheap from the implementation perspective (we need heavy changes
> > in ceph server side and
> > client side too). Btw, currently VFS API is also not ready for that,
> > because we can't
> > decide if idmapped mounts are allowed or not in runtime. It's a static
> > thing that should be declared
> > with FS_ALLOW_IDMAP flag in (struct file_system_type)->fs_flags. Not a
> > big deal, but...
> >
> > Solution 3. Add a new UID/GID fields to ceph request structure in
> > addition to head->caller_{uid,gid}
> > to store information about inode owners (only for inode_operations
> > which create inodes).
> >
> > How does it solves the problem?
> > With these new fields we can leave head->caller_{uid,gid} untouched
> > with an idmapped mounts code.
> > It means that UID/GID-based restrictions will continue to work as inten=
ded.
> >
> > At the same time, new fields (let say "inode_owner_{uid,gid}") will be
> > mapped in accordance with
> > a mount's idmapping.
> >
> > This solution seems ideal, because it is philosophically correct, it
> > makes cephfs idmapped mounts to work
> > in the same manner and way as idmapped mounts work for any other
> > filesystem like ext4.
>
> Okay, this approach sounds more reasonable to me. But you need to do
> some extra work to make it to be compatible between {old,new} kernels
> and  {old,new} cephs.
>
> So then the caller uid/gid will always be the user uid/gid issuing the
> requests as now.

Dear Xiubo,

I've posted a PR https://github.com/ceph/ceph/pull/52575

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
> > But yes, this requires cephfs protocol changes...
> >
> > I personally still believe that the "Solution 0" approach is optimal
> > and we can go with "Solution 3" way
> > as the next iteration.
> >
> > Kind regards,
> > Alex
> >
> >> And also the same for other non-create requests. If
> >>> so this will be incorrect for the cephx perm checks IMO.
> >> Thanks,
> >> Alex
> >>
> >>> Thanks
> >>>
> >>> - Xiubo
> >>>
> >>>
> >>>> This makes a problem with path-based UID/GID restriction mechanism,
> >>>> because it uses head->caller_{uid,gid} fields
> >>>> to check if UID/GID is permitted or not.
> >>>>
> >>>> So, the problem is that we have one field in ceph request for two
> >>>> different needs - to control permissions and to set inode owner.
> >>>> Christian pointed that the most saner way is to modify ceph protocol
> >>>> and add a separate field to store inode owner UID/GID,
> >>>> and only this fields should be idmapped, but head->caller_{uid,gid}
> >>>> will be untouched.
> >>>>
> >>>> With this approach, we will not affect UID/GID-based permission rule=
s
> >>>> with an idmapped mounts at all.
> >>>>
> >>>> Kind regards,
> >>>> Alex
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>> - Xiubo
> >>>>>
> >>>>>
> >>>>>> Kind regards,
> >>>>>> Alex
> >>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>> - Xiubo
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>
> >>>>>>>>> - Xiubo
> >>>>>>>>>
>
