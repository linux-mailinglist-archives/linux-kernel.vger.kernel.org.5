Return-Path: <linux-kernel+bounces-98319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5280A87785C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833711C20908
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20CF3A1AC;
	Sun, 10 Mar 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRmS7jca"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE83987D;
	Sun, 10 Mar 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710100720; cv=none; b=G1gLftY8HKwRJYGDYpQ8gkfJeCxu45OWYEGl+Ay6w+1QfFB/eFCnQ5SW/Zi5oGhZs2eUjSQiT61LtiidrN/c2pD90Mjc5MLnHf4GRdTHyZu7hv90OZxp1mzc3disIu1Uq3tv5XUsjkIXfZKCDRwjC92+RfLNvg1VpqSD6g+IH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710100720; c=relaxed/simple;
	bh=e/S3QsOZRxk0R1c0mtSGuywQ8blcGGvaddFxTrU5nzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkEuog9umVZK/97vNGkYHZeu/rYHTgEwP7DufKyDWAS/F6XYRy/14uuTNkjG4BIksGqUBq5lhAn5xqVwn5bzZLWXCc++Arr4HQWKIOGmbAlA+l0h5SICIULj/7DNk8jhNJVFxblxYRmZAan/WNA6lUOp2A6NDQVXBKnxGORUl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRmS7jca; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4eaa4b394so1597275a34.1;
        Sun, 10 Mar 2024 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710100717; x=1710705517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUky88ZAZ+yr9vj7pzsLUkjMCq8JAAHxO4SYtMxX+9w=;
        b=GRmS7jcaehhOxliCLGxAY9cD8RHwTBUqRdwPx6S5INYcA2MBcwgxFtjHNOOJaDm414
         PZ1eyQeQbwrvE5Oz3BrITARLiFsx5R5Mq77be7F7unWthr6LkogGw4QG0FJfTQKErxRk
         Xqdo9ROV02G05Bo8Ddhr+YPzoyJ0Dq+kuT9EJvmqy+kcQpvvapWnweS17b3iKoTehlCK
         lFrB/lSnzmeLerSw4vRigaK2+Qb1rBjCPfwlsknoXjx0WgjB/US9HKRm0OAuae7gQ4YR
         T6LZR4BvVZ0F3cEow+UrU4Aox7vq5TnYvtMpsJF/tmxnWYojJH0Mu+VpmLkB5shxVj28
         4bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710100717; x=1710705517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUky88ZAZ+yr9vj7pzsLUkjMCq8JAAHxO4SYtMxX+9w=;
        b=WMDE8iGFHAfmx9Gdu2DXgQwnElwQZ3CQeJs+E0rms5KAbxvXQs5t3NNHDpmGv8Yn/y
         pc0Qmz3dxBCRyoFUikRK31KYQA1dm/VkiMrIOdxK0OvxKDarDqRwoZvLenWGrKRheuWH
         7YOSIBhSni8EnDhf53KAeNhTO8R0LZjFbkEg/3tmxVsV7OatTaSnuB+elEFmzcH9Q4Xh
         k94vx97lbwAAdW8hKdoq42CsCwc6QZrzSu00YfM2mSINSh4/RSXe7tEYHcyPPeKJZ2Vq
         IffXUmDpKiZSZYRFdMUcF2bMK7rZPW13zLgEOOj7nCMY4C+lkuKz+W/pqStLbxqUySUC
         +hrw==
X-Forwarded-Encrypted: i=1; AJvYcCXOsSrVJfYWQSV4qFQv6tkDQxo/Hf/zo+14TjD//OY+YeqwWftMiU1ofWotL+yiqR/a6SSiwUJTcscJar0vH1LUD2PuD2GqKr9mBGYr6ROYoWTlFgiJk2ErLqwfcpz/G+6QmCRFg9j/s+U=
X-Gm-Message-State: AOJu0Yx5mdc6gLzJrcWC4v56XKgVoj8r+8IZzBL1Tn56rpQPpxiCfNFu
	pBYi+pspKjfOAb+ReigyFMFvr6XajEzozJeQLPQRwPIKZEkTMnlc
X-Google-Smtp-Source: AGHT+IFFiiCe4Qnwvr/rghFmL47p+EkCKmaCnHCOzJOECf1+sw3dexnPEF1isa5Sc9m2cNdQWggfzQ==
X-Received: by 2002:a05:6808:f94:b0:3c2:4d6d:22bd with SMTP id o20-20020a0568080f9400b003c24d6d22bdmr314193oiw.10.1710100717553;
        Sun, 10 Mar 2024 12:58:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001dcc2951c02sm3000939plc.286.2024.03.10.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:58:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 10 Mar 2024 12:58:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add XPS 9315 to fan control whitelist
Message-ID: <cd8071c1-22c9-4a2f-89d9-6634fb88b842@roeck-us.net>
References: <20240309212025.13758-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240309212025.13758-1-W_Armin@gmx.de>

On Sat, Mar 09, 2024 at 10:20:25PM +0100, Armin Wolf wrote:
> A user reported that on this machine, disabling BIOS fan control
> is necessary in order to change the fan speed.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

