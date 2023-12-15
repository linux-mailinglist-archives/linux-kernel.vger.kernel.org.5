Return-Path: <linux-kernel+bounces-438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86232814124
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF661F2302F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA1CA70;
	Fri, 15 Dec 2023 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="NZOpeKOd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9CCA67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d347b4d676so2039825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702616766; x=1703221566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvpP/ygkFMYd8akAA0h2BMF7cGxl78yZ9yQVEC1m76w=;
        b=NZOpeKOdcwKj3GkoNv9NTb+R5XhN0FwzyzDTz3eYCZ0dVCPRtazyIK4ft5K/9fTBz4
         wj4fsFnx1wGfzTV68fcgFV8y36BOwaPqkWAVQRlUbmBTW7yHr5iCtxA4dVTU67nIvHQI
         Rh8vhB62X2n4ZqtO1c4AenNOifkePD/kAp7djJ2HbP0Xo/zggU6gLDLQ6+D64njEh1g4
         ZeSbxhu/q6RGS6xGMnYmOOLjhJ1faZv5nhkE+HDremtZK0HOKSolwqOig455Hd4ReNlw
         btM558dPYFaj6thJfo58kay8QFRqmkLoYQF7NosrzDF/jAupPwfwWSj9ymRlXHvkWJ/F
         mQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702616766; x=1703221566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvpP/ygkFMYd8akAA0h2BMF7cGxl78yZ9yQVEC1m76w=;
        b=rIcQ44rWArdTTMoTc2vv/O03tMnoONHDfZis8XG8CvuYy1d/7JhHM3Vb+kPOXzAGu2
         5VZgsnUGCXz0OA+UMgQbYPLKL+AzL/RjOgGTnNIEp0rdmAP3NFGFnRCDj+zLBMnwcSVe
         No+PcSMStvur7fW9jeCA5uSQVioQHFfoxx5ogp/S/RqxtzpwfDzjNjHQ3MQMz0IVgBxg
         S9ZCrVMatCAy8ukQFCPwIDjtVpuxvYNCYShZ1V+kypqVJo+Zf+t6vJoYR2lAouUtfHXK
         +zec9iANsMtMZtLlMjPMdpNCzMWKEv3didhj5oUbSDllb8Z5/PKvSZjREKlScalNpp70
         OIHA==
X-Gm-Message-State: AOJu0YwsCw1JZMSHWuX2V8w55HRReqYSJbRarRIDWElo31jio+oTwC7w
	/+XOn5NKkzEbkzj75felTbUxsZr6L9HplicZHbg=
X-Google-Smtp-Source: AGHT+IHJ3DBkuKkdets9d837xoghatL8OwNCUq3Sx8ZFLNbuSRbWp7OiuUaSbeKx1eoJ27Otho8bIw==
X-Received: by 2002:a17:902:c406:b0:1d1:c96a:c5e with SMTP id k6-20020a170902c40600b001d1c96a0c5emr13537749plk.70.1702616766572;
        Thu, 14 Dec 2023 21:06:06 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001d0b5a97cabsm13255145pld.124.2023.12.14.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 21:06:06 -0800 (PST)
From: "<Tree Davies" <tdavies@darkphysics.net>
X-Google-Original-From: "<Tree Davies" <tdavies@gmail.com>
Date: Thu, 14 Dec 2023 21:06:04 -0800
To: Nathan DSilva <expitau@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net, kamrankhadijadj@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Add blank line after declarations
Message-ID: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
References: <20231215032852.501316-1-expitau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215032852.501316-1-expitau@gmail.com>

On Fri, Dec 15, 2023 at 03:28:52AM +0000, Nathan DSilva wrote:
> Found using checkpatch, removes one warning about line breaks after
> declarations.
> 
> This is my first patch, feedback is welcome. I am submitting this as a test
> before moving to other subsystems to (hopefully) make more meaningful
> contributions.
> 
> Signed-off-by: Nathan DSilva <expitau@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index ecaa4dec3f94..397859c7f5b1 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -946,6 +946,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
>  {
>  	u8 type, stype;
>  	u16 fc = le16_to_cpu(hdr->frame_control);
> +
>  	type = WLAN_FC_GET_TYPE(fc);
>  	stype = WLAN_FC_GET_STYPE(fc);
>  
> -- 
> 2.43.0

Hi Nathan,

Thanks for your patch, but here are few comments.

1. Your subject line looks good. Keep it.

2. Your commit message should read something like.. 'Do x to fix Y'.
There are lots of examples in the log for this driver which demonstrates this.
You don't want 'This is first patch' in the commit log.

3. For this driver, it is best to send your patches to Greg, Philipp Hortmann,
and Dan Carpenter (error27@gmail.com) looks at them sometimes too. And like you
did, cc the mailing lists.

For example, My setup usually looks like...
git send-email ./patches/*  --to=gregkh@linuxfoundation.org --to=philipp.g.hortmann@gmail.com --to=anjan@momi.ca  --cc=linux-staging@lists.linux.dev --cc=linux-kernel@vger.kernel.org

A good source of info for sending patches can be foound here:
at https://docs.kernel.org/process/submitting-patches.html
and also there is a free tutorial at:
https://trainingportal.linuxfoundation.org/courses/a-beginners-guide-to-linux-kernel-development-lfd103

I'm a newbie myself, but I'm happy to help.
Cheers
Tree



 
  





