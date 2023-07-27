Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32AB7646F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjG0GhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjG0GhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:37:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C402115
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:36:56 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F2C9413BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690439813;
        bh=ixXUsdEbp7NrDCpAcykv+BGZ2S4P9k7Jx6fAAO/vohM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lYNCFIq9tSNjp0gR6NodJ8i8o+vzEnZatJ1nAoCLAB2emJpSoY+xwplhUbxHeHm3E
         D/rnqhJB4iG6IuwlZXWBjdYtojoAoCXEQVonFfiXSforLzuN0ldNFNIfy4MP9yiVyP
         t9W+jOwAWNgiPzWBy6uXtCCcPRxDYaZemsY7nz+CB/kfTaE46XIg/9LHDztMB2g0pA
         KCYcFrOOZJKkho7gYrmDY/oMlKyDYlfyJ79Z6CCyLjlZmb6YLY90TE92/aIjCf3lsn
         zn0u6BsU2xnXvqieny8/MFy1NHjeCvr/p49nHS/6daJjHX73od0NEwjkMNUJWazwRL
         xW0U6gQ9yAEyw==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d10792c7582so589880276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690439811; x=1691044611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixXUsdEbp7NrDCpAcykv+BGZ2S4P9k7Jx6fAAO/vohM=;
        b=bFaw9A6Yu+77NrXBXv3h6qRSvG6m/IrAO26BrsWiaqVaKRkDu20Iniid0F7fZi5k7X
         sU8Ft2ULesFzmp9maDHzP7QfAZb9cP7VIUQEMP3yiNqfjpCPwq1F3Cea/Tn7iXsTvpc4
         /Kd5swPXcsGSllOjo07DnKpLE4+aBXFVsAWDkI/M5svDdPfQmonNR7OXCd7ExRz5tDER
         9eVNfCtxVGVRjAXeWlHkL1ePS4WIkwDB49nuwiEYmjTA0Yxml0I4cadhxnUHhk/fpO4k
         V4pbeJfFiH+Ole0jL4sbFbliXitdNTe0MuGcQODpYoo/rewGE/ef0KUxfNal/VtQwoDf
         6umQ==
X-Gm-Message-State: ABy/qLa5aYck2X9RZpBvxDmOM85GHd9cM5ig2uSg8FaITwuxM7hDyIwk
        n2FgPiAkpZFQbdcd/ecvoVXQrCoKmNlHo4aU0jSwsDY6Z7ed4fkmh4TSBzWaZ7Qbm5UjiVXRAVX
        RZWr1yX+RUuhw+3tkc4quENVQjbfAs32/rxaJhfUJGCEUpjbVoz3J2VyaEQ==
X-Received: by 2002:a25:bcc5:0:b0:d09:615b:4ff0 with SMTP id l5-20020a25bcc5000000b00d09615b4ff0mr3464538ybm.28.1690439811658;
        Wed, 26 Jul 2023 23:36:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFY77dwconKnXUDwu7xpJub4pzi1QmIlqbM2S6AnVh/Ebxq7At7wlmSPJ+ZZ5vESJTznNVV52AuL1+AGwn6pHo=
X-Received: by 2002:a25:bcc5:0:b0:d09:615b:4ff0 with SMTP id
 l5-20020a25bcc5000000b00d09615b4ff0mr3464530ybm.28.1690439811352; Wed, 26 Jul
 2023 23:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com> <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com>
