Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262437EA61B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:38:26 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4410D0;
        Mon, 13 Nov 2023 14:38:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46A21E0003;
        Mon, 13 Nov 2023 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699915099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sTxLeLc82mmht8wipjypAj1ei1WrsDVW9xRtHUoNb8=;
        b=izQsON3R8/VUAZyRk+epXwsiLweP3Bpw71vvAYojUMF3F7jTw+Ky2q1kibsrT8uREh2CEk
        gVavslBD7SoTts5jS/kypeEcwb+nuPXhK/Ydj2MuRUpHM09jY5AFkPTUfWj/rk+7g8e89U
        Wo1M656A9vWP1z6snHrS8ttrdFx/4P6nZ/vMClnsA0cTaOdUFFXslhdJddrTRR4RND/OeZ
        LwfiID/v+I8Mg6LBj+LzyiO/uONGY30AoGALF36JFGikMP1NDJ8nj+94dNZvxs2P1hZQX4
        KuNrBF5MbbeORLBekO7SXGLuyFTacxgsIwER/7OkqGdwv7sa5Y9o4G2Da3nuIw==
Date:   Mon, 13 Nov 2023 23:38:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Message-ID: <20231113223819fb469198@mail.local>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
> Now that the merge window is over, can this be picked up?
> 

I'd be happy to invoice AMD so they get a quick response time.

> All of those people who reported it have also reported on the matching
> trackers that it helped their issue.
> 
> Thanks!

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
