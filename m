Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70497E1112
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKDVCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjKDVBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2787BD66;
        Sat,  4 Nov 2023 14:01:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A247C433C7;
        Sat,  4 Nov 2023 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699131703;
        bh=+7byfA4Ppk8N0k1bYP3EJZinN4mfeQq879uiQ9hGw84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yvbs/6PjuCp11yK49p0WYF++z2pGVaebkm3vOm2YVUF89Vjs8LcU5FDCX6TYHJxbL
         UmyN9plXwI8cLdG+YqSuTZ42Evt+zG3M8RUPpBRwtf5g/xEQ+iB10zYjE1op4a2vsh
         NJeZFUWLDtzuU3wuhjwEp48rgZRnKMgNPnNoGLY7ZfCm0Z6Y85M04MZJJzmlz/AdAo
         AOOGONMhnMB8TyqDLmtz7qGBTlGeHMXMA0HIKSVyWHGxvejLaycwWs/K28C2doM0ag
         xrBa0DaJsm0cHB1m6zyY7khisnc1nL8ox65kSEAyTzM6qMZ7x6hl9jDciPziZ24WxB
         aEpCd4JJQnjPg==
Date:   Sat, 4 Nov 2023 17:01:42 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, sre@kernel.org,
        Shyam-sundar.S-k@amd.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Backport of commit "power: supply: core: Use
 blocking_notifier_call_chain to avoid RCU complaint")
Message-ID: <ZUaxNuhxWabM6zx4@sashalap>
References: <20230913033233.602986-1-kai.heng.feng@canonical.com>
 <ff242a4c-8c84-485f-a100-0317eaa1544b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff242a4c-8c84-485f-a100-0317eaa1544b@t-8ch.de>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:33:45PM +0100, Thomas Weißschuh wrote:
>Dear stable team,
>
>I would like to propose the commit
>bbaa6ffa5b6c ("power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint")
>from mainline for inclusion into the stable kernels.
>
>The commit fixes a RCU violation as indicated in its commit message.

Queued up, thanks!

-- 
Thanks,
Sasha
