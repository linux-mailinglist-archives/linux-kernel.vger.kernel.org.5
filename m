Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92994783C67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjHVJCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHVJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08B1B7;
        Tue, 22 Aug 2023 02:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D19637EC;
        Tue, 22 Aug 2023 09:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD6C433CA;
        Tue, 22 Aug 2023 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692694914;
        bh=oCbojt07SO8RbzwvZv92plbP41oFUdM1PKdym5EtsfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejrTcNOML+v/yoUgA5Kwpb44WA3VNRLu9jjOGOsnxQIwSlaxCp540Hmvyg63i9rtH
         NdoIi551+poyczVZA2UTFZ5DlC0VSUsvPKRz8YEWfUb6M0souzHca+GM79eNmbfCU5
         KVoBkD6GSip0E/5EzRgqxXSf3zqmL/jBy3g4trtpSvDWQ/UeiGuIPipI/KSLm8PHrj
         wi0oMF8WbQ9eHTlZpyyhkZL2HPZcXItn3Y6DCNL5+hE8LvRIw54l2RyqdM7hBxUYBt
         IsuqXXAbc3ytNVE7BX3Ogu6VXKu/H+zqfrNwHgy41qXj3G0NyAPja/nQyUezJtWl13
         WQJp9W02FGyEw==
Date:   Tue, 22 Aug 2023 11:01:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Franklin =?utf-8?B?4oCcU25haXBl4oCd?= Mathieu <snaipe@arista.com>,
        ovt@google.com, corbet@lwn.net, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] shmem: add support for user extended attributes
Message-ID: <20230822-mammut-weinlaune-7925b2a8af59@brauner>
References: <9b8d38f0-fd22-3f98-d070-16baf976ecb5@google.com>
 <20230814082339.2006418-1-snaipe@arista.com>
 <986c412c-669a-43fe-d72a-9e81bca8211@google.com>
 <CAK8sBDM5aid1vkCKhBxqUHXrG_FbDRN0noLtPkcPv=jXb7NTNg@mail.gmail.com>
 <20230815-sensibel-weltumsegelung-6593f2195293@brauner>
 <924ed61c-5681-aa8b-d943-7f73694d159@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <924ed61c-5681-aa8b-d943-7f73694d159@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> "tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple xattrs" just sent to fix it:
> https://lore.kernel.org/linux-fsdevel/f6953e5a-4183-8314-38f2-40be60998615@google.com/

Thank you. I snatched it now.
