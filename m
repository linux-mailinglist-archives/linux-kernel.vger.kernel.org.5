Return-Path: <linux-kernel+bounces-109198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B623C881608
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78F61C20DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538A69E04;
	Wed, 20 Mar 2024 17:02:00 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E54EB47;
	Wed, 20 Mar 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954119; cv=none; b=QMwYa6O4OXXE5GRVR8fRrFm+p53exSwYOjo0CRzVnwp99ifW8ybyGM8rvrN04LXo69wcWjzlWv9ochARhAHAAEcFeIhFrBacRiDN8DWNK84l9F6Z3f3gl0lv5chlZsEsR3+XmSIeXd8FoB/VGAE0IEZoue8w/5XWP5VDkJd6xnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954119; c=relaxed/simple;
	bh=riDnAYASVcYCRvsE9up4IqXSn5APJJQ9Ae+rukBzFQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzZJMxwdBHtR/LCGHVRzqp6iIFDkES/UzS70C5uTWVimqWNZ2b4rqgKhjHtSYxp19Vn7qlzn+2pAWvw1uu3ou+71IZVrzI/Y0M9i+UgeikB9kTrfRRXV/yEncZcMBmI3pF7s1OKewmB//8E0FPV0zAlo7bUxuuaoP0elpRdBpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513d3746950so104578e87.1;
        Wed, 20 Mar 2024 10:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954116; x=1711558916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEfzL/x+HvKfKexpvwPECfkK5QWCbVSUpN9Cn9FEYTo=;
        b=Yrvjc//77d6YrXWuejx0beLNRi0W4B6PLrQN/QHyTUZyDGyhDUwpCBT/ZLHHEhfKfy
         4Qe0BMINwJW2pQK/hT3Bw6swCcYCbi8Bgw2VsYE8/8rX2z3X/XC/1hIlCCAcqNWSs0W8
         43J/VMBWWraix0t50UsaUceYVkYVkpC9iwkpfcKiw8zK10PZ2kR2OOpCrWoXmVrpryf+
         nIRPVR/xlu/s1eGFpqZodNiEOV6abwW3Qqz9M87n84a0XP+5JIZ8/EXmBtWVOrkqyTRq
         Z5bau67UinQGOyxaM7LGXYd4pWKhSmsJTiyWhXsK4wL2C9yr+BXcVXGVAY2LHOrhYXYS
         40NA==
X-Forwarded-Encrypted: i=1; AJvYcCUJi30MyommHEx0q14Afow9l7trEN08hSyat91gebUKA/bjbMBL8MjbOmWaC+TbRP5DXuTkYHkkc8h4Ux9MOEv+oraKGAapn0dqlpAmPcY7q6Z5sSrSDDs+mQaCfgbI1qVjsNsnVibPquDLVLk=
X-Gm-Message-State: AOJu0Yx1UUqKP58G2AqYvtZ8cWjbKA0HIWfj/0t87RN08Xjadw/ge982
	m4vyRrL/fSF50SAUaqHqLrXKD8uLoIMOm1fcZj4nExuZBnmqAGQb
X-Google-Smtp-Source: AGHT+IFshgPj3UMN4cJiNIVIXvG/10g68W2pa6RLfXGSEY8o7CaDgP1x0o/YnloMRnopMl5TdGmZIQ==
X-Received: by 2002:a05:6512:3fa:b0:513:cf4e:941b with SMTP id n26-20020a05651203fa00b00513cf4e941bmr1681905lfq.19.1710954115798;
        Wed, 20 Mar 2024 10:01:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640205d200b00568b6d731e1sm5798016edx.4.2024.03.20.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:01:55 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:01:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jeff Johnson <jjohnson@kernel.org>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <ZfsWgVeHJXMdh5bp@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
 <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
 <87wmpwaprz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmpwaprz.fsf@kernel.org>

On Wed, Mar 20, 2024 at 05:25:52PM +0200, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
> > On 3/19/2024 3:47 AM, Breno Leitao wrote:
> >> Embedding net_device into structures prohibits the usage of flexible
> >> arrays in the net_device structure. For more details, see the discussion
> >> at [1].
> >> 
> >> Un-embed the net_device from struct ath10k by converting it
> >> into a pointer. Then use the leverage alloc_netdev() to allocate the
> >> net_device object at ath10k_core_create(). The free of the device occurs
> >> at ath10k_core_destroy().
> >> 
> >> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> >> 
> >> Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > NAK this based upon the ath11k patch results.
> >
> > As suggested there we should just use kmalloc/kfree to match the existing logic.
> 
> BTW if the patch is not tested on a real device then it's good to
> document that in the commit message with "Compile tested only" or
> similar.

Good to know. Thanks. I will add it to the next patches.

