Return-Path: <linux-kernel+bounces-165885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3518B92F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9BDB20C38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D21643D;
	Thu,  2 May 2024 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCbgBEMr"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91ABFC18;
	Thu,  2 May 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611060; cv=none; b=AV26rNlVm6BdcoTtVqTvUzOWlV1Ms4OWBDO3jXwKKajv9lsO+tMxLHX/Jvi6K//rlvEJ3bWkwmSK8rXG4GbO3llGhVCb0WOIH1LKBHSEIunIJ4p9dd1gNyf3seOSxIi9MTPbjH3b9FPiem77KrzR+MuvW6Iu5xigHoXmTcf2KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611060; c=relaxed/simple;
	bh=iYwlZk09lGEg5SU8dNZHUSzybOX1TNAiKtHww/Lb6ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3WH4RTv/NdWsn6QlCsMBmk1KE3YU/7IyFDw3RkbEepG8fZ1C8/hZg6nIdDcxZ0qpZyjLVZ7UnJDVsz057JwevICRK68BSZdorqRrf0r1S3F3Z0+J+rk+yNjoSTvJ98aI+Hdt8t7CIPaqbUG+R8qA42sS0pGp2r4G0IciXbuOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCbgBEMr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6effe9c852eso6547398b3a.3;
        Wed, 01 May 2024 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714611058; x=1715215858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmLIxq18jhqSpH6wwbeekfAu7FDAZjqkdNP+HNU2GsE=;
        b=cCbgBEMrKqwFzccq1xnLFTqTSnuPrpaGlvoR07sJZ2atLdQUu1cFWENOi7Gky7pilU
         QXRj9QwLXaIm5qE1B8lhBRifMdkkzGmn47tx1WZKHqW5y7e1zNfkTkq8gaO4a/HfDSM6
         e5Jr3Qo48gjkZQpkzCcRWYzxcql2zB0wsJfR9Ru+klqlVrJARZ57oyYL2WGwDxuOnrNA
         KwiZEqBv3b/Mov1+9+qJeqGSS9aC81rwzZYllfkX8qvZ+rxymFPecA0zA+se2/ia8LXC
         85XLP7Eh83qOP6+onKIUvzXVkRCmgoTGZKcnS0uKE3DEfiXrDtH/oDKUyTcllMnMP51R
         jn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611058; x=1715215858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmLIxq18jhqSpH6wwbeekfAu7FDAZjqkdNP+HNU2GsE=;
        b=Mo5VzuW2C9R1qooZJ1MBsomcFGoKQvdaNKaLkHpxI5vTQdH91zfXq75aKt/3n3gYUG
         vsxwtESONlCBy0cLmyLZdiLDBZFIlrNNgBjwGI28e15tVsn3ZyP39jPnxIrlhYgRtAlT
         283NJMS6yAIaIsOvtKopQ7QdciiPz94ySvVPAlWCJlpULkKWx+O/+GTvel8VSe+6mtiQ
         Rjb1OfS0aP08c7EFYrZ9A+0IbEutDBvs/yWd14DbnYW2y7pzp23XJZiysM3gv611sB0i
         LjoYs138HVDpC04yWpSN6hTWA+z37ZN+Z9ikIvpE6Nvsg+qWl0E3OJ2Be80bB6eyHCRn
         rZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZX3zjMtb7dLq5kktrPNTr47iohKtwlDE+BxnSzEKmpqmtrGe3k4UJzDVF27Hr1FwD98XPqpyi6dRSmJTrpPfGmmlG5iaeddlRwvZeaMwWsBmvqNAPDdEbKpinJ2QO5c4Vz3PpC/rASA==
X-Gm-Message-State: AOJu0YxhZxDTcgZz/a2OC9fTZBvX9QUDsX+LfobUj1aw/d4a0BD3B2nI
	9l97I+3cBQ2c731W30kWxHOX1AiURUFeTLr8WDU+aT+KxdKbutF8+s+IuA==
X-Google-Smtp-Source: AGHT+IFwn8ax05rz6vc9ez7T2CHuGf6DKVB3Mu6PTuI4pajvQwXVnPkoYQkY5l9rlad5X0NX+pJlFQ==
X-Received: by 2002:a05:6a00:2d87:b0:6f3:ed26:e4f5 with SMTP id fb7-20020a056a002d8700b006f3ed26e4f5mr774032pfb.7.1714611057989;
        Wed, 01 May 2024 17:50:57 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm23156602pfb.137.2024.05.01.17.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 17:50:57 -0700 (PDT)
Message-ID: <776e460d-b86d-4051-84d0-0388e2d57278@gmail.com>
Date: Thu, 2 May 2024 07:50:52 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Linux IIO <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Devicetree <devicetree@vger.kernel.org>, joao.goncalves@toradex.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
 <ZjLe0yIpMyPRl-eZ@archie.me> <20240502004247.pfevxrxf3ephw2tm@joaog-nb>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20240502004247.pfevxrxf3ephw2tm@joaog-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/24 07:42, João Paulo Silva Gonçalves wrote:
> On Thu, May 02, 2024 at 07:31:15AM +0700, Bagas Sanjaya wrote:
>> [also Cc: IIO and devicetree maintainers]
>> What are these ohms and where do you get them?
>>
>> Confused...
> 
> Ignore them. They are not real values. I got them from the
> bidings example of iio-rescale devices. The DT draft is an 
> example, not the final/correct form. 
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara


