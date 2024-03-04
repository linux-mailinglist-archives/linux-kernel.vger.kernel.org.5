Return-Path: <linux-kernel+bounces-90990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988B87081B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE121C2032D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575160271;
	Mon,  4 Mar 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuEMUgu9"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FE39AF1;
	Mon,  4 Mar 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572434; cv=none; b=Z+rap6dWJM7qwqyrWcZbRixhk99IRT5Jop+xqjpPyl7t0WBq1tosUHcsWoM6g1i2GXC6sUTau6gTarPzDuu9m0uidyL864oYPCAjoyTvUtZfiTzUeFVNR0Y26czvUtcVrH3dhUpYNU/lo6fCLqAE5h5299w3MUu9meWELK+YQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572434; c=relaxed/simple;
	bh=aVsoSYr9lidkVGiDzBTySKzdgM/ZiOsURJBg5zuk/3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBM9NlaIiJV2ZwRjJfD+mjTtHr1ljp6RUGCL0hivSB5RPCtW0GbCRsnw+Kv7EJQhAG0W+0Q9Tx+alpDZ8VE4BI8xuGCvUYNjnkNRLq0cJwbH+yVKQD8BjKs1sPFbEy4tEbGrE+/n2Xe/dLlCKYJNf55hgLiO8O+rjWcuJMJWM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuEMUgu9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so3856488b3a.3;
        Mon, 04 Mar 2024 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709572432; x=1710177232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBlQa3GtwlSFl/WzXIlG10CFy19K9d7iBWjjMCPyyvc=;
        b=DuEMUgu9k8fQPQar9sOJZY9XuuSoWIfP++QENjZ6dFTyFWNVk4hlxAXUpdwG3M2ckP
         a5sH+f+xDZenvVlYVLHSChrQa2joyRiachZwFxPxXRong73gLjrkxPyRedzDD8WkGCXk
         uYAUaWo/qPV3OafGxmlIpnsgvU6zvAt8i4LPviaMX0HrTLbI9Xuf2oOrBox3gU8KYOhB
         VkYy0BcIlHxn7NgJZE/TFqT4VAaSUApVionHiKX2B/yjdNX8HiTttxIBC55f/yMcdJje
         SoatWoJ2KlxBTQvfhRFNrRntiHVjQNTGyofVnjOGf0YvppF9jCo1aAieup0WygsUEsyC
         CgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572432; x=1710177232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBlQa3GtwlSFl/WzXIlG10CFy19K9d7iBWjjMCPyyvc=;
        b=bDINECB5bNPvxiYVzYbx9LEhmaseFgQPoPChSbF0yWfNqDBX+FrZRpU676EQwyrsyV
         BzmatFyxm7bNsi9iOTxfWZPW7avEkG/HfJilc6RNCXv3pIOk+3CjjcAD7Z9BPhfz6L4W
         hTlsIDa7I02GOH5afMQsIn52owkZaUvCF1nGX7QHWy4E3V8m94UTq31xWPHO4WvTQVrk
         8z1TNLzc7HH7BD4HkH0x3+/KMPIlX5iZSelnpWdQzkJvVUWjGc21J7g7chIwIaepbCm4
         Ps9nnwBgkKiJf0ZljbpKGFJVZbq6QcxSoHJM13fgvz9GShQ37Kp/dMfn2FUusBFCQDxw
         hbSw==
X-Forwarded-Encrypted: i=1; AJvYcCVq2UFBvWdz7nNBsOYQwoRL3kUGpqJZHktBUP5E9WnY/MpQtjpiWYhme2hPFhGqqD/wvtiJgme3ekPdMO1AMZEH5cPcUycoQ0O//Fdgk6LF2Eb9sD/fFQO9rSyyJ/ghebuBHysndNKnDY9LFNy1wBL7rxIHoOmiuGGFmMsi1iaPy54zdHBtbVhsYz8=
X-Gm-Message-State: AOJu0Yy9J9JFhUo1DUoRbe1u02JAAFs80oRXvQ6rQVRA1fEu6dq3IdDc
	oOevGXRQLQ8qmtsvXjNFTyN1u3G263/jNH0Mo8yYZOAOANOoJECi
