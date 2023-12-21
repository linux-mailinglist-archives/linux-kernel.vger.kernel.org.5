Return-Path: <linux-kernel+bounces-8976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2081BECF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E161C22EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1A651B5;
	Thu, 21 Dec 2023 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM5fgkst"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265C65198;
	Thu, 21 Dec 2023 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso826009a12.3;
        Thu, 21 Dec 2023 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703185705; x=1703790505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76+oyG2G1x0gT7TSaAnna8obnYpV1SthTcTntxCagtY=;
        b=UM5fgkstvtcsonikn3MmV855Z6DkKkqgnExhSeG+34DQv9oI3ZduIEbAwOlr8ptXQa
         vVdYDUhsRqk2optCunr3OXLiH/ONdwEvRc6T5+/g9RCR0OBKX+Qb7GEYG2IUEHedJ5CJ
         mx5PgThZqK1qwYQPUhCwSoikOkZcfMQN42f+arVEHl2haquMwevqhSy3H++iIipw5EXw
         cZNxfNfLPNdUY88BnvcU/8rgROLHIWdWmnytcn09d+GPoj9JKjwLyoVmjiuw0CJbeMsW
         XwC8Ne6AlbTdZ7qdWuHAV698jHgYc7KN/+P0nTbK2z+jBuQKOvGH3Dg48BALw9UovuID
         /qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703185705; x=1703790505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76+oyG2G1x0gT7TSaAnna8obnYpV1SthTcTntxCagtY=;
        b=r5bt5gB0c9uLIWM0Z4MexnbnPKjjHQ34IVPZBxYl8wCc1gLUtHfv8bA5+Huf41OTVX
         6U84qvGixEMc4pMzumk0pVnYI79aJ5erSMPmsSUzW/Q/rfr6iWIPS5ZViu5eraml+Iyp
         DtjK5FRpQB1SBS0oIuqi+Ngr0yRLq34kJdBGRN7GciqlB1FqWe/3U8zO1Et3KUnjk2r2
         gkXzouTGS3CAde3fPTxeIjOyR/4vuiRR8GnhpjQZXhjSmbtaKXmYYw66DvrOmc4HHS6p
         0obMP39HQ680BQzfgwnDfhlUI1nQmSuBf7fH47Zb3i4t9O8EMqg+VhQ4TRtoWrHONkiX
         FInA==
X-Gm-Message-State: AOJu0Ywo1gDeQyKgKSErkpAY6fV/fG28EXjrQrprszvbH2RIeCGPmnar
	wZaMJolJDhjaZegXsg2JfG/mHbGrSl1tlQ==
X-Google-Smtp-Source: AGHT+IF4zGZPazNZTfZ5miRc6/PEO7loJCDDGRSV2wmSChdY5PEy1bwjCkDj2S68lM164f2lBqSy0g==
X-Received: by 2002:a17:902:e843:b0:1d3:eddf:6769 with SMTP id t3-20020a170902e84300b001d3eddf6769mr128289plg.92.1703185705576;
        Thu, 21 Dec 2023 11:08:25 -0800 (PST)
Received: from ?IPV6:2401:4900:5f1b:292f:dc7e:1579:ed7c:8f49? ([2401:4900:5f1b:292f:dc7e:1579:ed7c:8f49])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001d398889d4dsm1975467plz.127.2023.12.21.11.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:08:25 -0800 (PST)
Message-ID: <1f84c8f4-0b21-4e6e-942c-1f987dd5f63e@gmail.com>
Date: Fri, 22 Dec 2023 00:36:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: input: convert drv266x to json-schema
Content-Language: en-US
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231221181423.671432-1-anshulusr@gmail.com>
From: Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <20231221181423.671432-1-anshulusr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I mistakenly submitted this patch to the iio subsystem and CC'd the no
longer valid e-mail of Dan Murphy.

Kindly refer to the patch below for further discussions:

https://lore.kernel.org/lkml/20231221183109.684325-1-anshulusr@gmail.com/

Apologies for any inconvenience,
Anshul

