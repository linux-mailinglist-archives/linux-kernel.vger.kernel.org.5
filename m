Return-Path: <linux-kernel+bounces-163086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B618B654C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35013281BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296B190690;
	Mon, 29 Apr 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlxaXxUf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B282D90;
	Mon, 29 Apr 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428119; cv=none; b=p9yS2QhQ0txJABSSk2FPUzos9bKbGN8q3/a+DNCcxdf+93ZtBHSNxLvASUWisEElUcYGtVX83egevNP1q9rDuMj95GuQwteUdHCgzs+sPoAQbgfF1Ka0NMM0zNC/xPWpcRmZh9SZFbiczah+hSPuW6D8cfmHYLtXtXVG0qja7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428119; c=relaxed/simple;
	bh=n3EhX6iUB39aEkFmD1PaEAZbCSpeFyZeZta0ddHROW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXrEBCOX7VNSkUP4qnrX01IqKZjEP8nkXuozlLoNJRljYgJAKuO01ZlPhxyGsdi1iYaT2bh/603166HlOFvT2MtIo/Idp+ChGJTj9neZw0Rmz33a6PF2DT0MSjZl84gUniE1eKNxd/BvzlFW0C3+sgtfXRpHBE1lG14/Bbf9gVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlxaXxUf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6effe9c852eso4498298b3a.3;
        Mon, 29 Apr 2024 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714428118; x=1715032918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWS61cm+ZOsf3SgYfREAM4Ybr8shBq+dbRG+Jl5IjkM=;
        b=mlxaXxUfpLGgXChDF5Jw0twwIOhCB+tWgqy6XOiVtUVJJRlZAO7p++5yCOdrnAqWXX
         vLleoTqg/7imh1DKpHIXtRS00DiAPuEo2/bmiUBY8i5q6DsyPLmqwIIpy/BpFouwrdOV
         4imnP2VTFZGVaPmfj96/sQje4gu0i3HCrcJIMZJMM8Qp3vyuuYeeSYBuH/WU+TalVQY0
         XgLUvSFbT+qSG64eyzICQEYq+6uyNsiB6OfoAFsRQYQ9LyATnmFVSSweWqrqVZ8SJHOn
         YWIpcc7N1LsJQdv3iwx5OKm3IuoagHqoCG0jE4qCCDBX+IvcGGfJMkMAOvn4hMeY9tUT
         vwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428118; x=1715032918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWS61cm+ZOsf3SgYfREAM4Ybr8shBq+dbRG+Jl5IjkM=;
        b=W7OKH9Vnn8RmmrNX3rnQ0axizK8kXSUyrdPxoQVPLR+T0gDld7iakykcUwGweb/Pia
         8wRkw6FPZxNBesOoh11HqWGoXBqzOzKIMLn4OBwQMC0z4+fZw4pMB99Gb+C368TySrqd
         auwuSZjt80O0+GSp7fYPZ4MtrjKjELjutOmuht+4CLYapyaf6SQSS21XNHDi3Dpr4YKL
         GY5iME+FxKPykAQ09LrovZnj3p3ibSuGIxNS8B47g//G0T2XzXZr4K29zShPmr56t02M
         wzriNN36wr/LvVYtjP7EGi29uxZpYFHyA9UGrko/vHo1iBLXNK6N8+wuwMqA/iwh5KG7
         WJbA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8f0NZ5ZCmGmuYpa1sxCnli3AwFzVi9cohLr8aORTjuAS4896pW2R98XXptrWALm61wLAeIU/nBmeL7MNgow2tyNGKI894T3zSNuc
X-Gm-Message-State: AOJu0Yx6rZy7hijbwJvNDUvFdsQ1RPx4EB7viBfAZnjEGzG9DZbxkwj7
	4tMXxeijhnNUAuMAhdJOOP6O1yaQI8zM8q6QZ9C63gnGSvJI8zIe
