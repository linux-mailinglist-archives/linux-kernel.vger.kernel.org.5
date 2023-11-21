Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECBB7F3253
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjKUP0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjKUP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:26:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0CE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:26:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700580384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iiq2mbTgBqjsqnzkJji7amx/RmZznpllsmH5eCktL90=;
        b=RyxafyiSMvaX486br0yP3gT97bwsZMFyYi2PdfIHpdsbz7WWf0ylTqkmvaAF51YnUPaZzT
        qETxDEgEW9pnOfGkwx4nBYHgDRp+5ovtAnKzRfNfrqMaVY9KJUYRUUXtjoNVOXPu0yLYQu
        uertVueEOQoUWyWJ9X84+2G9CcGmmPk5wkXNoQlIUaxD0g9GSep2oaMuXq5u4s683vEmdy
        wLeceGMJqPQWw3BwBN8Q4prtnLPAMzCBOD+QacZZ00WL2SdIrrKC1+AHxqx4b3Bf8D1nxf
        vpyH+GiPighoiQpigZAq3YhU2kFvm2hVvgT3Uesd8q5JrGAXXbrOsoO7FrcGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700580384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iiq2mbTgBqjsqnzkJji7amx/RmZznpllsmH5eCktL90=;
        b=czzsI8C6cQomtR9dlzFYm1BeCSClo2GYReA+2n5Hdkzb3vt18cv7ETHq+8pMX175ju5ptX
        QKLT9Tb8gZ4eHABw==
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 0/2] x86/entry: Trade cycles
In-Reply-To: <20231120143344.584345121@infradead.org>
References: <20231120143344.584345121@infradead.org>
Date:   Tue, 21 Nov 2023 16:26:24 +0100
Message-ID: <87msv7161r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2023 at 15:33, Peter Zijlstra wrote:
> Two little patches that trade a little performance. First patch optimizes
> (although I couldn't get definite numbers showing it makes a difference) the
> return to user path by avoiding some PTI specifics in the generic path.
>
> Second patch then steals some of the won cycles by making a debug check
> unconditional.
>
> This came forth from a discussion with amluto who lamented we only had the
> debug check conditional on DEBUG_ENTRY.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
