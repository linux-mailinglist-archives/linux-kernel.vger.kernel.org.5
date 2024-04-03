Return-Path: <linux-kernel+bounces-129717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2457896ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5913F28AF58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771751465BA;
	Wed,  3 Apr 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RttR61FS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379921465B0;
	Wed,  3 Apr 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147215; cv=none; b=bj/l53qqTZU+tEfcl7nR+YtlBTl/EKhj2j8nGF9TIMb6qUwM9AL1J0n9Jq1VNaWjeepQ5w7rTCt/Vp9755/xdYt35aA/oDs/i1sfhzMtG9dibZneAUPbo7//C+CeAV+Xd8Hc44dtxSg5IC2jtdS2AThIVC74tZcUE4LfOgYiyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147215; c=relaxed/simple;
	bh=ukDQ77z0zTDgEHZ5/JvW3hHKfTwSHmNYJHt/j79mwG0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hVEZ7JQ0KJeXqR+dgDNNS7TUuPnjcaM0rXlKlHnDHDnAiID03Rvi7dzYfoQdt5uXSlMJTw6RgIG64CiTkCGK0PVtGNCpVGrUESbWRlyEiMEH9CQJ5HiSOGIqwt8V4hPk8tLUYJNJlvJRToCABaR5rorOXceT4AjENaCYLz8MFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RttR61FS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41569f1896dso19420645e9.2;
        Wed, 03 Apr 2024 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712147212; x=1712752012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvCLM7KWbyJGgG8sR6Sshx7UgvNmX8RL0J9lEmjrHw4=;
        b=RttR61FSZdPQAYMdxpMrP5N8ZxrxaIBDjWHKI7FRO6o6UnOzHddtkWEQtAo2hpZJML
         WVmq5LmZc0B2xOYwTloCl1Vxg1qRNKRzsaz9ifXtBeInV6CQyijUdfHbT/JLKV3aX2q2
         CbtvrRLzsN7eqKGGTgPDDLRMVL8WCP8HPaFCZVSpOLiYDc0MYIvuGwvpWQDS5w76JRHn
         6HXVRm2ZQB/omBeugfEFcJzqhRbxSKI6A7vd8oETVuwkLAOHdczicUEpwOnoLiP0jQ1i
         2ViaF0D6kZMVaRleJw0v5/GB3O4PxHe2xRqz81XaK9c2JKfG2ebHEDUhNMJ57utV8KeC
         swSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712147212; x=1712752012;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvCLM7KWbyJGgG8sR6Sshx7UgvNmX8RL0J9lEmjrHw4=;
        b=QTwdNGfdSKdKOti7w+GQVWEIgvVBaCNjvhukx/87j3ednZBBbJlkQ76UOx3g/+xn4/
         AMWEY72xWEmcgIMI5ZBT1e44Jpj5Q8FRJ81vbeu1a2SqR8NO+9BROE60I51bE1hS0xJ1
         gFtgl/4GpIkwJzrO/6B4dd9UdoJtp1784EvQDwKpELqwnMiDoGzqohQiCelFdmnntcJ0
         HYS1j0ligVAgLZnbl6pXsJS7xa7TGLOhM3L+2ZFSJDjUOJM8zes1IQNySKkLCWHEAX9k
         dVbbkF3RHVEHHid2mMduF1/KVcK+Bj/f3Fwf2rhpt9w0A24M6oQGR12euPX4BNpl14s6
         NAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJIrYI7bPWFdxfqU9RDdepH1+yzbDS/KjdkA7Ddao5lLjtOTnz4A0gbEPErwc5C73/eYLPshLK5rWOkz77GhM2n9AHLlF9v+nzdX8FgFdBXpfV+L+2wykt0DUT2X+gZhZ6DD0
X-Gm-Message-State: AOJu0Yzk4FphNoHECugevffGqaRZVHkhzrjGVmJXxGBtLNTQSPyHTSaE
	lkHq0cfplwG9eCbaiU7hOOYkEmEe8fgY0X9xY2gfGzRkewb/bKEs
X-Google-Smtp-Source: AGHT+IGep7sS70dltb4GELbCG0CAwiW6bPOkxxFngASD+tV+hVjy7exTGCbfsyuZXiB8HVo3AJ8ivA==
X-Received: by 2002:adf:f48c:0:b0:343:3538:4ee4 with SMTP id l12-20020adff48c000000b0034335384ee4mr10976569wro.45.1712147212366;
        Wed, 03 Apr 2024 05:26:52 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600005c800b0033e7a102cfesm10876916wrb.64.2024.04.03.05.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 05:26:51 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
Date: Wed, 3 Apr 2024 13:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402184832.GO11187@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/04/2024 19:48, Leon Romanovsky wrote:
> On Tue, Apr 02, 2024 at 05:32:44PM +0100, Edward Cree wrote:
>>  you're getting maintainer pushback.
> 
> May I suggest you to take a short break, collect names of people who
> participated in this discussion and check in git history/MAINTAINERS
> file their contribution to the linux kernel?
Whether you like it or not, Kuba is a kernel maintainer.
And thus, semantically, a Nack from him is "maintainer pushback".
That remains true regardless of who else in the discussion is also
 a kernel maintainer.

If you had an actual point, feel free to explain to me, without the
 veiled language, what was so 'inappropriate' about my posting.

