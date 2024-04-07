Return-Path: <linux-kernel+bounces-134628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE789B3D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC521C20CE1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79D3E46D;
	Sun,  7 Apr 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/zEKiSd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153BA3D541
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712518325; cv=none; b=L4JA04ZBNBQAYrLez8NwIC2y0LK9QMqYRw11neqHxoMptTTiuYm42dKnNjLC10UuxaOuDCIESGpl6PeJTKSnYNWPJSKT5pmVUkhW7I9Ug8VK4lYG77IaqEUrbLEpwihl57FGu4ypX3p2RFpPxm3IS6eOQ/KEDhlXvRkgMeOoNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712518325; c=relaxed/simple;
	bh=54i7tPfHaBIpN+pRMkBLaE8r9/vY3iGtE8mQf/9PNys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFHOlug7or+p6SxG9Cnv8VyAnXyF4o5uzblCw0S/H4QE+V2iqLQzAymhA7RHStu1TS3xbaBo9ZAMSvGA0XFkwYXV5KXb6w0BSST4oZkq8+vefQ6qalOzcFS0PcLkJeiXIAsFaH9Qwh7JqhQ3rGUqaic2oRsC37Z5/P0VpImcIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/zEKiSd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41638a0a87bso6618925e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712518322; x=1713123122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZrhXovmX2pkJmHm1RyzDo75MIZ4Fr5A/qwgibhsNVk=;
        b=B/zEKiSdlW0HMoyJDn3nRz/mupZQVSt0jKmHz1w51nHOaELfscic0tgcUZgJmcO7Pe
         gFeQgPHD0dmtGJjOaMZi1j+map9zxUeBHNvFScScueOxGk2+seWwynQ1PbdZm197nQWx
         CKxbLstWS9nwzEgZbX7fND+GxCd5siqZ2hWuOJAgQhwBiKBUdwDAN29qDslcnRmB2lVC
         UE0rQ7BJCsbnSxbLeGQLNfAGSzhh4BR68wEC0Emw4VRPZB0y0QV+FJx9OyniV0Ca1qnA
         2wtpPkSIR79WBCeaex1uHyc3uqE2hgye6Vy5HEh9OL6YPqP+NIGkhxEU05RZMtfhY4UO
         zrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712518322; x=1713123122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZrhXovmX2pkJmHm1RyzDo75MIZ4Fr5A/qwgibhsNVk=;
        b=L+zJNA9+zYtPudHrydT5U1YT/07qykJzKUzaNaI9r4WuQwlZFUz58WrF5Rbq+p/3dK
         yImnCL12h+wagYmp/4+4HCqrKMQJA2zT3+iNVDGqFKIzNsEnXZujyEzaz7DjtPtIjxNC
         H69+a/JZzRHASigNQD1y+MlYJj0MmOQGRCrWdZoOdnCRZVdJQj0uxthU5TGla/MqttFP
         IcABG1BZavMIBHBw0i2RnvCuZ4E4dGPFzdZLnd3Yb/bTijsX/6V0j3vvXUPamJXj+qET
         3af39NNrIYGIJ+tZDVaGlxYECgSz1y1qymYmqqmM+TbTwVMoQMcHGMMHe7kqWLv+3CUo
         5/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9yYgWPjRRJcxGllozA+VUOXeRcZ/tP3r+T4olYsG3dB+j+x4tgRHjLgumDqzmXfNMYxwybPbpOtUNyHfLuZxTh6Jwt/5f2yf2r9PP
X-Gm-Message-State: AOJu0YxG3cfyPQ2WG26J3knqzJCEjzb3KW4GCTZGOrEQcebdBB9JKmFr
	9a8Xt+o9NOge6P29CaacKKuHoCCoYF0ldLDNJN+FtcVpZtSIg72ppps+AWRxZyU=
X-Google-Smtp-Source: AGHT+IEgW2dJnqjQ0m1gkRuqandK0mxDnrYAKBZAPVDNQkYt5AlfNzoXXsJSZr5MpCXSrYxp7U2j6w==
X-Received: by 2002:a05:600c:1e1c:b0:416:6bd7:cd88 with SMTP id ay28-20020a05600c1e1c00b004166bd7cd88mr595041wmb.8.1712518322330;
        Sun, 07 Apr 2024 12:32:02 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b00414688af147sm13990151wmb.20.2024.04.07.12.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 12:32:01 -0700 (PDT)
Message-ID: <c9948be1-4700-4aa5-9a63-10dc215fcff7@linaro.org>
Date: Sun, 7 Apr 2024 20:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: split HPD bridge alloc and
 registration
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org>
 <c1899fae-8669-485a-95bd-0e76738a1187@linaro.org>
 <CAA8EJppBE8xdmc6zQ2VLLPSzmtNq-+03H5skqbnLmLZ8AqSBfw@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAA8EJppBE8xdmc6zQ2VLLPSzmtNq-+03H5skqbnLmLZ8AqSBfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2024 16:08, Dmitry Baryshkov wrote:
> Basically, if for some reason (e.g. because the TCPM returns an error
> to one of the start functions) the drm_bridge is destroyed, the DRM
> driver isn't notified about the event. It still keeps the pointer to
> the bridge pointer and can access freed memory afterwards.

Hmm, my concern/question is about the TCPM code triggered by an IRQ 
firing here, racing with the bridge code.

If you're happy you've reasoned about that and it won't happen, then 
apply the ACK with the commit log fixed alone.

---
bod

