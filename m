Return-Path: <linux-kernel+bounces-20816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C52828597
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DD01C23CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C5381C8;
	Tue,  9 Jan 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIUN+hgg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB2381C6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704801451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R5fjjJdo/se/lwT5aPeXAFZ4sfB9cJDJDHFW45tKpaw=;
	b=MIUN+hggqqj621iXrWfocc/3bJEN4wQ/IUpzdgUYnETIhlstvRjvQRmBeJ7gg7DV1LEtlU
	VeIcpH94nGE/utY4nj/DxeD8A8Tdj5STV+iOHbxYYdGx6WQOsmhWlYByhYdlJ9RD8fkNbH
	GshqpZU9EG245TZXqWBRWP1ykoMeQKo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-jCVsqlqeNeCfwssaMMFLwQ-1; Tue, 09 Jan 2024 06:57:30 -0500
X-MC-Unique: jCVsqlqeNeCfwssaMMFLwQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5576084e86aso184910a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801449; x=1705406249;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5fjjJdo/se/lwT5aPeXAFZ4sfB9cJDJDHFW45tKpaw=;
        b=DbJf4BY0tDwXvlx9SQCqyctcUvGf6bqKsXKmqJqCH3dmblFCzj/tsFs1NfDJ+KLaAT
         jFYD7GndtpanuLw8+4HG+WzWwhL8vJ7HWytMU9MtYyvmW8g8ZkzOflYio833Lkjw+002
         CU8SpY5XKIBrazg6ZhHLBUl6n4b4O/cLkObgPf3ET7svt8V+WI90EfTcWHJJfJPsag5/
         CKkCsfys2jjH54YkL/1iUAGzI7kstmAkymdlV5TXKO9XptV1037j2KIqDs2MaWlW3xZX
         Tm47AxdqIQ/FhAJBEvA3sqA0aBiIbY19kppB1o25+77fUoBGtUHPqwoxR1EPGxM3AkhF
         Cu7Q==
X-Gm-Message-State: AOJu0YwHppA4Obgc7z3Kb5ikMYECIRNnsiPX6VuTKH3KJ5GAmrtRWQv9
	NkyKs5tLXCmTrulSGrP+M6VEH27MmQIniKgpt9QJzmc8sOb0AqXqaIJa25bG3tofXrGm0VbRhS4
	bMIYIIW2M3MXboquTyX3d0uzYPKwI8RJi
X-Received: by 2002:a50:cdc5:0:b0:557:4e8a:f2e7 with SMTP id h5-20020a50cdc5000000b005574e8af2e7mr6171032edj.0.1704801448954;
        Tue, 09 Jan 2024 03:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq7Ws8ENXGDpEIUdt0ipq6kCaEoxaN96wm+AvF65t758FqNq+zEDYsolqxI9CloUeuwGbz2w==
X-Received: by 2002:a50:cdc5:0:b0:557:4e8a:f2e7 with SMTP id h5-20020a50cdc5000000b005574e8af2e7mr6171005edj.0.1704801448612;
        Tue, 09 Jan 2024 03:57:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-40.dyn.eolo.it. [146.241.252.40])
        by smtp.gmail.com with ESMTPSA id dm3-20020a05640222c300b0054b53aacd86sm874254edb.65.2024.01.09.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:57:28 -0800 (PST)
Message-ID: <afdc7a0ab0015cd72943634c5e4acab98b3eea74.camel@redhat.com>
Subject: Re: [PATCH 0/4 net-next] net: mana: Assigning IRQ affinity on HT
 cores
From: Paolo Abeni <pabeni@redhat.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, longli@microsoft.com,  yury.norov@gmail.com,
 leon@kernel.org, cai.huoqing@linux.dev,  ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de,  linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com, paulros@microsoft.com
Date: Tue, 09 Jan 2024 12:57:26 +0100
In-Reply-To: <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
References: 
	<1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 02:51 -0800, Souradeep Chakrabarti wrote:
> This patch set introduces a new helper function irq_setup(),
> to optimize IRQ distribution for MANA network devices.
> The patch set makes the driver working 15% faster than
> with cpumask_local_spread().
>=20
> Souradeep Chakrabarti (1):
>   net: mana: Assigning IRQ affinity on HT cores
>=20
> Yury Norov (3):
>   cpumask: add cpumask_weight_andnot()
>   cpumask: define cleanup function for cpumasks
>   net: mana: add a function to spread IRQs per CPUs
>=20
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 87 ++++++++++++++++---
>  include/linux/bitmap.h                        | 12 +++
>  include/linux/cpumask.h                       | 16 ++++
>  lib/bitmap.c                                  |  7 ++
>  4 files changed, 112 insertions(+), 10 deletions(-)

net-next is closed for the merge window period, please repost when it
will re-open in ~2 weeks.

Cheers,

Paolo


