Return-Path: <linux-kernel+bounces-16836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91558244AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696CEB21902
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB3A241E6;
	Thu,  4 Jan 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="as7w+wtp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468C2375F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3f2985425so3541075ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704380991; x=1704985791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCW9oZWKyQ9e4+VukxMpsgFSr8YXVhhj/025rshv2Ck=;
        b=as7w+wtpsR+05KGxSvvhaH2cseUyFlXDydCngH5Di2wVRYiOSMBeSl48G8kJ4Q5WLd
         mgCmNH2r8FwX+6HP601EE2ne4XXjkUIkhboX7id0AkGWVvcgGJPQqJg4jDtKLXQyAfF7
         DP+PK2ZmzPsZq4SrkYzlqR/WSri7e8/oNbxnRELA/J5BAa5jYW84peUWDWu/VV2Ygyyr
         PhxndnTP3JKgd8buhCZzKKkuk301j9PH+8ZprTUKxqfG2YSMpeXTcUiO84wFsgNMOMCi
         MlT1FWHxYYg5RAlz1h/Eo/eKPKa6n/pAuSrrgZZ+ruicQVVMfx8bRjx1bGFh71w76lPv
         ltDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704380991; x=1704985791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCW9oZWKyQ9e4+VukxMpsgFSr8YXVhhj/025rshv2Ck=;
        b=UBpDCoKc68lOrrixBOXLgU5E2adSbyNFCIfDbVft4kOaBDOwQLT/4ftXNUf9bXwXAK
         kg11T/1ydPpt9UtD98H/kDPU6sBFMrT2U0aYq48CmXHNAJNHcN1fIWnVCKfjxsPseMBl
         8tGCFHgaYn5KVO7z+/x54rNETaxL400hH95Tu965WsA/SLuO3mGV9p2BL43ijvlmlgw+
         srg54i54MLllOkHlQw6uxHw+SKjMaTJ76CmTIOIQ8/L+LCOkdsI3bZdmlUPRlJwjcab9
         hnZfsht9FTn2a5E8Pl7ZeQ6gLRLqd7BJEAeQTZp1jDaoBgBRR/ODG49Xe+Xz86/FHhi1
         vz4w==
X-Gm-Message-State: AOJu0YwNyOZEJeeN1Fgds5YaFy6SSB4NyrnSwsbPlZW7Qm0QMDVp+5fJ
	hUjBPJaMsfT8Bbdf6+iMfMPlHH1dq0sJjg6zjdgV1YUdGKc5V24=
X-Google-Smtp-Source: AGHT+IFDeMjhUh85xUIOfhMENAOdaQ0mYUxGbQAbBNf5318yFFIj5Q0LR1p1rvUlPa0NYwaofk/k8Q==
X-Received: by 2002:a17:902:c10c:b0:1d3:fbf6:4d94 with SMTP id 12-20020a170902c10c00b001d3fbf64d94mr531132pli.75.1704380991041;
        Thu, 04 Jan 2024 07:09:51 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b001bf52834696sm25513697plr.207.2024.01.04.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:09:48 -0800 (PST)
Date: Thu, 4 Jan 2024 15:09:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] android: removed asm-generic/errno-base.h
Message-ID: <ZZbKNd5rYmd9EBf1@google.com>
References: <20231226-binderfs-v1-1-66829e92b523@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226-binderfs-v1-1-66829e92b523@google.com>

On Tue, Dec 26, 2023 at 05:09:23PM +0000, Tanzir Hasan wrote:
> asm-generic/errno-base.h can be replaced by linux/errno.h and the file
> will still build correctly. It is an asm-generic file which should be
> avoided if possible.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
>  drivers/android/binderfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 1224ab7aa070..d04ff6029480 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -29,7 +29,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/user_namespace.h>
>  #include <linux/xarray.h>
> -#include <uapi/asm-generic/errno-base.h>
> +#include <linux/errno.h>
>  #include <uapi/linux/android/binder.h>
>  #include <uapi/linux/android/binderfs.h>
>  
> 
> ---
> base-commit: 606d9c29e71fbf52fcfd3fcc3ad92e444c8e1d47
> change-id: 20231218-binderfs-a758e162e0ba
> 
> Best regards,
> -- 
> Tanzir Hasan <tanzirh@google.com>


Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks,
--
Carlos Llamas

