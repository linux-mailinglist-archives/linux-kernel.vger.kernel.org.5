Return-Path: <linux-kernel+bounces-96248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755D875935
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00311B25A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D313B787;
	Thu,  7 Mar 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9IcGzz0"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BE13AA52
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846712; cv=none; b=GG9IvPFEQVgFfhxZEjuG36C6FeKPclG11FPdoWOSz9B+ukGo+uF6f39trUJiTnQsk5y+cQ+oaiIf/hL2ZjrIyvqGogDHcB+aU/5YKDtnZj84D71XeqzHSj7FAWouyolxMEXSZMeAm3VSw4HMjs+3OeTyev/NPnoa5wR6pr+nLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846712; c=relaxed/simple;
	bh=fmMP5iKplWZjMSpRw/sZdefxBphDjLLMtsB0POMq9wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrZ/mvm/qhE0/H9957ziAKmDfExcIJWFnpTCEVtrxjBhqmlwJzAKDPQ1pHkzV6jVHcO7GEi06Y5WmaXwAUGaOh8qCsY9EmEF3hNBDTEW1QA7U+QFlja2LwCAkpIQQROQJEKdzjUytLV8lwCBzZsR8ozngxqJFYWsrHWrJAUFZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9IcGzz0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60974cb1cd7so13886797b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709846710; x=1710451510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9hhcys1gNGaG07NYC+PK2//TEd+2vYvb6mO1ZLDuZE=;
        b=t9IcGzz0Nq1flpUvdkBGP5Euh/4CAnc5TKttnLkWvkLIn0vK0i9rW27uOo9+SmUQlJ
         VCzJHkZTAKx47kejlueRP2QE+k5AjymQSVlYHD5qsHOxCA746r7Ga3CVzbtCpph85uJE
         9tDorYeSJPafo9f83e2tH7IoPOd+l2oUH+7b5df3G0ffh5nfJKAxMymyYAF6v8DeZGuk
         2esjb8Go/cTbBn/WpbydR5opCavOrbjnogHsfebj6kS+dF8ROF10DJ7myT/2kYp005Ul
         ZtpZeDSeV3kScmmS4pmy7emHfBqUF45MQ5QP9pPLuCeivqvJAdzhW94033h4yUUaIyWt
         axwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846710; x=1710451510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9hhcys1gNGaG07NYC+PK2//TEd+2vYvb6mO1ZLDuZE=;
        b=LjTQONxA2LhkMhkDpqDrbB+LF3GxlV86hLSTL3PlhD9uyIlfaBgoVlN77aw5ULS4dL
         fr47Q5/HwQrJfhZy9uBWgb25cN8JeVp0o8um486X0Ic5k9r8c32CprEUwJEp2DgJFleQ
         7xxO75mUGLov5Y855Xe7L69tZVKCpjLhhTIEUDTMWrRGjqdNpGafO+jgQ1JMDs/k37o8
         Urx8kX12gdO38OUUwiLHQ9rmLPlykc+Iefwz4mXf1G8s6FwzboUaQQkzP+sh/GKYAmVk
         2x+JwT3jbthEAYLWWvP191fN1mx9e1laAf5rkluyReYiQKPQDedVyAroUIvIrBSgwqBf
         hBqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBF7ylunMA72hWFQ1LCD6iLRzdjEZcdyli4N9u8+5mBs8eUXng0qbryolo4s0IL22I9Nlyhj2EUJPEOjRilPrrpzvc52FqTWH48LE+
X-Gm-Message-State: AOJu0YwSi+iDNeIgCkURZ8HYZG6OpOV3xjtk2Nhsrs4sG+NaHCk0JaGk
	H8DSGIZKKJjakomSowWBvSGdEj7pHFmPlD7FgPDMRnOcrhTnOnJNt2cboa/iq2LvU8TZmxVftm/
	+GC7gHkmO1ry7Olw0x3Oy4tyEOg8A5pQvwhQetw==
X-Google-Smtp-Source: AGHT+IFeiIPNPn9x5gaa4VWCe7fO1lW7o6wG5lJpI4FhUITzOYaLQsMD+ZKsTXTO2rCcXRWB2h99TPW5M52TItEo/AE=
X-Received: by 2002:a05:690c:fc6:b0:609:2fad:a9d6 with SMTP id
 dg6-20020a05690c0fc600b006092fada9d6mr25256866ywb.7.1709846710102; Thu, 07
 Mar 2024 13:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
In-Reply-To: <20240307205539.217204-1-quic_msavaliy@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 23:24:58 +0200
Message-ID: <CAA8EJpq01SPGnJx-YrM=GDRVD_DjYwMQqL9D9v5jADwd3OjVsg@mail.gmail.com>
Subject: Re: [PATCH v3] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: konrad.dybcio@linaro.org, andersson@kernel.org, vkoul@kernel.org, 
	andi.shyti@kernel.org, wsa@kernel.org, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, quic_vdadhani@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 22:56, Mukesh Kumar Savaliya
<quic_msavaliy@quicinc.com> wrote:
>
> I2C driver currently reports "DMA txn failed" error even though it's
> NACK OR BUS_PROTO OR ARB_LOST. Detect NACK error when no device ACKs
> on the bus instead of generic transfer failure which doesn't give any
> specific clue.
>
> Make Changes inside i2c driver callback handler function
> i2c_gpi_cb_result() to parse these errors and make sure GSI driver
> stores the error status during error interrupt.
>
> Fixes: d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
> Co-developed-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
> v2 -> v3:
> - Modifed commit log reflecting an imperative mood.
>
> v1 -> v2:
> - Commit log changed we->We.
> - Explained the problem that we are not detecing NACK error.
> - Removed Heap based memory allocation and hence memory leakage issue.
> - Used FIELD_GET and removed shiting and masking every time as suggested by Bjorn.
> - Changed commit log to reflect the code changes done.
> - Removed adding anything into struct gpi_i2c_config and created new structure
>   for error status as suggested by Bjorn.
> ---
>
>  drivers/dma/qcom/gpi.c             | 12 +++++++++++-
>  drivers/i2c/busses/i2c-qcom-geni.c | 19 +++++++++++++++----
>  include/linux/dma/qcom-gpi-dma.h   | 10 ++++++++++
>  3 files changed, 36 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

