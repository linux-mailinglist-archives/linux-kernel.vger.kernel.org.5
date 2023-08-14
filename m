Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D7977B53F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjHNJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjHNJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D004AD;
        Mon, 14 Aug 2023 02:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431D762A8C;
        Mon, 14 Aug 2023 09:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BAC433C8;
        Mon, 14 Aug 2023 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004520;
        bh=UnbYLbdWrIB2cXL2eCtQJBeGyCijgPtAVQK/KlNMhts=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gS8AIES9K3qT9NNb4p6wKdWIU2Y0Esec5F8jQa2fmYa8N/lsFeW4l8xPdk+l2IQkw
         5n9vv7eOndlU1eHq7ZEMDxjn3Q4h4aS93Nku1L+c/zWAxUPyJpv5kXb99D9cnoJEGf
         qXX6j6V0YesiBuSnxhCh5KfuY6t3nTOq6BmzEcGSIeIjnrfZxpKDYTjeZcKuM2od+T
         USVGmHE7V+g2UGw0wP+N1Yq/NDNnmMEeHf88Zp/hRlURl+FkFlZx+Ch28sCVXgPZbI
         u/Ltd25bs1Mfwh1s4WAiE1sFY0FadVz1DsCW2O2/gPbsgcw4CbQq5wm2kakJNeIm8j
         jAfFAI4dod0hQ==
Date:   Mon, 14 Aug 2023 11:15:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Osama Muhammad <osmtendev@gmail.com>
cc:     david.rheinsberg@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hid-wiimote-debug.c: Drop error checking for
 debugfs_create_file
In-Reply-To: <20230530154252.7895-1-osmtendev@gmail.com>
Message-ID: <nycvar.YFH.7.76.2308141115050.14207@cbobk.fhfr.pm>
References: <20230530154252.7895-1-osmtendev@gmail.com>
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

On Tue, 30 May 2023, Osama Muhammad wrote:

> This patch removes the error checking for debugfs_create_file
> in hid-wiimote-debug.c.c. This is because the debugfs_create_file()
> does not return NULL but an ERR_PTR after an error.
> The DebugFS kernel API is developed in a way that the
> caller can safely ignore the errors that occur during
> the creation of DebugFS nodes.The debugfs Api handles
> it gracefully. The check is unnecessary.
> 
> Link to the comment above debugfs_create_file:
> https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> 
> ---
> changes since v1
> 	-In v1 the IS_ERR was used for error checking which is dropped now.

Now applied, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

