Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857276490B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjG0Hmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjG0HmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:42:07 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF37D99
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:35:58 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04CF4413C2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690443320;
        bh=RKMCuKHuWbZ4j6RU2sqbTQzBCOCRVev47qJw1PwY77A=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fk+4zGp5psUPlUD8D/T6E8iXYt3LD6Fee9S2unm+l0Z0gwGrjUNO/8e08ihHP9h15
         +04yWu0zMjpEtgagxyxaWddjIeQt8suVchJNLCKrOhgLhZDuyQDCrrWKSO/eaybT40
         4rFYktXFQjaB+3279Kwc3SEbIGCGLPPAmUOrm1AxC8wJbfVVQbcM2soQUP1ZsEhFxk
         F964iZHZBnXbJ2kdrCPg1JTUi55KkMe6bj6DElg4b2AGdrlpnDTRrByKZ1U37sb/6J
         GWH519ykpWHh4nClAtSD07qHh8kSo46pKFadtscJC415cFAIB+Hx4FKLwZkRA3tm+k
         Te6x39oDx713g==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5844e92ee6bso7070227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443318; x=1691048118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKMCuKHuWbZ4j6RU2sqbTQzBCOCRVev47qJw1PwY77A=;
        b=dTmEptJpevd4gA3xJJ5KYJcrjhpzJIoslJXVFG6MnqrKjtyrrLsfesCl7pSgHy+7FY
         bq0+KzZ37lwRBv4tv60IVWl8x5P1Z8EaC6b7xAr3sG1iZ3Umu6SaUdTLrL5eJvMYs0b6
         d/uBbyTEScBAhjktzX8RpTbJ3+NmcYp/8I3YaFPwjO5l7hWG0hrxVZQpk6TesekGC820
         Gwh/UaRuKX3fH0i2uKaEcj4UUsKjMsOTLukTsvzNO0XHMfA+tjfB3Yz9k/F8lLxtPYxE
         DfkVzOo6oP9DmJ7wixd2epBYh/bMUAfIavlZdTRHPoyzwu08ieeUCz8ENlqk7l6PeumS
         ElxA==
X-Gm-Message-State: ABy/qLaxJUaiwBoqVNVAQZCFwxQOJoPXjN0mTxlig7FhFgJyP77lmirg
        CFTv/2UOS8iomHMyxU++A9PUkTUuFuY//jKxtrAAALyybajeIeSHUl5APoAGvlaHkENw7rW2RhD
        eJJfOCuN6nTWe4NHHRpw7IyQCI3Nrx/s43Tzby6r+WXWOdvW4/QFm0D/8MX6G7WeZYHA6
X-Received: by 2002:a25:d2cf:0:b0:d11:254a:aa71 with SMTP id j198-20020a25d2cf000000b00d11254aaa71mr3956784ybg.44.1690443318636;
        Thu, 27 Jul 2023 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQWTziFIdSl949Gbo6TbYPQXIEHcrd2JhcuVf6LNgcgAxRgZpAWf52mIo9nPrwStZmnIE39ZAMchBSvFIOdWc=
X-Received: by 2002:a25:d2cf:0:b0:d11:254a:aa71 with SMTP id
 j198-20020a25d2cf000000b00d11254aaa71mr3956776ybg.44.1690443318423; Thu, 27
 Jul 2023 00:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com> <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 27 Jul 2023 09:35:07 +0200
Message-ID: <CAEivzxfj+E7uF9PD-6qLkLMLOUa494Oq=6TTQYT3NtQOdyZPBg@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
To:     xiubli@redhat.com
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

On Wed, Jul 26, 2023 at 4:10=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>

Oops, have just noticed. Author of this commit should be Christian Brauner.
It's because I've squashed this commit into the previous one (which
was the commit that updated struct ceph_mds_request_head).
I'll fix that next time.

