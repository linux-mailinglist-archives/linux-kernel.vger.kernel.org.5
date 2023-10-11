Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5127C5117
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjJKLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjJKLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:08:12 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D919B1;
        Wed, 11 Oct 2023 04:06:27 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (185-9-11-240.cust.suomicom.net [185.9.11.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S591q2dYSzyYQ;
        Wed, 11 Oct 2023 14:06:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1697022385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmaAL5usRi4Ui8WzfPSbnayZGHaVdfiIz8XXq6gkdbU=;
        b=N6jTUMCMfg8Y3c7+PejgtPAw3RFu0E4jkLF0fzcjQhcK5Un94dqeXfXeZhbCoWfGoihQ5D
        0b65U5jjfkwLrKV1/p/hvTuopz3DZ0IwGG+Wgp+6beO2yjjAAzGAzU6ugogEQ0nkpZXXFc
        DDNmDooyda2L0yV8foAkfCm2bFdHpHs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1697022385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmaAL5usRi4Ui8WzfPSbnayZGHaVdfiIz8XXq6gkdbU=;
        b=cG6uMzlEyMOE4Ul9TnEN51ooSdzjqOyv33TAvdfPJFGoxloNDi6ss3Bt6kwaIAWcDeNCP9
        CJx0GergxhJqHFZUdNwPWPsehmjBTqPcugSw5mUEQ64gZ/T/wjKejNQ2GGbB6zRyTXhKk2
        SpMnYURxaEC4Nr+KTPRTNwxDfifk124=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1697022385; a=rsa-sha256; cv=none;
        b=C7cQiaw4zJHiDxcmmMMlUHfz1iw4VurZsgMNccMINm4n1n3m0No5Bbx9xJVMbVgOg9tIP9
        /RSXcpdiPljQIdKiw0KueNqSYfIqY3IUouMEJkslHT2UPiWbtNOzeG5qJBfDDUIS24Y64x
        jughi7PbcHTO392tpihY4HZHBQVd+tk=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8963D634CA9;
        Wed, 11 Oct 2023 14:06:19 +0300 (EEST)
Date:   Wed, 11 Oct 2023 11:06:19 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] media: i2c: imx335: Enable regulator supplies
Message-ID: <ZSaBq5ucJ5PrxI00@valkosipuli.retiisi.eu>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
 <ZSTrOB10pDhJq6gG@valkosipuli.retiisi.eu>
 <169701731909.277971.10840095252716847805@ping.linuxembedded.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169701731909.277971.10840095252716847805@ping.linuxembedded.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Wed, Oct 11, 2023 at 10:41:59AM +0100, Kieran Bingham wrote:
> Quoting Sakari Ailus (2023-10-10 07:12:08)
> > Hi Kieran,
> > 
> > On Tue, Oct 10, 2023 at 01:51:23AM +0100, Kieran Bingham wrote:
> > > Provide support for enabling and disabling regulator supplies to control
> > > power to the camera sensor.
> > > 
> > > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > > ---
> > >  drivers/media/i2c/imx335.c | 41 ++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 39 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> > > index ec729126274b..bf12b9b69fce 100644
> > > --- a/drivers/media/i2c/imx335.c
> > > +++ b/drivers/media/i2c/imx335.c
> > > @@ -75,6 +75,19 @@ struct imx335_reg_list {
> > >       const struct imx335_reg *regs;
> > >  };
> > >  
> > > +static const char * const imx335_supply_name[] = {
> > > +     /*
> > > +      * Turn on the power supplies so that they rise in order of
> > > +      *           1.2v,-> 1.8 -> 2.9v
> > 
> > This won't happen with regulator_bulk_enable(). Does the spec require this?
> 
> Every camera I've ever seen handles this in hardware. (I know that's not
> an excuse as somewhere there could be a device that routes each of these
> separately).
> 
> Perhaps I shouldn't have added the comment ;-) But I thought it was
> useful while I was working through anyway, and could be important for
> other devices indeed.
> 
> The datasheet states:
> 
> ```
> 1. Turn On the power supplies so that the power supplies rise in order
> of 1.2 V power supply (DVDD1, DVDD2) → 1.8 V power supply (OVDD) → 2.9 V
> power supply (AVDD1, AVDD2). In addition, all power supplies should
> finish rising within 200 ms.

That's an annoying requirement but I'd presume this to work just fine in
practice. The device is reset in any case (as you describe below). Some
boards might not wire the reset GPIO though, and then it's when it gets
interesting.

To literally implement the documented sequence, you should separately
enable the regulators one by one.

Although I don't object just removing the comment either.

-- 
Regards,

Sakari Ailus
