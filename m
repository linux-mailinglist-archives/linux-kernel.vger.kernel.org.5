Return-Path: <linux-kernel+bounces-97140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB648765FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFE31C20A56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473E3FBB8;
	Fri,  8 Mar 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEUog5mX"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0763B8;
	Fri,  8 Mar 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906855; cv=none; b=I5piY3WJEEZ4y5ASz0NZncWP41odHHc/S6aFRScFBrKLi3+fL1bvwztLh0htYVUmE4vch9ZUCW+nwM2iZ6HtPieMlMUYyBU6uUzm1g9gbX8bKI0sFFLsvwL15jHFrc4cxUk6DQaMW6ylI/8PB73Tk7FSaqy0jP17m4/kVym1Vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906855; c=relaxed/simple;
	bh=9aUV0lwshQLHEQidMvGenU5qEAn4ekLdhlVdJOvmEVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G5914BH9XB3awSAGoTA5iFhiHY8DofaiF2Gmpae+a/AdylsWaKiwtObpDHyJKiiJ+/CHNLUqhh5dxv70EsoPgIr9tXt2nmq2oRHefsOxSWdztPUhuFV3y/tDgcBhomGkELvLaqJQ0wm3KbIwCNXFfzSihPeVrzcyqFzFae+hwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEUog5mX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7885980949eso9022185a.2;
        Fri, 08 Mar 2024 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709906853; x=1710511653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miDE/vGMqieyhqNZidg/4W9UPLe/m+Xym9XBjZr29EI=;
        b=aEUog5mXX9EoQGHD+FFSxMZJ0hcFz1UGoCYO7pIJbl0f21BkxcOSc4Wi33F30i1cjh
         Chj1DqmR/sr/N4xbCDlXaQU9vhKiTo4XPYTCvdejN6zCeXcW0s1JVo3l9S3zfgEPM2Y9
         83+uQVq/CTUSNHLhy1yc+g39Xr2N4ZmPbNy0rqAeV4lfVrZp5X85tSZO0k+xzmaTAblC
         xh47xrqlFSSR9RVYcl3UaHDHAMIhHruTOZkibM8ett/ukFGzT9kWCLmVDhnpEQtTi+NJ
         mgTCnhZWrLIr8h61DOxFshhU0xfWckLjhhPQnIqK9M/3jJvR7xA8Pgz+xZcBeF8pdKcS
         QQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906853; x=1710511653;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=miDE/vGMqieyhqNZidg/4W9UPLe/m+Xym9XBjZr29EI=;
        b=pC08huff2rJQ6GWjbODbB+S7ueCetl51QWFVubKDdzqNEdFs9tx7WnC7THXnWjGc7I
         Odnibxazgz1DWkOFXxZsrP1a9dRPHQGzXHy7Mrn7MfAPd5gGdc9R29pVCuZ/DsPD3zm3
         JAJHL5/LVBOhOQycWHnE8CyVC7Pf5+w16b6w15ObZp/zZelDkJP/edWGO1XcAca09VuR
         TESKrsqrtG25BK2cowEznSrolKCYhJ2mQvDpi45DtbKISGyZXPWCo2fMAHDtv+v3KNmk
         cryvUmP31/M7o7DWgpmuenKv/T6dj8K/L3E8MejcR9PloA8GoHjXT6WL4H/tICih+64T
         CR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUce3AZbRaxOmC5HnYanC4tg0w/jypezvFMeJ2orxqQM2SIdqUNYQVuX04BreFrynJAFF/XWaCGag1gAY6GZQnrPk2dJABWNo7Wyok1
X-Gm-Message-State: AOJu0YyIRLYTLJku/uVAJ57RIWOC0yyKMVXQPz1zQa3jjcvxATelXmnA
	DwnYwb36PU7VJGRiuxvqDF54PTy1jY4QpRdBmJnYYfG+jcKOASPk
X-Google-Smtp-Source: AGHT+IG9j6mjgo76J5OeV5SD5e7xMfgBlsTSpRJX2Qb9wIEmBbRYm75ViLHHb4pGhOX2XVUONOsLNw==
X-Received: by 2002:a0c:eb4b:0:b0:68f:5ab1:a135 with SMTP id c11-20020a0ceb4b000000b0068f5ab1a135mr12139815qvq.47.1709906852936;
        Fri, 08 Mar 2024 06:07:32 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id ks3-20020a056214310300b0068ff0778895sm9847843qvb.81.2024.03.08.06.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:07:32 -0800 (PST)
Date: Fri, 08 Mar 2024 09:07:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Juntong Deng <juntong.deng@outlook.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <65eb1ba4956d_14430d294ec@willemb.c.googlers.com.notmuch>
In-Reply-To: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58487A9704FD150CF76F542899272@AM6PR03MB5848.eurprd03.prod.outlook.com>
Subject: Re: [PATCH net-next v3] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Juntong Deng wrote:
> Currently getsockopt does not support PACKET_COPY_THRESH,
> and we are unable to get the value of PACKET_COPY_THRESH
> socket option through getsockopt.
> 
> This patch adds getsockopt support for PACKET_COPY_THRESH.
> 
> In addition, this patch converts access to copy_thresh to
> READ_ONCE/WRITE_ONCE.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for addressing the READ_ONCE/WRITE_ONCE.

