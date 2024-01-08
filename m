Return-Path: <linux-kernel+bounces-19925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90698276DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF17E1C2098F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B45644E;
	Mon,  8 Jan 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="btZUj6hu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFB55E64
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3aa0321b5so19192715ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704736677; x=1705341477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvMazmgKoWsnbBpLVotpsngL1oQ/K5uRYIxujPwKFyo=;
        b=btZUj6huR1TasDu5KvFVxrCcA5Cm2gdcQ+BiuJOFoeDqAkmyS9e3wtLmI/m8TAxNnG
         jXDZHK0csCiac7llVS6fLWwZAs/tcybxf+ajdert0LvQ4MIWF84kCXeHwLw1pS/3R8ty
         Am3ID93IVSBA8vgb1ou02G3UWIlVd/RRGcVFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736677; x=1705341477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvMazmgKoWsnbBpLVotpsngL1oQ/K5uRYIxujPwKFyo=;
        b=Bnwi1os/44AlyiMTyM0E6RvcELwWyDv34o3ls4Ci+PmgXciH7FEFRId4l/p9O83Hvz
         dF+Z8sPF81fJzeCbWwYSxYv8EmHxCsbSc2Wy3LH+3vKBfdaGTlAsBiTIAIBJgWbT9ad1
         yB3imeZ179Ye9FUp/u/r7oh7YZwVMHLpzmQlp4oI/WXs1UTMDlQORJWEIagtLZCn4hhz
         CeNEde2Si6LTnGp5Cj9d5ZA/wIF/CuHb4Utb+w0HdHTmeB0hxojxitSowfwpEpjfW8w0
         oPFDTZIZKSrn0TSUWpQM7SqqKaVoCn1OvevpqL48/LdWYxUTM/sli348vFlS7qqFuPW/
         DDBg==
X-Gm-Message-State: AOJu0Yy8Vn+ARoKcO3TVIhwnZWKUw4sintZax8LKIgQAswkQ6nyMPxAY
	QWWACapLOOEgIVvppurodNthN6XO73pL
X-Google-Smtp-Source: AGHT+IGwtRPXwmYzpN85L0M4dhNyX8jGEFxMDSCpkMmD+9xGIVhAjN4ikUgXAVStQmAFziY7f1bV8g==
X-Received: by 2002:a17:90a:7566:b0:28c:287b:dd96 with SMTP id q93-20020a17090a756600b0028c287bdd96mr2073284pjk.8.1704736676908;
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090a4f4700b0028c8a4fb12fsm240139pjl.49.2024.01.08.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:57:56 -0800 (PST)
Date: Mon, 8 Jan 2024 09:57:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Jingzi Meng <mengjingzi@iie.ac.cn>
Cc: gregkh@linuxfoundation.org, gpiccoli@igalia.com,
	john.ogness@linutronix.de, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
	senozhatsky@chromium.org, tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Message-ID: <202401080956.7FBE02F54C@keescook>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105062007.26965-1-mengjingzi@iie.ac.cn>

On Fri, Jan 05, 2024 at 02:20:07PM +0800, Jingzi Meng wrote:
> CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
> 2.6.37 (2010-11). For a long time, certain syslog actions required
> CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
> CAP_SYS_ADMIN for more fine-grained control.
> 
> CAP_SYS_ADMIN was once removed but added back for backwards
> compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
> when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
> in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
> (2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
> preserved.
> 
> Now that almost 13 years have passed, the legacy application may have
> had enough time to be updated.

I can't find anything mention this warning in recent times except this:
https://sysdig.com/blog/container-escape-capabilities-falco-detection/
which is mainly an example about how to apply Capabilities, not a
software failure.

> Signed-off-by: Jingzi Meng <mengjingzi@iie.ac.cn>

Reviewed-by: Kees Cook <keescook@chromium.org>

If you can boot a few stock modern distros and verify nothing emits this
warning any more should be sufficient evidence that this can be dropped.

-Kees

-- 
Kees Cook

