Return-Path: <linux-kernel+bounces-158091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB88B1B59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36B11F22A49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F696BB33;
	Thu, 25 Apr 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jsgcpWFr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612A3C08F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028381; cv=none; b=lY435qxiwheI2ubCZCGLJB89+5oUJM0nntWP7ovJrnadSgvHnYhu8MlPr03GFgdOHTlTA4885xpnWl4GWuFEOaR93x5AaaH209nTGh0k8SL/6XHtIQIoClQPSp/P6LleqKYi5A4j6lvHqDbTioslFpzZuRHLaZQl8MvtHCIe/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028381; c=relaxed/simple;
	bh=e1vlBiYgpPvF92O4Af9KuT1S8cWMNzZQEzACGAc/4QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHJHcpOQSJ3aEIszcP8XCCAVJosv5kJDjt1zrkxYt9FhNGPWtZGInFnyXCwfnzYbiQJD5Dqns/F1Y3qDf1lNAKGyJgIg6FWTwNTFKesaG23jnh7IMUdkLqI4j21AeaPYYajKjEEO0hG0Dq1776lmmX4N/L4XJ5U9ho8lvYsrF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jsgcpWFr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34b1e35155aso700831f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714028377; x=1714633177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peNA2dsXCHbUBK91wvLD3fmzxWkuZFoJfKP535nVv64=;
        b=jsgcpWFrMEa6YkMAlH5ImNGm83ItBfKSOKdALMPb61zUIuihxH/EhmhRCHchdp4bQB
         DRE5GFHYQ7KZ09HHENzWB1q3xs+0IS3G//SoqQzLDU1yH8SWw5SVZmkF4PmKVMTWFXp0
         PxVrXW7A4/JddwRwWZP0XcVbjq6zYiwF2nv1H4uuLS6N3Up00npqOgShwP3X1ScrlgoP
         gDnjzXqorG+dqEH+NI/dOc6BVrc2riVi2wks9HTbz0GvCerathKezYa8f6VY7rYkpEKL
         Jl22fAygEzo06q4OH7OsbqbgTWwcow3zVTFAZm8EgPBeo2cTLiqCCj7F1ffr/Z27i5Lc
         qO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028377; x=1714633177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peNA2dsXCHbUBK91wvLD3fmzxWkuZFoJfKP535nVv64=;
        b=hQtCV3j/SJRFrIsZeyeQo4toP2VeQbDHyHQxc+EdAILX0dQKhtW2S2UyaSu9MS+UiP
         sf/kEu25sjKXvmBMLQIjvg2TMMEbA60RvB1A+aiFb8k9BKfl8mW3xpuI2HMrYZIS1Ems
         XRc80VTaMcQhmi1m4faMA6jk+waJZOPxL+wAyZHMJUUxiL29KBHfIsT1YPYYNdb4qF3J
         O0RgQRHBD1Nt7xgCvcA14gWOUqflX9EMGwmX/vUKczvtDrshFPEZFohVf6F/H3ImOyqX
         /AhSiSah6w3vYkj7O8lnUchDMAl1UWR/kUHwxBvf8ai01TGxTeBnvypAnwmSvbkCpeGX
         b+dw==
X-Forwarded-Encrypted: i=1; AJvYcCV2VFRjjv6tZ1YEkrDaI9XNAk5QoWQWTO2uoC5AESYXJjW/ynYa1mUMMjxKAceo9pBEPpDlNaXIGPAjq4JytvdpnZiqyKIVJplVgCmq
X-Gm-Message-State: AOJu0Yz+Y1GtjEUVnOWWtNjE5R3YjAa4ACJgTd2Z4WQ0vEoet7a2YUXo
	hS1Rg6O9/x2BltXruJtF/cv+hBScvtm9tL8K7v5iU0RwjZq8pj3fRJ0M0hmoa44=
X-Google-Smtp-Source: AGHT+IGr1zr4QKQl7DWg38CUYJnl+aOHDuzzAoVNuUJ8bzBpBTf+6ltkHS4meFQNnnEm0meI8FWDAw==
X-Received: by 2002:a5d:525c:0:b0:34a:beb3:f6dc with SMTP id k28-20020a5d525c000000b0034abeb3f6dcmr4650743wrc.2.1714028376567;
        Wed, 24 Apr 2024 23:59:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906368400b00a4e48e52ecbsm9123739ejc.198.2024.04.24.23.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 23:59:35 -0700 (PDT)
Date: Thu, 25 Apr 2024 08:59:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Geethasowjanya Akula <gakula@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <Zin_U-0PPfk5a_1d@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-6-gakula@marvell.com>
 <Ziey7sruZrtq_5Hj@nanopsycho>
 <BY3PR18MB47379134443CB002D80A7F90C6172@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB47379134443CB002D80A7F90C6172@BY3PR18MB4737.namprd18.prod.outlook.com>

Thu, Apr 25, 2024 at 08:01:47AM CEST, sgoutham@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 6:39 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet
>> path between representor and VF
>> 
>> Mon, Apr 22, 2024 at 11:53:57AM CEST, gakula@marvell.com wrote:
>> >This patch installs tcam rules to stree traffic representors and VF
>> >when swicthdev mode is set. To support this a HW loopback channel is
>> >reserved. Through this channel packet are routed between representor
>> >and VFs. "ESW_CFG" mbox is defined to notify AF for installing rules.
>> 
>> This sounds very wrong. In switchdev mode, there is no implicit packet
>> forwarding. User configures that, either by setting up TC filters to
>> match/forward packets, putting representors in a bridge, etc.
>> Basically the driver offloads whatever configuration on representors the user
>> does, in case it supports it.
>> 
>> Please make sure you follow that.
>
>In our HW, there is no in-built switch which will forward pkts between representee and representor.
>When representor is put under a bridge and pkts needs to be sent to representee, then pkts from
>representor are sent on a HW internal loopback channel, which again will be punted to ingress
>pkt parser. Now the rules that this patch installs are the MCAM filters/rules which will match against
>these pkts and forward them to representee.
>
>To be more clear the rules that this patch installs are for basic representor <-=> representee path
>similar to Tun/TAP between VM and Host. Now for any further offloads (eg: L2 or ConnTrk)
>user will have to install explicit rules via TC filters.

Okay, makes sense.


>
>Thanks,
>Sunil.
>
>
>

