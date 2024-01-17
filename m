Return-Path: <linux-kernel+bounces-29453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C969A830E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081431C221AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30825574;
	Wed, 17 Jan 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx4oRFMC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F925562;
	Wed, 17 Jan 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526407; cv=none; b=ORwtVuXXHgpJtcskUrPlbfsTrJTj3yNWCZNHZbPCliioFdycIgs5IxPoRfc+EOn8a4SMrmJMs9BK5ZrleLsAw0Wzu04O57xGSgu95uBOd95s9wTfywN3+XPccoFWo7dWXH85VswQZ7Bs1wkSxMzXimXY/GLhOzEdP1wamG8vhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526407; c=relaxed/simple;
	bh=Usy1X9bR2Bsf5rq6XUwehouKg8Z5H/l9vzbpJtgQvXM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfgXHiFsSAnJHhHkldbHK3slIWkQCXUmIg/2yMPXb8DM4L1DbE8CXhnr3L6zZZyErsf7rgx6fuU2sz027FL7+W0ZlgY0W8aw9pgSzUKkmfmSpsqwcIqfZonDnEQB4ianqypMHEwLbyEdac8dTzcoqqrchfwCNMwnCAxfHhIUSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx4oRFMC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso8537759b3a.1;
        Wed, 17 Jan 2024 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705526405; x=1706131205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJobziSCd9q4uVk2bgj8rZ0Erm0TBOh91NVx6zlbs60=;
        b=Rx4oRFMCNLtPFK0sQf2UKdq3pQF1IW89D/6xFjY7EnWlrKy0wClkmVCB0Oj6xGuMRc
         1K1Y8VNTcJWt7hvrVrzvHhT3xaMgj1GjKMD5iNfH7A+KZLmt0k85Q7d/1kUruygH5WcB
         KexSV07eiMWWjZTmEWM+ttYOJUJFPf5HiZ5ifXza3/3NdzbNIy2Quz9EDf20BFXiOvQJ
         JQtPyRfnI4qc1A83C1G+xg40yEJ2qJ2eaxAMIkzF1eboqfPR3swV5BWQfhN7HHm4IGT6
         72YwVyXRYgKXtio8Or7+uWfz/6/iSbUCzUGuhMGBKtgsK0PBNNMXuoglBwIXcD4cVIPc
         dR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526405; x=1706131205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJobziSCd9q4uVk2bgj8rZ0Erm0TBOh91NVx6zlbs60=;
        b=UyNGZHo/n2PuLHWxIVVZ6FhRKFX6Q7WsMlyFnWQIunNyWWf+0z3Sm3txw406KuLD1s
         Wr3y6fohB/wLw/ZshndKdRfhUl6bEOecv6gBhR0E7UArcLzo3ScBoeulyJpS0n5fuP29
         +JqDnzcUEOouIT/w3hiIbd03rrDmlc7NrYLWOIrRXwmqyl6PCMTiEK+84sPbHVtw0hLJ
         dzaOxIk3DU9KgOjp1vcmTAgFrcvJeuTIHkR3urqBlGwU4OVeMTRLdOcIo5YhINDUHowf
         HMZocIqpuqSp3m5BIjMeEG5sP5meJ5F0sEwxlfaAl+oNagqsWXzVY+vU7kOai0b66jb6
         iZ0A==
X-Gm-Message-State: AOJu0YyQRehuDU+UnPSdl/EtPR09bP01nQljKaBxGZ5guXQ8KaDQmuN9
	/tYLyqc0IMFNoeCagmRxQEo=
X-Google-Smtp-Source: AGHT+IEKKHqMIVLugtAGMMDwvnESPwoXJpmw7xKJqOeKGPA1kqM5iNfKBxnBb817AJ/Xw836xUEd3Q==
X-Received: by 2002:a05:6a20:12d2:b0:19a:2733:58d3 with SMTP id v18-20020a056a2012d200b0019a273358d3mr9785660pzg.85.1705526405327;
        Wed, 17 Jan 2024 13:20:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d414a00fd9sm101716plr.29.2024.01.17.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:20:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Jan 2024 13:20:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Forest Crossman <cyrozap@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for MSI
Message-ID: <d10b63fa-a459-41bf-936b-113f2b8f6b17@roeck-us.net>
References: <CAO3ALPwot01+bBisj7Roog7SD9UwV+y4NtiakKrBDE0tPvFhbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3ALPwot01+bBisj7Roog7SD9UwV+y4NtiakKrBDE0tPvFhbw@mail.gmail.com>

On Sat, Jan 13, 2024 at 04:27:55PM -0800, Forest Crossman wrote:
> This value was found on an MSI PRO X670-P WIFI with an NCT6687D chip.
> 
> Signed-off-by: Forest Crossman <cyrozap@gmail.com>

Applied.

Thanks,
Guenter

