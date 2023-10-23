Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51E67D3643
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJWMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjJWMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:19:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D42100;
        Mon, 23 Oct 2023 05:19:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507c5249d55so4531581e87.3;
        Mon, 23 Oct 2023 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698063569; x=1698668369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC8RwLIS4Bs9UmtzGsUr6haXBVTLzG1rlQGdy2RVoKc=;
        b=MLB4guL5Ok9MeBxJ7IYP4p1BgjeVbCXHf3qzUhkvi40cxz1tiQec1PNKeFz08zNhnj
         WneAi5dEh0qgX3ww9CKhzSCdfQ+nIczbCRxOe/lj33sHMESZ3iUpDZtArm36yqJKw8wu
         AOPRuVorHgV3FQd5RdVZBI+Kx9SzTNOas6DoHakVS5ew2gePYrNqosMF6uhFKuoKETbU
         9MYs7D9qODqnwU2lKSsNOSPD3EhLIXq8NgR/3iEB850QW5BTEWrpc0i7MAV+wm6B1Zul
         Gbo9CdjFFfM0DGuPwGeQmavPoPgwD6u0BQuS7sXTjLUjFLS5BRagQchfDU8lfNRcqpvR
         6zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698063569; x=1698668369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC8RwLIS4Bs9UmtzGsUr6haXBVTLzG1rlQGdy2RVoKc=;
        b=UsbEhv04lUqh1YVOr9fnas9Ovm6MMub4AxhdU6+fhKJ2ch31JoCN9CKuwkeDdfhAT2
         zG+S4zAPyU/TWy/HpZ7ETkg0Sk/EAVbg/Zq7LaEOpBz/PiEIU9fUMOAeqa55u3PSXsMg
         MFzrZd2Ws1dOE5m5fmQ34Gwqj8mv5vD2WrPsNyvso0xeKokRcsE9vonfbrfO6iCxKsxm
         SR6AuQEOKDKTuFnZ2Xckmvs5jtvdCyS+2ptplQVkDQHawtI8F20IjnBT3Bc/A4xqqZ1g
         TSA7CbwHTtuth/yprk3OxH7I4AORatcZ6mPLLkFGZGcZkX8ILyg++PEC9nYAGFzbtg3+
         tNeA==
X-Gm-Message-State: AOJu0YyXq/RibcADfQjj2rHGIomRmscc1Vz04z/27I1RCJ9C+4X3Bz44
        xXOn7EQm98Tm0y6hCuWiYe8=
X-Google-Smtp-Source: AGHT+IGrAMp9m07AaNF5yySpls8rzV1GziF9lQyjCrmxEg63X482fDQlepLc/J9jN4lWYyHD5mTZ9A==
X-Received: by 2002:a05:6512:4885:b0:503:35bb:1e74 with SMTP id eq5-20020a056512488500b0050335bb1e74mr5896731lfb.61.1698063568601;
        Mon, 23 Oct 2023 05:19:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm6146122edb.28.2023.10.23.05.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:19:27 -0700 (PDT)
Date:   Mon, 23 Oct 2023 15:19:24 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231023121924.udseyuy7t77dscwl@skbuf>
References: <20231020143759.eknrcfbztrc543mm@skbuf>
 <20231023072700.17060-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023072700.17060-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:27:00AM +0200, Ante Knezic wrote:
> As far as I am aware only the KSZ8863 and KSZ8873 have this property available,
> but the biggger issue might be in scaling this to port property as the register
> "Forward Invalid VID Frame and Host Mode" where the setting is applied is
> located under "Advanced Control Registers" section which is actually global at
> least looking from the switch point of view. Usually port properties are more
> applicable when registers in question are located under "Port Registers" section.
> This is somewhat similar to for example enabling the tail tag mode which is 
> again used only by the port 3 interface and is control from "Global Control 1"
> register.
> With this in mind - if you still believe we should move this to port dt 
> property, then should we forbid setting the property for any other port other 
> than port 3, and can/should this be enforced by the dt schema?

I have no doubt that RMII settings are port settings. Scaling up the implementation
to multiple ports on other switches doesn't mean that the DT binding shouldn't be
per port.

Anyway, the per-port access to a global switch setting is indeed a common theme
with the old Micrel switches. I once tried to introduce the concept of "wacky"
regmap regfields for that:
https://patchwork.kernel.org/project/netdevbpf/patch/20230316161250.3286055-3-vladimir.oltean@nxp.com/

but I don't have hardware to test and nobody who does picked up upon the regfield
idea, it seems.
