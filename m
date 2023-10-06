Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2827BB91E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjJFNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJFNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:32:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915EC9E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E8DC433C9;
        Fri,  6 Oct 2023 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696599151;
        bh=J16OmmTjaecD4/PoAb2njb0cPL7n3/wpyLjeH1OTmF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfACQxOSn0ThLhWzxysG4qT3xfyk5N28YD/GUdEZGrH+DnjqnmDbXLfuwYFJ0SHSF
         x0CT9fg0xQ9W4z69hskfC9aBKTYSqA3rqDDTRZT6IFJ41/QyBSCJSBicNyta1Vh+Gl
         beWSpTPc0slJeOOEcaZ3DCNcaDTrWwKGDNtAmzbE=
Date:   Fri, 6 Oct 2023 15:32:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        coiby.xu@gmail.com, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <2023100657-purge-wasting-621c@gregkh>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> Avoid read overflows and other misbehavior due to missing termination.

As Dan said, this is not possible here.  Can you redo the changelog text
and resend it so that people aren't scared by the text?

thanks,

greg k-h
