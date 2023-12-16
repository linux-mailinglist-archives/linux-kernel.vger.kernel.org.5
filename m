Return-Path: <linux-kernel+bounces-2358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E548B815B96
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C421C21BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41332C62;
	Sat, 16 Dec 2023 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfnurh4T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CA31A7F;
	Sat, 16 Dec 2023 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso1004888b3a.2;
        Sat, 16 Dec 2023 12:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702757643; x=1703362443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISKon5ZR/yS/6ND76BAqWus+LJVP5hp+FFcICHrHPPE=;
        b=kfnurh4ToymyMl4cyWXrvOuSsQDxzSfOvhoI6Oh1hti1Sa/58eWvTRcVPHaTsNz9pZ
         3DWSHJlc2RTaEokWeSboOfSiGwDVjRDbI/FhFOXz8uwRcFDjq+7qKKPcBISTPNL6cLGq
         uoUVkK1lfyFllqgbMVAJFiSx+cXF/wm5J2Y9GcOQ61iEZC5Q+ifnLkIXqHBRNMe1a58E
         AsG7E/YLdPKKLbxH9958qtg6mBwUJOB8zuradcP2vZdqJ3naBalZH7PRbo5zZGoYdZzA
         7mbYS1MPqwQ935zFwGFM/GPQKnZb7r7YyYpdLW7dCstFIfWIUPrMcAbcm0aMJPrM0KY+
         v6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702757643; x=1703362443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISKon5ZR/yS/6ND76BAqWus+LJVP5hp+FFcICHrHPPE=;
        b=ikvJLSzuuoFg5u6bUmzQ7zp5msmn0XKmxKbpA5lw10IMlbClVUpYudRvYqv6IumNH4
         NxYjwtHvkMjbzJHelI5QDbSYWOYAuoFyM89ZRvdZaHez7MB8pVK79KR7AR0b4kEuTf/k
         VJ6Le8r4SWvEDZLKsp7f8mkA/eZ3GZDRU8cCOV42Ip8JH89pjlle4UWbYgIoluEpXGQ2
         ACZPW3lLh6wq8cI651z1oPmS+PX34zsia9xgkG2dqBeMv5LDbOVsaN2gh776uQg2BwSJ
         KIglGUnkts1q44P7mW7uRRLQmx4ogJ/zlGOPXSSB07tXJB6/ObTzgfO5T4l6UlHXVJDq
         z8wQ==
X-Gm-Message-State: AOJu0YxbU9OlrKL0y2KoESpaITbRMYxCPhd9stZ9p23BTuPT25vlGh9N
	DRw8mJv8x2i6wQhvHpQlmOo=
X-Google-Smtp-Source: AGHT+IHr4BnYJvxaRaxU2bkA+nYi6DJEV4q9VROEwqKqTqiPkPD9UDAmj82NIsSQZnccO5jOPk60MQ==
X-Received: by 2002:a05:6a21:99aa:b0:18f:97c:925b with SMTP id ve42-20020a056a2199aa00b0018f097c925bmr8427793pzb.64.1702757643323;
        Sat, 16 Dec 2023 12:14:03 -0800 (PST)
Received: from localhost.localdomain (1-170-84-144.dynamic-ip.hinet.net. [1.170.84.144])
        by smtp.googlemail.com with ESMTPSA id w10-20020a170902e88a00b001d38410aa13sm3242188plg.192.2023.12.16.12.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:14:03 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: Larry.Finger@lwfinger.net
Cc: Jes.Sorensen@gmail.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU
Date: Sun, 17 Dec 2023 04:13:59 +0800
Message-ID: <20231216201359.8176-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216165259.5389-1-zenmchen@gmail.com>
References: <20231216165259.5389-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> On 12/16/23 10:52, Zenm Chen wrote:
>> Add additional USB IDs found in the vendor driver from
>> https://github.com/Mange/rtl8192eu-linux-driver to support more
>> RTL8192EU devices.
>>
>> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
>> ---
>> v2:
>>   - Not to put these USB IDs in CONFIG_RTL8XXXU_UNTESTED
>
> Have you tested all modes including STA, AP, P2P, etc? If not, then your devices
> belong in the CONFIG_RTL8XXXU_UNTESTED section.

You're right, I haven't tested these four devices, so they should be in the 
CONFIG_RTL8XXXU_UNTESTED section.

Please drop this patch, thanks.

>
> I am also not fond of splitting the rtl8192eu devices into several different
> spots in the table. That only makes it harder to see what devices are supported.
>
> NACKed by Larry Finger <Larry.Finger@lwfinger.net>
>
> Larry

