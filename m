Return-Path: <linux-kernel+bounces-109255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1D8816D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A8E1C216CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620D96A356;
	Wed, 20 Mar 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYEFIp5M"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E1EB44;
	Wed, 20 Mar 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957194; cv=none; b=buckbqQI1PRuGLFeeqU8MTaipAv3gg47pEZfVqyvcxPSk5T9kECiYg/sLnsnMrwf5WozxFXXNlsydgfu1k6x4vX6KgQ1pjzzWxQp0Jn3XLyqPUKRi/n6JfnWNtuBBomjd7UWezCmddIoTA6JvEAITkb22AoF1NK/JRMUFTt/Tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957194; c=relaxed/simple;
	bh=U8iDRQhYcvX6/9YMs1ddaL5R1BN0NhkZr5i+4CX1juc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcmkT3qFpghxj9pXYeozhhQuSowFGf7W7yBxdifHuhp+PRbw78LHfXfx/p6DMgWsSwBkfu/4VxkbZNwSNIE9vkAayOSfXd+GCQ7v0F4Hf5BEyNfxbmqn1osXFLWK/fmqrM9MkYlPzdCnz2QngERo/satUg0PnLA1qgyKlg8+Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYEFIp5M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def59b537cso350155ad.2;
        Wed, 20 Mar 2024 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957192; x=1711561992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIFOXnlpQn40I+CjIMHCKge6cxVrQe5AAV9uLe3wQSs=;
        b=WYEFIp5MytuY2OwFF31DQ4MPy+KIOyL6IAazc9WZhAOqBKtEDOPmrFaz64i/umXprw
         ci31YyIA3fUtracE0D4E3jNdYd7s5DBOJ/hZNSRShHWvKzepHsm7IL/B9WLlB1c/hZn9
         gbpIQKzcTqOcwPXBMBwySZYlu/A5mSekBxRwuDQ7zGQO/+n+YyKrwINuZn5WrV6ladXA
         OCPX0reN6N/PJzexJd++1+ec8Ec+a9WWnFjSuZ5NT6o5DGgMLj6CDFu5izJRwHLKoBb5
         Hy0xMd0UTjNYx17E7gGtbSZG096A5ACkEJy4Sj29FiJrF+KmcuqNRO7ju+OD0tIf0NaH
         p0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957192; x=1711561992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIFOXnlpQn40I+CjIMHCKge6cxVrQe5AAV9uLe3wQSs=;
        b=vaL1E0thrcyTcsJok1zGXhKNO3fHUFpc3CFm4JqQa4cL5fvAB8FOfGBz4+QK8sz/tx
         eoogzRU2vHmVhSJI8gqvJtFK5UdJYxmH0Xb2vTJKUIVgkoOPL3pDqNJDvZBPMwcoKLQ2
         gIgRXsj0iSsc/Gkx4u2/Hu7gpw55innj+PhAcph/VoCeNP5ijE3koWUf4t/rCl18zU2u
         ywv/0CX9kJzOZ0L2a39DX1i+rKZoeQITNVmKXZ3BxYdmfjg7XsD63OmjA6UQIqpbTXe6
         OUfRlmPomBn6fuR3+KbypTg6qbqPjh3IMkj9ISIzgA27BX/GgUnx71QysGU9jxF3qr6H
         +xdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpCUEmu4XyXfu0FRXQOAC3mEzrYVqDXL8fdkeK1NUkgTznZ+5BauJqxpyk6DUtCZxQ4Z1V5FW+OfmgqkAvXGAoA92ERVHJq6fY/0Sr38O5KBg8S6BmEnDmZRzAnTmXia/JYvjgtXtSzdM=
X-Gm-Message-State: AOJu0Yy/SvX4yTUCsfJz4yPY4DYiYU5gRIXffWKk6HOZSV4wOtR6/Puw
	1sCHiyDyAS1WcMbjlzsqgVxvMaubDEVBlzCD6N0FpCZGYIX6opvA
X-Google-Smtp-Source: AGHT+IEswqFoovRdTgMjCxwd02FDjhh4fjObRrM9JCNobqGafNr6RKLVaKlu+49oMsKKGN5Ux2+faA==
X-Received: by 2002:a17:902:d507:b0:1de:f93f:4410 with SMTP id b7-20020a170902d50700b001def93f4410mr16983598plg.8.1710957192578;
        Wed, 20 Mar 2024 10:53:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090264c900b001def0897284sm11758039pli.76.2024.03.20.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:53:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 10:53:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] hwmon: (pmbus/mp2975) Fix IRQ masking
Message-ID: <50505cde-48c8-47a4-ba0f-48b02fb1fff8@roeck-us.net>
References: <20240318174406.3782306-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318174406.3782306-1-naresh.solanki@9elements.com>

On Mon, Mar 18, 2024 at 11:14:05PM +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MP2971/MP2973 use a custom 16bit register format for
> SMBALERT_MASK which doesn't follow the PMBUS specification.
> 
> Map the PMBUS defined bits used by the common code onto the custom
> format used by MPS and since the SMBALERT_MASK is currently never read
> by common code only implement the mapping for write transactions.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

