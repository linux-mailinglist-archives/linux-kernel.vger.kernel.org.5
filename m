Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B437DE3B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjKAOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjKAOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:20:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E0115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:20:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EDCC433C7;
        Wed,  1 Nov 2023 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698848408;
        bh=PzUEW4w524QdvWruo3C65kPqW198zzSfCHbbShc+m20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvzfVprkRxyBXCL2fyT3+f/ZKg3hX1Ss7t1LQCNQEkqIKOANLH43BUvLnOy0DIVoJ
         cJrywwsRHVVNA9tWb2U0JN6aDQ4uAqkMhu6ucPdjq5DWYgsjQ9zSy9uWM+2+lOkpd6
         ts0iB/+Y5ul3aTkgNMM9IfyZdAtmcFDhARMAKi14=
Date:   Wed, 1 Nov 2023 15:20:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Mingshuai <renmingshuai@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        jirislaby@kernel.org, caowangbao@huawei.com, yanan@huawei.com,
        liaichun@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hso: Fix potential null pointer dereference
Message-ID: <2023110139-spearmint-throttle-ed90@gregkh>
References: <20231101133544.246961-1-renmingshuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101133544.246961-1-renmingshuai@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:35:44PM +0800, Ren Mingshuai wrote:
> Generally, the old always points to the address of a ktermios structure,
> so old is unlikely to be NULL. Still check it before dereference as
> elsewhere.

If it can not happen, there is no need to check it.  So unless you can
prove that this ever could happen, this change isn't needed, right?

thanks,

greg k-h
