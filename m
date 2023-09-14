Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD1E7A04A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjINM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjINM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:59:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55561FD0;
        Thu, 14 Sep 2023 05:59:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35FEC433C7;
        Thu, 14 Sep 2023 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694696373;
        bh=7vDP4g7jMMD/RN1sC/k/VT5TGJ/WVi77BDoNV/0fFWE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=akOU2uK04oc6pz08pJcQmp/jc3wstHcgLS41MvhzK9nmEk7WS64SThd+WBOcGmfNU
         COCgTsB9O8Ummya+Y6fj4Rax9Kf2TjyXj4uLbSOd2jZxfGn5tUM0y3s6m4nwckHbn6
         YTcIqQAPdBlxCRiIut1SAeel8Ad3TB5hosq2pAVZkh91C1Amn2J0MZ6ikYUkWyc1zL
         2j53lCMx5paGTcvluuwn8sbFcPnW1IhnEhyXQsdMw6HE+BfZQ+IJyZ1rtWWCzRu54Y
         RcLivIFavDnc2+2Rt3gZmi1slV3ep/8zOx4eeK/kMCsW16doT3BOkV20IJrlwMfgps
         VXD3TYzeFKrDg==
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
In-Reply-To: <20230914-roaming-plunging-948c78d9831c@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230914-roaming-plunging-948c78d9831c@wendy>
Date:   Thu, 14 Sep 2023 14:59:30 +0200
Message-ID: <87pm2kap1p.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> writes:

> On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Hi,
>>=20
>> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
>> AVX-512-to-RISC-V translation patch appended.
>>=20
>> I've tagged it as RFC, since Andy's series is still not in-tree yet.
>>=20
>> It's a first step towards a Vector aided Wireguard! ;-)
>
> This has the same problems as Andy's stuff & doesn't build properly for t=
he
> automation. What is the plan between yourself and Andy for submitting a
> version of the in-kernel vector support that passes build testing?

I'll synch up with Andy! I'm not even sure the blake2s patch should part
of the "in-kernel vector" series at all.

Thanks,
Bj=C3=B6rn
