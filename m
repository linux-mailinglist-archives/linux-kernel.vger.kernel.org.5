Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A880C2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjLKIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjLKIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:07:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A84ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:07:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A6C433C8;
        Mon, 11 Dec 2023 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702282038;
        bh=3GqnJlLQgzJix4uleFQHfKZjGRQYL0QZLwm4aAsiEkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvVtjOw11aO9mExns9Vh/CwD0zBcHAhfP57vRwAHZ14s4oH5bglxziHG/3/I3exA6
         tsRvtOK/xvqi6pPrBTitdRhGV8G0D7ZBiwv/xzzAiJAjVBuo/vbAcrmErpzgolBFm5
         Rix3xhfcyefxA+rsQOzZZTGub0tRHg95c7VZ4eVK2/e61czbbjIdgtKFPc3GoWKtAv
         tgr7HK0Iz0FWjWAMv5POP32INgUXkUUVhbIRMYu3agqwbJ6AF7/2Qek5iYhDctqGi9
         eDsnDcOrS/WBiIj1nSAJhuhbi8wbfRMYKweSHXLDv4h0ck1NC8sB6DID59+SfoDfDp
         EwBG1iqaXiaSA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCbKd-00016z-2a;
        Mon, 11 Dec 2023 09:08:04 +0100
Date:   Mon, 11 Dec 2023 09:08:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Sasha,

On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Limit the speaker digital gains to 0dB so that the users will not damage them.
> Currently there is a limit in UCM, but this does not stop the user form
> changing the digital gains from command line. So limit this in driver
> which makes the speakers more safer without active speaker protection in
> place.
> 
> Apart from this there is also a range check fix in snd_soc_limit_volume
> to allow setting this limit correctly.
> 
> Tested on Lenovo X13s.
> 
> Srinivas Kandagatla (2):
>   ASoC: ops: add correct range check for limiting volume
>   ASoC: qcom: sc8280xp: Limit speaker digital volumes

These were unfortunately not marked for stable, but could you pick them
up for 6.6?

The upstream commits are:

	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")

>  sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
>  sound/soc/soc-ops.c       |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)

Johan
