Return-Path: <linux-kernel+bounces-145854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D589F8A5BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D861C21D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A93156675;
	Mon, 15 Apr 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX0RTb7+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B6156659;
	Mon, 15 Apr 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211128; cv=none; b=CcndDYNK4D50Q4I9elUIdqu2F5v7kJtD8Tn1s5m5votMletJ0D+HsOxagGSOwtGHLMwG8Y/QeIepfETYd6yS3EXui1Er5qlP0beJ8oD0iLozCYrQHhS1QepN+ZR3ri4KjXgEU3doA2wz2UFeZs/NVtG1xbqO+4g71jyN11WMP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211128; c=relaxed/simple;
	bh=hTtSXjX8wwQ52mvZNlG8C6+vZHJXUlFtTNXY13zM7QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXsONEuHE2F7BYBaI+JuwclUKzpCFpz2+uIleCNsgYFAvswlAq8LrQRRw4HTb7aTFW+aukEclXi6l82b+hhrDZlyE1eGskFgwqTqphLJmdot/berAkNZ0KBUz2dwNjCX5leT9Xe9xXeTkdRuA5cXZTwch8gEOh4UialqIDiB/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX0RTb7+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so19628305ad.0;
        Mon, 15 Apr 2024 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713211126; x=1713815926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBd42mgmvxrD8R9WdimJbzSeiQhD8nTqmtgkyeTdRGU=;
        b=hX0RTb7+s80d+cmUuJgJFfRcYi1X5zn0yAfRapESBPRqz9zyS/a8kI4piA3l26l1tZ
         /1prIT14YegMk19CjUB8TmBW7umXGXh+J393ysVI8oIn3lMKANVA40UCaB75WRtVfE9B
         +lGSgvrapGBmZwCj+Dc0mSYuU7TqzGHCpqtnkgljUczhmnq2dcFciY/C+MkeyyITi+TL
         x50PLPgM772CQQ/TTCAvyRmB1/fXtf6OrBak5Fy0h0fX3UVk0NzRkFaKDeElsmduk1NF
         Njc/ltLmF4pCIrPkW8e94nGU9CAp4GKoFmsxFBawnoBUFXozUuM0oo0UyHKjYk9JFQv4
         4cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211126; x=1713815926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBd42mgmvxrD8R9WdimJbzSeiQhD8nTqmtgkyeTdRGU=;
        b=sRNVWANYQsD7SAe8sjh8P8Om+hDfvsibd4PkNHiUfi2DjPj9pnx71j8nqwNkajS8LF
         roMb5ps+NFraf3cOwMTTFlSb/O2UNLeyIL0ESd3amQb4umPVyl4qOXyTwfOnuCKkrvPy
         FBvndcMYTnDRxOJKSsBZiYdMwTmdsNPnjgFzH1z6wp3W51Maeu4sLpa+ptWHWCyKrmQp
         77+JY+RKan75S+bJEdnJTNonBZwmwkC5j3AnjNERB5hp6tvNekT7c+HYm11UOJj3IO2W
         Mj24B7+dJEMhrcLKF+XCAvvYoIf5fPGwy8aFBTl+nUyEDUTjAaUIDVzoS0LbVsebKh1J
         csJg==
X-Forwarded-Encrypted: i=1; AJvYcCVeJYTCkT38VIUeSl4YzhRMypklIIYPgPfwFz3VkYZ7Cr5WhLS+rJTN8n3h2QzsI20tokXZ1OANOPSHWZXABBm1FuSe2ZKb0FtF0FmCmj5ChQX5H8NEvYWza17id5JKr8SvH6bvKeeKp13UIRWRqx7vZiSmdmxD5nEFZSJTRXpVYFXOzFkCxByQIqa5iaWh
X-Gm-Message-State: AOJu0Yy6fBFV3ssR1/5X7OX/lxHKPGXzbiG4wPOhHd6cgrqlUAn6TWB+
	r596xawBCi5yEi5YDktG1XOD0DMKcM47JifwG7RKPAXrWCa6yJqG
X-Google-Smtp-Source: AGHT+IH7ea3KoZiXOIC3+Ronx2QI3xFZgHQdbbyRyw0DuQ+sbEfTPQxggp/eHNMUBJezDbW9ayO0Ag==
X-Received: by 2002:a17:902:8214:b0:1e5:10a2:7bde with SMTP id x20-20020a170902821400b001e510a27bdemr68351pln.18.1713211126309;
        Mon, 15 Apr 2024 12:58:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001e3f4f1a2aasm8348636plf.23.2024.04.15.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:58:45 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:58:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Peter Hutterer <peter.hutterer@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <Zh2G85df29tPP6OK@google.com>
References: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>

On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
> > On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
> >>
> >> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
> > 
> > Please see my response to Peter's letter. I think it very much depends
> > on how it will be used (associated with the pointer or standalone as it
> > is now).
> > 
> > For standalone application, recalling your statement that on Win you
> > have this gesture invoke configuration utility I would argue for
> > KEY_CONFIG for it.
> 
> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
> the GNOME/KDE control center/panel and I believe that at least GNOME
> comes with a default binding to map KEY_CONFIG to the control-center.

Not KEY_CONTROLPANEL?

Are there devices that use both Fn+# and the doubleclick? Would it be an
acceptable behavior for the users to have them behave the same?

Thanks.

-- 
Dmitry