X-Google-Smtp-Source: AGHT+IHMZPii8KNhV0sSfdA1ahnzkIkrriDy33cN1wcfC/2V5l4SBefB0+HcFMX/wVn2TFBpUvkivA==
X-Received: by 2002:a05:6a00:4b42:b0:6e4:62ed:23c3 with SMTP id kr2-20020a056a004b4200b006e462ed23c3mr12677188pfb.9.1709572432503;
        Mon, 04 Mar 2024 09:13:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id lp3-20020a056a003d4300b006e553f2b880sm7420133pfb.211.2024.03.04.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:13:52 -0800 (PST)
Date: Mon, 4 Mar 2024 09:13:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeff LaBundy <jeff@labundy.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-input@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] Input: iqs269a - Use scope-based resource management
 in iqs269_parse_chan()
Message-ID: <ZeYBTUQRAp2u3bXX@google.com>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
 <ZeT6UUFNq1ujMW17@google.com>
 <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
 <ZeYAk830OUpaup5W@nixie71>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeYAk830OUpaup5W@nixie71>

On Mon, Mar 04, 2024 at 11:10:43AM -0600, Jeff LaBundy wrote:
> Hi Markus,
> 
> On Mon, Mar 04, 2024 at 10:55:11AM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 4 Mar 2024 10:30:52 +0100
> > 
> > Scope-based resource management became supported also for this software
> > area by contributions of Jonathan Cameron on 2024-02-17.
> > 
> > device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> > https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
> > 
> > 
> > * Thus use the attribute “__free(fwnode_handle)”.
> > 
> > * Reduce the scope for the local variable “ev_node” into a for loop.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> > 
> > v2:
> > An other cleanup technique was applied as requested by Dmitry Torokhov.
> > 
> > 
> >  drivers/input/misc/iqs269a.c | 73 ++++++++++++++++++------------------
> >  1 file changed, 37 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
> > index cd14ff9f57cf..9caee936927b 100644
> > --- a/drivers/input/misc/iqs269a.c
> > +++ b/drivers/input/misc/iqs269a.c
> > @@ -557,7 +557,6 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
> >  			     const struct fwnode_handle *ch_node)
> >  {
> >  	struct i2c_client *client = iqs269->client;
> > -	struct fwnode_handle *ev_node;
> >  	struct iqs269_ch_reg *ch_reg;
> >  	u16 engine_a, engine_b;
> >  	unsigned int reg, val;
> > @@ -734,47 +733,49 @@ static int iqs269_parse_chan(struct iqs269_private *iqs269,
> >  	}
> > 
> >  	for (i = 0; i < ARRAY_SIZE(iqs269_events); i++) {
> > -		ev_node = fwnode_get_named_child_node(ch_node,
> > -						      iqs269_events[i].name);
> > -		if (!ev_node)
> > -			continue;
> > -
> > -		if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
> > -			if (val > IQS269_CHx_THRESH_MAX) {
> > -				dev_err(&client->dev,
> > -					"Invalid channel %u threshold: %u\n",
> > -					reg, val);
> > -				fwnode_handle_put(ev_node);
> > -				return -EINVAL;
> > +		{
> > +			struct fwnode_handle *ev_node __free(fwnode_handle)
> > +						      = fwnode_get_named_child_node(ch_node,
> > +										    iqs269_events[i].name);
> > +
> > +			if (!ev_node)
> > +				continue;
> > +
> > +			if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
> > +				if (val > IQS269_CHx_THRESH_MAX) {
> > +					dev_err(&client->dev,
> > +						"Invalid channel %u threshold: %u\n",
> > +						reg, val);
> > +					return -EINVAL;
> > +				}
> > +
> > +				ch_reg->thresh[iqs269_events[i].th_offs] = val;
> 
> I may just be a curmudgeon, but this is another NAK for me. The dummy
> curly braces and extra indentation make the code difficult to understand,
> and this simply does not seem like a natural way to write a driver. Just
> to remove 2-3 calls to fwnode_handle_put()?

The extra curly braces are absolutely not needed. The for loop's body
already defines scope, __cleanup()s should be called at the end of the
body.

Thanks.

-- 
Dmitry

