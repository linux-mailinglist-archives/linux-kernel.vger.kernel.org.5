Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04E7FA4C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjK0PbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjK0Pas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:30:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6F1988
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:30:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a29c7eefso5700548e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701099036; x=1701703836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0nEvDUTA+VvuaYc5IvEcHoTln/14hfyXc63Vrf+U23o=;
        b=TdaqAdOHGHRUQIQ58Zzi1ivA/gkcWgUKlHkgv2qJRjAfz0y1u6k2xlua3CjJeQMnCN
         jAm7bQuvGMU5gTCbNwLI2n4XMuWJR6iHumE009SlERLd+8eI40jXcL4ZVd9jaD/yipbY
         A/7LEA+EHylsqz9MxCV7O/e0YKqelB7ktAHP93NJ9s8m/V2KawJpUj02pbqb8Fh6cxgB
         +iFVNha29qee0qGnEIOBhmtOR6rjVZwosdWjAqq8pGednvkjMGlZoLKoGGIlcGD3Ncs+
         JbfGSs0YlAgflFyd7TDU9yZH3SW3xTSVsK7YVfIxOabqry2641OjInXswVtmGnfLp6SV
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099036; x=1701703836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nEvDUTA+VvuaYc5IvEcHoTln/14hfyXc63Vrf+U23o=;
        b=jq3CAdoWFECeDvLyRiQxlCV3X8bXD1r/b4ypdVIY4f0EMLnCvggZomf8/EG0Y8/tsf
         J/1F8RFDIRxieWs59z3C7Df8Ie96kBKQz3F8+iPx673NkbZbhWAPDLlEXpWB6NWowaIn
         3LgGPzfbgzLCtzk3AmsY4DIaUTNIKe0HCzoduKcUr3D+MHG9ZH9S68ZZDna8Rh7GNuJv
         X3si7TAdCoGhnThGBFHIZ2MrS4rX+GfYPEKZg1eAbKMAAFqFHmGSRP4TjS7e+e32Quw3
         sO3bytNd1EmnRlotfz2cnAkE/CrXrW6ocrttEWP/Hscll4W8qc2LXwL4jAAQfFRToEYb
         suOw==
X-Gm-Message-State: AOJu0YwpMgBFDuhjRw0qpxE5FSjIc7s1HGCaQbKjGFgpJ3Mm2eV/+U0K
        8VGCVtdUbDUX4KSK2zB81rc9iA==
X-Google-Smtp-Source: AGHT+IFIdQDsSEv3RzXM31ZIHh3gafChRm3GIc3+5CtX1YMLD/gJ44pyECWYXqOtlO0mWzBletRSiA==
X-Received: by 2002:a05:6512:31ce:b0:50b:aedd:6d53 with SMTP id j14-20020a05651231ce00b0050baedd6d53mr4159551lfe.62.1701099036331;
        Mon, 27 Nov 2023 07:30:36 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id x5-20020a19f605000000b0050aa491e86esm1510684lfe.83.2023.11.27.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:30:35 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:30:33 +0100
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
Message-ID: <ZWS2GYBGGZg2MS0d@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 02:58:32PM +0100, Andrew Lunn wrote:
> > Collision detection
> > This has been tested on a setup where one ARM system with a LAN8650
> > mac-phy is daisy-chained to 8 mcus using lan8670 phys. Without the patch we
> > were limited to really short cables, about 1m per node, but we were
> > still getting a lot of connection drops.
> > With the patch we could increase the total cable length to at least 40M.
> 
> Did you do any testing of collision detection enabled, PLCA disabled?
> 

In our dev system we've only tested with PLCA enabled, bit too tricky
changing internals on the microcontrollers.
But I have a lot of usb eval dongles that I can test with.

> You say you think this is noise related. But the noise should be the
> same with or without PLCA. I'm just thinking maybe collision detection
> is just plain broken and should always be disabled?
> 

I don't have access to the equipment to measure noise or reflections,
I've looked at the link with an oscilloscope and it looked fine to me.
The reason I'm mentioning noise is just me parroting the datasheet, for
context I'll quote the footnote here

"No physical collisions will occur when all nodes in a mixing segment are properly
configured for PLCA operation. As a result, for improved performance in high noise
environments where false collisions may be detected leading to dropped packets, it is
recommended that the user write this bit to a ‘0’ to disable collision detection when PLCA
is enabled. When collision detection is disabled, the PLCA reconciliation sublayer will still
assert logical collisions to the MAC as part of normal operation."
LAN8650 datasheet 11.5.51

> I've not read much about T1S, but if we assume it is doing good old
> fashioned CSMA/CD, with short cables the CS bit works well and the CD
> is less important. CD was needed when you have 1000m cable, and you
> can fit 64 bytes on the 1000m cable. So always turning of CD might be
> appropriate.
> 
> 	Andrew

As you assume when PLCA is disabled the phy runs in CSMA/CD mode.

I'll do some tests with both PLCA and CD off/disabled. My thinking is that a
adequate test bench would look like

* 3-4 nodes (depending on how many usb ports and dongles I have)
* run iperf with long cables and CSMA/CD
* run iperf with long cables and CMSA/No CD

I'll report back the results. Anything you'd like to add/focus on with
evaluation?

Ramón
