Return-Path: <linux-kernel+bounces-147638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34D8A76BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA88B24342
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64313C835;
	Tue, 16 Apr 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9vAamYM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C213C819;
	Tue, 16 Apr 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302624; cv=none; b=WMIbdHZX/ZB7ZhxAc00quGwyk4zDKN5JA31wGgU+fTLYS8c7DQRCRy5uP/ex+r4JpJ2YNWhAMhg1R48OpoIwjnXAhbQ+9NyNk0JHrXKBXHNN4EnnIsuE7bzdT5eyQlEAMJv9o5KPfVHMA2fDcnQsUk2sd0Nf+w8X7xRiEieEInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302624; c=relaxed/simple;
	bh=Fkt++JTyYof4Eg+DZY2XPpS8Oa6RROqr0lGhT/b1Y5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSn+w+2I2CxkEoAWoWNIjidA3JBb/4LPsnGWljfeHsY+318yfjbFOhPbPndtA6ESpAECKAK+WZq8W7uqN4Af6Oo3iICOZHPJisTAD5SMnam/Wifa6BOrWGPUNHZvGXdIhw/X+qXe30ocIunm6F0pGF7NfF9ExvQwYO9nRyzaWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9vAamYM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed267f2936so3900764b3a.3;
        Tue, 16 Apr 2024 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713302622; x=1713907422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fkt++JTyYof4Eg+DZY2XPpS8Oa6RROqr0lGhT/b1Y5k=;
        b=h9vAamYM3v/6IU8l4NX/AmREhuz7ObDmX0Nnl1fxy7cdXM3yI7n6KWhRsPAPaV9YwF
         qd81zxEEe4+F9jJ4CcgNNCi9tUelxbnRfE2AL7baHeU0SIUuOpHGX+g9/OBjc132+NoC
         GM5gJ+r3w5sALI35eqwpyyr8v0UFSiR1gyRXo76IxuzmwaTS7+YFRi0WTGF0kV7E1F7g
         yKeizTSp4A/OYwHNYqfetsTIUCJ8pXAP6+b4UvWv5SnlWxI10aH9r7rhVg8IYZ3+Hb9y
         3WdS5nn23MhXXy1oWQzRe4rYCGwjUDA5ySDzJuhqG0pW1D3axXd5sSZuuzakv8RPe/d/
         v3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302622; x=1713907422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fkt++JTyYof4Eg+DZY2XPpS8Oa6RROqr0lGhT/b1Y5k=;
        b=XBf0X5qrV4O/D7xS3z1+3Pk2lLqZpl6XA0yDfxxQO7q/0+Ylae1yOnvhdVVWTZy0pi
         24Sb9AVqvoy0JqMTxbt6eeAVtSF5IBRU5YQvPY11Qn3WZJtNmdE5WmURPT88J8/4DrS+
         9UAfStyNAZWPAegi5bjFlpoWqAjVmMqokuW7GHBlL9BjrQDE/NbHqP1lI10cuTriRwju
         Y0kphOh9WtvSgAh6v+9qprqFdHOLdyDmTVT7VxGDvF9CT8hIJHOhZQoYxjZetex3e8L5
         3RzJnHeTfeSCHmPQmr0j4Rhho9Bl4JV01DvkU2eBP633/ViHHkjCw8IScBvgGJL4k0yo
         qMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtBcgZcfZ30sPdbI5Ml0bpyAGcvkX73hxonnc3+JL6sNTbzH96LAFYRyu2KE7qn1YzqKh/Brc8VeFhSQJNBBBtmj3I1Dxc5KHxdFiNQvnA+KuexCVqAhaH9IQkHHpyRDtjdbq9wvz8K3o=
X-Gm-Message-State: AOJu0Yy3y6N7CMWRVDuD4l5deEJk9xN7DUbGyBs6qrvRtkX7jLJ5ism8
	mh/BqbBpgf/UyVoUBGqLR3v7UCq4+W4kuQSiTmwJrCt61Zjyt/mz
X-Google-Smtp-Source: AGHT+IGcoxvDo0vrG+67tAOJRqEYQZakHloelNK6PkXb17apBlJls6xveNQIjCgoKlvWQOmU9VjkBg==
X-Received: by 2002:a05:6a21:8cca:b0:1aa:5fb4:8b14 with SMTP id ta10-20020a056a218cca00b001aa5fb48b14mr1835576pzb.52.1713302622094;
        Tue, 16 Apr 2024 14:23:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m129-20020a633f87000000b005f077dce0f6sm8177233pga.31.2024.04.16.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:23:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 14:23:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon (max6639): Remove hwmon init with group
Message-ID: <cd051bcc-7351-41ba-894b-b4ee26910e0b@roeck-us.net>
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-4-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416171720.2875916-4-naresh.solanki@9elements.com>

On Tue, Apr 16, 2024 at 10:47:17PM +0530, Naresh Solanki wrote:
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

No description, and I don't really understand why this is
a separate patch.

Guenter

