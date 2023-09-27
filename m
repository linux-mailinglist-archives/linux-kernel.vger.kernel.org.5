Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB407AFC35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjI0HjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjI0HjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:39:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02CBF;
        Wed, 27 Sep 2023 00:39:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695800341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WEaS5J7hQPOB4r9sfIbC/59hNCFJ7psDD/W5mr+mcZ0=;
        b=XRULdat+pGcSPCVEdmpp3yQw5ZVHIif2IXNDX5MW7I0kV56f+GwMAGGKqKYSgDUA8GtcyD
        w82kxKnzNs6S8xTQrbCv9ZDlX8vpGuDl/DeVvz3RojVsTPTcRVOtcvZFg9Va9ttC3qLKS+
        y8E/D86nrhtiUU4bPSOfwl0kwh9WSOKkcLxrW0NZVShsPtHhB7RBTkWJ0TJY9eGviySs2h
        POL1Dge7BFcop9uDEb58awPyGrp1Ha5ZPGyq1mZ/JwKj6EXC/FlZMgjLEFhoK+wBOCj7ev
        JlpjbYYST0SMZO6bqOe8NzC0Y8zkfWF0Pmgd0fysyjFoOd29+rVuOa8ii/khdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695800341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WEaS5J7hQPOB4r9sfIbC/59hNCFJ7psDD/W5mr+mcZ0=;
        b=90OqJWBBT/je5vf/OUwMIVQPQIT7uDibZQ+oKcMwQDXtd/2f7Cts/o6lurhqJ081lC4lQv
        TWYOIMd0plhiiCCA==
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH -next] serial: core: fix kernel-doc for
 uart_port_unlock_irqrestore()
In-Reply-To: <20230927044128.4748-1-rdunlap@infradead.org>
References: <20230927044128.4748-1-rdunlap@infradead.org>
Date:   Wed, 27 Sep 2023 09:45:00 +0206
Message-ID: <87sf70f4kr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-26, Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix the function name to avoid a kernel-doc warning:
>
> include/linux/serial_core.h:666: warning: expecting prototype for uart_port_lock_irqrestore(). Prototype was for uart_port_unlock_irqrestore() instead
>
> Fixes: b0af4bcb4946 ("serial: core: Provide port lock wrappers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>

Thanks for catching and fixing this.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
