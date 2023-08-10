Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC8776FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjHJFut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjHJFur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E67FE;
        Wed,  9 Aug 2023 22:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2883F6453C;
        Thu, 10 Aug 2023 05:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37535C433C7;
        Thu, 10 Aug 2023 05:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691646646;
        bh=yxe/F2fvp0XMn5DsiwYb3ozvH6Ae18tCbur5MWqtm5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9YLjZSDcLNd+0yY4WEPHrrrBvNCsC2x2C/W6U6k9DVv/67lsIz2TBvs+ZEsSad2s
         2aMmCYfhBbaBPPn23gW11+PbOsXFHhgFdQPu0CVmsvTuyAGb1AjnsiUYA3XWXAkb1c
         pR4Wuf5JZ86XtFEj4X21ezjsl/tEpq4ligKK6/8s=
Date:   Thu, 10 Aug 2023 07:50:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v9 4/7] sign-file: add support to sign modules in bulk
Message-ID: <2023081024-garment-conducive-d429@gregkh>
References: <20230809172211.343677-1-yesshedi@gmail.com>
 <20230809172211.343677-5-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809172211.343677-5-yesshedi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:52:07PM +0530, Shreenidhi Shedi wrote:
> In the existing system, we need to invoke sign-file binary for every
> module we want to sign. This patch adds support to give modules list
> in bulk and it will sign them all one by one.

But you never actually use this option in the kernel build process?  If
not, why add this at all?

thanks,

greg k-h
