Return-Path: <linux-kernel+bounces-83246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62828690C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0B41C239F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941013A251;
	Tue, 27 Feb 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jHCgNOSp"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666931A66
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037604; cv=none; b=FCosibVFnYMkJ4FlKVEssjKe1gqj3lp3EadeFlWRYhPt9klhFyXCb+9AOc4cx0MCePlHPuU9141jBX4PEo0AyuktemWy47se5wHHz0Lehf0SJOq1ngLDxU8YmdtKIlNb/hXbut9KpJLc7RZSHgb7P8mPbLZIYuIEoGK4AB8F+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037604; c=relaxed/simple;
	bh=3G5KA/KgvvnP+phbQfXRPEFm6i2mU+y0npJdWX/2CSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8+C+UmWutqPqhfeSzFygEf16lI8u7ROZGReQsPQC0qvdzuuCf8w//Zxr+cBOGS68VnwNCf088R/07t8N+tUsQAardbtOGbXpmBVjNDWO+1Bjcim++7lL/kSS6kyxS3pTG1O98H6861tiEYs4dsmevYfWHJdkbEYIWzCFOnzH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jHCgNOSp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso576940766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037601; x=1709642401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3G5KA/KgvvnP+phbQfXRPEFm6i2mU+y0npJdWX/2CSw=;
        b=jHCgNOSpMBU0VigG4iD9R5XshpWywf40VJuefxMlEEkiR0CaIbxbg70etnyiwxod+x
         0hIYb4B/gSNipwLL3hwbskrR7vTfQtuloJfKeo73D1n5eAVq1Ms5GkTobq2xBnOaaram
         xkgybw7b6srTE/Va9lbJZagTp7recqjZRlQoeZYEGg/BenYnYNiVkawQLg0615Jt2ttk
         wqgUvClBKfpbb0Pgk1tYXfkb9+q8Rt3O1B69x8JAblPpMRR8I3sxdXGkZbYbdgPEdj63
         0wGtSEz9m883N9k6XMmj4hM4VhncyB0FWh+kgYkgEhl12cOYNaiz5uP2359YhMUxbTdw
         HBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037601; x=1709642401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G5KA/KgvvnP+phbQfXRPEFm6i2mU+y0npJdWX/2CSw=;
        b=Yl0R9eQltIEyRRbn50cyiU3jIb5EpgKOnMQacqMP2XS845pz6iQ+yg5FtwXSAXz8nN
         W8s4GW3DKeUz56tPVP8aS852S/NGrtyJSvsJbt0w9+N3CgquDczeanqenCE8GmXZwaAw
         NTohrc/RSDEDFUDFdpErE+4ley9DT4kChRLImU4XI1Mbi7xYiZe/pzWpNqbarroBB8U/
         8Ofy18duxlPBKcO2yYvLqo3HSBe256VLnUqp7tfEX/45MfCXtLKN5qsQl5D9LYWggbyJ
         akCbym1dmWGvAi8G02w4pkrayJIQ4jhaerS8J6GxFOKXQs48VMijaqs5EDSRRv6BIMVw
         QGvA==
X-Forwarded-Encrypted: i=1; AJvYcCVGA3GbqK6afR9CuQNgZWHhtLxODB1E6SEeCbR6deWzy2D6/UHJEo2FTNbiGo3KPDxkQ+o6KngMrBU4fOLoFuG+Gi80XBuvm8Htd08j
X-Gm-Message-State: AOJu0YwHCrbNqLoOecPrDqHfUkDPdgkuWh/qGafXN+rBn57lSmxyylVX
	vDeN/ToGr9slE18sIvmaLIUICV9EqpkDS2qR3NiNJ7mp1sNWyxbGnxX9noyBnqg=
X-Google-Smtp-Source: AGHT+IFf+1UxKm68Ufr79btEFTW+YSygrKjHq5rNe4O6m6Bv9IEEvxhrtwQV1oX0yXq9DLLJhL5gyQ==
X-Received: by 2002:a17:906:e0d6:b0:a43:8468:ac0b with SMTP id gl22-20020a170906e0d600b00a438468ac0bmr2629106ejb.7.1709037600854;
        Tue, 27 Feb 2024 04:40:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id wr2-20020a170907700200b00a3e881b4b25sm714035ejb.164.2024.02.27.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:40:00 -0800 (PST)
Date: Tue, 27 Feb 2024 13:39:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rogerq@kernel.org, andrew@lunn.ch,
	vladimir.oltean@nxp.com, hkallweit1@gmail.com,
	dan.carpenter@linaro.org, horms@kernel.org, yuehaibing@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <Zd3YHQRMnv-ZvSWs@nanopsycho>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227082815.2073826-1-s-vadapalli@ti.com>

Tue, Feb 27, 2024 at 09:28:15AM CET, s-vadapalli@ti.com wrote:
>The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
>VLAN Aware or VLAN Unaware modes of operation. This is different from
>the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
>results in the addition/removal/replacement of VLAN tag of packets during
>egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
>the AM65x Technical Reference Manual available at:
>https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>In VLAN Unaware mode, packets remain unmodified on egress.
>
>The driver currently configures the Ethernet Switch in VLAN Aware mode by
>default and there is no support to toggle this capability of the Ethernet
>Switch at runtime. Thus, add support to toggle the capability by exporting
>it via the ethtool "priv-flags" interface.

I don't follow. You have all the means to offload all bridge/vlan
configurations properly and setup your hw according to that. See mlxsw
for a reference. I don't see the need for any custom driver knobs.

