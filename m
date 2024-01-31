Return-Path: <linux-kernel+bounces-46137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB417843B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C4828F2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FA67A18;
	Wed, 31 Jan 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EdllPm/8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EAE67745
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693351; cv=none; b=Y6e1y9wU7fN7mSaHTIVPt1v6SV8S5yl6xtftnM8oZTUXPwQG64KUIWaqT8DEMpEaoDYQ8VaZ+vekNDznWSXDJxpfK4kb4+hNrxFMSYi8e3G/G5bbr78lAUb9KjnsQuj89F6+dyBiBVc7WP5LHzw5WK5BI9qHbQfHI285jhpPHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693351; c=relaxed/simple;
	bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+/8gQ1oykOH+HmXnLJCgt/xoKLuZ4FOXKSS3AfsohgZPh/9ab16RwVN0OBMfGWQaFCY8SmYAO6952p1BgVmmBTTMueZ1sEh7r/TndFj9l/RYHmAvOJCNsH2SaDogcYokMfd3/oCjV43gXYMIlr3+kaZqtEcmNv3vMBGfLLl/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EdllPm/8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so50812745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693346; x=1707298146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
        b=EdllPm/8J17oq9R3/crIAnK+8S3WFFRMxVjFdt6D7M7RIg78TNb1PmAPN6x+IJCFGq
         djaPW2JW/C1QV9N/po6BBwHr4AU+srLZJ1zVV5C6vpNgeL6xb/EZgQL7+UcmdnnDPL6S
         mTv1FAOVzqlp9DDwHPQt2Tr0h0ZumW+OEQnqkdu0tjTuYKeWgD+VAzYazRI9pbqvb8iH
         cT3fcbmZzlQLXsd9x7DsEBdi5OuoTMst703u9SY8QUhhUiYH+wyriG9C4HgW3zNxeUP/
         t2IXaKvy/2pSGIaSAgPFHYZIZGID7chf/UzcWKHnAV1DMcSSxfaK7g0Uxc1oqXyOlVR3
         0a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693346; x=1707298146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f43fKUriad8uDoZeZk6V7VP3GUeZsSWr0g2dLquSmNU=;
        b=uaLPBQVGMyH8cMPOqTqnFqYtngOYuX8vedaXKQ6DjzrDNCEjiNevzjqy61lMLKd8Jo
         mrsDDaNPb1U5WyXL1qLv1tAn/2uEHOqPGdUfQ8OLf4zHmKn8cGMPmU8TdKVKJa3Ve8Un
         BBfUxQ/sbSbA65u+bkD6ahRL7YHFmiZqM2dWQ7FL4Kv1qxO8s4Jh1FhssjT7ewPkcqQw
         erUZb2qiQDOv/prYNf3Anek9vDJiqR+d4TUnWxx0qtb9yf7IBljxgPRpcrqLjhn/zvm0
         pJ1D0If6RZFhSlZgoxcucIUlr7TQmaNQy0Sn+SvltVQFYvVtlxIe0enuvWgYm7YLfeUr
         msgg==
X-Gm-Message-State: AOJu0Yxe6u8T+tERnfPG/ckDZ0B7mxkpSv0J9DOkWfoFC3GrB4qXqssc
	KOkZnYly64xNG/UoSe3rZ3Nrk2fY2CBCtitfqNBnMixi1mvtrACQJoFXwVaErBeCl3mbBcJkoG9
	b9vUrPw==
X-Google-Smtp-Source: AGHT+IEY2lXWkefvxzH893aZoC/yJtLJWaibwPImgr2nOy1n6RN5x75B2Avq9gwETOse4c3xNrxmhQ==
X-Received: by 2002:a05:600c:450a:b0:40e:622e:7449 with SMTP id t10-20020a05600c450a00b0040e622e7449mr725550wmo.22.1706693346221;
        Wed, 31 Jan 2024 01:29:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyfO36vqppt50qgUDOESB2a3qrfawNZwydoEBbJCI2JFg2TkSMzceQG+yb8LZPQSoO4kGRBL1+yY176OY4Z/b+KmamlIS3odBxf6UcJ27Hq4EF6aJfpHGtOeLTCZhO9oN2umde/v3UImFWthmDH5Xoiv/XqcV9dmzMTMpWTbBCTMXyBcLltIfas4oEUjKtRDE2aw0UMgmrSbi6inIFA8grw6yf+HLvDwwjXVuWQoYBvVNVwk1TQTw5qq5yNBGoPB+FFX2/9g==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033afe6968bfsm2433573wrg.64.2024.01.31.01.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:29:05 -0800 (PST)
Date: Wed, 31 Jan 2024 10:29:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dccp: Simplify the allocation of slab
 caches in dccp_ackvec_init
Message-ID: <ZboS3wXu7Pan4Szi@nanopsycho>
References: <20240131090851.144229-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131090851.144229-1-chentao@kylinos.cn>

Wed, Jan 31, 2024 at 10:08:51AM CET, chentao@kylinos.cn wrote:
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

