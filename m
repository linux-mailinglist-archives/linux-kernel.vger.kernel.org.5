Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D7803F56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbjLDUb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjLDUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:31:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8268101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:32:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74239C433C7;
        Mon,  4 Dec 2023 20:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721921;
        bh=vAm568BRd8IC8spgStz9HEYW5+zfw1VvtEJXuqXZs0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W2txz6VTc+5hwhE7CPsVoxkrL44nwF4mkrMlGMA/TgSwJOXpFydcZcX0wLK0Qa94x
         ILCtggIXNV2MH48+JqKyhIqXfSBUCs3LKKkoxl0wA5rsFYb/4iqicG6YRjf6GRsTUZ
         Z8FjUo4dg7dKn8zbtYsJlG8s1Y5xvS1P42t/pufoJ4ze1F+J/bciGvCawHDl2ekxnl
         tsEpkvYMqo+sUJsahVD9kQYou7M5yeOdo/z5glYokqMYBiVusRoSyZ/E+degyr8Cr0
         V9jFTTBnZCf9MSjpH+gyIJzk5ReYXOkPALfGsM8azSBTqyVnTPxnDdfwj8iPkVz1B/
         Xqbcl7XJJPgXw==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-423e6615f24so38495191cf.2;
        Mon, 04 Dec 2023 12:32:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwLCJnW0AKQrLA1VDS0eYsv8ZDEhpQtWCsbvrSEuI2qrHpOFss1
        rvp2RTQ/7gZO7BJ7onPqFcYX5ElMfBI3LR5wP6M=
X-Google-Smtp-Source: AGHT+IE5oJMjzAguWLZfOfPhWuhPSkviWDjHBMJQZvTH0L7iq90tzCC99NDNKm/EKgIRem9LHP1PMtHXwybJdTlYA3o=
X-Received: by 2002:a05:622a:58a:b0:425:4e22:b7c8 with SMTP id
 c10-20020a05622a058a00b004254e22b7c8mr171053qtb.45.1701721920707; Mon, 04 Dec
 2023 12:32:00 -0800 (PST)
MIME-Version: 1.0
References: <tencent_03EDD0CAFBF93A9667CFCA1B68EDB4C4A109@qq.com> <ZWy7ob2HhNRX7Z1b@tissot.1015granger.net>
In-Reply-To: <ZWy7ob2HhNRX7Z1b@tissot.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Mon, 4 Dec 2023 15:31:44 -0500
X-Gmail-Original-Message-ID: <CAFX2JfmrGLmEsXccUGZ5drAJ9oxaqjTUxO0tPVgz_mf9YXZN+Q@mail.gmail.com>
Message-ID: <CAFX2JfmrGLmEsXccUGZ5drAJ9oxaqjTUxO0tPVgz_mf9YXZN+Q@mail.gmail.com>
Subject: Re: [PATCH] NFSv4, NFSD: move enum nfs_cb_opnum4 to include/linux/nfs4.h
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     chenxiaosongemail@foxmail.com, trond.myklebust@hammerspace.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenxiaosong@kylinos.cn,
        liuzhengyuan@kylinos.cn, huhai@kylinos.cn, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023 at 12:32=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Sat, Dec 02, 2023 at 09:07:25PM +0000, chenxiaosongemail@foxmail.com w=
rote:
> > From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >
> > Callback operations enum is defined in client and server, move it to
> > common header file.
> >
> > Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> LGTM.
>
> I can take this through the nfsd-next tree if I get an Acked-by:
> from the NFS client maintainers. If they would like to take this
> through the NFS client tree, let me know, and I will send my
> Acked-by.

Looks fine to me, and I'm okay with you taking it:

Acked-by: Anna Schumaker <Anna.Schumaker@netapp.com>

