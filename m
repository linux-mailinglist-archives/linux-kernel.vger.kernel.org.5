Return-Path: <linux-kernel+bounces-105347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A7D87DC7F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEACE281AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829D1B28D;
	Sun, 17 Mar 2024 07:31:29 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA61AAA5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660688; cv=none; b=djHZJwDqS0FfTwFkzppCNJVC6D6ARt7EzDEuupxHbfeT1/b4NhbUbJz0c82D2L2lg9vSjv1xwHWKKUQL+9vk5XL4QatlKu5EOU6wT41JIfh8yDUo6+oQNQtQZbgov+uFMZAwXInBD27nOWuE89340gl2FkVbDCALnTCQ1iQMOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660688; c=relaxed/simple;
	bh=AZfLsfK8a8pFrT4w+NHnvtDI0aHm7GlHr05kCtXLxCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bH4yKec9XaF2fO+r0Qc4ATY31iTCnHisNiUKrNhDSVVFcRNKAXo6gO5cYjrpM/TlUMJyoKx1+d0Rn1PZwQRiHO+kzeIXes8FbtXbWvS/sjXxDQazAHjbGHYn5FVdGOUSfhTVoqe/m6Z8EpFgCEn1Mr1L1vTwOE2KL++RQaLHO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so481662f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660685; x=1711265485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZfLsfK8a8pFrT4w+NHnvtDI0aHm7GlHr05kCtXLxCg=;
        b=RfTm/GTsVDN3QFQiZ66K8ROtElL+xlJA5HCq1WUk3BSrty2W0v6RT/zmSkNeyeMPhQ
         Wp7Q0co8Htm9FD0BsVWp0nNGcPwECFIt3Qz3VEgAj5xE4JN3TtzpRkg/z6Jt3gpXRbzs
         qrdI32uDY5a83q04JwMupuVxyXo2jpvkf7q+Uo6z/YwpgWCPdkHQqbLaef8LCsRui6lW
         GSlG0Kr9hjiYs1W7JxdWxmI4wtm9oMBQt3IpNngyVixZKJ1claHBpAzU+f+HCzFjsGx8
         tT56caWV9aO/Fw5oAxZldoV5TYRRuTQKOng3+FWGpkJz4UjWLzBtH3YkNv7+7OxG/4aN
         sBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUfFPJApGfSyw9uhvYZSKWGMWGOTYjIjh5zykqnqI/dlUDkekH8To/dOyMNel5E3WxjlZaelK4qY1ITX152Pql3mSZK0ZfFd8uSWaxh
X-Gm-Message-State: AOJu0YxyeK+MKH3BnU42xRiSmSTDaLBobx8ACakeb/S8XTrXDW9JtyIO
	ZJn+Zw69H0qQBAvtB4U1kfN+E956FavvCtZLXtYdlbmLj6m1Hts6
X-Google-Smtp-Source: AGHT+IHWpARUFyJxaLK5xOn0Slk1kvqbz1e2/yWi2b8p0mXc+jyHzyL1b7fURaWhh9a0QhfTRBK9oQ==
X-Received: by 2002:a05:600c:3b18:b0:414:225:38e0 with SMTP id m24-20020a05600c3b1800b00414022538e0mr4110906wms.3.1710660685569;
        Sun, 17 Mar 2024 00:31:25 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm6341183wmq.23.2024.03.17.00.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:31:25 -0700 (PDT)
Message-ID: <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
Date: Sun, 17 Mar 2024 09:31:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313123816.625115-1-fengli@smartx.com>
 <20240313123816.625115-2-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313123816.625115-2-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Does this get you the functionality you want Li?

