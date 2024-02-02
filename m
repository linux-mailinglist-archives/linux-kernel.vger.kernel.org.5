Return-Path: <linux-kernel+bounces-49980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B30847278
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6E61C244B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32531145B05;
	Fri,  2 Feb 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRup/HNv"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6F144609;
	Fri,  2 Feb 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885997; cv=none; b=J2SM8k9F/JqtsOp05MHN0Da5ASNmWDzs/Ym0Gln2rzQSsSiz0teW3PObmbs0i2Y9IIEx021W+VWM1/q5mT20pebINTzsWYxvhzPygYs9ARBlxUGJ+Y80Zhhyb3kV8iK2crfIS6K+s25XjQT6eQZd4ff+21+dn+atIPHa6lsl1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885997; c=relaxed/simple;
	bh=CuetZk/+EkjNrIs+1rRl17K7bkTvfXOKs+1QbXGDq5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Eni+zN5p39LK0Mp0tJhmO3lN/RS4PoFq4J9RfKUSRYs6wu7sZssLD0TR6f1cqTr0tsrOSULQ5Wja+kyWCro3HYaReh8yWcYEFSqxrxSGo1P7XvvB/VG/owt9nV1igXyvnW9rZpzj5OW90X+tEZVwUhgvlhpy2F5VYreph6i8pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRup/HNv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42993124fa1so12709341cf.3;
        Fri, 02 Feb 2024 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706885995; x=1707490795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kU+/unKfx+Ejj62/GX3qwwj1B4YVl83Qf5yBYnMpIZ4=;
        b=gRup/HNvLHP5VVkBwZWORBMdGTw8u6kVfpYM7oGG1bcIuG34lGNb1VYYrY2FApv7R2
         YfZWgRujpfz274TGDrpFAkSjyOevBFpmEUz5J1ioVhJTCVMO/WJkDbeWcKvH2VbV52rl
         oyZjNd182IBXkzkASgFdzhfRR+GRyLj8iaSuH6dB9sNWU2vh6q7datOQ0JwqiwWxfP2x
         6KCDvYBFkgOEJFjjNvgxNceYvUBORCU85Qs0MV3vJAnmrMqzC2QMfNO9HSuyAHjlI5FG
         JALk5kvRrT12ip99pknQBYusjDRNYiINdJs7/XOl0sTYGx9NJaIuOCz0KEbDH5w3gZtY
         mthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885995; x=1707490795;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kU+/unKfx+Ejj62/GX3qwwj1B4YVl83Qf5yBYnMpIZ4=;
        b=oTTtDt1x05Lt7ujMg5kBC0R+gSOaVk31f8/18yuG0Cr0EXefqm0rkxl3y7NTYUm6Go
         DM5uBX7qvTUNmdlPv4F1cVncbEqVA+WapDCp2/k4U7nh51ZRZS7gA3F4kS/k/HU/4XiP
         fEsNWRy09HxdKwTBls4y9oJEHXnKeyTAIfth+N6PjsrP9qs5wpX+CtJ0/cscRzbLnhO7
         QUxQwIOtgJXXODYO+tHUma+x7I8V0VYejYhECcoT2YupENnwEZClUJQMHIq+7x46Tq8N
         fc/6Kgq4or0jZxnjnGkZorFlLAF49MCXPUUQ8H55KZZan0sjyL0bUH94FKYtfGCKS8lA
         y0YQ==
X-Gm-Message-State: AOJu0Yw2WKjF+vQpwfFEoH6SlHI9ogWSfl5okSaKxLqZvQX+VqhBq2a0
	7TX8GY4QBDfEeSQ2M3l1Rx7DYMdOgONxmtppQhtN6UwoNsPfjXua
X-Google-Smtp-Source: AGHT+IEj6xFOhZkwYpfItM/1RHkGeN6347sPU7cybTUdPt1BdyI8nsx1sWRNXYJ7d1Qk1fZHaOW4RA==
X-Received: by 2002:ac8:57c9:0:b0:42b:ec11:1a6b with SMTP id w9-20020ac857c9000000b0042bec111a6bmr2065012qta.67.1706885994784;
        Fri, 02 Feb 2024 06:59:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSfTOAl+HMNROlvzaMpmSsNFz3QFPrSf/Upgh62GWhLcQr79rAQQOj8lX3QHn74qNcID09EyJWNiqwyC2vb9NBUXoaJFnlFHarQXEcH8P+79PTbS5eKgaD3wTR8Zut9qQzmTG6Dmdbphy7SHO59jZ0J3g6JO3kef7xPrNN2S5XgJpdulTCrI3R31MQIbRweypEhthxq1jbwCXBfL2FpClhNMWtgdf+yflo83lmhE/MHKWinB8N1WDOAu/TQls5o+Eaw6QpaWeiMlCQmGciuzg=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b0042bf2bda630sm873773qtb.68.2024.02.02.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:59:54 -0800 (PST)
Date: Fri, 02 Feb 2024 09:59:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 jiri@resnulli.us
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65bd036afa50_2ef2a929420@willemb.c.googlers.com.notmuch>
In-Reply-To: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
References: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net-next v2] tun: Implement ethtool's get_channels()
 callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> Implement the tun .get_channels functionality. This feature is necessary
> for some tools, such as libxdp, which need to retrieve the queue count.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

