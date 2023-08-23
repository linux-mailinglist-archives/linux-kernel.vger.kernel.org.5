Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5127859E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjHWN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjHWN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF57CEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5469362118
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F29C433C7;
        Wed, 23 Aug 2023 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692799093;
        bh=Zdj/CQUvNhqQqF/31Re5nB/bK10f0Wsxm66WwFiAdQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4gN8dgcZjPFTRxRmbUOZcHC3jTv6595R505EgCIsVsu64tv7iJ2P/RM/mF6t2d7X
         q+rpNCq9O9JSpvftgqK1ZhnymVt/1aKyW1nmVaxdG4V+WEQwXVQ5XCpdpatSIDTM1d
         Q7b5wSDu1urHsRqvwFDWNsv9JHC/9/gUu22Mp8dA=
Date:   Wed, 23 Aug 2023 15:58:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <2023082300-oxygen-stratus-4602@gregkh>
References: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 06:23:07PM +0530, Pavan Bobba wrote:
> 1.Conversion of formal argument names from camel case to snake case for below functions:
>       a.SROMvReadAllContents
>       b.SROMvReadEtherAddress
> 
> 2.Conversion of local variable names from camel case to snake case in function SROMvReadEtherAddress

When you list the different things you are doing, that usually means you
want multiple patches.  Would you want to review something that mixed
something like this together?

Also, please read the kernel documentation for how to write a good
changelog, and subject, this subject is identical to the one that you
were told to change and you agreed to :(

> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: encoding of type information in variable names dropped

You also forgot to actually cc: the maintainer that could take this
patch :(



>  
>  drivers/staging/vt6655/srom.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
> index ee5ca4db74dc..9c13ad089d78 100644
> --- a/drivers/staging/vt6655/srom.c
> +++ b/drivers/staging/vt6655/srom.c
> @@ -59,36 +59,36 @@
>  unsigned char SROMbyReadEmbedded(void __iomem *iobase,
>  				 unsigned char byContntOffset)
>  {
> -	unsigned short wDelay, wNoACK;
> -	unsigned char byWait;
> -	unsigned char byData;
> -	unsigned char byOrg;
> +	unsigned short delay, noack;
> +	unsigned char wait;
> +	unsigned char data;
> +	unsigned char org;
>  
> -	byData = 0xFF;
> -	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
> +	data = 0xFF;
> +	org = ioread8(iobase + MAC_REG_I2MCFG);
>  	/* turn off hardware retry for getting NACK */
> -	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
> -	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
> +	iowrite8(org & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
> +	for (noack = 0; noack < W_MAX_I2CRETRY; noack++) {
>  		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
>  		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
>  
>  		/* issue read command */
>  		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
>  		/* wait DONE be set */
> -		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
> -			byWait = ioread8(iobase + MAC_REG_I2MCSR);
> -			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
> +		for (delay = 0; delay < W_MAX_TIMEOUT; delay++) {
> +			wait = ioread8(iobase + MAC_REG_I2MCSR);
> +			if (wait & (I2MCSR_DONE | I2MCSR_NACK))
>  				break;
>  			udelay(CB_DELAY_LOOP_WAIT);
>  		}
> -		if ((wDelay < W_MAX_TIMEOUT) &&
> -		    (!(byWait & I2MCSR_NACK))) {
> +		if ((delay < W_MAX_TIMEOUT) &&
> +		    (!(wait & I2MCSR_NACK))) {
>  			break;
>  		}
>  	}
> -	byData = ioread8(iobase + MAC_REG_I2MDIPT);
> -	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
> -	return byData;
> +	data = ioread8(iobase + MAC_REG_I2MDIPT);
> +	iowrite8(org, iobase + MAC_REG_I2MCFG);
> +	return data;
>  }
>  
>  /*
> @@ -98,20 +98,20 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
>   *  In:
>   *      iobase          - I/O base address
>   *  Out:
> - *      pbyEepromRegs   - EEPROM content Buffer
> + *      eepromregs   - EEPROM content Buffer
>   *
>   * Return Value: none
>   *
>   */
> -void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
> +void SROMvReadAllContents(void __iomem *iobase, unsigned char *eepromregs)
>  {
>  	int     ii;
>  
>  	/* ii = Rom Address */
>  	for (ii = 0; ii < EEP_MAX_CONTEXT_SIZE; ii++) {
> -		*pbyEepromRegs = SROMbyReadEmbedded(iobase,
> +		*eepromregs = SROMbyReadEmbedded(iobase,
>  						    (unsigned char)ii);

You now have an alignment issue, right?  Did you run this through
checkpatch?

thanks,

greg k-h
