Return-Path: <linux-kernel+bounces-149034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE308A8AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A5A1C21B21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9A17333F;
	Wed, 17 Apr 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbKord8I"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C4172BD8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377331; cv=none; b=AI36PICeHBKoiVW2zYq0xkLgcPolY/J7cc3ZJaGC8eLG+vHPMOlA3vBoIAE1zBi6sfKBYlWgmZTW9VBdgSuTbBrCzMggQESGBYE4VqAWgGrUKIfi8YeVjPPdbx8UGblX7A6VxSZb05rXehutPzEJOKtAVyv++qfcfN1ElxuSUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377331; c=relaxed/simple;
	bh=uJ5v1jt/3xrupY2eFoZwiWpvIRIEsIFpdqRkLLBC03s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ETzCiBg+UvBOREHlhT8tlLlYaA7PoWPTZnaJrFfbzXKw3ZAfIq6rSWPdl0WbqJ3m/glZ9fPR2Xi08+quuR6guX1IKVWqFpb3gt7sTiLsIze+84VLy+JxD9ahYcFS5SE9c73XuddVlqmdUq4THDSIGsKWAbR2uXiUOGCJ7posdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbKord8I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44ad785a44so723734966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713377327; x=1713982127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smloynM7fJQsDmi6Ly/M7gsorOUchbbkFXvOhhW/pH8=;
        b=sbKord8II0+VtrEtikbY/lT5v4XUuLInpa5MJdtDLdIqbrxhsb2nt022U1U6HBdw39
         ji2Yr7OlqvAoTUNIf6rRSpkkyNoj2zgQcQhCzMjEaZvgo8cUEDP7RRfjpfF+hTdv20gl
         1013kKXKkAfSt0aYtxffhW4l2bmqcz0a7s9675zIUPJYtAsIKgDNzujlEt+2JP120a9f
         fSzdrD4yYIjeBk/C/CawIW9XyzCgAA4COTC7oLUO0NmAyt8VzFWDah8AMTpsNHoySTJ3
         /6C/KuAAOBjJBkdqGc9cf0+YjXFgWMvY+Y76MEONt2FGgCOIT0/yUhJTf+/6P0vcOV1s
         bWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377327; x=1713982127;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smloynM7fJQsDmi6Ly/M7gsorOUchbbkFXvOhhW/pH8=;
        b=wZw8DYsUei5qgTcxSVGarKqqjGp60ijxEx6V1UWCZUa+S98M4Ls0EKbn+oalPZny/C
         Y4vcqGTnDPmATnVO4/X1hdakRkrRVN9fEvRklt1Cu7mhm0ZGLXHoNxs7N8BaiI7r0TLG
         txgqp60Fw+jAUmSOUWDdKIbsR+tv6wPdsrewX/zVj8XpVQpn1PFH20IfEyRDqqtFeWeS
         e9Rj6zxwP/LdVq8lIT5PMMeXQ7F9R/s2zWYlZy+tKqBV0hunzM4XlTS4/WEcvVTyXU7d
         igDjJlGRA7T2mb4Sbh3IgHeajz48uPUMjGYzJXcl3OXGoLnJHwA2T7kJHkgThVDDyBPx
         LzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTY3uzIy7NaboZzpHzTIBfaoYq3BeGDuk8CCv92WQ44REpoE7ozMlxIzv6Nd0Nf0X9TIoTOQsDZHFUj2iUsrOW9GL8T84FhB9Meh4
X-Gm-Message-State: AOJu0YwIv4u4WM2llIwuJ1D5JfNLq8rX/4RT3V6p1owE5Mrnbe6yEi/l
	OzPlnHshp4oQIUkmNH7nGM4ILCI2JccH19KtzmqZijaXhJf+y9hNRB0Da6Uvy2A=
X-Google-Smtp-Source: AGHT+IGhJiNkCMkOyGk0LfZLLEky0z09T9gj2Uq8zgjLyWia0fsntM3spbqybvS4qSutvJ6D3xpwGw==
X-Received: by 2002:a17:906:3491:b0:a51:a06e:afd1 with SMTP id g17-20020a170906349100b00a51a06eafd1mr187751ejb.23.1713377327128;
        Wed, 17 Apr 2024 11:08:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gs16-20020a170906f19000b00a4e48e52ecbsm598618ejb.198.2024.04.17.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:08:46 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:08:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH 5/9] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <bd981ef9-f888-4cba-8fdb-46738198105a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416050616.6056-6-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240416-131052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240416050616.6056-6-gakula%40marvell.com
patch subject: [net-next PATCH 5/9] octeontx2-af: Add packet path between representor and VF
config: alpha-randconfig-r081-20240417 (https://download.01.org/0day-ci/archive/20240417/202404172319.ys4PQfP0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404172319.ys4PQfP0-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:23 rvu_rep_get_vlan_id() warn: signedness bug returning '(-19)'

vim +23 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

5c25d7a685d906 Geetha sowjanya 2024-04-16  16  static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
                                                      ^^^
u16 type

5c25d7a685d906 Geetha sowjanya 2024-04-16  17  {
5c25d7a685d906 Geetha sowjanya 2024-04-16  18  	int id;
5c25d7a685d906 Geetha sowjanya 2024-04-16  19  
5c25d7a685d906 Geetha sowjanya 2024-04-16  20  	for (id = 0; id < rvu->rep_cnt; id++)
5c25d7a685d906 Geetha sowjanya 2024-04-16  21  		if (rvu->rep2pfvf_map[id] == pcifunc)
5c25d7a685d906 Geetha sowjanya 2024-04-16  22  			return id;
5c25d7a685d906 Geetha sowjanya 2024-04-16 @23  	return -ENODEV;
                                                ^^^^^^^^^^^^^^

5c25d7a685d906 Geetha sowjanya 2024-04-16  24  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


