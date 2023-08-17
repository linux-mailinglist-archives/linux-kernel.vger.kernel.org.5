Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09F7801EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356295AbjHQXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356299AbjHQXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:48:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267A3A97;
        Thu, 17 Aug 2023 16:48:18 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790a590237aso11626239f.3;
        Thu, 17 Aug 2023 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316065; x=1692920865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEqjp8LuBAI3uvCVY4BxAGDeVICB/Rnulmk6tW27L2k=;
        b=SkiJuTy9Q+d7EUYeDjAhEm0Brg0zNoMYTDTfsC+9G0u+NqKstqKkVMgnG7UdiFyd6w
         u40bMrdkE+tuKidyR7AcpB5dhfRH2q+JogCd6e7B8EN1ur352YkEapirMuDXUsUPmJ5m
         GmMEQ+LXyipplxBNEr8HJYpEyZ3IvkfskBW30HMdk889r+dfVCqetGp4qqbFBt/jmciT
         L2iqfucMYfmFMJEvBBJ6yVVNH+OLgBtRD2/XLPCxb7zSlADTQ/qzJZeO62hDRaIDBh2b
         pYER3WVLHShPMh8M++zL9lJngn2ua7HBoIRUQuROxP9seQatSOa491IxkMfgY0Ocnq4G
         Ma1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316065; x=1692920865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEqjp8LuBAI3uvCVY4BxAGDeVICB/Rnulmk6tW27L2k=;
        b=ThPvoI9Ox8w7pf6GmDiMUhi2MysfxSbLsMnMHThC5pF6tpChY1YffJvTCY3ToaOQjQ
         3FQNrvES+wYJdm7L6HcibBQ8GHs9ekYHPgDkmKaX6q6Yw9M0YbQrSEF8WpFCK3l5SaJk
         XB/bbRPYk80IGvp8SKzJvXukJn16vcTWY4rfUhHhl1a07cATc0zBv34SYtCCjTaVd7Q3
         hkJ55FxF2ZqR5vDp8BcCVUDbvEcusVD7Oh5G+Xfbn/Jzi0MB7LhRVdb/ctKk97kAW57D
         zkYTqlYVs0sFVUPEkUmuCUfGaWXEPkt9pgKUkWXLkhYd6jiuQQu14g7bwQ5n8hK4M6jM
         ECjA==
X-Gm-Message-State: AOJu0Yxv/Ht6fJsTggdQan9TS1GSAxCqTazuJ+XoOLYh2/VrCGTBnewN
        T9fDbdlv5ZNQjMeag5wJ+Qk=
X-Google-Smtp-Source: AGHT+IGeYWvkbovGWi0ssDH9PzYvZfk6n7jROaxvM3Zv++IDrgy7v5lyujdwg2mqgDV7n7QvF6EJAg==
X-Received: by 2002:a5e:d816:0:b0:787:1f16:53ce with SMTP id l22-20020a5ed816000000b007871f1653cemr1241031iok.18.1692316065197;
        Thu, 17 Aug 2023 16:47:45 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.161])
        by smtp.gmail.com with ESMTPSA id fr11-20020a056638658b00b0042b34d4d07fsm150977jab.156.2023.08.17.16.47.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 16:47:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] tracefs: avoid setting i_mode to a temp value
From:   Sishuai Gong <sishuai.system@gmail.com>
In-Reply-To: <20230816155245.6ead4384@gandalf.local.home>
Date:   Thu, 17 Aug 2023 19:47:34 -0400
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9B746AC-DF36-4ED3-BBA3-2EEC1BA166C8@gmail.com>
References: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
 <20230816155245.6ead4384@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 16, 2023, at 3:52 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Thu, 10 Aug 2023 20:59:26 -0400
> Sishuai Gong <sishuai.system@gmail.com> wrote:
>=20
>> Right now inode->i_mode is updated twice to reach the desired value
>> in tracefs_apply_options(). Because there is no lock protecting the =
two
>> writes, other threads might read the intermediate value of =
inode->i_mode.
>>=20
>> Thread-1 Thread-2
>> // tracefs_apply_options() //e.g., acl_permission_check
>> inode->i_mode &=3D ~S_IALLUGO;
>> unsigned int mode =3D inode->i_mode;
>> inode->i_mode |=3D opts->mode;
>>=20
>> I think there is no need to introduce a lock but it is better to
>> only update inode->i_mode ONCE, so the readers will either see the =
old
>> or latest value, rather than an intermediate/temporary value.
>>=20
>> Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
>> ---
>> fs/tracefs/inode.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
>> index 57ac8aa4a724..dca84ebb62fa 100644
>> --- a/fs/tracefs/inode.c
>> +++ b/fs/tracefs/inode.c
>> @@ -297,8 +297,7 @@ static int tracefs_apply_options(struct =
super_block *sb, bool remount)
>>  */
>>=20
>> if (!remount || opts->opts & BIT(Opt_mode)) {
>> - inode->i_mode &=3D ~S_IALLUGO;
>> - inode->i_mode |=3D opts->mode;
>> + inode->i_mode =3D (inode->i_mode & ~S_IALLUGO) | opts->mode;
>=20
> You do realize that the compiler could decide to keep the original =
logic
> even with this change? If it was crucial that the compiler did not, =
you
> would need to have:
>=20
> if (!remount || opts->opts & BIT(Opt_mode)) {
> umode_t tmp =3D READ_ONCE(inode->i_mode);
>=20
> tmp &=3D ~S_IALLUGO
> tmp |=3D opts->mode;
> WRITE_ONCE(inode->i_mode, tmp);
> }=20
>=20
You are right. This will prevent the compiler from emitting two writes.
I will incorporate your suggestion in the new version.

> And if you notice the !remount flag, this is only preformed when the =
file
> system is actually mounted. Are the files visible before then?
>=20
> Can you produce this race?
This data race was detected when I was testing the kernel (e.g., =
fuzzing)
but I did not make the attempt to reproduce it.

>=20
> -- Steve
>=20
>=20
>=20
>> }
>>=20
>> if (!remount || opts->opts & BIT(Opt_uid))


