Return-Path: <linux-kernel+bounces-101037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0CF87A129
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172C9B22148
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC8BE65;
	Wed, 13 Mar 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inh6CyaI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B003BA27;
	Wed, 13 Mar 2024 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295145; cv=none; b=KQt9oQ1fFBJg0HcP/+HUC00xt/+zl+YqIRtshECJtfCrnYgRBaVFkU/caitj5EHbihRA8Pfxn60yaz5oPwLMuE0PhTQnKycax9iSy3/XVjOIvO/PsQu8W+38F6tOtPHRfypO8WL99epADKmysMZex6Ai1z7NAQvp8N2CDALcSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295145; c=relaxed/simple;
	bh=yCzLfMCERzhpmQeaZQp12W9PWBfBNEBGbVM8t/X5y7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aP4fjZI+GqdetuXTROIhH2JEbtKL60MoN3xByGP7TCoFmCxVnNFULsSvLEo8kDrwYOQ4NXU3djla2ZrVDCaoRBwlWZKC9vDOgG6vsJ3vwqx2Zy9jUzyvQw5jSltq87syPcS0f15pGM4EeMaq2NyUVraWjzSAc0oKnzK5m4kFOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inh6CyaI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd5df90170so3908725ad.0;
        Tue, 12 Mar 2024 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710295142; x=1710899942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oP2K1n1X+9DGLWdItTeWuFNvDflUz+Ie9+tyKphc+M=;
        b=inh6CyaI8DqEet8BcqW391Z+YwmMgUgXgFFidpiidkdqk5u7WabbQZ3BRkkjcSnwpx
         uKalBivGdtVl625id3ciTSC+aOwOzkhrbBEoVNWAQekCnXnGOFqBGgyODdoSI9rZpRLS
         LmzAz5PQtJXfrfcboCq+QGPyyp9j/G5LEsCdfvN80mzPeYpt44/Jsom5MWtkbGVF+tuG
         /fwk83rBR3fi+rmxH0dijkWIwx47ZHSRXEy+0BUUPN50f73/14rFPMY1UclyFNLNdHPU
         aru1v50enqSr+oKZzwqun1A94BOQzF/lZxoBBwvGKjgqNc4aLI/KL0fseNlokjfeY/Uy
         L1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710295142; x=1710899942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oP2K1n1X+9DGLWdItTeWuFNvDflUz+Ie9+tyKphc+M=;
        b=A50q9PBybU4fUgRpMCFmKqej9ISTPw89H7ndnMCt666E6DKWh67c/ji8U8ypmw7ZGa
         /Aypx+iybL0Utu/tJemPVlFKQCak78SiqYpsJPceNZ0qMplfEpX1MRGCHwBW9EMNtkcf
         hpr5MI9+6ueZoS62k8L6FdllxQRVZHRdHvj5GMiK+clgzr2B/m0cvyhEQq4KPTUH1t7d
         7VshSgSVQCDK/juqAef/OmY3sb4iepQRjqyd05H4eqzHuLLEGdLE6Z1rjHXpeo/MmeOl
         TjhhMUQAp38f3R1JAWCnU7EjLTsMq5Z0klYeh+w9SzCGFyGVjc/y7yEdYkOyn0g65up1
         Dn5A==
X-Forwarded-Encrypted: i=1; AJvYcCWPmmQbSFJPSev/oR9p4uQ0Vkv2yypCCN5BH2gQUETmvlBDHPCkFILm06xBcPWSiD7dQurz59qH1y0HF9SMq/u/wqVj1I//FVCDs23qf48Fc+UzRqtpC9ovoXWAIibXA8tjcP1oU+Vk3ugLotv9++mSCCLSjPUEFZpvGkXQKseM9VgqeP0tdA==
X-Gm-Message-State: AOJu0YyQ2QseG+bLiqStI7cRfnCkfFJr34z3mQxIzULIXNuy51MYW1tt
	MWhueSLIXC4WgZZjbjUSq7RZue5QyXmo7fpErrbeRDZp9AqUoQqC5Pynfqh0
X-Google-Smtp-Source: AGHT+IFoaK2nyB0YllAD/6xrr9CDFunZOFx5tDZ5MLCtIAJWBd60MjCREHvWoImGTRNeicYeJiRH+A==
X-Received: by 2002:a17:902:da91:b0:1d9:4106:b8b5 with SMTP id j17-20020a170902da9100b001d94106b8b5mr1935151plx.11.1710295142505;
        Tue, 12 Mar 2024 18:59:02 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001dd88a5dc47sm6273813plf.290.2024.03.12.18.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:59:02 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	akpm@linux-foundation.org,
	sfr@canb.auug.org.au
Cc: ebiggers@google.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	v-songbaohua@oppo.com
Subject: Re: linux-next: build failure after merge of the crypto tree
Date: Wed, 13 Mar 2024 14:58:48 +1300
Message-Id: <20240313015848.46765-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
References: <ZfEFKxl8/42oXv0i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, Mar 13, 2024 at 09:43:52AM +0800, Herbert Xu wrote:
>>
>> Instead of using the non-existent crypto_comp_alg_common, it
>> should do something like
>> 
>> 		return crypto_acomp_tfm(tfm)->__crt_alg->cra_flags & ...
> 
> Nevermind, the stats revert should not have removed acomp infrastructure
> like this.
>
> I'll revert it.
> 

I assume mm-unstable doesn't need to do anything since Herbert is going
to revert the crypto commit "crypto: remove CONFIG_CRYPTO_STATS" which
accidently removed the API. once that is done, linux-next is going to
be ok.

> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry


