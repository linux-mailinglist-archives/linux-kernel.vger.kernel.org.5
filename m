Return-Path: <linux-kernel+bounces-55666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A0084BFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1E1B21712
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2381C298;
	Tue,  6 Feb 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfP/Zf3z"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140701C282;
	Tue,  6 Feb 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257069; cv=none; b=iNHyaylWuBko96DDksFbTpo/ZqzfO/cwrKdJAF3dZF5GYd7QQYOX/sN5SJsLrktHnoMCPWmvbZlGO76hWC5KehJ6ZyWaLldrEm7xN8JW6dEOJlvjwAkhQApyr7hbTcMBUGK83jpUt0pVdZIGAruArlbmIGXXmQBh+niiuaYYiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257069; c=relaxed/simple;
	bh=HNFj0Tll2vGXlhgpsYBVvDJcOqd1cX/WGM9VGPSYLLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKGm5fN4BrnLTR1Dx8Ebof4NSDkigz6bWthCKRisXF9C4q30Amk4aPnbhTi3gvUpZtNp2KGJ8RLoDfAvMEf5vpO4DTxO/CKQsYZ+TGb2nvUowdgY1+SPqznrx6sIT927sD8ESBknaT7mkEuZ1F75seKVy6gmqpBpE3toZFfVoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfP/Zf3z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e054f674b3so11323b3a.1;
        Tue, 06 Feb 2024 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257067; x=1707861867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K10sZoh6Xgt2Wbd/c0Z4AznT9qZkf92alPX991Dp40c=;
        b=EfP/Zf3zwoVAmc9UPImz4O9497NUuxj/Mb7vqikN04uHwXTg8k6eRQxoPVpKLtfqkS
         aZ9eWQ8rh8FDPI18NTnVB6YGpr1+MHqCMVNIgXm2zUE1tApsRo5ZqBQ2//H6o8JoRRvB
         BUkoR1H6sSfhnPOCy7wzoAyjHW7uqFlZg5LliGo2/wKN+wnAqav46TEL27D5xE28geoZ
         0MVTpOdgvrWtF3IR3vbkEqTVoHx6tbrr5csuJZP5QaAsPrVfSFEb+Kn/tLNRJW4dTchi
         eniSZjfkv3OlSN7c/p3kpFfFeN3FraR/OpvnCQ8GGTK576rn9Ao0KPqD2Ar0DOGraxEA
         0vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257067; x=1707861867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K10sZoh6Xgt2Wbd/c0Z4AznT9qZkf92alPX991Dp40c=;
        b=qA/MtwrLqq3Rd6vO+p0LgL4L+JH3K9kL37I/FtdEiX3NTktMKfTFUbLnMnLZ0SN7jM
         +GWXtfgxS1fx3qDjd/gY4mCPIUKU5YwGHn/vvH9P+JmdcwV0MbG936g9JvGgzkKa8oQ6
         qpKevpisEKz1RkqwrbL60km3rq/yD6pkc9jBM33oHGhc92/ZcJn8Xsm3wJ0sT/ezRrkU
         UBYPFzZr3E4Sf5dKjPXp7AGpMMLpM2yNkHKD0EbOoKSWtRzXxXGDgnMqlEos4D9tyVcA
         6TzBc4BzemlQ2HEvlJ6OW7fdakVfjS7EJyv9VJfCj+wdJIqYV/8zS2C/sJdnZ+aSvWh9
         XMDA==
X-Gm-Message-State: AOJu0Yz0v95atA+unSxMbUT3UFnpV0LFeP9hqHZbufDLmr+/1bnvdxvr
	QnxETuyOGQRtm/UokGou2EEPD2Xw7ShaurL6YouKVTXpVOOnwftM
X-Google-Smtp-Source: AGHT+IFNfLBvKU6abINRmGfulY1RMsCB3E848y+XTu5siSJwvz6vDKngep7oa7/eU9knqF41qGqTIw==
X-Received: by 2002:a62:cd4f:0:b0:6e0:4b47:8216 with SMTP id o76-20020a62cd4f000000b006e04b478216mr675241pfg.16.1707257067136;
        Tue, 06 Feb 2024 14:04:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVUoQhcQu62NypDcMoGLO4utDW0R9UcZ8N/IDu8Ytbc0YxSalaoiEV9z1fcCri2CcgMKYgbEhROzomBMOnrBubaNWtIFMpD9pI0q1y74b/GgSsREBWrirRsdvovBq+WEF0/Dt7hoD40Ko/ro4s24VwLomwymawKl4yccYjH3xljRFxWmOhBMzBkxSqmwRHDbD5mS/OxtgAvFLmce3q/N62oNyLFk4UDZUDGrQ==
Received: from google.com ([2620:15c:9d:2:52fe:6180:e1c7:7fca])
        by smtp.gmail.com with ESMTPSA id z29-20020a62d11d000000b006dd79bbcd11sm2564591pfg.205.2024.02.06.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:04:26 -0800 (PST)
Date: Tue, 6 Feb 2024 14:04:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZcKs589qYxviC1J4@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>

Hi Jonathan,

On Thu, Nov 02, 2023 at 07:52:47AM -0500, Jonathan Denose wrote:
> Some elantech touchpads consistently fail after resuming from
> suspend at sanity_check in elantech_packet_check_v4. This means
> the touchpad is completely unusable after suspend resume.
> 
> With different permutations of i8042 nomux, nopnp, reset, and noloop
> kernel options enabled, and with crc_enabled the touchpad fails in
> the same way.
> 
> Resyncing the touchpad after receiving the
> PACKET_UNKNOWN/PSMOUSE_BAD_DATA return code allows the touchpad to
> function correctly on resume. The touchpad fails to reconnect with
> the serio reconnect no matter how many times it retries, so this
> change skips over that retry sequence and goes directly to resync.

Why can't we do this in elantech_reconnect()? I am sure we can make it
simpler and more robust than what the generic handler is trying to do
with polling and everything.

Thanks.

-- 
Dmitry

