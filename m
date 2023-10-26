Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569A7D80F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjJZKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjJZKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60A18A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:41:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698316890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6L6DWD07tt2bFggRawWCkh8dvucnoefnFHvJXio3Cc=;
        b=SDA2PWvd6GpZ23Q29afOzvItIzP7Dmf9HxNwShbfHzRxZjMPA4ORRmQFrk4WZqVIuYJe78
        Jjsg0SXxwbKfifz1L23f1CdJwoxreMsFrOKuBeQJfGXO+u26WWu5ivTISfPn4+KXF0cHk/
        huAuzWJqNSGNclPgsARofKggfNPAuZ+0plX2vdFECnfvEECG9ZCV2OgWZzy/kFyldQpKNy
        DG2ezfPALHgpx2jG+WhLbas6xIrBHfsdS2IKEi5xAaG6qX720gEFKUw0hn3r6kdvA0wQG0
        0TZzeFKe5acOFUy8oa/+e/DZcmRQQ1B7ook34O80PbmRILDqUAZryd/8cae/+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698316890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6L6DWD07tt2bFggRawWCkh8dvucnoefnFHvJXio3Cc=;
        b=ZME73FASasBJ5RVuSkYko3ct13v8tQwEK3s0Acq8SemU/uhrkeF7J9uba6SJtkbApjKiuN
        8qpaQyEohb9CJKDg==
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Anup Patel <anup@brainfault.org>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [RFC PATCH] genirq/matrix: Dynamic bitmap allocation
In-Reply-To: <20231026101957.320572-1-bjorn@kernel.org>
References: <20231026101957.320572-1-bjorn@kernel.org>
Date:   Thu, 26 Oct 2023 12:41:30 +0200
Message-ID: <87r0lh4qed.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn!

On Thu, Oct 26 2023 at 12:19, Bj=C3=B6rn T=C3=B6pel wrote:
> Thomas, this is just FYI/RFC. This change would only make sense, if
> the RISC-V AIA series starts using the IRQ matrix allocator.

I'm not seeing anything horrible with that.

Thanks,

        tglx
