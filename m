Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420377B24A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjHNHYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjHNHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:24:05 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFCBBE71;
        Mon, 14 Aug 2023 00:24:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.81.81.211])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gw.red-soft.ru (Postfix) with ESMTPSA id 8E5233E0CA5;
        Mon, 14 Aug 2023 10:24:01 +0300 (MSK)
Date:   Mon, 14 Aug 2023 10:24:00 +0300
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] brcm80211: brcmsmac: phy_cmn: Remove unreachable code
Message-ID: <ZNnWkD5pCTAD7jTc@localhost.localdomain>
References: <20230813212343.245521-1-artem.chernyshev@red-soft.ru>
 <CAOiHx==NiPG2GdZNrJn5hPEdi70Spe9Kc9CHO5NjnATAjCgUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==NiPG2GdZNrJn5hPEdi70Spe9Kc9CHO5NjnATAjCgUsg@mail.gmail.com>
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 179214 [Aug 14 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/08/14 06:04:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/14 02:52:00 #21602132
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:19:14AM +0200, Jonas Gorski wrote:
> On Sun, 13 Aug 2023 at 23:31, Artem Chernyshev
> <artem.chernyshev@red-soft.ru> wrote:
> >
> > Since wlc_phy_txpwr_srom_read_nphy() in wlc_phy_attach_nphy()
> > can not return false it's impossible to get true value in this
> > if statement
> 
> If they can only return true, then maybe their return types should be
> changed to void as well? No point in returning a value when the only
> caller is ignoring it.
> 
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> 
> Regards,
> Jonas

True that. I'll make those changes in v2.

Thank you,
Artem
