Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDAD7B474A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjJAMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:09:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964692
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1696162128;
        bh=HaGGZ/T1x2QqtiunV/yuLIU/Bf4cwKcDBuVOuiJdBO4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cSPgCQWkWl+vq4DTmWJc6it0Ms0qTx5xVyBHCROP8flRCcYQBo46bvVYp4E2EA7ul
         EZZdeUl5yuLBpit32J1h8YCa9LI3abw66iRev20FBj7p6nCPFZeBdyrJ5a3zVq2nMs
         Z022TiT0wJVeK7+5ni815zlvs7W2fdA1VYRuVWTHD2B+fLmqI1l9394pdu5PiVnDn8
         3EQdrKicR+O5R2dFZmGxcOopnOzgTrqHUq90N+O7It+rNww+VTnRLL/qyRtHo/vc19
         aX4D0eqRDiEC56nX2xLcmgg6seky89L3h9miRYiHlmdmTHDBFRO1ArW2Dk4Tdqt8WM
         GSwYkmNqK0HFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rz2tN0S4Tz4x2Y;
        Sun,  1 Oct 2023 23:08:43 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <ZRgfVfaIkEWsL8Ha@gallifrey>
References: <20230825142754.1487900-1-linux@treblig.org>
 <ZRgfVfaIkEWsL8Ha@gallifrey>
Date:   Sun, 01 Oct 2023 23:08:42 +1100
Message-ID: <87a5t2sfxx.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <linux@treblig.org> writes:
> * linux@treblig.org (linux@treblig.org) wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> 
>> PowerPC has a 'btext' font used for the console which is almost identical
>> to the shared font_sun8x16, so use it rather than duplicating the data.
>
> Hi Michael,
>   Are you going to pick this up for 6.7?

Yes I will.

cheers
