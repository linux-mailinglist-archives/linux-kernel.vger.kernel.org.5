Return-Path: <linux-kernel+bounces-132635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1889978D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCBF281F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A84145B34;
	Fri,  5 Apr 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5W2zGwy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30151143860;
	Fri,  5 Apr 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304706; cv=none; b=OP6bVTFypUgcR/OO3mlXx2WFBjkpmapbsFAGYtHLXgCoj5Q6Fw3lMyvqBMvbnTp6zq6xJaJHbZ0GaJqeWBGmAxewbQ/q4J38yQ9umLEZaCLHI5wiuKxfHzm96+ylefV1fuF7lQ6ORF7YynHg+7kofAdagO9P/U8f1+WAK7EdQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304706; c=relaxed/simple;
	bh=yi8PAHg0FKEHeQospJGwgER/voQz1Dbxm5AeM7nY/n0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bat/kDzIyqfX4vUPvz0KDh35VEPotdFgOw05o5a8RGLL8qsoxc4TXbAvO1cTZ3j2Cw/EFanIiPTXCuWcFx2B7t+eUHlHnbKXO8bckuqrvFwk909Mt2trtiuhRS3CZLfwQsKSAST+ScQamYEWIxh5fzPPkZRW8i5MBSlNPM0NRWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5W2zGwy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c97ddcd1so2184833e87.2;
        Fri, 05 Apr 2024 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712304703; x=1712909503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yi8PAHg0FKEHeQospJGwgER/voQz1Dbxm5AeM7nY/n0=;
        b=V5W2zGwyXnQa4KavoDhSQ92NT8zHe3kSzPX2ps2p0FQ+P4nGnKUON4TRBxsirNBSmH
         7AwAEz6bew+a/ivEZtGjyyDkpBovER1jXeobCRckxZAtO9CuCzvEfxusK1nI2hMctdqL
         ZKFefLEVXSA3med/MVGgScXAIzZwnfYBnRiREiqLe/Mm+NdOnf5NnhqQeupaX5WbQVeV
         1jKo7hC4R9Zs/C0uT6olYcGtmH6PJlWJeXq4uL2It3pEez0+YO1/zmWlbHv1x6VQKyFU
         jexI9BVXPmPZ4DXPW1UhB35RpF3kLdWQeZpTXdEs73PqLO2vtZPPO6yOCSfAsOTw9aFd
         meeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712304703; x=1712909503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yi8PAHg0FKEHeQospJGwgER/voQz1Dbxm5AeM7nY/n0=;
        b=P8a5vCpe8S4N1eQ/bRJIMIrVkv26ScCBbdC0vf8r4lZPetq/pesfT/wzlRnQZwwNVF
         omk+1e1kGz/PeTbb36JGoLvWMqXejROEs1JItbygWt5jRdgiX8FMDk1O6TyO7emc/R+j
         n4nEbb6i6F7/7LcJppBi3lBmiUSbl6d+lp2NIdgOBLUjQAHha7cuRtqfDOsPPWMCj3Gb
         sUIC+LdmUmzCDWn+ZQcQwijvnaAlGTBUIihcd5Zpqg2TrWCVwo7V8HOD4iHiiuF+sqbc
         /HvdQmPcs60xQIga3OQoRMfSaQDv8TpkJx1oG8VEaYEzxfZW67DuTE5teFaoQBO6Vard
         3JEg==
X-Forwarded-Encrypted: i=1; AJvYcCUxIZeivwVJ/InZ9wg6p4EpU4fq5APm8WKagHPcCZ9BdKflwAAwqD1TMSIMB58Ct2wzdOwVJn8U/6pndWnLQ3ctVKFXUYHv8Fueci4TeUaIAYhtBGx0tczSqpASbDUEsWDH8yp9eQfnGg==
X-Gm-Message-State: AOJu0YzCqvzYb8JsOpQ72yaUr5SaJT+qBPbHEgt+FZr4qnnHSS75jv9B
	g78732G6ksVYnRREHyLDClj2+MvpB357BTO0S7jIixlYvT9jP+2K
X-Google-Smtp-Source: AGHT+IEBl+NGUmAKsMMIjq3va74DO9HZXUY2YYjJkt/EkqMvCQ8eSxSObJ3o1yUFzc3pe8iGvN6xdQ==
X-Received: by 2002:a05:6512:459:b0:513:c60a:5fc0 with SMTP id y25-20020a056512045900b00513c60a5fc0mr474146lfk.0.1712304703038;
        Fri, 05 Apr 2024 01:11:43 -0700 (PDT)
Received: from [10.176.235.56] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id e10-20020adffc4a000000b00343a66f6be4sm1394300wrs.24.2024.04.05.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:11:42 -0700 (PDT)
Message-ID: <0d8ff9ae438537272d40c801f5f5e1b6fb213363.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
	 <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche
 <bvanassche@acm.org>,  Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 10:11:41 +0200
In-Reply-To: <20240327071714.757-2-avri.altman@wdc.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
	 <20240327071714.757-2-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 09:17 +0200, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that
> uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.=C2=A0 Thus, remove support of host controllers
> prior
> to UFS2.1.
>=20
> This patch removes some legacy tuning calls that no longer apply.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Acked-by: Bean Huo <beanhuo@micron.com>

