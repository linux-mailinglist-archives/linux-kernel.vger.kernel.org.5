Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583BF7FA294
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjK0OYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjK0OYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:24:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D564230
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:02:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507ad511315so5892921e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701093762; x=1701698562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh8MG/fcScS4zGx1w1Y666LV3WqtJtCJW99b8yZPGeU=;
        b=lvw+6FxYVAJcVDXhAwCe/s9ZxNHS8sF1SM/r+F8nmyCxt6kggKelzzoVhdrYZypeGh
         ZUrPlACn2bhGk/rchjr6SSV5u5KgvbkMR5AVxEk2vG8YmK6qc460vKxl5jxXdZRQg2yq
         VzOO+lmVMmU7F2py/GETYiesAsPCKaXiA2FdQoPr3Mp2zJKOtGx4dLxDaC4ZPV7R2X9y
         x3zy0X+wPtx9H7N986+Ie20LJDu3lX2AVrxtBi4l2xOHeG9M/nKyEvsU5BDT2Nl223J+
         HT2YcZ5m1KC6818QSROQFoDBaBgTy+BRGInPT0bEDNXR9/YBiC6/0yUD84abdeDn2nrK
         L5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093762; x=1701698562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh8MG/fcScS4zGx1w1Y666LV3WqtJtCJW99b8yZPGeU=;
        b=oggHzDtfq2O2yVlM+wRHkSjFleaVnd26wkqIQWFVlEItJ8rezO2uihFhjkvaxEMwQ6
         GjpDNc1bwv3u/MYZTyAA3VDP1qEldxOF3kVNOzb5DCvEkdDxUI5cUG4RI5bimlykvKmp
         LX2l0vWIMyy6v6u36WRJgipsv3/oh0zJ5QWCdWkG7Pmvt0J6CeE3/VGlDHCejdwvlo5N
         hV04tYVhn53WSua7dbTolFonMFM+YlAEZ1dmmT32ErQH22tsITGPTUw3ju2CfmAofDyz
         XSVsxuwShVGY/aEJwdO9P/Fk+VIqEc0zqUhLOqzuKoLr9WW9w0j7Cv5iif8XUuu2feW4
         ta4w==
X-Gm-Message-State: AOJu0Yz5ktf2p1GroLW+PSf6RaQHzuIGw4khfE7iKoH/EuRGxyYNsxZW
        HZnmBdjHDSIlXLY8XbDZVani5A==
X-Google-Smtp-Source: AGHT+IFj52P0DIEx0c9vj7QT0YARpPDlM/qFv1+NoeWnzCQ9HCNWjkCgkmNnLJMpwF9gtUU6vrpmNA==
X-Received: by 2002:a05:6512:2389:b0:506:899d:1994 with SMTP id c9-20020a056512238900b00506899d1994mr7071586lfv.52.1701093761408;
        Mon, 27 Nov 2023 06:02:41 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512128400b0050ab696bfaasm1486122lfs.3.2023.11.27.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:02:40 -0800 (PST)
Date:   Mon, 27 Nov 2023 15:02:39 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1
Message-ID: <ZWShfwyqO-JkqVgI@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-3-ramon.nordin.rodriguez@ferroamp.se>
 <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 02:37:41PM +0100, Andrew Lunn wrote:
> >  #define PHY_ID_LAN867X_REVB1 0x0007C162
> > +#define PHY_ID_LAN867X_REVC1 0x0007C164
> 
> So there is a gap in the revisions. Maybe a B2 exists?

The datasheet lists A0, B1 and C1, seems like Microchip removes the
application notes for old revisions, so no way that I can see to add the
init-fixup for A0.

I'm guessing there is a rev.c0 that was never released to the public.

> > +	const u16 magic_or = 0xE0;
> > +	const u16 magic_reg_mask = 0x1F;
> > +	const u16 magic_check_mask = 0x10;
> 
> Reverse christmass tree please. Longest first, shorted last.

My bad, I was just thinking 'christmas tree' forgot about the reverse.
I'll fix that.

> > +	int err;
> > +	int regval;
> > +	u16 override0;
> > +	u16 override1;
> > +	const u16 override_addr0 = 0x4;
> > +	const u16 override_addr1 = 0x8;
> > +	const u8 index_to_override0 = 2;
> > +	const u8 index_to_override1 = 3;
> 
> Same here.
I'll fix this.

> 
> > +
> > +	err = lan867x_wait_for_reset_complete(phydev);
> > +	if (err)
> > +		return err;
> > +
> > +	/* The application note specifies a super convenient process
> > +	 * where 2 of the fixup regs needs a write with a value that is
> > +	 * a modified result of another reg read.
> > +	 * Enjoy the magic show.
> > +	 */
> 
> I really do hope that by revision D1 they get the firmware sorted out
> so none of this undocumented magic is needed.
> 
> 	Andrew

Really do hope so.. 
