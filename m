Return-Path: <linux-kernel+bounces-132837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564F899AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EFD1C208F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13013AD12;
	Fri,  5 Apr 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWpQ/Df6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE4745C2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313278; cv=none; b=sy/NOtgkuKAccjqiBZ+bTBg19u/ed5vIyb0sZoALMrSnHGYQqq6v9hpRRFlEqWAmIFfr2uiWRCuh9oTLlKP8Vy62KG8J3cWKvN1nj65PuYSB4UI2uCKsQoIlD/ECaV4br/pmz96NfUwOfhxghIQMuTghzXXdiQ6XXq1koC+T4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313278; c=relaxed/simple;
	bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFw33kj43fam3lCe1+Cf/Eas8D2qmLjAXwjQFB3448qZwvp1uE1iUDkwpICQaALDzgnOOnNxKe1TEE19YIpn9YuB+BNbo4s9TO4mQ5bK8WV8AD7OW0rFy3seS3+HP+mECuHLxN0I9hzxagGuxoDfW0NYpnhH2ajJUPpbniaOwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWpQ/Df6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a1c8d931so77739466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712313275; x=1712918075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
        b=lWpQ/Df6KeZkRDsnpw1ccvtuyPy2Qf4qOpcElzm1Um1otWz7c7tIvWlV5rNTgit7f9
         gbh2wA2R1JSXlAduh4ZNgw+SAa7A6WjoSlCLYoj/gZcJZchy+SfWFr1WTq52AiYgKqCR
         luzgSC1T/CgfmX5zcAHQZx3wZz+tpHVfP1k2oLnWBgogUcp3wSXP93lksn0NAnEAMqmE
         rviRf1wsWUyYBHCfdG8YoHd9yOuIhMs4J1gnRTRf0I6bKGBvf8dOK8OiiPjwThvgvMlv
         TkMyo5U4vwjNU8ZGL0YvHlwN9NKAQ1SOR+rdEbQZkHli0nsKw4qXmCt6BljNe/HKhMm8
         h8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313275; x=1712918075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U926oL0MDod9834V/+y8z2gIy7U+dCjf8CDW1Dhy+k=;
        b=OZC/aYeGFSt2mf6HVGYSsXVHctkOZNVJh8IoKSfVREz6XoJ2Vzq5VIHl+VIc78dkpi
         hCwjA6cw3yU6bDSELgOVKtU8oYJEue4mT6m8LaGxmOFTPdoB6TMmTcuq/1YiTK7MYZVh
         pv20cuYuI7ps7Viqlx7NOZX8Hks5x6A7tx0I1MSYzpAA5cx8B+WHLmY1q9Qxqcrcn6W7
         JuOcGUpzCyPB/tYNlXZHHZ5N8+P8K8q4XRznJvWz9eHEmLS5zY+IQXzfnC23fx6mUDhL
         onwMJRFMKMlTf8vagek1qHTyXx13TBk6IWzdaGvflv3utAc8X7h4uf6rHDnqcLsYVaDd
         vZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa55fmEtZAc4XL88eYuykZmLCkpyssPHN7fmdjemrFMaqm0RTcHP2cP/oUOIArtB6DJxh1aB5jyiMfgHkJytFAqLSSVbaWp9/JHoGB
X-Gm-Message-State: AOJu0YzSZG8NlhEyyOWXn33mkq19vZtHwRuMgSU0Z0C0vj4BVK/+I7O/
	zGKMAuGVi7LTd3ZNC+s7+ZJUzdFq9H9bC5/gAdVD5TSi7CtsXZY61ZeU4dkGuH0=
X-Google-Smtp-Source: AGHT+IGRtQuOF6VxMAza2Cyl1XCPnfmisCkY/idqQHtJmUn1wqBML60U9vGFXtOnfI/sNbHots1E5A==
X-Received: by 2002:a17:906:b849:b0:a51:9f3f:3042 with SMTP id ga9-20020a170906b84900b00a519f3f3042mr630592ejb.1.1712313275194;
        Fri, 05 Apr 2024 03:34:35 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906b21900b00a46c39e6a47sm677153ejz.148.2024.04.05.03.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:34:34 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:34:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] staging: pi433: Cleanup & fix potential resource
 leak.
Message-ID: <a8dda2a2-0dc7-4f44-862c-f282c1856af4@moroto.mountain>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


