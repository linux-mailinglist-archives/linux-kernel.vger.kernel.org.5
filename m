Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432DC7B1D58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjI1NHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjI1NHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FC6F5;
        Thu, 28 Sep 2023 06:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD351C433C7;
        Thu, 28 Sep 2023 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695906435;
        bh=NfgEOxeSgPzf5YIzv2Gv1CuDr6cayB88kUGYz6CEoT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9qGQZtT27F4bLJfQGTzVRTpgQmwU0auqm5ddJJ36nLEvD0FbeO2NGSF5TGwafXOE
         sV013+2nOXvFmfxMEo0snHu0YZBCHArqkR8queAMk7R58itOnTWAV0ZtQwgHNJqnGr
         9slhvm07FAfJ7GRN7EavZ5hqZuF0JG/Jq2hrKcJg=
Date:   Thu, 28 Sep 2023 15:07:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        ekangupt@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v3 1/5] misc: fastrpc: Add fastrpc multimode invoke
 request support
Message-ID: <2023092840-rental-ascension-b062@gregkh>
References: <1695206827-29446-1-git-send-email-quic_ekangupt@quicinc.com>
 <1695206827-29446-2-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695206827-29446-2-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 04:17:03PM +0530, Ekansh Gupta wrote:
> Multimode invocation request is intended to support multiple
> different type of requests. This will include enhanced invoke
> request to support CRC check and performance counter enablement.
> This will also support few driver level user controllable
> mechanisms like usage of shared context banks, wakelock support,
> etc. This IOCTL is also added with the aim to support few
> new fastrpc features like DSP PD notification framework,
> DSP Signalling mechanism etc.

I can't see where you are properly checking the reserved fields in your
new ioctl structures, am I just missing that logic somewhere?

thanks,

greg k-h
