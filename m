Return-Path: <linux-kernel+bounces-103348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1A87BE65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89D01C21EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6299A6FE22;
	Thu, 14 Mar 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS92/yl5"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA86F523;
	Thu, 14 Mar 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425096; cv=none; b=rd+xLEZTeTw49vckdKdGDKcU8N0j7OHwYHoea7pk+CgkE60gr68abbw59nJf+MwuRTiicMBX6iDDjm5rLVV5VYkhY+XDEsUdy9EcOLA7u6xifJ5BEcR0gkBuPJqxJTsZL5c6GIRAS9kp/ww5TWaSR4dT0E4PAoJa6RUIlUPtZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425096; c=relaxed/simple;
	bh=ITZ3dKpgcqMVgeYuP89fUJum5q0GYjDW5jqXG2GngTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF7oALOBCy7fa7+LQ9QdaV/GIaiCswODP/jHpgASB/Dn7Sy6KyZlNQ0FgZwdNY4vVhgdA1J6JbdZDOWcbyAQYeh6UBSYcWtng1YF5TpZR2KBpJ1rMxDodov3xDHO5sGw8Z/nxG+fmV8df6JdkAvMKLkPJXUg94r9nUCPy1eCffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS92/yl5; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-41324a16c9eso6183005e9.0;
        Thu, 14 Mar 2024 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710425093; x=1711029893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITZ3dKpgcqMVgeYuP89fUJum5q0GYjDW5jqXG2GngTM=;
        b=FS92/yl52GPkd3NvW/OoEQV3QpyaDfDGob7l/ZYqOZTIDAsmfM3md3G59QoR7ENRM9
         IRMkL9rP0OQAMbF/0UBuqyQjX7VyjrX+fPaZU4Vdp1pojJABzqdG5qaLQiGwExrePRvy
         6Tvh2XmBYVvQ5HRLhvR9UgdeNAOeS6gdgrvn86DTJXKIh0NAw3WXRjPdA1xzeHhT8rh6
         RWTSifM8o/oGIWp6imBkV8Hu+xKsrpV90qgMRM/Sb939j4VtsQFxa+0Tve85esXW16SQ
         tJ+vCnjt77iwD3FvT4+d3tvIz0BoSLPXbp2ACJxHWoBtnmFLYUR3/9BD51ZN/eb4j0H2
         F1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425093; x=1711029893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITZ3dKpgcqMVgeYuP89fUJum5q0GYjDW5jqXG2GngTM=;
        b=AQFNDR7MxLyqIS419APQLxEP8kkMCCziWHk5gC8oz7w2JyD2r8cwYhzGZeTsoqy8tR
         7FiwiY9/aG8tZ1HtXKQ5nqFKfHxOqZ/8ghpAYAWIg830dvxCjEmWke/sP3kUZRIBswsP
         A9yLsBEWxSKEia3RaO/InsRTVEkxEi5YW/jJH7xiWwxmpV/46M6kzYNSEtJUnZGvm0RY
         /borDB/1mhFU9BYglMa45ovtmA0pak3qZnUpn7lo6xBfcRjP/1wAm8dcAwP4wtqjSuQN
         3OXHDppeJ3pX6btXju9rwocCjGkuxiWLSyP89MNcWPlwAuddEJ2O8ksEuxaB3OHBw9ut
         l16A==
X-Forwarded-Encrypted: i=1; AJvYcCW5c1/AJoLYhGLTF0PJXO8FTOkGc2uTtnI2fg6iprqZ2YiGoWjFUX3vq8bmnK//2Pldfbms6A30DQV96pjrLUVxNmrNXE5Mzn5EWc324XF27yPYirHfomBiEgFdyE7+iUw58ET9
X-Gm-Message-State: AOJu0YxK3CO0SKMbfr/w1K4YEwog62rD9XiVMcjmQPDHa2YQOkZh0uRI
	VkMghDbqdWpJwdXK27ccj6is8XS2kkGEacEefPqn4V0EJ2g+SERD
X-Google-Smtp-Source: AGHT+IHeRU/6m15vM3xUViFf4l1SIZIIT/mlJnGLHtC6ocHThn+bOAV74CF7OwdxqnWkLGGI0AmN2w==
X-Received: by 2002:a05:600c:3506:b0:412:ea32:e7b0 with SMTP id h6-20020a05600c350600b00412ea32e7b0mr1398868wmq.40.1710425092579;
        Thu, 14 Mar 2024 07:04:52 -0700 (PDT)
Received: from localhost ([217.212.240.67])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b00413ef6826desm2566738wmq.4.2024.03.14.07.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:04:52 -0700 (PDT)
Message-ID: <b90d127a-ec5a-4c24-8ddf-4c592dae28f1@gmail.com>
Date: Thu, 14 Mar 2024 15:04:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: dst_cache: add input_dst_cache API
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
 <20240307171202.232684-3-leone4fernando@gmail.com>
 <20240308195529.57b1a4fa@kernel.org>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <20240308195529.57b1a4fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks Jakub. I'll fix it and submit a v2.
What do you think about the patch in general?

