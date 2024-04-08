Return-Path: <linux-kernel+bounces-136018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59E89CEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FAEB243BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD81487C5;
	Mon,  8 Apr 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZkvfDXP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F528171B0;
	Mon,  8 Apr 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619101; cv=none; b=tKAV1iQhoSnlutpyvPb1YOHpyVyhSebl4evtv+YMmRw393oKUO9T4e6XDuj2FCE4YA8Prwv/KS+VoLIfXUhbcPff5+BCCCE5w7/r0Sq6zbYOcaO7o8fN/sbVooK3MvZrJ9O8hfMqyGIdAaXXBnv5k2e//nIySEcZw7vudAgLMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619101; c=relaxed/simple;
	bh=Lf20BAMJDntTSPzEumiirtwvbuJ/TuNDUyWB6WEUaSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBNlUsN+JWls0JFLzlBBkX1P2Eja6b/ah0MgkYRml/rx1oCglJXY2KuIeAqM0lkTtc3zK1+tdQL7eqrRZmxBHqKWSHYsQrx/fyAB2pijQ0CQonDqckkUqmg+cCRzjXms5FFEKb8psuEBVqb37m0+3DoA7Pq1NcHmDiTzOdNv7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZkvfDXP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2232e30f4so44333855ad.2;
        Mon, 08 Apr 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712619100; x=1713223900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzTpKViV2Dcm/KyMkuaFPP0/U/kgyCGskJ3yYQuoi34=;
        b=DZkvfDXPv8GMGFHfnBtrdkqye0Zlh3e32nd/YYbFPkvEDotN6qBWDYWxGx2oHAx7ct
         mI9Q+8hy4sFc5KjztOv9GXNWRjttyf2g//E8OsD/Xj3qFpmDfnHoWbLxIIueyB6k9Pj9
         Z29lMSjEoZzwxIWORjl1BRGoe7Q9KiXfqRSJjvyByiVNMDKQQL0QuAk56IuMW9tW8Coq
         +Om7lu+22tQvxR+xSyUhgdqaiwDkT5U/RE+o/tKzBFKNhYGg+Vp1dHivd0LpOl/ihv5B
         UGz8Kxbb4TIhPf1didhscLG5v9IRP0V0vz4tA6Dfmjomch4cl3rmEYBToW9lcHxpvViN
         KUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712619100; x=1713223900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzTpKViV2Dcm/KyMkuaFPP0/U/kgyCGskJ3yYQuoi34=;
        b=dMlhH5tSqXDKvReOYj+UrVoTfRoEZXDnOK89gWxi5TV9esvAcYZjJbQQaFF+tMd4ew
         NJlXewIW+jKmFRjPyy+Th58LG0nyEcF74OidVKEZUlpNG5MtiMwQxVT7iaEPhHDK6sMD
         K/AeS/ZijzxwGZvVqhOoc5PcTZdoAISGGncKX3R4snZSYZisnHPpel1uDpV65AZZTIp9
         xMga5Q9EcY4d38hNLgnTlh7EDBsODuXTVrT5v2LFpuXoxhs5Q6k5ytt98bFc2jwjMYFo
         Bh6UyTJxdewlH/2Tx70u8+O/2cjbJ//1KYuIeGJtVYjqcurDojdqa4pnfy4l1jCVIId5
         CATg==
X-Forwarded-Encrypted: i=1; AJvYcCVtTtLm2uUO/b3OqZOyT51jzthHom30Qxxf2OrZTBH1umCsH1mJs1KTpmpI+fIuX/SK3aQ/pA/nAxt+BhTEC4PKfmTc71BOsZLJ6THpjgdZ7Qd6f1WpOPkBVGHl3wycInrpdZ+C9vLY+MMREM2TxnFxkiuuX+aP1DdsXwS8lT3wIjf6/Bs8768wzPXzpoYy
X-Gm-Message-State: AOJu0Yw8eTxdpcCsfrW5bYxb0MidPyEH6zrspYWgUDCo92DGtV0WorZd
	c9GmpaiSPJXkQcaF48V4LN0gfeaP7sXaOnSa7jDHOg71igWCinrq
X-Google-Smtp-Source: AGHT+IFS3F36fsetJvUPZpbat4+TSuZ7yDpgMTewKajtRAYjXpPSRT5ZA67Q5InVAxnXRnhV/VFnHw==
X-Received: by 2002:a17:902:c946:b0:1e4:24bc:48e with SMTP id i6-20020a170902c94600b001e424bc048emr4222078pla.22.1712619099622;
        Mon, 08 Apr 2024 16:31:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a480:1072:3aaf:99a0])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001dee9d80bdcsm7569687plb.107.2024.04.08.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:31:39 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:31:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, njoshi1@lenovo.com,
	vsankar@lenovo.com, peter.hutterer@redhat.com
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <ZhR-WPx7dgKxziMb@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>

Hi Mark,

On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> Add support for new input events on Lenovo laptops that need exporting to
> user space.
> 
> Lenovo trackpoints are adding the ability to generate a doubletap event.
> Add a new keycode to allow this to be used by userspace.

What is the intended meaning of this keycode? How does it differ from
the driver sending BTN_LEFT press/release twice?
> 
> Lenovo support is using FN+N with Windows to collect needed details for
> support cases. Add a keycode so that we'll be able to provide similar
> support on Linux.

Is there a userspace consumer for this?

Thanks.

-- 
Dmitry

