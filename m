Return-Path: <linux-kernel+bounces-110962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C3886653
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9922828A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E3BA5E;
	Fri, 22 Mar 2024 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs9RY5WC"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C975BA27;
	Fri, 22 Mar 2024 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086144; cv=none; b=ECJtsdrt7gvT2gLZnN3LsG9DA03hbrKHgU6ewMP5EbQcIY2OZe3l5TLoFjVm+cAddpETe5M1VUW1h/2b+cXn+1sd8stlZo+I0S2CxilAAFOSJIXoVxUO9+LSJbT63cUI1fyjPqv457SBa9N0Q0SlnCToCDdhzGueOWKjULP/LWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086144; c=relaxed/simple;
	bh=syQU4MzVCz7AvYGIe8yfFD1S+gjF2dNgawBt5pjfbVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rv88AbUce7ErofKRUu3ilXrzFZytrL6WppvvFIhvFkMB62jk2eRHaFLYIuQmJldugPtgaxLn4zefGqY/Gt6x4H3ZCBA6kMJcndr8YwSmFx//7gYr0Gv8ar0XuGb5e/KgkWDjfUYLLoJkegr7DveokVdwPe3JJlMxWk5Frbx6fxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs9RY5WC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1795543276.1;
        Thu, 21 Mar 2024 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711086142; x=1711690942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syQU4MzVCz7AvYGIe8yfFD1S+gjF2dNgawBt5pjfbVU=;
        b=cs9RY5WCm4eCBU24y9zpR/v5QX8Ap1+KtR/R+xBW+nKgJmBnNxlLvEf6QvfaAhErOf
         Ofj/UIyGSyiEH9TUmqDqbdhq3TpW07gjj1Rcj8+7nl54exR/9381ogbwh/CTtBfS5B1+
         rrZzQTV4bm2PA/KptB8j9WKN4l/Io3IRD6RqKy8l7ahDm02/oiGWMD1uDD/saOome1s0
         qQv722YjfdqZbaTzZ6jcK5qBrQ8tI4iDXf4g+oLzl3JTrPFKjwDy+z55MS8ZUAgx9bOw
         wYbKGfAV4in6n6O5Ry0cmngUSLrB7AWSq1q2gyg3d7H2X/Y9RZl9ANNmSgJ9qE3CpI4l
         mtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086142; x=1711690942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syQU4MzVCz7AvYGIe8yfFD1S+gjF2dNgawBt5pjfbVU=;
        b=lfKtlW4Lq4eLuNSa6b+ILXD7obvEZf+bdp9gZD5zOhu2SMmI8oGA8FV9sBKr92Mnsv
         d1ABWeAIw5/LZnasq75Ws0kK2Ch7ZScuhTF6eyrDj70nTj/+jfePiZnueg1Ox295nrlt
         e+ReVlLe/1a0hOYudoJGz7heozlTEcduafYSprp6tJP36J+OfB5TWfSpLuIBtfhA4f/3
         csgL8QDqQA+GCFsM2j6Gyix4HfZo5EnwaJK7ZDkTsT6QZ+KpLjLHqXqPVo1nw2bEovCF
         qpQtItbXNaYVACyqmWNXggcGT/jhbOMEzupA4IFbcq9DS504Mm4Lq4njFlw+G8q8+8Hf
         9haw==
X-Forwarded-Encrypted: i=1; AJvYcCX30n6mkhqL6ZWws3ZfaknzJWVVKq+90oN9Q9Pditgym2kPmNtxmcZ6nof9MqPdy5gz9MG0lBvXUSiGy+tA6tddu7fkCx5ccHQUNju7PHfKuLZBP1juL3N0yTtDdUaprCyueMdEZ95t3qK0l8XRmYGnO4h81/pQ2XOmIvLNWhTe8BSEJImq
X-Gm-Message-State: AOJu0YxvpgLqeUGlSQqJFxO6i31s7dTv8fgJUCVjFR4GzVIDkMlzITgI
	D0Eghmp1u31pMGDRt8Valwk0aqqbVAIG6nrEdh3GH+LLEm66G7RMBTbb4v+pEvJiWQ==
X-Google-Smtp-Source: AGHT+IG5/HFcpIVuILl2KkuQ/ocANf+70Zxb3vvKytmJwJpKn2jAkIblj8+2Ctb2nem9pOzNcGOVVQ==
X-Received: by 2002:a25:2644:0:b0:dcc:79ab:e51a with SMTP id m65-20020a252644000000b00dcc79abe51amr1239785ybm.57.1711086142078;
        Thu, 21 Mar 2024 22:42:22 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id w11-20020a63af0b000000b005dc884e9f5bsm813831pge.38.2024.03.21.22.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:42:21 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: liujianfeng1994@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	jacob-chen@iotwrt.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	mchehab@kernel.org,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v1 0/2] media: rockchip: rga: Add rk3568 support
Date: Fri, 22 Mar 2024 13:42:11 +0800
Message-Id: <20240322054211.3508301-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
References: <20240322052915.3507937-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am really sorry guys, this patch is for rk3588, I wrote a wrong title.
Do I need to send a v2 patch just changing title of the cover letter?

Regards,
Jianfeng

