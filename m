Return-Path: <linux-kernel+bounces-148665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8478A85CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049F31F22F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5A14198E;
	Wed, 17 Apr 2024 14:18:29 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497021411CF;
	Wed, 17 Apr 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363509; cv=none; b=OOf+g1t3UMwaBP0FGQDIyM+627Rdbgkj2SQjsaB2g3/MIwZ4YwrJn+7ikMvz0/HuhtNVoKblCUKnp5pUR8ISlCkZj1dtPbzac1k9RxQhEMBhe1GTG+h3YsPq1yBxMrrjUuAnzDCodwnlmnGeIholhST3IlJCxW4eVA1r7zLjbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363509; c=relaxed/simple;
	bh=WaC2druakjJV+zFjmdeikwA3CiyuPhwF8v+9yEn8j10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpTsN9n1YIFznBF/oxG2wioPwUme4TkhyapOjjXiUs+jJTjZAiPckSDufJewJXP04sokyqCYiXzDMVNhfCVFnaNs/qhTPWX16d3Q1JWnbrYh9c5/TajJkqBLIK2JxhMtTAHdxee0QHDwtFcyolxA22gO+BFDBjrRV4J0LnjFul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61af74a010aso17307637b3.0;
        Wed, 17 Apr 2024 07:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363504; x=1713968304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avO898yqsUcNC4lZWFklgBAuRw3SczTcgwrfOeGT8Mg=;
        b=Ncm2Yga1n56LP7oXyhMsBNhPxWhbDQSEYBs8ULP+V9Odr+RKmvYIUObx/wyL6ptUir
         vBCaxqYyEZ2fURyhssqDHNIGKvNe4pQubEgyiEvk2EWfW9TX+xJWla37U5tW8mfCUYC2
         GnjHtf9gHYMA6KvG9PMSmh9iM4rDptoQFIJWJKdWU/Q3s83FviT5mCJAZ80iaUcR2zXm
         ctgP2t/1SxlafP6Hf0tR6FxNHtEhRfUjEwlDPf9fTmh1n+DoJEmfJS7VACMsMEh/wr2b
         9zcbPhSZPkdEFLsnNCGBySOTwATza+O+01tgmBetzcaTm8d1Z4OoU0VtfHG820beSmBP
         VITQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSkGuH7Bdkez58ADtazhBuXlKENhvGJxNT4YQ3wjmi4pfZlnFev4+98tkjvqAFgqy/MASHnJVBUe4m70pUidsX91ML7wIB7ZCyueZmbBR4pMirqkHkezbhVe5ujY/idpenaiub1hkwUBubRFqSaBbPql/1OaYf2txi2bihEvYw7yG5UqHOeodf4FW+E/6/hHiG9rsV0xeEgwprE/2425XWJgvjMRD4LzhVP3D0wWJzdGJqN3FbIIcLg4sToWD0hs+yCAvttsdyV9sj0XSZARPWwHqkl0WaJP7NK5S1WPvZOJReDwIC4z92
X-Gm-Message-State: AOJu0YzGCjhrCmJSG4im9P3cdJY8gQTvd0tG44uyQyx8YI+lQoRjyOZt
	jeFr8pnJGIvUMtbc6qv2Q6cM9X0IUIGSm+k6Tn77TtbLfImle0DVktx29RAv+jA=
X-Google-Smtp-Source: AGHT+IFNO9uc2PTPZrzIN0HtgGbUW+GpsqSP8Iw4/SFGdULVtPKSlG1+gVUNT/iY40JpD87PHMZWGA==
X-Received: by 2002:a05:690c:d1b:b0:61b:123e:7210 with SMTP id cn27-20020a05690c0d1b00b0061b123e7210mr1232006ywb.40.1713363503429;
        Wed, 17 Apr 2024 07:18:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id jf4-20020a05690c700400b0061129ac87fcsm2976926ywb.113.2024.04.17.07.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:18:23 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de45d4ca525so55953276.0;
        Wed, 17 Apr 2024 07:18:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsKjbTmAezX/6x3516iFFJ8JJ1Ek8ovhwn5lHF7UI7NriWn6QKXZ9lYeTSseyxUw39gVPS1Ius+N6BQ5WSaWvJwdLAi6aCXsk5AlcGJi5XKU+NPrz5b5wVVAj2BTaB+gmF6/uSsJ6JXX4Gj/oxYmpoNIa3h8F1sULE9k7eRpa8mSUG/zAdC3LZXqsoCdKpCWoCpMYf1soi3igM960If8T5pFNOMP7/tlMLfpOaXvI+odT3cpaRBvhoCMXSYdd5Ti7ZcmLYrRr91VQ6u/l81gLboQ5qSCHv8ENaVYYQmvapHaFk2mMd5xSh
X-Received: by 2002:a81:ff02:0:b0:618:94a6:6ca1 with SMTP id
 k2-20020a81ff02000000b0061894a66ca1mr10536616ywn.27.1713363502402; Wed, 17
 Apr 2024 07:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214215756.6530-1-mario.limonciello@amd.com>
 <20240214215756.6530-4-mario.limonciello@amd.com> <Zc1JEg5mC0ww_BeU@intel.com>
 <9831e9bc-d55f-4a72-950a-684a757af59c@amd.com> <Zc5cPjpNZydqKeS8@intel.com> <ecbaadf9-dfa1-46af-9a7e-cfd7aa1120be@amd.com>
In-Reply-To: <ecbaadf9-dfa1-46af-9a7e-cfd7aa1120be@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 16:18:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1XYpu3JeP3W-dZpO8kmN75XckuPRnw2zLW-ZqD4634g@mail.gmail.com>
Message-ID: <CAMuHMdV1XYpu3JeP3W-dZpO8kmN75XckuPRnw2zLW-ZqD4634g@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm: Add support to get EDID from ACPI
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, linux-fbdev@vger.kernel.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Melissa Wen <mwen@igalia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Thu, Feb 15, 2024 at 8:04=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 2/15/2024 12:47, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Thu, Feb 15, 2024 at 12:20:56PM -0600, Mario Limonciello wrote:
> >> On 2/14/2024 17:13, Ville Syrj=C3=A4l=C3=A4 wrote:
> >>> On Wed, Feb 14, 2024 at 03:57:54PM -0600, Mario Limonciello wrote:
> >>>> --- a/include/drm/drm_connector.h
> >>>> +++ b/include/drm/drm_connector.h
> >>>> @@ -1886,6 +1886,12 @@ struct drm_connector {
> >>>>
> >>>>            /** @hdr_sink_metadata: HDR Metadata Information read fro=
m sink */
> >>>>            struct hdr_sink_metadata hdr_sink_metadata;
> >>>> +
> >>>> +  /**
> >>>> +   * @acpi_edid_allowed: Get the EDID from the BIOS, if available.
> >>>> +   * This is only applicable to eDP and LVDS displays.
> >>>> +   */
> >>>> +  bool acpi_edid_allowed;
> >>>
> >>> Aren't there other bools/small stuff in there for tighter packing?
> >>
> >> Does the compiler automatically do the packing if you put bools nearby
> >> in a struct?  If so; TIL.
> >
> > Yes. Well, depends on the types and their alignment requirements
> > of course, and/or whether you specified __packed or not.
> >
> > You can use 'pahole' to find the holes in structures.
>
> Thanks!  I don't see a __packed attribute on struct drm_connector, but
> I'll put it near by other bools in case that changes in the future.

FTR, don't add __packed unless you have a very good reason to do so.
With __packed, the compiler will emit multiple byte-accesses to
access multi-byte integrals on platforms that do not support unaligned
memory access.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

