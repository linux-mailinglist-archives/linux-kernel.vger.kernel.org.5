Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820257791AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHKOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHKOTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:19:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1C32D72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:19:20 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-583f65806f8so21812827b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691763559; x=1692368359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZudPvE77obhdTH9BwvUPtFGRDBscAM9ndagajqjxgA=;
        b=fOJN7/01bKuxSiPWfoaDMd1rHwiRAo0+t60pWZ00VIRK5P/s0UEBMLu0XrnF9XsLNV
         +onChgYJMLEIznghAYMqxv6BBQbzL3K4Dl/8BSeCWxmJPDrVH41nEszOeVOR7j0M1MD5
         wbxa/yU9BVYYZb3mpKOVWFX9fVibxwzRxagGwfCf0G/yDF9ez2Vg0DnBthuH4WEfb8Q2
         yeTz6xCPKqpO6fbB7cvF2cDw3rJUNxAf+CkMDBsXEwlLYgA1Eqv/a+swWYKEO5rBFYY1
         68hrQiMt/IQ+wRkMAP91apnd+8qIvri+8zvp7jaet6Xg0mjEIulThjZjEb7ymSaAtFLX
         +SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763559; x=1692368359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZudPvE77obhdTH9BwvUPtFGRDBscAM9ndagajqjxgA=;
        b=bhlyozlUrGEYeTHBVP5/0WTDN0NkTxGs7jFAOQU6VdvwteqP/mSbEeBr77+PykbpH6
         j961iQwqjGoMAyMafYpznMx4yIlDzgvDISu3wdEldZL1feaHLn4ZLejdnAmfWRJT95L7
         1Sv7NaCW26JEk2o5L/zGvis+6+B5JFSx+pHmjO5H6yAdNGNT005Y5jMuu6UjO2PY4+qi
         tlDtxvBciKHU2WclPBJHHqjgsW/G7JS1NTO8xNd1Cpc2w2rILvT+8ImS7MMKlpKYNz9D
         pN/nAxxJfsXtSCBmRtznnlrEL/qNHd4ROyxWyL1uUj1I6cIsy2FllFbYJDg5oXKtNHIC
         2s7g==
X-Gm-Message-State: AOJu0Ywu8JqpCLOBsZorRqyy7YqA2Ld/hseCK+OJVTqMSZng2/hqTgVa
        OvX/S80/RBj0jiYeA4ooo9zBUVz/N+HEqjl+JhQM
X-Google-Smtp-Source: AGHT+IGDUbfXK+AIRXUY0biV6PHrbsLLAXTemWgR+C8O2IbwMktrRjWoRwhHhix/sOWiIoiNeNiblxKOu29ljZis3Jc=
X-Received: by 2002:a0d:f806:0:b0:584:1a4d:bbfa with SMTP id
 i6-20020a0df806000000b005841a4dbbfamr2228192ywf.29.1691763559514; Fri, 11 Aug
 2023 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-master-v9-1-e0ecde888221@kernel.org> <20230808-erdaushub-sanieren-2bd8d7e0a286@brauner>
 <7d596fc2c526a5d6e4a84240dede590e868f3345.camel@kernel.org>
In-Reply-To: <7d596fc2c526a5d6e4a84240dede590e868f3345.camel@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Aug 2023 10:19:08 -0400
Message-ID: <CAHC9VhTAF43=-j4A-Ky1WxJVBOAWzU+y2sb4YmeSQjFOa4Sy-A@mail.gmail.com>
Subject: Re: [PATCH v9] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 9:57=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Tue, 2023-08-08 at 15:31 +0200, Christian Brauner wrote:
> > On Tue, Aug 08, 2023 at 07:34:20AM -0400, Jeff Layton wrote:
> > > From: David Howells <dhowells@redhat.com>
> > >
> > > When NFS superblocks are created by automounting, their LSM parameter=
s
> > > aren't set in the fs_context struct prior to sget_fc() being called,
> > > leading to failure to match existing superblocks.
> > >
> > > This bug leads to messages like the following appearing in dmesg when
> > > fscache is enabled:
> > >
> > >     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,=
100000,100000,2ee,3a98,1d4c,3a98,1)
> > >
> > > Fix this by adding a new LSM hook to load fc->security for submount
> > > creation.
> > >
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_moun=
t() to it.")
> > > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inod=
e)
> > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>
> I've made a significant number of changes since Casey acked this. It
> might be a good idea to drop his Acked-by (unless he wants to chime in
> and ask us to keep it).

My apologies in that it took me some time to be able to come back to
this, but v9 looks fine to me, and I have no problems with Christian
sending this up via the VFS tree.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
