Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960987D396E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJWOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:36:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C1DD;
        Mon, 23 Oct 2023 07:36:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256C7C433C7;
        Mon, 23 Oct 2023 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698071767;
        bh=PgA9yYa6/1qxru0Rwr8SOL4n9Sf+KY4AdlDhFZNeRMo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qQjhSgSZxVDSNrUricToBpOO3r3/9HPO9ePt28aLe38EMuSbiPvh0DhTtdiZt8DKb
         zccwbQRXYv7h1SjVPXd+UphUB4VILi6IE0ef/Jkpf14TinQSLXWHSeg1KNGKZlGKdO
         qUPTnR5EwpEQOYod9oelcttVvxy2u8hinktsyJNfh6eVdJ8aPD5hfQisqosvKojUQG
         s89phH1sbMPTAH5f61vmorwhTOeop64y9KNMHJEaAYKBLRVJ2+mAsiMTUv4cjo5tZH
         MD1WPybZUAYpoiJZgnv8d32NDcnx73frJGkJDJswEYZjFVVWqdMGI8b1ndc4MtJw14
         Op5z3rREu0YVA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geoff Levand <geoff@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 04/10] wifi: remove obsolete hostap driver
References: <20231023131953.2876682-1-arnd@kernel.org>
        <20231023131953.2876682-5-arnd@kernel.org>
Date:   Mon, 23 Oct 2023 17:36:00 +0300
In-Reply-To: <20231023131953.2876682-5-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 23 Oct 2023 15:19:46 +0200")
Message-ID: <87msw9z9rj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> HostAP is an ISA/PCMCIA style 802.11b driver supporting only
> wireless extensions, and some custom ioctls (already removed).
> Some devices include a legacy PCI bridge but no DMA.
>
> The driver was marked obsolete in 2016 and is highly unlikely
> to still have any users.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This patch didn't make it to the list, I guess it was too big. But it's
available from the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?h=pending&id=39ed2ce3bdc43bc9dbed65608d98828f21b9f33d

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
