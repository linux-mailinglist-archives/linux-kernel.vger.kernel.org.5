Return-Path: <linux-kernel+bounces-47824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A284535F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A8E28BF31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059E15AADA;
	Thu,  1 Feb 2024 09:02:54 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80415AABB;
	Thu,  1 Feb 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778173; cv=none; b=QKmACzeXU3DN/o+h2S8r+rhCbmDnKGHxjfnk1PBBiJ2wDl3pXOS2s2elZqqNouWACkoXwqVfWwxv8Cr81R87U9GxtmCX1hwnIh/kbVPXduHFeHjTzEs2hcxtBLzOwwZB4ShkxtGYSsSFCDwOIs90js33Al5Esn3EMNvcbrL9FJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778173; c=relaxed/simple;
	bh=+DMkfcQRY0kabbqcrrB8TeJZsVn9GIf4FTlYS+8wIpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFgqwOurPIrCiplRSF/mb6UkDn2it/WeQf85YTvkyDQVaSNVjvLyiJfWwB/mbOQnoxYFnGms59S/zxEUk68E6Gf/dtwJ6Wnxt3IQ2woYFD7+DmgqoNWGolLewr7s/NJwJmKxS1f0IYkpG1QplU7gU+xFMGngaZMHzTDoNLxre60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5112cb7ae27so1224797e87.0;
        Thu, 01 Feb 2024 01:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778169; x=1707382969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd2c+CX881s9B5blOUk+/zj8aF9uYV2A5nr/DOovMGo=;
        b=q/O2rf49IjkpQRVgz3FrqgE1whvOI12J/K7+3WfyuiaZg2XENCW51C65dqyidgKI99
         /or+7lVQ/a5Dzb6IFswReYbcOB7zcCVnCviDh7ZbcnwwTrwXRRYnOWVcBXCK7voPBD5r
         Jki8jXbSNL7bogIof/T/ud1NkWNiRrWvEAX2m9FX1dbO1k3aI7XZvgpD+Dc9nvFWBcas
         DkcW0vEwToATfxVB3Obh1PgVKR4KxzZe86ICG987Eh/xz2hCAmsdEyZbcMjJpaH8HzXC
         NCWyJkaupnel5boJZgAqTC5dRw+9SaNUlFLMYYA7FygK11Rnd4iJKWza3Waqktt4qmgr
         /Lfg==
X-Gm-Message-State: AOJu0YzxZGMcjdD03jy+d4znSys5BVSogY3pg2zJHCPvdQUefAIasvHy
	gwOUKQ0r81MGPzpNENXRG8a5WHBWlfuWnrlMzAEXYDl7tQm4hP3NrObyk/6egGI=
X-Google-Smtp-Source: AGHT+IEM0YMluzM35hvCRecPyeTWXKfOO93vIwxvFqLerGyyGQOrhDFcV7MqBuaTAPsv9Me2XIMQXQ==
X-Received: by 2002:a05:6512:443:b0:50e:74e1:144a with SMTP id y3-20020a056512044300b0050e74e1144amr1342437lfk.15.1706778169053;
        Thu, 01 Feb 2024 01:02:49 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b0040fb01d61a3sm3706956wmc.18.2024.02.01.01.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:02:47 -0800 (PST)
Message-ID: <feabd944-47b6-4ea3-bde2-b6e90c58015f@kernel.org>
Date: Thu, 1 Feb 2024 10:02:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: This is classified as spam [was: [PATCH] tty: fix atomicity violation
 in n_tty_read]
Content-Language: en-US
To: Gui-Dong Han <2045gemini@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 baijiaju1990@outlook.com, stable@vger.kernel.org
References: <20240112125801.2650-1-2045gemini@gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240112125801.2650-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

all your mail is classified as Spam in both my private and company MTAs. 
Not sure what CCs' MTA say as I don't know why (as dkim, spf, dmarc all 
pass). You likely need to fix your mail setup somehow.

