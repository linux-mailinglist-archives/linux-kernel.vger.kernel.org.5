Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A378980EF08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjLLOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjLLOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:41:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D8EA;
        Tue, 12 Dec 2023 06:41:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cjPK7MVMgy2ptbwUtlp8hX92DZpbm09HrB3RqKSh7c=;
        b=hCzGva0qLyY2C794F9jreEi1PD8bHm/7vc2zgjOo66QgbykdqHgb4wGk0RaEJhMI+7W54z
        +NYLWcjI5Y5AXNwoEnl3jvaDcmBgJQDDr7PADCO6kQwqeOwkdmAocWluYzUQCYQUFYlxfh
        Q0Ikm6ZEYxj9IHLk1iGRyexe+8YY8aZmTf5L0TTz7KynsISTAJdp6LDADZwqmh6j+wefyb
        88ieBJQN7PRqQnjvL1UAeQObMSc1gQQlcc0hzfvlSKRvtUkOZSlKlVZLiApec5w+zp2ix8
        64KIld3svU96A6McyGVJpYr7Mnkixau9BoNEWnssHQ5IoI36VIpHMVmoN4A+NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cjPK7MVMgy2ptbwUtlp8hX92DZpbm09HrB3RqKSh7c=;
        b=rAOSq9PljTxW1TWf7+dIHC1trcyKTaG3HqffG6HSHU3USgY3wtPbHOQ4zC6GYi9Ve0cz+e
        hZKuJH22Z+TwoABg==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] arm64: dts: renesas: r9108g045: Add IA55
 interrupt controller node
In-Reply-To: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
References: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com>
 <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
 <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Date:   Tue, 12 Dec 2023 15:41:47 +0100
Message-ID: <877cljqy8k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert!

On Sat, Dec 09 2023 at 17:24, Geert Uytterhoeven wrote:
> On Fri, Dec 8, 2023 at 10:16=E2=80=AFPM tip-bot2 for Claudiu Beznea
> <tip-bot2@linutronix.de> wrote:
>> The following commit has been merged into the irq/core branch of tip:
>>
>> Commit-ID:     8794f5c3d2299670d16b2fb1e6657f5f33c1518c
>> Gitweb:        https://git.kernel.org/tip/8794f5c3d2299670d16b2fb1e6657f=
5f33c1518c
>> Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> AuthorDate:    Mon, 20 Nov 2023 13:18:20 +02:00
>> Committer:     Thomas Gleixner <tglx@linutronix.de>
>> CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00
>>
>> arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node
>
> Please do not apply Renesas DTS patches to your tree without an
> explicit ack.
> Renesas DTS patches are intended to go in through the renesas-devel
> and soc trees.

Sorry. I had the impression this all belongs together. I zapped 1/9 and
9/9 and force pushed the branch. Should be gone in tomorrows next
