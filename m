Return-Path: <linux-kernel+bounces-26464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E582E14F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDCC1F22D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE01947A;
	Mon, 15 Jan 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha/0V3VV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EB17BAB;
	Mon, 15 Jan 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso10292602e87.2;
        Mon, 15 Jan 2024 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705349505; x=1705954305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIzPwYM/Ny8e0mdBUhsIkDn1Q1CyUA5R1cmNmiZYEMc=;
        b=Ha/0V3VVV6X7Mmic22cHDuJW4lhgiaUSLA5ACDtRwDfp3GIcSlDVq6qg/6mzLxD2T8
         0HYUqbW29EzTWZCPjvb8zxPHmPR6lJOj1T1lfFjWP85fNoE9LomnQy/tzJa09L3b9KOz
         SZNRTULn55PM35RC0SblyIHzKDt+JN26DJ5hvKaG1vPMlDAhWi6LrINF78L1xUeBgBfk
         +NiBOQJANyWiONQ3ttmwkRdOAQ8mLgoeTk3NB4IDxIgiArAxAtA+ZDfVSn2cg8mAw5g9
         1CfsjNgjR2pBkpvPA1/CrntIvAqKehxHrXHhXEGE1JkpFRrohAeeHbYGbmFZvPUFYFcK
         496Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705349505; x=1705954305;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIzPwYM/Ny8e0mdBUhsIkDn1Q1CyUA5R1cmNmiZYEMc=;
        b=IcTVpLb33yimSD2j2db92/n6+3buDpbywS0XYt0Su2RXYY2cHwm69BfLC7Y4q45duB
         wEdCmDcRHQOHpbeKnJnYdmgckEW+cnFLoFyUUa7d+8ea9s2/Gy2a7Nctnyu3Sw5xmHUL
         pEpOCCEqRSUQgNdLNzjLDUmHhbEZ1vAbwxs2ZbwQuS2m5YVD0kGCMHvSDbSP9k0/l6gr
         qh8rhT97SCT4mbXDQWNihu/tCttrp8E12sCk+BSJdlD660UEyHDnuFGZ0ZUPQWwTx6ZH
         2e0+R9Lx/88OyEBuo3gdnO8bbrObbKjS4VKERnOWeUCNLsL3qTlFcSKlLcW0Tuz4hfEx
         Ap5Q==
X-Gm-Message-State: AOJu0Ywy3x9hMJlcLzukEkp+WfowvBf6L2JWZF121ZnjcDGcFDOJCHTY
	l92Ja5+o9GgRD6z3S5miGEg=
X-Google-Smtp-Source: AGHT+IGOdhTcDmH/j5CzVjjXx9n1gHAiS/+bh0UAaYWK4Uyrbcp985c8qH3vB39trmISFgq0UB07eA==
X-Received: by 2002:a05:6512:3a91:b0:50e:fa02:2f8d with SMTP id q17-20020a0565123a9100b0050efa022f8dmr1143726lfu.62.1705349504796;
        Mon, 15 Jan 2024 12:11:44 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:176c:f513:1187:6521? (2a02-a466-68ed-1-176c-f513-1187-6521.fixed6.kpn.net. [2a02:a466:68ed:1:176c:f513:1187:6521])
        by smtp.gmail.com with ESMTPSA id y3-20020ac24e63000000b0050e7e92d211sm1545416lfs.45.2024.01.15.12.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 12:11:44 -0800 (PST)
Message-ID: <8d8ee3be-3068-4a52-82d3-51678cd620c2@gmail.com>
Date: Mon, 15 Jan 2024 21:11:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror
 detachment
Content-Language: en-US
To: Richard Acayan <mailingradian@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231218164532.411125-2-mailingradian@gmail.com>
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20231218164532.411125-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Op 18-12-2023 om 17:45 schreef Richard Acayan:
> In 6.7-rc1, there was a netif_device_detach call added to the
> gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> the netif device and suppresses pings (ICMP messages) and TCP connection
> requests from the connected host. If userspace temporarily disconnects
> the gadget, such as by temporarily removing configuration in the gadget
> configfs interface, network activity should continue to be processed
> when the gadget is re-connected. Mirror the netif_device_detach call
> with a netif_device_attach call in gether_connect to fix re-connecting
> gadgets.
> 
> Link: https://gitlab.com/postmarketOS/pmaports/-/tree/6002e51b7090aeeb42947e0ca7ec22278d7227d0/main/postmarketos-base-ui/rootfs-usr-lib-NetworkManager-dispatcher.d-50-tethering.sh
> Fixes: f49449fbc21e ("usb: gadget: u_ether: Replace netif_stop_queue with netif_device_detach")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>   drivers/usb/gadget/function/u_ether.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 9d1c40c152d8..3c5a6f6ac341 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -1163,6 +1163,8 @@ struct net_device *gether_connect(struct gether *link)
>   		if (netif_running(dev->net))
>   			eth_start(dev, GFP_ATOMIC);
>   
> +		netif_device_attach(dev->net);
> +
>   	/* on error, disable any endpoints  */
>   	} else {
>   		(void) usb_ep_disable(link->out_ep);
This works mrfld (Intel Edison Arduino) using configfs with v6.7.0. 
Tested using `iperf3 -s` on mrfld,
iperf3 --bidir -c edison-usb
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   130 MBytes   109 Mbits/sec    0 
    sender
[  5][TX-C]   0.00-9.99   sec   129 MBytes   108 Mbits/sec 
    receiver
[  7][RX-C]   0.00-10.00  sec   167 MBytes   140 Mbits/sec    0 
    sender
[  7][RX-C]   0.00-9.99   sec   166 MBytes   139 Mbits/sec 
    receiver

and
iperf3 -c edison-usb
[  5]   0.00-10.00  sec   247 MBytes   207 Mbits/sec    0             sender
[  5]   0.00-9.99   sec   246 MBytes   206 Mbits/sec 
receiver


Tested-by: Ferry Toth <fntoth@gmail.com> [mrfld]

