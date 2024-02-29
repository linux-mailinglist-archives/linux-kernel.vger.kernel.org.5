Return-Path: <linux-kernel+bounces-86529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FEF86C698
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BEDB23197
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A663503;
	Thu, 29 Feb 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTfUvhjW"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395662164;
	Thu, 29 Feb 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201703; cv=none; b=U82PuDGRvNDb4NHhlu528Ikrl9Z9ciZVowCo2s1uAb43WgwNUw/m9+DwyHnqIRHx2dTmEKCqMg9kn9xxlJMmlDsWEeuBc8houLWf2cybUerpXwiWIdjdYWF1eFLrKVLmSkBJKhNK2nhxahNDDvPRJQQZgwdArLogT8PsGH62Xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201703; c=relaxed/simple;
	bh=HFQviBJBdpXxP3V+ppGKsRvRJC+Zo8edUcmUqvxdT2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rA2zN3e1nlnZaUop9D6go5E4cf5YivEQ4X6ThPxxfaFqVn3DVsQM6biZhOHHFViyzP0oOBspTPItH8TPNzUqS+5al9Wt5DqBBv/k1REmhaECgBLPINobQMzm5lemy8/wKderpVFZwKdrS4WNjNbkWjKEC0CbpmOCzTjvCdUsPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTfUvhjW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so6091535ad.3;
        Thu, 29 Feb 2024 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709201701; x=1709806501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9QAof83tM0bxMK1+gw23eXvivTgSQEbPbHGTNrObe4=;
        b=WTfUvhjWXNtT6hJtet65KYw06MS1RPFY2BDe7c2Pqaa6HeUVn1oJGJ+uzRESClEJBD
         ZVy9B2ScMupKv3j98V92Kpm3mcrMdv3oqez7tFnD2oNYhudRM7U3QCpmGnS0dN3aoUs8
         BGTbvRE82/YBIZgWylDIoyPvujCFp40fAlKyAPA4VFf0IKQjvinwu7gekwPsUj0DHayH
         w9nUAv+TD4cngmX1XaFlLofOl3G/bRO8gLEW4B6txiza6TcUCxDG2Baxar+bRc75/35x
         NiBDPkiTvNVwMQ7+PoPFqksaR91rtlwt1x0M2O/VAUz1hWkHKSdHwGEvYxmrGzU1A+o6
         plNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201701; x=1709806501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9QAof83tM0bxMK1+gw23eXvivTgSQEbPbHGTNrObe4=;
        b=mUfiVOQBLfZkyzujzRy5hidFyaX2lhuUIUtfQ40v6maJQptMsSdbcqTOfvNcB6VYc9
         1AHqCLCfRiDgk3/UNdbVSGpEdUe/Dizu3EI0XsanCe7o1eXwot3r9ZpgwvvTkbfJtCrr
         ibeHkWompEkm1u44b66JQEpFea98T/0GEHT7Us09XJ8KPeA9HeN5RvvKGLHBxhB2XqdR
         nF3u0+NKwaMIspWKdvXkaCsPUaiN9TLTEcx3mQz5DZiB3r4EqmVuQu54TpNv8LAlGC1n
         WzF8S8RvlZgnwTJkMzbOgzngRHGhEwzGHRLmgIcRuadAz00tisEBDpGsDKKpji1FG16a
         xVMw==
X-Forwarded-Encrypted: i=1; AJvYcCVS7/AxzHFIyu8AxzegEmlTAGCQYUxCkhTEp32r0FLyLXdePBm8YdjC1srNA7KUJuQWAUHdbu34DLMhNEq3xTfrApO257ULXFscz8QD
X-Gm-Message-State: AOJu0Yy5SOVSIFXQUDZkRuAAcatBtG2F/GTUUs0FBGsjgZixXsFRqCsp
	5rewBSdogJXfew92/JAMmFm8SPjv6tJRmDwXQDFuHSyc/fwtd6Ay
X-Google-Smtp-Source: AGHT+IHA0FNoF61OaXVVD9EXaPiaegEc4Xja/AvbhuTrIfuGrttwQVso9+nPqK65WpzuKCyDvSV5MQ==
X-Received: by 2002:a17:902:eed5:b0:1dc:1ff5:3dfe with SMTP id h21-20020a170902eed500b001dc1ff53dfemr1536854plb.27.1709201701155;
        Thu, 29 Feb 2024 02:15:01 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902ba9700b001da105d6a83sm1061874pls.224.2024.02.29.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:15:00 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2 0/2] [PATCH v2 0/2] crypto: fix missing CRYPTO_ALG_ASYNC for async drivers
Date: Thu, 29 Feb 2024 23:14:47 +1300
Message-Id: <20240229101449.227921-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Fix missing CRYPTO_ALG_ASYNC cra_flags for hisilicon and intel iaa
drivers.

-V2:
 * collect Acked-by of Tom and Yang, thanks for reviewing!

Barry Song (2):
  crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
  crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags

 drivers/crypto/hisilicon/zip/zip_crypto.c  | 1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


