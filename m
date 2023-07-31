Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E9769BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGaQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGaQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:08:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6E1BC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690819680; x=1691424480; i=efault@gmx.de;
 bh=7nnNBH6xB2pqtpGFYgVngQiZQ5abcZmqdXDxIJ+VXQY=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=KxvgO2vObgT2wphWWJ2077OECv0pFuin28Gi1YNQGjG10K8K6PRgpZz/o/mHPslW23zUo7F
 ClDo5I/X5bdjr6C0V1G+rQhQkjBHcgWPQKgfkwtzH6pVTaYSuP22A8aZIojvbX+fQcFPePGqK
 HBeKhqvO5CUgW15TSOLOrRVH8IOpJiKO14bUTarJyc4FncNYnUvAYOG+HOnXnhvDySKzxu9jH
 hA/aO9VN7tOW085hWwTynn8SbNCfpyJ79l4cOwgdtao45Sfyzo4GYv6DyQVRtoJafpkRLumXO
 rhO7robque+t0BzRhgr8n0uiUHcrJ9wU1AWaIVCjEgVlfapg7W8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1pkWpE12eu-011yaT; Mon, 31
 Jul 2023 18:08:00 +0200
Message-ID: <ee5d936351a56a52573a17e46680374df4170b2a.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lstoakes@gmail.com,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Mon, 31 Jul 2023 18:07:59 +0200
In-Reply-To: <20230731115207.GB24767@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LcvZjUFgaeamfGH9YDKCej+3gk7Y2bYSypvTi2Jq+hf1iTUZttD
 cFLqKyobSJ4dtuLqPyZUg/w1Vr3GBaq5AEwN7IvOXADvfq/d6k8Bj24Cfa1nhisBjZ7aiWA
 bo13CMiUNmfc9J343M/EOtvn+vZ1vxBvSBMbq7Vc9fsz2ZXerzeS8Khkben0xBWnyZ8l53B
 lgNxg6qTdfkhoIyoH1riA==
UI-OutboundReport: notjunk:1;M01:P0:AN9GzX+FfMw=;1J/9B0CKQJej119uumV6Czazu3Y
 88MXpeBif6d4FkzZxuijPWxPzDvPMmbkpiQLkAja1MHwzMuF+1c2AMEEkMmpCOccylIhPgUnX
 XsvlDDVr2xHXCzBQwAalDC2GE4KEG0UBvm1F0CZO00OoEGM2zZWuIFyA9i0Aqo4FGpI6DXnH7
 pZherQ3aWZFubYE7IdZgwmYmiUBctbcSDa4qUocc2xQi9tCal482w8aEOZVhnbPD1RvpxPSLE
 BDAhnaLpwWoIsMYav9GCQtj38eitmiNrz8jP0TmPaiwiSmmoQdXVQFQYBcs3UxoAsTu/tq5sq
 cG83djKa7F5X0q/RSm6YnJRRHtuerd3c9FCr7SJ160UySNzy/k79B1P4VyLi5kIOOE1jldMhI
 ZWcDZKEX3QY84J5EpHoGRrl3LMd/lm+MyopmaNGwr0UJ9NE+rqwdBKHSR1DsyBARD7O5D0Hlx
 9wkaNpeuGlU2ME5U4ar9YT/E0BxoAyRRVlClz1BFEufz3G0oq1s+fUwglxDRE7iaGgE6J0Ib2
 3WChlsbsUnc6mqcG4GH0Eplqa3sExmoVGgZKe1Q53ey5w9ImLXBOyHbmSbbCNDJjqZYRDbHmn
 Gf7MlRvW5yjkzKvqsKLWR7WDDUNPEd+STm1SEl5+vb7NqOP4gjL4nnhg4+Wl5sSvBdN5vXzlE
 hNf6QCmuzS+mpf1Y9EhppBb3pZo4PrYpPg+obmULEjB7/7Xgnmtnx9rU0Mq+CXPSgAiKNfpZX
 ZPwQPgdvny0U4KiObLb1RoWCZfL51eMvpiPs/DbAvEEktzILJvcF9yKqhcL2JxZsW4JAoQZvD
 dYgo5giNpciTULwYqJeGBo7Vb8ofqG5DR1x6DmWRlns1x3Y28m1k8tUzxBcXffXtyLQJVCfhD
 /ButhidHw/xHwUH1+eQtO6T2ATasDH1AP0s50sr8TF8R/OtWs/oNMv40qgQbvyKNZCq/TNT/O
 kYFnfYBgg7KAjxRMJY1JoyAMUcg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 12:52 +0100, Will Deacon wrote:
>
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 9cb32e1a78a0..3696a209c1ec 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -635,7 +635,7 @@ static struct kcore_list kcore_text;
> =C2=A0 */
> =C2=A0static void __init proc_kcore_text_init(void)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kclist_add(&kcore_text, _text, _en=
d - _text, KCORE_TEXT);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kclist_add(&kcore_text, _stext, _e=
text - _stext, KCORE_TEXT);
> =C2=A0}
> =C2=A0#else
> =C2=A0static void __init proc_kcore_text_init(void)

That did kill all 945 bogus start instances, and in a brief test drive,
did not appear to have annoyed crash.

The two odd arm64 specific huge objdump allocations persist fwtw.
Unrelated fossilized bug?.. who knows.

	-Mike

