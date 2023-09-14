Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B27A0702
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjINOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjINOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:15:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52FB9;
        Thu, 14 Sep 2023 07:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939CCC433C8;
        Thu, 14 Sep 2023 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694700913;
        bh=WQKdr2jl9B3J+f1f9twtrgdMNHSlOvO8fP/0voLWkn8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TQyzNxnpLtZhTdX0sbl+RKoD7gYvsE4KC7UV2Ols6dLuBLTxKoWecfnKpxjZNGpqk
         bFz8nJ7pIfT/QXF1kroKmOY+RlgoMCsJkU/DCdzjZC3N6i/7C0Yo7i8PHaQK1afHzI
         2u7zD7Qwts3BP7m0kQFfJvcvYHXuzo/7uTSQnHVF2MNj1Z6sxLPHmFgwSr/3t7Khtr
         GIEeS1khXlUJqi6rsazVQmYh4zLglUM1Fxpw9Pg2FOY5ZOOc208856xFJ0WKYt1lxN
         y6UWMDuRIbB6Kb+o3usC8gW+08s4LrZx2CR3hJ+ULTOTK9ec8rfUD3VTJTamTW/n2e
         QcUOvFdo+XRyg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
In-Reply-To: <20230914-float-uneven-7cd1a18b3978@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230914-roaming-plunging-948c78d9831c@wendy>
 <87pm2kap1p.fsf@all.your.base.are.belong.to.us>
 <20230914-float-uneven-7cd1a18b3978@wendy>
Date:   Thu, 14 Sep 2023 16:15:10 +0200
Message-ID: <87zg1o3kpd.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> writes:

> On Thu, Sep 14, 2023 at 02:59:30PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Conor Dooley <conor.dooley@microchip.com> writes:
>>=20
>> > On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> >>=20
>> >> Hi,
>> >>=20
>> >> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
>> >> AVX-512-to-RISC-V translation patch appended.
>> >>=20
>> >> I've tagged it as RFC, since Andy's series is still not in-tree yet.
>> >>=20
>> >> It's a first step towards a Vector aided Wireguard! ;-)
>> >
>> > This has the same problems as Andy's stuff & doesn't build properly fo=
r the
>> > automation. What is the plan between yourself and Andy for submitting a
>> > version of the in-kernel vector support that passes build testing?
>>=20
>> I'll synch up with Andy! I'm not even sure the blake2s patch should part
>> of the "in-kernel vector" series at all.
>
> The in-kernel vector stuff should come with a user, otherwise it's dead
> code :)

Sure, just so we're on the same page; Patch 3 (Vector XOR) is a user
from my perspective, no?
