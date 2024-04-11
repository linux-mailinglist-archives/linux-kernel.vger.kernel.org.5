Return-Path: <linux-kernel+bounces-140197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953098A0CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2289AB24888
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44F145B0D;
	Thu, 11 Apr 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0H3guOs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B1422DB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828758; cv=none; b=nPgY9gSwWL7oiV0RUbM5kPhiua08eOb2TdtJDACzUpG1U6T9WladP+QZxnrf/GyBgw4bk+V68fUP9NEcIX4tNkN/A+9iRXFFTa6tR/DkL2yynfkvXCdIPk73xHLp+GB3cUyplZUbViKwgi+WQNaf1mNK7YKp/JB9bpm88Du3WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828758; c=relaxed/simple;
	bh=eSyKcInUKbmtE5Y1+3hBHxtToRvcjM10VKeKGmaF0V8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G1JjiIdJpnlT7eUGdWXfheDwTpAc6xR9W1ul+qxkakkhaGNPYignWEs2UmJl58qfxkMKh6XvlLb5+AwUM9GmMRheosZ/IJVCYBzk31fqMBNTAbXj8HynShjescupOE4hccLeV2+93imTUlAPR8cniINjS63EK+tsdy4jfVTG490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0H3guOs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso4985799f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712828754; x=1713433554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soqiGAyue3FuM/b/TmgD29RWhuxHuHd7HM0YcZRTcDc=;
        b=l0H3guOsl7T2ol1cvoZnKtesqt/E0jXeQDXXvxN8VJ6HxpUoUR3Je4DynE/DfiMUeb
         h0TKHeDvn760RJoH3ehKloiVGlycSl63njdYCyLg0QVVVxIksQzt1x7pdu6gTHV7ELA5
         MfcDj2WHtefQ+VuloX0cZ0jvMCTwLkCUhFflp/lS8FS58nc1UgMjFbl13ZLo/Bu3fVrq
         +9YaK0EDyz85Nhz27MiaM8RQ52rBiBmjA5pM8tvUKeH4dbm7Y6V7JICXLF+jHPrneHQ3
         gi9QsAyIr5iZ8PycrEJsnnzPLyjG/NRYlWU3bTlOj0t+Ur7BOsE96vtkGv/+k/Kw0piG
         FJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828754; x=1713433554;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soqiGAyue3FuM/b/TmgD29RWhuxHuHd7HM0YcZRTcDc=;
        b=GnvKXZfLpGUs9WiK03SIRIWAOcFna2Upoka7pbRAp5GVjTWOSYuAK+O4UVLTP5yO1+
         Tpcvd1rphMhkI5YaHIryyBtyV0D+5xl7CKRGeXvwNaLlj9LWHQUb7GwLhb12qBfD6yLT
         mP4tnnSZdq5NjQvlvBpExS3/WIxVhH4LcWIX4E1Ev2iZdoyyd4EahDTJBAJwt3k9dySn
         7MHfUg43KxOKM/PSxKbu7h/2Ah3Q6x45eo969Gl0AWUAyJxJKBdIYwIhZzCoFxyXfciL
         5w5k39iF/DUpl7DOfEsRUIZjUTu18fgCwyysw8HYqi+pMAaTgeprqBqXh+tofsZz+GAv
         pIdg==
X-Forwarded-Encrypted: i=1; AJvYcCX2AuYnVNy1BJDcN1uyunp3LvizfxR3k2f7/HNvDlK8ZxvXKG+qv1BIfl2oLmFPzyaQqSmloe5Dqlzrjwh7jSyh48iwa1R0ZqU9yH/3
X-Gm-Message-State: AOJu0YzMmRweYevMllOzWmruBHXSGty72wtdPO+q5vJR2giDko/42PWK
	xa4cYxSzRqZvSKznn7CvSJq4j2NhYHQlU+BzgMku6MZrkL5uFdbmipSlBvHYoo62JzJbF9oXiFy
	i
X-Google-Smtp-Source: AGHT+IHUpiBhwrClG1Yb1ijNQVSZvTkZWBxIBXCiKjub2VkkWSuV69NprTyCfS/hJrUjAf6b5Q6RTw==
X-Received: by 2002:a5d:4c89:0:b0:343:a4eb:b85b with SMTP id z9-20020a5d4c89000000b00343a4ebb85bmr3781716wrs.67.1712828754607;
        Thu, 11 Apr 2024 02:45:54 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id e34-20020a5d5962000000b00341c6440c36sm1357739wri.74.2024.04.11.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:45:54 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, 
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com, 
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com
In-Reply-To: <20240308124129.7833-1-quic_vdadhani@quicinc.com>
References: <20240308124129.7833-1-quic_vdadhani@quicinc.com>
Subject: Re: [PATCH v2] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Message-Id: <171282875386.157849.13077540195293855777.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 10:45:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 08 Mar 2024 18:11:29 +0530, Viken Dadhaniya wrote:
> Currently we have auto suspend delay of 1s which is
> very high and it takes long time to driver for runtime
> suspend after use case is done.
> 
> Hence to optimize runtime PM ops, reduce auto suspend
> delay to 100ms.
> 
> [...]

Applied, thanks!

[1/1] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
      commit: 5e8e32f818138fff0087d7a9708806db49b650a4

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


