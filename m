Return-Path: <linux-kernel+bounces-120677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07B88DB57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A81F27F03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62313FB85;
	Wed, 27 Mar 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZGpmWnY"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83A273FB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535833; cv=none; b=m6hZdAZZNag9u0CMggJkJzVjTNpA6rihr8nvwe5ZQWPh4dFQafOt82EEvVCqjKEIck8I+FlrydMEIGhsKtxoOfFMutkCvqmxyBBEPQiXPT4VN9vEsMjydac6LH6K2zrVwaKPk/0Id+PijS4jTkTFS1m0MFuJ92gXOXj/r4N/0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535833; c=relaxed/simple;
	bh=9MtnUGb5/xVzmxiQWRd0pMDTVCd37nN0QPXrSbZMyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBVQT1BDQ00ncVfAVLxnA8kxlOBjI+XCjja22tw3HgqcMGnefNWdo+Xzzsx1V1MwZQG5z2rBdUKoNZRq8kJc7rBk+LXRf/KBvl+BITxePcSHrcUt83c/0VG9OFfr1O64xSQAFkxta+9Kl97gxg/1r4EgfIwfSvUlHDJrCcrnqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZGpmWnY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so137224766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711535830; x=1712140630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0RBjv/Mk5+1uH8zHWpw+frS6Pk+FGxJ0ixEJQeiLUE=;
        b=GZGpmWnYg6GhwFB6eRNKaXWKkyMmDfdOPHdGc9Oqfl+KzdIbERbRLu80RDPtBzImL/
         cVvS+IYkr3VeTNM/msdVaWUtIqJTpbgmoY8dnAecGMrSmFRIaHms2BPxG17XI8qM/scj
         lx/nhKELnCvQDgK7EF+xCen0FYNVgQKXSzsE3Idrnsis0FInaCzvJlHSabaVNlfLMxow
         rKCajQ+0xqi1ukr70GjB6zry3zgLLYOSPGTCq/PjnnAw9QJxUwWligP7OF5XQNLqcIWc
         8p7oI5SqtQcP4FxjZ2UvN2QianT7gG7kQRz/XIQBactQCAWDJJCMCuu1Fn2O+2ZgJwA/
         GZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535830; x=1712140630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0RBjv/Mk5+1uH8zHWpw+frS6Pk+FGxJ0ixEJQeiLUE=;
        b=OPlYU0r6T6JakbPyhogfwdHyJ2+xxmkIh9atgjH68Q/3qllf9TY1y3pHBCOFcumMDr
         CUhSJPU3nxygO9+89fQrFkpjpGzoeutcF7JyNTjcwjPySboVzJzb/h5lu4/4PHpTf0ak
         f0QTvbvq5M9vlZiaM8Mywp+H7SF3DQ98604SQ0Hdon0kE7R5VA3aSGkeeGMcVAP0QV2t
         TlkdhwyLXdeEeoAkXvL/QVGZ9LBWQpG6GCkfmhUInZknVvxJNYm+MniVCuAbWCv2pDIh
         J3sFsy6/alOXyQdtVUaymJZUN0t+Z7bgHR5lU3WIgwCYcEDgsBPjjBi+wPMqRsUwLp40
         POpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKyjNkN+PaLQiF916eN++GEbM6343uqf8lB1jLpdWp3UcWkiIQv1hyhtZ5lhsD+L6VUOfRsBUmefKhCEbV2Vga9lijgzSmBpRvrg0S
X-Gm-Message-State: AOJu0YyE6A97diJceF7y5w+5Ju+00Gs3wgeZMuslNDwVVy44pCekO+W5
	Wg9OQWlhKA4wBpwqIIelTgb+lSqdCH4lZxMZaV1EkY/UBX7hs06zqkhxKrKGU+0=
X-Google-Smtp-Source: AGHT+IGz4Ddt/Fv3CJl38Ww58TnJzydiHKubdfPR7I7n1Y2mpYfMpwk6w9WcDu9linEDr2LcHQ+bmQ==
X-Received: by 2002:a17:906:4552:b0:a4e:ca2:f597 with SMTP id s18-20020a170906455200b00a4e0ca2f597mr141687ejq.30.1711535829275;
        Wed, 27 Mar 2024 03:37:09 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fe8c000000b0056a033fa007sm5109218edt.64.2024.03.27.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:37:08 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:37:07 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/5] spmi: pmic-arb: Add support for multiple
 buses
Message-ID: <ZgP209t7IhdhcZIr@linaro.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
 <d213f262-ba0e-4cf8-af0e-66745ffea429@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d213f262-ba0e-4cf8-af0e-66745ffea429@linaro.org>

On 24-03-27 10:23:51, Krzysztof Kozlowski wrote:
> On 26/03/2024 17:28, Abel Vesa wrote:
> > This RFC prepares for and adds support for 2 buses, which is supported
> > in HW starting with version 7. Until now, none of the currently
> > supported platforms in upstream have used the second bus. The X1E80100
> > platform, on the other hand, needs the second bus for the USB2.0 to work
> > as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
> > all found on the second bus.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v6:
> > - Changed the compatible to platform specific (X1E80100) along with the
> >   schema. Fixed the spmi buses unit addresses and added the empty ranges
> 
> Why resending after few days? And why without reviews?
> 

If you are referring to the initial v6 patchset, it was sent more than a
month ago.

https://lore.kernel.org/all/20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org/

> Best regards,
> Krzysztof
> 

