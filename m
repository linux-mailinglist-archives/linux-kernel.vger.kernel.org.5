Return-Path: <linux-kernel+bounces-20485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D0B827F8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82EA1C25739
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCF947A;
	Tue,  9 Jan 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqdyB/+j"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A619468
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33678156e27so2563203f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704785996; x=1705390796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FCGnpiVOUgVBf9FWkplPUtkcGPH1yZ1U7MpKIuVpA0s=;
        b=OqdyB/+jfheR41GiV1sV/u3R4imyL91OuwPqYFcPfK4JSBX2Onjuyl3lHdAdXgfvnL
         uQn+dB1janbiYi5IkKbfum7xHUR7zPlDOTwCrXuGGCMh2zdxEc9sBvsUMhVOQuWXhEb7
         wCdqlUEZZrdbNm3NGRlin56i5qP898KAoMoBUzvVrG8tHLGhWxQR836v2qr2Ba1XURky
         i2QX4NprTJY9izIWhDmStqH854Jrqt8nLgeUTuyQ+4JZWQ8X9JfVXxaTMs676pOEAClZ
         iPnRQAl5+Wz1oJ+JoaNnfX1SNgTbfWBeWjxkA5oreiA1USaTMWcX4Aoz6w0zAYvK+L2A
         MqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704785996; x=1705390796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCGnpiVOUgVBf9FWkplPUtkcGPH1yZ1U7MpKIuVpA0s=;
        b=r2DDqcp5HkoJ8PH5+7N7uQdUBDBcfqbrMsgKsf3wDI0WzMyVMAiwXQteKSw/5Kx52K
         EpQWeL+7VID2yrTHJWOqINciCdMscCjBQDfNyTSl7yMocbVg5qse9HUIw25gnrKIRpSL
         MKuGr72Ot34mZS/mudhTZB6tj+OC/Mco5KYal8936NFGQ6Nq/v8cbIkVYK75VAYxJBYm
         yxx9JXq3bh9d89hA1vwLqory0KRbtPQqL1GIT6+Yg7ahuwxLmiFcbKxSZLlCejx5qoiE
         QluqNQP1VkKYFzpyYBqjt4frCC/pc2LHZqwXrQC/+kwNNZYVYcgexZ2i/fRzZJDhFRR9
         D81A==
X-Gm-Message-State: AOJu0Yw8TbdA9H+rIuw196gObZprkJ4ivcjCj3wfhAG5l6sP+gA0gJgi
	ejpB0Gc9YCO07xKTPMRC3BK6M12XV/zlyg==
X-Google-Smtp-Source: AGHT+IEvk3ncbEGc3LkVgi8d+aEnFalCwAwKUCaY4/yteX7pPp3uVJedSRrAiFOv8VuIvMhiRNJVSA==
X-Received: by 2002:a5d:5966:0:b0:337:6535:3642 with SMTP id e38-20020a5d5966000000b0033765353642mr336509wri.43.1704785996635;
        Mon, 08 Jan 2024 23:39:56 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d6e8e000000b003366c058509sm1618608wrz.23.2024.01.08.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:39:56 -0800 (PST)
Date: Tue, 9 Jan 2024 10:39:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] cifs: make cifs_chan_update_iface() a void function
Message-ID: <5c29dddd-2952-4993-9347-7bb11bdf2914@moroto.mountain>
References: <b628a706-d356-4629-a433-59dfda24bb94@moroto.mountain>
 <eac139a7-76d4-4067-8c25-15e30692aaf9@moroto.mountain>
 <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6b12c9-0502-400a-b2ba-dad89ef4f652@wanadoo.fr>

On Mon, Jan 08, 2024 at 08:09:17PM +0100, Christophe JAILLET wrote:
> > @@ -478,13 +475,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
> >   	chan_index = cifs_ses_get_chan_index(ses, server);
> >   	if (chan_index == CIFS_INVAL_CHAN_INDEX) {
> >   		spin_unlock(&ses->chan_lock);
> > -		return 0;
> > +		return;
> >   	}
> >   	ses->chans[chan_index].iface = iface;
> >   	spin_unlock(&ses->chan_lock);
> > -	return rc;
> > +	return;
> 
> just remove this one?
> 

Doh.  Yeah.  I'll send a v2 of this tomorrow.

regards,
dan carpenter


