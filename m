Return-Path: <linux-kernel+bounces-157119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558398B0D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DE71C246D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498915EFA3;
	Wed, 24 Apr 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ogoM/PS1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93715E209
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970094; cv=none; b=P0iX1eV5MH7TIyZRJLAY2/Ta2UG/J/w6XV8WccacTzxJlxWiCxlw6CFvQ8yxnl74VWIcVXZG96ol+YOqOwq43hYTfCUXi4KaSGQct1VKiIhsguo75P8zZi6U5pOxTt4r17A3QhtS3+ozScAOfmknPzatyneJEG2PwP+CaLRW2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970094; c=relaxed/simple;
	bh=pZRMHeRrZ7PqTOAeDPMoXssbpZwAoT0QUjHK0yTI7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcCNpSOZcUjJ2cn4ikL4+I2V2dE2jCKHrfa9a1o7wQR0VxRqB0a4mKXMbSItM6Wna08aIqfRV+l47LtkoGhvrn+8IGfgFpRm7Kh9MIxceTipfKE8k0IaVh8/3XcmbLcviWT4srnJlgoKbgSMTz/KFbhckQHsD8qVCsFp7m2MSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ogoM/PS1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5224dfa9adso192401466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970091; x=1714574891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVbaUyrmVafdj/cQpZaiAaBbKWO3w1dBZ7Hp+YT/Oh8=;
        b=ogoM/PS1Y2jX+13pwUTQ0rudu54Dmu2iJ7RNx2vmuACcmsFTVv6vIHNhtekmDb3nCu
         8BusBlotgIy49+T7uufsI7jkabpyw6Qgn0OOe9xrsHCF8b+/WiXRavurqvkpYDqGlY2W
         bMdYlIbaX1V5LzLf1HkChyUNv5S35MFFI6vLVy+LVUycgNK0M1ntygEzSiL9dJFSH+JS
         PjzZbANMK+XkJ3wqPfrrvKAnXwJmWfb3YtDwhpo7cbZnwWpLLczj6prwBaquXsTaPY7J
         Dd9HshcE9GBUZzUwqvwxbq8eaUvX6emjkeYk+v4j1fiYaEu7x2CzW/PgSiDlkVmH2O/W
         J5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970091; x=1714574891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVbaUyrmVafdj/cQpZaiAaBbKWO3w1dBZ7Hp+YT/Oh8=;
        b=Hd902aMS0VOpkGEUXjuJt+K44M69JW5pGTE6ZxKLu7RlPmkRmgD36a5/M2GZx9PcMF
         rXbGOWJn3cyyVg/lBmyCrBy4pRpoJs45628l19uySpZAVdGYv3b4segM4z+sckQFnE6B
         XAND37bajEahpwz2pxibh6K/cdEWi9UHG/Z/bg5yFttDO1y3AjeyfUAVgOC36xeIXPUE
         rUVC9UhKFJc1keVrdlucYC2CAFTw3MRsUWksUkSSZInX6FBBBkWxbDu1T6yw75VO5X4g
         aLtBudhMukmm4A4hMIel7J3C1Wy7yr6V1m1kWgIpi/DO/XeieCRGEhxFd3S1wwWuuj0o
         rfog==
X-Forwarded-Encrypted: i=1; AJvYcCUdgUDcHPql9D5Li+HZf8JjEcuzmO8nzzrgPqzkKhOptpz8+fket9545yLtblThMmub6Kcx6Iciz8+kw0rDu51hAfKKZY1+b15F6lsM
X-Gm-Message-State: AOJu0YxOlnx417wOT4YzfGJgj3H+7vMkX/lOKZlVsSCZGm0z9DlhWbtA
	eO6VQHc+/Hg7hMcM4CTEJUAQ0kpl2Irih3wp999p5A6jh7E1mFGBXTtlQ/35qaboFJwMWi7ew60
	T
X-Google-Smtp-Source: AGHT+IHyL7UR+GGslunB2Saa9OzbsgaAEz0dYE5qzWUKj2z2emKP9Bh5u/mfXv0ND1AFRSdoAqJmPw==
X-Received: by 2002:a17:906:5650:b0:a52:6e87:77ef with SMTP id v16-20020a170906565000b00a526e8777efmr6378733ejr.6.1713970091244;
        Wed, 24 Apr 2024 07:48:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906771500b00a51d408d446sm8438326ejm.26.2024.04.24.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:48:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:48:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>, linux-hyperv@vger.kernel.org,
	shradhagupta@microsoft.com
Subject: Re: [PATCH net-next v2 0/2] Add sysfs attributes for MANA
Message-ID: <ZikbpoXWmcQrBP3V@nanopsycho>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>

Wed, Apr 24, 2024 at 12:32:54PM CEST, shradhagupta@linux.microsoft.com wrote:
>These patches include adding sysfs attributes for improving
>debuggability on MANA devices.
>
>The first patch consists on max_mtu, min_mtu attributes that are
>implemented generically for all devices
>
>The second patch has mana specific attributes max_num_msix and num_ports

1) you implement only max, min is never implemented, no point
introducing it.
2) having driver implement sysfs entry feels *very wrong*, don't do that
3) why DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX
   and DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN
   Are not what you want?

>
>Shradha Gupta (2):
>  net: Add sysfs atttributes for max_mtu min_mtu
>  net: mana: Add new device attributes for mana
>
> Documentation/ABI/testing/sysfs-class-net     | 16 ++++++++++
> .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
> net/core/net-sysfs.c                          |  4 +++
> 3 files changed, 52 insertions(+)
>
>-- 
>2.34.1
>
>