X-Google-Smtp-Source: AGHT+IGN3wwOy5bNYgcEj9kiIOFsi8iMs6oL9VTmMGAHf87Js5Q3zYsIXsSSrppzt9/2QPgpCjAMJA==
X-Received: by 2002:a05:6a21:3991:b0:1a3:8e1d:16b8 with SMTP id ad17-20020a056a21399100b001a38e1d16b8mr14141482pzc.28.1714428117581;
        Mon, 29 Apr 2024 15:01:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f2d8:c41e:613b:df5a])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78e02000000b006eae6c8d2c3sm19786376pfr.106.2024.04.29.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:01:57 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:01:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: try trimming too long modalias strings
Message-ID: <ZjAY0uFxeglmMagh@google.com>
References: <Zi2vDUZuVAEh4-yS@google.com>
 <CAKf6xpv76BO_n2VSAcbRfWowceXjiBSKHjx1nGakXzFHUiS6+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xpv76BO_n2VSAcbRfWowceXjiBSKHjx1nGakXzFHUiS6+Q@mail.gmail.com>

On Sun, Apr 28, 2024 at 07:43:52PM -0400, Jason Andryuk wrote:
> Hi Dmitry,
> 
> On Sat, Apr 27, 2024 at 10:06 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > If an input device declares too many capability bits then modalias
> > string for such device may become too long and not fit into uevent
> > buffer, resulting in failure of sending said uevent. This, in turn,
> > may prevent userspace from recognizing existence of such devices.
> >
> > This is typically not a concern for real hardware devices as they have
> > limited number of keys, but happen with synthetic devices such as
> > ones created by xen-kbdfront driver, which creates devices as being
> > capable of delivering all possible keys, since it doesn't know what
> > keys the backend may produce.
> >
> > To deal with such devices input core will attempt to trim key data,
> > in the hope that the rest of modalias string will fit in the given
> > buffer. When trimming key data it will indicate that it is not
> > complete by placing "+," sign, resulting in conversions like this:
> >
> > old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> > new: k71,72,73,74,78,7A,7B,7C,+,
> >
> > This should allow existing udev rules continue to work with existing
> > devices, and will also allow writing more complex rules that would
> > recognize trimmed modalias and check input device characteristics by
> > other means (for example by parsing KEY= data in uevent or parsing
> > input device sysfs attributes).
> 
> I think adding these links may be useful for cross referencing:
> [1] https://github.com/systemd/systemd/issues/22944
> [2] https://lore.kernel.org/xen-devel/87o8dw52jc.fsf@vps.thesusis.net/T/
> 
> > Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thank you for looking at this.  I think this idea of truncating the
> modalias is better than just dropping keys.
> 
> cat-ing the individual sysfs files works, but there is still an issue:
> 
> # sudo udevadm trigger --action=change
> [  601.379977] ------------[ cut here ]------------
> [  601.395959] add_uevent_var: buffer size too small
> [  601.412009] WARNING: CPU: 0 PID: 630 at lib/kobject_uevent.c:671
> add_uevent_var+0x11c/0x130

..

> Another path needs to truncate the buffer?  Or the problem is that the
> total uevent buffer size is what matters - not just the keys modalias?

Yes, exactly right - the driver core may add more environment variables,
such as SEQNUM=, HOME=, PATH=.

I created v2 of the patch that tries to leave some space at the end for
these additional variables.

> 
> My other thought is wondering whether the presence of '+' will cause
> parsing errors?  Has '+' been used before - or will it be an
> unexpected character?

I hope not. It is after "," and not a hex digit, so old code parsing
keys hopefully considers it as a separate part of modalias. I.e. it was
coping with:

	...-e0,1,2,4,k110,111,112,113,114,115,r0,1,8,...

so I believe it should cope with

	...-e0,1,2,4,k110,111,112,113,114,115,+,r0,1,8,...

But let's see Peter and Benjamin will say...

Thanks.

-- 
Dmitry

