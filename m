Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263EF77C6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjHOEHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjHOED3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:03:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58C2123
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 21:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692072063;
        bh=nIDeyPDR1fYGIXd4V15qRULGFD/IbdCDJF2LRUVHAXo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CopCExEAVijpln1YgNfHByuZGlpejzRWuq4nqWQRjTuvM22J4Ih8lVtwI5garc/IQ
         /BaEptyMCsmF6h+XCmyex33B3boEnWDSdsTbC/BZ/6hNdy5JQiuvBD1R66b+41CeB7
         MwTBUVBzwxKbkOvveNt4qWon6IcJR0ttIyrOoBLCeysHbBQyDYVDBzwGtbWYb7dN5o
         yh5zzsc5ENsZcMCi6K9FJ7/hdaYrqHJgl7bJ2OctxemJU3Mr3okWEb4ZQb/nGzUWmM
         yv/23K1mnLhsSHoLmB+8wBPi8fre6zCisWEqFUj/nXYabTAYZ1l+Iulpklqfbf4IE0
         83PKtpfM4B2Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPyHL1GWxz4wxK;
        Tue, 15 Aug 2023 14:01:01 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: powermac: Use of_get_cpu_hwid() to read CPU
 node 'reg'
In-Reply-To: <f97e8c26-1379-dabc-21af-ebf4b06b31e7@wanadoo.fr>
References: <20230319145931.65499-1-robh@kernel.org>
 <168836201902.50010.13066091729121047041.b4-ty@ellerman.id.au>
 <f97e8c26-1379-dabc-21af-ebf4b06b31e7@wanadoo.fr>
Date:   Tue, 15 Aug 2023 14:01:01 +1000
Message-ID: <874jl1dkea.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:
> Le 03/07/2023 =C3=A0 07:26, Michael Ellerman a =C3=A9crit=C2=A0:
>> On Sun, 19 Mar 2023 09:59:31 -0500, Rob Herring wrote:
>>> Replace open coded reading of CPU nodes' "reg" properties with
>>> of_get_cpu_hwid() dedicated for this purpose.
>>>
>>>
>>=20
>> Applied to powerpc/next.
>>=20
>> [1/1] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node 'reg'
>>        https://git.kernel.org/powerpc/c/bc1cf75027585f8d87f94e464ee5909a=
cf885a8c
>>=20
>> cheers
>>=20
>
> Hi,
>
> I guess, that it does not really matter, but shouldn't the=20
> of_node_put() be *after* the "reset_io =3D *rst;" statements to be=20
> absolutely safe?

Technically yes.

> (This change is in my backlog and I have apparently never proposed it)

Can you rebase and resend?

cheers
