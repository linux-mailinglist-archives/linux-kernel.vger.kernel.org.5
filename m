Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC09789835
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjHZQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHZQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7AA122;
        Sat, 26 Aug 2023 09:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CA3611B1;
        Sat, 26 Aug 2023 16:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F06C433C8;
        Sat, 26 Aug 2023 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693068054;
        bh=widZUIL4awMnotV5PwgV7JD/Cqjjf+9Z4OIXH0r4UHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwOLpLMyI4TvkLq706/Cxmncg4X+tXDMuAkPIWISEtEYE6+IQJg5e/hWdEBdDaZ1a
         5N0gfyaPk0+vwEOU91hClwWDY5loE22CYxSkC1zLKD5/NBKg49Klo9P+ruaW+IHFE1
         SNjps19s7mOYetR3G5VsB04XLJS7M18cJ45Rv1Z0=
Date:   Sat, 26 Aug 2023 18:40:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15] Revert "KVM: x86: enable TDP MMU by default"
Message-ID: <2023082644-vaporizer-stuffy-b8bc@gregkh>
References: <20230824010512.2714931-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824010512.2714931-1-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 06:05:12PM -0700, Sean Christopherson wrote:
> Disable the TDP MMU by default in v5.15 kernels to "fix" several severe
> performance bugs that have since been found and fixed in the TDP MMU, but
> are unsuitable for backporting to v5.15.

Now queued up, thanks.

greg k-h
