Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9557CDB95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJRM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:27:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095BCA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:27:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D30C433C8;
        Wed, 18 Oct 2023 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697632055;
        bh=3oMHWPgTZG+wzUE1L2j7bPKf+yDdpXrGoQcpak/VDrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsIVjBfchCmuA+zAYWvguw/d9o+Nn5OfO435koR3kW6NsDUccc/np1OVblibxiCCP
         gkCD6jYmh2VnrNbFuB8qXkX+Kv/MmCIvP11/d76Px8N4CcMsG0VNS2SHpfqCRcYkoz
         5l/lPhHiYbruGVg/bnlscThapy+Zv0UeJQNqw/fkYYyoq+ZijaK3E7hmJ5KQ/Anxl+
         dn4gj8Q2f5ztj5HTeDkKZ6zSnvo9P3SDaTWMak4LxKcjR79KiwzbqPGwoC7hArpK32
         pmLaxY0TtbLQtMNSYq/N3thH1HAEwQBc2Ys66sjwKAtULBvIBEdnO31w1Ji33KaQo0
         Sdtugu2J3X6bA==
Date:   Wed, 18 Oct 2023 13:27:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, arnd@arndb.de, keescook@chromium.org
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement
 optional at boot
Message-ID: <20231018122729.GA18556@willie-the-truck>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
> Aarch32 compatibility mode is enabled at compile time through
> CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
> (for both processes and syscalls) be enabled at boot time using
> a kernel parameter. Also, it provides a mean for distributions 
> to set their own default without sacrificing compatibility support,
> that is users can override default behaviour through the kernel
> parameter.

I proposed something similar in the past:

https://lkml.kernel.org/linux-fsdevel/20210916131816.8841-1-will@kernel.org/

bu the conclusion there (see the reply from Kees) was that it was better
to either use existing seccomp mechanisms or add something to control
which binfmts can be loaded.

Will
