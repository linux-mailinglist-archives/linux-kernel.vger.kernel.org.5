Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8335A76440A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjG0Czs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjG0Czo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:55:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F526B8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:55:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso6463771fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690426536; x=1691031336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p06jw+7gyGJ+2D+u0RTPTv2XoWSvckEyu8XfDgXy19Y=;
        b=vS9gReamfdyrkYFZ3PabrVrVKUBNEONo69kEptL7m4J1DFoun7O6jhXqbB44QM44FI
         ee3K20EOsa0JgjhYLcPWkXt9fA2Kzk0v9dOYOEo2918oK0jH0I+TN6Jw9wHoXwyfc0ao
         +s23QyIpc9jOiYwfZ1O3ebEMkDJsse3fsenMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690426536; x=1691031336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p06jw+7gyGJ+2D+u0RTPTv2XoWSvckEyu8XfDgXy19Y=;
        b=F8DqgVhnwz24kcs37J33/0/jnpzRKAKhmyq3ny+wOTb7e7d2mOWFlj9AGxJmOp5y5w
         0LoeG+kngSj++tIvWnQR19w7HgOEjUoJCSBrJJGq/PiNuL1UvvTSDCAokgYjdB2Cfu59
         2iV73N0hxh0a6GJFUIO5uAPj3/ipiPEd1P3iX/dU28P/B4I2UXgBIrwgxgcu3Y6s7iou
         K3AGCdDLtramDc1wpbKhF+7Lh3ewxghQNK0MNh92HCKmmeIrQ03t7O/WJGgRaLzDO18Z
         7E+QiqS8/dH/HAKMi2pV+VctXBmGwDpMQe/NPZbMih3MSH1Bq/7URbY2uue3PlBvhhiO
         6CIQ==
X-Gm-Message-State: ABy/qLZKrUUYiWWmO6KsR2N4Ts7KC+AC38M6n5WaI8c7/+gWxSFs7URZ
        Wkhk/iAG0XHxBlGswZVswWuKIL+5XL297wLbWkQUemaibatsn+gD
X-Google-Smtp-Source: APBJJlGF38hdrXpP3Gug5ZZE1044c9gD+O4/VgrqNsLnGncK8QowBdjIP3ZB81wzoYfTyGeb6+/7JYdYuYhjc8M/VQ0=
X-Received: by 2002:a2e:9b0b:0:b0:2b6:d137:b5a1 with SMTP id
 u11-20020a2e9b0b000000b002b6d137b5a1mr594734lji.43.1690426535828; Wed, 26 Jul
 2023 19:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-6-joel@joelfernandes.org> <a28a2b4d-18f3-418a-ab9d-46d42616a118@paulmck-laptop>
In-Reply-To: <a28a2b4d-18f3-418a-ab9d-46d42616a118@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 26 Jul 2023 22:55:24 -0400
Message-ID: <CAEXW_YSUOzRxCX9cBeaXbBODt6EaNG+Xm-KF3nx7UoVCV4L3NQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:12=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Jul 25, 2023 at 11:29:10PM +0000, Joel Fernandes (Google) wrote:
> > The check for single-argument kfree_rcu() is no longer needed as all
> > users have been converted.
> >
> > This reverts commit 1eacac3255495be7502d406e2ba5444fb5c3607c.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Good eyes, thank you!
>
> I applied this with an updated commit log as shown below.  Please let
> me know if I messed something up.

LGTM. Thank you!

 - Joel


>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 1f5f0053f7662385d9ead46d4c0d2d4fe9aaa73a
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Tue Jul 25 23:29:10 2023 +0000
>
>     Revert "checkpatch: Error out if deprecated RCU API used"
>
>     The definition for single-argument kfree_rcu() has been removed,
>     so that any further attempt to use it will result in a build error.
>     Because of this build error, there is no longer any need for a specia=
l
>     check in checkpatch.pl.
>
>     Therefore, revert commit 1eacac3255495be7502d406e2ba5444fb5c3607c.
>
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a9841148cde2..528f619520eb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6422,15 +6422,6 @@ sub process {
>                         }
>                 }
>
> -# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> -               if ($line =3D~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> -                       if ($line =3D~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> -                               ERROR("DEPRECATED_API",
> -                                     "Single-argument k[v]free_rcu() API=
 is deprecated, please pass rcu_head object or call k[v]free_rcu_mightsleep=
()." . $herecurr);
> -                       }
> -               }
> -
> -
>  # check for unnecessary "Out of Memory" messages
>                 if ($line =3D~ /^\+.*\b$logFunctions\s*\(/ &&
>                     $prevline =3D~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*=3D=
=3D\s*)?($Lval)(\s*=3D=3D\s*NULL\s*)?\s*\)/ &&
