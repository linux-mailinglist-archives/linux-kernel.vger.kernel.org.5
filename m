Return-Path: <linux-kernel+bounces-48053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB788456AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC88F28BBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45B15D5BB;
	Thu,  1 Feb 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amq6ANsm"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57715D5B4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788690; cv=none; b=uv4A5XjdleNAwKINWOsU6NPDm785BYepAfB2ZdmXLIQt5lhB4Sgn/6eqGlV9p3Y50vJTVJVEehCHjU2wPBWU/HfS+eZTKOpqnYAYGqP6D7+KahOjGbH0tjwgxA3pdMeGVNW3+gGuMIj1Iw0+jfaNMcjawyHf11zEKdND5n19Wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788690; c=relaxed/simple;
	bh=btE1SSBf2ppninp5hZlLTh1Ze7wMCQmHIDlcN627AHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n9QyYBPUjcLERRRqEfA1T5zy6VLsrwG5GnGAaPgR/48g9dp+DCXvSHQOT+Aipzo7fgUAQJrlNBHVl3EyQD3oScK8uY4lSK7AGB+JPfmHqbiowfJ/g/rlw4AHzpUuByZOLP8YChdTSdBv11gQVZqYda7f/7zAjlbiu5w6gyvmEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amq6ANsm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso729006a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788689; x=1707393489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgRFed7250l9N64QCjQ8hFBeg+HCsu07CH0EHC9iNUQ=;
        b=Amq6ANsm2k9X284qPl5fCKhN5jy6QRXbrZzkB+UDdIqjkL+qJf+L8WcEpzvCpmmtGZ
         T/GUBup73G64bcp8Wto61rovTT+4JuX0k1hIGKnUNCUf8dng13A1sQ3/+LS1RVe0/7hM
         4uFTpZsy0Q6OGdcwnAH9OcMLLtVEIpYEWghMp/IpzQyXQEM5ODodZtlcIwh2aqJip8Hd
         mQA3yaFcvdI35iKq9kwtHwGYrDdNlZxBRtfQQmld7dbOtBIkgB1NrZaQ0TGf5E9UpuKh
         cETZfb8hChduGpoOqoKYAmv7ZJ50348CkU8VSloA7FrFtaqn+VLMi9WRYnykHlhRkLId
         MDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788689; x=1707393489;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgRFed7250l9N64QCjQ8hFBeg+HCsu07CH0EHC9iNUQ=;
        b=BEnJ7jKs0hW2VZk/EhhJlpABZ8KZpCsMUvETLqsI1ZKEqsHnu6bHodgqvwalfZnhHU
         M/NjDM6x7+7908l3GpC4j/LtnJVkpSDdeO22hveuGhOHDpQcYHyBcQzngtv3A/rGLshb
         XVPOZ6sQGxTT6thTN3/lw1wuJ916ZRw6YXvH364BNnbhZ0XjIue6f18tzU0N5CKU7fod
         ZPc2MskXNAcJ5V5BqBbccRVxdcoTh+Dn191oWfIQhh4c8S1EQ6wWepNumHEUEINHYIwL
         spgqxenihRY5ZsTd3hoiCzWqJmnzvM0D0LtWGFPtHnE/sUQq2XhO2Wjt5OYhDjH+znMP
         fqaA==
X-Gm-Message-State: AOJu0YxbH82UBQ5yHlSxZV04QH2iCbYOyz/teuWjSfNA6Z3aXLZ45PSv
	CBC7Vqk6sdIU0yS33YsL0ylqUjG6KvtcRGyHftXdTz7HFRqdqN1E
X-Google-Smtp-Source: AGHT+IGUoJfx12DlYhmEvo9OuE0I4u1MIoEdQ/XVRGlbgKoYgQMb48ANVv8FkrDa/nzLgBm2xBV0cQ==
X-Received: by 2002:a05:6a20:2eb0:b0:19c:71bc:ec82 with SMTP id bj48-20020a056a202eb000b0019c71bcec82mr4341564pzb.48.1706788688624;
        Thu, 01 Feb 2024 03:58:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLK5LxqLQk9xP+92asRzKpWhp8TIsjiirrEnk0nMnGalvbPNhAnUi3BfAwKlWu5cxwMOynuzmbRnfbQPlaeL179Ep/V2YegdWKSzG6sfG2OYcBK7PjYa147guKfUbsCBaPMD7A2A==
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id ks19-20020a056a004b9300b006d9a7a48bbesm11754439pfb.116.2024.02.01.03.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:58:08 -0800 (PST)
Message-ID: <f4c6a0a1-e02b-4668-b3b3-0ba04fa079a6@gmail.com>
Date: Thu, 1 Feb 2024 19:58:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] samples: mei: remove unused parameter
Content-Language: en-US
To: alexs@kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240119040012.2925013-1-alexs@kernel.org>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240119040012.2925013-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping

On 1/19/24 12:00 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> The timeout parameter isn't used in func mei_send_msg(), better to
> remove it.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  samples/mei/mei-amt-version.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
> index 867debd3b912..bf14d8a819b9 100644
> --- a/samples/mei/mei-amt-version.c
> +++ b/samples/mei/mei-amt-version.c
> @@ -195,8 +195,7 @@ static ssize_t mei_recv_msg(struct mei *me, unsigned char *buffer,
>  	return rc;
>  }
>  
> -static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
> -			ssize_t len, unsigned long timeout)
> +static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer, ssize_t len)
>  {
>  	ssize_t written;
>  	ssize_t rc;
> @@ -391,8 +390,7 @@ static uint32_t amt_host_if_call(struct amt_host_if *acmd,
>  	memset(*read_buf, 0, in_buf_sz);
>  	msg_hdr = (struct amt_host_if_resp_header *)*read_buf;
>  
> -	written = mei_send_msg(&acmd->mei_cl,
> -				command, command_sz, acmd->send_timeout);
> +	written = mei_send_msg(&acmd->mei_cl, command, command_sz);
>  	if (written != command_sz)
>  		return AMT_STATUS_INTERNAL_ERROR;
>  

