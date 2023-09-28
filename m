Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407357B1D62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjI1NIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjI1NI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:08:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A611A3;
        Thu, 28 Sep 2023 06:08:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0066AC433C8;
        Thu, 28 Sep 2023 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695906507;
        bh=qy+wyMSB5TmeVH+efYDiQdI0EguHwwNVRxvyeIVS4JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7p7zQdgx7ZtQWi0Waxqc+ElvmOI25MTgUbOINvXkfyh8qXewlx4gkxRYaLed4bzR
         JBmknL7IeaRYpTCOsEYJH6t2Q5Pv9yfP5C/h5BUAyeLZr9otOsiBsyb7XGMtLqFnqi
         II5B11FXjEF1+mviE9cr09jhyrM6X4QRrVw6jHJg=
Date:   Thu, 28 Sep 2023 15:08:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1] misc: fastrpc: Clean buffers on remote invocation
 failures
Message-ID: <2023092814-aliens-sneezing-39eb@gregkh>
References: <1693464082-24095-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693464082-24095-1-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:11:22PM +0530, Ekansh Gupta wrote:
> With current design, buffers and dma handles are not freed in case
> of remote invocation failures returned from DSP. This could result
> in buffer leakings and dma handle pointing to wrong memory in the
> fastrpc kernel. Adding changes to clean buffers and dma handles
> even when remote invocation to DSP returns failures.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

What commit id does this fix?

thanks,

greg k-h
