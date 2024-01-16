Return-Path: <linux-kernel+bounces-27769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3F82F59D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683AA1C23E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E51D69F;
	Tue, 16 Jan 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tu5U1NHM"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC31D68C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434037; cv=none; b=flFIGOToWMG8ayqj52VAMWjauVpiniLhfDBcCmQOSP2ZvcUYdcSW26hz59AVDA/L0zafYh55MyJ/OpbUdxQ1EnYwnGLCtFejtB92x4boE6lG2Z6QO9kgWHmrDIYZvjF06nPBYF/jIGfTevUXg/N5vaiCqqYlvRxecZh/U32Bh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434037; c=relaxed/simple;
	bh=HDuB7jq0mLFOFRxAL2ZW5svv4REg+HwB2Qw+eBWDlRo=;
	h=Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:X-ME-IP:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=pT+OUsNnxVRMfDU4LdHB88WhBSRdYDxK7C/KiP705MSmjI6IiIvrFuMcxjanJBTQRvy5CzIahy/dpbTR6+2ESSqIbdA7FiF6GJdqQLwnu+8wvYheSU0MsZwJ17vr8Wmyjcr8THMjt3p4GWGFHdF6eNKSmU2Bs7BkS44EddyFNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tu5U1NHM; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id PpIUrqTO1ZHPAPpIUrImvr; Tue, 16 Jan 2024 20:40:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705434031;
	bh=CdQDLNKrvD6zhAnp7AsYeXLbtX89HnZlN485MGZzLLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tu5U1NHMbRE0dtBT3se5XiQCmX5+WXBRFrgs3c0VMdz1UEBvmXdCqcljv218yqiMp
	 7JNrdn2Dk7Nh6J/Iah9lsnBqzYrwv6YUubVCSSfGT+AAIkBVPXBseYDpaOvMUEnKsx
	 5ukEXrvEj13sjgjXrCLfu1gp25GKZsJrarYIDzjVkFKM6djhFVqwP7PZeir4vXYOF/
	 uqcoZ+0mc3Q87OYkEQ6FIAoV04cllTtOWHWc1aFnPvsjtzAC/gMXkazcP7ivnreB6Z
	 alOYNJdYgXpPSFJ2f+Xm9251dSAIIQe/nAgGTcEMjerQ8q/3S+rP6H7Uv93X09wSrg
	 bcXHwikAaXIcA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Jan 2024 20:40:31 +0100
X-ME-IP: 92.140.202.140
Message-ID: <407c467e-1f0b-4549-951a-83c295b27733@wanadoo.fr>
Date: Tue, 16 Jan 2024 20:40:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seq_buf: make DECLARE_SEQ_BUF() usable
To: nathanl@linux.ibm.com, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
References: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/01/2024 à 15:09, Nathan Lynch via B4 Relay a écrit :
> From: Nathan Lynch <nathanl@linux.ibm.com>
> 
> Using the address operator on the array doesn't work:
> 
> /include/linux/seq_buf.h:27:27: error: initialization of ‘char *’
>    from incompatible pointer type ‘char (*)[128]’
>    [-Werror=incompatible-pointer-types]
>     27 |                 .buffer = &__ ## NAME ## _buffer,       \
>        |                           ^
> 
> Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
> compound literal to define the buffer array without attaching a name
> to it. This makes the macro a single statement, allowing constructs
> such as:
> 
>    static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);
> 
> to work as intended.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()")
> ---
>   include/linux/seq_buf.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 5fb1f12c33f9..c44f4b47b945 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -22,9 +22,8 @@ struct seq_buf {
>   };
>   
>   #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> -	char __ ## NAME ## _buffer[SIZE] = "";		\
>   	struct seq_buf NAME = {				\
> -		.buffer = &__ ## NAME ## _buffer,	\
> +		.buffer = (char[SIZE]) { 0 },		\
>   		.size = SIZE,				\
>   	}

Hi,

just removing the & in ".buffer = __ ## NAME ## _buffer, \" also works IIRC.

See [1], which unfortunately has been unnoticed.

CJ


[1]: 
https://lore.kernel.org/all/2a534333-b5f6-4b1d-b4b8-a1a71f91c3ff@wanadoo.fr/


>   
> 
> ---
> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> change-id: 20240112-declare-seq-buf-fix-9803b7e679bc
> 
> Best regards,


