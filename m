Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5623A807736
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442755AbjLFSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbjLFSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:01:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B7F122;
        Wed,  6 Dec 2023 10:01:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so2423019a12.1;
        Wed, 06 Dec 2023 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885694; x=1702490494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uakw0xbIjx7LFKm73fUVJEIp419SfbRyT/FiQAyMveE=;
        b=hcMU5fKvoOU+VIXeOZ4LhcBH/mR0pgpY9OzgVOhhpWZwfH1jylaD1TYyRqzJ7ZU7I8
         AaogpzmHddsos4hzBdjedmIRzumlES8O7c+XrMXnVoP7Pm2Xgfqrze17UjHgCzED9FvP
         WRfkVPJBa4LgLAOIkzG10IrNz7UOI5HbdG5wOqZ7lHchSjOx/ESax3Hh8PybQBKTGeqV
         Q9+o2pxTlYaw0ESHB9avS02WmMxtZEjHu+UAIci/YXukN2dQP/EQwNnEaRzUTktFOyOV
         IsCGUKeZ65QmK2SdeXx/o0NBHeEk5fpKDv4XkHJ3br+iI1aKE/2ZTxBIXVRy7S96yhVa
         Qhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885694; x=1702490494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uakw0xbIjx7LFKm73fUVJEIp419SfbRyT/FiQAyMveE=;
        b=HzKHgUxJdeVnLC43X08ugicf/nauI1EE20Ngx3cyoUNvR1p2prkW8kDDe3e73xJVmg
         MZemedXB2C3ol0obTnQmnff34/gaKA5Se1ItFqOf11Yjok+OliORzxEi2pVoYkmfVlgZ
         IcYCMBu3WLgbo99pNnpzO51wDQUUdU7VNNqwbSxbcAE2MThlTnEBWcPaTaRJB9itjV4e
         kxRcfvlKIqgyiPthUizb/2O24HfQgGFYeFeyk+7kQHe4u5iQcAzlXsD6f1BX3Tvxs4Ss
         f1XciJE+Fnh2jVdkNJQsADt+oSwuo5clYek0kcFLD13N6mEC0dfrZtgDBtbPm7A1j5hM
         4Ifg==
X-Gm-Message-State: AOJu0YxSPDBkhRo/91BEy4cIiMnhevBUNQ8ujWH/YWgrLgOxSyGEMxUc
        1Tpo3JdykBgU7PNwnQkVJHM=
X-Google-Smtp-Source: AGHT+IE7/6aN+mvH6ma4z5ujZMBMtBcU/LCSPM0CjFNej2u1lk1K8sqvvGWuIM2ToQiYzGt/stCpog==
X-Received: by 2002:a17:906:c292:b0:a1b:75f6:165c with SMTP id r18-20020a170906c29200b00a1b75f6165cmr3602583ejz.52.1701885693921;
        Wed, 06 Dec 2023 10:01:33 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id kx2-20020a170907774200b00a1da2f7c1d8sm239570ejc.77.2023.12.06.10.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:01:33 -0800 (PST)
Date:   Wed, 6 Dec 2023 20:01:31 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Madhuri.Sripada@microchip.com, Woojung.Huh@microchip.com,
        UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Arun.Ramadoss@microchip.com, ceggers@arri.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid
 protocols for xmit handler
Message-ID: <20231206180131.6uy3c3nazjaok2yl@skbuf>
References: <20231206071655.1626479-1-sean@geanix.com>
 <DM6PR11MB4124D98726836442169C2C55E184A@DM6PR11MB4124.namprd11.prod.outlook.com>
 <20231206173543.ag7xb4vhcjknyiyv@skbuf>
 <2244A511-6F6F-4711-9BE0-30786B021AE5@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2244A511-6F6F-4711-9BE0-30786B021AE5@geanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 06:45:12PM +0100, Sean Nyekjaer wrote:
> > Don't just leave it there, also explain why.
> 
> Message to me?
> 
> /Sean

No, to Madhuri (as the To: field suggests).

In the Linux kernel it's not a good practice to put defensive checks
which don't have a logical justification, because other people end up
not knowing why they're there, and when they can be removed. Checking
for the tagging protocol gives a very clear indication and traceability
of why it is being done, on the other hand.

If the ds->tagger_data is NULL for a tagging protocol for which it was
expected it shouldn't be, and the DSA core still decides to call
ds->ops->connect_tag_protocol() anyway, this is a violation of the API
contract established with all drivers that use this mechanism. Papering
over a bug in the DSA core results in silent failures, which means that
any further behavior is unpredictable. So I'd very much prefer the
system to fail fast in case of a bug in the framework, so that it can be
reported and fixed. With rigorous testing, it will fail earlier than in
the production stage.

I only said "don't leave it there, also explain why" because I really
don't appreciate review comments spreading FUD, for which I'd have to
spend 20-30 minutes to explain why leaving out the NULL pointer checking
is, in fact, safe.

Of course, I am not excluding a not-yet-found bug either, but I am
strongly encouraging Madhuri to walk through the code path and point
it to us, and strongly discouraging lazy review comments. It's not fair
for me to reply to a 5 word sentence with a wall of text. So I replied
with a phrase of comparable length to the suggestion.