In-Reply-To: <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 27 Jul 2023 08:36:40 +0200
Message-ID: <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 7:30=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> > Inode operations that create a new filesystem object such as ->mknod,
> > ->create, ->mkdir() and others don't take a {g,u}id argument explicitly=
.
> > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > filesystem object.
> >
> > In order to ensure that the correct {g,u}id is used map the caller's
> > fs{g,u}id for creation requests. This doesn't require complex changes.
> > It suffices to pass in the relevant idmapping recorded in the request
> > message. If this request message was triggered from an inode operation
> > that creates filesystem objects it will have passed down the relevant
> > idmaping. If this is a request message that was triggered from an inode
> > operation that doens't need to take idmappings into account the initial
> > idmapping is passed down which is an identity mapping.
> >
> > This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWN=
ER_UIDGID
> > which adds two new fields (owner_{u,g}id) to the request head structure=
.
> > So, we need to ensure that MDS supports it otherwise we need to fail
> > any IO that comes through an idmapped mount because we can't process it
> > in a proper way. MDS server without such an extension will use caller_{=
u,g}id
> > fields to set a new inode owner UID/GID which is incorrect because call=
er_{u,g}id
> > values are unmapped. At the same time we can't map these fields with an
> > idmapping as it can break UID/GID-based permission checks logic on the
> > MDS side. This problem was described with a lot of details at [1], [2].
> >
> > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuib=
rhA3RKM=3DZOYLg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.=
org/
> >
> > Cc: Xiubo Li <xiubli@redhat.com>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Ilya Dryomov <idryomov@gmail.com>
> > Cc: ceph-devel@vger.kernel.org
> > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v7:
> >       - reworked to use two new fields for owner UID/GID (https://githu=
b.com/ceph/ceph/pull/52575)
> > ---
> >   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
> >   fs/ceph/mds_client.h         |  5 ++++-
> >   include/linux/ceph/ceph_fs.h |  4 +++-
> >   3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index c641ab046e98..ac095a95f3d0 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
> >   {
> >       int mds =3D session->s_mds;
> >       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> > +     struct ceph_client *cl =3D mdsc->fsc->client;
> >       struct ceph_msg *msg;
> >       struct ceph_mds_request_head_legacy *lhead;
> >       const char *path1 =3D NULL;
> > @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(s=
truct ceph_mds_session *session,
> >       lhead =3D find_legacy_request_head(msg->front.iov_base,
> >                                        session->s_con.peer_features);
> >
> > +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_featur=
es)) {
> > +             pr_err_ratelimited_client(cl,
> > +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OW=
NER_UIDGID"
> > +                     " is not supported by MDS. Fail request with -EIO=
.\n");
> > +
> > +             ret =3D -EIO;
> > +             goto out_err;
> > +     }
> > +
>
> I think this couldn't fail the mounting operation, right ?

This won't fail mounting. First of all an idmapped mount is always an
additional mount, you always
start from doing "normal" mount and only after that you can use this
mount to create an idmapped one.
( example: https://github.com/brauner/mount-idmapped/tree/master )

>
> IMO we should fail the mounting from the beginning.

Unfortunately, we can't fail mount from the beginning. Procedure of
the idmapped mounts
creation is handled not on the filesystem level, but on the VFS level
(source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774a004=
c0424260a90bd/fs/namespace.c#L4277
)

Kernel perform all required checks as:
- filesystem type has declared to support idmappings
(fs_type->fs_flags & FS_ALLOW_IDMAP)
- user who creates idmapped mount should be CAP_SYS_ADMIN in a user
namespace that owns superblock of the filesystem
(for cephfs it's always init_user_ns =3D> user should be root on the host)

So I would like to go this way because of the reasons mentioned above:
- root user is someone who understands what he does.
- idmapped mounts are never "first" mounts. They are always created
after "normal" mount.
- effectively this check makes "normal" mount to work normally and
fail only requests that comes through an idmapped mounts
with reasonable error message. Obviously, all read operations will
work perfectly well only the operations that create new inodes will
fail.
Btw, we already have an analogical semantic on the VFS level for users
who have no UID/GID mapping to the host. Filesystem requests for
such users will fail with -EOVERFLOW. Here we have something close.

I think we can take a look at this in the future when some other
filesystem will require the same feature of
checking idmapped mounts creation on the filesystem level. (We can
introduce some extra callback on the superblock
level or something like that.) But I think that it makes sense to do
that when cephfs will be allowed to be mounted in
the user namespace.

I hope that Christian Brauner will add something here. :-)

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
> >       /*
> >        * The ceph_mds_request_head_legacy didn't contain a version fiel=
d, and
> >        * one was added when we moved the message version from 3->4.
> > @@ -3043,10 +3054,19 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >               p =3D msg->front.iov_base + sizeof(*ohead);
> >       } else {
> >               struct ceph_mds_request_head *nhead =3D msg->front.iov_ba=
se;
> > +             kuid_t owner_fsuid;
> > +             kgid_t owner_fsgid;
> >
> >               msg->hdr.version =3D cpu_to_le16(6);
> >               nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERS=
ION);
> >               p =3D msg->front.iov_base + sizeof(*nhead);
> > +
> > +             owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_=
ns,
> > +                                       VFSUIDT_INIT(req->r_cred->fsuid=
));
> > +             owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_=
ns,
> > +                                       VFSGIDT_INIT(req->r_cred->fsgid=
));
> > +             nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user_ns,=
 owner_fsuid));
> > +             nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user_ns,=
 owner_fsgid));
> >       }
> >
> >       end =3D msg->front.iov_base + msg->front.iov_len;
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index e3bbf3ba8ee8..8f683e8203bd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -33,8 +33,10 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> >       CEPHFS_FEATURE_OP_GETVXATTR,
> >       CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> > +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >
> > -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >   };
> >
> >   #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
> > @@ -49,6 +51,7 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
> >       CEPHFS_FEATURE_OP_GETVXATTR,            \
> >       CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> > +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >   }
> >
> >   /*
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.=
h
> > index 5f2301ee88bc..6eb83a51341c 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
> >       union ceph_mds_request_args args;
> >   } __attribute__ ((packed));
> >
> > -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> > +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
> >
> >   struct ceph_mds_request_head_old {
> >       __le16 version;                /* struct version */
> > @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
> >
> >       __le32 ext_num_retry;          /* new count retry attempts */
> >       __le32 ext_num_fwd;            /* new count fwd attempts */
> > +
> > +     __le32 owner_uid, owner_gid;   /* used for OPs which create inode=
s */
> >   } __attribute__ ((packed));
> >
> >   /* cap/lease release record */
>
