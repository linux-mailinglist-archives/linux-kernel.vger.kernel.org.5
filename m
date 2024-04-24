Return-Path: <linux-kernel+bounces-157053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B028B0C37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B35286BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D615E7E2;
	Wed, 24 Apr 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAB1FS5w"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5715E20A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968123; cv=none; b=o9U5JkM1w5voTUBNgfWfYHMCHTdBvvXyBSUybPNwBhHshsgz84fpb3POUwxZpHjFrdhEdNi+JYY9Tg5X5PGkJvd/uDBEXXyUQ2V7agV3b3CXEShVd5w4Z1wfvNFeqLVi42zExb3RONNCpqHb4e7sU/HfsZlOiORLxL9jp3BRiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968123; c=relaxed/simple;
	bh=XtI4VZwEvKEnGFjUBEcBf2rIBOmBKZTVTUPJvz0eB+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NM1tDa+9iBJRX9RKRWrq8orNErzE9i6W4sxKoitMb+45DlAxggLkadBswFDXVEEhQOM+o9EeQxARiFuOKaYNZiLKIpUohD0mYzbHpQFnMVJVi+vKjNVHPk7Mj7mE0QkHSajSKnulKUGM1IqZ1FSEf9Io/1oj8S2Jzq4eFqupjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAB1FS5w; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343f62d8124so5638800f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713968120; x=1714572920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ICj7KdxdXgaSdsuHJozfxnMsxvxx/JNeMgnHWWq5E=;
        b=oAB1FS5whJQC1sRm6r3deGcBuOYklcR7kZIVE4mmDVJtzHo5vVzDZpUJnhgyEn6y34
         DGT2yoArqPQ8HtuzVDPJcNPNmwbuuam5TSjRFaIefeNUMsMB8Wf8mQNRigAUtIVsWJCw
         MqclFv/1391VHHkhQYnymTEqLPrmkKe7UFYi7PugAurST0QNCM4VZmAuV3/kUJmg1poA
         nhj6bPEpqF0Emvs3doxE0hdxUqAq9DOc23SUDghj5r9kzUt1g2rP5h/sZjdlSbspMmfw
         Mnfh6cb/6Jb8fQREZvsUExrBpY5AgXGzHePQSy0DFdhweSq8AwXkR2Jweb2dzIM//Bu/
         6NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968120; x=1714572920;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1ICj7KdxdXgaSdsuHJozfxnMsxvxx/JNeMgnHWWq5E=;
        b=PvH5DfK4DMjbNNRfv9Gjqd0DKTuStHv0pnltojBgs0KqCgI18EtTs9uTtBT2IHv9CN
         fYkbJljGRJdEMHU94qAOd/NKgLP/xmv5BbUWyqFdtZvwP5b1P07+utJ1SnYmE9fT4L2a
         eIKWkJLlg5E6lEYg5XuHcPoV8xHVQKdEyd/41RdDIKV1j9mCd/P72rmWteXMBkrg8Gw8
         6tD2YHhL5yVevPTQQFBfHawvYAiP271y2U96bv+1Wi9eS/1OO+R8107wiP1kJ5XwdiPS
         2Hhisli2N7AW0uQXcd3CNnIkg5Tno6z5otNavdZARkPhLzjCEkYIsKEi4pQ5ISbXt6cS
         +AMA==
X-Forwarded-Encrypted: i=1; AJvYcCWNFDvOIOvVZ24YVvE2mEqW3gWNwKfOilJexo45aRS1nPXxPQe5XrjZ6cx4WWiaHPIvEfH6ZDcFroh0f/epP+XS1J/5za+m9IaRQDay
X-Gm-Message-State: AOJu0Yw50fVdBZPMNwxjD+8oZafEjzAkRTpZE2aQU5k47geT8ANVhJJc
	hwUJ60/vqNIzKX/DwuZsvebS2/xeiKBLVvoZajtR+oIliUQ8oxBQ8bdvyLZHHoU=
X-Google-Smtp-Source: AGHT+IFoSScwKSrOFawIKH9Sx1BKf/iAlyYerETZdqOTxPUVubedu5iDyFJQl7TZbqk/Hz1GO82ijA==
X-Received: by 2002:a5d:4646:0:b0:34a:983:6b34 with SMTP id j6-20020a5d4646000000b0034a09836b34mr1545266wrs.39.1713968119646;
        Wed, 24 Apr 2024 07:15:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d434c000000b0034ad657deccsm10106315wrr.71.2024.04.24.07.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:15:19 -0700 (PDT)
Message-ID: <f589650d-ca3d-4468-bbf3-f862fe319719@linaro.org>
Date: Wed, 24 Apr 2024 16:15:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240424133201.19140-1-nikolaos.pasaloukos@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240424133201.19140-1-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 15:32, Niko Pasaloukos wrote:
> Add device tree bindings for the Blaize BLZP1600 CB2
> development board (carrier board), which uses the
> BLZP1600 SoM.
> 
> Reviewed-by: James Cowgill <james.cowgill@blaize.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Reviewed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  .../devicetree/bindings/arm/blaize.yaml       | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/blaize.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/blaize.yaml b/Documentation/devicetree/bindings/arm/blaize.yaml
> new file mode 100644
> index 000000000000..8034aeb7a2b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/blaize.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/blaize.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Blaize Platforms
> +
> +maintainers:
> +  - James Cowgill <james.cowgill@blaize.com>
> +  - Matt Redfearn <matt.redfearn@blaize.com>
> +  - Neil Jones <neil.jones@blaize.com>
> +  - Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> +
> +description: |
> +  Blaize Platforms using SoCs designed by Blaize Inc.
> +
> +  The products currently based on the BLZP1600 SoC:
> +
> +  - BLZP1600-SoM: SoM module
> +  - BLZP1600-CB2: Development board CB2 based on BLZP1600-SoM
> +
> +  The compatible property should follow the format:
> +
> +  compatible = "blaize,blzp1600-cb2", "blaize,blzp1600";

Drop last three lines. Redundant. Your three reviewing folks should tell
you that...

> +
> +properties:
> +  $nodename:

Best regards,
Krzysztof


