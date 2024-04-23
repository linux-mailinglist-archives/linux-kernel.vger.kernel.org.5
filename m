Return-Path: <linux-kernel+bounces-155480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C863D8AEB28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687511F23DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626EC13C800;
	Tue, 23 Apr 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cPWUViJs"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7513776F;
	Tue, 23 Apr 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886319; cv=none; b=boXBpS3iC+WcGshQwrma2GwyZQc1nPbNSp/XE08ov7oYZ5rCtsiFSkRelRUdjgm0EZSm3gumuau2EgyOCdlOUo1T0nSgqsEBOxI7Q0GNY2pCSADecOP/YcPDJ3f45KfbcJfzcZegSSAa/gq88PBp0pCYANJXOGgpypCh5gWolao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886319; c=relaxed/simple;
	bh=OAXHGuB2S7zVOdQ/dF5+GpP9iAUxwcWQOhCvIwvgmg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZti7v/dzcGPIN8Nf7DaAgkZ+DB0dsehJrfZ/beuTRjS35Vwf/7nX8pcph/4CYX1lvKCZ8SqsqSf5Luq1RiU1f3SHWknlIIgU6K6sWwIvZxtgSpwS0u/FGwYmptWCoLfuelSWtDm9i8frzHmHhd3HU7XSmdqUBRRzXntK/g4ECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cPWUViJs; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8ED88600A7;
	Tue, 23 Apr 2024 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713886313;
	bh=OAXHGuB2S7zVOdQ/dF5+GpP9iAUxwcWQOhCvIwvgmg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cPWUViJsiaBV+FvnZ2RblzJiZ0sG7U/DitKHnJbJVbBr4OASHP8p6VAlU5oUQtxo7
	 cfbVIqRu9Sszj5DKc9zBNQp4xVwU4Ojv3RWH3TAybh2Jix7F6Yxh2/bhoxz+C1u+RY
	 yO+5gx9A0y2YA9yj2H0Cwcn5vmPtoWouB83Ykmh82lnd96aOmOXN4+bE5FBg6Fj9ke
	 2KM/MQPn3eMkcPCfBFIdZYK0uSNr8IVZQjR7tPJlH0Njbcbb9EwBkzafzobZMuKg1M
	 27hmAmVqDHJWZ+6mTeEGXK63luwE5beMfWjRTK+Yp62yjg7rNQtuRakIt9RE4p6yOo
	 4Z+COCcTQhlFQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 2F979202787;
	Tue, 23 Apr 2024 15:31:40 +0000 (UTC)
Message-ID: <a8238354-c36e-4dcb-88ba-1417adc44245@fiberby.net>
Date: Tue, 23 Apr 2024 15:31:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: flower: validate
 control flags
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 linux-omap@vger.kernel.org
References: <20240422152656.175627-1-ast@fiberby.net>
 <ZiewT6N2fjhFwrpW@nanopsycho>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <ZiewT6N2fjhFwrpW@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiri,

Thank you for the reviews.

On 4/23/24 12:57 PM, Jiri Pirko wrote:
> Next time, could you please bundle similar/related patches into
> a patchset?

Sure, I did it per driver to make it easier to handle differences in
get_maintainer output and be able to integrate feedback into later patches
for other drivers, and since the patches could be applied individually.
When I started I through that more drivers had their own trees, wasn't
aware that it was only Intel, and that mlx5-next was dead.
For instance the feedback from Jianbo on mlx5 patch, also went into the
octeontx2-pf patch.

I only have one patch left in the queue now (for qede).

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

