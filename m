Return-Path: <linux-kernel+bounces-154967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B948AE3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01387284609
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355207F7EB;
	Tue, 23 Apr 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ihqD9qbI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36E60279
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871277; cv=none; b=NDSYUPZv+xoNqQVNJYsanEeuU1Y8RLKexgoFTKdp4sKNGnfLuhlAvc2sK5hpRKPU4gb+Jsz4Pw0E8SA4eu0UzsP1fJKvKLQtz73zN2jtGxkfuMjTJy+EK1Qa1iFou5L76KP+PkiOm7sWjh8yneB12MSgIGGazU5lcU0Ep+57BHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871277; c=relaxed/simple;
	bh=McL494kHylPQpgK5Rw5ewYirZI64scA+ENuhG3CQDmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgI2J8H6L2fXG/OiEeH9lvDMDEn676rYZ2j95om6taDyt4dOn3h8JTUhqdo+uHaFfZVpaczpAtbOdP/wBuqw7S3fvqwMytdmDRc4ub43da6noGgJDjOBKgMG++eCWSUBewfb3JXzTrGnVUFTqiqzn+fKg1Ec52Cw1ybzGdmp4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ihqD9qbI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572242ed990so371319a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871273; x=1714476073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xQMenMSb8l2LXPyBEi3wXYVH63SCYqukshiFhylvZmk=;
        b=ihqD9qbIatpdUh/0foOGY7hiqy8iG1ld0JmC8PR94KHVQx02hzv5gZwVLLv3y4p9h4
         KAlh2wGbcV5U9v3Quwblmtd6KX9gvTgH28NnXcnxPgdbUbZV64LxeGZ7frbcZ5Op7UkV
         0vK+pDui7RAfJF8AP2mWIUmT+ZW3cRDUOmfdPIurf2d81BmNa5zIvGJSDzpjMTE0uJyX
         KsALYJ6pJFkus/O4o5R/sFCgh4+bc4cyt0bSnSjcW5AWh4LEPsgTli95fIRp8K3V5J1V
         Dlm+/DjlZlrPuA6V4OaYnIOMlbUfFrP9NbjU5eLQajmNqiQikxI/Ib/uvMNtpL0IMB0N
         wiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871273; x=1714476073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQMenMSb8l2LXPyBEi3wXYVH63SCYqukshiFhylvZmk=;
        b=pAtB27y9T125dzqZOqKYV3pcYeq7Qny6UGiOjrydOx/PBy3Anah+3uWMTRrTh1cUYV
         CrF/2/FBHUzON/7AiFCKDie1vrIo5lCQM9a/bnYU2eB6bXKBuzjoyvFMcLMyKWj+cvti
         TMVPfIyFpGEPtzuelrXgMPgJclcBO139KA9aO2TLXZkTKVxJDOuuY4az7KnCNVJCG58D
         eBDxBGKHjId1Pp7EwpJ1YTkjFLhRw8+UWyLdD+4669FzP3UpNCUGrghb+yKmrED2RoKV
         jdTpN8GHcvGdRAK9s7cfUtRbt/8kV1z7l6RTPRjDpnpqMDQ8hn+SIZ8hPdI9ujiuCvoN
         nfqw==
X-Forwarded-Encrypted: i=1; AJvYcCUZoLqaF+GsvzMo7zdvrYxHP5fg2g8r39zZAwu77KoKDYn7wuty9Hlmgbcw4T6sKgNKxvBl04u25hKEgtzBRFqoONch0uB3kHiVdQPJ
X-Gm-Message-State: AOJu0YwytxvlmYEoTvhsFbWA8RtcWC+o5WUDLyrKCx8NaQarj5fC1gfy
	IQh42PL9uruEi8Ttc6vMSi6wTFQL/BqA3AmcwgmWErT58oaNeK6u+x/VDHcu+1Azt82vQ+aKOAi
	f
X-Google-Smtp-Source: AGHT+IHLl0Px4nYo1vdOF1bA0+T6nLq2YDRmJapSrmSqV5inK3bXcounfKFEFFWV8y2QLErPq7rOQg==
X-Received: by 2002:a05:6402:430a:b0:572:f71:8030 with SMTP id m10-20020a056402430a00b005720f718030mr4482592edc.8.1713871273077;
        Tue, 23 Apr 2024 04:21:13 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b005721b7bfea2sm1082789edb.22.2024.04.23.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:21:11 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:21:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: lan966x: cleanup
 lan966x_tc_flower_handler_control_usage()
Message-ID: <ZieZpixUPfTxIRs4@nanopsycho>
References: <20240423102720.228728-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102720.228728-1-ast@fiberby.net>

Tue, Apr 23, 2024 at 12:27:17PM CEST, ast@fiberby.net wrote:
>Define extack locally, to reduce line lengths and future users.
>
>Rename goto, as the error message is specific to the fragment flags.

2 changes, 2 patches?

>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
> .../net/ethernet/microchip/lan966x/lan966x_tc_flower.c   | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>index d696cf9dbd19..8baec0cd8d95 100644
>--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
>@@ -45,6 +45,7 @@ static bool lan966x_tc_is_known_etype(struct vcap_tc_flower_parse_usage *st,
> static int
> lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> {
>+	struct netlink_ext_ack *extack = st->fco->common.extack;
> 	struct flow_match_control match;
> 	int err = 0;
> 
>@@ -59,7 +60,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> 						    VCAP_KF_L3_FRAGMENT,
> 						    VCAP_BIT_0);
> 		if (err)
>-			goto out;
>+			goto bad_frag_out;
> 	}
> 
> 	if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
>@@ -72,15 +73,15 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
> 						    VCAP_KF_L3_FRAG_OFS_GT0,
> 						    VCAP_BIT_1);
> 		if (err)
>-			goto out;
>+			goto bad_frag_out;
> 	}
> 
> 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
> 
> 	return err;
> 
>-out:
>-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
>+bad_frag_out:
>+	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
> 	return err;
> }
> 
>-- 
>2.43.0
>
>

