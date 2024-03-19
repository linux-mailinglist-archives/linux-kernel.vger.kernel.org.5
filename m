Return-Path: <linux-kernel+bounces-107382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E787FBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52471C21F46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282AD7E10E;
	Tue, 19 Mar 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PhUxpv+D"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF77E0F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843941; cv=none; b=Tqhs4ISAdyZeJeGhlVlikbK6315z0qDrbryBsoxyk+9mUbk482xao90Xx2yk2PBy4MhLp5OmcCXk8tgvteQTnmqBn2sqh3roxB49EGmLbCnrIGOh25EisMgA0wn3YAAHbDllKi+bxK3lh7ddU6sWF4EqF6qOGCrgsLeN8GB62mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843941; c=relaxed/simple;
	bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIyO4vwacaQJLH8ypXBmo+6FKjnCVKj1Erc05189BnsX4Pc+HvEpofg4tI4tF8U6PbkVjByg/qxYY8fMmeX8GxM5f7gFqmSGvADUWqyUPohbh+SYcT6DdYcI2SGS43h3o6WDDyBlYQfZbmdbVAg65FrK6W1ngzIdCKK9Fae7eY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PhUxpv+D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5157af37806so589750e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843938; x=1711448738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
        b=PhUxpv+DfxOUavzRV9uGR2QVWSDH0t006SW7rw43zZ8+XT1IDyMCzGka82XmQZbSud
         qn80thICNt/bke1kN6HBNHGhLGKObwq9dD96Hy173230XrCazWzf/yDY16gWw2PJPFVm
         ifExinfEojniSyynkKMwHp8Ny/fzOgQ8GuPQuXCnF5K/TE6+l1DMQwFPJ3X3NIQWsFRR
         GMdfpN5my98Flqih2TGvwynGQpPl1yLpYZf1IT3TCKRhmcsGAYy18ZWvWbalIUK0bnqC
         qmfrlrpdRhhUbOh7Hp53HBOl6ZrhzhNbNGarhojoPaDz94/jREdunpQJdJy3l2D9B4cP
         7uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843938; x=1711448738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
        b=V/JDzUxOODj8achKAzbnQZDVsvRlDIn0o+M/lDDO0MhdlLXcUMJiJAq90v8z0DeGW5
         JpWWtG4KWP2nzW2gSuv8UaVmHibHH3W726xZ8l/yq6T7VraLI8tikDqUCdnP142a6ocu
         rh2ucu+oIIeCxlxBAd0zIaJ8Rel3/VjSIUHb7B8UFZuTqgF1l53OCwGl2xoB4wi3hQPM
         S2WYCRiiwhOEwHkWX6GDRYOCPggIfuWusFxrC0VHQpd5/VTDY8/fDWxQ5YCKrG9GY+tN
         i1sI/3eSyE97DxKXiwDOoFd8Xml9SlLt4R+LNMh+zw1loBDazsZI0CPWbS2LNSVDa+IY
         QRoA==
X-Forwarded-Encrypted: i=1; AJvYcCX2VAgjHtA0l4UL5o6HW2Z4E7XsbYn3+iyvVw2rhFXuZ5GcKc0vkVmO7X9RTJdpmQXBh5oqza+h+J0hXjrHDejwZ2pTTbQ7wMt2DCPL
X-Gm-Message-State: AOJu0YyP5eN4QaHDOzfyD4XqKQVYwiySmX03AHkg6rGqyO1mKdNKXS67
	xMar3psga34bMztaBcaJ3WRw4InIlToAZcohYfKmpDPtjU1m9dGoPGdWceOI43c=
X-Google-Smtp-Source: AGHT+IHBEYxMdf7EUFfVdd5ojgJCIa7Qd9jXAFR1mKkUtfqgXCkr1oqH/Znz+xela24vnnbkZ7D6Pg==
X-Received: by 2002:a19:8c4d:0:b0:513:cc24:c464 with SMTP id i13-20020a198c4d000000b00513cc24c464mr10289181lfj.15.1710843937924;
        Tue, 19 Mar 2024 03:25:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b0041408451874sm10558176wms.17.2024.03.19.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:25:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:25:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Message-ID: <ZfloHvWaTOQErWfU@nanopsycho>
References: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>

Mon, Mar 18, 2024 at 09:39:23PM CET, andriy.shevchenko@linux.intel.com wrote:
>This updates the driver to gpiod API, and removes yet another use of
>of_get_named_gpio().
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

net-next is closed, send again next week.

