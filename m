Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DF9811A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjLMQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:56:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE95D0;
        Wed, 13 Dec 2023 08:57:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso57653635e9.1;
        Wed, 13 Dec 2023 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486621; x=1703091421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JLUeO8RasjjEv0mzXbeiiGvfn5uMCTD81cey6FspQio=;
        b=SeB6goGaYshBeIVl2OO8F+KEGa+l5az9DO2xGaIFiaClHoRg8K1GjxnrRks5tj5xU/
         PRe9JSZw3wf6U2ZOYM4UiOET3q0HOM8prZhzKKsONfyCizY/cdlv8UD4725zwxI+/q54
         U382luIFyNz4gINu5myxDHQW+ZYq7f5V60lh/PlpfjmevmNx0Ko6mu8MmQDlXuFnoFmo
         vzpHQiPcVzwaQ+6PFVECFv/UL3U2rLweJ7N9afhQfDbHgKR0tQzowEZ153qvUITt3ULO
         tSRb4yM4V4yyufUoPXoqr+czJjP3X98oP6KOYt0EFwxHsg9R855hUxaBS90L/nSF3uLt
         JkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486621; x=1703091421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLUeO8RasjjEv0mzXbeiiGvfn5uMCTD81cey6FspQio=;
        b=VtdoOvIPDpZB9n+EyoYVYGNz8n3FwGeDqfZyzj5G0Nil3ZCLClq6S145XkcMXeG/n9
         n4nVJlHO+MqpyQZmCSEFXZgoeP+tP7qxxzmDTRkVunkM3y730e7TDEqIsf9RS+VmjMSk
         ZwNXBHOH4WOhm9WNuOaui+wcdC+euGrL5y3iGKiiy6fZmVyTgQLrbVHKFrC/yh7sA6Kx
         UyKY4TOmOCqm03R5iqMgvYd9OLdy3k3iz95TM3FTDcwljIDR9rdN4Rs3fbPJ/qdlPF4O
         CCmD1Gr0UvmlPoK1+O5qizyNSd3+87Y5SXFIuwWqLb49rEPOvDZGUQITf9vvhBj0FZKt
         ztlQ==
X-Gm-Message-State: AOJu0Yxvd3k9Ez1HCd0OYAYYwWivHImh0S+VmAFP3/KghZjukKnvBxu3
        T1gLrJHcqqFdSckmO/quuwE=
X-Google-Smtp-Source: AGHT+IGcmtUxAmDjpv4DrWiw5VjQKFXpMVncbj6W1AUjwFQUFIst586FioVsSJE8DsZlGB9wTikZug==
X-Received: by 2002:a05:600c:3d91:b0:40b:5e1d:83a7 with SMTP id bi17-20020a05600c3d9100b0040b5e1d83a7mr4675660wmb.59.1702486620642;
        Wed, 13 Dec 2023 08:57:00 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d48cd000000b0033609750752sm13426614wrs.8.2023.12.13.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:56:59 -0800 (PST)
Message-ID: <6579e25b.5d0a0220.2445e.1753@mx.google.com>
X-Google-Original-Message-ID: <ZXniWQmi_NOKmZ2n@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 17:56:57 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Golle <daniel@makrotopia.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: trigger: netdev: display only supported
 link speed attribute
References: <20231213150033.17057-1-ansuelsmth@gmail.com>
 <20231213163757.1d576bb7@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213163757.1d576bb7@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:37:57PM +0100, Marek Behún wrote:
> > +	/* Display only supported entry */
> > +	if (attr == &dev_attr_link_10.attr &&
> > +	    (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported_link_speed) ||
> > +	     test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported_link_speed)))
> > +		return attr->mode;
> > +
> > +	if (attr == &dev_attr_link_100.attr &&
> > +	    (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported_link_speed) ||
> > +	     test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported_link_speed)))
> > +		return attr->mode;
> > +
> > +	if (attr == &dev_attr_link_1000.attr &&
> > +	    (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported_link_speed) ||
> > +	     test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported_link_speed)))
> > +		return attr->mode;
> > +
> > +	if (attr == &dev_attr_link_2500.attr &&
> > +	    test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported_link_speed))
> > +		return attr->mode;
> > +
> > +	if (attr == &dev_attr_link_5000.attr &&
> > +	    test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported_link_speed))
> > +		return attr->mode;
> > +
> > +	if (attr == &dev_attr_link_10000.attr &&
> > +	    test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported_link_speed))
> > +		return attr->mode;
> 
> Why only the T modes? There are much more ethtool modes for these
> speeds, for example at least 5 modes for 1000 mbps speed:
>   1000baseT_Half
>   1000baseT_Full
>   1000baseKX_Full
>   1000baseX_Full
>   1000baseT1_Full
> 
> There are also 2 possible modes for 2500 mbps
>   2500baseT
>   2500baseX
> 
> Ditto for 10 mbps and 100 mbps.
> 
> So if you're doing this, why not do it properly?

My concern was filling the thing with all kind of modes and have an if
hell.

> 
> There is an aarray
>   static const struct phy_setting settings[]
> in
>   drivers/net/phy/phy-core.c
> and a function phy_speeds() which will tell you which speeds are
> supported for a given ethtool mode bitmap.
> 
> Or you can add another function there,
>   bool phy_speed_supported(unsigned long mask, unsigned int speed)
> and use that one.
> 

Ok this is very handy and just perfect for the task. Problem is that
adding a function makes this again a cross subsystem patch and
problematic to merge...

And having phy_speed_supported would make the function very heavy as the
settings struct needs to be parsed multiple times...

Still I see the settings struct doesn't provide a way to comunicate the
sum of all the modes. I already have a patch in mind for that (usual
enum define hell) but that is again cross subsystem thing...

I see phy declare a array of 50 element to have enough space for all the
link speed modes. Think I will have to do the same here and update
later to a better implementation.

-- 
	Ansuel
