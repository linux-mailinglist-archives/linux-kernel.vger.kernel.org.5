Return-Path: <linux-kernel+bounces-104800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3CD87D3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7119A1F21511
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78038DD1;
	Fri, 15 Mar 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwKAaevR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5941EF01
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528247; cv=none; b=ieAOo92S//QrVz3rUJYcASV3qUirwvDGD7PFSclGIQvLstuyhn1s7qKT6ILIbS7JFx3vFbOZUsQKxqdi5dIhKIJ/BsOzJKvyrTNiYfXDdwC+IIP0Zn+rBx1VCE/1vxOie5W1/llTwgGZjbdzuA9S0OqNyqM7DfnNJWTPzUh2Thg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528247; c=relaxed/simple;
	bh=1hIcaEugVHYM9qv9vCZLr+cROMsMJ1VI8gM2ISBNduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE9sJUGrVtj/aev1UZxiMHIhwofHca1XCUp8daL+CtrE4eY3UVESUN5HQognbngv1DCActDi26HOlJMyTwcfq7JEYT3dFFP6Maufme7T+LTDppC2HZjkwx+KMYLqJrPruKqpq9c9IwsJ/gKOFZfrZC6DBiC+VP6J9dGHUTnStZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwKAaevR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513da1c1f26so1456180e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710528242; x=1711133042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unYKsN6XP1tGmxG8mlEYFLlvddoUm5Z9kRt/TflohbA=;
        b=MwKAaevRMzrfYEe3Nz4rdKAEAkimUYY35sWA4sxD8D1D9XFtW/jBsarxXxQ5xjq3vI
         ZY5g9w0b7SbRyNO5ZlpAgu3ChpNyejpAYipLT4oEBr5ZRDhBh2wIh/W/lYTBays+WWOP
         PfQahhy2iALf0RlqrXc3cjuAYbljqYIdm30T21fp5j1G6hRqJMcM12tCAHcuk65Wqxxx
         mdxs+MsYuFCTNeVefwyM2w4UMaThPOicIBZqgIOAsrwQdkqhsVbJ222E+Nmad1FwVgO8
         +ZFD5msGU4fDmHMQrouc0+8HtyoTDBr8Z720/BUQQEB6G/GmQA6/lJZyvHpPacyn6hN1
         OMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528242; x=1711133042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unYKsN6XP1tGmxG8mlEYFLlvddoUm5Z9kRt/TflohbA=;
        b=cyCVDjCyboaOMcHEo8gBgbUsBptepYARn49B7lIGZRW9S8G6RllyUi6872wxMzNnDO
         4gwjgZTfMAG8u6dbu9mZmRRwVuYLhsIDgiu+k/nsmfUYLKHKVg4ASQg8SiSr8UrdWfZJ
         vtQDtZo4UBZQaZ566Kjhw1AqbFuuYcT2RBjKnbEx2nzeX8FIs08wyn8naDZb0gvnseKk
         4snBNEDBe55OBBZ0kYxokB8Ln+aH+2ugO92iTlUXLq+EF4atzg6A+PLJUhIVWXA0z1Pi
         4lIRCOjCWzbaRCjen/Vt5kVqaRqpOSrEqyWgnINQLf3RFYuw5oWa0wkPC9P6UJxbAWxQ
         txUg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwJ2FymaPQvbOivG7qDmlaP7sbj5xZTuHJcfgL2yzlj+PFBejp3XkKBAqwLUfV/pCcSf7Rtr3p5aArhqrJQpp/nR+Ni/PZDx54YhH
X-Gm-Message-State: AOJu0YxYUYxGZ3/1OHLNjU4f+1X94e8eHVtkSepOnNwS2ioGIYb30u7R
	HdYx5A8qAEra2Q8WJJcY4j++Xjja5QoPdWth6f5u+osaQYTqxw2IjV3f6Plm4oc=
X-Google-Smtp-Source: AGHT+IGepkNfjDBvL+Ow3oH9rGw1nhLPfmkERiJyEG0SK9efGs8Tt8dyBlC5GPFaxBFpGKlpa7MjuQ==
X-Received: by 2002:a19:4353:0:b0:513:cc91:9ed7 with SMTP id m19-20020a194353000000b00513cc919ed7mr3525941lfj.11.1710528241555;
        Fri, 15 Mar 2024 11:44:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm2016682wmq.23.2024.03.15.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:44:00 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:43:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: usb-acpi: fix uninitialized variable in
 usb_acpi_get_connect_type()
Message-ID: <eb25d06f-775c-43f9-9e7e-4f859f6cc41c@moroto.mountain>
References: <fdd4f94d-fb8c-44a0-9472-3485a567caca@moroto.mountain>
 <2a3ab595-80b2-fd4a-8748-c823fa5ec098@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a3ab595-80b2-fd4a-8748-c823fa5ec098@linux.intel.com>

On Fri, Mar 15, 2024 at 05:36:16PM +0200, Mathias Nyman wrote:
> On 15.3.2024 17.21, Dan Carpenter wrote:
> > The "pld" pointer is uninitialized if acpi_get_physical_device_location()
> > fails.  Initialize it to NULL.
> > 
> > Fixes: f3ac348e6e04 ("usb: usb-acpi: Set port connect type of not connectable ports correctly")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> I sent a similar patch a week ago, just before merge window opened.
> looks like it didn't make it.
> 
> https://lore.kernel.org/linux-usb/20240308113425.1144689-1-mathias.nyman@linux.intel.com/

Huh.  That's interesting that this bug was causing issues in real life.
I thought everyone was using the GCC extension to zero stack variables.
I've only been fixing uninitialized variable bugs out of sense of
stubbornness and to boost my patch count.  :P

regards,
dan carpenter


