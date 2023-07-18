Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43949757C09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGRMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGRMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:43:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597CD134
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:43:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5667073b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689684222; x=1692276222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gM/YgQOHeZ56BBUJtDtFJHEmngLOGV7x/3NVPgw+uwg=;
        b=w2hgTYFo0jHGi/AdVX7TD2uUbk+BXLb+ZG2Zdw4rHJpk2T64R7srvLTU1EecmWqOqS
         +2jICAWOFdA3n+NCVvYfHl0gbvmHFdN/TULrzU34DmJFhmBJ7HFP7kD5ELlciAE0SsxV
         kgKsVcvw9mNvmcXpwZJ5BsgmfldRJD4EnkdtvBbHkjY7R1wkzXZqohfr1f2V2t/auNvo
         uOLi0T3d6Ic7oVvvNRQKN86yHEsfxfjzgpmHSNnGOf0CgRVMHzyIXHqFgtUkPuw34m6B
         abB+AOkZ+UV4Q+lnWukzd73MYDLSmt8SFGtfUhAx+cIIkzHJHWVCM1nTKlaOQTXdZ+OC
         icaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684222; x=1692276222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gM/YgQOHeZ56BBUJtDtFJHEmngLOGV7x/3NVPgw+uwg=;
        b=PgqniAAkautx+kYlsbxt7gbLWv+GMM0pnVJh8MtoJTsSFrtLTZR3FWviloYlU8ej1S
         HlVLnu7tUddxXR8guHQ3gBDNAgLCcR4WjftPdCFZCYNblhIN/sPavTrJP2aqIK9N+46u
         6HFBDJS2Zf/n97mLu9BacFBcJMRGLTn0IrgiCanWHAkc8XFt9K581afo5g4ofto/kYnj
         3lqASHhXb8ix6znbHOvZR0pFxBYN8KZe+31r8En+1oYBKGs/yyrGKRaeLg9mAQJMGyip
         dtxzeO5S2W3u3wrZtPZj84rjfZZ+79P+4boXhQ5ghDwlxPcyPBl9Gn8lOadjLzSrZ1XC
         giOw==
X-Gm-Message-State: ABy/qLYYYFodyi268uqWxfeW0M9Z8RwnBMxXY5I+sxSj9aEiNqgvLAXa
        +xd+Wu/2QypN/KPAeMKNjtxZ
X-Google-Smtp-Source: APBJJlGIyCLi2xXMxJXvF91GTdpgYQEGsEVobhqGEnYYRfEsOVgBWaJGpPgU4Z2/dyfXjMaz88khfw==
X-Received: by 2002:a05:6a20:a121:b0:133:249f:2ce2 with SMTP id q33-20020a056a20a12100b00133249f2ce2mr18924689pzk.0.1689684221820;
        Tue, 18 Jul 2023 05:43:41 -0700 (PDT)
Received: from thinkpad ([117.217.191.149])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78395000000b0065434edd521sm1444932pfm.196.2023.07.18.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:43:41 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:13:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc:     mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] net: mhi : Add support to enable ethernet interface
Message-ID: <20230718124334.GG4771@thinkpad>
References: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:45:28AM +0530, Vivek Pernamitta wrote:
> Add support to enable ethernet interface for MHI SWIP channels.
> 

Please add more info in the commit message i.e., why this interface is added and
how it is going to benefit the users etc..

Since you are modifying the existing mhi_swip interface, this isn't an ABI
change?

> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> Reviewed-by: Daniele Palmas <dnlplm@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
> 
> changes since v1:
> 	- Moved to net-next from linux-next	
> 	- moved to eth_hw_addr_random() to assign Ethernet MAC address
> 	  from eth_random_addr()
> ---
>  drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index 3d322ac..5bb8d99 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c

[...]

> @@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
>  
>  static const struct mhi_device_info mhi_hwip0 = {
>  	.netname = "mhi_hwip%d",
> +	.ethernet_if = false,
>  };
>  
>  static const struct mhi_device_info mhi_swip0 = {
>  	.netname = "mhi_swip%d",
> +	.ethernet_if = false,

false?

- Mani

>  };
>  
>  static const struct mhi_device_id mhi_net_id_table[] = {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
