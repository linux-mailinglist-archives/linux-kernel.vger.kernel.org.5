Return-Path: <linux-kernel+bounces-3563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B11816DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791B01C21D45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B0C48784;
	Mon, 18 Dec 2023 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvOPFjeQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40234F5E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702902174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2SdDeSPPlV/nfiFkU1ioKbqxWQd9T9C6ET4cb22Btg=;
	b=GvOPFjeQDFvzh0O1R1gnsjJhlxyqIm2jE493/rTgiiq41EsqNbWZWkIgbvm4OtBbsagz8F
	SXcuAlskFlxri17yWqv9RD5CzXYRm99QSMivcwCT3vFGJKufbgcUKeTXUQUrLgduJLhQYx
	CaWQmPHb7q8Qzj7aAwjpbr0LoOij1j8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-bBVRray3MtSCA6JVSbMvRw-1; Mon, 18 Dec 2023 07:22:53 -0500
X-MC-Unique: bBVRray3MtSCA6JVSbMvRw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a19c5cbbe86so168065466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702902172; x=1703506972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2SdDeSPPlV/nfiFkU1ioKbqxWQd9T9C6ET4cb22Btg=;
        b=P2CV8++y5gL7ufUYpGJyV97GqW02d2C6OwmbKf1mbh10yeOEQZUepN3juQMkR3b+4F
         FnJrMVdRvxPnSsFA0c1Eu0QpwvPflPsXS4l9pcCW2sps8dpxi2qHMlqyc5M2q+l6Bd8H
         bTmB1LOoTvUKWNY2KtZpY+mXB6qXfIaibHs2W0AkTSwPGRHsbQWkeSEycrp/2IRwufBY
         8zNo2Dnb+xB3FRNdTFWSxNzE/2kr3Yr2EsEk/FxyosD/xiSGzsWhd27pP7EZvR/cyI7j
         c35ZMxn/06MR9yijSjoUrOc3d0n1r8/fzIxEhfunGZXc/0q9FqPaMcYyHJjqxjflxcuz
         lx8A==
X-Gm-Message-State: AOJu0Yw6icI07Y6og7ulnPxpFTAmTWIq2XMZZCs8hzelS1SDdzSpanYK
	U8NV7xx/9uIhu0vgfgCQUw7m5NF3Hw3eGL5iTGGtAEdloBbf+8Pxync5rbHxZ2yOI4C9nUbxRJg
	uZXCrqxVD1qt/axUgLQirqx8I
X-Received: by 2002:a17:906:24c:b0:a23:3361:bd0d with SMTP id 12-20020a170906024c00b00a233361bd0dmr909641ejl.10.1702902172277;
        Mon, 18 Dec 2023 04:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmNos2aSDQzZ+hxz0X7hqbynZkCOhJkD6jHnhqTozeXmGFUEAx6B+3aH8+YoHuNxYHCSLs0w==
X-Received: by 2002:a17:906:24c:b0:a23:3361:bd0d with SMTP id 12-20020a170906024c00b00a233361bd0dmr909639ejl.10.1702902172001;
        Mon, 18 Dec 2023 04:22:52 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a10f3030e11sm14085551ejd.1.2023.12.18.04.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:22:51 -0800 (PST)
Message-ID: <c9c5fa54-9407-4613-b251-efca237c840f@redhat.com>
Date: Mon, 18 Dec 2023 13:22:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vishnu Sankar <vishnuocv@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 markgross@kernel.org, vsankar@lenovo.com
References: <20231214134702.166464-1-vishnuocv@gmail.com>
 <702d46c3-f4a1-142e-c8a3-1e462934f9ea@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <702d46c3-f4a1-142e-c8a3-1e462934f9ea@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/14/23 15:52, Ilpo Järvinen wrote:
> On Thu, 14 Dec 2023, Vishnu Sankar wrote:
> 
>> Some ThinkPad systems ECFW use non-standard addresses for fan control
>> and reporting. This patch adds support for such ECFW so that it can report
>> the correct fan values.
>> Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
>>
>> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>> ---
>> -Improvements to comments as requested.
>> -Removed the usage of unlikely/likely while reading fan speed.
>> -Improved and clearer print statements to match the current style.
>> -Changed seq_puts to seq_printf of an unrelated section of the patch.
>> -Improved the readability of the code.
>> -Added more clearer comments.
> 
> Nice work, thanks.
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Ilpo, thank you for the review.

The patch looks good to me too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Ilpo, do you plan on sending out one more fixes pull-req for 6.7
and if yes, can you add this patch to that; or shall I merge
this into for-next so that it gets included in 6.8-rc1 ?

Regards,

Hans



