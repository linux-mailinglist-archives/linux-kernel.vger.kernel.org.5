Return-Path: <linux-kernel+bounces-127757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CF895089
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB971C224FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37895FB9C;
	Tue,  2 Apr 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE9/grAw"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CD3EA72
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054447; cv=none; b=dbrXSf3g77pKwpUsE/WV7F+otN9x1mswVyOr99re0byFRqXwsKcC2IQjXfq5njxZswcY0JQw0+OcZowrcnK2vbzj20aLsl4CoPRLNkQP0nHc3WK5JY35jg75w6bquFlMzDRXv2Eh1kcgYLb0NyOT5GVLv4LEJjSzXWJXlzdXmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054447; c=relaxed/simple;
	bh=UsPusJ70z/hTGNwQRA1c0DtkXeRzoz/bLJ9nq3UmtYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqfc4Co9V3RlcJgAubSlGjsVVtE5mGDBqGiKkbaR4MrouFL7oP1rXKMSj0zZKB9YPVqoXWRmNgskaPmwgqeLKwpQx8zxNYWGjdTplfZ8J+MRsnXSBSRBtKngQkNX7RCcx3oKz+GkgzP/f+YOiWgmCIaOnMKsEnxtfY9g7oNUqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GE9/grAw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74435c428so4777896276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054444; x=1712659244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9PYIxF4j0xg6PPKY6bKCHDAb7yDnCos1Y4nrGksgbb4=;
        b=GE9/grAwXjS3vyGcP3xO2p7aY4SQE7kknB7whhEJj+RZknboC7Fkvp5M0xLcp1w1YF
         9VpuKcerKq53qlB3n6JQSIHAjOlswb4uYVhXhsR6Ja9wE/rPHMag0KbrooFWPEMq+hLH
         P7hhUzKBJNjEmLbY+0YEbZUL/slxVBYtziKTaXOC98GLtnQuknFdZYcC58bEU3+fj+W2
         IWMHarmeQM/wegnsXs/iykS1bPnSwd1fzwdYT3pVsAfNRgxk2Eitfk8A7n60Oc/8jjkj
         5aK16Le0kSOPc7dZXxF6fxVp/iJlt2UiWq0n4uKZsaqagXfsnZfC1fXvzH/ekK3lzCGj
         xzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054444; x=1712659244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PYIxF4j0xg6PPKY6bKCHDAb7yDnCos1Y4nrGksgbb4=;
        b=Q18JCMRYmFlMn/BBnv/UOErzl5Ugm+RbvX97y/Kn/IydSpAYoDM3BkQf8fNHhZRzzJ
         Ny9vlROztTs8SbJTuZJBCr0r4Jh8lx5DhRQuxW1suXE8g9f+Evdg7cpP9KmXL8YaVaiz
         RMdBVGue13KKsOAoAU1joyMewCucL13IoRkeyzJdsCXcqSwDfbYXPByA0TLxVTLGRc9x
         1LtXwaXRTGIP5aVPqEEUIUIreskU++mYr57WBjyCoseg0UfF5mrdtb9CULZaVbn95qkb
         Mlj5ftA6e8QirWka+6GmME5P66pCUmhiRvZvwQDWLbAjliLDz5ZmJiAPJv8d4vfHuJqz
         2hvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZBarbgyo5YPmvwMxfaRonJhlKe/WqmsVc84CvtFn+RXgm1a3e8vMo9Rw1jw0f+EmiqNFkmVsi2dsvf7FTyVULusDlOSFV+8nsrKa
X-Gm-Message-State: AOJu0Yyk7us43C50BkTIyqvCZbqBZQAsW0LJ/kC3NZbN3KknuGJML8Qp
	SZQ0LBvgi88RW//uGXIXPD9bllnC9f/Byx6cBdbk7vLNXBnJrCYBJZNjBGQRIEy9xQvajMAwRwF
	V4UHtyF+RCWpHZiY/L6vYk7+N8C+3g7gxFPJ91g==
X-Google-Smtp-Source: AGHT+IFJm9l+G9UEBddm5xRcgxHteNtcPg5V78UGOHmM+aa84AtnvwUHGqb/sEXQfiCIWlOZaAm0r9DYyPYH6p7uu4g=
X-Received: by 2002:a5b:ccc:0:b0:dc6:de64:f74 with SMTP id e12-20020a5b0ccc000000b00dc6de640f74mr9783364ybr.9.1712054443883;
 Tue, 02 Apr 2024 03:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-4-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-4-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:40:32 +0300
Message-ID: <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Wrap icc_clk_register to create devm_icc_clk_register to be
> able to release the resources properly.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Introduced devm_icc_clk_register
> ---
>  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
>  include/linux/interconnect-clk.h |  4 ++++
>  2 files changed, 33 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

