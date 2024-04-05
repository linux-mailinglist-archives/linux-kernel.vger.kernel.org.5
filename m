Return-Path: <linux-kernel+bounces-132479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B1899595
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77931F2218E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85421A19;
	Fri,  5 Apr 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5Qgp4RM"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCC1CFB5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299061; cv=none; b=IGQHjanFKYnY/T9AQpcIstDSMWNj8LPG7RMnti/svPs/zzSe7iO1WTV5yyYlVuuo0YEXnccY911b4y93EIudGqP+VV0vPxooRJkHeP0XhdYhZvAue3VNu0PsqnmOvXLnNt4hvRX+KTxwvqt1XMW3YE8snxDtARbhC4IuYhjIMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299061; c=relaxed/simple;
	bh=bgDz6g1gPJNOWXZ0pJtwEJayVj0AbYJFB6CCr4Jz4Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ5YNAZsQr4c0YkX95IRl2lbNNLuWUkgAIETcrk9qqtQv+20vGIJjrhFnQ5p7d0bGA1XANzmLoOmUeS6eugqvA+Y+DOX1xK8skbJ6T3cJDS7CbX+tJNLNJYHpPSW+VTdn+96AZIMuYNGN0I3ystCpGjlpjhbqOMiVJF9qrHH/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h5Qgp4RM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso2424743a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299058; x=1712903858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XqDAdsVeoyL+xrVeF88k7hXSD8XUa1tRXZUSMSa9TIs=;
        b=h5Qgp4RMFmnEwFIu1c2PT5qattyjWk3WWcsUw4vN/nd+rYC+VuQ+f9BY2h6XR+zFpJ
         F6zkW4N4i7XARwih+9AuUfMwnr9QA1v927uPzKjteuffr9soLcDRsXtiNnbOiWf+22uB
         za7FH1I0AUoQmDWjRKKe2j4S47jzdD3yihbOstyJqW4I9p04nneUaAyV9mJ8Np7gVgCQ
         S4hZYbDuaneJYVvHq2DGb6lCp4FSEal0nzsU6kkNTErTeGjVmkYO+50JPe9nn+0oFhkl
         4KzbkU3YtKnkUK6bW2K4VfV/sPNldphA0wbVHcj1Mf40MWXNsB4LuYzusUREIfxHsl/Y
         Cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299058; x=1712903858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqDAdsVeoyL+xrVeF88k7hXSD8XUa1tRXZUSMSa9TIs=;
        b=SqeloDvRF4QJB/6mxzCgnxhC93ZQXvuF9/MfjdUTtplA6bjPRGCmgS9zMBHzZETBIa
         z9ZS7SaMBFQnYQ+JFaT5asy9gLeDoDHQS0PjeqyNV0+MB7KajemCg2D+q3C9zJPMevbM
         2ZRr6kMWZHZytzBYcJz4opI32qMVUdCPnl9g98omZkXoUMPBeXAzEB/yvd8wqtNYG93G
         v3OmAgPFacryiZSLGInV/Qe/G362oAx2lEhDoyM6CIGL0eeV8X3th47HZJ/DS/JYfGvQ
         4Ulebb/UC0MFGzNtxzmVk0M29BLt5as/Nm8MrwJ5LYpsmtepfhukmsTxW0CBFX27pR8D
         FLvw==
X-Gm-Message-State: AOJu0YyxTsRr8J1tFSYd6Ihs2DB00GQd/ZVDViki91cxAGN099agme18
	AueCXspjnNjKdpVNvMBxGO5ZMYgirEhuBiIxwjhW3XnZ8Yk+K9iyeeWxTxH/KzO/S7MSwSQgemb
	d
X-Google-Smtp-Source: AGHT+IGRBLADwlM/3DSugja9cczPOJ/v278LOwFQQ9RMre415HD7loRF8XDyKXmJQQvheswnKKB18w==
X-Received: by 2002:a50:d599:0:b0:56c:5990:813e with SMTP id v25-20020a50d599000000b0056c5990813emr364888edi.13.1712299058070;
        Thu, 04 Apr 2024 23:37:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b0056e34297cbasm72015edh.80.2024.04.04.23.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:37:37 -0700 (PDT)
Date: Fri, 5 Apr 2024 09:37:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	forest@forestbond.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] MAINTAINERS: vt665?: Replace Forest with Philipp as
 maintainer
Message-ID: <cc0b2d25-e9d3-47f0-b22c-24f748ad8ceb@moroto.mountain>
References: <20240404202450.GA23408@matrix-ESPRIMO-P710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404202450.GA23408@matrix-ESPRIMO-P710>

On Thu, Apr 04, 2024 at 10:24:50PM +0200, Philipp Hortmann wrote:
> Remove Forest Bond <forest@alittletooquiet.net> as maintainer as this
> email address is not reachable anymore. Add me as I want to take care
> of the driver and I do have vt6655 and vt6656 hardware to test.
> 
> Link: https://lore.kernel.org/linux-staging/d599cd7b-a5d6-4f2d-8744-10254b75f7e5@moroto.mountain/
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Thanks, Philipp!

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


