Return-Path: <linux-kernel+bounces-165385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90918B8C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA96B2200B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12905FBB1;
	Wed,  1 May 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlKIQudv"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0110958;
	Wed,  1 May 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574757; cv=none; b=g273wY/tAjsJzD5ui9bYrl/v6pN4r9Y7EVRzpeJRN8gvQ6uGxRsWgc2x4mcaw7RL/vEsyNagcpBU/5f87flKwUXVNRbXlg6bHROy+8+cwAFuZttrXhgTRAJXBMcP+Qwv3byooANg8ERSoEO35lO0LEd5xF3CfeeBi9JP7wSodGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574757; c=relaxed/simple;
	bh=Lr+zIgo/OtAUC7MfUUAOJmSsXwP++T+/RCsxrw4DNQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfUDDn6U2yILyRdz0t1rU8SkQFlCCjqiHcnWIWwQb0O2KzNzkBlfV8hKdLZ/4HKON8qtTAlYAUiS9viREwVc7XbIjnN6C7khf5qxLC+oqb/3cBzVQr3+E91LpoAkOaiIuI0WT35fWwUZmDOE7hIuyBe0e+5iPjHeT9qBOQZ2iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlKIQudv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f07de6ab93so6437540b3a.2;
        Wed, 01 May 2024 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714574755; x=1715179555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pn4mAEpkg9DsE8kn0GNq/PDutzyas5mpgXUYzPQmPvQ=;
        b=OlKIQudva2dChMPjTTbRHLzUCKU8G4MbiM+NsTsEtkoVmshiyTtEpTtaSCek+E2G80
         TbEbM2IDd56HbtTzbma//E6Hd9MSPTdBmJHAFSsrl/h59UMML7jUZG3Ti01rZMDEFhDp
         0Go/U3rIZhicJSn1aWrKHxXtmW4asVg0NdFb8myV4s7JZFa5skJrTKrHFUa4mRcic+5H
         Z7N8ymY7xFbvpOINboSnRg6WytoaymQRIuVQTRDAP7ChGhHemKPD1uWAjfLBqUjXkRj5
         ih4kKm6dg0jaXhlMf0z896Wp8azELST2Yl1w1HT2/mE5CG7aHelpyCvtu80tIhb5P4SW
         ivyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574755; x=1715179555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn4mAEpkg9DsE8kn0GNq/PDutzyas5mpgXUYzPQmPvQ=;
        b=LCn43VaF/Nl8l5sAkPAU9oc4iKtN9fSF/qEtDHWZnWp06Q2br2WVW+IGNqRX6O8Npk
         7x3+nWgrCC2srDQcjhGWcw1DHlAQrr88WCTYEIbvhgOi3lG7JmbOYmk/6HuPrvqWYriK
         lsRcruUxJx0bLHKdhQEtvC/mFb7HJbBljQr7BhCwZ8xgm2MHlctvT2+dXZxekfsQsHNG
         xF8FxPPc3yaQBWLqmov00UVitHV0wK730MiE1G7AY9fB+efIWVzK28MEqx5lupG4oQp8
         2ZelW01dgUGizWL2/0MxgaNyBT7yKFMFbR+soXriaQBMN+CDTbxS9ZTVD9rhXctwoJNV
         DSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGspQSeEm1a8mTrs+18NrLxxT/tBDHOgh96Dsa8wK+MqypC3xnLN9051D5flmW3eOAPYHYtFRfXHag0q1TsEoF7Pwim3z5GvOgKSRBM9XqP5jf8/n5se6jEpm6snzH44midBlHfHJQf9Q8iS8o9kwg330yWOK9tT+qQpE2SQqwa/7Aikd8o203c0g=
X-Gm-Message-State: AOJu0YzYZH1lFc+t7Q1JDx9mYnXqih5o1jgCnG8eEvXiy5QbvtGoybsy
	YwRgNteif7u0P7WCb07MsJBrgyJ5hP4O6UWzpTluKaDKcWzGqLdS
X-Google-Smtp-Source: AGHT+IEd17PNu6VWr4on732WJPeqS9YY7Rqn2dZvUyvqUH1SH3YwjPwLUaYwyzziTXY8J9oUN9HbQg==
X-Received: by 2002:a05:6a00:938a:b0:6ec:e726:b6f5 with SMTP id ka10-20020a056a00938a00b006ece726b6f5mr3670773pfb.26.1714574755014;
        Wed, 01 May 2024 07:45:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78816000000b006f3f9e4dfd4sm6384477pfo.60.2024.05.01.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:45:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 1 May 2024 07:45:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (stts751) Remove an unused field in struct
 stts751_priv
Message-ID: <d5df8bd5-7de0-4d13-ac62-069ab5b05501@roeck-us.net>
References: <94ccf9caaa6b0101351bf381f09f4428c5e0835c.1714511322.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ccf9caaa6b0101351bf381f09f4428c5e0835c.1714511322.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 30, 2024 at 11:09:07PM +0200, Christophe JAILLET wrote:
> In "struct stts751_priv", the 'smbus_timeout' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter

