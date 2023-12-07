Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7454B808476
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjLGJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLGJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:01:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521B19A;
        Thu,  7 Dec 2023 01:01:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so8336185e9.1;
        Thu, 07 Dec 2023 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939672; x=1702544472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKsrC2p/dEstQQ0QtE5+II/Axy3OGpRA/lKlIyxGMfU=;
        b=P50b6a6EiNqeI3saTqQWSxr8707DjD2giXkYr68M+X82gzEw6GkQpFAX0ywwVXeBkA
         M5JnIPlJHaE6tNi4aw+aGcR3CL5r1C6WQuba7XP3E0FXv4v5OzgEgBdN+8fe7QNW92Pb
         N88C5lpd4xdCVWbC4NngSRSxj3dtYc6k4ApfAOamDeWnoAeh13VsgY4LxSkp0XL/nvxh
         AvEuvaz6KkCpCuhuTh4s+yyKWQAC1Syx/E7VtmpDt49EEXJ7L79ziSsTFfblle/9Upad
         qRIVJqJQwdy4j+lccdJ6tDrD4Yf4u7L2gBKVuxUeD10Ar0/+vpJ7TfN+DqD58cdKIipb
         bwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939672; x=1702544472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKsrC2p/dEstQQ0QtE5+II/Axy3OGpRA/lKlIyxGMfU=;
        b=jDWRQiZwpfLHnQia2D7NZwcD1TIjp0g0ib2wzGgJnIDhSvt61r3/61G//l7rYdkkU5
         mDPXlkrJXdmpnTtRc58FHLFsV1sB13ZNWxIT7w3ivqe2lpR5XbBST/0UR6l+h+sfpC+4
         cr79hqEnk9oKixsDyPRH4AyI5VTprGZ0WcbVDjhuJUViatgS5a7TIlKyEambOWfDh6Ts
         pQunmw4ljS6Yf+IJ0z6Yehu6mJBoSSt7RjC3gVhM0xKA2vkHLHxNqJBk7FQiWIIICYWW
         WscoqlHqjHTTAfzUNGxKd6Lt/BZLuBv7CwoFVhWf8uBsfwDUgoJOLQj5sb38OcgBJjCN
         Xb2w==
X-Gm-Message-State: AOJu0YxJ7c+AP9poVIPi9jDl602q+9uZZ22qxTRbhE4j7Q7HI1MEf5uf
        hPLMjYwiqa06Q7YPKdD/cPk=
X-Google-Smtp-Source: AGHT+IFwH3MlrTBWISRHWbZ79UOTiRqbgIqnDY4jyF0MSzJqHfOjVk1Qh+G7NHGCEArx3HAl90HMfQ==
X-Received: by 2002:a05:600c:4f03:b0:40b:5f03:b3db with SMTP id l3-20020a05600c4f0300b0040b5f03b3dbmr657798wmq.253.1701939671713;
        Thu, 07 Dec 2023 01:01:11 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:5036:93fe:290b:56de])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b3d8907fesm1173675wmo.29.2023.12.07.01.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:01:10 -0800 (PST)
Date:   Thu, 7 Dec 2023 10:01:08 +0100
From:   Stefan Eichenberger <eichest@gmail.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: add support for mii
Message-ID: <ZXGJXIK3cl/9lfKi@eichest-laptop>
References: <20231206160125.2383281-1-eichest@gmail.com>
 <20231206182705.3ff798ad@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206182705.3ff798ad@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Dec 06, 2023 at 06:27:05PM +0100, Maxime Chevallier wrote:
> > @@ -6973,6 +6988,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
> >  				  port->phylink_config.supported_interfaces);
> >  			__set_bit(PHY_INTERFACE_MODE_SGMII,
> >  				  port->phylink_config.supported_interfaces);
> > +		} else if (phy_mode == PHY_INTERFACE_MODE_MII) {
> > +			__set_bit(PHY_INTERFACE_MODE_100BASEX,
> > +				  port->phylink_config.supported_interfaces);
> 
> Can you explain that part ? I don't understand why 100BaseX is being
> reported as a supported mode here. This whole section of the function
> is about detecting what can be reported based on the presence or not of
> a comphy driver / hardcoded comphy config. I don't think the comphy
> here has anything to do with MII / 100BaseX
> 
> If 100BaseX can be carried on MII (which I don't know), shouldn't it be
> reported no matter what ?

I missunderstood that part, I thought it is a translation from interface
type to speed but it is obviously not. I already verfied that everything
works without this part and will remove it in version 2 of the patch.
Thanks a lot for the review!

Regards,
Stefan
