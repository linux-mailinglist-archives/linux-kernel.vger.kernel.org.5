Return-Path: <linux-kernel+bounces-49357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56375846922
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F121C25A38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD9179AA;
	Fri,  2 Feb 2024 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rmVTRZ+8"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7C17C60
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858287; cv=none; b=fr4/LwwzZUk3tTyrgWMj8O/vLwFA9ELzsngcJonwigDi3RKdBPC6ffRf2xt2hyiUzNvR5LYS6aC61Vd+g6MajmsfMcy19M2sZMxE2yRoTwXaVU2W909cjpxSk+oe+jd49jx1bK/8O76/n+Cilp+pptSg2U4rrm7W0NmWrUsT+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858287; c=relaxed/simple;
	bh=nm4ZQS/VjFA0/33oXv/rZ2TvSf0VJ3+fW6AC5T+GWFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKG052tOJmmW5oRt6Y1FIxebz6IBWDMg/ZVJ0eYPxjaaW3cfWudnwDEtoMoMb4J0DBNIicwrgu4rUjbXa3dAtOR9gegKS2eFTF3tzXHzvGXtWjBJBfdSmXCLWSGWF1Ql+/Omqh0yT6jYY3dEy5rQH106v7qGsPI+rspYZCogqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rmVTRZ+8; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-33b130f605eso1060022f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706858282; x=1707463082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAUjuRqQR3EqFDoyAUglRvCh4JpyuuFKVUjgTVN2xyU=;
        b=rmVTRZ+8PCWvNWzs0+MdhQgerkdXtWbyRkWOV0mzLY5Z8xFf7B83aJd0Jk9bdt1Zlw
         D39tNrxTXQu3XD+OS+sipJIoD47PQhgBVaRuEuLTMYNXjP9hyRgYcZM2NxFs5w4rJs7T
         Wi4/ctnnkarBrN9eTbqTsg37b+IwNaH23n48kTRjvrP6h+xPQlWwaNOSoVsliq/xQD2Z
         88L9wKkNxr+ijOmBbVb460xY8UtNNm0Il+91Mx+oaau1LwVGO9pzR3UrxFZbka5ZK7Op
         uTZkqjKZNlgPnny3oVUOtlzg7D+c1w2iljYUhp8goN828ucqInNK/k1QLPd0BSqrqVLv
         FiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858282; x=1707463082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAUjuRqQR3EqFDoyAUglRvCh4JpyuuFKVUjgTVN2xyU=;
        b=okWemZ2rIpqVfqVfMCWdgRVdtrFyhK/rzrCCkbJFR6a0TW9cyDdAsNgRpR94h2it/t
         hEb0ViNjQkHZCCytMqW2tIhDUS+77R1sdFc9fj/Ko6XxZdu2z5KFY+87VXngNBDmmTWX
         M8aqaXWcBONASGHIwkQwaFCnU035+uyCSlhCROMWCAhHzPIVfMW4KSl7UKwBPClR/PRB
         DSq9Ym9E6kKHzg7BMstJ98g6EYf8Rd+ulmo9NSUsN14flvxMGbjdce1r39cQT0RlV0LU
         3GGKmzO4zVOaG5iU53lPYPbGI0Y2FFGJuheSUI1G4X2drSY83OvQ2KtMYC3ki0YmgAdC
         qB4A==
X-Gm-Message-State: AOJu0YyG4/inMEmmMy/EROoCEZHMXa6OewxNSnhe/syQy22K5kFlZ8Nd
	ET/hQu6mSuXCb0FyjxwSQWOYg6bqydgGoIKW7RbNCw2LQNrER3bANjtX7/ncr7c=
X-Google-Smtp-Source: AGHT+IG2x8GDdFF8OLIvYlGbLM6O8MjsOOzCIZrIporr34iTNIHJYlQ0U7dsMCWY0nH0mKqaxkdoow==
X-Received: by 2002:a5d:62c6:0:b0:33a:febd:f1bb with SMTP id o6-20020a5d62c6000000b0033afebdf1bbmr659915wrv.33.1706858282218;
        Thu, 01 Feb 2024 23:18:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVX9Y+zLh8jP+uos0qelWWa7RYcG+vufyZ8JE1v5YdeSbhliA/oBkPpOd7x1g+fDkhcJgFYKoz9pi02ivCUjXoVOey32Sfu8zvAMQaE9bAmlMYKfUu2IatqZgj931a/6SRDOAdf90pbUvUDB/TaRzGcd1itGi8Pf0jsyAaFNdY55TN2F6wU0sBo6xf3lPhBypzoBnLU3F/6nIHLQs2BkWTOBCqkTuYcm7aH/Vcx5wGNR2wKkzbuPhdT/enpapPso90uQDqwYlq0ZekAvkd5uM8Ky7NfbMyxwlxH9AhpRhSYp4kBdCRhCtEiG9YAOyl7feFMxw6KfwoAQo84agcsNSVnxzfl7sw1QbEAa+nhpDnlBbrKAVWyEU9/IxiwBtk+FhBbnF218OzVJ5ff8liJSYGPF2J+ms2N2z6UjcL6OQya5iTYuKMkTLab0s9+tY1jhL8PTiyZ4ZnO6Bp+PJyEJ3jJQx8=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d22-20020adfa356000000b0033af51eafc6sm1244237wrb.104.2024.02.01.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:18:01 -0800 (PST)
Date: Fri, 2 Feb 2024 08:17:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: Add independent control state
 machine
Message-ID: <ZbyXJu0ZO4sZfrV2@nanopsycho>
References: <20240129202741.3424902-1-aahila@google.com>
 <ZbvFEtQskK3xzi6y@nanopsycho>
 <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com>

Thu, Feb 01, 2024 at 07:45:23PM CET, aahila@google.com wrote:
>> Any chance we can have some coverage via self-tests?
>
>I plan to work on these self-tests decoupled from the current patch.
>
>> Hmm, I wonder how it makes sense to add new features here. This should
>> rot.
>
>Could you clarify what you are suggesting here?

Don't touch procfs here.

>
>
>On Thu, Feb 1, 2024 at 8:28 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:
>>
>> [...]
>>
>>
>> >diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
>> >index 43be458422b3..95d88df94756 100644
>> >--- a/drivers/net/bonding/bond_procfs.c
>> >+++ b/drivers/net/bonding/bond_procfs.c
>> >@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *seq)
>> >                          (bond->params.lacp_active) ? "on" : "off");
>> >               seq_printf(seq, "LACP rate: %s\n",
>> >                          (bond->params.lacp_fast) ? "fast" : "slow");
>> >+              seq_printf(seq, "LACP coupled_control: %s\n",
>> >+                         (bond->params.coupled_control) ? "on" : "off");
>>
>> Hmm, I wonder how it makes sense to add new features here. This should
>> rot.
>>
>>
>> >               seq_printf(seq, "Min links: %d\n", bond->params.min_links);
>> >               optval = bond_opt_get_val(BOND_OPT_AD_SELECT,
>> >                                         bond->params.ad_select);
>>
>> [...]

