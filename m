Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633AD78C4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjH2NNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjH2NNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:13:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84A6CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:13:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693314791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JO9KtpnDE1a8KxxyGyMgLSwSr0i+MtKSwZdLTJlEKyA=;
        b=SJvtttE6at9UXfUHhUjWk3EC/R/zm4sgPtwbzpUt0j+dQgRiY1llnUmeJU2nj57EM8BStN
        j+FKGv/r9+LCtq7us8nUGOmPofQ7ahQ/CTz+LwRLE4qrXIefro0E5AkszR1Mw70jZGCyOk
        eRly6umF5YCUT1/27J5Sz+HCsX88QkABHrKU3Mkx1Hd3S/Kj7qeex8h8/oezq/L4JHJq/k
        vrgiL8zW03YbiHhOToJo8tRk2u45RyD9f6HmDtsumtCAnBQaFOFPdOwptRMSDF+3ARLdCN
        PIvWw+bC3bOhyAKwMoMtMyiWthPJr9ikGeEwS0q4fV0109EWe8epkfHsYS1rGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693314791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JO9KtpnDE1a8KxxyGyMgLSwSr0i+MtKSwZdLTJlEKyA=;
        b=nkKFpg/LG+a1T1LvpHPA+3VDBn+D6CJh7gcKCIlt/lUdrf73S11LyHCd0SSK09e0dXZh7c
        1ZOe5wP+Tnls0kBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 8/8] printk: nbcon: Add functions for drivers
 to mark unsafe regions
In-Reply-To: <ZNY8koUN5a9TVzS2@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-9-john.ogness@linutronix.de>
 <ZNY8koUN5a9TVzS2@alley>
Date:   Tue, 29 Aug 2023 15:19:10 +0206
Message-ID: <87a5uarnyx.fsf@jogness.linutronix.de>
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

On 2023-08-11, Petr Mladek <pmladek@suse.com> wrote:
> It might be better to define nbcon_context_update_unsafe()
> in this patch. I guess that nbcon_enter_unsafe()/nbcon_exit_unsafe()
> are the only callers.

Agreed.

John
