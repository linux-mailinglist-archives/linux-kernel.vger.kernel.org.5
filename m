Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6081C80CB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjLKNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbjLKNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:40:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730092
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:41:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03EC433C9;
        Mon, 11 Dec 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702302061;
        bh=nxM3m0fd/Qts426VUxaIvUcMjAL8BjhTWiFbn8gjtHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWISpyq8wNowbv0aYVcvdj3yFg7Rf4k6p1s8hhxK6NY7eiVikxtLg/N67DRry/c6+
         xCDto1x/dyxRE0i4mxYN1Kyh9Y2z8AtYz4/CsyfjqJ2ltyisaobLefFGXmNNWm7j3/
         U4r3banV4ANXrkdOJVgt7wqtT/0L9dgO0G01A4n0=
Date:   Mon, 11 Dec 2023 14:40:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH stable-6.6 0/2] ASoC: qcom: sc8280xp: Limit speaker
 digital volumes
Message-ID: <2023121154-mule-utter-98cf@gregkh>
References: <20231211132608.27861-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211132608.27861-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:26:06PM +0100, Johan Hovold wrote:
> This is a backport of the following series:
> 
> 	https://lore.kernel.org/lkml/20231204124736.132185-1-srinivas.kandagatla@linaro.org/
> 
> which did not build on 6.6 due a rename of the asoc_rtd_to_cpu()
> interface.
> 
> Johan
> 
> 
> Srinivas Kandagatla (2):
>   ASoC: ops: add correct range check for limiting volume
>   ASoC: qcom: sc8280xp: Limit speaker digital volumes
> 
>  sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
>  sound/soc/soc-ops.c       |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> -- 
> 2.41.0
> 
> 

Now queued up, thanks.

greg k-h
