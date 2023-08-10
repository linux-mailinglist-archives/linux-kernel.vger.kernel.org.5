Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D776FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHJFtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHJFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB66DA;
        Wed,  9 Aug 2023 22:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400D564F14;
        Thu, 10 Aug 2023 05:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA4CC433C7;
        Thu, 10 Aug 2023 05:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691646556;
        bh=IJi0sm+DkLbY+WnD9F/rP1g+MrL/9MVSJKbj/TUpj7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4jv/bdK+EUAN6goEQjx6uUtnqg9QRMO1hfUJLbYZizoyF+1/5CXr5qioNWpXY3ux
         BA/HtmOdfzq7r9y3X+baWKC7HGTMRA0zhxjiE5W7dVCvfSnf/ssXAJSYTm1wU7na2I
         YMZcXe5PvKCZuyk3YfeW2E2cZq3QJt9hAjWTACeE=
Date:   Thu, 10 Aug 2023 07:49:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v9 2/7] sign-file: inntroduce few new flags to make
 argument processing easy.
Message-ID: <2023081048-evergreen-unmade-87ac@gregkh>
References: <20230809172211.343677-1-yesshedi@gmail.com>
 <20230809172211.343677-3-yesshedi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809172211.343677-3-yesshedi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:52:05PM +0530, Shreenidhi Shedi wrote:
> - Add some more options like help, x509, hashalgo to command line args

What do these options do?  Why multiple new features in one change?
Where are any of these documented?

thanks,

greg k-h
