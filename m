Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9E78586D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjHWM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjHWM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:59:34 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4100E5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1W9ssUea60J+pSvyJCVBbSbx44jAQJcv36rjM60pRZw=;
  b=mNVbsb89Ke7zWlggcrx74W4kIPzu7oEpVIoQuVnm86CU+uyFFGZGwsAZ
   M+kwP9mw3qQ7zzLqbUrpUFE595wK0/SlACEs3yzveCwH0YLt2JWrTUi9D
   VKrVyBkYSr56IDqBveyl2R5EJUF5Q2rFVCgq2Fum8JUT174j2JPO14UQr
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="64020145"
Received: from 98.66.136.77.rev.sfr.net (HELO hadrien) ([77.136.66.98])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 14:58:39 +0200
Date:   Wed, 23 Aug 2023 14:58:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Pavan Bobba <opensource206@gmail.com>
cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
In-Reply-To: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
Message-ID: <alpine.DEB.2.22.394.2308231457310.3210@hadrien>
References: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Aug 2023, Pavan Bobba wrote:

> 1.Conversion of formal argument names from camel case to snake case for below functions:
>       a.SROMvReadAllContents
>       b.SROMvReadEtherAddress
>
> 2.Conversion of local variable names from camel case to snake case in function SROMvReadEtherAddress
>
> Issue found by checkpatch
>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: encoding of type information in variable names dropped
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

Maybe the W_ should also be dropped?

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

Here you could add some spaces to get the - EEPROM to line up with the
rest.  Likewise later.

julia

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
> -		pbyEepromRegs++;
> +		eepromregs++;
>  	}
>  }
>
> @@ -122,19 +122,19 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
>   *  In:
>   *      iobase          - I/O base address
>   *  Out:
> - *      pbyEtherAddress - Ethernet Address buffer
> + *      etheraddress - Ethernet Address buffer
>   *
>   * Return Value: none
>   *
>   */
>  void SROMvReadEtherAddress(void __iomem *iobase,
> -			   unsigned char *pbyEtherAddress)
> +			   unsigned char *etheraddress)
>  {
>  	unsigned char ii;
>
>  	/* ii = Rom Address */
>  	for (ii = 0; ii < ETH_ALEN; ii++) {
> -		*pbyEtherAddress = SROMbyReadEmbedded(iobase, ii);
> -		pbyEtherAddress++;
> +		*etheraddress = SROMbyReadEmbedded(iobase, ii);
> +		etheraddress++;
>  	}
>  }
> --
> 2.34.1
>
>
>
