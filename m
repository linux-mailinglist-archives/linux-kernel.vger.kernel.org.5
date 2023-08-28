Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0F78AE28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjH1K5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjH1K4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74EC2723;
        Mon, 28 Aug 2023 03:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59A661BFA;
        Mon, 28 Aug 2023 10:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A6EC433C8;
        Mon, 28 Aug 2023 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693220142;
        bh=oDzwoDE9xRqhbl1GhBeNUokhC//efLDV52EdLY/Fx90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLwV11v3sjKCXzsBvLOXv2TsXAvVvY/fAl71fbUVfuYY4yhZ64mCNfWleBcDXBpmS
         bucZeZjBVvpw3mKxsHMwOkVWyu/Eiz4RZGZaw3eEWoDH5TgPqCwPTBvh66OyqJIfLs
         SXuYOVW7D9dtXO9keFSGdl4dGMZyoaBZIZw7asuo=
Date:   Mon, 28 Aug 2023 12:52:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andras Sebok <sebokandris2009@gmail.com>
Cc:     linux-serial@vger.kernel.org, andriseseboke@gmail.com,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH 2/2] Add disabled text to indicate inactive commands in
 sysrq help menu
Message-ID: <2023082854-cylinder-putdown-6a54@gregkh>
References: <20230828102753.4811-2-sebokandris2009@gmail.com>
 <20230828102753.4811-5-sebokandris2009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828102753.4811-5-sebokandris2009@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:27:56PM +0200, Andras Sebok wrote:
> This patch adds disabled text after disabled commands in sysrq help.
> 
> before:
> sak : k
> 
> after:
> sak : k (disabled)

No need to tease people about options they can not use :(

sorry,

greg k-h
