Return-Path: <linux-kernel+bounces-109873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0DD8856EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79563283EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A356B7B;
	Thu, 21 Mar 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dX6wZcEm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FF54F86
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014983; cv=none; b=YyGei+CdsYZiX6crG4CXQuG+etD8y6005h/4cwnWaMnL58yxUgWnfcSV6VFFL89DTu4hcNPH/QRJ0ToEY8/QJuGo7mdp3a6dTjN4zJZuhpUpMfEJDbstfLnT8ymT8CIaHsow4YMO2UZ0eZrATchqZrL8mMvlpNQgslYgZN/KI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014983; c=relaxed/simple;
	bh=IO+9vowruzoaiNh8DcWhzWYf/YIoE5qaUL9K77WgNBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7fz14C46jPicZVwupzIaqiS14cdnhRKMHEoiGv9NDPix9ibYDS5LZZyaOrakVrqlSNZPNZ4NQFBEbK2ll7imjIAr7aaYYEs+UFE7x4BgPCwuzPSxXig+UHxwEIEqg2KhKGlBeFlWbtcDxet5e+ZPZ9vqApRgpOouao0Y9R4K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dX6wZcEm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5148ea935b8so901538e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014976; x=1711619776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO+9vowruzoaiNh8DcWhzWYf/YIoE5qaUL9K77WgNBk=;
        b=dX6wZcEmU5BFGgyGM78gwEKR+0IzLlEgilwKV/P1fe/WsK/2PX5xUYoU339L3iC268
         w4A8LnIYi6G8u8fAjvv7Z5MBvXSevudQGY6qhgEmjnwBEk0dePJY9CktZnEydNYDPEEq
         CjsN6P2IHO9UwRJKKYt3NS37jSZokPd7Z0Mgaswd0uhv9gcEgCuRc2PhOT9l0OHSXInE
         n+NrAa299MzWoDOZG0KolBE2G5ZXbjhcIf6gNrgqtLi0YsTricaHJ3kkcLSSKn6WXGQ1
         0xX7bKot2NYhKPJl67KdAP+CPtQ7k25ArFdtTXqEhIq6cdU4a644H22WCBeKNgL63i2t
         Gu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014976; x=1711619776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO+9vowruzoaiNh8DcWhzWYf/YIoE5qaUL9K77WgNBk=;
        b=FWpZqyfvhZLLjC6qQfD+R/LffXObqhtoYjDrU1k8nqsH2T36y9Vxib6vaMfS+Fca3+
         CZTCYRctPqljWfkZAqJ3SbfF/8cm+USH2XLdfvncz+IBll6E0chhOmz1G0rOpdomAcPs
         5QLPiT8/HF9lbh4Jx/QvjC3/3nbyGl5OSuoETVVXKUUyICTL2CKEn73noxnz4A2vGojc
         BTZrG7iAJgBEEGkjxyEgLuzrjW46CwKwbYC96m4xQ4iPb3M91GDXicTb3XIKx7bFeQH4
         Jp2sTGlj3AKcFJQc18xwGnSe00DEljjNBbmNtAwtNUrcDdwF8fDTfFKsyL1/HmWsHnwm
         g7TA==
X-Forwarded-Encrypted: i=1; AJvYcCXRYjDoFR43FXf876uqsr45CYdnUIDW1XDT1MYSWPnA9747aeGCuSZqO8rywE0YppUJBLEgyM5M/m9w/D4oCNi/MDdR/vkDwChq4EkU
X-Gm-Message-State: AOJu0YxTM0kL7gYe2gNTYNZcJu44VISypshI+zw9YWlsFUO9S6cCvdtc
	TeRaAH/vfE9X81Ebjq+f3yShcoqG8IMqAOBAeqSNuHRxg3fdUw4wAa0x1lf3HP0=
X-Google-Smtp-Source: AGHT+IHiv8rCbj5/wtlh+JmDnjNNtstpYv466vmEYYp8jZzG/w8XqxgYhpCN+apuzqdNQWCtVmQYhg==
X-Received: by 2002:ac2:4da6:0:b0:513:e17d:cf40 with SMTP id h6-20020ac24da6000000b00513e17dcf40mr3525391lfe.7.1711014975994;
        Thu, 21 Mar 2024 02:56:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fm22-20020a05600c0c1600b004147266a37dsm2072060wmb.30.2024.03.21.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:56:15 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:56:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <ZfwEPA0dxi2VN3fD@nanopsycho>
References: <20240321020901.443642-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321020901.443642-1-duanqiangwen@net-swift.com>

Thu, Mar 21, 2024 at 03:09:01AM CET, duanqiangwen@net-swift.com wrote:

v3:
Date: Thu, 21 Mar 2024 10:09:01 +0800
v2:
Date: Thu, 21 Mar 2024 09:51:39 +0800

Where's the 24hours before re-submission?
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

Next time, please honour that.


>txgbe clkdev shortened clk_name, so i2c_dev info_name
>also need to shorten. Otherwise, i2c_dev cannot initialize
>clock. And had "i2c_dw" string in a define.
>
>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
>
>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

