Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27167594B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGSL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:57:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F5CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:57:40 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B6923F171
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689767859;
        bh=50fI6ytW8x/Kq9eZRnk0hUtItl8ywHtvZMF0CGzwqmI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=I6cxLifC/ysdXlbEUsyCGmu8citBQXGSo9LYjh0qyJDUCoTILYLq8fNHjhW2L83fn
         FzWT/gjGGygaoANktr9DUddApiOxAj8g7fqnZ6twTIRDViO03ICzbIsChbQ0DY52uA
         BFqhW0PiGChLvusMImPr7F8slzE6FwHouUz5v4scHNyiI/l1+uIRhnhBFItSYAiudr
         bBys2zbvvTzEuYyQ0uKL2QYFNotlcjQNSoHYVsZhBBmdNpXWZG3/ImwcWbVwZ82mEa
         1ZDQohRnUChsm7GPkSOK4fOsSb9HRNR5HZDzKGFOSO6pUAECAlFZbX5v+4D9VfgNlg
         LzMHkHMOKFx2A==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-573cacf4804so60019797b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767858; x=1692359858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50fI6ytW8x/Kq9eZRnk0hUtItl8ywHtvZMF0CGzwqmI=;
        b=GwmBlilXtzHvsbuw1naGchsx3F6tmn++KKwjzOLPN2HJe640daM3QdonOPcxIPzLhL
         ZKLWZriLI+CyESn2tNa14DPIhHIMrfQPkuEmr4+dh3b3YT5yyOdj9z2a0qm7yN7DQ0uE
         vLpPcnveaNPff2wUFv/wNR1g8A9wLztPPFwzTaTLUKqT7CiKw3StjSMwqmdSBHdPg3D2
         s21CIq+zjzb4ImXhfy8axneXPDKB5SuGHAo0p9avO0lEX/BokRkio6Kujs8w/RYiY5cc
         QDGQnPN1rP5e2ZQMB0A5nBVSHGP8sEXAJC8cUAQ8AUMnnvvoqKrU5zoxqsKkhQazOOEm
         O2Mg==
X-Gm-Message-State: ABy/qLZNkPUZdKeRDjIRF9a5VrTqTVvJidfMzYsWp6K7JfTyps4s7rxS
        PGzvIf39pO1Dh5yZlFO4ieOyWFz5kyB7OxG53iqpCWPB1/LSEAf/pbYOSLFKRMv32knOpIhgzQH
        Zhj4KZFjrfgzhbS+b7WhZNYu21yx+18bWEWoczfYJv3zjzheVFN77MtB7RQ==
X-Received: by 2002:a25:34d:0:b0:c60:9caf:bf57 with SMTP id 74-20020a25034d000000b00c609cafbf57mr2300237ybd.45.1689767857793;
        Wed, 19 Jul 2023 04:57:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHggmXaenfc+ImeNRxpPBDeuCeygqr1ew0o8ylIUV9Gia2o9rFn8tdBrNz/vERMNlhZtnW8tBWiwKidftn0EQE=
X-Received: by 2002:a25:34d:0:b0:c60:9caf:bf57 with SMTP id
 74-20020a25034d000000b00c609cafbf57mr2300213ybd.45.1689767857367; Wed, 19 Jul
 2023 04:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
 <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com> <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
 <0a42c5d0-0479-e60e-ac84-be3b915c62d9@redhat.com> <CAEivzxcskn8WxcOo0PDHMascFRdYTD0Lr5Uo4fj3deBjDviOXA@mail.gmail.com>
 <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com> <CAEivzxcaJQvYyutAL8xapvoer06c97uVSVC729pUE=4_z4m_CA@mail.gmail.com>
In-Reply-To: <CAEivzxcaJQvYyutAL8xapvoer06c97uVSVC729pUE=4_z4m_CA@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 19 Jul 2023 13:57:26 +0200
Message-ID: <CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 4:49=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Tue, Jul 18, 2023 at 3:45=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrot=
e:
> >
> >
> > On 7/14/23 20:57, Aleksandr Mikhalitsyn wrote:
> > > On Tue, Jul 4, 2023 at 3:09=E2=80=AFAM Xiubo Li <xiubli@redhat.com> w=
rote:
> > >> Sorry, not sure, why my last reply wasn't sent out.
> > >>
> > >> Do it again.
> > >>
> > >>
> > >> On 6/26/23 19:23, Aleksandr Mikhalitsyn wrote:
> > >>> On Mon, Jun 26, 2023 at 4:12=E2=80=AFAM Xiubo Li<xiubli@redhat.com>=
  wrote:
