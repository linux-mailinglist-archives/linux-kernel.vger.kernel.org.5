Return-Path: <linux-kernel+bounces-142978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F328A32DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A131B284909
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4F14882A;
	Fri, 12 Apr 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDGnhZZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6A146A75;
	Fri, 12 Apr 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937132; cv=none; b=dPcDeVQP3K0ybSk5aO+8knfK0h8st/gIOtcpBWBbhgzHqxb1w6ohFODKXO8+mdIp1EGkxrSrOaoxvTXI8H7b6XCHyV+PmxoRSNu50QZP0NE9mD4abY5ZYToM4R8k7bEK0C3fy/zDNJ7nvOl86uvo8OFnTRm5zyrfWCheATjJ6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937132; c=relaxed/simple;
	bh=n3FhrSSGNYinFWKOLI9XEyvtmcy6wfy49qe1cma28H4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eCtXzx6Fpe0/wUwnLpXeaHwxH7tt37IMQSa34dPGfQA53pDd9MydbQYfHyps7ZHxQLcWaHi9q8Up1G9rQq6RX/ygeYFs9/x/9TMacINvgXZImJ0OTZIIs4Dbcf8+IS6Pqf4Mn1eLUoQKBweBZ941Kh1azPZ0AXtsxonkq/c43zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDGnhZZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23881C3277B;
	Fri, 12 Apr 2024 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712937131;
	bh=n3FhrSSGNYinFWKOLI9XEyvtmcy6wfy49qe1cma28H4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SDGnhZZS5hf5QwVfBTJ6uevszB2ptzmTwOips9QfzlEs1pqGzbzioFNWpFk/T6KdY
	 dcXdNeRze7eBE84N2WBpgYuzDAJjg+BphAPJssccka1Ml+DcJEp+X4N6x3KGweOicI
	 +mZTLTMdmEcIpnEFx3zQ8KjPA9+hFIFNqdKZaKFrpgiGy4lvGBcamaV2/bDQ8Xt14Q
	 EU8R0M9oDpqcLaCobgvEoGDC7bjIaQ6UAg/TM87nLBrk1rtUoGSKoPwK36lYMk5bIl
	 hYYMhQlVFgOcW/w2YBAHkb3speBI66/06v4LxVFv1PGhAiScXTco+l1MN5x0Y5w+AW
	 DQL6kjT+QLPzA==
Date: Fri, 12 Apr 2024 17:52:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Stefan Berzl <stefanberzl@gmail.com>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH] HID: uclogic: Remove useless loop
In-Reply-To: <20240401004757.22708-1-stefanberzl@gmail.com>
Message-ID: <nycvar.YFH.7.76.2404121751250.5680@cbobk.fhfr.pm>
References: <20240401004757.22708-1-stefanberzl@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Apr 2024, Stefan Berzl wrote:

> The while in question does nothing except provide the possibility
> to have an infinite loop in case the subreport id is actually the same
> as the pen id.
> 
> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>

Let me CC Nicolai, the author of the code of question (8b013098be2c9).

> ---
>  drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> index ad74cbc9a0aa..a56f4de216de 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -431,40 +431,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
>  	if (uclogic_exec_event_hook(params, data, size))
>  		return 0;
>  
> -	while (true) {
> -		/* Tweak pen reports, if necessary */
> -		if ((report_id == params->pen.id) && (size >= 2)) {
> -			subreport_list_end =
> -				params->pen.subreport_list +
> -				ARRAY_SIZE(params->pen.subreport_list);
> -			/* Try to match a subreport */
> -			for (subreport = params->pen.subreport_list;
> -			     subreport < subreport_list_end; subreport++) {
> -				if (subreport->value != 0 &&
> -				    subreport->value == data[1]) {
> -					break;
> -				}
> -			}
> -			/* If a subreport matched */
> -			if (subreport < subreport_list_end) {
> -				/* Change to subreport ID, and restart */
> -				report_id = data[0] = subreport->id;
> -				continue;
> -			} else {
> -				return uclogic_raw_event_pen(drvdata, data, size);
> +	/* Tweak pen reports, if necessary */
> +	if ((report_id == params->pen.id) && (size >= 2)) {
> +		subreport_list_end =
> +			params->pen.subreport_list +
> +			ARRAY_SIZE(params->pen.subreport_list);
> +		/* Try to match a subreport */
> +		for (subreport = params->pen.subreport_list;
> +		     subreport < subreport_list_end; subreport++) {
> +			if (subreport->value != 0 &&
> +			    subreport->value == data[1]) {
> +				break;
>  			}
>  		}
> -
> -		/* Tweak frame control reports, if necessary */
> -		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> -			if (report_id == params->frame_list[i].id) {
> -				return uclogic_raw_event_frame(
> -					drvdata, &params->frame_list[i],
> -					data, size);
> -			}
> +		/* If a subreport matched */
> +		if (subreport < subreport_list_end) {
> +			/* Change to subreport ID, and restart */
> +			report_id = data[0] = subreport->id;
> +		} else {
> +			return uclogic_raw_event_pen(drvdata, data, size);
>  		}
> +	}
>  
> -		break;
> +	/* Tweak frame control reports, if necessary */
> +	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
> +		if (report_id == params->frame_list[i].id) {
> +			return uclogic_raw_event_frame(
> +				drvdata, &params->frame_list[i],
> +				data, size);
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
> 

-- 
Jiri Kosina
SUSE Labs


