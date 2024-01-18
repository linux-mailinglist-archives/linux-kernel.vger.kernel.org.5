Return-Path: <linux-kernel+bounces-30446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37A831ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0227E28AD12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F42D60B;
	Thu, 18 Jan 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn0W9XSw"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E32D608;
	Thu, 18 Jan 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600543; cv=none; b=CR1sI/uPbtxXH6mub7BwhJU928Cfmb6aXUifKVyxBjoYm8yWlnoKLPv/JP4MObvPP00fSIrHq3mrBXebRTGfTcybggHvzQA62bA1xP3HGM2ns2w6WMy84zsZX7UrH4xwIhBNBlPqV/LiwnUV1z63R4317aMR+UJaL5OTTqa5AbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600543; c=relaxed/simple;
	bh=fKFKhXygl42NeFOdSVuJarNs+0BLW2bOFf769RHcpgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keOZVvfPZWgySMnEQgzaCQHaN9HVDLmkywNaCQVZSX5UGZM/lbq6tv8A8mahPDgE3fA4loHjmy4j+dmivBuqZSJLhmS0PqQts9RV5L9OpObYnb+2C2Dd0Sm2GgFkC5G6Cg1UwT4dBca0yyue9T+tSfb75NvsSXzxpY07RY/W2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn0W9XSw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9bee259c5so7569288b3a.1;
        Thu, 18 Jan 2024 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705600542; x=1706205342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQV2inHhk6YnIPGUCD6FRidR+XFSr3X65Rn9aWPTRfs=;
        b=gn0W9XSwi8kEzOWnGUs1TkB4E5Sc88iAoNSkDIv0azMJWbzdgtjGUi7v6/ICTu5gRz
         z/nP6TR+nX4wcIOeqZJ2VC/CT9fj+kLwFz6k6h/NQMlR6bVgNLRLPGtN4PKbO+ld1xDh
         jmrINY9kGZ7Y939SZhMBQ3dWCmcSlB/o0J9WubHy67u6xw/Rt/5GC9ziTMdGWjyCkFHF
         y5Pf5xLdsBRN8tbybworuh74zxI9exwolAmV6JFVEb1HknGxuTfbrjIVaMF48LEXhLYq
         ECmtzmf3uJ9Lj0OxGgKRkI0RCLJfWe8bml5/KqMzUngHZY9hQ8M6hiImWVWiH9yZLryT
         HU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600542; x=1706205342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQV2inHhk6YnIPGUCD6FRidR+XFSr3X65Rn9aWPTRfs=;
        b=YIyIYxhpboO/UnKmBGtTae1aIIf1DLG/9/gFhfamCEk15B6hYL/KYrx+2/YjoXH3Su
         zCt1R1NsaKqJQIcD4J66jNuTfT4nb/cYRnwKCuhiV+CitxLWFhjImc/ICzD4CzMYVrPJ
         +ukT111Hje2BHPodd/9nu4lSQ4w6l55Ct5XcYLMPOVTA3rHr48gSJmwLFTAuK/U5EQsV
         RMdPzQMaV3MtMZV1yRsrShdxL5IXHy7LVUZShEv2kBtUoniDvLX19FVvhsvNrOPlUkf7
         Uyx6S2SFTn2vis6DgQo4mfdL1HSps5n/sOYNUJyBIq9Y9YFqm5m9tKvbxeknj+ku/ExV
         6IpA==
X-Gm-Message-State: AOJu0YyVS8LXteVT9WxfflGKr2l/qf52Pa3oGvkaDwMytkNpmrPRTRP3
	ybVtv/GB0CLrAfMkIaD36imxu96aJyZfqGNXCi5UtBJ87Rvh5oMhafRUiI1V
X-Google-Smtp-Source: AGHT+IELdrhwgZSXqBrT051wdOSKlOlhfFGsJhxKGC6nUuSXcUvarjBz1SucjIUHsxFlNa1NFmzVgw==
X-Received: by 2002:a05:6a00:1791:b0:6d9:9afd:82f9 with SMTP id s17-20020a056a00179100b006d99afd82f9mr1271350pfg.51.1705600541769;
        Thu, 18 Jan 2024 09:55:41 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id fj2-20020a056a003a0200b006d98505dacasm3587634pfb.132.2024.01.18.09.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:55:41 -0800 (PST)
Date: Thu, 18 Jan 2024 09:55:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ting Shen <phoenixshen@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, fshao@chromium.org,
	Ting Shen <phoenixshen@google.com>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	joewu =?utf-8?B?KOWQs+S7suaMryk=?= <joewu@msi.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: cros_ec_keyb: add support for base attached event
Message-ID: <ZalmGi_Zlm9HLoBy@google.com>
References: <20240118085310.1139545-1-phoenixshen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118085310.1139545-1-phoenixshen@google.com>

Hi Ting,

On Thu, Jan 18, 2024 at 04:52:43PM +0800, Ting Shen wrote:
> This CL maps ChromeOS EC's BASE_ATTACHED event to SW_DOCK,

As far as I know none of the Chrome OS devices support classic docking
station (not talking about the new USB-C/TB ones).

> to allow userspace detect that a keyboard is attached to the
> detachable device.

Are we planning to have detachable keyboard that is not USB?

EC_MKBP_BASE_ATTACHED is processed by hid-google-hammer driver and,
together with the USB connector state, is used to form SW_TABLET_MODE.
The reason just the USB state was not enough is because the keyboard
could be attached to the lid "other way around" to be used as a stand.
In that configuration USB connection was not active. However userspace
still needed to know about this to activate tablet version of the UI.

Please provide more information why you want this to be exposed via
cros_ec_keyb driver.

Thanks.

-- 
Dmitry

