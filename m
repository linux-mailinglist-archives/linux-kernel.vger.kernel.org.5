Return-Path: <linux-kernel+bounces-146678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CC8A6939
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914E9B2212E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD806128384;
	Tue, 16 Apr 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epqnMqu5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107D127E32;
	Tue, 16 Apr 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265045; cv=none; b=HrDljHWNNHnb5maVc2F9Lzz+zXAq2Fo0t9lsLZzko3kRn+FAAZItf66X/N5IQxhdNA+KB8zia5rZT11fHs33SuRYFTVPY9CUhr/T8zQR9OK8E10KsQ5MLhOI2CHx6tNZPurQ62P0swDOo6KThsbRw0qHEDcm+Uq6Bi1ExJ0JwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265045; c=relaxed/simple;
	bh=Pr3XKvw/T8nKgY4Qt3IAqPH9vO3TLkvytdvxhapkMC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d/tvWQfAG/Hk52KddAj2YTH+xV1bD7dbHb1hcxMY8mzXk7hvIim90t6GFouxNuXz1HoI7gswRDks+xemTb1FeIO76DX0Gb0pfY98lczokRCsQ1uV+4qXy54E2GZnNLwMbVCNhB9eFGvECs0WSkhCE3qyr/sRbrARtvC+T2zWK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epqnMqu5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3f6f03594so27142975ad.0;
        Tue, 16 Apr 2024 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265043; x=1713869843; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VXDS603E6QnBbvZTmX8l+u6lu2qPQ8v//r8g5aNGqw=;
        b=epqnMqu548ppm7J5NecG57wjjPXyDNDwfWlJijm3IyTV95KB/85U7P5jCvG8vgNRSo
         Xe57wmcdvukNmLt7tsBM/cf18REq2z/7sBpKpKnUTAajKSksjRP5DNdiBdliLlWgBZWb
         9a5l5THRv8b0fJwwlu0/IhxPu8gLaTEOjC6krwnljIZkD7Qo0B+mKwFn6n9yUU9szcBn
         TLU18CBBdTuykJk8eifqAtMNLuQY0+pE/qUhnZ8ej0d+vAEKqvSWUEYVqcvr59YYhei6
         BtraeP2VEn1y8K5OAygbBO05ZVjnLInWzwlm7mvvlh5H7O8SD/2k5OKhzNipMKfJhtXv
         d+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265043; x=1713869843;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VXDS603E6QnBbvZTmX8l+u6lu2qPQ8v//r8g5aNGqw=;
        b=O8k8W2HaiFX/7k76gQrvTfuzkot2714SSOWQs30p9xlMUPVWJjyyXXdtVrXEPQUSZ1
         +q+PrEfGGV5hNc2ZbSTyWT7L+OxoyOz5UDvGmOb4QCWsnuSwgo4dLpBHW79mqxaTlYB/
         QhJsd98TBZeTqWv2tJ7XRBaaY4CcC0r8PQUepSWG5QxUf2oF+JnltQdHfOj13+C7oGgQ
         K+e6KJ3XhDMaunBMG7ZbHEpcW7jaF5K5705xT/bChDYRHn8EZd6dulvofh7MjuFf7mGe
         vBW48zyOWOGiHl3o9CUWr0ZnJqEklZAF89fShKuZyNy6rCmkoJIS+UIvM/5y7e1MaaZp
         8sWw==
X-Forwarded-Encrypted: i=1; AJvYcCXVRSBq2g+FkDdoyjzNMkYno7lFWE28mDdo7nj5KlCUjHnOWDCzaqKckcw31atyc44xMxEjufCK06WecjmuCgfwCB5VJ+NB1qI3wSCkcVD9FSv39phVcHS79/DOBXrAU0BuQ7z8vJYF6HkD
X-Gm-Message-State: AOJu0Ywe7GOiSZVqrIE5+S6d2eOlJM2Y1J2THhrcXFk67h/clSkjZwfE
	1DW4JfjUpgKIG7jJ/GEGjYmoA1czFTtnSVeKEuo8qb2GL/tl6fD8
X-Google-Smtp-Source: AGHT+IE1A/vbwCbQxMqZHoJB6Gv3RB15XeUD29GG/LSbjCtdkgaYEee5EWgNH8xi9EV3b7I1raatEQ==
X-Received: by 2002:a17:902:f688:b0:1e2:6165:8086 with SMTP id l8-20020a170902f68800b001e261658086mr13034573plg.61.1713265043211;
        Tue, 16 Apr 2024 03:57:23 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001e294f2f30dsm9481532plg.93.2024.04.16.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:57:22 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:57:19 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>,
	syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com
Subject: tty: n_gsm: race condition in gsmld_ioctl
Message-ID: <Zh5Zj35zeobGGzKj@libra05>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

memory leak in gsmld_ioctl was reported by syzbot, and this issue seems to be
raised from race condition involving gsm->dlci[addr].

https://syzkaller.appspot.com/bug?extid=6e3e8f30f269f5028e5d

When dlci object is checked and initialized in gsmld_ioctl(), it may be 
assigned multiple times because there is no lock which guards entering 
the critical section in gsm_dlci_alloc() from multiple threads.

For example, when multiple ioctl() are called concurrently, the following 
scenario is possible:

Thread 0                                Thread 1
ioctl(GSMIOC_SETCONF_DLCI)              ioctl(GSMIOC_GETCONF_DLCI)

gsmld_ioctl():                          gsmld_ioctl():
  dlci = gsm->dlci[addr];
                                          dlci = gsm->dlci[addr];
  if (!dlci) {
    gsm_dlci_alloc(gsm, addr):
      ...
      gsm->dlci[addr] = dlci;
                                          if (!dlci) {
                                            gsm_dlci_alloc(gsm, addr):
                                              ...
                                              // overwritten & memory leak
                                              gsm->dlci[addr] = dlci; 


We think either (1) gsm_dlci_alloc() should hold a lock(mutex) and do
internal check about whether gsm->dlci[addr] is NUll or not, OR 
(2) all callers of gsm_dlci_alloc() should hold gsm->mutex and check 
whether gsm->dlci[addr] is NUll or not (like gsmtty_install()).

Could you check this? If it makes sense, we will write a patch following
one of the suggestions.

Best Regards,
Yewon Choi

