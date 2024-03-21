Return-Path: <linux-kernel+bounces-109661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC5881C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E75282D03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9F381AA;
	Thu, 21 Mar 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGYuGR/K"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E13AC2B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999703; cv=none; b=G/B9zDtiJqQqjWPLekqkfs1RahXSsdVk3iMbjGGlajac2UcClfi1Ebcf9vY9soSCx5YVJrbh6zJEtixDcBHxb9aUyaZiZZq+JAc0W2ijDUUewp9nij2usvDsz0wZNB7M+8dfRegUL+gK9L/3iu1Cd6Uve5bFYX/AucjGvKsnf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999703; c=relaxed/simple;
	bh=sLCJ5w7ZjIc5OwI8r6fw90adJAwfvrKs/3vsEHc06vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alG/XVPB5HGw63+d32RMfbl7vDGJWAnYPHTt2uB82GFUnUPg7jYSmq9EKgtk2XSK5RJfzF46pT9ih4q0GTdkxjp2E8gw/pUasXGAGn26ovEE5vcOWYfoBc3Z7TieKYHtCAkDUeYxEsEbqDlJmieX7V/pn/wYwCpLLR+pTPNLu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGYuGR/K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41462295004so4386985e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710999699; x=1711604499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm+dDDn/qjmssizpNHCqnR6eRhc+Lz6SbwtuAIJ0yjA=;
        b=NGYuGR/Kti50Mc0lathcf0N6IcRQM03sKHvQYt6ENoNUZdv1GLqSkhfqFHKBK8p71O
         T1hYI21l++lUobPtPJzwkwAOt5X83AkTzSDf6EGFQdzS2C4apaqpJ8bcVxUAEafuQwTD
         ghjfPAhoHGDSUqQL94H9CB+9OGWyDSUj/CCWa0gvOn4+gay9nsjzSzuYDoJW6bK6XKj3
         G8lK7OV6BMrMRYrPehLwOLPbrbrjPp+4WoE7dDUJG19G6REZj0k/BfKNLmiCbTELewsR
         MjJhJFrvj1sxtYHZIYlPyWh/DfQAq/KnCaBbDtb+o2+0BSSy5kqMH+ennDL81KpQHke2
         p2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710999699; x=1711604499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm+dDDn/qjmssizpNHCqnR6eRhc+Lz6SbwtuAIJ0yjA=;
        b=D8Cux0musUgseGjOutlKzvbGxTqSTlByb5BPsK7zUQp0z/S9L7CApl+XkDpM44ySTl
         ix0EeWvTkhLo6tgREiZ5FQL85Py5hR1wx+ussewULVnCYJEBDbY0uSsFiwv81l+uDToF
         305KQcu7yzFMKmQMqltdV9hwEGBBL0qgoNQ4sPFD49aIJoFK/0aCngvEdSNLjQPYgY+6
         ZMajO3iAuqe294nFGNwL+45HrrTEvm2RWismX3MbsKzpj9PALrCyrW4okf48zvMW5UVk
         JXrc2a0iEr9PZ4zoqTLprLvR5LI/FXHWswGaurQsaBivqhyT6NU9Ui6PitefoC5gh46f
         GJCg==
X-Forwarded-Encrypted: i=1; AJvYcCVw0Zci46qVbTGSncR9/QsMOzm3YfZU17BUQO48HOy4f6kdZAxS63tdypOHzIaHKpvW8G4vodbknA6LoNQqzMTjwWt8GHdWvbOvD8/Z
X-Gm-Message-State: AOJu0YyXlBWbr8sTeb0dqqkv+SsQQv8p0hsrim0VnxM/BwEKgqSWtgS3
	rb6zNk2RJ65D3MPV8bFy2BuBAJTMRmuowwne5nhFUotgNcCgFTbdbheyWQDCido=
X-Google-Smtp-Source: AGHT+IFDFiJPls7HzGZtyNHBa42C+coG8tOL6Rb1hcMWDpZDq0e6ExNBc1UHVkYbAtN2t7TZXly4Yg==
X-Received: by 2002:a05:600c:310a:b0:413:ca0:5cd1 with SMTP id g10-20020a05600c310a00b004130ca05cd1mr488156wmo.39.1710999698539;
        Wed, 20 Mar 2024 22:41:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fm22-20020a05600c0c1600b004147266a37dsm1370015wmb.30.2024.03.20.22.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 22:41:38 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:41:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <51797d72-056b-4762-a328-1d968803b931@moroto.mountain>
References: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
 <20240320180943.3683-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180943.3683-1-chandrapratap3519@gmail.com>

On Wed, Mar 20, 2024 at 11:39:43PM +0530, Chandra Pratap wrote:
> Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
> with '(*opt != '\0')' to adhere to the coding standards.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
> Changes in v2:
>   - Update the commit message to reflect the changes better
>   - replace (*opt) with (*opt != '\0')
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



