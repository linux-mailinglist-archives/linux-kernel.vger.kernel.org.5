Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624FC7AF0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjIZQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjIZQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:24:44 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FA7B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:24:37 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-94a348facbbso773083066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695745475; x=1696350275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFkpn2H397KrVSqmEDJx57x47TGFCVVPTN7FsnVWNzE=;
        b=1hFoAxEOGZbiAoDfKUO45fdAWUEnVPrTBLwCnAr5TndUi/CpxBn4N2Vq1G7Cor+nrS
         TlakioOk9Tsthn2A54LcuTsp8JDA2B4qaImYYhJ8y8tJv2k705Z349CfRgjJkCFso9b/
         ihC9g1f0pzKXY/pbEy5j6vbvMVfaG4BDrS0R1cZPB5r5fSeaGnaoPEbVxr/SYTQmZcex
         M+u2H29QOgUKN2lbH5joPfQMlQazTm9aYcB9SF0Dgn8t8EL5jQSumXFzt2ExdyR04+g4
         zvUYFoT2XN5GNc8iPiQQv0BDq1LmY60xhNJyYnGij0FXmQZ7+wtrVOdnYJ+5KsoK/Ehx
         /cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695745475; x=1696350275;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vFkpn2H397KrVSqmEDJx57x47TGFCVVPTN7FsnVWNzE=;
        b=VDBvvDCmM9zI46kCxyc5AH8wa77yLnHWSkdl0FfgZtIAb8vqWMOtWPIj3+/ouGu6OL
         LM2fNGsSbce7mz1B6XRKujnCxiJRYIzugsEhi/1U4FPh1FBqupXHAa6+3pGuOrSs4rDf
         Q0BiQkXyGlnV5dnf47HE625N1VCLH0UvlVxWj9MowUBiu/H2zYbt/9+GkOVOZKFU3VN0
         A7o3js2IdRWhoDgl1awj5VlxjqJklxlpdwgcOFstc5jUyYuULCKQbxBcc90cNV3PBNC1
         o0cMAza04LwBb6jpe5uH/5A9BfZP/722B5o8vP3dBoonordJTAaesDW/LHVVLLuv72kx
         MJMA==
X-Gm-Message-State: AOJu0YynNpv/wMS011aWsoV0nF4WXleOgeAKTMQySjeJvnxiuusw7y1C
        yhQxpUdkm4PbMmFy8hyDfWqBcg1qjNM=
X-Google-Smtp-Source: AGHT+IHBoakqhkhiVEAsv+mZQ0hK5/qDN1CmFMFNKuR5J4mjx2CZrD8PGaR7oJWeHShb9Petn58MPj8g4wE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:dc99:dac4:b719:7cd8])
 (user=gnoack job=sendgmr) by 2002:a17:907:7110:b0:9a1:b087:3bcb with SMTP id
 zr16-20020a170907711000b009a1b0873bcbmr34230ejb.7.1695745475433; Tue, 26 Sep
 2023 09:24:35 -0700 (PDT)
Date:   Tue, 26 Sep 2023 18:24:32 +0200
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
Message-Id: <ZRMFwNzBJyyr85hV@google.com>
Mime-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net>
Subject: Re: [RFC PATCH v1 0/7] Landlock audit support
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micka=C3=ABl!

On Thu, Sep 21, 2023 at 08:16:34AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> This patch series adds basic audit support to Landlock for most actions.
> Logging denied requests is useful for different use cases:
> * app developers: to ease and speed up sandboxing support
> * power users: to understand denials
> * sysadmins: to look for users' issues
> * tailored distro maintainers: to get usage metrics from their fleet
> * security experts: to detect attack attempts
>=20
> To make logs useful, they need to contain the most relevant Landlock
> domain that denied an action, and the reason. This translates to the
> latest nested domain and the related missing access rights.

Is "domain" always the latest nested domain, or is that the domain which ca=
used
the check to fail because it denied the requested access right?  (If it is =
just
the counter of how many domains are stacked, this could maybe also be queri=
ed
through proc instead?)


