Return-Path: <linux-kernel+bounces-21885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0F829607
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6BB1F26EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62C3E49C;
	Wed, 10 Jan 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEhML+gG"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1833C68C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a28fbc49006so100358366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704878112; x=1705482912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22meeCLCLk1sr+ZeBgBSyZzfHRxkkpMLTBZ1RKzMp7A=;
        b=WEhML+gGbJxSrenA9eLRKjZ2KY/fNPoUWSxHR4Y941VVr5FmdKrnEkJhVZxvmFubD/
         OMxvAvEHo/w1xuxRI8nQIYBpalGDHSNnqPsqZ5KDCAbKL6Xo8gJl23yvR6fqRwY0nmru
         JzRUp7GaoulXOt+vdJ8K3NxDyOHa/fZU9mqAlFR/yuAbeFB9Ob1vywbAinI67cKnhDwl
         jA+XtdBKj+BMxMcoxhQKlY0Ht8gYNVivF9nyxH71hrrrB0f85iJRCySX+pkryPRILHCZ
         9zRfiYreNbhhI9NSchkDxB6GfufcwXt24rgUuq8LBSqtWdrHmguTXYJaMZUILcwJvou6
         rbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878112; x=1705482912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22meeCLCLk1sr+ZeBgBSyZzfHRxkkpMLTBZ1RKzMp7A=;
        b=i9aPJTLld0XHz2CH+gJShiCLlJEpUHQYB7DmU7kZQwB2jTPDv66FwTlH1SR0/UQz2u
         /6w6JBfHpn5lNAbmSzMiwU12YKbwvngMjX3OkwUcmUOE388GVaqogdKNpYpCsJkrSd6x
         nj2Slt6U5zewhqUIMg/reVYnnYEAgPpTxz4WvIVZH7lqx0KxGFuCTqBuMNYpQiAPpXzL
         oeStWkn7SU2rO4X+GWaeN+4eQ4Bf9lYRC6I2E06fMJAQEcF3kjHPhLkVfoJ20bVHawGp
         tIO/V9WuHLIGCcA5g7OxRk/4dVIDBVr5EA2j3LnSxl+mzXB9gAmIOj8d/43rGeoNXfxi
         300w==
X-Gm-Message-State: AOJu0YzCN63TftcdE+GqKCyTbL8VnRd7MDrZFwkoGbpWk69CAMEPpiPJ
	fgHUh0F2C5edzsDFAnTs2XQ8rM775eeAx/lqjg==
X-Google-Smtp-Source: AGHT+IHM8JuNl/FzfRgv7kFNtWTX/Dshz79l5nmXtz4XHV7Kd5Q8CYGVBOXDaIntaQbKbitkmYqtlcdcPDY=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:8a0f:76e:1832:6c58])
 (user=nogikh job=sendgmr) by 2002:a17:906:36cf:b0:a28:e1a4:ae3e with SMTP id
 b15-20020a17090636cf00b00a28e1a4ae3emr22935ejc.0.1704878112336; Wed, 10 Jan
 2024 01:15:12 -0800 (PST)
Date: Wed, 10 Jan 2024 10:15:09 +0100
In-Reply-To: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110091509.1155824-1-nogikh@google.com>
Subject: Re: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
From: Aleksandr Nogikh <nogikh@google.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"


> #syz fix: 482d548d bpf: handle fake register spill to stack with
> BPF_ST_MEM instruction

It needs to stay on one line, otherwise only part of the title
is considered.

#syz fix: bpf: handle fake register spill to stack with BPF_ST_MEM instruction

