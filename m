Return-Path: <linux-kernel+bounces-18657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC098260A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8742E1F225A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161F8C12;
	Sat,  6 Jan 2024 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt8kLSNi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8198820
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2045bedb806so546011fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704558935; x=1705163735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz/Di55aeQBffTUgd13EseLNrnnt2s1rAMNRl9hJG0s=;
        b=Pt8kLSNi+Rar4uy6u8yF/jnHe5Zj4DETbwm3Dd5U5BX2/gHn+NRCO9u9iqxmzdOKdt
         b6B1pMIo98t04lfYTaZWBjI4BW8ZTBTvpqzZPdbU+ctkOWrtMpKnOE0Ahh95Y2NRbbsp
         0JNslAC1vNnQQkMbewXequozzmJIzwzIYZcZh94azpU+BfjD4Xigwz/Fk6j4RuW6CZ73
         I9cEzY3AFvNzmaL74wc0nPg0NstgJ6AOi3XvczRDWwLQCJxNnUpH0TMpC4HvcH6q7Daw
         FIFOR59lQtGlh4PI0sDri7nzGqDd59dDgBse27l7OAWIm9sBXfvKD1GF1ePN3LDpRxFq
         1v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704558935; x=1705163735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz/Di55aeQBffTUgd13EseLNrnnt2s1rAMNRl9hJG0s=;
        b=LJoLpEkNoVc3mCzvA7fbwGHArxBcSBUr4EjNP0uwihrrdaY7BxG2xcvtVFzSO6MRWg
         fxSFZCSMpmFFNRtNN3NJOw8dH/PNNkvv3gsBS38nGu848kS7OzfdGYgSYFNXrOCGHmd7
         1u68z1oaGyGuMyRTOkG0jr/Eopts2oKbN6wBBjIlDPfaSiaUuv1ls3WbeTGCQFzLTwaC
         AMiIDJ19yOB59TwVEFx47D4HeHDN5jBmW2vAY43tsUd6QdN5U1PNOd5pLNTsoZzv9FVy
         5gNMtN0MBXT6/0f+da1PzQrE3dk1SXvtS4LJZ1CM30USwVhmhP4YERzkU7cEKuIETVUt
         JIcg==
X-Gm-Message-State: AOJu0YwxHH0SaSHDKPO4sUgXasUMwR4K6YynM3u8IKYnHq2BV8OQMKj2
	y69ow/3GTKd83k7NhfsvCSZo2MiCqtXN
X-Google-Smtp-Source: AGHT+IGg1/bFKA1jzYpuKIirevRWdlpM+F72B+/xTtSyfpfMGxKF5YlnOPGWEcI5ZyN6JrjuXjucwQ==
X-Received: by 2002:a05:6871:814:b0:205:ee93:1875 with SMTP id q20-20020a056871081400b00205ee931875mr1823529oap.73.1704558934798;
        Sat, 06 Jan 2024 08:35:34 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id f33-20020a635561000000b005c6aa4d4a0dsm3171674pgm.45.2024.01.06.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 08:35:34 -0800 (PST)
Date: Sat, 6 Jan 2024 16:35:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tanzir Hasan <tanzirh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nick Desaulniers <nnn@google.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] android: removed duplicate linux/errno
Message-ID: <ZZmBUtX82fE1c47z@google.com>
References: <20240104-removeduperror-v1-1-d170d4b3675a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-removeduperror-v1-1-d170d4b3675a@google.com>

On Thu, Jan 04, 2024 at 07:31:36PM +0000, Tanzir Hasan wrote:
> There are two linux/errno.h inclusions in this file. The second one has
> been removed and the file builds correctly.
> 
> Fixes: 54ffdab82080 ("android: binder: binderfs.c: removed asm-generic/errno-base.h")

I'm not sure that we can I this tag before the patch hits mainline. I
suppose it's ok since char-misc doesn't do forced updates?

Greg, is this fine?

If it is, then:
Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks,
--
Carlos Llamas