>
>
> > ---
> >  fs/nfs/callback.h      | 19 -------------------
> >  fs/nfsd/nfs4callback.c | 26 +-------------------------
> >  include/linux/nfs4.h   | 22 ++++++++++++++++++++++
> >  3 files changed, 23 insertions(+), 44 deletions(-)
> >
> > diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
> > index ccd4f245cae2..0279b78b5fc9 100644
> > --- a/fs/nfs/callback.h
> > +++ b/fs/nfs/callback.h
> > @@ -19,25 +19,6 @@ enum nfs4_callback_procnum {
> >       CB_COMPOUND =3D 1,
> >  };
> >
> > -enum nfs4_callback_opnum {
> > -     OP_CB_GETATTR =3D 3,
> > -     OP_CB_RECALL  =3D 4,
> > -/* Callback operations new to NFSv4.1 */
> > -     OP_CB_LAYOUTRECALL  =3D 5,
> > -     OP_CB_NOTIFY        =3D 6,
> > -     OP_CB_PUSH_DELEG    =3D 7,
> > -     OP_CB_RECALL_ANY    =3D 8,
> > -     OP_CB_RECALLABLE_OBJ_AVAIL =3D 9,
> > -     OP_CB_RECALL_SLOT   =3D 10,
> > -     OP_CB_SEQUENCE      =3D 11,
> > -     OP_CB_WANTS_CANCELLED =3D 12,
> > -     OP_CB_NOTIFY_LOCK   =3D 13,
> > -     OP_CB_NOTIFY_DEVICEID =3D 14,
> > -/* Callback operations new to NFSv4.2 */
> > -     OP_CB_OFFLOAD =3D 15,
> > -     OP_CB_ILLEGAL =3D 10044,
> > -};
> > -
> >  struct nfs4_slot;
> >  struct cb_process_state {
> >       __be32                  drc_status;
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 92bc109dabe6..30aa241038eb 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -31,6 +31,7 @@
> >   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >   */
> >
> > +#include <linux/nfs4.h>
> >  #include <linux/sunrpc/clnt.h>
> >  #include <linux/sunrpc/xprt.h>
> >  #include <linux/sunrpc/svc_xprt.h>
> > @@ -101,31 +102,6 @@ static int decode_cb_fattr4(struct xdr_stream *xdr=
, uint32_t *bitmap,
> >       return 0;
> >  }
> >
> > -/*
> > - *   nfs_cb_opnum4
> > - *
> > - *   enum nfs_cb_opnum4 {
> > - *           OP_CB_GETATTR           =3D 3,
> > - *             ...
> > - *   };
> > - */
> > -enum nfs_cb_opnum4 {
> > -     OP_CB_GETATTR                   =3D 3,
> > -     OP_CB_RECALL                    =3D 4,
> > -     OP_CB_LAYOUTRECALL              =3D 5,
> > -     OP_CB_NOTIFY                    =3D 6,
> > -     OP_CB_PUSH_DELEG                =3D 7,
> > -     OP_CB_RECALL_ANY                =3D 8,
> > -     OP_CB_RECALLABLE_OBJ_AVAIL      =3D 9,
> > -     OP_CB_RECALL_SLOT               =3D 10,
> > -     OP_CB_SEQUENCE                  =3D 11,
> > -     OP_CB_WANTS_CANCELLED           =3D 12,
> > -     OP_CB_NOTIFY_LOCK               =3D 13,
> > -     OP_CB_NOTIFY_DEVICEID           =3D 14,
> > -     OP_CB_OFFLOAD                   =3D 15,
> > -     OP_CB_ILLEGAL                   =3D 10044
> > -};
> > -
> >  static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_o=
pnum4 op)
> >  {
> >       __be32 *p;
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index c11c4db34639..ef8d2d618d5b 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -869,4 +869,26 @@ enum {
> >       RCA4_TYPE_MASK_OTHER_LAYOUT_MAX =3D 15,
> >  };
> >
> > +enum nfs_cb_opnum4 {
> > +     OP_CB_GETATTR =3D 3,
> > +     OP_CB_RECALL  =3D 4,
> > +
> > +     /* Callback operations new to NFSv4.1 */
> > +     OP_CB_LAYOUTRECALL  =3D 5,
> > +     OP_CB_NOTIFY        =3D 6,
> > +     OP_CB_PUSH_DELEG    =3D 7,
> > +     OP_CB_RECALL_ANY    =3D 8,
> > +     OP_CB_RECALLABLE_OBJ_AVAIL =3D 9,
> > +     OP_CB_RECALL_SLOT   =3D 10,
> > +     OP_CB_SEQUENCE      =3D 11,
> > +     OP_CB_WANTS_CANCELLED =3D 12,
> > +     OP_CB_NOTIFY_LOCK   =3D 13,
> > +     OP_CB_NOTIFY_DEVICEID =3D 14,
> > +
> > +     /* Callback operations new to NFSv4.2 */
> > +     OP_CB_OFFLOAD =3D 15,
> > +
> > +     OP_CB_ILLEGAL =3D 10044,
> > +};
> > +
> >  #endif
> > --
> > 2.34.1
> >
> >
>
> --
> Chuck Lever
