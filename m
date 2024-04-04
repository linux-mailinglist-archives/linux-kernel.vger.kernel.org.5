Return-Path: <linux-kernel+bounces-131643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B4898A58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1171C25F60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A71BDC4;
	Thu,  4 Apr 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="KQivoeJZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800133EE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241920; cv=none; b=uuaD4Z+C5qPf6Bht53jSSFh8tufAUAhit4iTB8ly0WyYRFIvPwuwr0qSmPbg8RHxQTbVu7lgKE/sWYn6Rx6yNVVd37HHDOlajYuddYg2JNU9dK02K/GmcZKN5vwBTLYkC8eFjCzi4pdr7yYS0YUSa6gWcFhBaU+p3vD0uoQyUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241920; c=relaxed/simple;
	bh=OEHQ4jWntQEzgLpILxQRKPJLIbKczYdchBitjO266Wg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=J2RqufLbGIcDaG0apGOJMTNHr3ebXOEQ6GlLNrj7ezlWpn2HPVyYdZXPxVhyGLwfnv/88c+eTP16od49IlKTBOBHpEql0ykTYQFarjsTLiICZEqRFmVoZoVErkXHv3ecEPfO94ifdw0pj1nOkW3JyQKAM5BtmIChETttXOR9IKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=KQivoeJZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0d82d441bso9756405ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712241918; x=1712846718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEtA7ue1KjE0okJsvDxQ4gU3UMWQ6K77fPKwSzlZjUQ=;
        b=KQivoeJZ3PtLACeCg1DKItbq4s1x9PH1soZ+Go+8Cnfk1dBqP6ouvEoQs0v71SgStt
         BxUq134cbq42nNh6AzrlNPj0+Nqy9M4UudQodpKUMrVfbqKHphUJY7cxERD4s8wQ8wfC
         7VogA1pbSCvOUAuVdqhzCv4dVOLg3zepkhm1zLwReaov0DtcLw55/9oG/0ieAaa0/reu
         hSP2eYo7I8EeMz4C2aOJefdm2gUzsb/8y/aMPdR8y5mUACWGh7rnKgvbxzkrI9WESyLs
         BxXlAlgKBgA/PkFb7b4x0guB//7aTROT94Rny+pt1mmxdBfBmKMfuA7J+oQct70K81GI
         3kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712241918; x=1712846718;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEtA7ue1KjE0okJsvDxQ4gU3UMWQ6K77fPKwSzlZjUQ=;
        b=H1G6PBnQznYT7PhJ+2DOiOLKtaaXn0t0MjgaqOyH8IXYhk7VkOErDi6nJXi54mMesM
         xw0ef2N5HMcilJZoVFkb83BNXd2Zxy6sQk+n43udhUphSkKuhAdvUYVGpAgFC8PmzF7+
         r/1hv7h3NXnyYni/kKRcZZuZ+8QPTLvzTh5H6T0ip7vafU+iZ2NaZXCN6ELI9jCRZfAz
         w8vdSkVKkLfzJuLxK3lpQQsafl3b3hT3OPoxWQAaEVW9X2JrcBuLV2r7E/GmTdn5sC1c
         XcpM1kXGUy47W6PSyShLNDw6iNKvNbLaEBS4TMRmC+STytB95oPlop8N3X9k5cdDnfOC
         eHgw==
X-Forwarded-Encrypted: i=1; AJvYcCUws8TlIa5G5RlGl2VAqNkoJKcPzI49jEC61DNwS5jbgTr6MyuTybiqFqA30JXS73a3ySIZqVN0rBWVE8d8VMXbtGx/qn2azABYpBbv
X-Gm-Message-State: AOJu0Yy0/Y89kdgaOQ06rJYOswlecBJYBCJpNsdc4MNsKqMI/I9sEYJo
	a2iCen+BAPpdHQN1CPwjDqDD+Pz48uGVVbv5slbx9Xf+SWUj7XS8gj616AV552g=
X-Google-Smtp-Source: AGHT+IHwy78cYmNYeVvfhGjPLhIMRbEB6HnpVGkbCUio/Ffr7v+iXHwkKs2oMzYWsj/nY7zb8c1Upg==
X-Received: by 2002:a17:902:ec8c:b0:1dc:cf38:3a77 with SMTP id x12-20020a170902ec8c00b001dccf383a77mr3314598plg.55.1712241917705;
        Thu, 04 Apr 2024 07:45:17 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001dca3a65200sm15555320pll.228.2024.04.04.07.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:45:17 -0700 (PDT)
Date: Thu, 04 Apr 2024 07:45:17 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2024 07:45:14 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: use KERN_INFO in do_trap
In-Reply-To: <mvmcyr5ckit.fsf@suse.de>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
  cuiyunhui@bytedance.com, Bjorn Topel <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: schwab@suse.de
Message-ID: <mhng-44c24766-aac1-4deb-a487-076a4315bd4c@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 06:41:46 PDT (-0700), schwab@suse.de wrote:
> Ping!

Sorry I missed this, I just put it in the queue for the tester.  Unless 
something blows up it should show up soon.

