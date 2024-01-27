Return-Path: <linux-kernel+bounces-41265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6983EE34
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8913B1F22807
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00A229431;
	Sat, 27 Jan 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDXyRMUZ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460B2E632;
	Sat, 27 Jan 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371475; cv=none; b=CKI4zCNAM4UwsjVRsCGkvIU9wEiSOWcHYG0RjOjWxlwjFWpcK2dtJFtGM6GSXo79/4n6qyZrEQs6rHuij96mS0VTXlITbSaGQkdu5ri4xCYretCD08jVVyq0/ZqHbcT8ZuPqhKkJNLKRqwYx7pyRAuV4m35EwgPs38GOVM1Sl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371475; c=relaxed/simple;
	bh=XzAWz2E95iHyjrd89f4/TJqp07CUnOUXukexxaJwLBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5iineO4hXW+d02Je8PFa+OsBXDWJCiRgEzsotbUpjC77CtRJ38I9cn1X5JSO9G95WZVFZtJBO7Ui2f3c8LKuEiSkCpY0VlTtePK5yykaKNYHlNEzcqWFptX7KuhPQqaHn0ibh1tExXyM1v1A1+ycH7EjvFGPl3fs00Yh7fEk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDXyRMUZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b276979aso457956a12.2;
        Sat, 27 Jan 2024 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706371473; x=1706976273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZdFILiLbRsP6hGM3Tt4xKM8/T2MZ9WlHwj20zfGDaY=;
        b=KDXyRMUZCdGs9XHX5E68zI70zKyd3Mnjxusgi07keD+foLcuQ5wQRLkn7ascZ/Mmj7
         k9Wd5NoA1nbl5XPz5ZOjKO/z+bhNcB+gDoOeSPhK2RxF4j+GOutZr22oMLTKr8svA3RX
         H7j4z7J2TiVsMf/arxn29qEM9E3RH/DwXunaXdSjSTj7jgoCUnYIgSqE+3HAI0ukLv6h
         PLdlbiOrAO71Rhw3nifZMeWg0AYiQW+099t5+ple+D/asv8a3HGfYl0MoH1q6yMHcdsL
         AEN2N0PSN7szbBumriBYOTVfJ0TCRQBF9Z5NmbsW2nDcAzC6VeDb+2ZNnMJW+TZoliZy
         8FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706371473; x=1706976273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZdFILiLbRsP6hGM3Tt4xKM8/T2MZ9WlHwj20zfGDaY=;
        b=Df20c8a/ce5oytKTXNbGNiIKXV4ZiO8C7JeEbVOAhLGh//i5NEVnb13BhAsYefVsNy
         fxI1s1KLLW5GJTdBmEucUDgVZEay+7p/NA5y9EBTKt2qQGbUiJks0xCeY/sKo5zDI9Nf
         Vi8dKQyHpAUh+rb1yplLCfGecBcNtfAMS/VU7Nh5RCEW4+9zACvXRGiaMgD/3jACj49F
         M6kzZldvKwp0C/1k6o0GPMzrBTHQcqr/TQkjnEPkF0aOQI5CCXW9eAr97RkofsSmYXpx
         xKc9W5pfr1BxHr+QO/jowkCy+sRPU+F83iE/+uiHM5gSj/0PhmplVzB6gYGB+WaATgPb
         YW0A==
X-Gm-Message-State: AOJu0Ywa20g8nZkPPwbOxyo9Xqv4HvplskMhRg1sGxkM46mfae2SodIL
	NXg2Pt1AQrh/73evR3y4xU2aGfNtIe72NzH2JP6qAR6MUmEVSwqI3YSvC9ek
X-Google-Smtp-Source: AGHT+IFuF2/P9rmHM7xXw0buGLPX8VeqnYplAUqMzEjslwytidjh0bpbkii3bhxkgdQVWGbKwxslRA==
X-Received: by 2002:a05:6a20:3546:b0:19c:95eb:ba5a with SMTP id f6-20020a056a20354600b0019c95ebba5amr833273pze.108.1706371472937;
        Sat, 27 Jan 2024 08:04:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id st12-20020a17090b1fcc00b0028ffc524086sm3094774pjb.24.2024.01.27.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:04:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 27 Jan 2024 08:04:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Correct comment inside
 'mp2975_read_byte_data'
Message-ID: <71614451-66e3-4427-abdf-e1d0950c767a@roeck-us.net>
References: <20240127154844.989-1-aladyshev22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127154844.989-1-aladyshev22@gmail.com>

On Sat, Jan 27, 2024 at 06:48:44PM +0300, Konstantin Aladyshev wrote:
> The current driver code no longer perfrom internal conversion from
> VID to direct. Instead it configures READ_VOUT using MFR_DC_LOOP_CTRL.
> Correct the comment message inside the 'mp2975_read_byte_data'
> function to comply with the driver logic.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Applied.

Thanks,
Guenter

