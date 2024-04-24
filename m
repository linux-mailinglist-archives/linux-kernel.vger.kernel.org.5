Return-Path: <linux-kernel+bounces-157134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0878B0D44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CE4286F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A715F408;
	Wed, 24 Apr 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WW821IC6"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD215F3F1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970357; cv=none; b=Q4ZJ8XWkrJAg0Jk5T16iXMvegmV9vAejQFco1CIIMdu37yOLg0NdNJbCLXz/k06hGH6Wv509sEI/tkmD4nKbE48gbZTVvhu+npaERaNXDyYagUXxDFKc5PBbvXuG4Xj+w+UQh8TXIgx+yyldLfh1hWqiw+rkSJONfVO9/Sy7WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970357; c=relaxed/simple;
	bh=uwMlOajpsTG7Nvu/GdqkCHHfqk+DgHsocAsnwQtfytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiQY0u7MilrSmFBk+A45DVId/XeibvkYXMc8oNEOTjawg3XMGCD4aKVUKNy9Op4US19VMLYsKh35rIjltAn1OIZr2pv8R1Bro5W8QWsKNr/FpjXPeeOpAJUl4YMM6ipi0NWp4rU1GpRsJjHMRzQ8aLxNcMa4Cgeeqsq6qyDecIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WW821IC6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d6c1e238so8809580e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970353; x=1714575153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7XnI+BXV8UmW2sRzD+hzCEM7gwy7DDAc2EqtkuzGdE=;
        b=WW821IC638aKkEVNJ1SI4qdJdp32abv2tsasowSJrxJXD/WZMGypwjC9OGZz0QxQAP
         L4q+PRmYCbm6dzrAs02icdNaPVO0edEkI1r+BLz6xc1Ubjxrv51bOvepNZlOXAGbMHgy
         RIUHnT1gRbmyhe2y+op6emBQDoP8FDCL2vuL/7xStCb2rS3k4BFXQpYWg3DYnX28dT1v
         2rfMj/sEcpuTjjSo9cD2xiQyBH+t+cdEfkQPDyR0GCcxGUQgn4kFp0pbjasdSy4uZMdN
         Q24y2yHrr1DM4BNU9lpfKoz8tXS9CWKRU5OKnbymqIld5KxIwHFOphIpqpbYpdfX1q5S
         Kc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970353; x=1714575153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XnI+BXV8UmW2sRzD+hzCEM7gwy7DDAc2EqtkuzGdE=;
        b=MxnxJDKpYSEZRs9Uy55nr8FLmkKm7ElVWWG3q3EFVz7TmU4D6WalWSUV/uW1Akqfxu
         vAal4jafRT0LvATwZPaMsur/otfDBPLFxxi3h3IxNq/6668RNQG6tW4Vot3gQkJC2LLo
         LNg3pi4BQnooikopSxn6mk/LKZEz3MHZxeO1CWMu2l+ExfLuyR5cjR3EaO8VsN91bQg0
         yQ3k4sRQK/B7118D7xqo87lk+UTkngcqzeRJDtXIFyJGfFo8svhIg5mIm6XvbYxpGfWn
         tl/O3oNuieiXqVO3I5oEaruOvOTbzF1F9EKLMejWdW3qjJPnAhuq0MpPXm+zA7szv1jI
         lfnA==
X-Forwarded-Encrypted: i=1; AJvYcCXRxQE47VmFEpSqUQfkiWkfMncxKLaSQh2Nx5DE1gYyf4s9wQWQGGNfLxqzY6EYu4hB6+YHjIkmgYgwG9bOeFiTqWik6mc9g48/izTe
X-Gm-Message-State: AOJu0Yw1VHIL++4JvsARrWgNIUyGTn2LRVlMo2LWOXTVRn6/Km9S4zNL
	DN6jcjBrR1PE9mKYQ3HoQgYx+TQOFAcaDlokDjXTvCO7QyXZSPwaw3WpxqctHPU=
X-Google-Smtp-Source: AGHT+IH9F9eP/2XPHDQWflN29dAuAUFe6jszWIggRCsEU6DATfYGnMJ4GGP77Hb98kuV+APO2prnzQ==
X-Received: by 2002:a05:6512:3d2a:b0:518:8d15:8810 with SMTP id d42-20020a0565123d2a00b005188d158810mr2738510lfv.14.1713970352642;
        Wed, 24 Apr 2024 07:52:32 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906128f00b00a473a1fe089sm8442813ejb.1.2024.04.24.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:52:31 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:52:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next] net: qede: flower: validate control flags
Message-ID: <Zikcq2S90S97h7Z0@nanopsycho>
References: <20240424134250.465904-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424134250.465904-1-ast@fiberby.net>

Wed, Apr 24, 2024 at 03:42:48PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any flower control flags.
>
>Implement check for control flags, such as can be set through
>`tc flower ... ip_flags frag`.
>
>Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
>and qede_flow_spec_to_rule(), as the latter doesn't having access to
>extack, then flow_rule_*_control_flags() can't be used in this driver.

Why? You can pass null.

>
>This patch therefore re-implements flow_rule_match_has_control_flags(),
>but with error messaging via DP_NOTICE, instead of NL_SET_ERR_MSG_FMT_MOD.
>
>So in case any control flags are masked, we call DP_NOTICE() and
>return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
>
>This is AFAICT the last driver which didn't validate these flags.
>
>$ git grep FLOW_DISSECTOR_KEY_CONTROL drivers/
>$ git grep 'flow_rule_.*_control_flags' drivers/
>
> drivers/net/ethernet/qlogic/qede/qede_filter.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>index a5ac21a0ee33..40f72e700d8e 100644
>--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
>+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
>@@ -1843,6 +1843,19 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
> 		return -EPROTONOSUPPORT;
> 	}
> 
>+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
>+		struct flow_match_control match;
>+
>+		flow_rule_match_control(rule, &match);
>+
>+		if (match.mask->flags) {
>+			DP_NOTICE(edev,
>+				  "Unsupported match on control.flags %#x",
>+				  match.mask->flags);
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+
> 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
> 		struct flow_match_basic match;
> 
>-- 
>2.43.0
>
>

