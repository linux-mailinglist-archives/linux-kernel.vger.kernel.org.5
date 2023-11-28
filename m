Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10237FB9EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjK1MLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjK1MK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:10:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C0182;
        Tue, 28 Nov 2023 04:11:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso1702541f8f.3;
        Tue, 28 Nov 2023 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701173463; x=1701778263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HJdSIDCxSEvtc8ZvR5XfMxZE4GiAmSPMLyCTMUELYDk=;
        b=nolgIYQavzigaMj4HTRgH5sV2sj2W0EdROUq791Qhu5yaAMriEq+gjqCcE9oWWPr/S
         nyVrtNjU+1O9JoYHRBzpNpfkcS6xeeboTT6H50lSFIwgr0W5MriWG+CU3+PzYmULPWHb
         sc+t/OoUO9OshZrlME0T5eH6AcyH8/splDDF8Flvz+IwX4QTI986QR5bzjRyb0Br3Tij
         0m+3psKYk/w8J928kIp+C/pMpiOBvtYIWpkoc+g2+ytrY0gSv71o+piZr3hgDY1Xhuvr
         6TnFfJUrWqZzEQ+ChAanHXHFNHYo05zVRt3T9oP3MxoBppkH0O7C0N63UevSq4Kkwb2n
         aYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701173463; x=1701778263;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJdSIDCxSEvtc8ZvR5XfMxZE4GiAmSPMLyCTMUELYDk=;
        b=xVc1hg/GAh3a/f9hOMTanRsR66yhOVc7epELMuon0WAM1sVYw0Jblhy0sDimi9XZvT
         gPVqCXhpQtbRCGpvA/2GCiBWlIPvn+D0+ZUgQ0ZhOQEoAD4GbLZFRa8q4aCdGc5zKnmM
         1EFwwwZ7NHES/KYK84qP1jidSJN0MTyMvBgvj8WqEj/0ito3V2Yuz0xrfyrs4T3ygTH4
         /mkEfnGvkTi5JJeq+v4+6m3CQ2q2MROJFW817Byr5+6jgUjVQTSbGLpN3bHaML4I0Vuq
         q5OUl3uyRo+H9avWPr20G+gDCcpwzeyfEaRaZpzxhJBtqIgCBS6A2ipCoDCyGXYwHwyI
         Sskw==
X-Gm-Message-State: AOJu0YyCtlDSgmAtoAOjQGOppJSr92wQ2WYCz88c5rhjUnr1XPCrbv6F
        vrYkeERdsToq+73oFpWiuwY=
X-Google-Smtp-Source: AGHT+IGcuds64zZU5GSlQaktzAPSJ0XvT5T6vmTEYD7+PSEklEmXzr/hUvLxM0lcVF7awEmMamWYQQ==
X-Received: by 2002:adf:a49b:0:b0:32d:9395:dec6 with SMTP id g27-20020adfa49b000000b0032d9395dec6mr9246805wrb.67.1701173462996;
        Tue, 28 Nov 2023 04:11:02 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm13472891wru.67.2023.11.28.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:11:02 -0800 (PST)
Message-ID: <6565d8d6.5d0a0220.5f8f1.b9d7@mx.google.com>
X-Google-Original-Message-ID: <ZWXY1O0fHIS4tBo-@Ansuel-xps.>
Date:   Tue, 28 Nov 2023 13:11:00 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: phy: restructure
 __phy_write/read_mmd to helper and phydev user
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-3-ansuelsmth@gmail.com>
 <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:46:10AM +0100, Andrew Lunn wrote:
> On Mon, Nov 27, 2023 at 12:51:40AM +0100, Christian Marangi wrote:
> > Restructure phy_write_mmd and phy_read_mmd to implement generic helper
> > for direct mdiobus access for mmd and use these helper for phydev user.
> > 
> > This is needed in preparation of PHY package API that requires generic
> > access to the mdiobus and are deatched from phydev struct but instead
> > access them based on PHY package base_addr and offsets.
> 
> Why is this all going into the header file?
>

Was following the pattern done by phy_package_read/write.

Considering those API are not single function call... I wonder if those
should be moved in phy_core.c instead of static inline them in the
header.

What do you think?

-- 
	Ansuel
