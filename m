Return-Path: <linux-kernel+bounces-2063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7C81576B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394882875B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDFA12B88;
	Sat, 16 Dec 2023 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+hJegVM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CC12B6E;
	Sat, 16 Dec 2023 04:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210BBC433C7;
	Sat, 16 Dec 2023 04:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702700901;
	bh=OEjtAn62ongEethmnYWtHP1lO82w76auIQeOdoxN/Bw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=e+hJegVMrDiSZ9TrJ5Xa5rmezF6m00KijQnADBqQg5tLPabmaZ54am6l51gnDzy89
	 njAOrfYd1OagKzdtlK5qnOZyS7Dr57Lw6KMxpGuRIg3cDx8UoIGLmiybQQQTZY0Dkx
	 Aa1IyTPDKK7M2wjD3g1J2SsmU9sxvEm+WiD3LJjmdSXkJFpGxBKTKxed0/63fvfEPx
	 P1HzBkleLPZob+CZLVX/cF4CEzFfyiFehcxC1eT4zITYXQAKIuP32hZTsGs1AiJzuj
	 zv54IDw09XJHuWdfmGVXpS5a0wiNGj5yOyyKUsfdlo0N7aE0DY4MF1mtH8Lci4iHSo
	 i/jx1wdpE3Fag==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58d1b767b2bso963351eaf.2;
        Fri, 15 Dec 2023 20:28:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yxoi7AgbmSGyEgb72p/wfsB0Wxg2tyhurKmF6NZVZnKIZkNSKYz
	VJXV9CbGBYDkEKxF3w2d8C1xrcOAVLSBzrnwKls=
X-Google-Smtp-Source: AGHT+IF+aWPpQmC/10VagUYo/GPeuZ38AsScMOdw+YVQHTYR3Zi1IqPmf93RAnpp5cZs6KnoGoLPtDB274jlOVMvIbw=
X-Received: by 2002:a05:6871:5a92:b0:203:20d2:293f with SMTP id
 oo18-20020a0568715a9200b0020320d2293fmr6262558oac.10.1702700900436; Fri, 15
 Dec 2023 20:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f88:0:b0:507:5de0:116e with HTTP; Fri, 15 Dec 2023
 20:28:19 -0800 (PST)
In-Reply-To: <20231216030357.7728-1-rdunlap@infradead.org>
References: <20231216030357.7728-1-rdunlap@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 16 Dec 2023 13:28:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_yckU+dQwSfkA9P4xAbjAU+jaxJgV=R6n5CvrjQtm=fQ@mail.gmail.com>
Message-ID: <CAKYAXd_yckU+dQwSfkA9P4xAbjAU+jaxJgV=R6n5CvrjQtm=fQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: auth: fix most kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2023-12-16 12:03 GMT+09:00, Randy Dunlap <rdunlap@infradead.org>:
> Fix 12 of 17 kernel-doc warnings in auth.c:
>
> auth.c:221: warning: Function parameter or member 'conn' not described in
> 'ksmbd_auth_ntlmv2'
> auth.c:221: warning: Function parameter or member 'cryptkey' not described
> in 'ksmbd_auth_ntlmv2'
> auth.c:305: warning: Function parameter or member 'blob_len' not described
> in 'ksmbd_decode_ntlmssp_auth_blob'
> auth.c:305: warning: Function parameter or member 'conn' not described in
> 'ksmbd_decode_ntlmssp_auth_blob'
> auth.c:305: warning: Excess function parameter 'usr' description in
> 'ksmbd_decode_ntlmssp_auth_blob'
> auth.c:385: warning: Function parameter or member 'blob_len' not described
> in 'ksmbd_decode_ntlmssp_neg_blob'
> auth.c:385: warning: Function parameter or member 'conn' not described in
> 'ksmbd_decode_ntlmssp_neg_blob'
> auth.c:385: warning: Excess function parameter 'rsp' description in
> 'ksmbd_decode_ntlmssp_neg_blob'
> auth.c:385: warning: Excess function parameter 'sess' description in
> 'ksmbd_decode_ntlmssp_neg_blob'
> auth.c:413: warning: Function parameter or member 'conn' not described in
> 'ksmbd_build_ntlmssp_challenge_blob'
> auth.c:413: warning: Excess function parameter 'rsp' description in
> 'ksmbd_build_ntlmssp_challenge_blob'
> auth.c:413: warning: Excess function parameter 'sess' description in
> 'ksmbd_build_ntlmssp_challenge_blob'
>
> The other 5 are only present when a W=1 kernel build is done or
> when scripts/kernel-doc is run with -Wall. They are:
>
> auth.c:81: warning: No description found for return value of
> 'ksmbd_gen_sess_key'
> auth.c:385: warning: No description found for return value of
> 'ksmbd_decode_ntlmssp_neg_blob'
> auth.c:413: warning: No description found for return value of
> 'ksmbd_build_ntlmssp_challenge_blob'
> auth.c:577: warning: No description found for return value of
> 'ksmbd_sign_smb2_pdu'
> auth.c:628: warning: No description found for return value of
> 'ksmbd_sign_smb3_pdu'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <sfrench@samba.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next.
Thanks for your patch.

