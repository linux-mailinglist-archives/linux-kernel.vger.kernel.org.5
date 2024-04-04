Return-Path: <linux-kernel+bounces-131809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941B898C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8711F22D88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539A12BEAC;
	Thu,  4 Apr 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SYUaaXZ7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9E101DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247840; cv=none; b=MVg7UM8uFT/H47gEM/gMUAdoM0kSaizl0nz6vYbwaZbF94FDcVotoPv2whD0r8rWi43Gb+zmrJxFT74+qN/HpLmNneUX2fzH9zEqdns2q1BfVJ/h4g8MDiaKZbh+7GEQWxStSnzxSb8wdGaXOrtaDJuqptAPjyFCfD3HUvHp2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247840; c=relaxed/simple;
	bh=zFhn1U8ytYpsOvkJX7a4izAucNTPGwY5m88u33TBZyc=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Ky6YmorF+En+nnrpSJjxvi6WgAGAhvq6xBJiDdrE9QPpMAkNp9jiDCRmJrga2fa2bCvfteqK2FZLjnUw2w/hdutr6M5o/Y+I0nOLtHE5W1cWx7XQ9eqe+6Edd5LfJCpmG21akPXPNESBU+CoaX5j4I12rh9u5E7Jn0X0GCLcg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SYUaaXZ7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso9034905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712247838; x=1712852638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPU9sS5DWZPGpUNMdeH+fpB2Hej5OG1Ft3OqUmS5OQ8=;
        b=SYUaaXZ71fVLl/j/6hAJUhHpfQKfFQQiw6GRysBdHeYwquUUVXFetN7y2d2q4pJOWL
         HZfAy8m47atgyuH2CpNvpN69IFhrYlhkHkogat11eVOBd/mzyWoDOTSfvQ7P8kL7B6Xe
         68vacx21ZFNlLCmKuIu4AVa3Cq13PKva9syvfTPf+D17LO/w/uS9jTTK2SfUJBN6IfKg
         eVhRmZP2oZbaQPYSwgP3fJLEz6YGXprrsfwTmqtTVsv/QlYNSnpwBI/SCi7BOu6nu6G8
         H+DiiMc5qMhwpP/XpDmOppa01zZfHFOj/8ExD+sFZA8bN3N/vdQAG+issclS9RE1JOLM
         4jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247838; x=1712852638;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPU9sS5DWZPGpUNMdeH+fpB2Hej5OG1Ft3OqUmS5OQ8=;
        b=n9y8eMBjhXUw3br8tDfVfZzwMCCQWPy2AldjXJhc3A+CDxolUEMhiWiKYhugFqJ7Ie
         qUsbsW7lQi0ALvmAmZzfjB3GcHY7eK7RudCig9vcM8m++eMEwKHNMkT1r0mABHPEK8wT
         rEmSmhp4mml+zf6HhF61Y3rC7Lyvp+HCiR+lAu8hD97nXFOrg9UXhhDIHKYErUFMCSGl
         8aRmydw23Vzmq1k1KF9ZE6WyJbAqUNubbq6oPGuHmUQavaksWHmg8HmP2yjGE7MKBLnH
         gz7tDSLcTfmwu5jeGpfd0H4RII1VXxUrS8659qYFDOHcSNCUuy5AOGMtn9P7GeLuETAs
         9hbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUynp0vDsILRdGjdR7sYi0+Gr4l6mwtOk33EMP0pZhrD/6Q6E1GI5lM8Zurbq9Y92Z1A5bGhOqIii79imeuSJKFBaMA9ESv+JxWjWje
X-Gm-Message-State: AOJu0YyhW/t2ujTXjYsmeBV1gMjTd2sE7W0XdEHsqY25WNP99ZEInUyb
	cLZ4Q8XaFrbeZGJ7Q8605Uq6/vMwPI9xu6TCOvoT3GOXY75OUzPlhX3wGePGa6c=
X-Google-Smtp-Source: AGHT+IGmaPPjOazCgHMtgZExzOBqJ8VGwnNXK5kl0Aoh37HnQp1lmpqRJgkjFfBfCS75s7beqRvWGA==
X-Received: by 2002:a17:902:ef87:b0:1e0:b5ee:e806 with SMTP id iz7-20020a170902ef8700b001e0b5eee806mr2464416plb.10.1712247837945;
        Thu, 04 Apr 2024 09:23:57 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709026e1000b001e275521788sm6187948plk.184.2024.04.04.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:23:57 -0700 (PDT)
Date: Thu, 04 Apr 2024 09:23:57 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2024 09:23:55 PDT (-0700)
Subject:     Re: [PATCH] [v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
In-Reply-To: <20240404080132.2cd4821d@kernel.org>
CC: arnd@kernel.org, akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
  christophe.leroy@csgroup.eu, pabeni@redhat.com, Charlie Jenkins <charlie@rivosinc.com>,
  goldstein.w.n@gmail.com, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: kuba@kernel.org
Message-ID: <mhng-793e0145-42a1-4c3f-b5b7-eb5dbacb4f34@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 08:01:32 PDT (-0700), kuba@kernel.org wrote:
> On Thu,  4 Apr 2024 13:44:33 +0200 Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When CONFIG_NET is disabled, an extra warning shows up for this
>> unused variable:
>
> Happy for others to take this, but to avoid misunderstandings -
> if it's not on netdev@ we won't be able to apply.
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks like you took the last one, do we need to just CC 
netdev@vger.kernel.org ?