Headers:
> Delivered-To: jirislaby+korg@gmail.com
> Received: by 2002:ac0:d5cb:0:b0:2fd:5d7f:bc30 with SMTP id u11csp768930imh;
>         Fri, 12 Jan 2024 04:58:18 -0800 (PST)
> X-Google-Smtp-Source: AGHT+IF/3LYNmNd1d7yS4c746ryIOjwWPOlNU7fcqvZ7ycEWFsrcPzEYgEqRc5d2BrPcf8yom1He
> X-Received: by 2002:a17:906:29ce:b0:a28:b085:5a86 with SMTP id y14-20020a17090629ce00b00a28b0855a86mr594229eje.133.1705064298179;
>         Fri, 12 Jan 2024 04:58:18 -0800 (PST)
> ARC-Seal: i=1; a=rsa-sha256; t=1705064298; cv=none;
>         d=google.com; s=arc-20160816;
>         b=X5hO2nwthigWdqlDEp9mlArxmch62iPLf7BohvIaT+FLSQtkY/wROZtenuCZT2bV9y
>          NhTy4ua83SjlXUsReLP7dwbOjQilwdqiKFPMKTn+tJmShfcxdaYjvpAr7apSZi4YpEQf
>          uRoWK7W8JfpVKFQT4D8cHv9+hliBxhmC4GRLdKtp564+bpO3j/4zsENIe9saFzMNqmM8
>          QVhZXotHRShB2FdZc/VmxiNe4eXnxJ8KIhQMJcuo3LdXRiWrQ/2vXgBcIfsfr4FQeZM3
>          xacjxp9OrrdUlUZQdY1JmfiU13iN+b4oiu7W2suuj2zSUbdUT3vcufTBDchwEX7S84Oi
>          Sy7w==
> ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
>         h=content-transfer-encoding:mime-version:message-id:date:subject:cc
>          :to:from:dkim-signature:dmarc-filter:delivered-to;
>         bh=SKCP4kSmi8Znay+ncNnEwwM69gACCAM8H97RoLluFSU=;
>         fh=fP+uh1DN39DuEzOCSiaLKB3WTgSPWFk9ij8kCOsTwec=;
>         b=acW4d8Z6n1mvqA9PwE3vDYYyHpDkDTNIfnmf9bbIVDFRzIZ1g5eGCnxCmJ9kA68nAW
>          AZ79DUtrCYuuWsW5mLidpsdDDKWB5iVy7xpTtlTOhrA1A3QHk7d9afk7d31lu73SLJ+s
>          cim0UxXCsyOIdPeWlaKeKB3u2gozSBP/wN/jMtqxfzbvZxjZV451c3eSSI/093s5Nj3/
>          U8tjiUDidbRkRIk2GRiwOMU2FIEORIyAylSNBtGJvlQ1CNavVQ3nU/OcMeaQ150+FIKD
>          gQY4khoMEyVPph27tYwZh6exWeZcuw2jVG72JkTJs3ZEwR/B+bPBobFPjIK4UzkSwn98
>          yTxA==
> ARC-Authentication-Results: i=1; mx.google.com;
>        dkim=pass header.i=@gmail.com header.s=20230601 header.b=EvmWOavP;
>        spf=pass (google.com: domain of srs0=twir=iw=gmail.com=2045gemini@kernel.org designates 145.40.68.75 as permitted sender) smtp.mailfrom="SRS0=Twir=IW=gmail.com=2045gemini@kernel.org";
>        dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
> Return-Path: <SRS0=Twir=IW=gmail.com=2045gemini@kernel.org>
> Received: from ams.source.kernel.org (ams.source.kernel.org. [145.40.68.75])
>         by mx.google.com with ESMTPS id t10-20020a1709063e4a00b00a2a224d5420si1409203eji.776.2024.01.12.04.58.18
>         for <jirislaby+korg@gmail.com>
>         (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>         Fri, 12 Jan 2024 04:58:18 -0800 (PST)
> Received-SPF: pass (google.com: domain of srs0=twir=iw=gmail.com=2045gemini@kernel.org designates 145.40.68.75 as permitted sender) client-ip=145.40.68.75;
> Authentication-Results: mx.google.com;
>        dkim=pass header.i=@gmail.com header.s=20230601 header.b=EvmWOavP;
>        spf=pass (google.com: domain of srs0=twir=iw=gmail.com=2045gemini@kernel.org designates 145.40.68.75 as permitted sender) smtp.mailfrom="SRS0=Twir=IW=gmail.com=2045gemini@kernel.org";
>        dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
> Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
> 	by ams.source.kernel.org (Postfix) with ESMTP id C5199B82253
> 	for <jirislaby+korg@gmail.com>; Fri, 12 Jan 2024 12:58:17 +0000 (UTC)
> Received: by smtp.kernel.org (Postfix)
> 	id 3B5B1C43399; Fri, 12 Jan 2024 12:58:17 +0000 (UTC)
> Delivered-To: jirislaby@kernel.org
> Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
> 	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
> 	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
> 	(No client certificate requested)
> 	by smtp.kernel.org (Postfix) with ESMTPS id 0BCAEC433B1
> 	for <jirislaby@kernel.org>; Fri, 12 Jan 2024 12:58:15 +0000 (UTC)
> DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.kernel.org 0BCAEC433B1
> Authentication-Results: smtp.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
> Authentication-Results: smtp.kernel.org; spf=pass smtp.mailfrom=gmail.com
> Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598c92465c2so263240eaf.3
>         for <jirislaby@kernel.org>; Fri, 12 Jan 2024 04:58:15 -0800 (PST)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=gmail.com; s=20230601; t=1705064295; x=1705669095; darn=kernel.org;
>         h=content-transfer-encoding:mime-version:message-id:date:subject:cc
>          :to:from:from:to:cc:subject:date:message-id:reply-to;
>         bh=SKCP4kSmi8Znay+ncNnEwwM69gACCAM8H97RoLluFSU=;
>         b=EvmWOavPxwjgc+yDYIiyY/w/z1xhXMRSVpdywGaxL7rklmdTONNRCxvtacNNITc+5J
>          kw7sEpuBdUYGg9ynslYzKdiJqEaMqG/tVw1VA8WglLrc5WDiWVe0Ly6pAF0n7qtVmPVi
>          pieUNXbpLlfcVuDrqczwe9IdUuAL+d+UNkqf+GkHSVJ/NzKicOB160AvopFIYN6Qoj/d
>          qCQVQ4iy3p44eZ86MbztWy94mN/JDaXJjFbvuI5v/Cfx8LmJJT0V44VBmD3mPPGNAzy0
>          Ho/htuIS78Mz8hEf+JnoHkVsHH+l3R9XixAlz4L3w+eM1LxwNzK1AXbGZnAdBsLmbAIr
>          4YgQ==
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=1e100.net; s=20230601; t=1705064295; x=1705669095;
>         h=content-transfer-encoding:mime-version:message-id:date:subject:cc
>          :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
>          :reply-to;
>         bh=SKCP4kSmi8Znay+ncNnEwwM69gACCAM8H97RoLluFSU=;
>         b=Rkanvc4aSfPbP0ynJz41MBjbAVn0zKy8x8W+ftdoY8DkbJ5x7/ENKVUjLgRkbXWuQH
>          bTp5BX8j7EF0EwnZ1ut2KYQPO1Nrb29If9XSMcG8D2fhaKSraPV7gwgVLwTmY6J2ObwV
>          EOv3uJXr4BVngTXEMdCG1uGhoW70YBDFciT2iHbK2aZ6oz3CdVAdQznVlxJXArRmzqcv
>          GvQvrlWI+qt7QWKiXzqI4DRkzEuyK/qNLfu67NyJ1qssm9mNt0il/GYTZkqdfuI/wxlI
>          yWtl4b0qyaEmNFVOIF8B8BLSJWs3y5YH+WZQxQSfZGrg26cN0OlBtj3N4oOKAIaOCH0Y
>          WI9Q==
> X-Gm-Message-State: AOJu0Yyyn81BwhbCgzcpJ5tAP9T/AjxpT0em8lzR+hmuGwzP3IAEgJw+
> 	+sAIT5qrT4keqaUNgAJRtBU=
> X-Received: by 2002:a05:6358:4d83:b0:172:ae2a:2256 with SMTP id cc3-20020a0563584d8300b00172ae2a2256mr1350395rwb.27.1705064294552;
>         Fri, 12 Jan 2024 04:58:14 -0800 (PST)
> Received: from g2039B650.. ([106.39.42.152])
>         by smtp.gmail.com with ESMTPSA id fd14-20020a056a002e8e00b006dad4c91e8fsm3103080pfb.205.2024.01.12.04.58.11
>         (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>         Fri, 12 Jan 2024 04:58:14 -0800 (PST)
> From: Gui-Dong Han <2045gemini@gmail.com>
> To: gregkh@linuxfoundation.org,
> 	jirislaby@kernel.org
> Cc: linux-kernel@vger.kernel.org,
> 	linux-serial@vger.kernel.org,
> 	baijiaju1990@outlook.com,
> 	Gui-Dong Han <2045gemini@gmail.com>,
> 	stable@vger.kernel.org
> Subject: [PATCH] tty: fix atomicity violation in n_tty_read
> Date: Fri, 12 Jan 2024 20:58:01 +0800
> Message-Id: <20240112125801.2650-1-2045gemini@gmail.com>
> X-Mailer: git-send-email 2.34.1
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit



-- 
js
suse labs


