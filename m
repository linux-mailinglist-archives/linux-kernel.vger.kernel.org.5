Return-Path: <linux-kernel+bounces-97178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E4876687
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139301C213E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7824400;
	Fri,  8 Mar 2024 14:44:20 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03231865
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909060; cv=none; b=mxVu1+C4IgKKb97Msl6A0wkoc2TAk/5zJPiDHCrR//neIyWpmcC4Qfu1GR/ygjteF0qP8zJ2KIh3A0qWqgXUHzWREfbvjiL07YpTMk8bB/zuqJhrVYl4EKW+EFgxyscyVG/h/Y+PHlxlPBAitR4OelXrF9tWA+eJ61pFJink+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909060; c=relaxed/simple;
	bh=RNyhKX+44etDaPeXvf805XOJQOz+KJlCk+saU/ThMG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6bzOiC2w5AWSbgZLcQY1WHsAhoT7ZxMYsbBogFk7VdF27bLjJHPUxIrjk42sjt9eZgSNO+lris7ktF92C2MdTyCeY7qXnngPdUjTrcVIyEX6WcDRj56K4EJN1a2yGp2yr7+0NlMtHlinNk3ueWgF+x+hFk0R9xQyHNeC/Zc4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5132644150aso372526e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909057; x=1710513857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyhKX+44etDaPeXvf805XOJQOz+KJlCk+saU/ThMG8=;
        b=JD0sm0kurjycHkqLXKhylBY3NoKyXdNydmMfTCYjRTD4tPUICGJPT8f2iI5T/1Lk1j
         +v3EOcHK1EtwBfwhAl+uppvj6ydN4NgfWJ7oGrQS8ZPPOApA3PO0yg6hfiF4y+Vl4K9t
         /eQLiFrhJAmYZFD75+RBEaeUibAlcWu3Avo4b/v8EvFDhB74HFc6I4o5xxxA/EU9trfp
         JXXKBKI9euTY6WrIXPmIsEyrZTOJqV6NSq942s9URiuBi8YCHOo62NQKVILaD5LLA4ai
         oXS2fH2/AnrRQN4ot9BeVHnNTY6qNHfEV2W5dSWbsWadFgjANKfsJd1u++SApNmh5wmr
         AkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZopZWV9XBKpiS+1VYQBgo1qnpnpSWsD5qj8DA9w+gQCgzYXUHBhcKUsxWzO7169vwyzUbQP+Rn+NcxYx2WrhEZQK+o5eXvsX6XyKm
X-Gm-Message-State: AOJu0YwMIZU/GVazNuPdTx2XrfUnSbI7iudXHAt3Uaos5EBr6LWKF4gF
	E4pyf8ibxQufNpsYqWobHYVPi+6CFtvauNuAgYPq3T2IWKYVM8Fm
X-Google-Smtp-Source: AGHT+IHldJgJc2ijuaJnS0hYUOmRB065SGk6SQ22acfoGc6EFB7sbKNUttdDPGioyr9l3pSSKrtFXQ==
X-Received: by 2002:a05:6512:206:b0:513:4b49:e1e5 with SMTP id a6-20020a056512020600b005134b49e1e5mr1402433lfo.1.1709909056630;
        Fri, 08 Mar 2024 06:44:16 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0041316e696besm2740963wmq.13.2024.03.08.06.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:44:16 -0800 (PST)
Message-ID: <c895887c-7b5d-4254-9a91-76fb31e661f1@grimberg.me>
Date: Fri, 8 Mar 2024 16:44:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: he-IL, en-US
To: Christoph Hellwig <hch@lst.de>, "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240308015435.100968-1-brookxu.cn@gmail.com>
 <20240308144208.GA9194@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240308144208.GA9194@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/03/2024 16:42, Christoph Hellwig wrote:
> The fix looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But given that's we consolidate to a single place each for setting
> up the tagsets for admin and I/O queues, what about just killing
> the symbolic name and moving the assignments and comments directly
> into the only users?
>

That works too

