Return-Path: <linux-kernel+bounces-13384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197E9820449
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682FDB2133D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997823CF;
	Sat, 30 Dec 2023 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2uIiWPp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228E1FAF;
	Sat, 30 Dec 2023 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso4845281a91.1;
        Sat, 30 Dec 2023 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703931039; x=1704535839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUwoHcWCWeNwaua/GlD5vIC8+pco3z2IDUy7BqEvQuc=;
        b=K2uIiWPphOVeChtZ6d8ncj9rdRIXzfUbqi3AuoPAhuMV3gc+gbvAkuHSs4gmoCsSC3
         FHHrSoWhsLISzu3SEulflY26NtpMDhFD8JsP/1ZpQf39M326f/EAidQRlcT9srhy8NX2
         xfyv4rNTso8S8aC472qSkL8+JgqCjt/WXtVpMIpNj8fGX/dYzqqeCdkYPDbj9c+n6QRD
         9J0diDeCt58MSApXSsvZLGKIw5JR35bwqjnuhb2nsq9ScsQTQPFPMLWM0VaFj5GYYyeF
         MxsAxa93V8dR90vRCP6K4iYEmBDWuKep51ZWGNrExpxAi4rCwDbeNtiuFihjxLZ5/l2E
         sVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703931039; x=1704535839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUwoHcWCWeNwaua/GlD5vIC8+pco3z2IDUy7BqEvQuc=;
        b=QKGoq46mWgqiHgtaL+lYuuLE0Ui0m2fO6YAH//P6lI7xoQK8V7U2YMCPFakmD8ZTrr
         WYpklEz6JvsVnACUAU4ZYeDXIcvS/uPKTFf9FzExk2Kh8cMN9ayL3b8f8ERpzslmGrGe
         BS9YBbG9CYF8BLKsPN+9wont/Gn0oWqBoNv8QCZ14Zj0WxOHoZwBA2Y7zY46m/iT6ZXV
         qmzse8XLChnVMYFCwjLUG0BfbsTVdE4dPWa5y0wp4SroXUrh5NcaIn4LB6d1OZi1nPDW
         CKjXS+UWVPbvQfekQ/aAYyDdOQtaJ2T9pRUDqMVE6kHG/IckysgXDzBfoa2sbaswjUOs
         RfCA==
X-Gm-Message-State: AOJu0YyHKmrOX2Cvj7kLWhtXuZOurMvPoQbhOKemlJrt8LXmcbvrElKX
	u2F/jDjWlRYMZVhoB4Y1+C8=
X-Google-Smtp-Source: AGHT+IG6AQ7NkttmEt+vKSAtKtO4REhFtyapg0WY7cxINl846hNcIzMUUlHk84tKE6tmQ3nMDwZbFA==
X-Received: by 2002:a17:902:e549:b0:1d4:48ab:a83 with SMTP id n9-20020a170902e54900b001d448ab0a83mr10017701plf.71.1703931039106;
        Sat, 30 Dec 2023 02:10:39 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:23b7:4d83:3222:c5dd])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001c71ec1866fsm9751639plz.258.2023.12.30.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 02:10:35 -0800 (PST)
From: amazingfate <liujianfeng1994@gmail.com>
To: knaerzche@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v2 0/3] Add hantro g1 video decoder support for RK3588
Date: Sat, 30 Dec 2023 18:09:30 +0800
Message-Id: <20231230100930.3740439-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <35df6456-2bc2-415d-bc61-09e4b440e2ac@gmail.com>
References: <35df6456-2bc2-415d-bc61-09e4b440e2ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On Sat, 30 Dec 2023 10:46:42 +0100, Alex Bee <knaerzche@gmail.com> wrote:
>if the RK3568 and RK3588 variants match, patch [1/3] is not necessary. Just
>document a additional compatible in a similar way it's being done for
>rk3188/rk3066 or rk3228/rk3399.
>If there are ever differences we don't know about yet, a additional variant
>can still be added in the driver.

Hi Alex,
I did try to not touching hantro driver code and just enabling the node in
devicetree by a compatible property like:
compatible = "rockchip,rk3588-vpu", "rockchip,rk3568-vpu";
but the hantro g1 node is not binded by hantro driver. I guess that is
because hantro driver is already binded to the hantro av1 vpu on rk3588,
so I added patch[1/3] to make it work.

Jianfeng

