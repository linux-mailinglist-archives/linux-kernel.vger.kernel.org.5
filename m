Return-Path: <linux-kernel+bounces-109911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538348857B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697881C2215C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB357867;
	Thu, 21 Mar 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XtPCq5Mi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E254FB7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018658; cv=none; b=F/9oKE634TOF/AmtkRi92VVplgLBgLvahbygQpjHjt97+mHYlUVdFEEp2ImBGUErr64gxpThoARIOgXzUVxRsatIY87X2ptZURz0GbiuZZr7AUnzd7HOlkPnqUyzca9pP/gen69LUctQtWkIty3Eh0X+3EL0iKTMNIO7QWF3h2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018658; c=relaxed/simple;
	bh=CG1JXQpdUvv3rT0qsD2v4D4lP2ZYu+U0xKPRIHl3MJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V82HXCnt7VoivWNFK9qaUFbmNTISQfRXQTOrQfVYzq4dOPSc2yzHzwHZvVgp5MQTzqoNTNaP4CVbzsoFkY+M/BjBhTXaF+1Nfntfz82YoA7NVF4SKesmczc3FFwh1I6F4j6NiIixpyFtYSV3hlS8tPT5GIeBGayi71CI51QBlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XtPCq5Mi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146e5c719bso6288095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711018655; x=1711623455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YpoB6rawd5A1BAipjDXpWOaIKNHGW5GiFJ8RTwY5i8=;
        b=XtPCq5MiVxJEx9afupLx0EUzUnhRfamZ2n8hWPq5CjhZG9nk3nYDhdXrmzJZPvBLIm
         bFmKI5TuNLersRHK/RAB65m3rTQggbBYOCBmc14VvePL2KVEDtYEq2EGHagqdLKW8SLW
         4IPB9hCRHCfAKaHMbtZTaLXEYvzpxaPhrGWMYgmTjrmDtw2/Pm+eqoENRGFPnlzlp3m0
         sWWwC2oCPX/Oo9kgZyNmXfZzo++LGeOjYYbMVsXJDM29YZQmOtGOMrtWN8ANCNV3WGVB
         74rml3PK5duWmy4sKdIOrtC/8etJ9vggFdZwPRwDPXus4AQ9qYDFBbC7v7MD+Knf4fqp
         UtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018655; x=1711623455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YpoB6rawd5A1BAipjDXpWOaIKNHGW5GiFJ8RTwY5i8=;
        b=OunUqo8e5CUApyI8s1Roe0jSNHACwXcyrzsp9liz6aL5dhyjTgXeJNTvJQ/ZDdZkBu
         qwNZdwF2b42kHiBzk1k+BNR1YCjtB+BDA/+8dBjCE9lUMCUW7lpMo+dZNnEXkS5IYmWm
         EDKPqL21XnqvL+GFJZcofIaW1JSWr+HtUABAALjPQOCKbMNEwHSW65ekT0Lt/x660U1z
         3kitllxRzJoA9IojWJm1hsYqgANv7UuED82Eo5zjDL+KyBJkj26sgVTmXMzrtNVCuo9X
         4kOOLUuL8jolXNQS+FyG0y+Ir6NJ+tlczLf4QUHZGC6FEXiAfcG9LnS7GlgcFy5ZA1w5
         q6pA==
X-Forwarded-Encrypted: i=1; AJvYcCWunEylqtmZzXmXnbfUcPWpchEi1taFLqBHs+lFuDLjFHvWwa0QS351IsXaT7XxBm9ShiE33biCt+0R8ENGkalhp98ahcre0feQLonp
X-Gm-Message-State: AOJu0Yy3hJiknKJNc90zYyvQaxDTgxb6uaEPhI1yRpBCXU7o7jIn4Ulc
	xRxkIC4WcMo0WNGPLvZnUXLicZFaEv5iP46thIw+GCGGl0Oqs6mrhxY7VeQlIjIooKIV5KUGkxQ
	13uA=
X-Google-Smtp-Source: AGHT+IF1manZMw5oeVMy6LIZmcP4p30fJKE/z/LJKSMDkI53+5vpzVMlDsmb/LfM0Bp6zynjXC550Q==
X-Received: by 2002:a05:600c:4e86:b0:413:fc09:7b19 with SMTP id f6-20020a05600c4e8600b00413fc097b19mr3353073wmq.40.1711018654731;
        Thu, 21 Mar 2024 03:57:34 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm12027242wrb.75.2024.03.21.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:57:34 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:57:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <ZfwSmlZ-Ie1dFlue@nanopsycho>
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
 <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>

Thu, Mar 21, 2024 at 10:36:53AM CET, abelova@astralinux.ru wrote:
>
>
>20/03/24 16:38, Jiri Pirko пишет:
>> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>> > skb is an optional parameter, so it may be NULL.
>> > Add check defore dereference in eth_hdr.
>> > 
>> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>> Either drop this line which provides no value, or attach a link to the
>> actual report.
>> 
>
>It is an established practice for our project. You can find 700+ applied
>patches with similar line:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org

Okay. So would it be possible to attach a link to the actual report?

>
>
>> > Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>> This looks incorrect. I believe that this is the offending commit:
>> commit 690e36e726d00d2528bc569809048adf61550d80
>> Author: David S. Miller <davem@davemloft.net>
>> Date:   Sat Aug 23 12:13:41 2014 -0700
>> 
>>      net: Allow raw buffers to be passed into the flow dissector.
>> 
>
>Got it.
>
>> 
>> > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> > ---
>> > net/core/flow_dissector.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> > index 272f09251343..05db3a8aa771 100644
>> > --- a/net/core/flow_dissector.c
>> > +++ b/net/core/flow_dissector.c
>> > @@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>> > 		rcu_read_unlock();
>> > 	}
>> > 
>> > -	if (dissector_uses_key(flow_dissector,
>> > +	if (skb && dissector_uses_key(flow_dissector,
>> > 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>> > 		struct ethhdr *eth = eth_hdr(skb);
>> > 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
>> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>
>I agree, I'll send the second version.
>
>Anastasia Belova
>

