Return-Path: <linux-kernel+bounces-101664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62387AA20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA103B2444D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0E4778C;
	Wed, 13 Mar 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQTqO5RK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E53D0DD;
	Wed, 13 Mar 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342655; cv=none; b=BIiIPhMokPBnB2X06b/d245xTxq4J3nKxipS9gsxLwdWaCnL7waHFXrTqlpujV8NcP/j6GwaxJED0uyU8PQQN8D/B4s679zHnY8kqx+0fcM/R1I/5wL5lAcwOfmpr5Npb3imKRwcJY6HiCgZd8CVzAbX2SKok/I11kqQtcCTfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342655; c=relaxed/simple;
	bh=Ocy8geFE9kPb4bFGq3+89/S58bGkARoG+qV87/35muY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVq4akUdvLdaR1rx/IgxUS2eDR0ZNElcnFEEKK1h2Nq3okYYZKybUQJ3UxoLqYUXJsm4kvwTTN6paUnys7OkNxFlOqKvOHeRuuOp35FwUO4FSTZ7zh9E8isnBSXlscb1r9Iow7R5OYPHUPlS6Kz+cp6KF0MrnUwms0JIgwL2P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQTqO5RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5857CC43390;
	Wed, 13 Mar 2024 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710342654;
	bh=Ocy8geFE9kPb4bFGq3+89/S58bGkARoG+qV87/35muY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BQTqO5RKQ54EJbv1S8P4pENDD44OtCvTkL9lM0F/BjZDviqG3B0fDJJK/mP93C5AD
	 e9TBae3uLVN8p+c9QD+Cgcg5BhM0SQ+cbTJVjY48VqldBqjhoxy/kKJ5GZr+iYgyDD
	 fMap9HtRVG7CVD0kHcCT7P/XpbW1oiZ5e3mTERWJg34aNJRfbiC6lAgjQ3bdjLyQUc
	 5F2CmhbUXwmkDQLp5Dbww4+yg9bG3nIQNdrd3luSRaFR4fmxe1IG1k6USgNsRoMmQU
	 m7Z7qjL5d+9JQOr9qOo3eGbT3GtBTePzlKT0Am8DiS2uvcVVYuktEKspVo05H7FTg5
	 8XlUR3jJv1Mkg==
Message-ID: <bb1cbf09-53dd-42d9-bce5-9ac1ba94be2c@kernel.org>
Date: Wed, 13 Mar 2024 16:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v4 0/3] Add minimal XDP support to TI AM65
 CPSW Ethernet driver
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
References: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
 <20240313134441.GA1263398@maili.marvell.com>
 <9016930f-d90b-4a7a-b6fb-80cf56a94bd8@baylibre.com>
 <MWHPR1801MB19184E6AFDEAF4062FB1C4B3D32A2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <MWHPR1801MB19184E6AFDEAF4062FB1C4B3D32A2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2024 15.31, Ratheesh Kannoth wrote:
>> From: Julien Panis <jpanis@baylibre.com>
>> Sent: Wednesday, March 13, 2024 7:34 PM
>> On 3/13/24 14:44, Ratheesh Kannoth wrote:
>>> On 2024-03-12 at 18:52:39, Julien Panis (jpanis@baylibre.com) wrote:
>>>> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
>>> is this a net-next item ?
>>
>> Initially I worked on top of mainline kernel v6.8-rc1. Then, I also ensured that
>> the series could be applied on top of net-next/main.
>>
> Please post to net-next ; once it is open
>  > https://patchwork.hopto.org/net-next.html

Funny link, as I usually use:
  https://netdev.bots.linux.dev/net-next.html

As documented in:
  https://kernel.org/doc/html/latest/process/maintainer-netdev.html

--Jesper


