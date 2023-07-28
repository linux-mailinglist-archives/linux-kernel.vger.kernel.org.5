Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05447665B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjG1HrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjG1HrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E539B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B30062031
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E818C433C8;
        Fri, 28 Jul 2023 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690530419;
        bh=UPZGZZDtACk2HPDvz9hxP3rYKDUEjyDArXVM3YwrrGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GH9SYZoLnmZbEeCmKGkeuRQ56isG+we93XeL/BolYPAjTDBhlQngRU3AVHK5L0ZUM
         X6/MzLUR/E2ERaAowhgh+YXik9r7jaoR7Faa/lOePMT/GLf/cdIpSqLVwmfCWrNLHO
         kTxeA0fpbvGVRu5W90rS/uuFR0UZaIFr3XI8hMOZDqm12Q+iH/UV/GO/oseyORvm+W
         smLo0zw9KPeCCyPaaKHdgikQxoUHGeWCt/praFWSn9CkuzZ18shvvmVi3YZCYfWQTX
         7SkRbgsT2RbgJBaQM/Be6agIFtWlI2/yua1DjJl31UVguBPZLrKbCPUemLEhyBAMNg
         +vFlxJqcQY+ZA==
Date:   Fri, 28 Jul 2023 09:46:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] binderfs: Drop unused #include <linux/radix-tree.h>
Message-ID: <20230728-derivate-verprellen-9a7de26bacbc@brauner>
References: <20230728070931.589823-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728070931.589823-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:09:31AM +0200, Uwe Kleine-König wrote:
> binderfs.c doens't use any of the symbols provided by linux/radix-tree.h
> and compiles just fine without this include. So drop the #include.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
