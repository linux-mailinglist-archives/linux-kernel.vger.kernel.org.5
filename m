Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA17B1D53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjI1NGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjI1NGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:06:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5119D;
        Thu, 28 Sep 2023 06:05:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5CC433C7;
        Thu, 28 Sep 2023 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695906355;
        bh=TYCJvNXignKZxmUxck1gTDRPyQI43GHtmHRjMgZ7NAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od4I6nuTYSLiG8X1hMSzaGddUN3BCD49zWIzjGiGFkfPpTXuKkFGnhdhcub5fQmyA
         9jTdsbDW3CV51fYTlaEdJYMXyB8AHBpxMRs5rSUNA1SKKsuid2+ixqWcDlfWha9xkw
         2z6t0kCH4s6ZkaWzsaZjO/y9USTHjWMxmLsoA0Gs=
Date:   Thu, 28 Sep 2023 15:05:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1] misc: fastrpc: Free DMA handles for RPC calls with no
 arguments
Message-ID: <2023092833-daylong-gecko-eb0e@gregkh>
References: <1693463029-9311-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693463029-9311-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:53:49AM +0530, Ekansh Gupta wrote:
> The FDs for DMA handles to be freed is updated in fdlist by DSP over
> a remote call. This holds true even for remote calls with no
> arguments. To handle this, get_args and put_args are needed to
> be called for remote calls with no arguments also as fdlist
> is allocated in get_args and FDs updated in fdlist is freed
> in put_args.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

What commit id does this fix?  Or is this new functionality?

thanks,

greg k-h
