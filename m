Return-Path: <linux-kernel+bounces-17551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95F824F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B718A1F23748
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1BA200AA;
	Fri,  5 Jan 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erNH4ikJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF71EB3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a27cd5850d6so136086966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704440320; x=1705045120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xbMRyk1Q8N40M3FG4qo7cue0pJiuY6oG4D1rJ0mRFg=;
        b=erNH4ikJM/oFRO1xSJntE42GqhCNgHXusHvn1OVgsYivob4RiofJflxgjYyCm333LD
         AOlJE5kqNx88GtVd5cK7L50Y3jmbWU6iXa8patQwzke4TT5r1cfhtPpSZSFvOTpM8JQx
         oT1ezOIfJmZcjnNIQii9c80cvsddYkUt3iIPK4T1TxNchEQDZkRncjnTUlwYdIxHjG4v
         yUacoeRInM4kJOdOlDHx2WKvpJWqLl3idAd1PZpu2WHJWwInNqmykPaNRyZk2HkqX2XV
         aZCyI7eJyylGbU6FcpAGKarSeXNprMiFcVDAcwSXxNdn03nxvg5ARByW118zUt57jqiG
         GIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704440320; x=1705045120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xbMRyk1Q8N40M3FG4qo7cue0pJiuY6oG4D1rJ0mRFg=;
        b=UK+8RbihKXNKMN1fSxxwUJFoYOonIsinqbwYXluEpvk2JIYNP2xR2NbQPm91A5dook
         Y2dF2BR3xw24k3LRYoSd65R7w6wDRo5KM+b22mPlTXrN6wP8emRCRkpz6nZCcR+94mov
         zU+5Ow1av56TCPYxw4Z+KWBlUeQ3+YqQDVsNarZObxhfrHOiyCYSlF6LiT0Qfwtw6fba
         Kg0eMdalDIKexh+McgVnw5Cnj1SiG2DNBJGAAVIA9p4g/IBwwem97Mk7SCAIg5HXiNKI
         I8JAn5ubH5qdnhbSv/6UHaLVP8MwQu1lL5/zG11F+ixhoZpopGogGtLs4fIlSE33nIRt
         y98A==
X-Gm-Message-State: AOJu0YxWiRPWJtpclZruBRXJKyxH27fynRlCY79083Tvo6QHy7OPAKzX
	+IfUKrx9hrOfmI2r5QSJRVIG8RGi8GBBcg==
X-Google-Smtp-Source: AGHT+IGiSm5dGtRrsw5R2/4RG5Ea0xNgOoH5nfO9zv4MQzIegx4Srmv6aiLOEZrZaQeubMROlPP4XA==
X-Received: by 2002:a17:906:5305:b0:a28:d5dd:574f with SMTP id h5-20020a170906530500b00a28d5dd574fmr638290ejo.31.1704440320419;
        Thu, 04 Jan 2024 23:38:40 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id lb24-20020a170906add800b00a28fa7838d2sm567579ejb.18.2024.01.04.23.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 23:38:40 -0800 (PST)
Date: Fri, 5 Jan 2024 10:38:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v3 0/3] riscv: modules: Fix module loading error handling
Message-ID: <6f715492-dfa7-44f0-98fc-fc76e095b7a3@moroto.mountain>
References: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>

On Thu, Jan 04, 2024 at 11:42:46AM -0800, Charlie Jenkins wrote:
> When modules are loaded while there is not ample allocatable memory,
> there was previously not proper error handling. This series fixes a
> use-after-free error and a different issue that caused a non graceful
> exit after memory was not properly allocated.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


