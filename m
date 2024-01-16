Return-Path: <linux-kernel+bounces-27728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E967D82F4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD2B22E26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9401CF9A;
	Tue, 16 Jan 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIrHqnQg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8D1CF8F;
	Tue, 16 Jan 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431801; cv=none; b=SeQ7Gb/1fc/YwoqKJIChHt3c4cFFCroUFJjSl5oDiGEDXmyeytSI6AND9VTCl0zJGqckOlsxoZhzMoJyO7Bzt/DxFqaQOcZFwCMynfHlvNETqdt7oRfLWsUuHDiiCCQ2hr7YNG3EGpIUUx8eatSKbliijyjxVyyuM4WaXIYY70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431801; c=relaxed/simple;
	bh=FJi5Rz/Ct21jxkMGzJBXic2R8TpcMAp8GPHicEZDiGg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=DXKjggyaxRubjeW1QDLP65caJ9lQQak7cC38MClN2onCSXwqEpzGO54dM3SXqiCrJy1vkufQuQ89w+JFfpqOjEq7t75PSN+h+0EyvK2RQbXTjcEkpEeAHrsfq8Wab7XlSXAg6gKGX0ISRniU7/NupRZ+85frAKSF3+zKb9Vd+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIrHqnQg; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso5681414b3a.0;
        Tue, 16 Jan 2024 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705431799; x=1706036599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kq8izapE0NfSMoGMRCpBWLSDRMNP/HU9b+0WJFWPDcg=;
        b=MIrHqnQgd2UccMX7YLV/1SpJ5AycttVFES5VIAttLo+pznYaUVDz6whloXw5VwRagJ
         +cKTFFuyklPRHqtXmJiOVQJLvIBwFkE5CN/Ss2mUn8INCPYtCsjGnJPuHwMSgMPSc8ak
         GG2bZhf3+Azij7qskRVmGyPGL7bjPfCMaK6M8ZJeQRAuPtOKs30W/2KrEZZTl7c/T9VW
         8c7/0aqUhtFYEcPIbIG3estBLVARPyFzf83MffdDlv5gM/nRmis52PJbHl+sFkd0Cqk3
         c2OrQkIPk5DXjMXx1LSO7bBbC2b0hT71BheCG4ApZs5ibLksMGoRyYdXvDpbg648cFEB
         /1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431799; x=1706036599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kq8izapE0NfSMoGMRCpBWLSDRMNP/HU9b+0WJFWPDcg=;
        b=N8UzTX3VUUfQFY/XvoVhpczAzWS0OsVmOvJj97zWDNVpIX4HheVTIWSzsO4vyu1lE3
         Q0Zsvez/e8yCpU4gdkK4mGSnRqOSS8jaI9cvq2NnC16u7ZVrC/iSy+WWKdtn9Y6Gd1ka
         cYcX1pn39ZNCrOF9V7H0X/1/tq8Zp6d0Esn69N6ohJL8wJdcKXypcth3CfcarfUPouDb
         0pB4sGYniIbYv6dHzRjcM5aqMCexMeL5ulOer9HVoxjYeN+kJ/d9wJNaH8VkVxsTJSps
         UwZElAwKCFVWSrZEIdmBid7vpMMY2UlzZDY9xB5wnNeHFUZ1y3MTOrGZ6jCZ9BthgeaO
         zB+w==
X-Gm-Message-State: AOJu0Yzdh5bOSQVtB26wlI0ltVj0B45pb+b67hmfkkL+QGLzpuGCCb2y
	YVabpel23TXeXCSBV9eZCtLzqQ2ocxY=
X-Google-Smtp-Source: AGHT+IFu2uqg5PePdr72uWSqdZyqnFQpkGxCNg4amB8BshW09bXZ4kYtnC9NbeKX2EiqY6vM+gHc6A==
X-Received: by 2002:a05:6a21:3183:b0:19b:624c:c7c1 with SMTP id za3-20020a056a21318300b0019b624cc7c1mr89673pzb.28.1705431799023;
        Tue, 16 Jan 2024 11:03:19 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090aec9000b0028feef0f956sm221473pjy.17.2024.01.16.11.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:03:18 -0800 (PST)
Date: Tue, 16 Jan 2024 11:03:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Russell King <linux@armlinux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] input/navpoint: remove driver
Message-ID: <ZabS88WnVz9avRv2@google.com>
References: <20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr>
 <20240116-navpoint-removal-v1-2-593ae4954a83@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116-navpoint-removal-v1-2-593ae4954a83@skole.hr>

Hi Duje,

On Tue, Jan 16, 2024 at 07:17:48PM +0100, Duje Mihanović wrote:
> This driver does not use the SPI core as it should, instead tampering
> with the SSP registers manually. Besides this, it relies on the global
> GPIO namespace. Refactoring the driver is almost certainly not worth it
> as it was seemingly only implemented in the HP iPAQ hx4700 removed more
> than a year ago in d6df7df7ae5a ("ARM: pxa: remove unused board files"),
> so let's remove it.

I think this clashed with some recent cleanups to the navpoint driver.
Could you please re-generate the patch against linux-next or my "next"
branch please?

Thanks.

-- 
Dmitry

