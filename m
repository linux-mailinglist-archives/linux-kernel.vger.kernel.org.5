Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D879CBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjILJ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjILJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:29:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A720AA;
        Tue, 12 Sep 2023 02:29:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so5563323a12.1;
        Tue, 12 Sep 2023 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694510952; x=1695115752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSMVRpWVo+AScRBCa4aVAyCAGCT9RW5LD/2W0PB1Sww=;
        b=aLshgCO4zTAqOSf1aTbNxFKmCENT+AQ3QQwvmVEkBuHAcaUp5KivXAhX/rlca6Jm9O
         tE2ZzivHrGNfhZwL+OmYwo+1v3Hs1rHu62gB8haj+MH6qMN3MY08Ngzrn+q2h+TgfqmQ
         DRvg2eOyDiaffPGSYIRSOelyMCabMAM1eUtDiAoSGPN4dWbTY1UpCMPSxW2LdirNBLJz
         y5kKsKY9lx0zBlHneWIZLqMg0MHcivALdinFlqhNUseQZoakQ5vE4mFkKArV55FGr/Bo
         Hz3Hygoo4kFr6OZTqKTEqKThJsChl7h+MaF+fNqjF8pneS8ArMoAnBQ4d1JbZ09wujCJ
         ihqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510952; x=1695115752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSMVRpWVo+AScRBCa4aVAyCAGCT9RW5LD/2W0PB1Sww=;
        b=dtIRyfcJTgdzrYoM+EM43Q/Mq7hJth5OQZnMFGJGN8tjGSuwL3LCyG3eVNyfbQt+Nt
         ri5JS7KFYpiXAAm1yjNO5n0FHF6agxJGArtZvEBjrfHwkxll6DVSqEY3zp5DatzWX58N
         d/pIeafEw21r/H6YX19dCf2FZR9hfZoKHDoZ2As3ja+QrskQurgG4y6lQPuusezZz3ej
         aDnlhV9Z73Sta6bOv8tr6++jCi4awmgcUwvLb5j5Yf6rnXseIKwsbRlueMNl9eVOMCDz
         18+EdRpyrda+WhJjLAmhX5uMBl1gDQQvdYaNHlcC5C4a3m96h9ERSzwboATwjc7UUReT
         shlw==
X-Gm-Message-State: AOJu0YxGenIElGSrCM3PCbcyTqsRKvDgWmouxEN6PmCOCvZ6/MUA35kW
        OyYrhJyeMDDhyMFlEg8cq+4=
X-Google-Smtp-Source: AGHT+IEUHz0HFujs/1zfbaqG1lnAWE0fsRRg1JorSvF3zU7MZdiOFQnwYVvC/0GHl5ytqK60C5gI4Q==
X-Received: by 2002:aa7:c652:0:b0:523:2e23:a0bf with SMTP id z18-20020aa7c652000000b005232e23a0bfmr2707895edr.11.1694510952196;
        Tue, 12 Sep 2023 02:29:12 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402135600b0051e0be09297sm5709984edw.53.2023.09.12.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:29:11 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:29:09 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230912092909.4yj4b2b4xrhzdztu@skbuf>
References: <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230912101748.0ca4eec8@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912101748.0ca4eec8@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:17:48AM +0200, Lukasz Majewski wrote:
> IMHO, somebody who will use HSR will not fiddle with mac addresses of
> LAN1 and ETH0. It will be setup by savvy user once at boot up.

The point is, it has to work in all configurations that are accepted by
the kernel.

> Please correct me if I'm wrong, but the above issue (with lack of sync
> of mac address change in DSA master and its ports) seems to be
> affecting HSR support in a minimal way (when considering the above).

It's a different (and very old) bug for sure. But it has impact upon the
v4 patch set as you've presented it here.

> If I may ask - what is your suggestion to have the HSR join feature
> merged for KSZ9477 SoC ?

Anything that makes sense and works is worth considering.

For example, one can argue that since we already have this pattern in 2
places in net/dsa/slave.c:

	/* If the port doesn't have its own MAC address and relies on the DSA
	 * master's one, inherit it again from the new DSA master.
	 */
	if (is_zero_ether_addr(dp->mac))
		eth_hw_addr_inherit(dev, master);

then the consistent way to react to NETDEV_CHANGEADDR events on the
master is to change the user ports' MAC address yet again, to track the
master.

In any case, as long as it's the DSA master's address that we program to
hardware, then I see it as inevitable to add a new struct dsa_switch_ops ::
master_addr_change() function, similar to master_state_change(). The driver
would always be notified of the current (even initial) MAC address, and
it could update the hardware registers (for WoL, pause frames and HSR
self-address filtering, in this case).

The above 2 changes could be one way to ensure that if a HSR device was
accepted for offload initially, it will remain in a configuration that
will keep working.


Or you can argue that dragging the DSA master into the discussion about
how we should program REG_SW_MAC_ADDR_0 is a complication. An API
internal to the microchip ksz driver could be added, where the user
ports on which the various specialty features are enabled (HSR, WoL)
take a reference on the REG_SW_MAC_ADDR_0 with their MAC address.
If the reference on REG_SW_MAC_ADDR_0 gets bumped from 0 to 1, the
hardware is programmed with the requesting port's MAC address. If the
reference is already elevated, then a request to increase it, coming
from another port, is accepted or denied, depending on whether the MAC
address of that port is equal to what's programmed into REG_SW_MAC_ADDR_0
or not. The refusal gets propagated to the user, together with an
informative extack message. The ports which hold a reference on
REG_SW_MAC_ADDR_0 cannot have their MAC address changed - and for this,
you'd have to add a hook to dsa_switch_ops (and thus to the driver) from
dsa_slave_set_mac_address().


So, there are some options to pick from.

> Will the above problem block the HSR offloading support mainlining,
> even when the self mac address filtering is one of four HW based
> features for this SoC?

I don't know, that depends on you.
