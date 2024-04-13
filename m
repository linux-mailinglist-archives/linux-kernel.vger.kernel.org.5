Return-Path: <linux-kernel+bounces-143669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD18A3C27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94971F211AF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD343F9FB;
	Sat, 13 Apr 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L13OnTJT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB13D97D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003079; cv=none; b=ZC3NINOFnBJW+lhe1I8+n9bhxfNquZL7TamFiv8Ylf+zpIHUpm/J3IxzZfGeCSZr8n2Hyz6trfn3jqAereRxmSCQRAmJnNbmR7wkH2mK4B2x3m+1hsX2z0FqD4QQSpBllcMxjNBwzDK2NFJ1SWXTX9zha6XkgW7KZ3qwrhIb/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003079; c=relaxed/simple;
	bh=xcTftBjRZvwlkk8acKfxRbwFXnReE8SDXxuve6hq6xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R6VULed550u2m8XAAifUSRwoxqKWInPCYKq8QGhk3ZsmwLY0pEX8tzvjHfrxESoQH000hyV84olK9JG7OrsP/dbpCEYjKS6VK4B5c7XFSnLp+GSXNm2QUq5tRHAw1ZO/3j/q/qfPLIMmEd6W1snC7tPUKK0iUzw1Nr3eRRdZbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L13OnTJT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418307295d9so480015e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713003076; x=1713607876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbKfGuYck1Dd0mERclSatwtewewkeFmLREd40MUNYkA=;
        b=L13OnTJTvBTzDIbl20wO59bz8oZ/kGxW2/gd8EySHlOlWLmfx3eLAFeneJ4NrSO1eV
         WZH69S5f+AeUQnGbfwPSl2f2GpB3HPCAdh3D4Lw01gyGZLTgv3b0NuKvmkw1w0n5ndb+
         3ggNbDJBWQCYJGgDHMLTOnmoMJmZ605rQ07p7toBLUcbjfvql8OxqJLMKi3aibHY/AJY
         yxi/BaW8/JU8vlZxggN0OjAC6Ja0tVDvgKIe7VoMCkaf0uG5LhFTL4vCdz7M8xjJn5gO
         iRdXdJNsVE+uG3pej6+hrjESSS8TkNNN8Z9CQvquffQPQYoiZBiJk5dy5WhSGwgNVoe0
         jiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713003076; x=1713607876;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbKfGuYck1Dd0mERclSatwtewewkeFmLREd40MUNYkA=;
        b=bmbJcax8aiCduDwi0DRBcgVAceuMFg8CM2eVY8fUPXxG2f0EcNdGD22cPhoKjzgwEt
         pUhmv7w8yWSJbG2cKzdCBDpor0q8uGxfMrIfqD+1SWI81QYgTVvmeRY8R0eunBAucuhr
         d39cI1hvR9FMPvnmGUjxgv5IRwHrxii55BvYYOXA3EiPKWIxInPVaq+3KgQ7ljzxI7Hr
         Kzo1dZSWlUzK69vcJuEbALmh0uh5Rnr6SRCIPDoLqHtwVfK8Io90q4StDDHWUgsAU6+h
         5xM6+CWGsy5JoLFZVV5ZMwh9c/bB+5vDcXlWqE+xMd38RbPPHjlAM0gcXExrJuohkgSl
         FByg==
X-Forwarded-Encrypted: i=1; AJvYcCXpaf5BN2mUADbHlt80rYh0CAA/dH8/vwd2JAKXLXhvUkxN+KRZCAHbzf0ljpDOO6KNIwv5jz8lkqYrTuEknEYlARVXmAj0+cKbmbTl
X-Gm-Message-State: AOJu0YwssCTovBRBNL6TARfSSfjft2OH+ns1YEDW2Ln566Xp9BfY3t/b
	2pifTXykjybFaS4Tp22zWSyiXJPgUMME5L88IW3psbIb75Lc1NjsJiz88ddK5Os=
X-Google-Smtp-Source: AGHT+IHhRdVLgzREwxCECb/fYsU548C+a1eRJL0NJIZN6+VsDOHADU/O5DcTROxt1Lrela8AVF6nXA==
X-Received: by 2002:a05:600c:4510:b0:418:ef3:6cfb with SMTP id t16-20020a05600c451000b004180ef36cfbmr2033253wmo.26.1713003075890;
        Sat, 13 Apr 2024 03:11:15 -0700 (PDT)
Received: from [172.20.10.4] (82-132-212-30.dab.02.net. [82.132.212.30])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm11773696wmb.46.2024.04.13.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 03:11:15 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 David Collins <quic_collinsd@quicinc.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
In-Reply-To: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
References: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
Subject: Re: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
Message-Id: <171300307446.22846.7815957106245497089.b4-ty@linaro.org>
Date: Sat, 13 Apr 2024 11:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 23 Feb 2024 15:29:55 -0800, David Collins wrote:
> Emails to Shyam bounce (reason: 585 5.1.1 <sthella@codeaurora.org>:
> Recipient address rejected: undeliverable address: No such user here.)
> so change the maintainer to be me.  I work on qcom,spmi-sdam as well
> as other PMIC peripheral devices.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
      commit: af868167a7090ac3c065580cb1959fadac3cac87

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


