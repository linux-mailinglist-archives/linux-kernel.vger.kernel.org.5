Return-Path: <linux-kernel+bounces-105345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4287DC7D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038A5B20D46
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92146DF5B;
	Sun, 17 Mar 2024 07:30:53 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AFD26A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660653; cv=none; b=n8Od/3H0eqgxBtIhg0Zg4Vb2hXUh1li1hnk6YU7ilv/ZF7uP0YC5tYlvJ5qsGR6HvnjE+hXPtg3BHI82jrTkmM8ye29Xxir9PpcPLO93tiVsyf8f26hUMZWCH89yqHhB5/pIbu4IQ02b53l2EyioJWEpTVANboe8PgajDY10IKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660653; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLacNz7IXAp1dofJhKZ7Ekrv7TaPJlRWzjORewigR9D0Z4p/mQEfnE1n0sRDn1R+J1C7RMDxico6d/hlw/oOe/EIWZdDOE9P8OhmIy60Tv5E27NrsEW3GwjnoZ7amg1jcziX3GLFO4+SJzBBjEpahaAW735HjsDLKId24VbsNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ed6097ca0so446818f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660650; x=1711265450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wmhHA0lYVmhNz3szGBFoDmttNIb3EO6gadl2hT0H2awtovKYrvlR2H0VrGj4RmBn42
         67pSNmjPr9x1FNGoZhueuo7oUFoATc9nccm+WoekAl+uuKT47hGHrgA9XZ8gMYsPMoTz
         7iJfA1S9zGR7mFqglCsCLJtsuOdC8nEvTX5/C6+j5F+X0PMXRnlehpIx6da+Pta8ajgN
         595RoF6lIuccQYlw+QxB6wdkJnyl0JLib1uS1bUktp0c5/iRTqPTYps59Yky5oejjBJD
         LT0bhaMZsxb2VZyX5ODtRQa7zpftqKx8pX+hdv7xykfVzpUyD5h+T4kVcHJYLGyfeedN
         YynQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9r/zNpVYlyHFrqchHq0n/9X01tX+L7su4off3DwTb13ebSHMDw6wOqXccv4oVTsK0VH9YKvxZtdobH7rVL+vrX+jhoqA/0o+hS15I
X-Gm-Message-State: AOJu0Yww2xudHUthOoiIVvUB/JUdaxOgMz2Wvy6nc5oJVdYrAagilAns
	lczHC1eMhY1IPPTs8JqLqwsk51lhtU6fEdsyBdzkKnJ3HmgarZwU
X-Google-Smtp-Source: AGHT+IE1YedpIs5EDAiT+16B5tDyqlOASHCmlbPIoQt7Cazm2Aoe41mMn1s1CeLOEg0pVl+ZlOw3GA==
X-Received: by 2002:a05:600c:1c17:b0:414:225:3699 with SMTP id j23-20020a05600c1c1700b0041402253699mr4358587wms.1.1710660649695;
        Sun, 17 Mar 2024 00:30:49 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm6341183wmq.23.2024.03.17.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:30:49 -0700 (PDT)
Message-ID: <44dfdeea-973f-4bfe-b72a-96513f447b5e@grimberg.me>
Date: Sun, 17 Mar 2024 09:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313123816.625115-1-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

