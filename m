Return-Path: <linux-kernel+bounces-81297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA408673A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA131C259FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72821F61C;
	Mon, 26 Feb 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjl9F3xp"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD51CD3A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947798; cv=none; b=R55D8NThfCiXxPCg+1N14Nx1e45ewJjnE+Jlyl76egmUaLdq4UqV6gudCco5556b5sD3sNjI4BbN9BPpOg1vd1OL4NMoLbHekofhnTYdhjZpkQfNgbh5YNDBytcTIEVAUaEfWd14HY3KokAYwCB/q8mS9AbSkHVT2mwqyGRjVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947798; c=relaxed/simple;
	bh=+D1gemzTmM+hYFzEtK0DGUXUvrO2heqPidHgtv/T6VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6j9OPbS9gprDJeUgNvy0L6UuoMAm/DKLicGSGzEmZvfZNeti2ew8+N7C/sIOg8tkBkQbUHn0sIBwRG1ACqZbRwvYMy1qo4BsiTuc33CiTgz1r/JxF3yF795GbEXQDZLLgEuujjB3ThmADZZCcr63tZd/ns50p+rw5QrgRmeiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wjl9F3xp; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787a43e2e2dso196221285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947794; x=1709552594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A0/ZCukQ/ioxMt1iZ+gVoj8e21UGTGIMIaePv4w50ls=;
        b=wjl9F3xpwf0Jb+j6qKqpzC+i8dU1OP8Z45dEHH0F3xrtsBSKuAlM7GiHFXYSGRfu3a
         eJRKFZbfwN0+bFf3tqMSGgPFz7qJt7qXQLsuVHZRxBz/lvykIfLMgs6vWxKTv5YgUvsw
         tkMhXoZdCoGmn7tl2RkUL08BVLQW5vketYXDMhnRo+Wk6/+zA5vH+jAROOMR9wnZUewC
         zVPWTqF7b5LuGt5FhUUUx8m0WWAsnsx+EKG8+WOJRj/tBbpOpXsLyOxa61SoXHoCTD3X
         6nsW1GJ8WxBRmo3itX3lcasLh6MMvWehxBLuqNTJgrcJy9dQ+HC5zz0PIUTgFQXdRu0k
         W8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947794; x=1709552594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0/ZCukQ/ioxMt1iZ+gVoj8e21UGTGIMIaePv4w50ls=;
        b=sPINnJruPydidWIb3Lj1O1wHV4IxaaHmsTpwGwHWvDkeOzX4rqIgSeb/y2nJXnJeZh
         oC0upfIyS80OH+j5Caimk3oDEBxJzs5m8An5itJz1zDyafG4az2nWtXDH8F50d5JWDBc
         gHS+oh9ZkTWbgx6EiUj+8b71HelhArFF9X/JFQe/bqH6m2NK9vsC90kj2edimEnB+XlY
         6sXoy5AebseNf4yzhnQ4K3EGCX7uAhQAimftJtLufZBG7iJPu1c+40yBxsbgJYV26HuV
         9qywBcXR6Igs1kjmEKUSwX8jL2IbQUf9g0PXPK7MN5B0E6h22SKm+J49OlUb2GumFsae
         wu6w==
X-Forwarded-Encrypted: i=1; AJvYcCUGgzHWQ5SQ+p5NTF5pQpA8FLTw7a3nd9ZUYTiRQfB+jY4bAIIDaj2AG+06wbOk20WEsZPzrYH6cW8XYQyf8yEuT985+grrTK8twDac
X-Gm-Message-State: AOJu0Yw2KyH760ahAUpmofBeFn+/GL/woid003ek/R9s4NZbRNwNrL9J
	H5jHEZHIwCUz+c1v+dYk5Az7Hfe+Gsfregv1hE30VX9qhl27McRzFrT0ldgFmA==
X-Google-Smtp-Source: AGHT+IHNgsf5DnizKG2yBjKkWpOwY6iMjPFmpI2P1crIgzEbd9mSBKH0ULZjXVuNxKokSy0+vf8RYg==
X-Received: by 2002:ac8:5e97:0:b0:42e:74bb:5fd3 with SMTP id r23-20020ac85e97000000b0042e74bb5fd3mr5280037qtx.55.1708947793999;
        Mon, 26 Feb 2024 03:43:13 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id r5-20020ac84245000000b0042e61ef71dfsm2347580qtm.33.2024.02.26.03.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:43:13 -0800 (PST)
Date: Mon, 26 Feb 2024 17:13:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Takashi Iwai <tiwai@suse.de>, Jiri Slaby <jirislaby@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	ath11k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: ath11k allocation failure on resume breaking wifi until power
 cycle
Message-ID: <20240226114307.GA8422@thinkpad>
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
 <20240222054739.GG3374@thinkpad>
 <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
 <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
 <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
 <34123ee0-26c9-4240-8d58-aba02f7c66b9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34123ee0-26c9-4240-8d58-aba02f7c66b9@quicinc.com>

On Mon, Feb 26, 2024 at 05:11:17PM +0800, Baochen Qiang wrote:
> 
> 
> On 2/26/2024 4:45 PM, Vlastimil Babka wrote:
> > On 2/26/24 03:09, Baochen Qiang wrote:
> > > 
> > > 
> > > On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
> > > > On 2/22/24 06:47, Manivannan Sadhasivam wrote:
> > > > > On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
> > > > > > On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
> > > > > > > on my laptop, which is Lenovo T14s Gen3:
> > > > > > > 
> > > > > > > LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
> > > > > > > ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> > > > > > > ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> > > > > > > ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> > > > > > > 
> > > > > > > The problem is an allocation failure happening on resume from s2idle. After
> > > > > > > that the wifi stops working and even a reboot won't fix it, only a
> > > > > > > poweroff/poweron cycle of the laptop.
> > > > > > > 
> > > > > 
> > > > > Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
> > > > > Jeff will figure out what's going on.
> > > > 
> > > > You mean the firmware is supposed to power it down/up transparently without
> > > > kernel involvement? Because it should be powered down to save the power, no?
> > > Let me clarify: from backtrace info, seems you are using a kernel with
> > > the hibernation-support patches [1] applied, which are not accepted yet
> > > to mainline kernel or even
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.
> > 
> > Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
> > for openSUSE have nearly no non-upstream patches so it didn't really occur
> > to me to double check if there might be in the area.
> > 
> > Seems Takashi (Cc'd) added them indeed to make hibernation work:
> > https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51
> > 
> > But then, why do they affect also s2idle, is it intentional? And why I only
> Yes, it's intentional. When suspend/resume, ath11k does the same for either
> a s2idle suspend or a deep one.
> 

That's a terrible idea for usecases like Android IMO. s2idle happens very often
on Android platforms (screen lock) and do you want to powerdown the WLAN device
all the time?

Even though it offers power saving, I'm worried about the latency and possible
teardown of the chipset. Later is only valid if the chipset undergoes complete
power cycle though.

- Mani

> > started seeing the problems in 6.8, the patches are there since August.
> > 
> > > So this is why you see WLAN firmware is powered down during suspend.
> > > 
> > > [1]
> > > https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
> > > 
> > > > 
> > > > But I just found out that when I build my own kernel using the distro config
> > > > as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
> > > > power ON" and related messages don't occur anymore, so there's something
> > > > weird going on.
> > > Here your own kernel doesn't include the hibernation-support patches, right?
> > 
> > Right.
> > 
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

