Return-Path: <linux-kernel+bounces-161535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DD8B4D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E0B1C20A54
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3A74410;
	Sun, 28 Apr 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKdCB2Xd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC77319A;
	Sun, 28 Apr 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714328197; cv=none; b=ZXlsMKawBm1RjHo1i74wPAO7r4d5w5PUS/OZwV/UIt5cglhTf2HidD39MznB/AXv5ZMp6d+sKaX0YZXfcMXtcIJ64fT2pt3JX3j3NsOJhPQmFNx1jCAoOwEb3m9O/DvGHIrsHXVRCZMDlIdKnIMNAKek3a6jrIm8Qt34rHB/tVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714328197; c=relaxed/simple;
	bh=d9HJPHpBZYGx+j+LD9rskBuivRQgOk542meAbykaPr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWNXH7TXA8oiC96kA7Id+JfEb9ttKJXzqrnZqETUySFg2KMtai8qmK9MMqT8TT6IzIK5cVxP/3+98HMtmnGnchF6LsChmgH/UoDiSgv5Nus9HF+nVroCW3AqGJ/rEWV44nbKUOVXVi3hdF1Hqz1AuPxB5jUAI4BCO8HiDc1fs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKdCB2Xd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso3185483b3a.0;
        Sun, 28 Apr 2024 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714328195; x=1714932995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/SOqpHITcOX3MgGX5oGZ3ohm6bCiSEe4ahxlofBE5M=;
        b=dKdCB2Xdc0WAk/wyz5GeVofRnPCaqSAefiY8uKzu5q2dLMJJIqtnkuFhHJHf99va6y
         p8ZY7z+qwFTatv0Zkf5oz35xWl+Szi4stfF3Ok0zlz4w+aOZe3XAysOuYokpEU+jTn9D
         EQ2UMsxvmI7mN7lwTvIEfUmcueQr2Khy1/csswqOITvpN6D+3XWH1M329V5I9wQhJUkC
         VIrIHgLVyfI92nidMo7rDwICpzJIwNCi4qvJqDzfjr06jTzlIE9kHGD/HePjnoabZ7xJ
         s9FyKb7AA6BBy1z0dksOsifukUFeHCebaEbHUMIHKsCsGi92How5G+XrFZLtaDB1pdv3
         9nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714328195; x=1714932995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/SOqpHITcOX3MgGX5oGZ3ohm6bCiSEe4ahxlofBE5M=;
        b=SGhmDp8vmdFWHqgtcoQaWpp15xezAvIl9rtP8kzisXkbJMr/yOgsv2w/8brbH/RwQE
         vgKtnsGP4Irzjc53jt7ZB6ov8NR4uQ/UvCiLUrGfYSpsbLk4su/xhXa9HqrYo5rTI/Nw
         sZNdW8ePxUL+C3G5MPtPBHM5w20FCQfjhLW1qqLIh+PVmebBL92T6YmTQmsMYVal+Rf9
         tjnQm/xA5s3ajXZTgm6a/lkn193If70tjOvu4y8FagXZscS83ksXeqPGTMlHcG09SsoZ
         htCf1OECxS8nhpn+OWzb4lfNTW8VZC01sbNDGOTgg7oeEEIFaQeBuXalj87aPN3Wk3zv
         q2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXcYDfJHWHpDfx/5o0vGLiAgYW+IZ+BZsJ4U3z/tq79jMSTsOMp6j9yuHrVZHttYctLPuhTGZmDrtRxZDHtCEPXfIaj8ekSX4hOk52WBBl22hmFM6nOGTHQNl2W0vRW8KDdsYKcpcLa
X-Gm-Message-State: AOJu0YxoDXySOjTg58MBN33yunCoS7Bc8p6TdiaB6taaKdQVeZhwGdLV
	5+nJaEMfqSL6NnMqaecJT0xyzbXveggRkfuOuw87XW4/k1L1zCHw
X-Google-Smtp-Source: AGHT+IFNY06iofzMQtCWdsgHQuwdjN01HSWJrBsaAgh35dsS2duXY+Q/KoZzDbuUnlvczmwaX50rBA==
X-Received: by 2002:a05:6a00:4b09:b0:6f3:368d:6f52 with SMTP id kq9-20020a056a004b0900b006f3368d6f52mr10600257pfb.5.1714328194880;
        Sun, 28 Apr 2024 11:16:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7-20020a056a00244700b006f0ba1c8ddesm8447579pfj.184.2024.04.28.11.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 11:16:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 11:16:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (nzxt-kraken3) Decouple device names from
 kinds
Message-ID: <a6a8c97f-be16-443b-af24-97f040db1b79@roeck-us.net>
References: <20240428104812.14037-1-savicaleksa83@gmail.com>
 <20240428104812.14037-2-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428104812.14037-2-savicaleksa83@gmail.com>

On Sun, Apr 28, 2024 at 12:48:10PM +0200, Aleksa Savic wrote:
> Prepare for the support of new models, for which the relationship
> between device name (for hwmon and debugfs) and kind (for the selection
> of appropriate code paths within this driver) will no longer be 1:1.
> 
> Originally-from: Jonas Malaco <jonas@protocubo.io>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

