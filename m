Return-Path: <linux-kernel+bounces-19450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2D826D11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2141F22557
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5714A84;
	Mon,  8 Jan 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er1pU6tk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F82575A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso909232a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704714225; x=1705319025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC2//5OPiqLff/6agGmWRFvV0cvFAloK9BgLADmtmcQ=;
        b=Er1pU6tkXGwoog9bFYrTo0MWPqylQvCaZkcrLCycmDZgHspeKnhSnj4auaU+RlKYGx
         oCDPHX4UDD2LmVAO+GibHxzZXrj90CMT1Uh/n/ZjYJlRkQDndybup+4/v9Ku4BwgAYQv
         WZSkz7W6FgqjlxjdRzH1Wf5kFRECu0zbecYMqJgR+3zLcrcMlxHZS6gOm+NbfFB9l/ws
         meGeujzBBgUEqOnCr00LQPOapLA4zLhx7lo6HqwAmD6RWyDfB1dl8K5R75QRFQn6dj0N
         1MO56qWyZjLwhVk6riHpB4re3PtZ7n0yEzxIwQFpPutberPdOzYU8/xPbqnM3zReynqm
         A13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704714225; x=1705319025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC2//5OPiqLff/6agGmWRFvV0cvFAloK9BgLADmtmcQ=;
        b=wI0kQ+gERIyqiV3tsRnW/o5bDJER5UReXEArpHyT9JcF7VWFUaZMbVnEtmjHCuxpY3
         d9IfjRiveXeTifZ2l6yyk2GHrQiR8usUs6o6iDZqW/C9+g/5mTQuSpPGPqv1LGtocY2l
         dlgKMeqrCibPmc0b17suAg0Itf9S1Z9yx+EdhEoUGtC8vDzwQUFQPvvQipIR8vOOCuka
         sgDhKZKEN/6CUPqlU9UQQBhFGM3Pftn+l3fkrvf5nU5i+o68DHbO4gqglvHbfJlDTgg5
         CHRuZol6sL4xVktLD4NAuwi4biVVSUwDUXvpold8cIDJdN/2XX0TmSncwtRTQBRQNuoZ
         VTFg==
X-Gm-Message-State: AOJu0YzHTNvOawXlNNPBSifAurQedsRF4NLJG16tESV7OTVTOAUBsjb/
	Dgh5gf0DANpmHHiw/aWuRSU=
X-Google-Smtp-Source: AGHT+IEbMqpIkchJBDCtJH4F2b9CyF8v3OJXlHhHzhM/fNBhpNkxCCevusNcFn+PzXG1eHK+UFpNHQ==
X-Received: by 2002:a17:906:f20d:b0:a23:6b6e:22e with SMTP id gt13-20020a170906f20d00b00a236b6e022emr676875ejb.80.1704714220035;
        Mon, 08 Jan 2024 03:43:40 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906199000b00a2b1280fbc2sm40611ejd.162.2024.01.08.03.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:43:39 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:43:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT PULL] IRQ subsystem changes for v6.8
Message-ID: <ZZvf6ck/fO3NUXPN@gmail.com>
References: <ZZvLCmUqAriMV/Va@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZvLCmUqAriMV/Va@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest irq/core git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-01-08

>  .../bindings/interrupt-controller/qcom,mpm.yaml    |  52 ++++++----

Forgot to mention that there's a merge conflict with your tree here, 
between this new commit that restructures the MPM device-tree bindings:

  ca596295f4c9 dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle

... and this recent upstream commit that extended the bindings:

  c0a2755aced9 dt-bindings: interrupt-controller: Allow #power-domain-cells

My resolution was:

        mpm: interrupt-controller {
            compatible = "qcom,mpm";
            qcom,rpm-msg-ram = <&apss_mpm>;
            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
            mboxes = <&apcs_glb 1>;
            interrupt-controller;
            #interrupt-cells = <2>;
            interrupt-parent = <&intc>;
            qcom,mpm-pin-count = <96>;
            qcom,mpm-pin-map = <2 275>,
                               <5 296>,
                               <12 422>,
                               <24 79>,
                               <86 183>,
                               <91 260>;
            #power-domain-cells = <0>;
        };

But I didn't/couldn't test it. No complaints from linux-next testing so 
far, FWIW.

Thanks,

	Ingo