> Inode operations that create a new filesystem object such as ->mknod,
> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> filesystem object.
>
> In order to ensure that the correct {g,u}id is used map the caller's
> fs{g,u}id for creation requests. This doesn't require complex changes.
> It suffices to pass in the relevant idmapping recorded in the request
> message. If this request message was triggered from an inode operation
> that creates filesystem objects it will have passed down the relevant
> idmaping. If this is a request message that was triggered from an inode
> operation that doens't need to take idmappings into account the initial
> idmapping is passed down which is an identity mapping.
>
> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER=
_UIDGID
> which adds two new fields (owner_{u,g}id) to the request head structure.
> So, we need to ensure that MDS supports it otherwise we need to fail
> any IO that comes through an idmapped mount because we can't process it
> in a proper way. MDS server without such an extension will use caller_{u,=
g}id
> fields to set a new inode owner UID/GID which is incorrect because caller=
_{u,g}id
> values are unmapped. At the same time we can't map these fields with an
> idmapping as it can break UID/GID-based permission checks logic on the
> MDS side. This problem was described with a lot of details at [1], [2].
>
> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrh=
A3RKM=3DZOYLg@mail.gmail.com/
> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.or=
g/
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
> v7:
>         - reworked to use two new fields for owner UID/GID (https://githu=
b.com/ceph/ceph/pull/52575)
> ---
>  fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
>  fs/ceph/mds_client.h         |  5 ++++-
>  include/linux/ceph/ceph_fs.h |  4 +++-
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index c641ab046e98..ac095a95f3d0 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_message(stru=
ct ceph_mds_session *session,
>  {
>         int mds =3D session->s_mds;
>         struct ceph_mds_client *mdsc =3D session->s_mdsc;
> +       struct ceph_client *cl =3D mdsc->fsc->client;
>         struct ceph_msg *msg;
>         struct ceph_mds_request_head_legacy *lhead;
>         const char *path1 =3D NULL;
> @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_message(str=
uct ceph_mds_session *session,
>         lhead =3D find_legacy_request_head(msg->front.iov_base,
>                                          session->s_con.peer_features);
>
> +       if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> +           !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_featur=
es)) {
> +               pr_err_ratelimited_client(cl,
> +                       "idmapped mount is used and CEPHFS_FEATURE_HAS_OW=
NER_UIDGID"
> +                       " is not supported by MDS. Fail request with -EIO=
.\n");
> +
> +               ret =3D -EIO;
> +               goto out_err;
> +       }
> +
>         /*
>          * The ceph_mds_request_head_legacy didn't contain a version fiel=
d, and
>          * one was added when we moved the message version from 3->4.
> @@ -3043,10 +3054,19 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
>                 p =3D msg->front.iov_base + sizeof(*ohead);
>         } else {
>                 struct ceph_mds_request_head *nhead =3D msg->front.iov_ba=
se;
> +               kuid_t owner_fsuid;
> +               kgid_t owner_fsgid;
>
>                 msg->hdr.version =3D cpu_to_le16(6);
>                 nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERS=
ION);
>                 p =3D msg->front.iov_base + sizeof(*nhead);
> +
> +               owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_=
ns,
> +                                         VFSUIDT_INIT(req->r_cred->fsuid=
));
> +               owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_=
ns,
> +                                         VFSGIDT_INIT(req->r_cred->fsgid=
));
> +               nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user_ns,=
 owner_fsuid));
> +               nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user_ns,=
 owner_fsgid));
>         }
>
>         end =3D msg->front.iov_base + msg->front.iov_len;
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index e3bbf3ba8ee8..8f683e8203bd 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -33,8 +33,10 @@ enum ceph_feature_type {
>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>         CEPHFS_FEATURE_OP_GETVXATTR,
>         CEPHFS_FEATURE_32BITS_RETRY_FWD,
> +       CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> +       CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>
> -       CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> +       CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>  };
>
>  #define CEPHFS_FEATURES_CLIENT_SUPPORTED {     \
> @@ -49,6 +51,7 @@ enum ceph_feature_type {
>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
>         CEPHFS_FEATURE_OP_GETVXATTR,            \
>         CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> +       CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
>  }
>
>  /*
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index 5f2301ee88bc..6eb83a51341c 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
>         union ceph_mds_request_args args;
>  } __attribute__ ((packed));
>
> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
>
>  struct ceph_mds_request_head_old {
>         __le16 version;                /* struct version */
> @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
>
>         __le32 ext_num_retry;          /* new count retry attempts */
>         __le32 ext_num_fwd;            /* new count fwd attempts */
> +
> +       __le32 owner_uid, owner_gid;   /* used for OPs which create inode=
s */
>  } __attribute__ ((packed));
>
>  /* cap/lease release record */
> --
> 2.34.1
>
