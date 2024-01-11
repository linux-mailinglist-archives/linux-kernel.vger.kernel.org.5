Return-Path: <linux-kernel+bounces-24002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AAA82B517
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BDDB221D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADD55764;
	Thu, 11 Jan 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZSPDovLO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07015E9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a27cd5850d6so614727466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705000356; x=1705605156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QzH687SLZ0DeiH1lFH9rSO+vnMHWQfHO7cGTEaKRVY=;
        b=ZSPDovLOBMpX6NjsCFqH6uTY85WgKgVvsEYaEsk3w1y8Kswk+1D20MqoymXmBNKJ6T
         XL2ylqeVOSCBvuYQWu46MLSjOCCxdgKv/uSRy/KhJU9dgYecED5FDE41DH+mEVfyb96E
         3jXm97drxgYYNX6Hz84le8/DMpT5a0RUctrsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000356; x=1705605156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QzH687SLZ0DeiH1lFH9rSO+vnMHWQfHO7cGTEaKRVY=;
        b=JqbhyDRrW1lOnxOVaFMMR8so414h58V1/wlvH2A8eU4BrZvmfIxmVk/t3GfqTGSaDk
         8Jb0ZYq6CdbGV43ONmFPFTUmiTU9IWkJif36aZWKJvxFeKIr0YM4eC/mJzVkgIrEWeUq
         7U3xSmP73tfS8+a9cskH/s/ZiyOkDNMuyE8UxwkLXBlF3rvycMW9FABTCNw7rGmSq5Sm
         RLDysfs3Pd6F/DfQStmX04SVVdgBuFNx4LlNxMGCHIqfdV/eE7AM7WT2oXpJ83V8l69S
         a+4UcXb/UbwhOU8vkqK7tEpcDG7HFEZwv1wbVxb/M26xFB6i9HArLJP7zrNaMRK27sZM
         Gt7Q==
X-Gm-Message-State: AOJu0Yzmk3v8isgRNq6uKOCNTqbXeUGUNug+8RS4LwfD7jGc3Fb3JeVb
	Xa2beN8iA8CkSsRKcEdh79Zvhyj7UhpbGMRttooz8soeKfxwndel
X-Google-Smtp-Source: AGHT+IEYPzjrCPjJQa0lF2fOwbsFCRh38BNozmAeml5C7z6f29HZ9E4vrEVGG1vNigh6mrJrt1pVFQ==
X-Received: by 2002:a17:906:1150:b0:a28:f771:ad06 with SMTP id i16-20020a170906115000b00a28f771ad06mr82215eja.84.1705000356241;
        Thu, 11 Jan 2024 11:12:36 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id pv18-20020a170907209200b00a26af6131e0sm902759ejb.7.2024.01.11.11.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 11:12:34 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a277339dcf4so633482766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:12:34 -0800 (PST)
X-Received: by 2002:a17:906:392:b0:a2c:96e1:77ac with SMTP id
 b18-20020a170906039200b00a2c96e177acmr84710eja.46.1705000354137; Thu, 11 Jan
 2024 11:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183252.GA797@neeraj.linux>
In-Reply-To: <20240111183252.GA797@neeraj.linux>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 11:12:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZdZ+GQBxntccu8FRkY1EzUL60JkcZtS-oQ=5CttZ_Ew@mail.gmail.com>
Message-ID: <CAHk-=wgZdZ+GQBxntccu8FRkY1EzUL60JkcZtS-oQ=5CttZ_Ew@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.8
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, 
	urezki@gmail.com, qiang.zhang1211@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 10:33, Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> Please pull the latest RCU git tree from:
>
>   https://github.com/neeraju/linux.git tags/rcu.release.v6.8

Not pulled yet - I have a big pile to go - but an ack that I got the email.

              Linus

