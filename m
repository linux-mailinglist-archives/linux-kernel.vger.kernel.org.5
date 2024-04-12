Return-Path: <linux-kernel+bounces-142790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7348A301E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5020282C08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694286274;
	Fri, 12 Apr 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuC9Yqjy"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977D85262
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930539; cv=none; b=g7sjnljQZkBI0/zyHy5es5JjzZYuDBlYD4atD4f/6oNk924vhUtVjW95FDIpRJt0uWFP9U0kA4bIgLhtNhYZ+kTZUhjK2tQnTeEK0GLHf6cWFWj9O9DnIBL+vL0a1KfbH8QzFFkQsirVGHUI5kTAAqIcuHQTXOqE9wWGL5fW6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930539; c=relaxed/simple;
	bh=vFqpAUpwG2hQHfLMXGbRQ+Tlu6lvE2ntl/2PebRnDtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvhDqcthrmpcdXnhiezCyzMtIU1iVpQzwGiuBM2PfWeGNrcnblUBpcuGqShW5U/V3oRL/F6YRGxTlXI6ldUjz2OzlUWZaOuAaFcSMzuwR7UEHNz8SCBzOHBcAiWey5ond76oOzcq8a90muPmPs7x7TmBLcHi+ok88NM6hYEaifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wuC9Yqjy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343e096965bso556696f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712930536; x=1713535336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFqpAUpwG2hQHfLMXGbRQ+Tlu6lvE2ntl/2PebRnDtQ=;
        b=wuC9YqjytB9QALueZFeaRqg0XqsErNHARRf55Tt2LRy6aSHCiHi0gtSSlO2HfXM5Kj
         jcip1Z2Cj3dklBhKV7ZRAVqIheSs+h3x7+J4WVsUG/bAeeV0EWbmBNdB8Cuxh9WcpMRQ
         6Iz4lp7CsXDJyY61tJUsuFDjIuQ++NYQVnewBZPCbIscHb524+R7JT/NMxZl3gsh2cqT
         tpqFrffTixYWoAgbQmCS8om1HpbB9Ki3bTojNf++qkg5QoYkfIhz7XHaa0B/NIXF1h8F
         gH/TVKY+2vghv/TfG8/qO8J7+DVjekuuXmkmYYaxfbrQDDtGUToDkP9BSLaqyL/oMPvh
         qefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930536; x=1713535336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFqpAUpwG2hQHfLMXGbRQ+Tlu6lvE2ntl/2PebRnDtQ=;
        b=wcV8qKPqF0tOcp/MaNuxs9/L+tVbs2l8c326vt1ZzRH2VfnuS8rptNONKo18IpWHoD
         3XebszgZixeh2xLqrPPuYMpBWScexNimUS9+FiVf0E7yA5ADwCvbKACtc+mu8sMDWKyc
         8d8+q4xRKbSa381q0YeggsLe7+6Z/IeqemxP67j4ysltXSdDbyIQZoKDSY3roVdXC49e
         WBaSvYNiVlJrC97JKljtPc3WM7Gmy2Gl+uGivlV8BqnzryIFKtVl3atAHZRIXG7lQh8P
         oSxm2pluCJmre12BgLnPC+PVuOscIG5HEy8MO6xoyTxluoo7Anfw8CZVzcnhScOvoi9K
         SzrA==
X-Gm-Message-State: AOJu0YyVfHDMdDnTxuoVU2p8eixzTEUSvkH3ioNWI4tPNO/1Xr3dR6TQ
	wRPlKTqeSVYgW89NV4aRp7GKPUCMWNvBPThSiZIQxEYc/7fXQkCCVmoPrV/WgR8=
X-Google-Smtp-Source: AGHT+IEXLLoh5B8UK347uf+zWqPNnsyjaSIbmHG7dITBS9HSlhge4UABfAYlZqwG5EmSFIBvUYb5/Q==
X-Received: by 2002:a05:6000:2c2:b0:33e:7f51:c2f9 with SMTP id o2-20020a05600002c200b0033e7f51c2f9mr2899188wry.49.1712930536440;
        Fri, 12 Apr 2024 07:02:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id g4-20020adfa484000000b0034330c9eccasm4393665wrb.79.2024.04.12.07.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:02:15 -0700 (PDT)
Message-ID: <f5518c05-d334-4b78-a2ba-eec8fbf10d8c@linaro.org>
Date: Fri, 12 Apr 2024 15:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] mtd: spi-nor: remove .setup() callback
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-5-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-5-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 14:44, Michael Walle wrote:
> There is no flash driver using that hook. The original intention was to

because you just removed its single user, xilinx. Please specify this in
the commit message.

Also, you can get rid of the address conversion thingy.