> > >>>> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
> > >>>>> On Sat, Jun 24, 2023 at 3:37=E2=80=AFAM Xiubo Li<xiubli@redhat.co=
m>  wrote:
> > >>>>>> [...]
> > >>>>>>
> > >>>>>>     > > >
> > >>>>>>     > > > I thought about this too and came to the same conclusi=
on, that
> > >>>>>> UID/GID
> > >>>>>>     > > > based
> > >>>>>>     > > > restriction can be applied dynamically, so detecting i=
t on mount-time
> > >>>>>>     > > > helps not so much.
> > >>>>>>     > > >
> > >>>>>>     > > For this you please raise one PR to ceph first to suppor=
t this, and in
> > >>>>>>     > > the PR we can discuss more for the MDS auth caps. And af=
ter the PR
> > >>>>>>     > > getting merged then in this patch series you need to che=
ck the
> > >>>>>>     > > corresponding option or flag to determine whether could =
the idmap
> > >>>>>>     > > mounting succeed.
> > >>>>>>     >
> > >>>>>>     > I'm sorry but I don't understand what we want to support h=
ere. Do we
> > >>>>>> want to
> > >>>>>>     > add some new ceph request that allows to check if UID/GID-=
based
> > >>>>>>     > permissions are applied for
> > >>>>>>     > a particular ceph client user?
> > >>>>>>
> > >>>>>> IMO we should prevent user to set UID/GID-based permisions caps =
from
> > >>>>>> ceph side.
> > >>>>>>
> > >>>>>> As I know currently there is no way to prevent users to set MDS =
auth
> > >>>>>> caps, IMO in ceph side at least we need one flag or option to di=
sable
> > >>>>>> this once users want this fs cluster sever for idmap mounts use =
case.
> > >>>>> How this should be visible from the user side? We introducing a n=
ew
> > >>>>> kernel client mount option,
> > >>>>> like "nomdscaps", then pass flag to the MDS and MDS should check =
that
> > >>>>> MDS auth permissions
> > >>>>> are not applied (on the mount time) and prevent them from being
> > >>>>> applied later while session is active. Like that?
> > >>>>>
> > >>>>> At the same time I'm thinking about protocol extension that adds =
2
> > >>>>> additional fields for UID/GID. This will allow to correctly
> > >>>>> handle everything. I wanted to avoid any changes to the protocol =
or
> > >>>>> server-side things. But if we want to change MDS side,
> > >>>>> maybe it's better then to go this way?
> > >>> Hi Xiubo,
> > >>>
> > >>>> There is another way:
> > >>>>
> > >>>> For each client it will have a dedicated client auth caps, somethi=
ng like:
> > >>>>
> > >>>> client.foo
> > >>>>      key: *key*
> > >>>>      caps: [mds] allow r, allow rw path=3D/bar
> > >>>>      caps: [mon] allow r
> > >>>>      caps: [osd] allow rw tag cephfs data=3Dcephfs_a
> > >>> Do we have any infrastructure to get this caps list on the client s=
ide
> > >>> right now?
> > >>> (I've taken a quick look through the code and can't find anything
> > >>> related to this.)
> > >> I am afraid there is no.
> > >>
> > >> But just after the following ceph PR gets merged it will be easy to =
do this:
> > >>
> > >> https://github.com/ceph/ceph/pull/48027
> > >>
> > >> This is still under testing.
> > >>
> > >>>> When mounting this client with idmap enabled, then we can just che=
ck the
> > >>>> above [mds] caps, if there has any UID/GID based permissions set, =
then
> > >>>> fail the mounting.
> > >>> understood
> > >>>
> > >>>> That means this kind client couldn't be mounted with idmap enabled=
.
> > >>>>
> > >>>> Also we need to make sure that once there is a mount with idmap en=
abled,
> > >>>> the corresponding client caps couldn't be append the UID/GID based
> > >>>> permissions. This need a patch in ceph anyway IMO.
> > >>> So, yeah we will need to effectively block cephx permission changes=
 if
> > >>> there is a client mounted with
> > >>> an active idmapped mount. Sounds as something that require massive
> > >>> changes on the server side.
> > >> Maybe no need much, it should be simple IMO. But I am not 100% sure.
> > >>
> > >>> At the same time this will just block users from using idmapped mou=
nts
> > >>> along with UID/GID restrictions.
> > >>>
> > >>> If you want me to change server-side anyways, isn't it better just =
to
> > >>> extend cephfs protocol to properly
> > >>> handle UID/GIDs with idmapped mounts? (It was originally proposed b=
y Christian.)
> > >>> What we need to do here is to add a separate UID/GID fields for cep=
h
> > >>> requests those are creating a new inodes
> > >>> (like mknod, symlink, etc).
> > > Dear Xiubo,
> > >
> > > I'm sorry for delay with reply, I've missed this message accidentally=
.
> > >
> > >> BTW, could you explain it more ? How could this resolve the issue we=
 are
> > >> discussing here ?
> > > This was briefly mentioned here
> > > https://lore.kernel.org/all/20220105141023.vrrbfhti5apdvkz7@wittgenst=
ein/#t
> > > by Christian. Let me describe it in detail.
> > >
> > > In the current approach we apply mount idmapping to
> > > head->caller_{uid,gid} fields
> > > to make mkdir/mknod/symlink operations set a proper inode owner
> > > uid/gid in according with an idmapping.
> >
> > Sorry for late.
> >
> > I still couldn't get how this could resolve the lookup case.
> >
> > For a lookup request the caller_{uid, gid} still will be the mapped
> > {uid, gid}, right ?
>
> No, the idea is to stop mapping a caller_{uid, gid}. And to add a new
> fields like
> inode_owner_{uid, gid} which will be idmapped (this field will be specifi=
c only
> for those operations that create a new inode).

