Return-Path: <linux-kernel+bounces-18305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C649825B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B7C1F242DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71AB360B7;
	Fri,  5 Jan 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7XfTSHM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C836080
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704483537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMoO1LwsnCwYYN8Uqa/kdGfXrJudOewzUd2AdmdxnGg=;
	b=A7XfTSHMFV5d5K4TARGMyJk1POuOnqdo9gbQNifN1g72biSa0ZtR1KHn2wlN9ELiEGAjiD
	phYBwWPDN2UnfrK2uC1Z1DjvGqdqbMf/CS6dhljQ2wrO0PTE4HsatCLymaSRkwYw+eeCqB
	BVJr9bZbank6W1O1ksPlnJiJwsNH36A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Ra-UqumTPkqU_FN8mlhaiw-1; Fri, 05 Jan 2024 14:38:55 -0500
X-MC-Unique: Ra-UqumTPkqU_FN8mlhaiw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a27eddc1c27so105915466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483534; x=1705088334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMoO1LwsnCwYYN8Uqa/kdGfXrJudOewzUd2AdmdxnGg=;
        b=UjLne3SxuMtt2ZMFVEXhoOxD9uj0u/OkM+x3yMDH1YNxEx/upJazD6Az0atTdWRJYU
         eB/SCLIjV77jDnLCbgB84jMoz2FFhI9eoF7XvA+YNWzBmsW7tiEiETzbOmHSFBL25V1o
         236zvjeULq9LKIEcFkCXlLByL1AwL9zoSw+VuVxm1l4sOLsnQLsexVW+VlgZaP46D0/M
         K0AhFaz1aHzbSC0neEYeXTvcB+klrAvtdyJYTLflhb7aM5qJZVKgyNa/ak4eTiU7NmEa
         +Shdv4nK8CewyMt9gs9ZIH1LVQDQyggBifp+LOvcQKENbYimvADCgAlKJxSgfHszHmZp
         pF2g==
X-Gm-Message-State: AOJu0Yz66c/sLfkrlyzBzkkfTNRlPyLXeCPqCP1d1vIJMcfw3LV7jU9b
	hmgOEiUCSjptbJt1q/riN44wm6gf9T1MeOHjBqXcQ0V8LgbFer//6vd9xejF3U0QOMYl6VE+8XD
	n7p2PKgTGntv6ZBTU2aCDa8ze24WC9/9V+th8O/r9
X-Received: by 2002:a17:906:4:b0:a29:bf51:6a9f with SMTP id 4-20020a170906000400b00a29bf516a9fmr59341eja.127.1704483534006;
        Fri, 05 Jan 2024 11:38:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIe7gBV7svaGGAmiOaLupilSDdw+HCLNuh71F+XKeYIMeOeQyhpMW/qR+BLrPPq6e7J9OaHA==
X-Received: by 2002:a17:906:4:b0:a29:bf51:6a9f with SMTP id 4-20020a170906000400b00a29bf516a9fmr59338eja.127.1704483533782;
        Fri, 05 Jan 2024 11:38:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b00a293280c16csm1083021ejb.223.2024.01.05.11.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 11:38:53 -0800 (PST)
Message-ID: <78c03189-f965-40b5-8aea-3a1294102e84@redhat.com>
Date: Fri, 5 Jan 2024 20:38:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] i8042: Use new forcenorestore quirk to replace old
 buggy quirk combination
Content-Language: en-US, nl
To: Werner Sembach <wse@tuxedocomputers.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240104183118.779778-1-wse@tuxedocomputers.com>
 <20240104183118.779778-3-wse@tuxedocomputers.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240104183118.779778-3-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/4/24 19:31, Werner Sembach wrote:
> The old quirk combination sometimes cause a laggy keyboard after boot. With
> the new quirk the initial issue of an unresponsive keyboard after s3 resume
> is also fixed, but it doesn't have the negative side effect of the
> sometimes laggy keyboard.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/input/serio/i8042-acpipnpio.h | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> index 10ec4534e5e14..e631a26394e92 100644
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1142,18 +1142,10 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
>  	},
>  	{
> -		/*
> -		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
> -		 * the keyboard very laggy for ~5 seconds after boot and
> -		 * sometimes also after resume.
> -		 * However both are required for the keyboard to not fail
> -		 * completely sometimes after boot or resume.
> -		 */
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
>  		},
> -		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> -					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
>  	},
>  	{
>  		.matches = {


