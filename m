Return-Path: <linux-kernel+bounces-50387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34412847855
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546A91C25A17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C21369B0;
	Fri,  2 Feb 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blbQL5nW"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992C136985
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899248; cv=none; b=FoftVz9Vv7Vuxn+C5Na1WtXtEhckuNy1aCE7T/by+2cbvtt49exYU+Mfh5GkJCIF4UGA0ONtlW5+F1bvYUTTIdWg/U/iMyPAsepHgq0yOGYuRFqIPYTiCLjpFKxgNUAA1C/v3yVGqIKUIfEWDvv/Ntse++sNn+Hh87LISLS3jVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899248; c=relaxed/simple;
	bh=iDIZyoYwVMCcH6jvBcxQvEoGmUeiAgOkJkI2EMrtO0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frJquPMzXMGU5vF2iNEZEbAeshqSa0zHFVoXMpSxPFfHSCyrK2MlgBDzfaOfUrxq4u0oqwYfWlWbtZbQJFnr0YnWauK0zRFCNGc6Dm1X+Ix7vXCT1mCzLNMxVxue+nCfgYdavyZt+yNSr2lZQM1AerRfVhc5CxaQQ8z/rYjaIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blbQL5nW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7431e702dso21052385ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706899246; x=1707504046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETc3MSsRJzGBMpx74CiCs8JTE3lIxFPwksv6ifKyi6k=;
        b=blbQL5nW1pBD3dfMOgaSSR9ZMRi8VSRr5eU94ae1t2iM+fSh5G6EF8LjLV67K/V1wP
         3QVAzzjL5pFG6BgAOnMRLU6PnzdznHV3V00bZybcRzhlmKemA87vPa69KBu795si2UHV
         2sSKKa2gvP1ZSG5FtYIL7+iHSJ0PY394Le/npjkrLcUBo7vttklGun3FeWO7/M3g1So5
         i21svC3xGm5YOoa18E3bgDkUI2sneQXd6qt3NHx9CgOXqEKiUted2VoS3O/tM/4y5r9P
         RB2rKNHyAGChJy234tJ/N+sEjELXAgal9wRxg7YymJTqC7fGCn+Bumn/R+iKXuI1tFwP
         3ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899246; x=1707504046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETc3MSsRJzGBMpx74CiCs8JTE3lIxFPwksv6ifKyi6k=;
        b=CK8wDrk2FjBaAc3oFZeZgeIPN5OTelFkVsOQ4oYSwSkYgTXBPGH8YmfNMAp4dlCxLB
         TIZgvjWBA2wXNoBLN2er47qtqOtvA/n6Yf3AqdA0nO6JYGiUXd6gf0FJdE59DV/wbZm4
         zLPhIJqddBBLD/2FfBKEu/0nW2IzYdISDEFV8XC8IVITCAQa7uVVmDpDzizZeyA/fLzs
         6DyqDZYTVdnIsEZHZsHd2I2XvTAYnIK2gyXBoAvvHnMBrqq7hm0VHmBTvh8eQztcjgP3
         cSb8rJtFdk2LJxTGoryo+fK3TCunBJDsozIRO/noF7J3WQ4hbQuyfziLqRV/SaP5BL1T
         nJ/Q==
X-Gm-Message-State: AOJu0YxwuYMKtAEoVVBFLkClXORvbsLMG+XXPEG4rKhIIFjnLadoxQ8O
	gbYtvBZW/N43JM5vwXBOp+13u8lJXlCEZ9CSKZhTrmTIRaipwAcg
X-Google-Smtp-Source: AGHT+IHMI7ICrbVNiKX1z+Oto6aNGJCe3UR3TXyy7FNW9KQC6RygHNftgy0M8m1opYzNpMzVSmMM5A==
X-Received: by 2002:a17:903:1c5:b0:1d9:3d3:484e with SMTP id e5-20020a17090301c500b001d903d3484emr10657563plh.64.1706899246034;
        Fri, 02 Feb 2024 10:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkt2T97j6wAXGdP0Lg5EqXhVHLeLedErjtgtd99megDpwMqlK4zyrXBKnA3xU/o+78cBPyVBNOzEanbeErAAGvqqFf7oIDKdkfCQg6z+LyJHuiIYLYniDl2BRKAk76ROCQylDG2PBptQR9j3A/+ICsQPMEfDJeYEJ5EHWYb47PXbLbMDq9D8Lm8Pf3P4I15Bxq0xMnv3ty8fJLobxS2XMO
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm1889607pls.206.2024.02.02.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:40:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 08:40:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: Workqueue regression
Message-ID: <Zb03LDPmMcBU0-Gj@slm.duckdns.org>
References: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
 <ZbxK01xuA_FFWaE6@slm.duckdns.org>
 <17cae1aa-98a8-48f4-adf3-2ddfc451bef6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cae1aa-98a8-48f4-adf3-2ddfc451bef6@linaro.org>

Hello,

On Fri, Feb 02, 2024 at 01:31:01PM +0100, Konrad Dybcio wrote:
> > If the system doesn't become live enough after suspend/resume cycle to get
> > more info, the following might help:
> 
> Looks like it's too far gone indeed..
> 
> > 
> > $ echo test_resume > /sys/power/disk
> > $ echo disk > /sys/power/state
> 
> Sadly, hibernation is not a thing on this platform.. Without going into much
> detail of how messy the power management stuff is, you can either have
> "on", "off" or "power collapsed" (bound to s2idle).. Trying to trigger this
> sequence makes the thing lock up and die due to unclocked accesses with or
> without the WQ regression.

I see, so, if you enable CONFIG_PM_DEBUG, CONFIG_PM_ADVANCED_DEBUG and
CONFIG_PM_SLEEP_DEBUG, there will be /sys/power/pm_test file which allows to
select the stage at which suspend is going to abort. Can you please play
with it and see whether you can reproduce the issue while maintaining the
console output?

Can you also make sure that the system is actually dead, not just the
console? e.g. by pinging from network?

Thanks.

-- 
tejun

