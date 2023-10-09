Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA637BEE35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378892AbjJIWWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJIWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:22:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6D9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:22:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696890165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mu10TlOwpiIHtysKbrBxTz77TSQUQDjSHJgGghr0Kv4=;
        b=SmSZF4vfYBfWQsa44X3C1PiDRMosLjLxN6aRIqNaLsoMtVDShtcKGaCmll8ZCqxsPOn7r6
        fnnf8ItSpmjqH8+1KXuMTzszvQL19+Cx3Io5qasGbkssAiGR1JgMPEdJ0SV55xxRgbKHdv
        +1bvKvTU7vTWEMwZCogNKSuRItN3zCT/pF3am8lXyhbZNskgBTVCo1Gp7TrMZH3GFaFeFM
        PBnOAOgh8U36JvAFzjtsh5A1lJhhvZMR0SIfLveFyQU9UR52lxMoskbEcxIvH4KlJY3fks
        VrN2uNsrDD4I8vaRaKcCoz7o+eHL+pvEkR84vmj2o8+lt3QxLDrSnVIC3cpUUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696890165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mu10TlOwpiIHtysKbrBxTz77TSQUQDjSHJgGghr0Kv4=;
        b=JegBx0ZrK84MSh2kn+6hspTsHnc+K44bhqB5ZhkFPVLX20wHdNLqUBDvtiT/R0fj7S0Bon
        SUH38PO4kqSRJUAw==
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: ls-scfg-msi: Use device_get_match_data()
In-Reply-To: <20231006224422.442491-1-robh@kernel.org>
References: <20231006224422.442491-1-robh@kernel.org>
Date:   Tue, 10 Oct 2023 00:22:45 +0200
Message-ID: <8734yjphai.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06 2023 at 17:44, Rob Herring wrote:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.

So this tells me WHAT the patch is doing, but gives me zero information
WHY.

Thanks,

        tglx
