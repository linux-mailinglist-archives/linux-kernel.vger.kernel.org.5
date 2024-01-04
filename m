Return-Path: <linux-kernel+bounces-17161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00382490F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC020283053
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05B2C699;
	Thu,  4 Jan 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmxmPyaI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307E2C682
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d9ba60e1c1so809612b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704396786; x=1705001586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdXwbs9LXy+0MwagLGqoXAsQZtAQ7ijReYfWL3XfMTU=;
        b=lmxmPyaI5554Bl4f4QQqr3TMDj9uuRhbxV8espjfnIKHAglZqV8CxtK5CmfGhCpCLn
         JxRC0bdpWOKsR9Kf4GK/dGqu6yS/VEaY7JcFEzAzLU6bWnry8pl/YC2NG/V64I8tSncj
         +1Z9/9d4m+7VH+/sRuZYsdW5j6ChARLkm97VZjkcobG+006Qi223fiOhdQQSr2CFurTa
         h/zmo1iuJiUhhvTOK69XmnQa3+E8aDDc1YKgj4oC+Rddj9InSYfEOkYH9zYgEVXAMe3T
         1dPYRv9RxeRcYxFTAP04XLw5fIkBS1mSvaqclnCxQUuNWWQBhdUptdgdsSFAwyv501cs
         x59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396786; x=1705001586;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdXwbs9LXy+0MwagLGqoXAsQZtAQ7ijReYfWL3XfMTU=;
        b=wLUFfnyWh1Ge4Y/RRdWAWfZagHJO+o98T2yoAhlqf21oy8MEhMoRpkleCxH7UARWUM
         O2DqHmJLb0UHU0U1a63g0ATooo4dvQNB1T4deHQdcpaZt3Z9XBD1JRSZZNvwdF7fkrU0
         WNpyerH/otw1yDKa9JEYlWgnzBbdvMwVITS9nXkDwfJN1s4qj6/e6g8Mc02Fdir/uRbb
         GROwP56Fd1gzdSvt9eDbOeetSoKmxgsACan/P8EUI715AacZJoM4c+gvyk3Yp1MSxJk2
         983S7lNNFIDT9n7/GRrnnCRmThAsrQCHxkHYy7qgo4oYnvs1woK+770GQgZzzLhfddvW
         pgYw==
X-Gm-Message-State: AOJu0YywQPCDIug9FBxL8fYhMuXFg2KJpuvLSeZMjV9g8UoaHYYmrGMn
	bEI1W74Hd5danVYrFjdEydDIezFwvQlFOPfuSw==
X-Google-Smtp-Source: AGHT+IEu1onX8LGcKX/vA29+4J8xdamwvAFAYUdMez94XtQ6ie+K8ekr1Fj7zrHbjaYkcovO3R0Ck2EX6HU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:390b:b0:6da:86e5:1645 with SMTP id
 fh11-20020a056a00390b00b006da86e51645mr141573pfb.6.1704396786344; Thu, 04 Jan
 2024 11:33:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Jan 2024 11:32:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104193303.3175844-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests for 6.8
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Pull requests for 6.8.  My apologies for not getting some of these sent earlier.
Between travel, time off, and end-of-year reviews, December was a bit of a
disaster.

  [GIT PULL] KVM: non-x86 changes for 6.8
  [GIT PULL] KVM: x86: Hyper-V changes for 6.8
  [GIT PULL] KVM: x86: LAM support for 6.8
  [GIT PULL] KVM: x86: Misc changes for 6.8
  [GIT PULL] KVM: x86: MMU changes for 6.8
  [GIT PULL] KVM: x86: PMU changes for 6.8
  [GIT PULL] KVM: x86: SVM changes for 6.8
  [GIT PULL] KVM: x86: Xen change for 6.8

