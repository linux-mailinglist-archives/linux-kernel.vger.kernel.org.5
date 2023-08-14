Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAD77B556
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjHNJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjHNJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238E113;
        Mon, 14 Aug 2023 02:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA41761471;
        Mon, 14 Aug 2023 09:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3C4C433C7;
        Mon, 14 Aug 2023 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692005050;
        bh=SCs4zTS/d2eft1FghdTtdZV62MgP4ApoANyrYFjopP4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Cr76U9yhiC5tWjPWC58TuQX0cqQY9Se0RxKNUIXPLjUAQWbS/VBgRlSp4VOlIYwmg
         DDoOJcYJ+RimqvLSCAp8VDYmUMzOcW5r8x6uGuq3SVU05ihKRGf4w1kXs4+TOXL4n4
         VSkix1zlPGJx4b/sWwXfGNSKh2h2CoSAC2AUzGjhkmFZhanSTyvPrgejBTNvh/leJZ
         hXTBObb9tRkkrpzkbO4VatKetRygQ7UdY6EzuLvcp68aFg4K0OwYiVa/nmS6J/DbQ0
         dPcVQoO7jgob3VK4QpK0E+vUlT5DJFiJsAncIP8wty1eQMAMDo8edeaXhc4HDjwmUE
         gAizLnWRB/uXA==
Date:   Mon, 14 Aug 2023 11:24:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: roccat: make all 'class' structures const
In-Reply-To: <20230620183141.681353-3-gregkh@linuxfoundation.org>
Message-ID: <nycvar.YFH.7.76.2308141123540.14207@cbobk.fhfr.pm>
References: <20230620183141.681353-3-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023, Greg Kroah-Hartman wrote:

> From: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> Cc: Stefan Achatz <erazor_de@users.sourceforge.net>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Both patches now applied, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

