Return-Path: <linux-kernel+bounces-3294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C4816A81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B661C2297D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23812B90;
	Mon, 18 Dec 2023 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W8qk2ult"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A212B75
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso1493935e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702893970; x=1703498770; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VA/CRanBtTCRovCAjUXUUqFal04ewMnPxSdzdrqR1E=;
        b=W8qk2ultb45/Ch6N8nRXxKuaeAURmCGqaYbDD7i2Alx5zssSKlOuALSRPg2eU8uqZi
         iTOuyNxEK0Q+AF3vH4e3bhNEI3L+YuPtWzVeFYh5scB0Yeer+NmWQxLX48Wsl1CQ961i
         zLFVuvtS5Z6fit+K4u90N8M9zuPCTY0X+4ZXrNOTeJPyGiAy9pVsHYoJjMwsorWTinc+
         VcR9XZkrkZXcfDciW82wuE1IwF4BAd8JziRjB3GI7JmJn5+oXbHAN6WqvNH4UzuEMyZ/
         Hr25o5TPyrY4bxUkn5HhamoGo7nsE6817PXvSJTJagHsNj4Htzd5JmzlW57XO9bjUC3u
         sefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702893970; x=1703498770;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VA/CRanBtTCRovCAjUXUUqFal04ewMnPxSdzdrqR1E=;
        b=JZ7s8a4aeEU48ofb80BRwdDUl+yGozYKYi5MhHsDSROCzG6Qq9OW+6s766QPVKxaU4
         sxNXSbAg5bWvrSeb4lHxjB0zHrmnRIqu8UQdHuKZV+dZXG1c/biFvjeoSdWY/tUwYpSD
         sqf+ZyuF1ZoteZFLhc2aFxq6hnHhr4he3Yi1SPjPmVotD7f5W3/5BnhoREpCRi+B2HCa
         yOjH8bfRX0a4KdFsQ2GIfiKdDXZ4y2xTroMdlgE/8WSmen1CE642kI4Bylv6mguZFTpc
         0nqSwIDqVKoQ+m29P4ccowZcxfhx2a6oKrY7N9nxJ5XGzwG11AUosgSbw9/FFsYY36RP
         pjVQ==
X-Gm-Message-State: AOJu0Yw9KgTmwIxQdwmoKmdbIdl1uwrPeYB5D3HRYm4WDsvDdWRo+Y4M
	EEv9JjadRGWpwzeVZuZinmSxmQ==
X-Google-Smtp-Source: AGHT+IFCG1LeGpU5/GNoQJmL3eATMQXYVBtGPKHhL0PgOA1ESfMQJcHbRUG84Pce3zr14zoOrn8qAQ==
X-Received: by 2002:ac2:4c8d:0:b0:50e:302d:b19f with SMTP id d13-20020ac24c8d000000b0050e302db19fmr1131963lfl.84.1702893969704;
        Mon, 18 Dec 2023 02:06:09 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id c6-20020a0564021f8600b0055306f10c28sm2065429edc.28.2023.12.18.02.06.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:06:09 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Mon, 18 Dec 2023 11:06:10 +0100 (CET)
To: Guy Chronister <guylovesbritt@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: google_hammer: Fix invalid ENOSYS warning and
 unsigned.
In-Reply-To: <20231212182038.28530-1-guylovesbritt@gmail.com>
Message-ID: <nycvar.YFH.7.76.2312181103260.24250@cbobk.fhfr.pm>
References: <20231212182038.28530-1-guylovesbritt@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Dec 2023, Guy Chronister wrote:

> Fixed warnings about ENOSYS and bare unsigned without int.
> 
> Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
> ---
>  drivers/hid/hid-google-hammer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index c6bdb9c4ef3e..d567f020bead 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -324,7 +324,7 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
>  	}
>  
>  	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
> -	if (ret == -ENOSYS)
> +	if (ret == -EINVAL)
>  		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
>  					 sizeof(led->buf),
>  					 HID_OUTPUT_REPORT,

Could you please elaborate why this is funcionally correct thing to do? 
How are you now handling the special case when 
hdev->ll_driver->output_report() callback doesn't exist for the specific 
low-level driver?

-- 
Jiri Kosina
SUSE Labs


