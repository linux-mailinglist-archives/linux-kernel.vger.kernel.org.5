Return-Path: <linux-kernel+bounces-93086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C1872AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318F71C2343F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494C12B17E;
	Tue,  5 Mar 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vba43/zp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7912CDBD;
	Tue,  5 Mar 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680653; cv=none; b=mVwphZfrVGYf/arV0gvjJ6AAU/MIrXWKYTr625Cgy26ORD32rHM9ZkDMm/UGLPYtBiwudJpXiil+LMWVkKGu3WNdriGDt4M4u+eC9RblEcYwZR55W3eKwYO8XIFrOWuPbb52FBDCe/d/AlAQ53yHP5bxX0wWf4jzfVnGStTZQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680653; c=relaxed/simple;
	bh=hAQXXtEpci5/rqG5hNT3/xrRrrFzIAMrqiDRFDsqivc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTS4hTgOnjVgIl1rnZ9IJ8xI6Dihqq6YKCtGoJcldbxwsJoMOEFgv7Me5jN0FWSpXlZ8tS/6XrtoP+ixl8KtdTiK+Y4wahBbjNC4Uw2ARLIkhFf46q32Z6hOyYt6kiQK/NMXwWNC9C3FR4AboxmbMBZrrU7YGL6Mt8qjEJ+TeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vba43/zp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0e5b223eso53731465ad.1;
        Tue, 05 Mar 2024 15:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709680651; x=1710285451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kAiofd41xTmLhHdy9IDUcWKAST66CzURKTeO5duD9w=;
        b=Vba43/zpKCp1jINc/8A7xHYaBAkzRfWIlzmws84Sgc5htoe+P9QhdBW34Gnrh2x9u8
         3rSblgcfAjDwPvG3O3QI8p7aNz29tXr4y7swxiArD9wQC2YERgZJGDEzHrVYpLmFCG5f
         OzfIQagXP781XX7WSb/36XIJhOlu9eSCjfuS3S5eJ4ausDptCRDvxLMZWh1cvd+aRfSr
         S3AX9GrdQGK2c4A3PlWi06m6ME43hPeV2NVNBPHYiL5X8PYKCsBOJ61QFiA7oWI8tL4y
         3yDlBByUjpJoqQYdC/mULd8qHNJJpgdN9sz+wU+Ut5OghqJd7V88HGwi4ivnT+hwq1U1
         hKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680651; x=1710285451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kAiofd41xTmLhHdy9IDUcWKAST66CzURKTeO5duD9w=;
        b=U3AzeVw1OUePZIiO6Mx3tNiTF5SR7K41hZ3nYgKMTTuHGrG9ocU08GoodHtGYZv8Jk
         IdW1OIdmgRSyNC2VPzXn1oKiz8zHqiQGcbH4MpMGs5X6vE4VuERNJzywcix9aWwOpKKk
         LJeJHjOsbKwSugTPBpM8sZmOd8sGghqLQp1pjcYMVNdEA3yiR83v2eJe7yk7A1PV5rp8
         ZVQPSU6uaoPH7f/IFj9bX6/uDC2xm6ts359u4w3p7t8SBKSL+FsvoB+F/jMwQ3ZV2lKq
         /o/C3tx2vSEHv45Lvfyv6DfFjYDJvgkdvvlnGdqRnM7Wsl4BIE5gzOMWkL+puAXl6ayh
         2qxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOR/T+0pk8DvubYIWXBOXwcgQ7rVUPOO+CtJFwn4Kb04aiEB8Bntogd02x4qRydb/QPVu8+HGFD3Va6DatE0Sf0U/qq3npqycRfE=
X-Gm-Message-State: AOJu0YyQjNahJbF8pxaOMpTIWP2pAx2KXGImkMAz/WzqzZS6QdjLbZNT
	hZa9S8c145Ll3oQB7msaHt1Ohi/vWzOVMV9krRTZIhGENDyjpG8mwddW/OQf
X-Google-Smtp-Source: AGHT+IGrKGFiKrQ8r1cAOMn/ooa6FZcEMzzBWBIuR2cO1XKgo/Q3HxKH8XvehN0XSAghUngAwYmFCQ==
X-Received: by 2002:a17:902:eec3:b0:1db:f389:2deb with SMTP id h3-20020a170902eec300b001dbf3892debmr2970443plb.17.1709680648399;
        Tue, 05 Mar 2024 15:17:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b1d1:58b4:d9ca:da78])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b001dcc29b985csm11133635plb.134.2024.03.05.15.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:17:28 -0800 (PST)
Date: Tue, 5 Mar 2024 15:17:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com,
	Jonathan Denose <jdenose@google.com>,
	Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
Message-ID: <ZeeoBeUwz0__lVLM@google.com>
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
 <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
 <ZcZ2oG1Rls-oR593@google.com>
 <CALNJtpWNbSZdpxky9hTiSRsaGgLDUnM66QGEy213d3Lhra0hsw@mail.gmail.com>
 <ZeDLq9gPs5InBmdK@google.com>
 <CALNJtpWwhen2H9OT1-rZ4bt+huwXPOPz6qVDJ5g+emE1wRSLsw@mail.gmail.com>
 <ZedotW8Yu6tJ2yYL@google.com>
 <CALNJtpWHxk8yWVSbX56JC3KThCZxFpUQMkikE9kc7hrawPdH4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNJtpWHxk8yWVSbX56JC3KThCZxFpUQMkikE9kc7hrawPdH4g@mail.gmail.com>

On Tue, Mar 05, 2024 at 03:48:29PM -0600, Jonathan Denose wrote:
> Thanks for this.
> 
> I tried the patch and unfortunately the issue still occurs. Attached
> are the dmesg logs.

So this is without going through suspend/resume, but straight up boot?
Could you please post the whole dmesg, not only data from 8042?

Thanks.

-- 
Dmitry

