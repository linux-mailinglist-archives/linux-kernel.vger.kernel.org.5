Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66A7F5E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKWLxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345126AbjKWLx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:53:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0F1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:53:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB92C433C9;
        Thu, 23 Nov 2023 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700740413;
        bh=g/xxUt9OQ1Xbt4EL/8qo6tjBYgOoMtRu6Y2H3RCsEtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bow/JHz0AWyZQMydFd3kvcnBkHRjgkGZmB89CI+9BMAQ7FiznLXuK3FVrW+afu6qp
         meyTRqjCcJnPJAzv2dIfgszGWP26395waSd7wh/7tlM+/iNu15erqqzng5G/bvce7i
         Tuz7gARZBIoL97n0F9TqdDHPZ9pq2K8Nn3bfCLu0=
Date:   Thu, 23 Nov 2023 11:53:20 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sound@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable-6.6 0/2] ASoC: codecs: wsa883x: fix pops and clicks
Message-ID: <2023112313-handlebar-handwash-b263@gregkh>
References: <20231123094749.20462-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123094749.20462-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:47:47AM +0100, Johan Hovold wrote:
> This is a backport of commits
> 
> 	0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> 
> which specifically fix a loud crackling noise when starting a stream on
> the Lenovo ThinkPad X13s.
> 
> These backports should apply to any stable tree which already has commit
> 3efcb471f871 ("ASoC: soc-pcm.c: Make sure DAI parameters cleared if the
> DAI becomes inactive") backported (e.g. 6.6.2 and 6.5.12).
> 
> Note that the interaction of these commits resulted in a bad merge in
> mainline which is fixed up here:
> 
> 	https://lore.kernel.org/lkml/20231123091815.21933-1-johan+linaro@kernel.org/

Thanks, now queued up.

greg k-h
