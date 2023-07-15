Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A2F754857
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGOLDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 07:03:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76C26AF;
        Sat, 15 Jul 2023 04:03:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687466137bso1959870b3a.0;
        Sat, 15 Jul 2023 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689418992; x=1692010992;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24wxBr9RJX3pgI/ht36f2xCi5Ssby9GZkRBl17Qpdd4=;
        b=KbTMjOO08/oKB7Q+ynBDiQsvYeXJnc6a+SMiW0p1tRA+hPacBKwm/PyF1tdCWrDrON
         MiQZpz2nuZrlWtmSD85bMWXiHpupkwB4w3kDxiTPbVRtQGGO/vXUGi2bi5URxe98f9kU
         vgX9Ep6lDx/uhpJ7NaJO/vuPKX8AharQxvdVLX2/H6mveHKGIvd1Lp9QLcKhbOG2suf0
         wi2ShFNFT9OylP7kJPuWvYqcevrJrWOsjgRdmB6hhEaYzgB9tvbrcrWxGQapXKZrQKMq
         6eIv6eRnKmRCICyz5W4Tt+uPIuqJ0FckPOggh3CiMXRwi09ILjU5shueDysIc410nE9o
         bqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689418992; x=1692010992;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24wxBr9RJX3pgI/ht36f2xCi5Ssby9GZkRBl17Qpdd4=;
        b=RjSEum0NA08BxOaZveiMh8HA1pWQ7rhcPQM49Y/1iLrWs+E16pNaHcZtBIkcRzGHU8
         vWY6g3WPS6Y7uR1xx1CQvom3Ck5uoL3RtlZvlBcJRnPEPvg++m/IUXKITIvmGSn9Af9l
         JAgrLKF+exwmdTo5L1o0T2gsWrTUcF+FmmnyjvdzeUI8eO7Rg9PYusBnHZrGhWCW1+oO
         P0mpiazrdbZ73UtYJN8vrZr2dQmxzhafgnz4Y2fl42hrGjdkUbjY447VBQXGOUXGnSAI
         7a0a8GlCP5pxPxhe0UiwgIbtCrrqXD9MGco2yZqWwlOig24n7DFVSMBhTbUbvvXC/fbT
         8mfg==
X-Gm-Message-State: ABy/qLZTGW0Q/qYUqDEfOhj50bMbxe7NTzTFJQDTSIk2bbFYsj5de4Ui
        /Tv2ueo87P34knOaLs+lb2fgjDEDcFKgJ01e
X-Google-Smtp-Source: APBJJlHnqrTPEPJ1628fEi4wMsVBH9Uvsg4Su67fpENCC/jmlluIs/KOBhLoD6++FAZB4xTlp6K04g==
X-Received: by 2002:a17:902:ee45:b0:1b8:5fb4:1c85 with SMTP id 5-20020a170902ee4500b001b85fb41c85mr5518120plo.16.1689418991928;
        Sat, 15 Jul 2023 04:03:11 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902b09000b001b8422f1000sm9249357plr.201.2023.07.15.04.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 04:03:11 -0700 (PDT)
Message-ID: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
Date:   Sat, 15 Jul 2023 18:03:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a stable-specific regression on Bugzilla [1]. Quoting from it:

> The backport commit to 5.15 branch:
> 9d4f84a15f9c9727bc07f59d9dafc89e65aadb34 "arm64: dts: imx8mp: Add snps,gfladj-refclk-lpm-sel quirk to USB nodes"  (from upstream commit 5c3d5ecf48ab06c709c012bf1e8f0c91e1fcd7ad)
> switched from "snps,dis-u2-freeclk-exists-quirk" to "snps,gfladj-refclk-lpm-sel-quirk".
> 
> The problem is that the gfladj-refclk-lpm-sel-quirk quirk is not implemented / backported to 5.15 branch.
> 
> This commit should be either reverted, or the commit introducing gfladj-refclk-lpm-sel-quirk needs to be merged to 5.15 kernel branch.
> 
> As a result of this patch, on Gateworks Venice GW7400 revB board the USB 3.x devices which are connected to the USB Type C port does not enumerate and the following errors are generated:
> 
> [   14.906302] xhci-hcd xhci-hcd.0.auto: Timeout while waiting for setup device command
> [   15.122383] usb 2-1: device not accepting address 2, error -62
> [   25.282195] xhci-hcd xhci-hcd.0.auto: Abort failed to stop command ring: -110
> [   25.297408] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
> [   25.305345] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
> [   25.311058] xhci-hcd xhci-hcd.0.auto: Timeout while waiting for stop endpoint command
> [   25.334361] usb usb2-port1: couldn't allocate usb_device
> 
> When the commit is reverted the USB 3.x drives works fine.

See Bugzilla for the full thread and attach dmesgs.

Anyway, I'm adding it to regzbot:

#regzbot introduced: 9d4f84a15f9c97 https://bugzilla.kernel.org/show_bug.cgi?id=217670
#regzbot title: regression in USB DWC3 driver due to missing gfladj-refclk-lpm-sel-quirk quirk

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217670

-- 
An old man doll... just what I always wanted! - Clara
