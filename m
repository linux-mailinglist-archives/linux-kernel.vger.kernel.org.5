Return-Path: <linux-kernel+bounces-146806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BB8A6B41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA5A1F21BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181A811F1;
	Tue, 16 Apr 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+dQy6WK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A24128398
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271137; cv=none; b=MdyIuHDJH1kjheKN2pNlI+gzQNdLb6l/M8WE6e8QPNsVzbqw2F2U99FeGuRdptng5IlCN5kCYSKDolvjgYXBYKLHueRNsEcjeXGvhZziyLrWdoKGu8zHdw6oWq2pqegTMhTvlG/ep+/ig/kgwU2HILNh69abrcWBcaDD6t80R1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271137; c=relaxed/simple;
	bh=RmzZf7KFhcOYGC2I6q3cNiiYlOfQWLYJ71vx42JQWRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP3FD+iCsCUqdOQlj5w/rZJ/oh5X297ZcAVUxFNnFFKzEVFkp53oQzKXLltdYJQKGDLLsIl0uMJPKG61pbA94oaNazWgmqwjO65QNrbbUbNC2ReJsEDIL+F+2Zxb/wlOwtS5JTzyig7DS66rPGz/VZeikH2DTXLAEbpasndUvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+dQy6WK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so482749266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713271134; x=1713875934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmaZPsA5/bY9fp2hcNvKXfbEk2+XWrkUqrlml8f+fjg=;
        b=R+dQy6WKwUESmMnwaQ3RaKdMz1AG7eVronYUMC0b+WL9pEyXjlai4dcAVwi8N+7mnD
         AWcXq5HVUIqneMJCrI/UT+pLUPelqBoJP2bLd4WyASFDqYOHxICr0TopYwHP0qyCF8on
         BYzxIge7T4txf+ZIcN+LWqCHPNJ1IjjEgD5Vf8fu97ME6Tf+62m1enTmOn5tNTTB3oXk
         Rg7i5m6mQnJQp8iamE64/Teg9GI+YeE7FZ5/5Nd492DP84qwB0N2HzkgzO2ey53Dtcwe
         nBLsAe0sADf+AMjOOwCCuCjHDCA+NLhgoVTzu6pWvJ1zvi7zJxwSU+lJ5QlZJXeMiLAy
         fPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271134; x=1713875934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmaZPsA5/bY9fp2hcNvKXfbEk2+XWrkUqrlml8f+fjg=;
        b=YewidJbfPygt1hLb5D8vmEIFir6ZpJBm2P74g/kFt7b+3e0xLCbuvc5bzYqYPWIZsJ
         vqaJDJ68Ihrvec4755YpnEcQoYq8aoyt/46g3GSCT+i8UZ9fxeb0a5DuXK6J7bQCe3kM
         n9TCVkRvP0Unt1Dln66Sofm3u2GRLiRdjnQxiJIbV0xC5gpPhTWna2/52MgkCm1sGn5V
         YKf8ART+5vTbl7pdE7cxBXWjHfBy+lXnUH31dbtFGoNRxmdeTK7RWCGJ23omhKGf9xIh
         882acN2OKvwOppQT68M613qfkuJUuuuRQLrH1qyokLxRckUrjmPddjpmxT3bGjP07zGt
         4O2g==
X-Forwarded-Encrypted: i=1; AJvYcCVlLTaLfyJ0ig2MJCD5t3sjvJNDOjjb+SKXaQq9rnvjSRnEXcUqhzrWEN84y8xWH35Z06ltJNHFW7cc+3s4HUBn3OeU98ZLqPD2LJcD
X-Gm-Message-State: AOJu0Yx3cOq+mljNNKpsAJQuLvCSIg7BPSKvt0ZR201ylWXjcPg4yl5X
	K2fXPfpSg6snA8rPI3RESkGmkWBIuvbtVVbW84LWKcsMUTaR5YyNKfXD4hTL4LY=
X-Google-Smtp-Source: AGHT+IGz3VKYK2E3xDM7FfRYh+Y9LTHdgWe5Ey7fM49QWy+hpmVdcxxwvu7Ke0VgRiRjbYE8DUnyXg==
X-Received: by 2002:a17:907:9496:b0:a52:30d3:41dd with SMTP id dm22-20020a170907949600b00a5230d341ddmr11072034ejc.41.1713271134447;
        Tue, 16 Apr 2024 05:38:54 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dm18-20020a170907949200b00a51983e6190sm6766884ejc.205.2024.04.16.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:38:53 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:38:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging : ks7010 ks_wlan_net : Fixed Unnecessary
 Paranthesis, Prefer Fallthrough and Line spacing issue.
Message-ID: <c45387e6-1af7-40d9-a2f5-5cc174154485@moroto.mountain>
References: <20240416115903.92706-1-karansanghvi98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416115903.92706-1-karansanghvi98@gmail.com>

On Tue, Apr 16, 2024 at 05:29:03PM +0530, Karan Sanghavi wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Greg likes parentheses so leave those alone.  The other changes are
wrong and also break the build.

regards,
dan carpenter


