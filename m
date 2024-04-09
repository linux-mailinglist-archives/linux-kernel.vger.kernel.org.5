Return-Path: <linux-kernel+bounces-137591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC14A89E457
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637B31F22C35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F715820E;
	Tue,  9 Apr 2024 20:26:06 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A88562A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694365; cv=none; b=PG2DxjpLkulwc1NRUnBArqNpZCFTCNux/2akICbVMbfQ2Q9hesiJLaznLDlKP5pdHSjvT7lASwRhmC3y35mpe7AHBhUOMROBLeXxqBdywZazgviVkpoem6YT6Eqpj3fzMoKP6+XZ8P9//F28285LiG5p/Mb3y1C9RIeQpyjRhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694365; c=relaxed/simple;
	bh=GsSOOBo7BskdQReYphJ+zB1eNZZh6oDLqHlP86aPuOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T60eLwFPFr8J3i0qIeNluvX+H8pOVxTtdAiJIELJlOqJ29a7EWdcDtglksSbO6OMbU9jvtK7jLkBim4V3UutS87s5whgR2w5yxyXcvlFeaSU6hzdzGRWMOdHKOL84M71jvEqKYrMgVu6OVlyaY+q1Isk+Ky0cbP5QQj1mWxDiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346407b8c9aso293230f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694363; x=1713299163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsSOOBo7BskdQReYphJ+zB1eNZZh6oDLqHlP86aPuOU=;
        b=UGpwuq7RXjgfDgsGbEeftuEWz3TqcEesZN1pjrI6HD64SWweG51JN2XkT+DggG135L
         ftM4SsaU9+/C5zyT9mzeFlgfX8kkDZE3y3SWJobm9FsAFEVArzI24JmAmkOt+NrjSZvy
         Tm7/JdCNvtbYqUFcRbKr7i4K2ni+g7xuvH3xH/WTYMn7oZtgWZ10Jpc9o8cjxVzsRZZi
         qGJYAwrTt+jWd8T262mA+16SitkCdLgXnOpPpCHrUysbjrDBcd1Ki1BOrNmFp4IMm2zS
         lM8J/+9CO8GgGbACRhUKvSMvCMza9OkImZ8HVouxy8FsWMc18YhT5UV2Bj2qZrFgg+mf
         BqZg==
X-Forwarded-Encrypted: i=1; AJvYcCX3fAztr8ZfLaxGwTQucI3PTx7dr4IEBASihFb7H7RDaVtIFSBbrn0xjwvc81urpu4Q5Z7D+20NmTW71WMqNIqEEj9NKbw684TnTJFu
X-Gm-Message-State: AOJu0YziEjxcJbdcJ20m2AFGRJW3vaJ1QpRp8L3raW2MHHfxA1QAB8rl
	F4QRd9Vs9YeZIJRheN9ntQPnJzf2+zEqYQ/rbJVAWDKBueWhXNxOLtzdr64B
X-Google-Smtp-Source: AGHT+IGzGXnDM7mT5hLOWyum+cQbDzz0Wlemyd3ZAbiTkKJ8Jp5bcZrhbdd+hdqW7Phge0yFk1tHIg==
X-Received: by 2002:a5d:4a4e:0:b0:343:c3b0:ee39 with SMTP id v14-20020a5d4a4e000000b00343c3b0ee39mr444775wrs.5.1712694362397;
        Tue, 09 Apr 2024 13:26:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b0034174875850sm12329296wrw.70.2024.04.09.13.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:26:02 -0700 (PDT)
Message-ID: <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
Date: Tue, 9 Apr 2024 23:26:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Any authentication errors which are generated internally are always
> non-retryable, so use negative error codes to ensure they are not
> retried.

The patch title says that any authentication error is not retryable, and
the patch body says "authentication errors which are generated locally
are non-retryable" so which one is it?

