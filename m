Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895A76800D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjG2O3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjG2O3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:29:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF93598
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:29:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so45609911fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690640972; x=1691245772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbS94N1MjDwqCnfmVQcbBgAgaWg79ToDiV7mbBHmHVM=;
        b=iqP9yHAluHPR1X5C+aYnUajWs5uGACqcpbdN0GXV/sjpIRAWdSXWVUmvLkDFuVpgdD
         lyeWlKIY8fFW+H0MV4UhLpB4H7qoXF1KpLEbKGDeckyFWkqb1d9ED/O+cVQ3iGtiJlSX
         OjYDUq+R7vlEzHEzsPsXzPLb0RTUPnDhZvJJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690640972; x=1691245772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbS94N1MjDwqCnfmVQcbBgAgaWg79ToDiV7mbBHmHVM=;
        b=COfR7J5G/b+ZJGvilUULFZu3TDuYF5HAunMFYcn6xpHwEJqQa6cK+1GksbFOYY5hp6
         0+rlbXUpVPllEo0mb7NXOYidZrXS9TPGm3znuAuX0GD02lNGDPFLX8st4CrJWs7iP3PZ
         3WOEWUQVnt51mzoLiEkjrOpbtQC+FC4BVBKws7BnOZiU4rjBvQMglDjMRCiM2AMFOFN4
         ihyTZ4pCA4D2jDiLn5G6uyZ3R45E7dvBSw3Rv59nd8/hP1qHu9VwQVPOm+VuaSyxRbbT
         Q0ZGGmKnWBl/U6P6Ak+FNeI3iZs13Zo5bFrmTH38yH3PjXG4km36TP7MRIlKYyEfyGzs
         mbUA==
X-Gm-Message-State: ABy/qLbcSJ9lXymnOfN1AK81Gbajr/RL/T9LOvfAVR4Gl4weyWHW9KB0
        IAEONulJpyG3ktmrllXXm1lcr/TLKp18rpM3Sq6cdaiccUXtnNwKfac=
X-Google-Smtp-Source: APBJJlEdQwctxJHERGXG0TG4JBnSuCpkdkaVM/fzNmmsA2eW7YxYeDCVDNcmsjtaQoZvK1QEJ2RiVQIOVQGZ55k6aPw=
X-Received: by 2002:a2e:9295:0:b0:2b9:4aa1:71da with SMTP id
 d21-20020a2e9295000000b002b94aa171damr3829062ljh.53.1690640972036; Sat, 29
 Jul 2023 07:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230729142738.222208-1-joel@joelfernandes.org> <20230729142738.222208-6-joel@joelfernandes.org>
In-Reply-To: <20230729142738.222208-6-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 29 Jul 2023 10:29:21 -0400
Message-ID: <CAEXW_YTOtt+1R3ob68+R+32PBfmfCQmXVVEtahKtCLr0VJEG9Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] Revert "checkpatch: Error out if deprecated RCU API used"
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, paulmck@kernel.org,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 10:27=E2=80=AFAM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The check for single-argument kfree_rcu() is no longer needed as all
> users have been converted.
>
> This reverts commit 1eacac3255495be7502d406e2ba5444fb5c3607c.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Ignore this particular patch since it was already applied, sorry for
resend. Thank you!

 - Joel



>  scripts/checkpatch.pl | 9 ---------
>  1 file changed, 9 deletions(-)
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
> --
> 2.41.0.487.g6d72f3e995-goog
>
