Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EEB76518F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjG0KqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjG0KqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:46:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECF122;
        Thu, 27 Jul 2023 03:46:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso8529885e9.2;
        Thu, 27 Jul 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690454766; x=1691059566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdmjQpiLc4ZmqDl3oE853D9MeV4yc+pdaIBR2PdGPbc=;
        b=fUp3mpm38j3vLb/RyzCVx8GuQ9XERRL8idRbt0k/B1qNKzwejtz4f0PsvY8/3mabre
         vyfo4kMGs8T0pDNUZZdynSLbdB1Ljnm4Kq0FKSC1G0D1K2o3CvLZNJT17SduzlRPAu+X
         nH+LxFNbvX3SDLAiqcZuLTOn5yYcnzn+rzZ/OTAehbzWJcXGJg70zSLDIr8LS6zB1/LM
         /kpcabfGstB9V/fBllu7UenoYqII08Kx5sv0gqECiw01fbzSlWeNHUiGSjHYBOOoUPPp
         vs1HpMHWbuH42i4YWgCDNxa0aSYswKwHqMRkh6hCXgoUrRD4QS6yItTj2XycjW4mlGAf
         9g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690454766; x=1691059566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdmjQpiLc4ZmqDl3oE853D9MeV4yc+pdaIBR2PdGPbc=;
        b=CRsjJ1YBn/mm14o/WHMoEUWvevTaNs2fQz0u+AjH7SBpOJ0XvWRNQPmsi/C2nwAkUY
         bEF/qfeHmpq00U/wQHjTHRpX9DGN0k+XIZjgy5rnB1o6n+5KNot8m4NE62AbFOGaBxKE
         lwTTsyc4ze1Nl5q8/DDf0f4JR/7J3OnfpzT4qDdrrpu4meeIwGISKnS4HD2tF5Unhyxg
         4C8ewrlZDjwa8C4O/dwIJYbM/DitNTR99N8yXdjetFtXCvrruprvfadFx53T/17z8+QW
         kuXkn+6GOUoeebbQTYSb0YVgqwSs2bIVbg0dTtyNOAcgoBhk4lXG+63x6zJ7NypVSDbG
         57lA==
X-Gm-Message-State: ABy/qLYkDe2mkEmlqcCxs438bVHfeUut7mJvHUwGue+CpCD5iFjPir30
        wtuyyUz5N8EGSFtdcyHX+C4=
X-Google-Smtp-Source: APBJJlHKZ5/pQi+YcSxjgRvTZA7OMGuSHcJ356ztIBkB8sq/joOHNqA/WnWFDnKHEIpfSGQxr4ogZQ==
X-Received: by 2002:a05:600c:b4d:b0:3fc:55b:9f6b with SMTP id k13-20020a05600c0b4d00b003fc055b9f6bmr1344035wmr.19.1690454765948;
        Thu, 27 Jul 2023 03:46:05 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003fbb346279dsm1467815wmh.38.2023.07.27.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 03:46:05 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:46:03 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230727104603.mqbnfrhri6riesrx@skbuf>
References: <20230727082550.15254-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727082550.15254-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:25:50AM +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
> V4 : Rework as suggested by Vladimir Oltean <olteanv@gmail.com>
>      and Russell King <linux@armlinux.org.uk>
>  * print error in case of failure to apply erratum
>  * use mdiobus_c45_write instead of mdiodev_c45_write
>  * use bool variable instead of embedding a chip pointer inside
>    pcs struct.
> V3 : Rework to fit the new phylink_pcs infrastructure
> V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch> 
>  * make int lanes[] const 
>  * reorder prod_nums
>  * update commit message to indicate we are dealing with
>    undocumented Marvell registers and magic values
> ---
>  drivers/net/dsa/mv88e6xxx/pcs-639x.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> index 98dd49dac421..ba373656bfe1 100644
> --- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> +++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
> @@ -20,6 +20,7 @@ struct mv88e639x_pcs {
>  	struct mdio_device mdio;
>  	struct phylink_pcs sgmii_pcs;
>  	struct phylink_pcs xg_pcs;
> +	bool erratum_3_14;
>  	bool supports_5g;
>  	phy_interface_t interface;
>  	unsigned int irq;
> @@ -205,13 +206,53 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
>  }
>  
> +static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
> +{
> +	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
> +		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
> +		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
> +		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
> +	int err, i;
> +
> +	/* 88e6190x and 88e6390x errata 3.14:
> +	 * After chip reset, SERDES reconfiguration or SERDES core
> +	 * Software Reset, the SERDES lanes may not be properly aligned
> +	 * resulting in CRC errors
> +	 */
> +
> +	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
> +		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
> +					MDIO_MMD_PHYXS,
> +					0xf054, 0x400C);
> +		if (err)
> +			return err;
> +
> +		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
> +					MDIO_MMD_PHYXS,
> +					0xf054, 0x4000);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
>  					   phy_interface_t interface)
>  {
>  	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
> +	int err;
>  
>  	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
>  
> +	if (mpcs->erratum_3_14) {
> +		err = mv88e6390_erratum_3_14(mpcs);
> +		if (err)
> +			dev_err(mpcs->mdio.dev.parent,
> +				"failed to apply erratum 3.14: %pe\n",
> +				ERR_PTR(err));
> +	}
> +
>  	return 0;
>  }
>  
> @@ -524,6 +565,10 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
>  	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
>  	mpcs->xg_pcs.neg_mode = true;
>  
> +	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
> +	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
> +		mpcs->erratum_3_14 = true;
> +
>  	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
>  	if (err)
>  		goto err_free;
> -- 
> 2.11.0
> 

It's good practice that, if you had a conversation with Russell on previous
versions of the patch, to keep him CCed on newer versions of it.
