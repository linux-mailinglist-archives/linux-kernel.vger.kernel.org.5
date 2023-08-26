Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F644789841
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHZQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjHZQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64481995;
        Sat, 26 Aug 2023 09:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D110624CF;
        Sat, 26 Aug 2023 16:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897DCC433C7;
        Sat, 26 Aug 2023 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693068231;
        bh=qwjLftzT2lJ3gR2Gen3pQpI/CQjmca5Vf/kLbbahIUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xyImouPOYx0nl2mK/Sri1zGS5I88X3fY+AbQC/CuWXD9rtALvj4wmeBIp5Y5pgGlO
         iC1T1KHgmv6bcRhiKoot86MjG0DwB9YzD4liPVjApXMbuJMbm5EF5OEd1Z1jqQ/yaz
         aqqylc6TKMIpaIAbeG75vr6d2OP38bdogz7EqTk0=
Date:   Sat, 26 Aug 2023 18:43:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     stable@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] KVM: x86: Preserve TDP MMU roots until they are
 explicitly invalidated
Message-ID: <2023082640-reply-pelt-b203@gregkh>
References: <20230824162624.2744655-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824162624.2744655-1-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:26:24AM -0700, Sean Christopherson wrote:
> Upstream commit edbdb43fc96b11b3bfa531be306a1993d9fe89ec.

Now queued up, thanks.

greg k-h
