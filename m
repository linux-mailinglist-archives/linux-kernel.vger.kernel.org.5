Return-Path: <linux-kernel+bounces-53145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C684A13B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C41F20D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294C48786;
	Mon,  5 Feb 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV5sY6cN"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9C47F53;
	Mon,  5 Feb 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155158; cv=none; b=uLtmoCvk9EXkEkLJODkj1PeMKw5TpPTRV6L9ycYXNDdQX1UJ9Ay/c0RsGj4BhD3acQqELOlUblSBmIvzMJvuMs9jibd1c7IxyOiX+9kWt5DuzyvpOs8OxrPRJkBUzVnH5if0LdDk/oCEGeywDSOtoJwMDw5jUPDgPGBU+1y46oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155158; c=relaxed/simple;
	bh=wfjuJDCo9ikop915DTLcUPjxvweOFqYhpNnxU+fUtKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZhI1z8UfNjlICU5Awbe/sQau1R5zwEkCeAXWNHdAbAhlNAV7CHN1rxnuzKARW7/ymgLeIXupeoOxKOrtz4pxkf0rcJDX6sb/htKfyruRq29OrWI31PLjZlVpJUtlQMFP0J0A7nu0S2Kb8KCWB/fOz/6ey+qYgSOBXfmZw1B0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV5sY6cN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29685114bc3so918653a91.3;
        Mon, 05 Feb 2024 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155156; x=1707759956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWpkA0adWfJg/N96ugMkWhlTX4/Zx12uY2WHwPaeRnA=;
        b=KV5sY6cNWaCCNRShIkvNPAO0T8x+prCIilt1FNV9S8N262Oq7jgMyoyd40QwZrfAWF
         Mz/6LHIh59F27KGxaPomrn+TZD2nB7let5nMRtR3xLd3pBb47odc7E+0Dds79IE55+GJ
         CfPrRzH3UHnEXaZRnYQTU6AzlgfHw9SnSm+iLQsMxPqnnjguNR/tIAl9wbvN/W2guxiU
         RTmbIkhSWa9TObXSweooQUVQsFT8Swg96t0xoTPnR8IKbNm3XWyu9jttHoDAbIYQeSyo
         lvS8xP1Z9RumNEA+FsldaWTHAtkJGw34eWK01rrCw/etlaD6DvUFUMMD+yDd65tiqfzx
         E4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155156; x=1707759956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWpkA0adWfJg/N96ugMkWhlTX4/Zx12uY2WHwPaeRnA=;
        b=THGyNCckFp9VGCGDHFFSt61hybo2HhzITs9PqItDhYHNiFO23SGYW1WO89JdAFdSTF
         apfw3n63VRQ5D51NBmeVt7+dZ+0ueoRiIwSLN07Udh9mwsqE0poIf8KAFWlK0szwr1Vj
         TR1Ay0jAcfgZnnCvACzmPegqQ3MiZNft7FOTvZCDLcY0UJnpTvTcN9ytLU2gOrUYWqgY
         flrI7tlOEEvq6bVR66pTxD9sqjLsjNZyBMn6nvPCwVNYZ5u7rqlxuBrudX76fFWvX1ro
         0vQdopQvfG17xiaUapEb5d9XBLc7uF7rsmAmdI/KVE0NImP45pDyn3TTllTsXlmB0hKf
         gASw==
X-Gm-Message-State: AOJu0Ywp+LJq5iTV82+NWmasEjlu4z8a8LDy++VVvwZxjDEznU7ih7MJ
	vatINLJyWBIh43DYoehGYxH6gD1aNdyHCh7ukZkqqfUPNSmypzXO
X-Google-Smtp-Source: AGHT+IEqEmWKxapPmLXYmOp2uW9MmgZudDXICGNoo85jUNcxH4rxgZoagf5UZXbl3QwCCMxY73PBsw==
X-Received: by 2002:a17:90b:3647:b0:296:3a5:6fb8 with SMTP id nh7-20020a17090b364700b0029603a56fb8mr140155pjb.25.1707155156241;
        Mon, 05 Feb 2024 09:45:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUTj4d9BneUR8TZxAaWCjiW0qPu4NyC9O0WiMqD0EHnQyDK/qEVa141FY7qkYuJnDqIDgdelFh/eE6OODkrU1xkP6MwGo1Rt4S8atEe92QUmNAC4qwcKL6NjLrhFpAbdAtuF4tZ0iSPFhZcNJvztJ+Oif6QDoKQP+woOxB+gNeACViotwAWvKQ0yEAcmkFw6aRy0M9Ahg5aX4o4dnA7tXBTiZpTGFAGhd8wEkpw6VdnFx9tIorsXqvjsSZM3byxJdSkfgWlHNoa2Rt7mZHKCmZd8B0Rl3ygArty1j/RFdt8876/3tNc2YGX3rrQMJvrU0/rpAaTe9J7N8PErxAllclAaSxa8IWv3bbiamB+yG6CkYt8W/2bY/qXRTgYWOTC7IJNdON29VtTP5MmAeDIzalabi2qUF44plo4wSA44LtuJfXkg==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id lc4-20020a170902fa8400b001d8e41b3f95sm141669plb.51.2024.02.05.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:45:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 07:45:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	jiangshanlai@gmail.com,
	"abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
	"mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
	"sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [Bisected] [commit dd6c3c544126] [linux-next] [6.8.0-rc2] Task
 hungs for infinite time call traces
Message-ID: <ZcEe0q8Bg5zca1nA@slm.duckdns.org>
References: <a95f5bcd-3c49-4ebd-b1b3-a688c5b6727c@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a95f5bcd-3c49-4ebd-b1b3-a688c5b6727c@linux.vnet.ibm.com>

Hello,

On Mon, Feb 05, 2024 at 03:24:17PM +0530, Tasmiya Nalatwad wrote:
> Greetings,
> 
> [Linux-next] [6.8.0-rc2-next-20240130] [FC / XFS] Task hangs for infinite
> time while running bonnie test XFS filesystem
> 
> Bisected the issue. Git bisect points to the below commit
> commit dd6c3c5441263723305a9c52c5ccc899a4653000
>           workqueue: Move pwq_dec_nr_in_flight() to the end of work item
> handling

This should be fixed by c70e1779b73a ("Fix pwq->nr_in_flight corruption in
try_to_grab_pending()").

Thanks.

-- 
tejun

