Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170A37B1D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjI1NIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjI1NIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:08:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A819C;
        Thu, 28 Sep 2023 06:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582FDC433C8;
        Thu, 28 Sep 2023 13:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695906496;
        bh=FgvrFkLj5yALBmEOjNK1KfhRZZ+9X76BFIOyFCpvUuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Izb656/IaNyoP69KH2Jadd3UbLfQ6FgPWbsbXin0u85ElT4sCrhpAguqFkYo7ICcY
         eKcKjc3AORwEnGZf+kyhQfyh4pICyZ0yb+QJhpqRz0yRXR+hou8eojCnqWqNTr68KG
         E8c6+NL5lN89WUQLCfvqpK8ZK+2Dhmobfq03r9Wk=
Date:   Thu, 28 Sep 2023 15:08:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1] misc: fastrpc: Reset metadata buffer to avoid
 incorrect free
Message-ID: <2023092840-balmy-proved-e337@gregkh>
References: <1693463723-16937-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693463723-16937-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:05:23PM +0530, Ekansh Gupta wrote:
> Metadata buffer is allocated during get_args for any remote call.
> This buffer carries buffers, fdlists and other payload information
> for the call. If the buffer is not reset, put_args might find some
> garbage FDs in the fdlist which might have an existing mapping in
> the list. This could result in improper freeing of FD map when DSP
> might still be using the buffer. Added change to reset the metadata
> buffer after allocation.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

What commit id does this fix?

And you sent 3 patches, but not in a list, what order are they to be
applied in?

thanks,

greg k-h
