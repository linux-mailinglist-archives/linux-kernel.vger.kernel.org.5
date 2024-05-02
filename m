Return-Path: <linux-kernel+bounces-167040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AE8BA3C8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5871C22D92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F71CD2F;
	Thu,  2 May 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKaXaL78"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7C57CAC;
	Thu,  2 May 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691423; cv=none; b=qswIdmAzmcS+cD7KN23VVOT2b8athIE/HKGQtqbfgIsWUlBf3GhHdtnlVRIXQYcAZB0VAlCr5Fka4dJoPEm9qd9oijTuKAGbeDatkfGr1rW2M6su4OiXAAYtMn1fuPwaxoZMWLttwLqp6tDMeIpAC2PAFXwx9+erN3JDc6m/Xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691423; c=relaxed/simple;
	bh=G6Jap8EOe5d0b54iT+8/lGbm4XfQUSp5uS/CYQYKHv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8lbQpMGmsidDbYXgGMT8/1Ajc+tUUHYZ0cQh2ZUtIlbcmq/10DXlCBhL3dNRyjS+e8UzhujFUkTEgkYsneyuMqEZEU2Z34PgouQMMQW6RspFZSK/HKSssuO1OnqeuzwhGAZtKTBvshfNp35i+fVCCtZitROF1IGzTjubf/PKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKaXaL78; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b338460546so1535067a91.1;
        Thu, 02 May 2024 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714691421; x=1715296221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oz9GftMyXzxmPtNsK1p52Rdd5H6WgQrupJjfoRwL0HM=;
        b=TKaXaL78EiYs3/X86SI1ITVgQkSaytgOrMgfa/QfL0x7G5PcM0Jwp5FspvyVSCHoWe
         06d5YhoKRnBTY3Qz+aF9lyTjoFppv353zCbFXj8Ag/DctndyRLFJ4LzvmjxGJGOZK5yr
         MwVyyxTMW93jszOMeaJGNCa3NQbysWM56LmZ2Y1VgBJoJwhtK2kBKsYh4LurA4tXEpvQ
         K0md+8j51J+KK5GNAtqY0C0/FjR7ViYVI61LOepcBJmIjMkcaEYaKmN/KPjyH7+9IPx+
         Avtl8GTL6yy4dOM0JeOye6lub5qAu2WLT8YxJReESxjJoDyJSXQscA042QxA/l7AGbI1
         eWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714691421; x=1715296221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz9GftMyXzxmPtNsK1p52Rdd5H6WgQrupJjfoRwL0HM=;
        b=VZSFmhKf+lX0bPT9ktZMuKviXLSjD+JFzf45Bvym3AAPo3kXsOFFjUbEs/QcK6u1ii
         FuiBCedx2mBy55BgRjwb1SlUoq7bH1abSbC2s3RiZJNRXenNQ4NGrFbU8C+9z6YjJEOV
         fLldZIyvaU+KBDeFoBSFUHTRFWqas2+t/QzorNcldFnUMKvk20pRMq426XXJZ9OmoML6
         k2yk5c12vNBG3pA/cgjdiq/LfPR3CAV93GHyfcM+pZYGQEOSWRQxOJ6UAxZ+F821qF4S
         Acb0es0tiHx+vJbXZYXd9osPSqXXnjcXLCbIlDAPlqIgCR29H3Hf45RWpefERHwQ4ZqS
         ultQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbc3t3Jo6LArEjE5PoOLP+sQ6P6v+fkopiqfqm1k8z04xezPk24jsRZGE1Wc34JluMQpSRUbdOEOHAM3L3qNkpTS9rzH4V0d2pMVEd+Utf1j5Pq7mtGplbt8Xjftp0qUYCqgLrVoXid1rkeZaP5SMmuCnxy9tZnts1R+N3rJuWBNKB+oeo
X-Gm-Message-State: AOJu0YzuBh+AQEGV67jOvQ20xEjD2zPetYW6NZ+fkwlrNtNymb3sVkru
	5ztncO41vzjxXwtG+KSmAzcRZSlu0aboj6dWyqsFBIVwCLSodGDI
X-Google-Smtp-Source: AGHT+IEY9+j+0JTSLTL/DcM6sn07kJipTmbehfafbAYspVGg8NXJ6tSgPG3kWISvlCAOemYCjgjOHQ==
X-Received: by 2002:a17:90a:9106:b0:2a6:ff2e:dce0 with SMTP id k6-20020a17090a910600b002a6ff2edce0mr1312082pjo.5.1714691421154;
        Thu, 02 May 2024 16:10:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e24:7949:ee02:ebf8])
        by smtp.gmail.com with ESMTPSA id r89-20020a17090a43e200b002a7e4b99752sm5682894pjg.0.2024.05.02.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:10:20 -0700 (PDT)
Date: Thu, 2 May 2024 16:10:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hdegoede@redhat.com,
	u.kleine-koenig@pengutronix.de, siebren.vroegindeweij@hotmail.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: ektf2127 - add ektf2232 support
Message-ID: <ZjQdWdpmqoXhJeek@google.com>
References: <20240502185819.788716-1-andreas@kemnade.info>
 <20240502185819.788716-3-andreas@kemnade.info>
 <CAHp75Vd1A8sy2Oky9TENUTAj0SCCyVQ8Zh49AN3X7t9cK2F+iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd1A8sy2Oky9TENUTAj0SCCyVQ8Zh49AN3X7t9cK2F+iw@mail.gmail.com>

On Thu, May 02, 2024 at 10:16:01PM +0300, Andy Shevchenko wrote:
> On Thu, May 2, 2024 at 9:58 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > The chip is similar, but has status bits at different positions,
> > so use the correct bits.
> 
> ...
> 
> > +       if (ts->shifted_status) {

Instead of the flag I think it would be better if you had
ts->status_shift and did

		status = buf[7] >> ts->status_shift;
		ektf2127_report2_contact(ts, 0, &buf[1], status & BIT(0));
		ektf2127_report2_contact(ts, 1, &buf[4], status & BIT(1));

> > +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 1));
> > +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 2));
> 
> BIT(0)
> BIT(1)
> 
> > +       } else {
> > +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 2));
> > +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 4));
> 
> BIT(1)
> BIT(2)
> 
> > +       }
> 
> ...
> 
> > +       if (dev->of_node &&
> > +           of_device_is_compatible(dev->of_node, "elan,ektf2232"))
> 
> if (device_is_compatible(...))

Actually I think this better come from data obtained via
device_get_match_data().

> 
> > +               ts->shifted_status = true;
> 

Thanks.

-- 
Dmitry

