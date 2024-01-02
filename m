Return-Path: <linux-kernel+bounces-14332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE19821B85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D291C21EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F478EEDB;
	Tue,  2 Jan 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZb8FQ3H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47479EEC6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704197811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPlLEBXfhLSd7sMzVTM760zSh1zEAP22oRkr84xyyqI=;
	b=XZb8FQ3HHrMvOJEtsLIxQvGSirAGsr9l5SfZnqH84+3XK2wiysFk8aa5sBJ7pTbK1/PgYe
	fcYlxaMbXaB+KCD590CBwD7ol/3RYWugBumKEktNgcl/8bFE9l+5/jNwEoWUsNtBFiqVYi
	4uCCSPokhZkgInHzPjfXFuoeqd+K3ZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-fHBa-TNVOY-M2IThzyzP9g-1; Tue, 02 Jan 2024 07:16:44 -0500
X-MC-Unique: fHBa-TNVOY-M2IThzyzP9g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d890b4536so11598085e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704197803; x=1704802603;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPlLEBXfhLSd7sMzVTM760zSh1zEAP22oRkr84xyyqI=;
        b=Z1Wl9kaYpJ7iCNt90j22UajI3eXu0eXWraFm0cdIgoSb/dFq6KiyK3n2lYd72SvE7T
         rVzz6FxZATSEYAPgfdlfDAMSH1XKr2B4GgBamVoUjzFMAI0BOUMcUOYIo+hYHyNtef86
         yrcZ80EvHmnVx/LmjYxOT7Z2fdCYAGBgfP27CSymgIQk22WhTvGC+PqFTXAsVk42P3BY
         1Hi+ZROScXo+BasPynWYjIF0xxAFmEbjfBHpPA/ycYtaP3Gl1RIAHmM50LIt9/4vancs
         6M5GUA2W1I+ROvOENHNMYeo8hbc3c4Xdp8DLnvx/1vd0IZRkds6h49h/tTZS75ZKgbqU
         oYeQ==
X-Gm-Message-State: AOJu0Yx5T4Nw/75S2wekm06CLUKTtfUiEVCMheqhBuuwwoL1uU3kQO3t
	q6MXDrOG0dU8o9ZUvGJ3FpUp0hzP5qKQKyrrczIOMasC8lGFcGd5BviX4gBmmeQJ3whm7kbxLBT
	iN7O8HZJ12vdbwyCjZD890kGkceDcwpF+3uguQKzKIcc=
X-Received: by 2002:a05:600c:c0b:b0:40d:8cd1:736a with SMTP id fm11-20020a05600c0c0b00b0040d8cd1736amr380538wmb.50.1704197803225;
        Tue, 02 Jan 2024 04:16:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2XMn1J/fN1Ic3hG9b7blPM6E9SLaxWfy6C+aTMS068vBjt/ls9arEBPcmBeFFxfKG97ZJA==
X-Received: by 2002:a05:600c:c0b:b0:40d:8cd1:736a with SMTP id fm11-20020a05600c0c0b00b0040d8cd1736amr380535wmb.50.1704197802896;
        Tue, 02 Jan 2024 04:16:42 -0800 (PST)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net. [159.63.51.90])
        by smtp.gmail.com with ESMTPSA id fa8-20020a05600c518800b0040d87c5dfe1sm8469244wmb.8.2024.01.02.04.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 04:16:42 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard
 <mripard@kernel.org>, dri-devel@lists.freedesktop.org, David Airlie
 <airlied@gmail.com>
Subject: Re: [PATCH] drm: Move drm_set_preferred_mode() helper from drm_edid
 to drm_modes
In-Reply-To: <87y1d80x3l.fsf@intel.com>
References: <20240102111921.3057255-1-javierm@redhat.com>
 <87y1d80x3l.fsf@intel.com>
Date: Tue, 02 Jan 2024 13:16:42 +0100
Message-ID: <87o7e43p79.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

Hello Jani,

> On Tue, 02 Jan 2024, Javier Martinez Canillas <javierm@redhat.com> wrote:
>> The helper is generic and doesn't use the opaque EDID type struct drm_edid
>> and is also used by drivers that only support non-probeable displays, such
>> as fixed panels.
>>
>> These drivers add a list of modes using drm_mode_probed_add() and then set
>> a preferred mode using the drm_set_preferred_mode() helper.
>>
>> It seems more logical to have the helper definition in drm_modes.o instead
>> of drm_edid.o, since the former contains modes helper while the latter has
>> helpers to manage the EDID information.
>>
>> Since both drm_edid.o and drm_modes.o object files are built-in the drm.o
>> object, there are no functional changes. But besides being a more logical
>> place for this helper, it could also allow to eventually make drm_edid.o
>> optional and not included in drm.o if only fixed panels must be supported
>> in a given system.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  drivers/gpu/drm/drm_edid.c  | 23 +----------------------
>>  drivers/gpu/drm/drm_modes.c | 22 ++++++++++++++++++++++
>>  include/drm/drm_edid.h      |  2 --
>>  include/drm/drm_modes.h     |  2 ++
>>  4 files changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index cb4031d5dcbb..48dd2a0a0395 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -43,6 +43,7 @@
>>  #include <drm/drm_edid.h>
>>  #include <drm/drm_eld.h>
>>  #include <drm/drm_encoder.h>
>> +#include <drm/drm_modes.h>
>
> Unnecessary.
>

Indeed. I could swear that saw drm_set_preferred_mode() being called
somewhere in drm_edid.c but looking again I see that's not the case.

> Other than that,
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>

Thanks. I'll post a v2 that drops the unnecessary header include.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


