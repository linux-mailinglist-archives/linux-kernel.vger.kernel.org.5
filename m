Return-Path: <linux-kernel+bounces-95096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C387492C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0541F215C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CD63136;
	Thu,  7 Mar 2024 08:00:16 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2A79CD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798416; cv=none; b=MU0y0gvY7s+CR5fUaOLHRTQ2lJ9Gf9Bw3uiwUMPCJyZ0P2EjGEKztgAGnAXtLYJAgA4xDhvgXG508eVAuQKHZlndvb7tGZqAn6nGT9RT9Rk0OTHDM2y9Izwu3gi0tnbg5Z3mWDCRxmowRtm2jnbRaJrsVmOKsU10UP8y7NcA1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798416; c=relaxed/simple;
	bh=uUQzjjo4EMn/q3kPGekEc6v0Ja0D/x9C5i2lvaabqQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOmaMYdpC0MJi8OUKSoCp1Yk/grvdwi74dXhKmaxZfznuskL/k9SojKewlqaLMxFPkJLIFFTquj4NMMltMMIhJUSw79hQyfrIvDX4SQ3+rH612cjfjJrHXEPznv6MASovFbtQfzQtAt+o+LJuWLeggleTyiWpqOUhFM696mZmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33df8203a08so110593f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798413; x=1710403213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NG+ffPYMj+yYCFSVTzmeOZMCnVORFngyqGQtpUEnSKY=;
        b=lQHbuSpstZ7WgF5IKWrB0EETLNL2csKvbEHFgfISstTGQpwwFwzBVb1QeL2wbYyO30
         NvvqGVx0Nk/wmjVzpveAgf1ZDZJBHcIhcqSi0Prd/k0ViVyzVr/gQsFDnxZzw8o7nb9W
         8fAmZ6exhT5j3MFdzhT53L4khqW92xLY0MhNG0U80QA1E+nC/hEimODGo0u+BPpgPSs8
         KUXqJh8t6HCEKTZK/FXKVqXhLMeftqFa4bznNxAxT3KuCCBWjWuk8LOA5QFnnpybE2Nh
         lF7hs7nBVUrDP+zdlFPwYSVYlxA+YZf9h2vUrqE00Z9xD5Y1YtVN0SgXOKYkBWCIh3q4
         LEUg==
X-Forwarded-Encrypted: i=1; AJvYcCWeRWTUQLMxLYzmKzkMyGyU7odtXakpf/Zk9u9bdNs7CZLIPMZqO4fbJs8pVx0PZyXpqUNWLnzgU8td8ipeZVEfxNusS5pKGn+PBQI6
X-Gm-Message-State: AOJu0YwSi3Dxh78Vd81k3DFQD2Vgo9ahhSjH7cBNEGATwMkShRFmoLV9
	a9+9o90hQTO7r+RDZbcsNCexZkOfpIJm2UBuV4mRAwpgJnhnN9Z9
X-Google-Smtp-Source: AGHT+IFqCG9cuATTRh+RSt/5YBfdLTIwxxq+1zc4f2qnjpmr5ufn7l8N3h9rppqbqjqgaSmyZPPZgw==
X-Received: by 2002:a05:6000:1370:b0:33e:1102:8fb8 with SMTP id q16-20020a056000137000b0033e11028fb8mr649046wrz.6.1709798413189;
        Thu, 07 Mar 2024 00:00:13 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e49aebafasm6592114wrb.3.2024.03.07.00.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:00:12 -0800 (PST)
Message-ID: <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
Date: Thu, 7 Mar 2024 10:00:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240305080005.3638-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/03/2024 10:00, Daniel Wagner wrote:
> I've picked up Hannes' DNR patches. In short the make the transports behave the
> same way when the DNR bit set on a re-connect attempt. We had a discussion this
> topic in the past and if I got this right we all agreed is that the host should
> honor the DNR bit on a connect attempt [1]
Umm, I don't recall this being conclusive though. The spec ought to be 
clearer here I think.
>
> The nvme/045 test case (authentication tests) in blktests is a good test case
> for this after extending it slightly. TCP and RDMA try to reconnect with an
> invalid key over and over again, while loop and FC stop after the first fail.

Who says that invalid key is a permanent failure though?


