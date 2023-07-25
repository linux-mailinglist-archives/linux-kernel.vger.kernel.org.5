Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924197622AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGYTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGYTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:51:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56F1FF7;
        Tue, 25 Jul 2023 12:51:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba48b0bd2so15313795ad.3;
        Tue, 25 Jul 2023 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690314663; x=1690919463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dM6PVN/UVPsx9akBfcdMrUXeZyjQENh7tRqhuMoKNtg=;
        b=hAb3Qm1QG+r6tIyuVNrs1EeeIUiPm8r80oQw5K4H7lWeg8XWu4UhqKUBnn+ESLSFGv
         iEfLyh+HD0ES08w5+8Zu7RaztH01hkAC7pjqNqk4v6rvTGUPHwBqBg7dpwijLb6UX76t
         i7VGX5PnSAcYablL/o3ZvFvxoC9gotU8oWRnAIWHnkud0xahYmAuDdiKhnQxj2l/5Mnj
         aA18idNdYQyLdLDpndVOBsDRi0fpkxE5X34mc0W0QxbKh8K4CHBHGUjsiV6oqUjSmR0a
         Oi2bGnCsPNrxeUCdmQFiK3BbQG18xxIOoErzLhGfqC0ZZWxcsJ1GXyI2oqm1LNVnmT8N
         gy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314663; x=1690919463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM6PVN/UVPsx9akBfcdMrUXeZyjQENh7tRqhuMoKNtg=;
        b=IQ1HZj1wLVnUocofr+Bxm+nsQIE8Qj/gwtVaf3yfsut4fO7gEIk8yszV20c+8305uz
         /V4giPAMGjCQEufhCkcly2ln+K/vUwXThr07eTteLmDjVSLB5DPy+fMDxxAlGnBxj5XS
         EaJVYsLPPUNWVLHIx7lKqMjRWJwW3wHDgSxpyCAsFz+lMbOEe+lwwyrh181C6TUN/vHK
         qIGOdqZqGJWAXtnelX0ChaxBegH6ftHih7+cQPoJIhkF/wuHfDyXP2tW3ABdBIdUD5Or
         lWrncMU/iRR7Fk6L4VQVbD//3a4zq4lDsXfeYe3Z5OMZ1GMDoWfEqw8qsaIscM3uEzxi
         Uv8w==
X-Gm-Message-State: ABy/qLb5njZHCt9i2wd6ebbrYcax1pVznitnmB8YR9UEH42+/ChtdDJ1
        yWhBXw2ptec7KqGNn6rQPVA=
X-Google-Smtp-Source: APBJJlGbkUe5BvV7or4sKMrmi21B5+NOUzEkmj8GDIfZZSZBwAgtngWYUPce3WJQcRB2njJdSxqM6A==
X-Received: by 2002:a17:902:c3d5:b0:1b8:77b3:6bf6 with SMTP id j21-20020a170902c3d500b001b877b36bf6mr113591plj.33.1690314662876;
        Tue, 25 Jul 2023 12:51:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:83ca:1b31:2c:d986])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001bb750189desm8409174pln.255.2023.07.25.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:51:02 -0700 (PDT)
Date:   Tue, 25 Jul 2023 12:50:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Silvan Jegen <s.jegen@gmail.com>
Cc:     linux-input@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Input: tca6416-keypad - switch to using input core's
 polling features
Message-ID: <ZMAno7jWmlBZpAO/@google.com>
References: <20230724053024.352054-1-dmitry.torokhov@gmail.com>
 <20230724053024.352054-5-dmitry.torokhov@gmail.com>
 <2KN6Z0RZYGDKU.2GGSSC8MYU6GX@homearch.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2KN6Z0RZYGDKU.2GGSSC8MYU6GX@homearch.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:43:12PM +0200, Silvan Jegen wrote:
