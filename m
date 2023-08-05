Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60EC771058
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHEP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHEP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83776E55
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 08:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A9660BD3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A917C433C9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691249233;
        bh=YkNHjCEsWbMSpXlVNxZWVhZt+vnKSvPNwFIfVzhj37A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=diCiFWhtRp0DlZjffoClzUp6DWeljZuVnTRm7GGHiXsa+ls06W0tLXXUSPx0KQUpn
         l8R8K3/c1TBodkqmAm8pFfK2GsnvcLK0nq/8yoMVISHTLHdd7pI75LJ/ixVCNH9fUb
         ohBaqOe84Qb5Ou6JGbQflihJerdNBG7ZVM9VE1kNYttbCUc9CVGHymY81iGZk38Amo
         nrdrWs86wK86om9zP46CCNBigZ5Y/VCH5V8M0ZeL4rlzqBv7M/d/5b1VNiOHeso4DR
         jL5pGvGVF0ADXes0GJbvKgZzGo6muSBDUl5eQbPquJ55YKiVsL1y+p4IBt161cEV2o
         k+e4qKBZ6zcjg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1bb717ece50so2251629fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 08:27:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBxREkF/tbjCpoD34TFg25yLhqu1VagJudMFwXZfLsxzrpBk4Q
        VDArMzqtRlY53QbxByBILiSpvuSkR/CWJZGJrMA=
X-Google-Smtp-Source: AGHT+IF83VNqYO6ZlkDw5ix0x5Wlv89VRCqY5RNFdE0mI5mj88qxXuzwxN9O41AxfgBQ77IotZre5R0bNHgAphrTnko=
X-Received: by 2002:a05:6871:29b:b0:1bf:74cc:c815 with SMTP id
 i27-20020a056871029b00b001bf74ccc815mr5671119oae.19.1691249232813; Sat, 05
 Aug 2023 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230803115020.2280542-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230803115020.2280542-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Aug 2023 00:26:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUR8+0tdtXmsYxJaLRgC2=e=BXTs3-ojp9dT=Gk5A-XQ@mail.gmail.com>
Message-ID: <CAK7LNASUR8+0tdtXmsYxJaLRgC2=e=BXTs3-ojp9dT=Gk5A-XQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: clean up stale comment
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 8:50=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Nobody has complained since 2a73cce2dad3 ("scripts/setlocalversion:
> remove mercurial, svn and git-svn supports"), so let's also clean up
> the header comment accordingly.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Applied to linux-kbuild.
Thanks.




>  scripts/setlocalversion | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index bbb6c7d545f4..e07795d1763b 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # This scripts adds local version information from the version
> -# control systems git, mercurial (hg) and subversion (svn).
> +# control system git.
>  #
>  # If something goes wrong, send a mail the kernel build mailinglist
>  # (see MAINTAINERS) and CC Nico Schottelius
> --
> 2.37.2
>


--=20
Best Regards
Masahiro Yamada