> Two "Landlock permissions" are used to describe mandatory restrictions
> enforced on all domains:
> * fs_layout: change the view of filesystem with mount operations.
> * ptrace: tamper with a process.

I find the term "access" already a bit overloaded, and the term "permission=
"
also already appears in other contexts.  Maybe we can avoid the additional
terminology by grouping these two together in the log format, and calling t=
hem
the "cause" or "reason" for the deny decision?  In a sense, the access righ=
ts
and the other permissions can already be told apart by their names, so they
might also both appear under the same key without causing additional confus=
ion?


> Here is an example of logs, result of the sandboxer activity:
> tid=3D267 comm=3D"sandboxer" op=3Dcreate-ruleset ruleset=3D1 handled_acce=
ss_fs=3Dexecute,write_file,read_file,read_dir,remove_dir,remove_file,make_c=
har,make_dir,make_reg,make_sock,make_fifo,make_block,make_sym,refer,truncat=
e
> tid=3D267 comm=3D"sandboxer" op=3Drestrict-self domain=3D2 ruleset=3D1 pa=
rent=3D0
> op=3Drelease-ruleset ruleset=3D1
> tid=3D267 comm=3D"bash" domain=3D2 op=3Dopen errno=3D13 missing-fs-access=
es=3Dwrite_file,read_file missing-permission=3D path=3D"/dev/tty" dev=3D"de=
vtmpfs" ino=3D9
> tid=3D268 comm=3D"ls" domain=3D2 op=3Dopen errno=3D13 missing-fs-accesses=
=3Dread_dir missing-permission=3D path=3D"/" dev=3D"vda2" ino=3D256
> tid=3D269 comm=3D"touch" domain=3D2 op=3Dmknod errno=3D13 missing-fs-acce=
sses=3Dmake_reg missing-permission=3D path=3D"/" dev=3D"vda2" ino=3D256
> tid=3D270 comm=3D"umount" domain=3D2 op=3Dumount errno=3D1 missing-fs-acc=
esses=3D missing-permission=3Dfs_layout name=3D"/" dev=3D"tmpfs" ino=3D1
> tid=3D271 comm=3D"strace" domain=3D2 op=3Dptrace errno=3D1 missing-fs-acc=
esses=3D missing-permission=3Dptrace opid=3D1 ocomm=3D"systemd"

In more complicated cases like "refer" and "open", it is possible that more=
 than
one access right is missing, and presumably they'll both be listed in
missing-fs-accesses=3D.  In this case, it is not clear to me whether the do=
main=3D
number is referring to the first or the second of these missing rights.
(Assuming that the domain=3D is about the domain which caused the denial.)


> As highlighted in comments, support for audit is not complete yet with
> this series: some actions are not logged (e.g. file reparenting), and
> rule additions are not logged neither.

When ftruncate(2) gets denied, it is also not possible to tell which of the
nested domains is responsible, without additional changes to what we carry
around in the file's security blob.  (Right now, we calculate the overall
truncation right in advance at open(2) time, and just store that bit with t=
he
newly opened file.)


> I'm also not sure if we need to have seccomp-like features such as
> SECCOMP_FILTER_FLAG_LOG, SECCOMP_RET_LOG, and
> /proc/sys/kernel/seccomp/actions_logged
>=20
> I'd like to get some early feedback on this proposal.

If you want to have the full feature set as proposed above for other operat=
ions
as well, like file reparenting and truncation, it'll complicate the Landloc=
k
logic and increase the amount of data that needs to be kept around just for
logging.  I'm not convinced that this is worth it.  After all, the simpler =
the
Landlock implementation is, the easier it'll be to reason about its logic a=
nd
its security guarantees.

A possible simplification would be to omit the domain number which is
responsible for a "deny" decision.  I feel that for debugging, knowing the =
fact
that Landlock denied an operation might already be a big step forward, and =
the
exact domain responsible for it might not be that important?

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
