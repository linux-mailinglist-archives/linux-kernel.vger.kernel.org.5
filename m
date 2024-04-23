Return-Path: <linux-kernel+bounces-154632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F018ADEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB69284442
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198C4CE13;
	Tue, 23 Apr 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeOHpGH6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD246447;
	Tue, 23 Apr 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858900; cv=none; b=my6PwZ4Ux1+6BkeR9Sr8yNtmpDEtypHlLWN2sPQKu9WZ48+q6lU4rWtcPDrJ47VXVX34JRUp9WaWGjZCCteJqra/sl/+ska7JvZ63dxWoZjOQGnn78r+xYDLPqLcKZXhyekuAS92RBh8rarBAQRKGDJB/YMhCvqzdsXs9d2h/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858900; c=relaxed/simple;
	bh=5UuB6CXi5ElqkfwREN1HfZ7c8FMEVX4JWVxxnH4Df7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnkEJuId4hlHx5qkrOPhhXG0uSDefURiZYob8JSMvmbKmXToVTzakPN3Gp3pcltlNoJz6DHfGdGkWk+q3K9WWazDuWQ6duZ3Z3ZYsQnJrAu61mRlC8FpFPG6F+Ys3GIlWFAiuNQf2RzqmQ9fjbRvRmL3+ILQvoxEnKv5ccrXDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeOHpGH6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5b6e8f662so41525555ad.0;
        Tue, 23 Apr 2024 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713858898; x=1714463698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agMoA5f411JyDJvtS+yhT8fkSFdQl8o5GANrhQCjrVc=;
        b=TeOHpGH6CG+LmUj0MZNdDx87COPEQOzSGJ2ZGqDAU99ExuUEUtQsGPxigvvgm0ajOR
         qaQJMoGlGbUDBKRGqePnT4JSjlVHJtUBjUWQ8OtkKqWhE+8o9nyv6ORnUJQcCevpKSQi
         5A5eS3/sMtfj4hEJXT5RUicPFxB1TAkiEbH6dr6jQ+9K3+FkLecYSA9Ap88xOkcN/NSZ
         mOfOInSN5E9m838Wsq3LRaVUQd/PKTJt3ngBHH7+PbxTnFve8wgCnvevtDSJkjxemCAq
         JVXa9PO/+W0T0wYY1F17y1l37+53nmuJgZEQzEa5voJi5xdTZF5EaJvwfOXfUuAkTJxf
         UrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713858898; x=1714463698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agMoA5f411JyDJvtS+yhT8fkSFdQl8o5GANrhQCjrVc=;
        b=wRk6KigQi3+VO5dPmtLKlcoGamacYANlm1TWBy6LTqtkcmSm4vrwedZLHyfJEM5WN0
         IyLxMdyuVND5z6TA0Wt+pMiSodwK1Eoc4FMRcRWL+PCwq3Da0nLMM70iBqRvW/Y1Q7Lw
         BrefbRhSp52HEGatDy8VjG3zg0A7CY/evGDa4G9d23qxlIYoTJA6K7vY0FJk7ueDrhOX
         N9c0wAwML0oXEBk74m/y6rwyS9m9ij0zkWDKUpH5pvLaW4n93ST0iPY3xOrdRpmhEV73
         cRDn+s2EYThv3a9MhZfCF/OZeI3/vyPxBn4CJ1qHwLLGlh1tAmGpiCgGsMr3zkoET1C6
         0W6A==
X-Forwarded-Encrypted: i=1; AJvYcCVjoLH1WnKxzEezzy+dNkm+FksvbuDoX4fzPP58qZAH8IgUkUTaOj0En8UrRviqgV9q0gbU7VCpJbwjuAKxuvzCp3EzQ+C7LJNB533yAETQ9btmPcOixGOyMciiyE8woqs2A2Sgh6zOyQ==
X-Gm-Message-State: AOJu0YygI6RWch2kCyzJdEa7kvTannIUWiFUYyp3G/txWoIjs8cNLAqc
	OseJSebqBdq1kvyzNLHNh/KPgyVsS/PIOB66vVErfAPnJZ90itQl
X-Google-Smtp-Source: AGHT+IFTpcIANOjtuEbyvgWkE9+dlhgH0w30ThWifG3zdGe8uwJhivJKKtXveCWmEHopHe1aVhohUg==
X-Received: by 2002:a17:902:d58c:b0:1e4:6938:6fe3 with SMTP id k12-20020a170902d58c00b001e469386fe3mr15510880plh.58.1713858897936;
        Tue, 23 Apr 2024 00:54:57 -0700 (PDT)
Received: from [10.66.66.2] (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001e2a4663179sm9382486plp.258.2024.04.23.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 00:54:57 -0700 (PDT)
Message-ID: <a97420fc-1fc3-4e85-9539-e1a74c711be0@gmail.com>
Date: Tue, 23 Apr 2024 13:24:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] dt-bindings: usb: uhci: convert to dt schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240422122125.455781-1-sheharyaar48@gmail.com>
 <7a43b05c-ca2e-4fa6-b1f9-cb1a12778da7@kernel.org>
Content-Language: en-US
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
In-Reply-To: <7a43b05c-ca2e-4fa6-b1f9-cb1a12778da7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 12:24 PM, Krzysztof Kozlowski wrote:
> On 22/04/2024 14:21, Mohammad Shehar Yaar Tausif wrote:
>> Convert USB UHCI bindings to DT schema. Documenting aspeed compatibles
>> and missing properties. Adding aspeed/generic-uhci example and fix previous
>> incorrect example.
>>
>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: generic-uhci
>> +    then:
>> +      $ref: usb-hcd.yaml
> 
> Nothing improved here.

Sorry, I could not understand this, please guide me about the correction 
required here.
I added $ref inside the if-then block because it was raising errors when 
tested against
dts files that used "platform-uhci" as the compatible. Putting it above 
the if block did
not work.

When I ref the usb-hcd.yaml, it also includes usb.yaml which requires 
the nodename to start with usb*,
but the dtsi that use the deprecated compatible 
(arch/arm/boot/dts/vt8500/wm8505.dtsi) have their nodename with
uhci*, which causes the tests to fail.

>> +      required:
>> +        - clocks
> 
> And this was not tested.
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    uhci@d8007b00 {
>> +        compatible = "platform-uhci";
> 
> What happened here? This is deprecated!

The original example has the nodename as uhci* which causes the schema 
to fail as mentioned earlier.
Should I just remove the example or should I rename the node here and 
add clock field to the original example ?

Best Regards,
Shehar

