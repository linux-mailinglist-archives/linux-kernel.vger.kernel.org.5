Return-Path: <linux-kernel+bounces-13927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376E8214F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40CD281D44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4BD263;
	Mon,  1 Jan 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2rxMKVpK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F0C8CB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ef33e68dso56586995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704132831; x=1704737631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReGf1cOAhj5IBC+Obt0k8qwdOa0dy6S3IHxPRIfLygQ=;
        b=2rxMKVpKYJGh89+4cRUkVNguolMz98/F8BfPX7AjYTzt85ld+lTvge0nKQXFpiKMle
         XrXeMSdy5iPYDEhg4sL7VmCW94xkMEAd5wUCxZw3aYDOLNgDvs2l/oEA0JuI0cv/3IdN
         vz5JDguPVtYFld8j2ADnGXbEPB8OGWEDsN3PNoGAuZIgZ1FgBXuhwP1ETaw8275EncT9
         DmPihLut3rIZHGeJgrBXVbFYWzX7TJcojxoJ8BQlk6SX1hRIUBcBL59BZ6GCmWIEHoa+
         srSmQ7n5LpXMQEGV/W1oYfr6lhheyymsQzMYsvnTYebF0ulxH3QO2urA24XoRX2AAu6i
         fhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704132831; x=1704737631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReGf1cOAhj5IBC+Obt0k8qwdOa0dy6S3IHxPRIfLygQ=;
        b=ZJ/v7hhcxwSToCtnZG18JgMbfNjflu/wFG24IPGpcHQhP/MI9rfJjHuqV/N7tugnq3
         ts93AkkD0/cwR++c1t1CTBI1j/pBoOQp59GbWVtvOx9rNdTrn6zp3z+9cCd6rfn8I/nx
         AlLScL0zNUeUJKrC7YHqpZPkPnzcVMk9RU9DOKhYTcEP85ajpLixJ0467sh+FLplUd27
         siYzwzy8k87X0q6Lp4B4Nmjgyxz74mQKUdRy0t1089pru9uGfk3uw0SFL4scgIZLwGC1
         NQLZHlR/TC4PeTyLJnGlwTO1eeY/gKJe7ID0rEhFeLsUfATAJEk7D38VT83v3ZxUNsdu
         A/Ow==
X-Gm-Message-State: AOJu0YzetBX7pTjYUX4gz1vslgkj49Umb/tL+SWXgBw4rkhK/fbErfk0
	w95CciFbFoEy3HZzTvFaYYYVRh/iXokT9Q==
X-Google-Smtp-Source: AGHT+IE1cS1k9Ungll9iPm/B/JTbPCnFxwHlQyrtzFcKGgrKDOLHBYvSnkU2Ezw4xjx0mKWQyKlUEA==
X-Received: by 2002:a17:902:ced2:b0:1d3:f344:6b01 with SMTP id d18-20020a170902ced200b001d3f3446b01mr19617998plg.3.1704132830785;
        Mon, 01 Jan 2024 10:13:50 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902b78900b001cfb4d36eb1sm20375206pls.215.2024.01.01.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:13:50 -0800 (PST)
Date: Mon, 1 Jan 2024 10:13:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Anjali Kulkarni
 <anjali.k.kulkarni@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] netlink: Improve exception handling in
 __netlink_kernel_create()
Message-ID: <20240101101348.66978156@hermes.local>
In-Reply-To: <477e5649-87e3-44d9-8226-010b9822e649@web.de>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
	<477e5649-87e3-44d9-8226-010b9822e649@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Dec 2023 18:42:30 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 17:26:41 +0100
> 
> The kfree() function was called in one case by
> the __netlink_kernel_create() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
> 
> Thus use another label.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>


NAK
Please look at something else, calling kfree(NULL) is correct
and the preferred solution.



