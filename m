Return-Path: <linux-kernel+bounces-78361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06835861261
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44EF284C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257780036;
	Fri, 23 Feb 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EOLLiRCw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2257E792
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693993; cv=none; b=LFyiYp9n63EZi1YtglyQeiD6MwfH0W+csOVwk54cp5u0yePOKVlcUkLW6l2JEbISylRGZjofStDGiMdudHAB0wmPVRsV9Z+qLyOCHvM0qahsHIEpMI3MSY07CCK/9o5yg8oTaSooRIC5enJV2xgqFbLChUuyXb4v+ZtHYi53WK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693993; c=relaxed/simple;
	bh=4grHiU4R1PD3/h/EWJQy/p4KaYw4FLcc4bf8AIrkiSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgwW7Bw1q7u6dQMTzPPbqsLHPSuJLHxinYxq8MJyuvg3xVdqlUcQgwKJ02BlX8T/qeJCRJ1aiI+vszVgHg1kvYpAguQPPPO4tikd3pe0QU1sPIssbLaUiW5pHEMgEVYZT2uZ+6kkS5x09Vl8crfhJmeoFuIPdLXaSXLg/faEl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EOLLiRCw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso874130a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708693988; x=1709298788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPpNnmfH04qPvNbsT+ao1sGUr2DFS6Kf08IWPwABmJU=;
        b=EOLLiRCwK7gz+5rXH0mnxGFnuDugIc5VsqSDcn9i0ZdKx+Nyy7+2kyVRRok6+CNLVj
         z35/ms+yVaowrPaDo5ThpgqH0ZUOH0gBV4umNatbx3AU/9OuykHI9ZJ04y2TMkjbah2n
         slFlSrHdBXFPz+stp1zKCTjfEAVLtntIPTHryxH6kXd7weJGDzZfbita9Xs4VxEbHlAP
         2BxIPCcIOmUll7PpaQGbdlDZdKMOLIQ8P80c1h8xzOK003XFiva3xguxrK/Xrqznhh/g
         h7ze2lzzqHXtUQnWn6n1d+PCijxcAx4CbLnsOfkHfwl11yDeY2FDsu/VLfVebZZmgLVw
         7pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693988; x=1709298788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPpNnmfH04qPvNbsT+ao1sGUr2DFS6Kf08IWPwABmJU=;
        b=QBe+6l2WCegy0Or+wPLOsYCnpkzXwfKqA6My/AP2sKosw7t+Rcht1ZCiJK49Ae/BDk
         pU1mhwQOIyNMh1NL/2yu/xWPikg02Km916ln/LZ6AFb+NkTApY2PDz9c4BCr6jHc7wvK
         33rB04WJF8phbj2MP1JyKvsvyAQeqTCCKr+kO9V1H3VgCA9ivD4o9zknqU4LKgWYn+iM
         LrAerM1p4o9hm/oIP4GFoLWvvR667hytfTnXvtmy+pfY8Oa57SuBK+YCOsLOVS4w39Lc
         /qNW5lyK6WUeQzlagv/2s4l8q8tdxcDcrCF9h7C2YaN2Sg20BQfkDOqd5ePwrHJh5GS7
         EZdg==
X-Forwarded-Encrypted: i=1; AJvYcCVPFEhz6+qUgZ2SXQdKoP4zXGtutrec0Wpwhfqn705vb916aMmHIOgNDW6WIxAwF74sx68fru6iDs6U52FGYTIXvDntGZiedzENzPK1
X-Gm-Message-State: AOJu0Yw8+A/32Q33A4XyUAqlsWxZhhAuwhLiW1ewOTmL7KIb7LQ8X/8Z
	fIvqWn95DRdW2hM+Yx9DHVVW0Lj7Y9ENMF7+cqfgU5sHWaBCM8AvAW+/bzdV/cjktATsFZr+01Q
	4
X-Google-Smtp-Source: AGHT+IH3miX4jc/k/19xdvTV9lj2s9RXaKpcoI9yKpZYRmENr3yuW6k5ZiDLlOerdnnNOwl4rvdNBw==
X-Received: by 2002:a17:906:55cc:b0:a3f:bd94:4d80 with SMTP id z12-20020a17090655cc00b00a3fbd944d80mr1248043ejp.76.1708693988309;
        Fri, 23 Feb 2024 05:13:08 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3e28471fa4sm6339835ejc.59.2024.02.23.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:13:08 -0800 (PST)
Date: Fri, 23 Feb 2024 14:13:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 10/26] printk: nbcon: Fix kerneldoc for enums
Message-ID: <ZdiZ4jvgHwlbEJuo@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-11-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:10, John Ogness wrote:
> Kerneldoc requires enums to be specified as such. Otherwise it is
> interpreted as function documentation.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Good to know. I havn't been aware of it.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

