Return-Path: <linux-kernel+bounces-161521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A228B4D22
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E60328148A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935F7319A;
	Sun, 28 Apr 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlfERago"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874A6F065;
	Sun, 28 Apr 2024 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324882; cv=none; b=ciin4prVnuW2eLkBpkG3G1iYKDr3Yk49VzQZmG+BSzb+HN7VwlrMcoXb/Vu9mad3li+FnEvmiWBKuN5uvCTJLal/34j2nzSC0sftB+vLqbPYjwU6RNfB4Kk9ihHaSmM/aDNJh+bdcusV4z8Yok7qtdPHoaNBeD3ZbFREMtO5QME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324882; c=relaxed/simple;
	bh=l+TRwc4SK57hrCFqHKsjP/S3s1bJJILdySwK7QAC4SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzvDA5hETuC47CMAlV2UGu1+3QJbSjq5N3Bmn5XPvHxmNAK9ti9ZR44XexOv6cxo/nvHNnjE4ZOtwM8klO78Z13yVW3kJN3vL7zlvR4g6UvNp4PDVZEL+2ioiTxASG21s3IsglecxUDR4XX1kCA+PPH/V7o7VexI+BvwlnxhYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlfERago; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so3517387b3a.2;
        Sun, 28 Apr 2024 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714324879; x=1714929679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JLevVTxq6ZZOLTNMIkGE22eEmTvnawbgYiIB/nO72M=;
        b=dlfERagoGF9RS9dO2tJnZZGvfAIktH7DNwRFaUI+ZHs1bq1wal0IbZ7Dy17juNfOxw
         T/DXetjFW1np6Ed39VRpS/lU8O59mUvwTQ8qXuNMJymCl7JurM6+liGDdUdc+kOIvItO
         gwlxKFqgu+39040dXiXdhLmd+8/jdQbzNudPVCZuJzfFfe1bHNRZG+tt2+2Z8tHLegTi
         C46c+X+EWjdC0ZfETFJHhEEK9lkyuuq36mcezF40peT7Op/FyQWSbeyTd4qkXIdLlfE1
         Yv9YuUc20ZfMhH6/TTk4jVdusuH/Yl8VW3VWdyhk5fgfM9F1J+9MLqcRIqQa/IQV1tUA
         bxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714324879; x=1714929679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JLevVTxq6ZZOLTNMIkGE22eEmTvnawbgYiIB/nO72M=;
        b=Iotk3GBogYxINUgK8Aqok7tEj+TKWouUMoIUWY9ufSq/5sV78950TwtwZ3B4Jsm7yt
         xmtPL7RvdmEcUx4E6Xo2JZej1K+xGBDbVt82MdrHWA7vATwPkMzQm3qtZbm+q02ihkIo
         GSwoMWR+tuvlMI7PflQk+Z8e1CPja9HOgeAmlmth1S3HgpcxxwmjOT/9J0MkMvjD0bes
         HnhB/niKXK1mFeFwsx30/ER2dmcjr6cvHXiYwTFcP/vjIP7xTahjOg8bA2eiUNjrmQrv
         YMj6BjMxQQOhggJanM+ORdBOd3P0gW2HVe+CLDw16rBaUYyNdVgYLbsQzWwRx+JC4BL6
         tVrw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Lwcky79mJVau0gZxtRzATozIZN02vMHV9mxBMxGdfUeK7Kwkq84uR9+X3LPRu4fDQUDLQi3ocDFr16AjHs9tetmLPJMR5XxaPtZ2FJcV/GK7Ih9PKyZcU2gZNNUTJg72YlfxIziJ
X-Gm-Message-State: AOJu0YxZrj8N1mZ8Y9PkFFJZugoHBbk4PUaQC0KWtOefHJTAn5GOLtvz
	u5WYNIjOiHjCw4Q9EXQnDWqf9fETk0Xvu78PUTcWoLe8RMKJX3li
X-Google-Smtp-Source: AGHT+IF7BsPAFHnzNOThRrbh3h5F9XsQXvHByAPJbG8lwEiQCfjWq7mPa0aFpUtvhL/bPqv7YoISpA==
X-Received: by 2002:a05:6a00:3a0b:b0:6e6:970f:a809 with SMTP id fj11-20020a056a003a0b00b006e6970fa809mr9601786pfb.20.1714324878996;
        Sun, 28 Apr 2024 10:21:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b006e71aec34a8sm17800432pfr.167.2024.04.28.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:21:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 10:21:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org,
	David Flemstrom <david.flemstrom@gmail.com>,
	Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (aquacomputer_d5next) Add support for Octo
 flow sensor pulses
Message-ID: <284e3b0f-2cad-47ea-9ad3-f699b2bc04f1@roeck-us.net>
References: <20240417175037.32499-1-savicaleksa83@gmail.com>
 <20240417175037.32499-3-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417175037.32499-3-savicaleksa83@gmail.com>

On Wed, Apr 17, 2024 at 07:50:36PM +0200, Aleksa Savic wrote:
> Add support for reading and writing the flow sensor pulses on
> the Aquacomputer Octo. Implemented by David Flemstrom [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/95
> 
> Originally-from: David Flemstrom <david.flemstrom@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

