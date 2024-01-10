Return-Path: <linux-kernel+bounces-17901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166C8254CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A27C1F22964
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1092D78D;
	Fri,  5 Jan 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XhCvbfkz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB32D7A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28d25253d2so172663866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704463419; x=1705068219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3bnN4quUJEriHwirvyf/MlXpTwHAU6a4DSC6ByIGJA=;
        b=XhCvbfkz4xkGtCVUYS6P6SCTByNC1xWYpzXGFzGFRpBiJY+Pxp01VrJsLZE8+u2TA0
         a+9t4jcJXk9DgGBOAcU1a6H3v1y8vkPgQLcOKCZ7JAclZ6ukU2VfhNvvyOv6EmMWwmG8
         n2gluIJRMq5UvWC9yNMyWHCO3p+j5Bf79pvUhKEjtMgdJCivV+ZNc5uEZqus7UeBZ200
         M7716C9exydMONEvTM5F2niNIjfpLDIcR/yFvb6rndu6BG9pJvhoWmhph2Z2CjmWnCrR
         E8+oopJYNv20evry3TRGQMMwSufSykDNXtQkYSh10LoIUCYOqDth7x3Vd+ooxeL0POzT
         /rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704463419; x=1705068219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3bnN4quUJEriHwirvyf/MlXpTwHAU6a4DSC6ByIGJA=;
        b=epXh5ktkd7EB93l+ZL7WjcoNwtHnbzI4aojia01qBYM8C1m3QnkhOLU7NZ7R1A7BLB
         /0r12khZuQr9tBXiHX5eJ6TvTXlH6HGSR6V3hZxh5J9nZUxpQgltV18s6kcPuD1+jNIF
         ytsOAS80ivx9Om5F4JQaOigZw18TobPR4/bwTTPZ6BBJ8TGlAfvE6p6b5ijteDvrCgqQ
         9SMvmjh33cj4NC1D/19jNH90ovw25DZ/B14HUq18w6JJ1AwycVs2TXEVb3F/oTX417aR
         N3R4OSD1h+0DlyMx13llJFZCLC+UCNnypYBGby1cmuydP81Kxu4cv6hU3weRcNithuTn
         d+yw==
X-Gm-Message-State: AOJu0YwBnRxzeQAzfZWzSAXQqzrXgo+6mtWzva2NArnCh941SXGrG7nN
	eet2sbjWF80sRz2fzwTGkArzaczgpabltw==
X-Google-Smtp-Source: AGHT+IH67SLFJ8C5gG4C5TbvF/XM8nwvZHERmu7ffu0wKuatbRuETiCLz0Cl7892rpSm45VScaekzA==
X-Received: by 2002:a17:906:2dcc:b0:a29:18c:8998 with SMTP id h12-20020a1709062dcc00b00a29018c8998mr752587eji.129.1704463418914;
        Fri, 05 Jan 2024 06:03:38 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906178d00b00a28cf49520asm905749eje.203.2024.01.05.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:03:38 -0800 (PST)
Date: Fri, 5 Jan 2024 15:03:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Lukas Hruska <lhruska@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v1 3/5] kbuild/modpost: integrate klp-convert
Message-ID: <ZZgMOA7s0VWsrTLA@alley>
References: <20231106162513.17556-1-lhruska@suse.cz>
 <20231106162513.17556-4-lhruska@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106162513.17556-4-lhruska@suse.cz>

On Mon 2023-11-06 17:25:11, Lukas Hruska wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Update the modpost program so that it does not warn about unresolved
> symbols matching the expected format which will be then resolved by
> klp-convert.

This in only one part.

The main change is that it klp-convert is called for livepatch modules
after the final linking.

I would write something like:

<proposal>
Call klp-convert for the livepatch modules after the final linking.

Also update the modpost tool so that it does not warn about unresolved
symbols matching the expected format which will be then resolved by
klp-convert.
</proposal>

> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Lukas Hruska <lhruska@suse.cz>

Otherwise the code looks good. With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

