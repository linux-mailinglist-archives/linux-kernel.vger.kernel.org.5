Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E29380BA9B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjLJMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjLJMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:10:20 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E473101
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:10:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf898c43cso3363566e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1702210223; x=1702815023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVZLGDwnFrSoZzbSshy6/E7v2T5vetFvtKyVzmesIKY=;
        b=gOYbznckZxS+4ftN5Y1dYYVfIRfXlnUpIYI8KAmuVayget4bJUKp1PPutfJyd0TVOL
         IZxA+q2p6pd4qcNSybfm2QjItYLKuCIaIGwxFt+1wKoVFdwWEUe7bur+kbzZrBbBZ5xU
         71jVTCV92Dhb7MXWE7lgMfqjZTQBZF1BEitx8TAMbesWveNGltyWOB1KXBvs1JHV0CKc
         UjfGvDEJ9GY5mBGBPqkjFvA8xghfw+OVKIoQxt8VJgu1aIpuCIb02DjAnmITGVltPcmQ
         VCSJjNme5CCko7VUc92MqXtZxZ+dQZo7yIUmFANtBJ7HjXYQ/+N02QPMtbL2EiiVB2Cl
         NPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702210223; x=1702815023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVZLGDwnFrSoZzbSshy6/E7v2T5vetFvtKyVzmesIKY=;
        b=g331xQAzM77NOtb4Tiw0QhpZhIBp9A++KLeBIePdw+0dvoD8rsBRJ4NbXxIjdN9VND
         pECCwRF9YrKjN9zLIRB7S2ecyEXxAL/tOd3GaxtTKlFILXmnN7OAZlqEhzPauRbncRU6
         zE67cqTSgSgtAzTAVhioIjJHU8FOwr3YhY8d5ZsXYp8Ak5jL0A+0cjVgxnmlBCroB6va
         /6jSdhG/hvgAzF/Jwkmiax+0RTu+TuECkMRMt/46QSNexLaGnj5QASkuXUd6vJTC7Azw
         9YS0BB2/aFbd8H+QBeYGUg41fc4NK1ELfdWjt/K8momWit3OfXuEkqETwrkNb7fPUyii
         Jhnw==
X-Gm-Message-State: AOJu0YxSBvawKGNSLcLj5Wpj6kD2Waw+oWgwUhFr9qNRt+UohR4Y3Ckn
        iaJ2JAIcbigJ0trOnhrDzjpLQg==
X-Google-Smtp-Source: AGHT+IFB80l7EyfYVJx9mjj/NoIh9j2du4/mUd4EDhNv2r6WZu64qOIGdc7jpotjPNfe3Po0CpR7vQ==
X-Received: by 2002:ac2:598d:0:b0:50b:fdc5:dec5 with SMTP id w13-20020ac2598d000000b0050bfdc5dec5mr627566lfn.75.1702210223371;
        Sun, 10 Dec 2023 04:10:23 -0800 (PST)
Received: from builder (c83-248-56-68.bredband.tele2.se. [83.248.56.68])
        by smtp.gmail.com with ESMTPSA id t23-20020ac24c17000000b0050bed700f5esm792527lfq.91.2023.12.10.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 04:10:22 -0800 (PST)
Date:   Sun, 10 Dec 2023 13:10:20 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <ZXWqrPkaJD2i5g-d@builder>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
 <ZWS2GYBGGZg2MS0d@debian>
 <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:03:54PM +0100, Andrew Lunn wrote:
> > * 3-4 nodes (depending on how many usb ports and dongles I have)
> > * run iperf with long cables and CSMA/CD
> > * run iperf with long cables and CMSA/No CD
> > 
> > I'll report back the results. Anything you'd like to add/focus on with
> > evaluation?
> 
> Humm, thinking about how CSMA/CD works...
> 
> Maybe look at what counters the MAC provides. Does it have collisions
> and bad FCS? A collision should result in a bad FCS, if you are not
> using CD. So if things are working correctly, the count for CD should
> move to FCS if you turn CD off. If CD is falsely triggering, FCS as a
> % should not really change, but you probably get more frames over the
> link?
> 

# setup

Andrew suggested that I try to get statistics from the MAC, I did some
investigation here but could not figure it out.

Using iperf3
Client: Arm based system running lan865x macphy 
Server: PC running lan867x revB usb dongle


# test results

The results below should be considered fairly represenative but far from
perfect. There was some bounce up and down when rerunning, but these resutls
are an eye-ball average.

No meaningful difference was seen with short (2m) cables or long (12m).

## with collision detection enabled

iperf3 normal
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  5.54 MBytes  4.65 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  5.40 MBytes  4.53 Mbits/sec                  receiver

iperf3 reverse
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   929 KBytes   761 Kbits/sec  293             sender
[  5]   0.00-10.00  sec   830 KBytes   680 Kbits/sec                  receiver


## with collision detection disabled

iperf3 normal
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  6.39 MBytes  5.36 Mbits/sec    0             sender
[  5]   0.00-10.04  sec  6.19 MBytes  5.17 Mbits/sec                  receiver

iperf3 reverse
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.27  sec  1.10 MBytes   897 Kbits/sec  268             sender
[  5]   0.00-10.00  sec  1.01 MBytes   843 Kbits/sec                  receiver

# Conclusions

The arm system running the lan865x macphy uses a not yet mainlined driver, see
https://lore.kernel.org/all/20231023154649.45931-1-Parthiban.Veerasooran@microchip.com/

The lan865x driver crashed out every once in a while on reverse mode, there
is definetly something biased in the driver for tx over rx.
Then again it's not accepted yet.

Disabling collision detection seemes to have an positive effect.
Slightly higher speeds and slightly fewer retransmissions.

I don't have a black and white result to present, but things seems to work
slightly better with CD disabled, so I'm leaning towards just unconditionally 
disabling it for the lan865x and lan867x phys for the v2 patch.

I'll wait with submitting v2 for a day so anyone interested gets a
chance to weigh in on this.

R
