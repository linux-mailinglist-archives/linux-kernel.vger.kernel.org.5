Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E37807C98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjLFXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441805AbjLFXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:55:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497281A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:55:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d048d38881so2493345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701906948; x=1702511748; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ioixfZXRdrOh6hBuj+IGCCPeUDF31MruhCzIBSvtPg=;
        b=frfMqTYeAmfyN/QMFsODwFNBXyJEXuHZK7/GuWqV85l7wZik6Do5E6yGl+1GpypHXP
         VXxL60URir4iMZdc55ZnCAnYzuBTTpDd88gA9qRLsBZYc5nlgZKVCnzx9NbU1xcALwCz
         yhS2NxMx8i6aSugxd3y5oXGL8lmJ/3gVfWGEiOugG7eIgu0ntQY02w1FWPoDdPu2PqZE
         4tIoneqXlVy+fXHu9TQDelfA6C4KVDwqjQGhZH28V5c5/jf/8EIcIKfuBWZijJaKNOkh
         C2vFHRcd7DLoomzlAMLZ7DzkBU9xnu61FdON+HIZdfLMdLutJRlT6cBdRMVBlQ8Ib/Lr
         /LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906948; x=1702511748;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ioixfZXRdrOh6hBuj+IGCCPeUDF31MruhCzIBSvtPg=;
        b=NLJz8JQ5S2QBoNLpdkzbj5HBQq/Wm6luyWBJ37HEvVE4/TcTqufMFtc33T/fNQlKcP
         6f5pbLem2Uq4iB4tpCy3/e/hFHe8PtK8HdH2rK+y/XQBfz2wtQC/Ak52/GYtytoYQos7
         wiN48JCPZ0gQrwC8kw75n0uQwNbtbRD7QY5VdJQgXxHrOlZBzwB51d5A3JWV6hE+eiks
         spg16SGn6Iz2Fx6MllRdM6hl5zzAzcjHQcBnwdNEhKLWc+B6ZjBEvtiHq+XGTv93Z6ul
         3ZmhZTbUpGenos1GR1YwUX7iThArxQhQSBqre/1O6xin617DWdbpbBEvKL3nW2OXGnfx
         mleg==
X-Gm-Message-State: AOJu0YwTjGHcJh8htVFGvmxn1Exgy5p3BDtQ+MBDSn3TGt2yScPUxvFN
        LDlR7De2eyGu7nIOt4pOQTbECQ==
X-Google-Smtp-Source: AGHT+IH4RBfMuZUIQDGUHTBkbgy1nx2Dp65ER39CnQABXNDh/8+Z4plHxRfGRvtVG/0D876wBT2R1g==
X-Received: by 2002:a17:90b:3b44:b0:286:815b:8c75 with SMTP id ot4-20020a17090b3b4400b00286815b8c75mr1449165pjb.16.1701906947681;
        Wed, 06 Dec 2023 15:55:47 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id cx14-20020a17090afd8e00b00286c1303cdasm7303pjb.45.2023.12.06.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:55:47 -0800 (PST)
Date:   Wed, 6 Dec 2023 15:55:45 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cake@lists.bufferbloat.net,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
Message-ID: <20231206155545.3ca3b2f6@hermes.local>
In-Reply-To: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
        <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
        <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
        <20231206142857.38403344@hermes.local>
        <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/alJaYiBnMbJbkGX8ASSTb5n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/alJaYiBnMbJbkGX8ASSTb5n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Dec 2023 23:49:14 +0100
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
> > It is not clear to me what this patchset is trying to fix.
> > Autoloading happens now, but it does depend on the name not alias. =20
>=20
> There are some more details in the thread of v1 [1] [2].
> Does it clarify?
>=20
> Thanks,
> Michal
>=20
> [1] https://lore.kernel.org/r/yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite=
2ah2a6i@l6arp7nzyj75/
> [2] Oh, I realize I forgot to add v2 to today's posting.
>=20
>=20

So your using blacklist as workaround security method and the name confuses=
 it now.

--Sig_/alJaYiBnMbJbkGX8ASSTb5n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmVxCgEACgkQgKd/YJXN
5H4msQ//bQpRE8MaxhEFPjgk6hhxd+8VBX3AF8SYclV67kaBLPnORN58blvGFVpR
jt+gbHGMyENxE3KXzowiyHcYayDrBJz3IswSKiFZgGTFiUZegH6/mwpfEZ77qd9R
II5Lqwc65AJWOlLvCXICUhvdCrAbyoIV+Draa6QZAz3hYILjXfVgDbIi1O7WI0S5
EcoyKP49Z3+TvakdNmgIV/XPkPQrbM6ipoeeYT1VUBhp2crFa68ISSjkjIlqDIhw
324Px5bmpOWrQfHUjBZnWyPUZpseRfKMhnd1czTRa/mRIFsZRr77O8/2XFp7IdLN
AMM1SuvfWj5jv8MSlR58Jf0/Us30X0ng4xAYIMx9ySFTqFK0sHN/84bgBermd/q6
ZGGTQR6jeMJw9phnLF7DUfZRlgs8QnqJ6KoddTyI7mF7yMbVpTvyT5EdWxEf5duY
IQf8b/ULKjsUankcEKQVM0hseAMEj0VTstA8bYiOpsrXPJGNenvOlp90E3hl/pBv
pM2Em+CpsJBabfXfwDqV9TcgpA8oCHgcuI+oDjJhY5PjIWT7+obMQSDpILntdAIM
UU28U81t1gl33s8XKcpNDGW9KUJv6j0/CUPX91FkWArt6DgF8zvbMGkICgndTHJT
6tBF/6G1G0mCvpdRPm133mx8j0SAA6dnJJvKM5fUjPikplpDoQo=
=Lgtk
-----END PGP SIGNATURE-----

--Sig_/alJaYiBnMbJbkGX8ASSTb5n--
