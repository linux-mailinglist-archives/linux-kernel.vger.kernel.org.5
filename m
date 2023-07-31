Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33149769A91
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjGaPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGaPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B8DC3;
        Mon, 31 Jul 2023 08:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDA56117D;
        Mon, 31 Jul 2023 15:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30823C433C7;
        Mon, 31 Jul 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690816503;
        bh=5keNSLxbAMBNVUzPnc9yXlnPrWtWTm9LDLEqarPOUGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJGpfPsSiMpWXm+oOwcMbYkDidV4+2yH2/iWfgHMS5W4eebVSHfCEpjjnPszMSx6h
         0/ZkKeFjamuultpyWK8VxX+pod1LKTSZJqunKagN3mexdMIAGSLm/pfmGPn4N/QeC/
         gadXcWmjfurfS9GHnjjuLcP11vDuHGrHt2/jCYI8=
Date:   Mon, 31 Jul 2023 17:15:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] tty: synclink_gt: mark as BROKEN
Message-ID: <2023073131-service-observing-ad91@gregkh>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:59:55AM +0200, Jiri Slaby (SUSE) wrote:
> I did some cleanups in the driver (in this series), but then decided not
> to go on and mark the driver as BROKEN instead. See the last patch for
> explanation.
> 
> Feel free to take only the last patch. I don't assume anyone appears to
> take care of the driver, so we will drop it sooner or later anyway. The
> changes only demonstrate how unmaintained the driver is...

I'll take them all, thanks for them, as I don't want to waste the work
you did here.  We can schedule this for deletion in a few releases as I
doubt anyone will care :(

thanks,

greg k-h
