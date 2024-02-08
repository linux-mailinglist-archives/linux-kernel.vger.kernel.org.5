Return-Path: <linux-kernel+bounces-58471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88B84E6ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA612845D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E382874;
	Thu,  8 Feb 2024 17:41:03 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFA125DA;
	Thu,  8 Feb 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414063; cv=none; b=WyeNzmGQ9nq+qU4ndAW/ltsH1+fnGKdwmuGJpZAXGT+euHRS0h6cpn5cNyPwpZhOxUZZIUwd+futzoU2X1gILCGs28yswVUS2coCQL1QfY6uy48jJQzKn4D88KUyCSHiZEVJjEdMHxGzgINtrADoQixDxTfM+Cd6ESFDTDdlGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414063; c=relaxed/simple;
	bh=JDlxEd4DUAltJgPtyMqh2rUgGaRPVzcz0OjIShKXtIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr7s4Viewurt7bQgXiLhTKfSFhy9c8F5yoUjEikwct8IaH3OM/qfDnHYhq4BUhpR/Lcpdw/OW2L8DesuOHXgc2rJDRti8NNXqRFG2n7EWok+ZBScgsOE3H2l6IEdTHe0g4DD+wJ/0AV7/RT5xNtDsSF1r/MafXRG4e3N/Ai/aMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d73066880eso153715ad.3;
        Thu, 08 Feb 2024 09:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414061; x=1708018861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDlxEd4DUAltJgPtyMqh2rUgGaRPVzcz0OjIShKXtIA=;
        b=Jq2rvyGUVo3NBnO27UpwBVPLO4sjCa/URCATcRE0zyvCopx6kIOdRpIxPzlUm67vqp
         +N8sMd8nRVrTiuoToBb8TvQvkommp7bSTovBRIjZhdwWljgxCAAvAi+usS2MxrF+dC1z
         yNY4dDCVrTEJtPdur8eeW5LLNl785V2PF4PvC8fF0HGePokMwn30CJiDpIxwDHkELqx4
         EbzxGuKI/diNn3nom6GRNGeFyszxIGULBm8n6EXiOYnShYqGz7d8QEqKtMgRqJQWR2xN
         egc6jZULCyHqOU3mppGKD/diUAdb1D85IAlKuOBJpCz9OILSpUcD9vzACdhSictIoNVV
         ibrQ==
X-Gm-Message-State: AOJu0YyZZYGzd2UIh4EJZS8mS5qyFh3JOoVKGfDFV3P03CLAwZxZley7
	z80g02efr4G8j82mRe4RmvpCn6pij0atrpjnk57kNlmpTSRrxEBB
X-Google-Smtp-Source: AGHT+IFqbBBf6L/TNgl9ud++eiJTxjSFTetMmFD3k56FU/BMtYyyW70vU5kc2Vv9Z8vtEXTsgQRdTw==
X-Received: by 2002:a17:903:1c3:b0:1d9:6895:81c3 with SMTP id e3-20020a17090301c300b001d9689581c3mr10652820plh.22.1707414060984;
        Thu, 08 Feb 2024 09:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwjeR7M737s3YhNB8/OXBJ/YXwSu9RCoYeW2dKcndfY2WOZwrqMkODdN7ilPpGQw5lK3nvu+szGFUZIxSQ2ybJTxDZ8uZz3qzlgWHOIBhl8g5GS/coMsWQb13qveBsmfhspOO3IUE7hQwvdwRRrU/JhEUVKbedMJu8qZHEdtrYv8iJ2YFZFHTSBgiFSjNLVmSv4xYyweIy7p+5DybJBdtO/fqCwR4mH4fde0BktHj5NUiBf6GdRz6H/NbgSoX6Qu/x4rYUu86wC6Vw4an0aGhF2DqQBff9j202E9WX/Wz4HgbaDq8ZIIE6W5uRqRCgoMR/QI71vSkiVJ3aC17+ozL0b3cThc36+NIZfO6euMCxM+uHC9SCc1ovwKGvanjnO82FWHJW2xk3gEW0Dan66v9wTQt9t8QYJJOmjWS7uT7cXlVj5VuDU6Qcw7FZIemJQ8fiLoke7LGh24wWCOos2aZ51NKjhNipZ/+l6I9uQbTfLC29kIrV/XrwkfvgQxELkVQTY+LcXI9q0r+gSkJoXgfMwwX5q491x1zxEOBDQyEZ4ToWgMPzZl4bmoGj8MzcRemj8wzOheYD9EBjfUrDS08WDO+qudgq9BL/+CPurFWY1qMMpVFI1Brr7qRMTdno
Received: from ?IPV6:2620:0:1000:8411:6ab9:a725:60e:97d2? ([2620:0:1000:8411:6ab9:a725:60e:97d2])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902740500b001d7439bf914sm5255pll.235.2024.02.08.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 09:41:00 -0800 (PST)
Message-ID: <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>
Date: Thu, 8 Feb 2024 09:40:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] scsi: Replace {v}snprintf() variants with safer
 alternatives
Content-Language: en-US
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Adam Radford <aradford@gmail.com>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
 Andre Hedrick <andre@suse.com>, de Melo <acme@conectiva.com.br>,
 drew@colorado.edu, Finn Thain <fthain@linux-m68k.org>,
 Hannes Reinecke <hare@suse.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, Joel Jacobson <linux@3ware.com>,
 John Garry <john.g.garry@oracle.com>, linux-scsi@vger.kernel.org,
 Luben Tuikov <luben_tuikov@adaptec.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Schmitz <schmitzmic@gmail.com>,
 "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
 Richard Hirst <rhirst@linuxcare.com>, support@areca.com.tw,
 Tnx to <Thomas_Roesch@m2.maus.de>
References: <20240208084512.3803250-1-lee@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 00:44, Lee Jones wrote:
> Cc: Andre Hedrick <andre@suse.com>

Please take a look at https://lwn.net/Articles/508222/.

Thanks,

Bart.


