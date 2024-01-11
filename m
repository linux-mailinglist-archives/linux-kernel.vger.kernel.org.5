Return-Path: <linux-kernel+bounces-23431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638282ACAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD76B281D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BB14F76;
	Thu, 11 Jan 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD5LF6ZK"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750614F61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5587af6ae5cso1063388a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704970569; x=1705575369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dIC4YOxW3puzkGtWuEVT4Nr9zyyNjs/7yil9gqa73I=;
        b=fD5LF6ZK6B8RcIvSM4+UYSh39O4WM9BuRoZLbv0pZnY9ExHluBIcVG+oW773yDID93
         Ovf7jXkHiUG1hNfiKPtBYpp7j0iymnpaeE1cutmG9xvC70RRxtzomEc/c/bdIHgrmVAg
         k6AAgLbGD9/pNm4WDzPIEMNQZIHaZ/nd0c/LF+hoVzFgz+HtWdugxUQB/4jso6Hubukz
         7HT3WU0KWm/t+SomGMciOMl3zzmyro4tnot44ByQvrvQchSDz+3qPcS6gF3AqTvBsqP+
         ePddid/XZjgdaSF0nc2ME3gVUH4mrKjEJW2K7K+kLClS5hqUvLjzZrnMwGA43+dfz2ll
         F/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704970569; x=1705575369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dIC4YOxW3puzkGtWuEVT4Nr9zyyNjs/7yil9gqa73I=;
        b=dwvw5HdifL51gY0XnDWgVAE1mvTr+r5ZDEma3OHvy/z1xXeUsCFrrsCmcbBwHB6vsL
         tW/AnKvJiXm4r0D1XmSDgUoFJR3JfZxKEyHIu/DUp6kkAWtKFKximJozwZsPcCZ6/m65
         AH7klsiE7ytZ7EMzab4qvKwKPK3g2f3luW+JIZbZm93/k9dfwjaxtfakS7Rjvf1DcwuX
         amGO5YeK5bieGtQeCxV3FrPCkLNBPj14T8Z9DV2DR4TyNO0Fhi/Lt6hNBzX8IFa4vSUm
         v/++2GdDmI6RUL1+LvBXHi4ZJpR2xhf29KSetYX3JH1NPz1wuIvm07v7ZyA4qRR3QXOp
         S7Sw==
X-Gm-Message-State: AOJu0YzsEkUUk/pzRROzlHOai9IwK4F+uTRjFsoijoaHI9iPW+tCBlQr
	afM1nXcW32uEDcOHmXi/ZA==
X-Google-Smtp-Source: AGHT+IHhjypzrVpQep6wtyCwienL5/h97jwvW/jQhvrPFNpCOVhmACE7pfPVxe/6GtqDExiOOjU43g==
X-Received: by 2002:aa7:d488:0:b0:558:ad7b:f049 with SMTP id b8-20020aa7d488000000b00558ad7bf049mr130760edr.51.1704970569528;
        Thu, 11 Jan 2024 02:56:09 -0800 (PST)
Received: from p183 ([46.53.248.125])
        by smtp.gmail.com with ESMTPSA id j14-20020a50ed0e000000b005550192159bsm468577eds.62.2024.01.11.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:56:09 -0800 (PST)
Date: Thu, 11 Jan 2024 13:56:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Neal Gompa <neal@gompa.dev>,
	jirislaby@kernel.org, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, pinskia@gmail.com,
	kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <fa64c852-01c4-4e4c-8b89-14db5e0088d0@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> SFINAE giving inscrutable errors is why I'm saying C++20,
> since "concept" means you can get usable error messages.

I'd say concepts are irrelevant for the kernel where standard library is
tightly controlled by the same people who write rest of the kernel and
no external users.

static_assert() is all you need.

