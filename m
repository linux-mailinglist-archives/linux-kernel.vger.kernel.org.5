Return-Path: <linux-kernel+bounces-158096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C18B1B69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D51F24BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015D6BFA1;
	Thu, 25 Apr 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fv/fN9Ut"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462E5A7AB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028667; cv=none; b=jELMT0M3IPKGAStdSrgnZrklBNq+TWQ+u8PBZdnFeMmNWu/6kd8NY03z8nHiIMdckRfyEYuC6vLw2eRwQuQWNzKRN+kuvBfWKpH3LD4YF70aQYygST1FiJu6z9i11KiWIhtfbMWPMF38a8T7AErYrZglLpBkVBj+QENMGzot6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028667; c=relaxed/simple;
	bh=/VjRoJE3IXRNkRzEdSWJMoni3iSBje1meeBcc8jOQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey/6p3/NLzZJJA59+XcsEwQTcBSdLQcjIrDCUZd4FxgxxpqRKy3/8gWNE/8fBDeUF+xGOdVF/V7n37cycTkbbgKKjumX+gXPeNQTDk0c0nuB5TCem70gO/glrnUV8c+k0kJEt3/i33AAzbQNvsGxdzN5F1ksx1oCCMMreYPR/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fv/fN9Ut; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572229f196cso674267a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714028664; x=1714633464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBR6dncekgh5NrQLVvWpJ1bIu14pltXiH3AH2dGUbz4=;
        b=fv/fN9UtkXWJblrg9TIz7VD/qvIR03gSA2pGOslX/floDTrKnkQrkTqhPW3+f0MbXM
         Ikw3kyPXYf9NEYSu71ergzqF6T33BbiyOAbEyN0uETHwk2nvWsaF15FiUqE3VYCTzbw2
         UP07sP89k3o6cmxUJb/ezwBrkz6eFzWIU++ySSE+x+DfRk1MzC8Ino29adNovHBS4VZp
         DpsjTu5YMpoTyQyB+huyB+S39eLbAOwozjTNRHlNUMoveL3vFfXCbtbUMe0MGBm7wpot
         uDPhbZ0xz8GrFdVWcFwR0sGf3VFDGDSZiJfK28OUpicmp0gEi8urhS6R+rDI434mCDhu
         I/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028664; x=1714633464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBR6dncekgh5NrQLVvWpJ1bIu14pltXiH3AH2dGUbz4=;
        b=bRkeoeoQ0hM0BIz2XJZ37dBZ6dTUBTOCtBZMdxQSzjCt+29vc/s2VJzdOP2SCHXJT4
         N/F5VtMgqbStFQ7JRwfJw1oQJAJJF4kEWGooxoHcgEU5hL2PbSgFn8v6QmNUse01hUmo
         v/oApTH7b1B15HqSHyjRhec/Gp+MIL15bXs37NNMFBQp3K4g8LZD3rzkGoN2wH7OAtsC
         /6FFotBPnHtTyyeij9K9EUp+b6uGnp4JJzrrhCvvTIGZeSJvSzI6QwIA6Jrn5vb7IHJ6
         CM82smSTkjbdFfsW0ZtbU7gZb4wqP7rdZ6+bpwHpEhlkMWebW4Sbfhdv6WpIG9hnHAfH
         6Hqw==
X-Forwarded-Encrypted: i=1; AJvYcCUWtuMFzk7nQicvPLclgVxYB1tRg/CX6SjGPP+lvvYEFP8WqQvazfTtWE+kd0a5D6vVMhW7mfSrDeq9wlvBWZfNaKmulPm6ZHrZs74a
X-Gm-Message-State: AOJu0YzgeMlsrJNsKEgwpvgfdy+gCwckRt2QnbQCYruvFHnuH7cZHEy7
	NgtJ8q8TqksTzX5pkVdQp/N1C0TiQ4c7Q4xxg8vA1vzT4vmY35Qo6/pJwxbS1Wo=
X-Google-Smtp-Source: AGHT+IEQ8s8854EseHNz+L2jLHovAq6W0eWl2AJR515h0d/Dmap6/1Bkc0yyTsrA4vgsxATiLZQQSg==
X-Received: by 2002:a50:9b55:0:b0:570:c8f:1a35 with SMTP id a21-20020a509b55000000b005700c8f1a35mr3456039edj.8.1714028663631;
        Thu, 25 Apr 2024 00:04:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0057245a3fd4bsm117790edb.68.2024.04.25.00.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:04:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:04:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next] net: qede: flower: validate control flags
Message-ID: <ZioAchImQ65ck1Ua@nanopsycho>
References: <20240424134250.465904-1-ast@fiberby.net>
 <Zikcq2S90S97h7Z0@nanopsycho>
 <923135c6-1bd1-414d-b574-c201644d35ab@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923135c6-1bd1-414d-b574-c201644d35ab@fiberby.net>

Wed, Apr 24, 2024 at 06:43:14PM CEST, ast@fiberby.net wrote:
>Hi Jiri,
>
>On 4/24/24 2:52 PM, Jiri Pirko wrote:
>> Wed, Apr 24, 2024 at 03:42:48PM CEST, ast@fiberby.net wrote:
>> > This driver currently doesn't support any flower control flags.
>> > 
>> > Implement check for control flags, such as can be set through
>> > `tc flower ... ip_flags frag`.
>> > 
>> > Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
>> > and qede_flow_spec_to_rule(), as the latter doesn't having access to
>> > extack, then flow_rule_*_control_flags() can't be used in this driver.
>> 
>> Why? You can pass null.
>
>Ah, I see. I hadn't traced that option down through the defines,
>I incorrectly assumed that NL_SET_ERR_MSG* didn't allow NULL.
>
>Currently thinking about doing v2 in this style:
>
>if (flow_rule_match_has_control_flags(rule, extack)) {
>        if (!extack)
>                DP_NOTICE(edev, "Unsupported match on control.flags");
>        return -EOPNOTSUPP;
>}

Looks ok.

>
>pw-bot: changes-requested
>
>-- 
>Best regards
>Asbjørn Sloth Tønnesen
>Network Engineer
>Fiberby - AS42541

