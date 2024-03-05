Return-Path: <linux-kernel+bounces-91761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AEA871630
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE02B236D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77C7D3F8;
	Tue,  5 Mar 2024 07:05:27 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962D7B3E7;
	Tue,  5 Mar 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622326; cv=none; b=rTpK0igrLcYn4vxFusuiXlqTq9sHe+6KmVff4PAlkbb285D0ZNQNs7ZAfD1rvpRCIe0soEf7VSBn//LWRB/oLy5zYQqu7zBd7jqSUfmIhBvI0Sz58fVW0K44Phl9W0/BTcyP8g30u/26Q51dccW2ZtZT7QPB29Mwtq5JEhBm+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622326; c=relaxed/simple;
	bh=FMKQCtbNGVtmsTvkEQw19ZwAZ7lkSkTVEPqApBceiHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjuilZ0qEUVzVTsi8LEhZBvg0smmED8ow2cuSC/Gq1kuiWYVp1s/LLoh0ZrzBTeXp32nBzHKbpMaELt4YySOoNRZUmEmSaI/I7mN4p5SmrZWMV9U6RoNBE+dG9nAwHrN+CdFdTmCpPvUSyg1iD+cWxa6g7fICAGRLvqjFB+hclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d24a727f78so64857381fa.0;
        Mon, 04 Mar 2024 23:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622323; x=1710227123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O0jv6LhDjyzJdxtct/C+ioUyyKG0iGxWB1l46k8xmk=;
        b=PtEPnQkfn4Fj40ENsRF7xIwZzYDq6Gd3qnskWm9ZYNdKy8XrfveIZ6+ndCqa8Rqa3r
         nAg8+5sove3wyDSsuyiwm7moI5zjGZT1/xctuOMNMe7KPoDHvRXL0j7ucII/PDv1eSLM
         uJX2v1VQ007ZoKWRd/RuTIZdst2Pfw1dHa/XwWONea9Hfr2zhim1AmSO6vubKfKsowkQ
         lglslLRCc/+m4int/sUX4y9L0fM3YRZAO/JtkUT74ijtUrlQ06Ap5Wy6D4pvq1Ssyho1
         yT5uZ9RRCFGBDSkBWT3GQhxVVpD+wORCkwpzeb3NnjvDRROdPWTaqU7E077OsipaWpr6
         xKQw==
X-Forwarded-Encrypted: i=1; AJvYcCVlzc9/BoOaO45PaRGW264Un5yG6YqYyiv+UVw/H3q6qmqR/KOwWFKnb46WOVUm2q2H7Q7JFm/wZPw7GdRzm+m+sW1jQLNNYLtm046gRyAvfbDrW/3v+XDHO10NPdiVNoix7duayY5RKB/dqW5eK3wEpQapXepMI4WYvGNQ4SSOetI9/EesL/4z7g==
X-Gm-Message-State: AOJu0YxqKzfKQ3nmBZ/u4IkQjRH/uVh/jV1aQgoyR6ZaGCqGPgNhRJSG
	vWnUCQtWQEDqQh6F5Gb5fW36qgVWnILZLqyw0fsJhWSLOrerHvrEEQlKRVLj
X-Google-Smtp-Source: AGHT+IGTg7AbvjHshYOWYEP/7coOaeVQPu+NnLoCzlx2ajIpsU9WluR+fkfnhymug8+vc0+2eWbxBw==
X-Received: by 2002:a2e:3512:0:b0:2d3:f64d:516 with SMTP id z18-20020a2e3512000000b002d3f64d0516mr309531ljz.46.1709622322854;
        Mon, 04 Mar 2024 23:05:22 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402194c00b0056777517887sm924935edz.85.2024.03.04.23.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:05:22 -0800 (PST)
Message-ID: <f196ffc9-1341-438b-abe4-0761b5901716@kernel.org>
Date: Tue, 5 Mar 2024 08:05:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "tty: serial: simplify
 qcom_geni_serial_send_chunk_fifo()"
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240304174952.1.I920a314049b345efd1f69d708e7f74d2213d0b49@changeid>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240304174952.1.I920a314049b345efd1f69d708e7f74d2213d0b49@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05. 03. 24, 2:49, Douglas Anderson wrote:
> This reverts commit 5c7e105cd156fc9adf5294a83623d7a40c15f9b9.
> 
> As identified by KASAN, the simplification done by the cleanup patch
> was not legal.

Ugh, indeed. uart_xmit_advance() is nice but completely hid the detail 
you describe below.

My bad, so for now definitely:
Acked-by: Jiri Slaby <jirislaby@kernel.org>

>  From tracing through the code, it can be seen that we're transmitting
> from a 4096-byte circular buffer. We copy anywhere from 1-4 bytes from
> it each time. The simplification runs into trouble when we get near
> the end of the circular buffer. For instance, we might start out with
> xmit->tail = 4094 and we want to transfer 4 bytes. With the code
> before simplification this was no problem. We'd read buf[4094],
> buf[4095], buf[0], and buf[1]. With the new code we'll do a
> memcpy(&buf[4094], 4) which reads 2 bytes past the end of the buffer
> and then skips transmitting what's at buf[0] and buf[1].
> 
> KASAN isn't 100% consistent at reporting this for me, but to be extra
> confident in the analysis, I added traces of the tail and tx_bytes and
> then wrote a test program:
> 
>    while true; do
>      echo -n "abcdefghijklmnopqrstuvwxyz0" > /dev/ttyMSM0
>      sleep .1
>    done
> 
> I watched the traces over SSH and saw:
>    qcom_geni_serial_send_chunk_fifo: 4093 4
>    qcom_geni_serial_send_chunk_fifo: 1 3
> 
> Which indicated that one byte should be missing. Sure enough the
> output that should have been:
> 
>    abcdefghijklmnopqrstuvwxyz0
> 
> In one case was actually missing a byte:
> 
>    abcdefghijklmnopqrstuvwyz0
> 
> Running "ls -al" on large directories also made the missing bytes
> obvious since columns didn't line up.
> 
> While the original code may not be the most elegant, we only talking
> about copying up to 4 bytes here. Let's just go back to the code that
> worked.
> 
> Fixes: 5c7e105cd156 ("tty: serial: simplify qcom_geni_serial_send_chunk_fifo()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> If folks really want me to, I can adjust the patch to try to detect if
> the circular buffer is going to wrap and still use the memcpy(). Let
> me know.

I will remove the for loop anyway (this was sort of preparation), once I 
switch serial to kfifo (soon). No need to think about this more. Just 
revert and be done with it for now. kfifo takes care of all this 
internally (and correctly).

thanks,
-- 
js
suse labs


