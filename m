Return-Path: <linux-kernel+bounces-106497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D787EF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AB3B21DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482F55E5F;
	Mon, 18 Mar 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns2botfh"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597855C0E;
	Mon, 18 Mar 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785493; cv=none; b=FEo0jfxvXI/TyNJg11hlL9vOB7Plb2OMMcEnHbqIPtEeGzxDUghVFCTblkYIEVxUE/bAxQ329d6c7TEY3Et8397npv3zeLgpJIuhEDiAsc/X8XFXqxvNWVqIAB0pNJlPAKWlWCCDgSUJEx50iTtlYDw3NXmoOyirGTQ8U3v3EmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785493; c=relaxed/simple;
	bh=tSZn6Ejd47KXYnMy/z4XjMIbJu1/NOUxNOUSsd7bn6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxRJMYt7qM01zIMN4ox/GAm58e+c1BqNmtRA4CEWhWtDVkh2i+QSn4k0iUWBk3UbQyVXzX57sNazINxB/XqaXHTt6dEU0JJ8PMjA0AoZrcVmgATktXAmnJB6EVGgj3uiZEqGGJgTW1VbwjsbGCs3CxDbK2rwPHI2in7iY9ervhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns2botfh; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a49261093cso1455257eaf.3;
        Mon, 18 Mar 2024 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710785491; x=1711390291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0VKqCIpVP/BtUvyp9zPnBwFIX1VHIioMo2d+w9H9LA=;
        b=ns2botfhXbTfzwgFKzE/H1HfdzFk1n/dhCD7pOXLMDhJyuuzxYfm4C43rzfAOB6tuw
         R9veQQD9Z2YmDA/5o6dMtU6XWLECTRJjhPUc0vE06vC530jsGCRhKAl7pZk1zhC8/3i9
         qqrOZbwIYB3KWDXkg6tyiav3jtE5AL7cKBi8OHjyQQjKqR42IIr0hEjck5D/+jrGfqUe
         dY+bxC+zd16LtN/XJGI6TGlLklpcNezMBrpfG6jaS29J0YrW+XiQUI5abH1VmG7eAE/b
         cWt4FrhiozvHcYI+i6kC+t84q324g4Ya03vkT4vMXMBwHjiYFNJ+GDMBUr3Vgn5XLPQn
         rhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710785491; x=1711390291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0VKqCIpVP/BtUvyp9zPnBwFIX1VHIioMo2d+w9H9LA=;
        b=izYxnqz/dGwfKLrd+Srhw1y7hlZ815khXOTvoE3cPBhex9+fwHe2EdmrtJxLj6vJXc
         03sgM78ErjDfTTkdD+nHQ/RzB86u47TlHdrGIEpZX0yldpYwT1a5VWYt9kce9aKudW4t
         P5Pavtkw1+NHB9856VL2U+EMCLNyCpKGNATrlkgiVBxbe5dwIftufGCPfptTODtLkBKM
         Rm/ioIOAYSUHsXrLJYEpXCHQtULj8wNIhPoIcAKTdcIIvAJMkTqWHXHv+riNWe/5zMrI
         G4PJ1YWk6/wwPelC+SuTt00kUNDV7/T845rIKpjo0ypKq7xcV3Pa3q+Kk13UzSEzX/k6
         jzQA==
X-Forwarded-Encrypted: i=1; AJvYcCUPwr4RRycnExa3BQr5Iv8c3F7iE5/jYyzki3WucnPBgbBUCAzTmJfGECmQb158Cjaq7mNoZe2YmN9mfpjgVjvT5ThN42gEFawwdqN2X4gPTsVQlzOrkuEGLxp6z66WHzgVLXZTJE4=
X-Gm-Message-State: AOJu0Yxe2JyWTpztQKV9msbHSlKiM1QmfArrhj2a62qT+juAD7M34/8f
	ptszoauTa8IyfcoLM3ACm6tX//dtZ/NlBUWOoV7YnYKIOfG0wdr4qELdLL/b
X-Google-Smtp-Source: AGHT+IEPU0++5brWJmarVPFjxJR6uw46576Yky3MEE1nT2iKYYnOieBZvcEfIWsDtDRBYexZlfip2g==
X-Received: by 2002:a05:6359:7c20:b0:17e:76a1:4dd3 with SMTP id xm32-20020a0563597c2000b0017e76a14dd3mr17527901rwb.4.1710785490915;
        Mon, 18 Mar 2024 11:11:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5-20020a056a000b0500b006e64baac744sm8255377pfu.120.2024.03.18.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:11:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 18 Mar 2024 11:11:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: lm70: fix links in doc and comments
Message-ID: <6c8b2699-5488-4ae0-8d78-59bcb2030a2e@roeck-us.net>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
 <20240318154540.90613-3-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318154540.90613-3-five231003@gmail.com>

On Mon, Mar 18, 2024 at 09:08:35PM +0530, Kousik Sanagavarapu wrote:
> Update links in the documentation and in-code comments which point to
> the datasheet.
> 
> The current links don't work because National Semiconductor (which is
> the manufacturer of this board and lm70) has been a part of Texas
                      ^^^^^^^^^^

Is this a leftover from the other patch ? The lm70 driver supports
the LM70 chip, not a specific board.

Guenter

