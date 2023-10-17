Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3E7CCA23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343945AbjJQRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:48:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309298
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:48:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E12C433C8;
        Tue, 17 Oct 2023 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697564906;
        bh=d5ro2uDPiHIFiEyEZ7t19KMZFO/2f6mAIKETEjwZ1S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgJrJZq169QAfjNFIMlxM40eVf3HWjrXSPP0p2+IxGVjstskU3RMip1lLdEzXA7vp
         gJHMyl9Bw/J0IL9OAlJ/vlaOHOq8c3j1r7+nSlmSARo8xuqeUwDHPyX3z+C7Fe9RuL
         ArLeetQUOxhLdyCrTd1dm6w4TzTAje5Ao4p/3kwI=
Date:   Tue, 17 Oct 2023 13:48:24 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pgpkeys: new keys need two signatures
Message-ID: <20231017-professed-pumice-ca3ae3@meerkat>
References: <20230716-fixes-v1-1-9802bf35ad6b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716-fixes-v1-1-9802bf35ad6b@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 09:38:19PM +0200, Thomas Weißschuh wrote:
> Recent messages on the keys@linux.kernel.org list indicate that two
> signatures are needed.
> This also matches the wording from accounts.rst.

Sorry for the long delay getting back to you. The current wording is actually
correct -- to be included into the keyring it is sufficient to just have a
single path to Linus.

We do require two signatures to get a kernel.org account, but it's a separate
set of requirements -- not everyone included into the keyring has an account.

-K
