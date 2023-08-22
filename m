Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D378459D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbjHVPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbjHVPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:32:27 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B9CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WmUJXSDkMyGjwPx/wY0QvHdK0aaOVzwaTSboJPvOA2E=;
  b=TLJDyHQ+b5xuMGwbS2g7WqOJtrwNhLQBVR7UfFcecEb6OvEyUtX3VSpl
   XQ2YkJIHU596hufHLBLA2pJ8/6PWnZIXvv7HgFNtI3vBvGXD6rz+NhcMW
   Hv4PR+C6eglDRsocvFvrn55IlJYHSIPUewW+V71BEx0AUhesF1rJBRctN
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,193,1684792800"; 
   d="scan'208";a="122021685"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 17:32:14 +0200
Date:   Tue, 22 Aug 2023 17:32:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Pavan Bobba <opensource206@gmail.com>
cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: replace camel case by snake case
In-Reply-To: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
Message-ID: <81bcc492-ac10-d185-806e-412a7b1acef2@inria.fr>
References: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Aug 2023, Pavan Bobba wrote:

> Replace formal arguments of few functions and local variables of camel case by snake case.
> Issue found by checkpatch
>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/srom.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
> index ee5ca4db74dc..c0dd4ad25472 100644
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
> +	unsigned short wdelay, wnoack;
> +	unsigned char bywait;
> +	unsigned char bydata;
> +	unsigned char byorg;

This raises the same problem as in your previous patch.  Here there is w
for word, by for byte, and later there is p for pointer.  All of these
encodings of type information should be dropped.

julia

>
> -	byData = 0xFF;
> -	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
> +	bydata = 0xFF;
> +	byorg = ioread8(iobase + MAC_REG_I2MCFG);
>  	/* turn off hardware retry for getting NACK */
> -	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
> -	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
> +	iowrite8(byorg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
> +	for (wnoack = 0; wnoack < W_MAX_I2CRETRY; wnoack++) {
>  		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
>  		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
>
>  		/* issue read command */
>  		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
>  		/* wait DONE be set */
> -		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
> -			byWait = ioread8(iobase + MAC_REG_I2MCSR);
> -			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
> +		for (wdelay = 0; wdelay < W_MAX_TIMEOUT; wdelay++) {
> +			bywait = ioread8(iobase + MAC_REG_I2MCSR);
> +			if (bywait & (I2MCSR_DONE | I2MCSR_NACK))
>  				break;
>  			udelay(CB_DELAY_LOOP_WAIT);
>  		}
> -		if ((wDelay < W_MAX_TIMEOUT) &&
> -		    (!(byWait & I2MCSR_NACK))) {
> +		if ((wdelay < W_MAX_TIMEOUT) &&
> +		    (!(bywait & I2MCSR_NACK))) {
>  			break;
>  		}
>  	}
> -	byData = ioread8(iobase + MAC_REG_I2MDIPT);
> -	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
> -	return byData;
> +	bydata = ioread8(iobase + MAC_REG_I2MDIPT);
> +	iowrite8(byorg, iobase + MAC_REG_I2MCFG);
> +	return bydata;
>  }
>
>  /*
> @@ -98,20 +98,20 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
>   *  In:
>   *      iobase          - I/O base address
>   *  Out:
> - *      pbyEepromRegs   - EEPROM content Buffer
> + *      pbyeepromregs   - EEPROM content Buffer
>   *
>   * Return Value: none
>   *
>   */
> -void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
> +void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyeepromregs)
>  {
>  	int     ii;
>
>  	/* ii = Rom Address */
>  	for (ii = 0; ii < EEP_MAX_CONTEXT_SIZE; ii++) {
> -		*pbyEepromRegs = SROMbyReadEmbedded(iobase,
> +		*pbyeepromregs = SROMbyReadEmbedded(iobase,
>  						    (unsigned char)ii);
> -		pbyEepromRegs++;
> +		pbyeepromregs++;
>  	}
>  }
>
> @@ -122,19 +122,19 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
>   *  In:
>   *      iobase          - I/O base address
>   *  Out:
> - *      pbyEtherAddress - Ethernet Address buffer
> + *      pbyetheraddress - Ethernet Address buffer
>   *
>   * Return Value: none
>   *
>   */
>  void SROMvReadEtherAddress(void __iomem *iobase,
> -			   unsigned char *pbyEtherAddress)
> +			   unsigned char *pbyetheraddress)
>  {
>  	unsigned char ii;
>
>  	/* ii = Rom Address */
>  	for (ii = 0; ii < ETH_ALEN; ii++) {
> -		*pbyEtherAddress = SROMbyReadEmbedded(iobase, ii);
> -		pbyEtherAddress++;
> +		*pbyetheraddress = SROMbyReadEmbedded(iobase, ii);
> +		pbyetheraddress++;
>  	}
>  }
> --
> 2.34.1
>
>
>
