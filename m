Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45C7F1D32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjKTTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKTTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:17:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BE9C;
        Mon, 20 Nov 2023 11:17:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E71EC433C7;
        Mon, 20 Nov 2023 19:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700507861;
        bh=Fv3vr/kjHZEqkRI4ksHx4P5zjJGxHwUUPir/TAi533Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fEBfi4g6aMCmWAdb2Ha0H+ETu17ancDylb3UWYuDj3mP/fVL04ZkTuODpjOY9dmTc
         qT1vogF3BLKKnIudo4134BmYWC4FP1zh1Mxo63GGhEJhHL4E2WiIteiXTXgWA3jslQ
         XKUsdycBb6RuEPwN23kvbx6nyLs0tUPTG2qL+AjwbN6jtTG110Ov/Y3AY4V5nCPsdD
         0KHvp08/K/uPKWBQD64y/vMzRGPA7+SZoF4qzGtZO04gHOYSzz0HEEayHMhxqHmLsY
         rFkhpGywtisTw6EfmcX3xmjlTbXaEraCIwK9dJh96ZEVrwr95shNKkTwCmxkIp6FM5
         PoSjEvghxZarA==
Date:   Mon, 20 Nov 2023 11:17:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
Message-ID: <20231120111739.31baf90a@kernel.org>
In-Reply-To: <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
        <1700402277-93750-6-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 21:57:55 +0800 Wen Gu wrote:
> According to virtual ISM support feature defined by SMCv2.1, GIDs of
> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
> long. So some adaptation work is required. And note that the GIDs of
> existing platform firmware ISM devices still remain 64-bits long.

sparse (C=1 build) complains:

net/smc/smc_clc.c:944:73: warning: incorrect type in argument 1 (different base types)
net/smc/smc_clc.c:944:73:    expected unsigned short [usertype] chid
net/smc/smc_clc.c:944:73:    got restricted __be16 [usertype] chid
-- 
pw-bot: cr
