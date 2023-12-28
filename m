Return-Path: <linux-kernel+bounces-12521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9181F60C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD851C22861
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DB63BA;
	Thu, 28 Dec 2023 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU6i4AvY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB628E3;
	Thu, 28 Dec 2023 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d430bac207so23078875ad.0;
        Thu, 28 Dec 2023 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703753041; x=1704357841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LAA70zXm10DEMc6Kjg+/EIPKIlRgUHAWPVMkU39I30=;
        b=dU6i4AvYcfB4XSUjzMpcGIAaWwkbiOsafjjRJ6gyactoKg2WhmJ9SwdThrruk+9H+S
         LFblKOLrXyxbQLDc1spcGmh1VzFQO5mei8SExt6/dUH/vviZOrCXN1UvJJNOXqEKvR1d
         3zVC29mmr36dTGijRDHgVRxY/KKu74TNTH+vcv4YEIYFLstbuR8byN3jFE4SRQjA+GTl
         6cSnYg8a02LcQUVk2BQdfIuT1lr8FjrsM8eNWWubYR4OV39vXaCjSlBFxQ8aXaRK9dgT
         HNXrPkorRw2nb01OuGuPC5qPeGkwAF6nv03gyv71NC13RZI/nKm2o5JVjV8M4l9O1B3F
         4X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703753041; x=1704357841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LAA70zXm10DEMc6Kjg+/EIPKIlRgUHAWPVMkU39I30=;
        b=JsnIIW0h9IJN8RkZvw+1gKOA9olscoou4i7ndPulIeFg4WTYsKI/fpLy+8G3qPpBdc
         gU98E2iwwpdUW8Cki3gdacJ9GTucgWm8aR/UTBn+pjiMoXwUpQrFQIJAt7oGUxT80lXc
         fVuHrw61cprnbKDmJNr5vQTvr7V4TaDyq8pNtRC/hbAEiNmeIEmTQiF7T9gac0vSbFKs
         7KOUYZCRtkgmWs6TuqWuoJLZbhsQ9kRBKaX5dF7Phatb5pDPq5/NoEqatNRSmMdWQtpJ
         y+gk4tyY5+1DoOSFsQGuMmlo8DRSjfDnC3hBDuGaB413PltgCsR8XrNCTssdaDc1rkft
         D3cQ==
X-Gm-Message-State: AOJu0Yzk+hIapv6wecNbUJU4ZZBjy3CFWdK3PynuRSVwBQ5/sq7krIyR
	Z2cZyr5xr6BD6KCONlKhhhU=
X-Google-Smtp-Source: AGHT+IGO2itkv+MUyVX3a5ZejUz/uivujcyirm9UN9HTmneFRG8FpKHBqElJbkLkEoCD0Eecttr+8A==
X-Received: by 2002:a17:902:c244:b0:1d3:d1ee:9bea with SMTP id 4-20020a170902c24400b001d3d1ee9beamr11013979plg.53.1703753040903;
        Thu, 28 Dec 2023 00:44:00 -0800 (PST)
Received: from [192.168.159.133] ([37.175.83.47])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001d3eaab64a3sm13726772pln.219.2023.12.28.00.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 00:44:00 -0800 (PST)
Message-ID: <0cdb0461-ece3-4bfb-b058-9bf75c1f6fd3@gmail.com>
Date: Thu, 28 Dec 2023 09:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net, marek.mojik@nic.cz,
 netdev@vger.kernel.org
Cc: davthompson@nvidia.com, linux-kernel@vger.kernel.org
References: <20231227231657.15152-1-asmaa@nvidia.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231227231657.15152-1-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/2023 12:16 AM, Asmaa Mnebhi wrote:
> Very rarely, the KSZ9031 fails to complete autonegotiation although it was
> initiated via phy_start(). As a result, the link stays down. Restarting
> autonegotiation when in this state solves the issue.
> 
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Is there a Micrel errata associated with this work around that could be 
referenced here?
-- 
Florian