I've decided to write some summary of different approaches and
elaborate tricky places.

Current implementation.

We have head->caller_{uid,gid} fields mapped in according
to the mount's idmapping. But as we don't have information about
mount's idmapping in all call stacks (like ->lookup case), we
are not able to map it always and they are left untouched in these cases.

This tends to an inconsistency between different inode_operations,
for example ->lookup (don't have an access to an idmapping) and
->mkdir (have an idmapping as an argument).

This inconsistency is absolutely harmless if the user does not
use UID/GID-based restrictions. Because in this use case head->caller_{uid,=
gid}
fields used *only* to set inode owner UID/GID during the inode_operations
which create inodes.

Conclusion 1. head->caller_{uid,gid} fields have two meanings
- UID/GID-based permission checks
- inode owner information

Solution 0. Ignore the issue with UID/GID-based restrictions and idmapped m=
ounts
until we are not blamed by users ;-)

As far as I can see you are not happy about this way. :-)

Solution 1. Let's add mount's idmapping argument to all inode_operations
and always map head->caller_{uid,gid} fields.

Not a best idea, because:
- big modification of VFS layer
- ideologically incorrect, for instance ->lookup should not care
and know *anything* about mount's idmapping, because ->lookup works
not on the mount level (it's not important who and through which mount
triggered the ->lookup). Imagine that you've dentry cache filled and call
open(...) in this case ->lookup can be uncalled. But if the user was not lu=
cky
enough to have cache filled then open(..) will trigger the lookup and
then ->lookup results will be dependent on the mount's idmapping. It
seems incorrect
and unobvious consequence of introducing such a parameter to ->lookup opera=
tion.
To summarize, ->lookup is about filling dentry cache and dentry cache
is superblock-level
thing, not mount-level.

Solution 2. Add some kind of extra checks to ceph-client and ceph
server to detect that
mount idmappings used with UID/GID-based restrictions and restrict such mou=
nts.

Seems not ideal to me too. Because it's not a fix, it's a limitation
and this limitation is
not cheap from the implementation perspective (we need heavy changes
in ceph server side and
client side too). Btw, currently VFS API is also not ready for that,
because we can't
decide if idmapped mounts are allowed or not in runtime. It's a static
thing that should be declared
with FS_ALLOW_IDMAP flag in (struct file_system_type)->fs_flags. Not a
big deal, but...

Solution 3. Add a new UID/GID fields to ceph request structure in
addition to head->caller_{uid,gid}
to store information about inode owners (only for inode_operations
which create inodes).

How does it solves the problem?
With these new fields we can leave head->caller_{uid,gid} untouched
with an idmapped mounts code.
It means that UID/GID-based restrictions will continue to work as intended.

At the same time, new fields (let say "inode_owner_{uid,gid}") will be
mapped in accordance with
a mount's idmapping.

This solution seems ideal, because it is philosophically correct, it
makes cephfs idmapped mounts to work
in the same manner and way as idmapped mounts work for any other
filesystem like ext4.

But yes, this requires cephfs protocol changes...

I personally still believe that the "Solution 0" approach is optimal
and we can go with "Solution 3" way
as the next iteration.

Kind regards,
Alex

>
> >
> And also the same for other non-create requests. If
> > so this will be incorrect for the cephx perm checks IMO.
>
> Thanks,
> Alex
>
> >
> > Thanks
> >
> > - Xiubo
> >
> >
> > > This makes a problem with path-based UID/GID restriction mechanism,
> > > because it uses head->caller_{uid,gid} fields
> > > to check if UID/GID is permitted or not.
> > >
> > > So, the problem is that we have one field in ceph request for two
> > > different needs - to control permissions and to set inode owner.
> > > Christian pointed that the most saner way is to modify ceph protocol
> > > and add a separate field to store inode owner UID/GID,
> > > and only this fields should be idmapped, but head->caller_{uid,gid}
> > > will be untouched.
> > >
> > > With this approach, we will not affect UID/GID-based permission rules
> > > with an idmapped mounts at all.
> > >
> > > Kind regards,
> > > Alex
> > >
> > >> Thanks
> > >>
> > >> - Xiubo
> > >>
> > >>
> > >>> Kind regards,
> > >>> Alex
> > >>>
> > >>>> Thanks
> > >>>>
> > >>>> - Xiubo
> > >>>>
> > >>>>
> > >>>>
> > >>>>
> > >>>>
> > >>>>> Thanks,
> > >>>>> Alex
> > >>>>>
> > >>>>>> Thanks
> > >>>>>>
> > >>>>>> - Xiubo
> > >>>>>>
> >
