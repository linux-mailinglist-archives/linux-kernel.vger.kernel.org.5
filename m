Return-Path: <linux-kernel+bounces-117468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39888ABC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CD01F64170
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5286213A250;
	Mon, 25 Mar 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlC5ddrY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7B5473D;
	Mon, 25 Mar 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384190; cv=none; b=Tmwxqyjf3cKTynAOuAuo8x+QBb/Wdnnuwz/wCZzJ+RKeF45j6tXur8E/ZDJM9Ks0CKtcAqcB1Dr3Gtq5EKwUUMmpTyJSIMgWlFUBnRRaaD7p8aCJEjnpCSR/C+KTJs1QRfx+XqJGDZWa862iDw8+LGmdGlCPwOkvxLbZSWfTS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384190; c=relaxed/simple;
	bh=zCEfDilLNaLthJWvhKWFHQWSr/Pwmgm4sTwPt47nI1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKcsNxpa1nUCUsLukiw6aahIx8Qpy1ZPRTxsVyhonostaStZnIZTR3fLwfwDQVhwwMvrz/g45HvCCgcSFtiHnGlVrl5eh0fDm1fvE2npxGdTOTuNuqRR0ydd0ToWY8ohtbwj7p90dYIik238szAlsirP9Z1+BCGMBXne3xdiE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlC5ddrY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1deffa23bb9so33923835ad.2;
        Mon, 25 Mar 2024 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384188; x=1711988988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/gn0GUG6JV+T513/jBkAyM3PUjK8qki+VFAOcOgSS4=;
        b=OlC5ddrY8ATG5NEJwyQedt+9HluVgJ56gbc1OfRcVfAB0jkYbiw42SyRV9pILUUS9h
         IYRz/mCnmTgW0m0A3enhYEcuPlGrFir5wbgRHtJvnVi1OyQiqbae1ktwW9piYzIPvzY1
         3l0ghkbZ70IbPgJqWef1G4u38ptj3P5uBhnEgz5EBqUyz8vOuMH+aV4pBjp7dRjBdQbz
         ZBtMH6/3HjZ9nbtQ4PqWX/AYpLdx+7phdlu1cnv0RmSPKtLfasbhth1XdWem0OXqZ78V
         xhkEZ9CBkH8K5+HEhnHhydQMTOYVDJtSO3Z8AAsR6EI/yRty/F82qyGefAymNQrfZFK2
         Md0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384188; x=1711988988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/gn0GUG6JV+T513/jBkAyM3PUjK8qki+VFAOcOgSS4=;
        b=HBeqWdOslUnDcxeg+3wnJZpeOcdhcaqs+Rw6BoTkil2iCZwjN1+TnJD38tX5/Q9FIn
         WgQKICCiHN5j90PDBSWEGd9P7Gxqop903E8E+iputeM3TN6vmM4b1a1fgBmXhmSNHEYX
         tZbf9Bv4XdXGKbhDPQleXYG5yRembuF0KNJ0u7kNGYFk+S3mhyki0hVFz0c0aKWs1NCp
         xqak+4YNWUf7w48CfosGbfJKy+Ml9o095uVJJaSMVYLNKv3v4ijWPyIDCoGHzcDW0dwo
         aX1Lap+BgaUHmIbt+pItH5IES/gO23LnIarpeRK7MU4pCpo1U6PK1sC4HmUxboQ5eSpZ
         sUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjpZxBpni7lmz8KDB6bi5gFVXa4IwfdvtDQfyJ7sTaqvm9J5xOnlKClHZWQLNeAiNMOj9O/hy2EVhK7KUTGXF+nEE4H/lYvXa+kXQO6gtLuEWJGZeGS7r0KrXYVxJCW/SqAi5n8vohr6c=
X-Gm-Message-State: AOJu0YxwIWpJrS6rL8AC9uKuZ6qv5PgFrbk4dnAI2wbwfXS8x3xQkzpp
	1DbFGnYVx2rEK2gnjVhKIHTKnYm3KOOFnRCqWMhwUTbTWd3a6TvA
X-Google-Smtp-Source: AGHT+IFf4FbpuyMe8ZiuM6FsYReg+v9tbFH9Dbpe6tqKRTdob7ECFhZr+/gwEHO6/qb4oLSy73mt8w==
X-Received: by 2002:a17:902:ced1:b0:1e0:ccfd:5a19 with SMTP id d17-20020a170902ced100b001e0ccfd5a19mr1725842plg.65.1711384188684;
        Mon, 25 Mar 2024 09:29:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902dcd500b001e0cde860dcsm1052930pll.51.2024.03.25.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:29:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 09:29:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 2/3] hwmon: (pmbus/mp2975) Constify local pointers to
 pmbus_driver_info
Message-ID: <7b9075b5-ea38-40cf-9db0-4c0a9e2f9587@roeck-us.net>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
 <20240325120952.3019767-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120952.3019767-3-andriy.shevchenko@linux.intel.com>

On Mon, Mar 25, 2024 at 02:07:43PM +0200, Andy Shevchenko wrote:
> Constify the local variables pointing to "struct pmbus_driver_info" and
> other encoding params to annotate the function is not modifying pointed
> data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

