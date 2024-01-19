Return-Path: <linux-kernel+bounces-30817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E21832499
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3578E286955
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15460D53B;
	Fri, 19 Jan 2024 06:30:40 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E51870;
	Fri, 19 Jan 2024 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645839; cv=none; b=nDZrhug/L8gXqreBSnAiV4LYxFYeB6KUJMpPgqycyK+vqs/npJB21cD5XPhV3VPl66mP8YqA7X8INkUlebKLW+UjW6KNxNVeKwlkqsN9/UAn720z3DzLJDfIEdMtgmBZ+LvdIXrldr13DcgkNtzG6V0QjLQWxZerYQKF8yLjg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645839; c=relaxed/simple;
	bh=KUgx2pM5cI1yM/hgJHoX/TsILAcbxzC/uA7dOOIXum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K47HbsfVBK30TNbQZqhaVN1ExSsfpnXsphojmosTvaJzGt4iZxYbWzRIFxBnV7sGjLgQaKUOaPxwuxboz509P7VMdOSoqs3rT+pe2EW/daRB5O1B/sDgtTb4N7JbdbkUPuWtosbJvhNN0jgsExEfwt8Hw3SkVn1QuB7OchlpHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso598135e9.1;
        Thu, 18 Jan 2024 22:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705645836; x=1706250636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rgq+nShpQau+v2jsE7HPUUMJIPYJu7zwY2PL11pPIU=;
        b=UNaYhc0uSP/eqWfvtirjQ4Sk9pACISwOsXm4ov5DSDmks/X+9p7k1KRsMOs/ySsD/+
         sXEjS7kZTl8Y6C4qnnqa4wspX3W/SimtPRewTLk8DhCY9QhffoBiIXNVL7JZsmJH8NhA
         e7zRcfBA3ytOpKcjEHFqOPeu+ydODPEgSwH6wIry4LmI8PzFdET8fsdLISb7tNYwKiw4
         DOUyAh/0KBB1AcUxKtCYuKC4KlO1gnulVYbynrLdVG3iJrKKeJtftKCNNox64iER8Qp3
         rDTJJMEizOvHrf9AhYeOQavuP+Rk1kdcJ85HkylxGeQn2HGEQUUJazjkpOCifUnqsu1J
         //bg==
X-Gm-Message-State: AOJu0YycEK6VyQfRDxCzZ0wfnEXpxcNticGc4gqWsvTJV0sKyIzpIzfn
	K4G/dS2ejh76AQ5ukditsoIkonRx2KsUTuuvcJrxSKtO/WmXNOck
X-Google-Smtp-Source: AGHT+IHvaz2og5VA8+OunIqH//5QBSImvAeI6TMR6MNSbh5yd1MxFb6GN9AiebBuxzKglMYTZF9GVA==
X-Received: by 2002:a05:600c:181b:b0:40e:7619:a2d3 with SMTP id n27-20020a05600c181b00b0040e7619a2d3mr218199wmp.105.1705645836008;
        Thu, 18 Jan 2024 22:30:36 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040d30af488asm31794794wmo.40.2024.01.18.22.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:30:35 -0800 (PST)
Message-ID: <0bfbf5ab-eceb-4dc0-a1c3-42da29ca9c93@kernel.org>
Date: Fri, 19 Jan 2024 07:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/45] tty: vt: define an enum for CSI+J codes
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118075756.10541-1-jirislaby@kernel.org>
 <20240118075756.10541-12-jirislaby@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240118075756.10541-12-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 01. 24, 8:57, Jiri Slaby (SUSE) wrote:
> Decrypt the constant values by proper enum names. This time in csi_J().

And there are more calls of csi_J(). All those should now use the enum 
constants. v2 will fix this.

> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>   drivers/tty/vt/vt.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 66ebc90a9fe9..4f7831f81db6 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1498,13 +1498,20 @@ static inline void del(struct vc_data *vc)
>   	/* ignored */
>   }
>   
> +enum {
> +	CSI_J_CURSOR_TO_END	= 0,
> +	CSI_J_START_TO_CURSOR	= 1,
> +	CSI_J_VISIBLE		= 2,
> +	CSI_J_FULL		= 3,
> +};
> +
>   static void csi_J(struct vc_data *vc, int vpar)
>   {
>   	unsigned int count;
>   	unsigned short * start;
>   
>   	switch (vpar) {
> -		case 0:	/* erase from cursor to end of display */
> +		case CSI_J_CURSOR_TO_END:
>   			vc_uniscr_clear_line(vc, vc->state.x,
>   					     vc->vc_cols - vc->state.x);
>   			vc_uniscr_clear_lines(vc, vc->state.y + 1,
> @@ -1512,16 +1519,16 @@ static void csi_J(struct vc_data *vc, int vpar)
>   			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
>   			start = (unsigned short *)vc->vc_pos;
>   			break;
> -		case 1:	/* erase from start to cursor */
> +		case CSI_J_START_TO_CURSOR:
>   			vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
>   			vc_uniscr_clear_lines(vc, 0, vc->state.y);
>   			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
>   			start = (unsigned short *)vc->vc_origin;
>   			break;
> -		case 3: /* include scrollback */
> +		case CSI_J_FULL:
>   			flush_scrollback(vc);
>   			fallthrough;
> -		case 2: /* erase whole display */
> +		case CSI_J_VISIBLE:
>   			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
>   			count = vc->vc_cols * vc->vc_rows;
>   			start = (unsigned short *)vc->vc_origin;

-- 
js
suse labs


