Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AC80DC80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjLKVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjLKVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:01:52 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA4F6BE;
        Mon, 11 Dec 2023 13:01:58 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1rCnPW-0007EJ-00; Mon, 11 Dec 2023 22:01:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 179B4C0A2B; Mon, 11 Dec 2023 21:56:42 +0100 (CET)
Date:   Mon, 11 Dec 2023 21:56:42 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP27: hubio: fix nasid kernel-doc warning
Message-ID: <ZXd3il10tu4yxWi+@alpha.franken.de>
References: <20231111030213.31595-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111030213.31595-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 07:02:13PM -0800, Randy Dunlap wrote:
> ip27-hubio.c:32: warning: Function parameter or member 'nasid' not described in 'hub_pio_map'
> ip27-hubio.c:32: warning: Excess function parameter 'hub' description in 'hub_pio_map'
> 
> Fixes: 4bf841ebf17a ("MIPS: SGI-IP27: get rid of compact node ids")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202311101336.BUL1JuvU-lkp@intel.com
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/sgi-ip27/ip27-hubio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
> --- a/arch/mips/sgi-ip27/ip27-hubio.c
> +++ b/arch/mips/sgi-ip27/ip27-hubio.c
> @@ -21,7 +21,7 @@ static int force_fire_and_forget = 1;
>  /**
>   * hub_pio_map	-  establish a HUB PIO mapping
>   *
> - * @hub:	hub to perform PIO mapping on
> + * @nasid:	nasid to perform PIO mapping on
>   * @widget:	widget ID to perform PIO mapping for
>   * @xtalk_addr: xtalk_address that needs to be mapped
>   * @size:	size of the PIO mapping

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
