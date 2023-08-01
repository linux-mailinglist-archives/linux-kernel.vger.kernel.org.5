Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6918176BCAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjHASmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjHASmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B22737
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:41:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583b019f1cbso64627417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690915306; x=1691520106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIlApo8gjLRu+n0OPtD703y80JbGFniI/Qh6BfEYFQE=;
        b=ej/+U9hwE1/sqD4uxI3Vrq/mjsbnpCW+r/5zU8P/9Q67msFDNMuVHcPCiQMbx0U1ql
         UT8UINsqSzAtSGzGoMhoD6xifQQu2dhz3CZJKInQm2lv77QUPoX3FwqHM6c1OEZpJ+SM
         PGS6qpg5sY+vwd5siWngU62giao4UsJvtn1DSg8lCtrOzaBM7A8aPSTwbuYeIYS6EhfX
         Vv4YuzMBI/1IxOyvIqWTS9CLsE/Qrq4DE+5JMTTuIGbxrkB4hsZ5u59qqXznnXRXpVfk
         WfylV7egkTPkN+FHj297NJlN8BgbBGp0JJ9Twejzzs1eaARLlsh6hAIlQBhC7ASH5EJi
         2QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915306; x=1691520106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIlApo8gjLRu+n0OPtD703y80JbGFniI/Qh6BfEYFQE=;
        b=a3utkGBSepav8uRWH3FCn5sRnjHd4d4GedVUIztL4VhkA2P9jQ1XVQY0Fg4lxjs5/B
         iwFERyGtiCVQg5N+4vFgMLSHJtnC+48kHnlhtunmjK7bOXpxJREig79yNSOj2dgBNusy
         VHAB3w882Ri4Uw92RLYOPSfkZiInzbvQIm85CyhxPG8jvs5UFC0zCQPr6+oj154HyaJQ
         aDNIjtwak3XDAo3gFuv/P031gMaEuba4WmGCtHQD0kPJ6qrxf8Yu0CxidyD3+ZGV2H7o
         CSvhZ0jl7ckPlOvYoL/c0+cHxiHvvx39EfahUQsoF2rr5DxS8c2XXW+d/k/hbPYMP2U3
         CB5A==
X-Gm-Message-State: ABy/qLbsbacd3FgHNi9wXz4u7Sc19NurmhZc8QqRx/wHYd7DvEgFiguS
        upCVL5CUG0KVNCciSeg0KoDWl0HWyJObSUinLBB0
X-Google-Smtp-Source: APBJJlE+Rwd1XlV3i58OIr9LAjIvAndfko6lcSQsnNtJ4oRPNOp6I0MRiDn+amG/23Rsq2ThgvrK5L6Lw6R8SCNvN/I=
X-Received: by 2002:a25:dfd1:0:b0:d15:b12d:6672 with SMTP id
 w200-20020a25dfd1000000b00d15b12d6672mr12602555ybg.40.1690915306187; Tue, 01
 Aug 2023 11:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801114214.2e169762@canb.auug.org.au>
In-Reply-To: <20230801114214.2e169762@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Aug 2023 14:41:35 -0400
Message-ID: <CAHC9VhSgHdLV+b=aMwuM1qiHg2uD_Bahs4=tuVnTvyHXAA2yFw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 9:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   security/security.c
>
> between commit:
>
>   5b52ad34f948 ("security: Constify sk in the sk_getsecid hook.")
>
> from the net-next tree and commit:
>
>   bd1f5934e460 ("lsm: add comment block for security_sk_classify_flow LSM=
 hook")
>
> from the security tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/security.c
> index 2dfc7b9f6ed9,9177fd0968bd..000000000000
> --- a/security/security.c
> +++ b/security/security.c
> @@@ -4396,7 -4421,14 +4421,14 @@@ void security_sk_clone(const struct soc
>   }
>   EXPORT_SYMBOL(security_sk_clone);
>
> + /**
> +  * security_sk_classify_flow() - Set a flow's secid based on socket
> +  * @sk: original socket
> +  * @flic: target flow
> +  *
> +  * Set the target flow's secid to socket's secid.
> +  */
>  -void security_sk_classify_flow(struct sock *sk, struct flowi_common *fl=
ic)
>  +void security_sk_classify_flow(const struct sock *sk, struct flowi_comm=
on *flic)
>   {
>         call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
>   }

Thanks Stephen, it's obviously a trivial fixup, but it looks correct to me.

--=20
paul-moore.com
