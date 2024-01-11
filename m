Return-Path: <linux-kernel+bounces-23521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04B82ADF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF5A1C226A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D4156D9;
	Thu, 11 Jan 2024 11:52:04 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335EF156CE;
	Thu, 11 Jan 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rNtbD-0005Y7-00; Thu, 11 Jan 2024 12:51:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6E9BCC0497; Thu, 11 Jan 2024 12:51:38 +0100 (CET)
Date: Thu, 11 Jan 2024 12:51:38 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: vkoul@kernel.org, jiaheng.fan@nxp.com, peng.ma@nxp.com,
	wen.he_1@nxp.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: Alchemy: Fix an out-of-bound access in
 db1550_dev_setup()
Message-ID: <ZZ/WSt6IBkzepcUy@alpha.franken.de>
References: <8069c4aa2328555cceded66d7dc4e5332a6299ae.1704910173.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8069c4aa2328555cceded66d7dc4e5332a6299ae.1704910173.git.christophe.jaillet@wanadoo.fr>

On Wed, Jan 10, 2024 at 07:09:46PM +0100, Christophe JAILLET wrote:
> When calling spi_register_board_info(),
> 
> Fixes: f869d42e580f ("MIPS: Alchemy: Improved DB1550 support, with audio and serial busses.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/mips/alchemy/devboards/db1550.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
> index fd91d9c9a252..6c6837181f55 100644
> --- a/arch/mips/alchemy/devboards/db1550.c
> +++ b/arch/mips/alchemy/devboards/db1550.c
> @@ -589,7 +589,7 @@ int __init db1550_dev_setup(void)
>  	i2c_register_board_info(0, db1550_i2c_devs,
>  				ARRAY_SIZE(db1550_i2c_devs));
>  	spi_register_board_info(db1550_spi_devs,
> -				ARRAY_SIZE(db1550_i2c_devs));
> +				ARRAY_SIZE(db1550_spi_devs));
>  
>  	c = clk_get(NULL, "psc0_intclk");
>  	if (!IS_ERR(c)) {
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

