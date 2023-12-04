Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B2803588
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbjLDNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbjLDNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:53:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1BD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:53:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81ACC433C8;
        Mon,  4 Dec 2023 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701697999;
        bh=esHuCLsnYzWLmm5Oa6L+Kmza70Ps3RCO18AT+iUJYoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7jPfNYoSehiFCVmvkeB3YWHBnjgSiFuETLq9dY1RH90k0MXl6dSB376aJQmxz/SJ
         QRqiBrCPDEv1NNNLFRdNyVkjtcdqEqUL/zpg/AxF++c9EonLkx58tZ+UvojQSP6YXE
         62SIy3Jbw8gCBjUohCYs20csnvEtT+ev3iQwuumVREZmjFQv/HL4+Z6/ikawOUcHaD
         JW0zXl6b3XoZFkJE+nF3JlC2xpaEMk9MhOOQFq4Dz0q2tgyz7G4hyemrsz9elc7pyY
         lVqrA/RCi1ut+Rh8FCFmoevezMjQhYb7V/4hj5lL35IcaU/LhMTlMSJYbRWuEnne3T
         MMAeJQzpMoK1A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rA9Ob-0003VA-1F;
        Mon, 04 Dec 2023 14:54:01 +0100
Date:   Mon, 4 Dec 2023 14:54:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH 2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
Message-ID: <ZW3Z-bQwlEoubDU2@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <20231204124736.132185-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204124736.132185-3-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:47:36PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Limit the speaker digital gains to 0dB so that the users will not damage them.
> Currently there is a limit in UCM, but this does not stop the user form
> changing the digital gains from command line. So limit this in driver
> which makes the speakers more safer without active speaker protection in
> place.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Works as intended:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Given the reason for why you are adding this, it seems you should have
added:

Cc: stable@vger.kernel.org	# 6.5

as well.

Johan
