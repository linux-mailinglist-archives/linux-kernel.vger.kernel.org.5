Return-Path: <linux-kernel+bounces-16481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D9823F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623821C2118C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86920B33;
	Thu,  4 Jan 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4o8+k6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5020B1B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so403012a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704362672; x=1704967472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1rX6LIIBT0bJ+f5LqsiiirLWt5Scgx/ZLAmvrn5Vnc=;
        b=e4o8+k6Bf3LLU3kjQwSwGH8y7byUnT6pPVISLOBiz4E8N+65IYlHyZAKsTKyWGf5M1
         lI/FCyPb6vaMCqDxXd1ClacEiEZ0hfr7QRI0YfYXv3YvQAKzaX7T9i9DsYLSnTeRaMz+
         03xptOYXf6WO0tv+XGheh/fQfndSrVMs9jS3JM1Q4KyZ63j1dj8EPAug0gu/kl2JB6U8
         cOUiPo63qzz8/1/Kbd6RHpdjrbc8KOQ4kunUk33RkClDgbYrLfQapz4N+aT4PocUpG+Y
         rRBPZfohde2zCE1rZpS+4k/m/YMgwVzijdTmxdMpflCEcklrd+gbnY8mxgPSkDW0XFyf
         1ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704362672; x=1704967472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1rX6LIIBT0bJ+f5LqsiiirLWt5Scgx/ZLAmvrn5Vnc=;
        b=C0M0EBXukjfqrwtSHrraBhI218qjO3df6VvbHXe9J/P6L/oYOERLGb07+jAUbavPAM
         UBC15i5D+dJ0sti5DfBH+jbqXjjFFLCqcu63TmNtiYU2+ZS8lo+cbLBZzYzXiMddZRKx
         26gbGkgVlyTKgkMf5WOOFN5tntxnCjAJw1qg7HS0TJ1B7vBaBXgtibkGNz6+xBv4Tc0g
         DXdqBzKC6ae9wYLGG2usVu9ywIaobOE+jltSDU+GWESGPL3/tZbNgTuL/eX2sSjrIlFk
         abHEHu787UvzD/PFojw6xjspDMIskhErxoQs9Vctn04dAfUL0WR0QkyWSaXjENK3uY58
         DfIg==
X-Gm-Message-State: AOJu0YxAQM2SMkBtjNLKY1BojwcnOrlKawlzhLMtfAujETrt4N7bTY3d
	elyXFjc1C5NDSRr55l18NIZaLpeqvQJ9rw==
X-Google-Smtp-Source: AGHT+IEWjOWS+iJS3VKXtHcdRKJTlTSCqeub68dLNbBbnnO+iXKNUFFkecaVunXmV7+mtf/AHSr0rQ==
X-Received: by 2002:a50:9b09:0:b0:553:6c38:148a with SMTP id o9-20020a509b09000000b005536c38148amr255183edi.39.1704362671711;
        Thu, 04 Jan 2024 02:04:31 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm18450686edb.64.2024.01.04.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:04:31 -0800 (PST)
Date: Thu, 4 Jan 2024 13:04:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hidenori Kobayashi <hidenorik@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <27f1c487-78cc-4e56-ba79-1434aba131fd@moroto.mountain>
References: <20231228093926.748001-1-hidenorik@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228093926.748001-1-hidenorik@chromium.org>

On Thu, Dec 28, 2023 at 06:39:25PM +0900, Hidenori Kobayashi wrote:
> The pad's flags is checked in media_entity_pads_init(), so it has to be
> initialized beforehand. The ops initialization is also moved together
> for readability.
> 

How does this bug look like to a user?  What is the Fixes tag?  Does
this need to be backported to stable?

regards,
dan carpenter


