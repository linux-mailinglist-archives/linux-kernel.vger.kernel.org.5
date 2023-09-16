Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925B87A2F35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjIPKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbjIPKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:08:10 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB9CD5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1694858881;
        bh=i7BQ6PsUSCvZwBxpAKXqxkBHRfKHAYqC55VhKt2+QOQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kMy7lu555CQjwOwnViDvu+MFd0fbAWE9pdQjuVPZix9CUg1Y6v8ZWQ2fV6aMd8Yo/
         5fm3O72dfu4tDwXCIsP4mKx7eGFGcy6f+t85M5V54Hfn/ooc+FBQc4830YoM29LpUb
         lVBZ3WBSj3jWJF8rMo/sx5FF6RMZJloiIc8LXatc=
Received: from [127.0.0.1] (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5D4BE659AC;
        Sat, 16 Sep 2023 06:08:00 -0400 (EDT)
Message-ID: <c71c610d70727b94dfaa1bdd537235cde13db7c6.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fix some build warnings with -W1 option
From:   Xi Ruoyao <xry111@xry111.site>
To:     bibo mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 16 Sep 2023 18:07:58 +0800
In-Reply-To: <1918be3c-3560-bd3d-6518-c5e49319b1d6@loongson.cn>
References: <20230916092330.971630-1-maobibo@loongson.cn>
         <CAAhV-H50_aY8Sw0uPSs1VuNOtbaHF2-a5mZE2jnSC7QPUaWf=Q@mail.gmail.com>
         <1918be3c-3560-bd3d-6518-c5e49319b1d6@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-16 at 17:56 +0800, bibo mao wrote:
>=20
>=20
> =E5=9C=A8 2023/9/16 17:42, Huacai Chen =E5=86=99=E9=81=93:
> > Hi, Bibo,
> >=20
> > On Sat, Sep 16, 2023 at 5:23=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> =
wrote:
> > >=20
> > > There are some building warnings when building LoongArch kernel
> > > with -W1 option as following, this patch fixes these building
> > > warnings.
> > Don't touch asm-offsets.c now, because it is being refactored by the co=
mmunity.
> Well, I will bypass this file and send the next version.
>=20
> Do you think that is it deserved to add -Wno-override-init option
> to remove compiling warning about file syscall.c? I am not sure about it.

What is a -W1 option?  At least GCC 13 does not recognize it.

And generally you cannot randomly add warning options building the
kernel and expect a clean result.  I don't think we should "fix"
breakages caused by custom warnings at all, unless the warning indicates
a real issue.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
