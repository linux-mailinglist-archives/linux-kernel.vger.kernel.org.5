Return-Path: <linux-kernel+bounces-27896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F882F771
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC6EB24164
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6D22321;
	Tue, 16 Jan 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtfMdCak"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C11383AC;
	Tue, 16 Jan 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434461; cv=none; b=Cm4xysANkgJ0ga1k/TC7tUB47LAjLAIiDicK90ecguZD2ECAz5vjFJAtoWg5fFYnOva2EYkw7hnCNhWo0jFER/SxE0gwtNigRNTiIkDkLOHj0RcmFp/sraTM8rd9n/1w9fGZ30mBPM7TUTblyXWAaNd6+pLOlBuvxur3+Msy7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434461; c=relaxed/simple;
	bh=xDOnRslm8NpOghkEKFADYeC4y8yRZ9tjFgiXnzzxmZc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=aTHmTMFJ7s27LwmeA2ej15SmbOjtkwOddrk1NsDFKu9Oe0uwucdpBwjRsRln3xRtfZ4VOabXoAbMAVErWM5/B32/SVaLgY32r3A9xu9CMXVZXMOxrHO2/Kuvqi7EdkxKaP+1tZ6zFKNjY6wTF+8lE+PrfClWbF8rDmgtqEm5b6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtfMdCak; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3940519a12.2;
        Tue, 16 Jan 2024 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705434460; x=1706039260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBRl+AOWeJy2GX0abNdKEQWVu+3zjK0hUonu45aV5s4=;
        b=HtfMdCakdYXn1Ut/WHmaNoMNEvjZsO2WxD7mf0vHjJ2ATVge9ccUuvcmCuYDMgCKU7
         HNyi77cic2n1SljCTb2dYpKNBXvzbT+OnNYmYmfsTFaSbAujJwe1JFrzDS3F1W8WYX2z
         RA57cETJSq3Mntw4tQkTmz/79H+QcRqh3X4+y/RYNDa5696WpzGL21y9qknnA6RnhPvA
         zQXwqn/2w3zK5MV9LhtV0MRq4CHWHsGOEMwpewUBJ7Sh1gA9i1eViT9/To3I17o3O1TA
         0CEc/yQbu5+eeURIE80sK2uh4YUgJ67RABgc8jGAfeyf4gonOEGUdRC8YQ0JYRWHCwjG
         RTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705434460; x=1706039260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBRl+AOWeJy2GX0abNdKEQWVu+3zjK0hUonu45aV5s4=;
        b=e0BskcByqg0yIYKZD7oF1kt8q8II/ygAzlBhSRulqGJasD09U5s3oM+b+tG7znq46J
         NpJ3rrq3+1MuVtrQaeYefQNvF0TmtiyOw3gWEZWmc54Iq5lCH+JL3JAjZg//gu/m/OQK
         6Qon+0WkQTQyAvP83dIbdYTFLZILLn5q25pbfGn2Rd4tCx2tnyzjcQ5h9jEM4oZYzD4m
         +VBX1SV2j9EOq8H0s21KkrYp3z3rZ/2Pey9M8HNYMNbyFciYOn0GiE4AWLsKUDX0uQSa
         A73xr3+NZmtCVqizHp3INc7X3sYI3r+KRJ4oAjsj6YpG6YLBFrDOqrWkJEcS8460hJgp
         JZ9g==
X-Gm-Message-State: AOJu0YwLZaixsXOxIW9tg08V8aRHlA2CBx7INC9Di8bZ4rtRkXorrLxP
	AUY60HOlKCjdGHezEx91wiI=
X-Google-Smtp-Source: AGHT+IGpguyzzSo/Uf4Wj8VoJUmfEa3izp0PhtpVxW5xbxMtTZQZwsDj6eUKKBeczO2lPA2tmTsn7Q==
X-Received: by 2002:a17:90b:46cf:b0:28c:fb86:23da with SMTP id jx15-20020a17090b46cf00b0028cfb8623damr4483069pjb.72.1705434459893;
        Tue, 16 Jan 2024 11:47:39 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b001d54c4184ccsm9610717plh.182.2024.01.16.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:47:39 -0800 (PST)
Date: Tue, 16 Jan 2024 11:47:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Russell King <linux@armlinux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] input/navpoint: remove driver
Message-ID: <ZabdWMa7PyQhuPfa@google.com>
References: <20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr>
 <20240116-navpoint-removal-v1-2-593ae4954a83@skole.hr>
 <ZabS88WnVz9avRv2@google.com>
 <12362783.O9o76ZdvQC@radijator>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12362783.O9o76ZdvQC@radijator>

On Tue, Jan 16, 2024 at 08:45:43PM +0100, Duje Mihanović wrote:
> Hello Dmitry,
> 
> On Tuesday, January 16, 2024 8:03:15 PM CET Dmitry Torokhov wrote:
> > On Tue, Jan 16, 2024 at 07:17:48PM +0100, Duje Mihanović wrote:
> > > This driver does not use the SPI core as it should, instead tampering
> > > with the SSP registers manually. Besides this, it relies on the global
> > > GPIO namespace. Refactoring the driver is almost certainly not worth it
> > > as it was seemingly only implemented in the HP iPAQ hx4700 removed more
> > > than a year ago in d6df7df7ae5a ("ARM: pxa: remove unused board files"),
> > > so let's remove it.
> > 
> > I think this clashed with some recent cleanups to the navpoint driver.
> > Could you please re-generate the patch against linux-next or my "next"
> > branch please?
> 
> I have done it. Should I wait a bit (how much?) before resending or is it okay 
> to send v2 right away in this case?

Please send it, there is no reason to wait.

Thanks.

-- 
Dmitry

