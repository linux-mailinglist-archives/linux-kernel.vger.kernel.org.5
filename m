Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439FE779267
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHKPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8CF92;
        Fri, 11 Aug 2023 08:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B2265D9E;
        Fri, 11 Aug 2023 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BE5C433C7;
        Fri, 11 Aug 2023 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691766414;
        bh=x9/6qPE0ahOZQaLwoxBTxd9SGZCAAaS1X7FH7xekC3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhIDV5tX3UpkogZmDz/UGhXNsPdjLYb+TPRfoJGSDVHnMj0OSSKTRgqo5Sz/WexcW
         5riHcZC3CUSoEYzQ/ND0nGwbI9a15vMS4dsoNtKZlLYlCqvP4S/QaB8Gyx0TUjEGIH
         qXCuzKMJgRgeooMbfYMjmjXRdU+WkOcMt68UGi3ZSd3HVQcOt1kisx0wfnHWuN+ETC
         CXA9jtQl2ROSChDpN9etivDJOXX6whMQTSSSbdvRSPelaoAEFLLTOWLlCsN+MeE9Yy
         1cLX1KqNvI66C38ed1PPi2dEYv3sQwbtdsY8yV4aMowBoLjCxzWt0OVf6e3Fog/uo2
         BBoNafQT3v82w==
Date:   Fri, 11 Aug 2023 20:36:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] bus: mhi: host: remove unused-but-set parameter
Message-ID: <20230811150644.GB5296@thinkpad>
References: <20230811134547.3231160-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811134547.3231160-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:45:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang warns about a parameter that is decremented but never evaluated heere:
> 
> bus/mhi/host/main.c:803:13: error: parameter 'event_quota' set but not used [-Werror,-Wunused-but-set-parameter]
>                              u32 event_quota)
> 
> Remove the access to the variable to avoid that warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 74a75439c7130..dcf627b36e829 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -938,7 +938,6 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  				if (!mhi_chan->configured)
>  					break;
>  				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
> -				event_quota--;
>  			}
>  			break;
>  		default:
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
