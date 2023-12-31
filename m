Return-Path: <linux-kernel+bounces-13676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0BC820AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9191F2219B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DB20E7;
	Sun, 31 Dec 2023 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt64JhWT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27233D3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704016179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06P+yxJB7L9syooh76lIMfJszoozMlJlWrSMKYy7B0o=;
	b=Dt64JhWTXxXJ215ZNW24UdCo4U1/HH/SbPitULkTqlDUwanKppApFvcWCMs85ldG9JUGmD
	TBd3uKj+rgpXWY6zPchp+9YpinHlhtgwl9jUpuhEFNO0apihE0/HxfbweCbgPnZwyia0LE
	u3aHB2gXWJQYdT25OFYWA9D2M+JkYrc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-l9VX_GQiOZaV-xiSwL8ZmA-1; Sun, 31 Dec 2023 04:49:37 -0500
X-MC-Unique: l9VX_GQiOZaV-xiSwL8ZmA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e5195db01so5939937e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704016176; x=1704620976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06P+yxJB7L9syooh76lIMfJszoozMlJlWrSMKYy7B0o=;
        b=wS/aYboqKZilx/qIMlRHjODgKTKzz5hiHssKber54ubs4wxNWHdehS/Ujy7xnqn/aU
         XCkCKl1XBRC8M3YrFLsFWH7vpkcnWorDgCc7efZYjNeTbu+h+LpuNTP9rLzWq/WchJ2X
         8NOMtXcMWJSjWbQADbt3ry1PyODndQaNku5sYofBi0ghRza/FrUtBRP8jveUfrLkz8qS
         ZPHegwuqT0MbOGnVGxuRJkupgrupecbJZ7WJYMnjVwO1Ye7n4Nl13hfPzY8hXhWhgxz9
         1pACrHV2RY3/6RJcplHnlIeMoqhDXT2AUepSh/isGun1i265xu4WsoKWxRklOw9y5BYE
         yxcw==
X-Gm-Message-State: AOJu0YxpjsAhQw7aaLrTahYSANe1t0T1xig/CaN1xKVyKSlnyr0joiT3
	6aAbL9ZFjPGRt6mteMQMaypVqbIPlnmtxeVuainz5qM+V/5xtLs012eFbRwCskNXsXF6KPkImw3
	0nste4Yq2RcpGM7lG8wlcjy/fbYrelVsA
X-Received: by 2002:a05:6512:2829:b0:50e:80db:e39f with SMTP id cf41-20020a056512282900b0050e80dbe39fmr4774744lfb.92.1704016176151;
        Sun, 31 Dec 2023 01:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG52VEr9QrD/BgWs6/s2qz/PU2Mi2WBqZxTlZbBoK18i20Z61V9yGvs4iactVekVpgx/gx4kA==
X-Received: by 2002:a05:6512:2829:b0:50e:80db:e39f with SMTP id cf41-20020a056512282900b0050e80dbe39fmr4774738lfb.92.1704016175758;
        Sun, 31 Dec 2023 01:49:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p12-20020a05640243cc00b0055493aa8905sm9894390edc.63.2023.12.31.01.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:49:35 -0800 (PST)
Message-ID: <da90dec8-b0f3-4ebd-92fc-a33ec96b4905@redhat.com>
Date: Sun, 31 Dec 2023 10:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci: Fix spelling mistakes in
 sh_css_mipi.c
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223064152.79712-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223064152.79712-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 07:41, Dipendra Khadka wrote:
> codespell reported following spelling mistake
> in sh_css_mipi.c as below:
> 
> '''
> ./sh_css_mipi.c:177: separatelly ==> separately
> ./sh_css_mipi.c:540: ofset ==> offset, of set
> '''
> This patch fixes these spelling mistakes by changing
> "separatelly" to "separately" and "ofset" to "offset".
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans


> ---
>  drivers/staging/media/atomisp/pci/sh_css_mipi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_mipi.c b/drivers/staging/media/atomisp/pci/sh_css_mipi.c
> index b7c1e164ee24..6e11fd771938 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_mipi.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_mipi.c
> @@ -174,7 +174,7 @@ ia_css_mipi_frame_calculate_size(const unsigned int width,
>  	mem_words = ((embedded_data_size_words + 7) >> 3) +
>  	mem_words_for_first_line +
>  	(((height + 1) >> 1) - 1) * mem_words_per_odd_line +
> -	/* ceil (height/2) - 1 (first line is calculated separatelly) */
> +	/* ceil (height/2) - 1 (first line is calculated separately) */
>  	(height      >> 1) * mem_words_per_even_line + /* floor(height/2) */
>  	mem_words_for_EOF;
>  
> @@ -537,7 +537,7 @@ send_mipi_frames(struct ia_css_pipe *pipe)
>  
>  	/* Hand-over the SP-internal mipi buffers */
>  	for (i = 0; i < my_css.num_mipi_frames[port]; i++) {
> -		/* Need to include the ofset for port. */
> +		/* Need to include the offset for port. */
>  		sh_css_update_host2sp_mipi_frame(port * NUM_MIPI_FRAMES_PER_STREAM + i,
>  						 my_css.mipi_frames[port][i]);
>  		sh_css_update_host2sp_mipi_metadata(port * NUM_MIPI_FRAMES_PER_STREAM + i,


