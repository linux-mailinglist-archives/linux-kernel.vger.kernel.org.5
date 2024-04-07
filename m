Return-Path: <linux-kernel+bounces-134634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACBF89B3F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00F1281141
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071F3D988;
	Sun,  7 Apr 2024 20:08:28 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016443D3BA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712520508; cv=none; b=K/n3mON9T8dCHpaFT+x44LI5QNA0d7yZWPCmPLCP/BYLh+ie1r3XyQAyD7cJ0B6NG8/9E3ZceOs60lKR0LU4r+j6hke/G2ZKf5ruSNgupguwi17OvPuh7dWXxCLdK9rHNrwHjUWJYa5O4JyoJsXrKTuawNfBpNVSm6w9ppMsLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712520508; c=relaxed/simple;
	bh=GbnSwLmnptyRkcjn6p8Yi9zoYP+iIoTU6qIYYZ2FN0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO01qjAU0I+q4IX1+nAjb2P2Fs2leSKSirWBqiFq+aw5mB5tyVVFkCfc73EUG0dbje9nl2F4EcMdfMFOHog1OrHORQ0Fj3j9G87UkAqO7y3NgzQRs6oPBBBo86Q4qlK1mPBGJTGKMf4/YrNxb6dJJ1EMIQGF9p0EWenNwsidR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4167082dabdso181245e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 13:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712520505; x=1713125305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z59eKGisbG/GVwZ41NOAkympydkJlAvl6JclA5ptAW4=;
        b=a09b+QbmkXDCH888aIX1eWi6aTDmYdJvubBZU7Nh+hqGF6IfBXmlc7WfHW/hqf4Rms
         xGLFkzqCXB8YjZjJ4Rx553dNmssUHuliJ8/jGISVFA0FSbVBC+kO24gcS4br4huzFOWH
         b01vBoJN8R4HQxEGD8K0LJ0XceLMq/e4iJyLqI/9yp8KDRg03kinuSoyE6hHzgJF4l64
         K32tjtlFESLLtJza8aIqlXJMxxTK0tSKsV73jmMQqp9e55MCoAUnXjBiIf7xHIk4Z2Su
         NyzYFyyCMwAj5cpOH+tGgrYYlPITJhzxUnCtQGZ8CeHy5D8vlpDyz1rlPHdazh1vl4hg
         oqJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+DP4+metKeziK7iWohgQbIXpfMcIlLVM3snpYgn88mg3em/cuzpHkGtPCsfGM5+J0gBld15S8iFrHpBYSQRgLJotQb9hcZ04waxjz
X-Gm-Message-State: AOJu0YwMiYcNw7x+7Bq4DLm3aSm4V7e+vVZRazwj7xBWNtPN+x8ySrB7
	5gel3IvD6Q5SCc/PFPi205mdIzWjxVYk3FXJ06yOAlalnCGA1EMm
X-Google-Smtp-Source: AGHT+IFbPIOq5EP4wvRPLUOjCwF64ufM0/+5/bxWBDsG82CRtuWR0RyEFHCnmSXszVXn3J9JBlOD7Q==
X-Received: by 2002:a05:600c:3b26:b0:416:3de5:1367 with SMTP id m38-20020a05600c3b2600b004163de51367mr3432106wms.3.1712520505315;
        Sun, 07 Apr 2024 13:08:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm14000449wmb.7.2024.04.07.13.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 13:08:25 -0700 (PDT)
Message-ID: <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
Date: Sun, 7 Apr 2024 23:08:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/04/2024 2:50, Kamaljit Singh wrote:
> Sagi, Chaitanya,
>   
> Sorry for the delay, found your replies in the junk folder :(
>   
>>   Was the test you were running read-heavy?
> No, most of the failing fio tests were doing heavy writes. All were with 8 Controllers and 32 NS each. io-specs are below.
>
> [1] bs=16k, iodepth=16, rwmixread=0, numjobs=16
> Failed in ~1 min
>
> Some others were:
> [2] bs=8k, iodepth=16, rwmixread=5, numjobs=16
> [3] bs=8k, iodepth=16, rwmixread=50, numjobs=16

Interesting, that is the opposite of what I would suspect (I thought that
the workload would be read-only or read-mostly).

Does this happen with a 90-%100% read workload?

If we look at nvme_tcp_io_work() it is essentially looping
doing send() and recv() and every iteration checks if a 1ms
deadline elapsed. The fact that it happens on a 100% write
workload leads me to conclude that the only way this can
happen if sending a single 16K request to a controller on its
own takes more than 10ms, which is unexpected...

Question, are you working with a Linux controller? what
is the ctrl ioccsz?

