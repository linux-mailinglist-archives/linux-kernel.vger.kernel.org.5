Return-Path: <linux-kernel+bounces-148619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD18A852E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A747B27688
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192C13F451;
	Wed, 17 Apr 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCKJEMt1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36B13F44A;
	Wed, 17 Apr 2024 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361598; cv=none; b=Feb0B2kD0mCzvcLcnR1E6c270BlzkrKQoT+gnAVBw72c0+xFB+2jbWsDGchkHrQYwLX1hsOkpBHgqrKi5XCjUOAQgv2DMyYVFv1XLdA0zIdmyLObtE/xkkZt/WkNteJvNG+fYdRvbgqo3s//SIgJ+HernI/q/ZvDRMtxfBRopGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361598; c=relaxed/simple;
	bh=G8N3Z0ToOnGx1r5XrvH9ejqq4sKfdkitetitwXzAYLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO78GbghoST8cYfz5BN3K2fbRGSpm6ice2Rh3PlEMyQUTNCRajcePbv7l3Z2eK0juygLhw9Nr/NB9OX7GJhvD3Z2jgDn2NXRwL4LEQMPnHPNTUKWOJgi1Yj1a+Cxkx7M+80OG4X7TB+j1eb9Gu3wEJqrrFkzABw1k7CxaC4epTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCKJEMt1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5b6e8f662so42454025ad.0;
        Wed, 17 Apr 2024 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713361596; x=1713966396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsPVDr8MYadpf9OOAgciXbNWFblocQRX3lYmYadOpeI=;
        b=bCKJEMt15zoGTp5QVk6fbyJCEKlKagV7ZjXGutLxZAWDHyK4clQmK/c/iuKnGyG4B0
         a5A6DkSYaVDHm5E6Yq22ZWlLpwKxaQPW2tYeuDlCZxMtqOB/w0feNDdnx9kfJhJqJx2r
         uzBcrCd4zOfETW+3RjNyClmLNfQ6Ky64t6fuVEPG5diDe7Z0Yn1l6L2HHNQADBwygOFF
         mUQ4LP1aKMoaGqHXmK9vtzRDhCw4/A0Rm//Ti1Fz8fpm03iAljYnLX5w+k41LdGZZvA6
         rZKACmBGLy1qYKb3o5u7lX9mfh126zrCg9Hm38nzRbewOypSZxfAfAGiT/YYtpCDRJf3
         vcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361596; x=1713966396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsPVDr8MYadpf9OOAgciXbNWFblocQRX3lYmYadOpeI=;
        b=OaFwyj904xSRPOVJnAbHq8aRpwJhIx5ahlAWOsmHFZ02oK/DU+VahT4GlJRHegFwtB
         Tsr3AGFojP/t23lJSwfASj1ocWMPn7qOiT4yshEIzG3b/8fplJ4Ir67dDUq4NLYJIG+r
         Ed51vR0XeugDIqtg0EKfknc2CY405XWTcBIfjSVivyKBit3EbBUgCtux83CFzvy7vFGP
         c8vfHo6AqbjpqVlUOLr8Milc6J0g3qKw1l00pCji8+G468q0SipZ5vZQVL7EJ19iwF7j
         Qc40PO4AlNlFiDKDxJ05jelgqQABGoF+3l7a/BwssaX3xPiiRsei5ZlnfLtivPh5Ts3E
         qoXg==
X-Forwarded-Encrypted: i=1; AJvYcCURVkmG41zha+M9+nIHoMA721/JCXGd8pClPZ0PIAFF59t7zbyPgB9s5H9o25Fxa/CritapgYw/U2fLsa4GEGwulv9ZeUky4+xOIiP10uzsddXQmELJGDltW7/hYKPuU9C18sHYZTJ3
X-Gm-Message-State: AOJu0YzMFA5Mrx1Q7zJXzGXZHGXhiYKbhap+pL6j+dPTEjKkL393TEE6
	8FmQGfe3KyUfIUPO5sHEmY7/UaK5AZuE/oOOh0crGIkbwUHK1bhN
X-Google-Smtp-Source: AGHT+IGGeCeCAckqV604CKpG9NBNR+/OchdxzvOdwDnGTs0+urOSd5H2aEUxnUuxSc9N8Lj37YnsKg==
X-Received: by 2002:a17:902:e5c6:b0:1e4:145a:ee19 with SMTP id u6-20020a170902e5c600b001e4145aee19mr17935591plf.50.1713361596324;
        Wed, 17 Apr 2024 06:46:36 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709028a9200b001e2b4f513e1sm11541755plo.106.2024.04.17.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 06:46:36 -0700 (PDT)
Message-ID: <82275ef2-64c4-44ec-b95f-1d53f24ef550@gmail.com>
Date: Wed, 17 Apr 2024 22:46:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: repair file entry in DOCUMENTATION
To: Lukas Bulwahn <lbulwahn@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>, Akira Yokosawa <akiyks@gmail.com>
References: <20240417101429.240495-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240417101429.240495-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 12:14:29 +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 1e596d5eff3d ("docs: Detect variable fonts and suggest denylisting
> them") adds the new script check-variable-fonts.sh and intends to refer to
> it in the DOCUMENTATION section in MAINTAINERS. However, the file entry
> refers to scripts/check-variable-font.sh. Note the missing "s".

My bad... :-/

> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this new file entry in the DOCUMENTATION section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thank you for the fix!

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4356b28ce625..250c8f8caa08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6493,7 +6493,7 @@ S:	Maintained
>  P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
> -F:	scripts/check-variable-font.sh
> +F:	scripts/check-variable-fonts.sh
>  F:	scripts/documentation-file-ref-check
>  F:	scripts/kernel-doc
>  F:	scripts/sphinx-pre-install


