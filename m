Return-Path: <linux-kernel+bounces-136338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0389D2D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D13F1F219F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457877F3E;
	Tue,  9 Apr 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUc+8akr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED11762DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646569; cv=none; b=eP1RJP0PhLF2gcixlNg/hSpEZeXGc3gPb2/sB1IuFwA0/VdlDDMqXpKgJTkIlV2f/b/vBpX2iv03AKKDvIXrMae4/rSF8GAborTAbnUqoSf6FtsigW2JZVDvKxQF/Z5pt3iwW7L+zVweFcjQwcCWMrODLpNEizWmOpkHIqNCqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646569; c=relaxed/simple;
	bh=/iJ+I5F0sfq9KYind7XSLJpgygAD0dC+pNWJj8IDHgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrCe+2VTG8wT7DO/vVr79USHMS+5Pxj9cvTnHUM+B2vQWUJxc/yQmLA5kSCFY9NzTQ+v1Sj6Cft9YYj/hlVqcGsHGh7nJ1PV4ijTQZNHJ7cwUy2v9ArYh0yIPNTyTsYBaiLXNzhvNVKGy0O+6VgSUPTIiBVwKZqHowZOqeqpvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RUc+8akr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so5171471a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712646566; x=1713251366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dqFx7OAEEc14dAOlgSGXODmvAlEfmH4sG0q/z/Eh9I=;
        b=RUc+8akrHkpMVOxChpd4iWer+FyWyAwjx1nlpvvls58ONK3Fr4qHSo3ishPIWhSCU+
         zTOzhO1pKANWiiu5QWaOSV6bRwfmXhTO19SC3I861nQxcpVtR9ClKHB8qJwIEr478gtd
         ZNHnfOnEp9vxaWMUpEj9CiXs1pmLOKDgIvgHgNmdWLvsexluoLT+rm3ONfahbDgZNF8R
         eCh5FbSYCDURy8AfJTm9QXElIalbLqjaSfqMaNotHcmzEfrl25CeOI1j+d8KWjm7wJ57
         V7OC93qb8YcmaqHltJHBUo9XhooZX1jztNC+V36odwLTCWn9i28XYnyupUMPqU4RNunT
         y3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646566; x=1713251366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dqFx7OAEEc14dAOlgSGXODmvAlEfmH4sG0q/z/Eh9I=;
        b=I5lqOKKlIr6Y33cIwWST5Ftr7Fak13ufKwls9gRU1Qr7vPUMV93gmh+7zyb7cpCOyq
         5kxPkczTDLD6uL7NOKi/z12WJfSYNpuzvjkLCDbZTFTVRVaLYJnoazkiblBN8SRr3xv+
         8GFl0wZiRjweY2YhRwxNK4mk2tHMIGltViR6hxh8ikuSJhiQacAfP99hf9au9hvZ/WI7
         3DJI6Ey6MXC6cXXbY4M8FQ7ksX94MNVRqGSLDHP36EawtVtM0mTM0verBaxrJwH0gmMB
         QmEuf9MYKLfQe1w0btSF+LIpWvdkczwus3KKZA5uiQK+X/uAL0/9IAerYkCCjLEsjZnU
         oBTg==
X-Gm-Message-State: AOJu0YzvHet6Cr9qrQ9qCkz3tJFaz5O0Ohz/qI328vBRiAAaMGL6nqIm
	nzoYNkG6Q6GGYzkMALIO31/2KF7Wk2gK8VWdRhUjKb7iTi00oSFiGko9XubFlro=
X-Google-Smtp-Source: AGHT+IF8ASg7kMbnXwHDeqwXy3LQ3xUTvoyu/Kg40aJzVJoigndfnNloGnbO9W76N9qNqCXlOfTaTA==
X-Received: by 2002:a50:aad0:0:b0:56e:32af:c527 with SMTP id r16-20020a50aad0000000b0056e32afc527mr4639177edc.20.1712646565942;
        Tue, 09 Apr 2024 00:09:25 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bf20-20020a0564021a5400b0056dd3626035sm4832490edb.91.2024.04.09.00.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:09:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:09:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Message-ID: <3bdbb7aa-d9b4-40ec-836b-ae5978cda9e0@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-11-arnd@kernel.org>
 <76214105-94ae-4540-8511-e9e2ff6d257e@moroto.mountain>
 <1622d9ff-feed-4a12-9d8d-3f00088c9edf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622d9ff-feed-4a12-9d8d-3f00088c9edf@app.fastmail.com>

On Mon, Apr 08, 2024 at 08:26:00PM +0200, Arnd Bergmann wrote:
> On Thu, Mar 28, 2024, at 16:00, Dan Carpenter wrote:
> > On Thu, Mar 28, 2024 at 03:04:54PM +0100, Arnd Bergmann wrote:
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> This is from randconfig testing with random gcc versions, a .config to
> >> reproduce is at https://pastebin.com/r13yezkU
> >> ---
> >>  drivers/staging/greybus/fw-management.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> >> index 3054f084d777..35bfdd5f32d2 100644
> >> --- a/drivers/staging/greybus/fw-management.c
> >> +++ b/drivers/staging/greybus/fw-management.c
> >> @@ -303,13 +303,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
> >>  	struct gb_fw_mgmt_backend_fw_update_request request;
> >>  	int ret;
> >>  
> >> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> >> +	ret = strscpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> >
> > This needs to be strscpy_pad() or it risks an information leak.
> 
> Right, I think I misread the code thinking that the strncpy()
> destination was user provided, but I see now that this copy is
> from user-provided data into the stack, so the padding is indeed
> stale stack data.
> 
> I could not find out whether this gets copied back to userspace,
> but adding the padding is safer indeed.
> 

Grey bus is a bus, I'm not sure what's on the other end of the bus but
I think we've generally said that the data needs to be zeroed...
Although if that is true, why didn't I make this a Smatch warning?

regards,
dan carpenter


