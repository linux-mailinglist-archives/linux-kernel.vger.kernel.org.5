Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D6C7D7248
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJYRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:31:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205211F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:31:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698255087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vEG9DpJeXgBAYLPyeI14/+zK1L5qo7Es6YcPCDpDJqY=;
        b=G0XHM7hHdxbzCd18a8TdD6oAVZlDR9vznRRxNa5bLv3uvf/5iAHlTUxpz+8Mh77YEphF9B
        wYEpaoTyidseaQCL1n89dbgDTw/khh7jZrvAxTU1rhVbNqOUIO9exkd+sXhWsQ1w5kkfMG
        j4bUf/I9mHxGhXlafrhvUH4ZVW+SpdZOXWIzkyzNAVT3ZqrptFvieBh4rNqlSTgKDzs+rp
        I4OQESSpqDdQi5IamdKOGMWLu7jKD/ef+OYRFW9s3oQBAlSbpgdjhFWM0aAhG3IgtonRSY
        /HycP95xQd0YWzG019UvTL0AtSDYAC9BD4lYHDqWuWOvcQYlZ05T0Pdv5Se4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698255087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vEG9DpJeXgBAYLPyeI14/+zK1L5qo7Es6YcPCDpDJqY=;
        b=cXkzEnNrBP4t9sarFxPQ8Sr9WbRDVSrRoBBqHdJhQw5rdpgo7M4Ol1XT4VuAf2RER94VN+
        Pvq2k779O4aNE1DQ==
To:     David Lazar <dlazar@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PIC probing code from e179f6914152 failing
In-Reply-To: <ZTkzYA3w2p3L4SVA@localhost>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
 <ZTkzYA3w2p3L4SVA@localhost>
Date:   Wed, 25 Oct 2023 19:31:26 +0200
Message-ID: <87jzra6235.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2023 at 17:25, David Lazar wrote:
> --- On Wed, 25 Oct 2023, Mario Limonciello wrote:
>> David - can you see if the below helps your hardware?
>
> The keyboard and mouse work fine with Thomas' patch.
>
> I've uploaded the debug info to the bug:
>
> https://bugzilla.kernel.org/attachment.cgi?id=305291&action=edit

Let me write a changelog then. Unless Rafael has any objections to that
approach.

Thanks,

        tglx

