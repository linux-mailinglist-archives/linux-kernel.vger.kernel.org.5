Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A30810B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjLMHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjLMHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:24:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D173AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:24:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8947CC433C9;
        Wed, 13 Dec 2023 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702452282;
        bh=1fqvxKFylBtBPcoXQPyYTVMKhnaamEgQ++fwy6GHEkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boPZd2hxFPasz5O41tQ5oqu+2UKNIgQgPPUhaqWQ3hQfkC0+UezbISRFJN2VRdcZu
         XxZDJV8C3w3Ks0nS3LzxYkdJDukb0SHKTkXSxe0SlepWr9HyNjLK7A/aP+c3+Fs1L1
         CP8FBi4QmpJc/9etU1QzET4clOkK3L9Gms1ybH8s=
Date:   Wed, 13 Dec 2023 08:24:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        torvalds@linux-foundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v3 01/11] mseal: Add mseal syscall.
Message-ID: <2023121343-scalping-urging-0dbc@gregkh>
References: <20231212231706.2680890-1-jeffxu@chromium.org>
 <20231212231706.2680890-2-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212231706.2680890-2-jeffxu@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:16:55PM +0000, jeffxu@chromium.org wrote:
> +config MSEAL
> +	default n

Minor nit, "n" is always the default, no need to call it out here.

> +	bool "Enable mseal() system call"
> +	depends on MMU
> +	help
> +	  Enable the virtual memory sealing.
> +	  This feature allows sealing each virtual memory area separately with
> +	  multiple sealing types.

You might want to include more documentation as to what this is for,
otherwise distros / users will not know if they need to enable this
or not.

thanks,

greg k-h
