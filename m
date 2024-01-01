Return-Path: <linux-kernel+bounces-13859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0E8213AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794AD1C20C05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A82915;
	Mon,  1 Jan 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxbhWv4O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2762112
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704110991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Azch07lTg84aB2Rb6QjZFZSA7yP5wkRdozKvJbeWmDs=;
	b=VxbhWv4OI8qgXzu6nPdKroWOhGx40xSoFaClqwUM+hwhAH1Fz5QqeWThUAE8TEHIJ/RTlw
	1gnAoejXd5sOJmfmgReTS79QuYJykZ9HriQR8VXr/xFK0CpCoCc18NXvYxGfPMD+IxzUh0
	ZdtvilvTZhxF7LqWeymcvs+aukMs2qw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-B0dyLQ3qM0q3PL8FSK6s1A-1; Mon, 01 Jan 2024 07:09:50 -0500
X-MC-Unique: B0dyLQ3qM0q3PL8FSK6s1A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33694552b9aso5227496f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 04:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704110988; x=1704715788;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azch07lTg84aB2Rb6QjZFZSA7yP5wkRdozKvJbeWmDs=;
        b=M/yzuOz3Yk0lL+dYqIMq8y4eypY0AouNFZPgikvy/389Xh+qKiBkAz7BwB9SeyfmAq
         iIDFVSxbGQUalhy2MqYU3DeEL1tzj1jixp6rXIoyS56YLtMChNbgKPYISRGPe00/upMj
         trJsRxAN6KCeF2A9lmfn3wHGmHtRqL536vXrdfpUQ/y9bB9u3XYZrGWxbW/qvYp1yxRe
         6wGfQK5a+t72eFx9c8H3aRpJAUJr5BwqpxVKJB6T0eEu3HrA/fSY4TvqzByhU6f+fUDh
         bdDT/oST7fDeYZKY22RKrp/t6+GJg7TvafNVz5n/230kCL1dtytswNHYjHjnR9ZcgYWl
         GNqw==
X-Gm-Message-State: AOJu0Yyg+v0Oeqahn55l1Ijtev9zDunvYj6sr06opSvlsvmQoDdyHiGt
	KC1gC488Y/8H0h9GLbVdox51BpgLjQXEnLxvZmnteKRNy4sTX0BFakeI8w6Ui130wO5/PsvZJEH
	U1yUt4OIndGdfoiZ/UFMIb761ySNLFEgjMNAVF/qij7armm15QWdKuWnZhQRfc+cOCRJq5wU8qD
	cHfkVwlg5hApiziWvo
X-Received: by 2002:a5d:4491:0:b0:336:9ec:683 with SMTP id j17-20020a5d4491000000b0033609ec0683mr7965590wrq.24.1704110987884;
        Mon, 01 Jan 2024 04:09:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKWyLHJ5nrPlW/ehgVUQA9HtsiYksOgMjOeLi1VaymrGEKk3opJ5Q2oDMaXVlvjQ2jZaz94A==
X-Received: by 2002:a5d:4491:0:b0:336:9ec:683 with SMTP id j17-20020a5d4491000000b0033609ec0683mr7965565wrq.24.1704110987518;
        Mon, 01 Jan 2024 04:09:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00336843ae919sm25513643wrm.49.2024.01.01.04.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 04:09:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jocelyn
 Falempe <jfalempe@redhat.com>, Conor Dooley <conor@kernel.org>, Peter
 Robinson <pbrobinson@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/4] drm/solomon: Add support for the SSD133x
 controller family
In-Reply-To: <20231229112026.2797483-1-javierm@redhat.com>
References: <20231229112026.2797483-1-javierm@redhat.com>
Date: Mon, 01 Jan 2024 13:09:46 +0100
Message-ID: <87ttnx45md.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> Hello,
>
> This patch-set adds support for the family of SSD133x Solomon controllers,
> such as the SSD1331. These are used for RGB Dot Matrix OLED/PLED panels.
>
> This is a v5 that is basically the same than the previous v4 but dropping
> support for I2C since the ssd133x family does not support that interface.
>
> The patches were tested on a Waveshare SSD1331 display using glmark2-drm,
> fbcon, fbtests and the retroarch emulator. The binding schema were tested
> using the `make W=1 dt_binding_check` target.
>
> Patch #1 and #2 are fixes for the DT binding schema of the existing SSD130x
> and SSD132x families.
>
> Patch #3 adds a DT binding schema for the SSD133x controllers and patch #4
> extends the ssd130x DRM driver to support the SSD133x controller family.
>
> Best regards,
> Javier

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


