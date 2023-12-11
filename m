Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B280CE18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjLKORD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbjLKOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:16:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CE5358C;
        Mon, 11 Dec 2023 06:10:04 -0800 (PST)
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAE5F1FB98;
        Mon, 11 Dec 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702303803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKxVyX+SKPCIYF4IJBe8/I2MyUGreeFRL0iWzGK5Q4w=;
        b=iKo7/NtwiCsZCOfWLOJpz9mx4wKtKPFqRJjZkJ81RIcrB/n6hw2eM3fHOiUTgzmEGwSVti
        5dA7MlJa2DBWySFuFTz/zo7MQH7ScbtW5L8vshDNjx8F/lcmAG2h7bONiklr1Ov2d1ODZK
        qP46GWnTJ4Dfd+rCIWNFi4v4maIylfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702303803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKxVyX+SKPCIYF4IJBe8/I2MyUGreeFRL0iWzGK5Q4w=;
        b=9FxoBVTdPWBMOqL4QBpYrRECIw94ljwhBkz7MKZlSJclOdQwhNbH5SQxY2lianCA9p3WTT
        j4wr3DY+1sMecoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702303802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKxVyX+SKPCIYF4IJBe8/I2MyUGreeFRL0iWzGK5Q4w=;
        b=kczBXqTM1vaAGqbVAA5pR0fxilW68PuB9MyIUuOZFBPu3ORPDu3swUUDxY+tovIYmSYBVH
        x8YIwCc8VHNddMe6k1q4jlhG2RUZi4VVUzeMMrw/9YZsM3pOZG+sudOe38VltPEXoDSUs8
        Iri+gBpJKvOuXvh5yEJx55bF20ulc2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702303802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IKxVyX+SKPCIYF4IJBe8/I2MyUGreeFRL0iWzGK5Q4w=;
        b=2DEYPgfostj5x0QebrIKAQA+QKl9Tr1auGjcjdU6c1ILBaWzXreF/Ba3kPMt3wSJfOGv8n
        73qgFtSGg2OYdACg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id D94014A0379; Mon, 11 Dec 2023 15:10:02 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     Nam Cao <namcao@linutronix.de>
Cc:     stable@vger.kernel.org, jiajie.ho@starfivetech.com,
        palmer@rivosinc.com, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Backport riscv kconfig for v6.6
In-Reply-To: <20231211145750.7bc2d378@namcao> (Nam Cao's message of "Mon, 11
        Dec 2023 14:57:50 +0100")
References: <20231211145750.7bc2d378@namcao>
X-Yow:  Hello.  I know the divorce rate among unmarried Catholic
 Alaskan females!!
Date:   Mon, 11 Dec 2023 15:10:02 +0100
Message-ID: <mvmwmtkq18l.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spam-Score: -1.38
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.982];
         RCPT_COUNT_SEVEN(0.00)[7];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.01)[45.07%]
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 11 2023, Nam Cao wrote:

> Without this, it is not possible to configure the kernel with SPI drivers
> for the Visionfive 2 board.

Is it?  There is nothing that stops you from just enabling it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
