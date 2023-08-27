Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9550F78A302
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjH0WrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjH0Wqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:46:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A35E5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:46:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27E9840002;
        Sun, 27 Aug 2023 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693176406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiM2QFhHnr1QFEOHj0sVy982q1bfnylCGYd4h2Dcdc8=;
        b=AzUkqyhepFmumOrPrNzLHjRVroBV4SEwQVw88W9dQQXOAKOU4kjDMSSkSrnrbpuPuBf2HW
        NPaENyvupE3W1l/ozZMwKuBb0g8h1v6hh9kCQDPVn8rkWopSd88e8/AJzWohisDj9xMFfB
        caQ51seMFsYipau/6/lbdd/aYkN3rw3w3yYwjQSBZgIWvUwF5eelW/5UGp6x413zU0DvUu
        Z5VJVPkfsA+m/SSrsouqHT4xSbdB7HPgq9TRRcV7Atwa2+IsM/jjKqkqihSLKFrvkqM4h9
        8WY8M2ehz7VeHJGhUYMv3qy6vNH4geYyJIOXIZEMtFSrDSbwVmzfLHegNN8zhQ==
Date:   Mon, 28 Aug 2023 00:46:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Aniket <aniketmaurya@google.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        joychakr@google.com, manugautam@google.com
Subject: Re: [PATCH] i3c: master: Fix SETDASA process
Message-ID: <169317639314.563617.17285767371678104909.b4-ty@bootlin.com>
References: <20230822051938.2852567-1-aniketmaurya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822051938.2852567-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 05:19:38 +0000, Aniket wrote:
> When a I3C DT node has a static_addr and an init_dyn_addr,the
> init_dyn_addr is reserved in i3c_master_bus_init() and then
> the static_addr is reserved in i3c_master_early_i3c_dev_add().
> But if the dynamic address is same as static then above
> procedure would fail.
> Add a check to pass i3c_bus_get_addr_slot_status() when static
> and dynamic address are equal.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: Fix SETDASA process
      commit: c6a7550458922181bb922863d5f5feaf3c453fe5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
