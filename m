Return-Path: <linux-kernel+bounces-22854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508A82A401
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0EF1F2350E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3234EB40;
	Wed, 10 Jan 2024 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di8EUN5x"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CC3FB3D;
	Wed, 10 Jan 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5582796b85bso1904842a12.2;
        Wed, 10 Jan 2024 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704926077; x=1705530877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amcLJqpm9QgZcs/rA3fHaBICgItRkDbfb+YSi8eii8Y=;
        b=di8EUN5xGpXQM9TeXLhjsRKaXAVeJLwTsyIiIviHtWX+FUU1R3Q8gtm9qf9oNAenZa
         Bz05gXi48AxC1WhDufga9gxuL2SVBonnd9EWc6Q1/JUfdaZgt81tlsAoX5McEWVTLjK7
         5V8cwgnkVYcmBwgiwZgZUU8zhyHvw+VLpS3l8/NqMuVpBC8/DWTAgS79ffn3TgIGmx0x
         gWWK8+eS1HcpLPn4B0jH0dcpG9NisylDvB91MgWiX0RD99Nua6vB2yv94MLcO2va80Uu
         cUX4Tld393REhHgLsKhwHWmsbM3G5FS8q2vwmSlZQtZR6DiJ+T63KXLHXU9soeT9VSYA
         zbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926077; x=1705530877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amcLJqpm9QgZcs/rA3fHaBICgItRkDbfb+YSi8eii8Y=;
        b=YHCEJCYD8kdBO+oryh8eVTetdXimh5WivRx4VrPW4WzG787k4YpOqDebR7HGJdLR29
         WClWIIAiaYRpXYnFQ5o9yXtRA8RT+qsSAInwaeysyZ1H9tVRSaXkYe/bU0WKz7oyXhU2
         eg2sLMaFAPmNjVsBwfbZS1eYLWbsUXlSnB1AKzQ9PYsOyeRWZTL0DoH240O4fZEO6vJV
         GE5alOt0d9OP9F9wrohxcDD607p/FAfADz/XSTqQT41DLScr07TjNF5HiNdAzXdpscKx
         tcy8qeu7EXI+1zK6vILIvgnTxEPU4XO36wluKfGeBwa1lox/NAIeQqVxptPwOnvmLP5J
         lchw==
X-Gm-Message-State: AOJu0YxVGqr7mboj+nLFg8nwXA8niUbAm2Izufjr799fiOPG+zVoPfte
	p/ujIr1IbaSknboAcyZ1DhP7mwTRLaYAmQ==
X-Google-Smtp-Source: AGHT+IEtgolnaN71uAvu7gHsKkVAwem27SKnfOVHefMhJhoKWSuu6zzvffBkF/WaXMgWqgu7v8lEoQ==
X-Received: by 2002:a17:906:1e:b0:a25:1acc:ff45 with SMTP id 30-20020a170906001e00b00a251accff45mr115159eja.143.1704926077219;
        Wed, 10 Jan 2024 14:34:37 -0800 (PST)
Received: from andrea ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id kt10-20020a170906aaca00b00a27a6d59045sm2493815ejb.217.2024.01.10.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:34:36 -0800 (PST)
Date: Wed, 10 Jan 2024 23:34:32 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: paul.walmsley@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	mmaas@google.com, Hans Boehm <hboehm@google.com>,
	striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing
 command
Message-ID: <ZZ8beGSPHBOXl2Sq@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
 <add243df-47ea-4956-99c5-7bcf19dd2679@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add243df-47ea-4956-99c5-7bcf19dd2679@app.fastmail.com>

Hi Stefan,


> "core serialization" is a meaningless sequence of words for RISC-V users,

The expression is inherited from MEMBARRIER(2).  Quoting from the RFC
discussion (cf. [3] in the cover letter),

  "RISC-V does not have "core serializing instructions", meaning
  that there is no occurence of such a term in the RISC-V ISA. The
  discussion and git history about the SYNC_CORE command suggested
  the implementation below: a FENCE.I instruction [...]"


> The feature seems useful, but it should document what it does using
> terminology actually used in the RISC-V specifications.

In _current RISC-V parlance, it's pretty clear: we are doing FENCE.I.
As Palmer and others mentioned in the RFC, there're proposals for ISA
extensions aiming to "replace" FENCE.I, but those are still WIP. (*)

  Andrea

(*) https://github.com/riscv/riscv-j-extension

