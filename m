Return-Path: <linux-kernel+bounces-89130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6E86EAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D0B1F22448
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA456B74;
	Fri,  1 Mar 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CauThr/s"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438E5677D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327065; cv=none; b=srI/qBIjsAaZolp/paFx/84pRU3qrlQoCRsl4Fu9yJ/ZVX7dDBEDRWMedJdghlWx9zRx1/H9nZvZiIySkEZaWsJ49CQND3UxbdeWrUyEA8SfHcwo95jNzM0/z3zenbQ7APlzQ0jIVwhDMCurXqdRk20dtcJ0Yy/tfOLoU+H+m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327065; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=NLeYrgPOLgOnAHl8EYvfsSMxJVTTqq09iXzVFva8btzgBHKaWV998fT5lHoD+PMXwNAnZz0GKaPl9migSXJGdftUTJwVtq6UP+Vd2P+leuQeFmFoGGlLKyq4De3b0nr9YzaGPo3V9riyNd5cutUefqK1LpN3p9D+gOoLwNxU110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CauThr/s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca8b86ee7so24750745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709327064; x=1709931864; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=CauThr/sIXva4Sh6vYkpd0hv1nelkZu1O3CXKpG7g6EQguj28qpWW4VDjEGo55fqJw
         6kbYp/5C8KU344iz9vyMpiRE7rwPc+TkSWjQDxN7phZkx9gV2iw2oubLuQo21uiZBrwT
         SRIGj1gAfPNdywp8NQuyE6ZqpASKJQSbMQ2r5NrtNqzCrrVhrZU3/pvsLYhud3xnrCHc
         f5dCBCBEN5gGnzhckOMwRiiomwzSHMMVwErE17DbGgG4HtB9BB0CcYUaFkW3RiVUgc5e
         gwb9XncthiL9hkojd+hgv/QUN2uDCgal0aprIvCK1TwEomOuYIkyXeCUoXL2HWw5RtWE
         FVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327064; x=1709931864;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=qB+siX6r0G4spWSokLQxfWd7RUN+nbQNYZdzZc8kJQC9Dj1UwmAs0UUEUObuOFAbMP
         N3aaAXDUOC+EeTMVVvlBwCG/Y8rZKb2La2qLRsg3Kw31OEAGAzINklmxWz0AQQzV0Nwa
         RUu2a+DC9jgzIWA3gNN29RH5TZkUbNWDQgmsHMTAHOSxc3JGS+hoIdQyvax86c73REHp
         BuFCJ2QOqeJEeKM26KFal0UNqw6EDLTjLaEMxYOPqxXHPpmEt/OT51YKkRltxX8TRaNu
         rBdKowpTQjWZJn8HZXy4WyhRs5DSYwEfJu8FTyDFAA+s/sleqR1Ueg10yMD2JtqFYLKr
         icfg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBetd+8X1Yca8B9nXSlE5V+m3MbvrvRkp0rUxNyrx8v4gPOltTddPb19IJEU2cnrI0ok0gH/cgRbGJ/y799aLC6iEgok8bCis7Tj/
X-Gm-Message-State: AOJu0YwBRbJEaSRFJXM/Yfh7osRRdDVk1pZ5VEweZjmUjoY2bTGQBYS+
	rPA1vPvYoJs0dUKY8evlr/4B2XY0b9x6gZr4AXuY0QFO3fBOzK+h
X-Google-Smtp-Source: AGHT+IF27vILv1vb7bryIBdE28wrASmR/Fbc3vQ0XCORU9LI80+bIrEAUkKKkP4EwLUmjB6GKcHVEw==
X-Received: by 2002:a17:902:fc44:b0:1db:47bb:65d6 with SMTP id me4-20020a170902fc4400b001db47bb65d6mr3367325plb.58.1709327063392;
        Fri, 01 Mar 2024 13:04:23 -0800 (PST)
Received: from smtpclient.apple ([2600:1010:b13d:eccf:a002:a81:f8b0:aa62])
        by smtp.gmail.com with ESMTPSA id kr16-20020a170903081000b001dcc0e239fesm3906511plb.232.2024.03.01.13.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 13:04:23 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Rebecca Stemmler <stemmlersisters@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/asm: Implement local_xchg using CMPXCHG without lock prefix
Date: Fri, 1 Mar 2024 13:04:10 -0800
Message-Id: <D56C6FA3-8E7B-4A8D-BA9D-B331B7B0C6E5@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
 x86@kernel.org
To: ubizjak@gmail.com
X-Mailer: iPhone Mail (21E5195e)


Sent from my iPhone

