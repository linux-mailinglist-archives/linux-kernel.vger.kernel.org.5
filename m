Return-Path: <linux-kernel+bounces-117847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418F388B063
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D291FA5FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554EA3398B;
	Mon, 25 Mar 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY2fZTNt"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4183DAC13;
	Mon, 25 Mar 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395966; cv=none; b=PJLH0bHYbyJE9dqz4RQzXELSiacqO+cPFAGcH3w2SUCVqGMDFtDdBrFm4y/Wtt0kST5HJIbBXWGj+rr2cK54CQetcmqYmCjjNeaboSGkRxq48/2ny0ygGD/kCEKAGDK0GOzqcPTn0wX+EhaoIiJ6Pn6DGcR9+TPOufFuzzTySrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395966; c=relaxed/simple;
	bh=ejrVfskYF+z12WQcu4RgeQwNwZ41srU284yBLtNzEUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdbZ7u04PbZyQVcR4l8EPz5vvPAoDU7AttPxHQsJDy6368hbce2KfhxFzMpUY6dtDjmLkL9kobFOJl2rCyhNeyepc4pTOm8Vi/SehUZfeYd9tiH3UiYWybmhFsJK7k4XajwDN/noREgl20PCVUZVrJICqt0PIKFquvjdpVIl4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY2fZTNt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51381021af1so7319142e87.0;
        Mon, 25 Mar 2024 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711395963; x=1712000763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxH1I50D13dH7ykhtOkVbN9CCmrYWH6O7UWZMGJn+Cc=;
        b=nY2fZTNtNZKuFGoK6wrnQr5EDUIbakwZBKVQ8od0hGXZrEY921FA1BlUfYypdhDtf5
         MlTaHjyVpJ4ZDcWiKxyiyf/crTAFdXR4bHkmuEh72tQMByJM5fba0+OcsOwrh0my8F4w
         BCTgKdrji3UPCH3TWf/yUMp/gG2B+1PwnjcbcAkdbgJKpCurJ3S2SPDqkwI4C0F+kItr
         3Zs3tGpf7V5ix3+u9G9nQxAdvXaV0AX+PCa45EAgfYL8pmU1Dw0RUfRHGBASx3By4My2
         VgdtWuVVU46RcolOQCFSWdg6frejHo+Odl6TR/TGt6TOuIQ48A3VCbWiueWQA9LafQPP
         +wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395963; x=1712000763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxH1I50D13dH7ykhtOkVbN9CCmrYWH6O7UWZMGJn+Cc=;
        b=WP+yXjPWZZ+pJM6mV76AXSGySlfmYcomgVW1nYaTEZoM6ufzdT9rijU86cBbu5omRI
         nQueuHLqc8tF8GMvF+Ino6TR4UfUqcY0ToBbaNBsZIGInFwQwGePx4QuTkDVcaPykfe8
         GOUOadXQRVz7SFlLfyM7LO5CiNKeMwj79omNLh48qXcG0nf/Y9UoHnVTab3fdPi0D8j5
         9XZdX3ZMQHoG2+Knchtyh4kRqtOY08bTeAUxihVasxbWpr9MGJZtMFalMSvT/k+qFxNZ
         B9yF+1KZ1hDXzprGz0cGfFziWQw2SrcAChTMK9odsUOAe6PF9xi+KLeFOe4IV43mr38g
         hwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+kz/iRz4d1Qmxrvn80aM/gnuwRqLtpBnwJQZQAOUtnSjj26aspkjeDssFwZJrJ8i6rIAOnh9mIsqUtA9vFtVLSri4QaxbNHnIKL1UrJLxy0RP2qnOzyqdh+fyQ0Ey8xUPKKSpeunoA/G7Vw0uRWZE9HuBGK9UuIhhNw439VfpJ0KkA==
X-Gm-Message-State: AOJu0YxqnsxfhWln7n3pwd24XXzJ7hMAewqmTQmVGO7A27jr8p720r0a
	Uv5xuINbsAgfcKd63P3cHv/T3u4pigrpbzRIMHllE3IFYS8YrVsR
X-Google-Smtp-Source: AGHT+IEzfHvR9Yxi2ZA48HLyIyJoVedDJotElXfnpLmQ3n1R6VGcTSZfcMMIOYOZm8NwL3GCHYjvSQ==
X-Received: by 2002:ac2:510b:0:b0:515:a665:94ba with SMTP id q11-20020ac2510b000000b00515a66594bamr4695438lfb.19.1711395962677;
        Mon, 25 Mar 2024 12:46:02 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:36af:6d49:8348:9a76? (2a02-8389-41cf-e200-36af-6d49-8348-9a76.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:36af:6d49:8348:9a76])
        by smtp.gmail.com with ESMTPSA id hg12-20020a1709072ccc00b00a4734b07436sm3405028ejc.141.2024.03.25.12.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:46:02 -0700 (PDT)
Message-ID: <f765a609-529c-4987-812f-9135041f63d5@gmail.com>
Date: Mon, 25 Mar 2024 20:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: rtc: digicolor-rtc: convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
 <20240323-rtc-yaml-v1-3-0c5d12b1b89d@gmail.com>
 <20240325160152.GA4035876-robh@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240325160152.GA4035876-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 17:01, Rob Herring wrote:
> On Sat, Mar 23, 2024 at 11:46:15PM +0100, Javier Carrasco wrote:
>> Convert existing binding to dtschema to support validation.
>>
>> The binding has been renamed to match its compatible. Apart from that,
>> it is a direct conversion with no additions.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml  | 37 ++++++++++++++++++++++
>>  .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 ----------
>>  2 files changed, 37 insertions(+), 17 deletions(-)
> 
> This could probably just go into trivial-rtc.yaml.
> 
> Rob

Does it make no difference if the reg property is a single address or
address + size? trivial-rtc.yaml does no specify that ('an address' is
mentioned), and I don't know if it is obvious for someone who wants to
use this device.

Best regards,
Javier Carrasco

