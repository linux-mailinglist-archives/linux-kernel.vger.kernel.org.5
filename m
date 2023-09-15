Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687687A174A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjIOH0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjIOH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:26:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBC1BE6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1694762734;
        bh=AaT+Zd5A+u64/jZniFM2Hfp9z5ZX8DVUs5Jk9m7d9J8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lxTpMv/MD/jC11s2upB8FzLsS7hAoDNJTH9BYMPSJhnRvlKts1RGzbHXQ4+14yaNA
         3/7vXyisYcev6W7Xy9vcVG6BM+rn3Qhof1+JUWTZFmDTAHGhxV/mDjSxM+89aSTOne
         ctESIfeqCXLrqzlOvrXJOKS87qAkU0SDUzkz6eyKcd36wBLiU1fmLxW41G8Tp9/jzq
         nBTYFoGZyeILYg3MWKI76aD/DYMu5NX4b3YUlHEqbmSc07sF4EvHPMl9HjR1lzdJxF
         nsVLzUxJA/ro8VVQte2SmLQNb5QMjV30mDKeCmIJbMRlm7onvDMzIG0Q7XmPu3tXsO
         qga/WMC5Xv9oQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rn5M22HYpz4wxg;
        Fri, 15 Sep 2023 17:25:32 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/82xx: Select FSL_SOC
In-Reply-To: <c481fa91-0cfb-1c19-2da7-cf768bc56aea@csgroup.eu>
References: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
 <87led86zaq.fsf@mail.lhotse>
 <c481fa91-0cfb-1c19-2da7-cf768bc56aea@csgroup.eu>
Date:   Fri, 15 Sep 2023 17:25:27 +1000
Message-ID: <875y4b7va0.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 15/09/2023 =C3=A0 02:43, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> It used to be impossible to select CONFIG_CPM2 without selecting
>>> CONFIG_FSL_SOC at the same time because CONFIG_CPM2 was dependent
>>> on CONFIG_8260 and CONFIG_8260 was selecting CONFIG_FSL_SOC.
>>>
>>> But after commit eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260
>>> and CONFIG_8272") CONFIG_CPM2 depends on CONFIG_MPC82xx instead
>>                                             ^
>>                                             CONFIG_PPC_82xx
>>=20
>> All the references to CONFIG_MPC82xx should be CONFIG_PPC_82xx right?
>> I can update when applying.
>
> Ah right, I mixed things up. This is CONFIG_PPC_82xx, CONFIG_PPC_8xx,=20
> CONFIG_PPC_83xx and CONFIG_PPC_MPC512x

Thanks.

cheers
