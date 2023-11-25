Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D57F8B10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjKYNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjKYNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:05:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7798F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:06:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D42EC433C8;
        Sat, 25 Nov 2023 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700917560;
        bh=zN2kg7T1x/yzMzUk9rg3IuB3e5b0pJ9xdV6CwEdltlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpM+OA4rGklyAAcdhgUH/8gk6C/5Z/HIGTVF0/t3JWHBPT8aDmVZd02aOUE8QToV0
         vANr5amDRmH5AxS5lBkRLYnVHscQzYVROW3mIURI252hyNOuyQPGBjEecJI3vZTv48
         qlhR/If0ZNdUJpaIL/JiKSyEVb28RTsXEJY0E4otGYZrDW2lH+zcaNFw9sRBgXChlt
         5/SAasKYLa+/Yug+2n7Z4iQnytXEwAE1Uzx6mfERJ6PEkFmBegE1lAQcNX1EN/QuHe
         TKjtMmG+NrMB+nG3H9aO4qTp/shjo1kTiXscP6vnAbyyJHcKQdNjv9xc3CYXNNOUoH
         sYT3owJIc4EAQ==
Date:   Sat, 25 Nov 2023 14:05:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@fb.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <20231125-blitzen-kugel-5159d574881b@brauner>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <CAHk-=wg0oDAKb6Qip-KtA5iFViy6EPWHt2DfCcG8LCXTb7i00w@mail.gmail.com>
 <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCS30Mqy9b=op2f=ir9iPQfQ2Efjo1b8yMeJrXcWTtWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Because we could just say "read zeroes from KCORE_VMALLOC" and be done
> with it that way.

Let's try to do that and see what happens. If we get away with it then
great, if not we can think about fixing this.