> Hi
> 
> Just one question below.
> 
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Instead of rolling custom polling implementation use input core
> > facilities.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/keyboard/tca6416-keypad.c | 46 ++++++++++---------------
> >  1 file changed, 19 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
> > index ff665319791e..ebc8b9561266 100644
> > --- a/drivers/input/keyboard/tca6416-keypad.c
> > +++ b/drivers/input/keyboard/tca6416-keypad.c
> > @@ -24,6 +24,8 @@
> >  #define TCA6416_INVERT         2
> >  #define TCA6416_DIRECTION      3
> >  
> > +#define TCA6416_POLL_INTERVAL	100 /* msec */
> > +
> >  static const struct i2c_device_id tca6416_id[] = {
> >  	{ "tca6416-keys", 16, },
> >  	{ "tca6408-keys", 8, },
> > @@ -43,7 +45,6 @@ struct tca6416_keypad_chip {
> >  
> >  	struct i2c_client *client;
> >  	struct input_dev *input;
> > -	struct delayed_work dwork;
> >  	int io_size;
> >  	int irqnum;
> >  	u16 pinmask;
> > @@ -85,9 +86,9 @@ static int tca6416_read_reg(struct tca6416_keypad_chip *chip, int reg, u16 *val)
> >  	return 0;
> >  }
> >  
> > -static void tca6416_keys_scan(struct tca6416_keypad_chip *chip)
> > +static void tca6416_keys_scan(struct input_dev *input)
> >  {
> > -	struct input_dev *input = chip->input;
> > +	struct tca6416_keypad_chip *chip = input_get_drvdata(input);
> >  	u16 reg_val, val;
> >  	int error, i, pin_index;
> >  
> > @@ -122,33 +123,20 @@ static void tca6416_keys_scan(struct tca6416_keypad_chip *chip)
> >   */
> >  static irqreturn_t tca6416_keys_isr(int irq, void *dev_id)
> >  {
> > -	struct tca6416_keypad_chip *chip = dev_id;
> > -
> > -	tca6416_keys_scan(chip);
> > +	tca6416_keys_scan(dev_id);
> >  
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static void tca6416_keys_work_func(struct work_struct *work)
> > -{
> > -	struct tca6416_keypad_chip *chip =
> > -		container_of(work, struct tca6416_keypad_chip, dwork.work);
> > -
> > -	tca6416_keys_scan(chip);
> > -	schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
> > -}
> > -
> >  static int tca6416_keys_open(struct input_dev *dev)
> >  {
> >  	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
> >  
> > -	/* Get initial device state in case it has switches */
> > -	tca6416_keys_scan(chip);
> > -
> > -	if (chip->use_polling)
> > -		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
> > -	else
> > +	if (!chip->use_polling) {
> > +		/* Get initial device state in case it has switches */
> > +		tca6416_keys_scan(dev);
> >  		enable_irq(chip->client->irq);
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -157,9 +145,7 @@ static void tca6416_keys_close(struct input_dev *dev)
> >  {
> >  	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
> >  
> > -	if (chip->use_polling)
> > -		cancel_delayed_work_sync(&chip->dwork);
> > -	else
> > +	if (!chip->use_polling)
> >  		disable_irq(chip->client->irq);
> >  }
> >  
> > @@ -232,8 +218,6 @@ static int tca6416_keypad_probe(struct i2c_client *client)
> >  	chip->pinmask = pdata->pinmask;
> >  	chip->use_polling = pdata->use_polling;
> >  
> > -	INIT_DELAYED_WORK(&chip->dwork, tca6416_keys_work_func);
> > -
> >  	input->phys = "tca6416-keys/input0";
> >  	input->name = client->name;
> >  
> > @@ -268,12 +252,20 @@ static int tca6416_keypad_probe(struct i2c_client *client)
> >  		return error;
> >  
> >  	if (!chip->use_polling) {
> 
> Sorry for my ignorant question but it seems counterituitive that we set
> up polling when chip->use_polling is false. Is this intended?

Nope, this is my brain fart. Thanks for noticing! I'll fix up the
condition before committing...

Thanks.

-- 
Dmitry
