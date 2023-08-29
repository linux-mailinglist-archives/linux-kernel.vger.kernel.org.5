Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B778C1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjH2Jnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjH2Jn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD93E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:43:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693302204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pd8ewzfjBoIUElsO+KGU1iEoHlv7aqduTYYolnrrfvA=;
        b=CJaTPpTsS15H5iou2C/cFyPCyMszciIY8oqHB48ASFbkay7uUVjymYsLzgR4PwuZ9k4PtM
        wuZI43Hl4rCtkkdiw7xKS44x78gQsDWeOSw15J8dV6vYJufdlNoxmWHVf7xxxeo5FaZf3n
        utcmkjZ9CmJ18rwPB2+IuccUNhq3tHvtgrERHqmNTgR/5ZFsbtH23yqpSF5/9QvmUDG17Y
        AHKJ7hHMwsE1yMGSKopiOoWH97cfpn2ZX1zCLQXxm3J+tawtnnRYrSzus6qMMPzLKmVI1C
        I7klk1J1ZHyqB04WPZpjU1twnml2NJjQWJ6x9me35Drau3DHVR5WnwhtUM3E+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693302205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pd8ewzfjBoIUElsO+KGU1iEoHlv7aqduTYYolnrrfvA=;
        b=24HUYEKbUpZ8JuLHFarloZrWtyqtZkmOL8fvKla7JFY5BgQsLIxIgnEwWMdbCzfYES7BdL
        19iodxKE7c2nwcDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 3/8] printk: nbcon: Add acquire/release logic
In-Reply-To: <ZNNof7rNADMtyajC@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
 <ZNNof7rNADMtyajC@alley>
Date:   Tue, 29 Aug 2023 11:49:24 +0206
Message-ID: <87r0nmrxoj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09, Petr Mladek <pmladek@suse.com> wrote:
> My proposal is a kind of inverted logic. It allows only limited number
> of scenarios. It reduces backward loops. And it is more clear what
> is possible in which part of the code.

I agree with your suggestions for simplification. Thanks.

John
