Return-Path: <linux-kernel+bounces-48154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73C845808
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6621F27A18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE728664F;
	Thu,  1 Feb 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aI1/fiHr"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2791DFF3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791654; cv=none; b=TnGqbyHItI+ugMdlmaduTMjkgWd3VyBmwPtoqnX/Cs+HNZsEm1mSJG9qiY1qKkwXZQMyaOlNQqjlFc1Zz6OC+C6hpXOi96ZmiGm76B6SWoto8w4NSOwMDnAkhCW/f929qS194tbyY6Qa+Bb6DZSrm4jlhT+Gk6zi3dX1kOeM8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791654; c=relaxed/simple;
	bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDJTA++zf6OvWa+I3plPcCxXRpnhva95BFMz9AwDVPaVeIluDWIr6k7wUnsjv/+PcfcbwAenu/qMhy/9cKUEBiR1ZiL5D4JGBMZb8OlZq9N//j72dDaSepgS0crSSMxGeAa1xpMCbQpBcP4hn3NxnaNNVwg2A27FC7SKuwdMkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aI1/fiHr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33aef64f702so507199f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706791650; x=1707396450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
        b=aI1/fiHr6NErtr0KIAfc5sKxYgbxdGCNb05/KAC6/UbWsuUxsWYLM0XNT90TQLTm54
         CEkw32xscbGCB2SaZfxUr5AoGLoETQL/VDk9FyzDYszmn3UN0FWOW32yEMsZJzE7intX
         e28UwOGOi/aVK9gL6i+0hkBHokLASqE8fzpCA8r7vrg7iyG9906kdnYLymmQJu7KptJQ
         0m85+kIfrDt1ZGbMcfs0zB8/2yXWv++Prz1Y1dti5xanRSQxPmjcpUE5bqckoj8kOUT2
         OOvakqwgHqLG4e+zZXNX4WvHv8JtAaouY52gpSODD1FvUIKuLGb30ltSzQ7Q0sGEuElD
         ctrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791650; x=1707396450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
        b=qiuA3OtbNJLJo64xqcnGciCwyD0fOX8fiSOGFAvNzg1O2uF0ZeujMr/FnArtd290Sk
         WD6b6blEQyAFSy78OUhSoqZOauMOZLPvf5+bjMDVpitXZL+uLFBgl7gD3C9an8HUaw/i
         2Siusy0EkZn6cbCx6W8kpyHTDy6xSS61A2SgdohcESHORfrXA6CAgq6yfX0cHrKY272X
         N9bY6mZ1Xmy1MAOMQSftKCn7Qm8IAair2C4wrRLq13QDAgn1PHJIBi6Dn2ZfSKzD4gKY
         4bTqbP246ZD0Ck252mYp7JLKJgyYuCJiEUgtfEu1VKLRZzXXU5orlV/yQAFUR1D9iKne
         c28Q==
X-Gm-Message-State: AOJu0YzjMGCMToCKuKmr+ikRdSY/JjuMWbbc/gsOhjb/X8Zx5xKF3tcM
	esbiW5oMS9N7GDVnH+V0tKB4Z5H2kYkdFC0Y1qx3agRjgZZUZAN0kabjI59BKFQ=
X-Google-Smtp-Source: AGHT+IFBQDMjB9QaO2zF8XjHM829y8wQFGbOhiy7LTTNAI0oH7do/LOdRbfw60OBh09NOApacPt4Xw==
X-Received: by 2002:adf:ea8f:0:b0:337:c73f:db0f with SMTP id s15-20020adfea8f000000b00337c73fdb0fmr2765113wrm.41.1706791650430;
        Thu, 01 Feb 2024 04:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgoQNbt3yJXfH7E2BOIhJs+AzgLHGcMAQhcPyICRIlMkpiRP+/hBdsENkApsvxCAuI0g5AIskYnAXSr1M3h6H6fYbiWiRNBlZbRHylTt9VQNK2tpJJHRnCrXl6tBMvajWkywnTWDaLOv5ZVbW5CBODV4KYYQbc6m/kUGz6gOGuwkfOY9KyISmHgR7JDeP717oUvPtbwGA+QFhnWQ4XrKEdEMsHeMYtfC4274B92qU33D9O7GF0muyY5+6gGjZD1fk6DHmEGszC0NGSxVi922d6Z0czanKQA4XTc2jexMJOmlkoKjwpTZR5rYWhpKbuIIy5h38SKqC6VkjQyxmk
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cw7-20020a056000090700b0033afcb5b5d2sm6653298wrb.80.2024.02.01.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:47:29 -0800 (PST)
Date: Thu, 1 Feb 2024 13:47:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Simplify the allocation of slab caches
Message-ID: <ZbuS3n8DM4QqoUGg@nanopsycho>
References: <20240201100924.210298-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201100924.210298-1-chentao@kylinos.cn>

Thu, Feb 01, 2024 at 11:09:24AM CET, chentao@kylinos.cn wrote:
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

btw, why don't you bulk these changes into patchsets of 15 patches? Or,
given the low complexicity of the patch, just merge multiple patches
that are changing similar locations togeter.

