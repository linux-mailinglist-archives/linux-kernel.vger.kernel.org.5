Return-Path: <linux-kernel+bounces-1105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB5F814A74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB5D284CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE6315BC;
	Fri, 15 Dec 2023 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mv/g2a0A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA43172A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c6736d10fso8925905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702650426; x=1703255226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ULcrY3kIS+SQU2mVVxzzl29mcLOvRWX6tiA+fzMsL4=;
        b=mv/g2a0AckdP9zFPrNNeicALESrEjRzQzXAWHjhhI5Se2nIjxB+WoIZ+BafNcIucJe
         gp3oJBeZEswi85O0e+1CwslkYaVvjG5kz9wJzXSEpYQMau1FMKuKiwv8TkSh4kpam2HV
         Lu4pXD2P5thBtqHx+9KJ+h/GGMQGJviIKy+hsRgX6FYDm3/km1SDvb5KW0yjMCmaekto
         M9Oyc3KHhms7RZN140Ll0cvFWLWenZ2Jfnk4/m4IUY70Yx3YOV3P93gmVYpRqQvwfJPd
         xB/+vkB1hJzhFaO6T/9T8r59+DQy21Hl/Xg3m3T7TO445qVG9R4FauweskREfduQfcyH
         zVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650426; x=1703255226;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ULcrY3kIS+SQU2mVVxzzl29mcLOvRWX6tiA+fzMsL4=;
        b=bpjdi62OJRJaiX24gqx6qjZJIP5uwVmAIJQ0WCbajOj4Foq84/qjQoLhkOWcPYVvLh
         kiuCKS+r9GvO9d5QzZlegXQ0gyKBG1+YozDT1BzyE5lcHgHDQPW8xDnlql+XQFtlrAQs
         FSKfdLV0V/ChWe0HitCxHC+LllK+ibLhG1VcpJOmvu8Mkowukv9/Mj4t3kIDKyDlC4WQ
         qa+hnqLyMKp7WIm6O7z7NI37MPa1s9oEKQ2uv6NfW1e3Dn6HrhNePALiUKVpzpc4eAsT
         aCPLnQ7qunJw5Z6lwlEhryi7RsIdNU3PzQVuJVsfZjQIDsRUobKzSHO4xrINs58HfN7P
         A8Bw==
X-Gm-Message-State: AOJu0YzM+9/cy+0uVNdpqpUeBItT6E3mdSpiA5ymSE4ggGUvLhZANvOD
	poMj6nDBc9/4dLoDnCqcOpWS1r869QJWmXSkNWsxpAty
X-Google-Smtp-Source: AGHT+IG9wf3SYeMcofeEHL7KS2b9aU+fXLb7V7ILTLAzv7W8hMu9mJz+xFNugNdx/mptsH4eZrmAVg==
X-Received: by 2002:a7b:ce8a:0:b0:40c:61f1:7fcd with SMTP id q10-20020a7bce8a000000b0040c61f17fcdmr1715937wmj.155.1702650426028;
        Fri, 15 Dec 2023 06:27:06 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05600c1f1500b0040c25abd724sm32158835wmb.9.2023.12.15.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:27:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231215-s4-dts-v1-1-7831ab6972be@amlogic.com>
References: <20231215-s4-dts-v1-1-7831ab6972be@amlogic.com>
Subject: Re: [PATCH] arm64: dts: amlogic: fix format for s4 uart node
Message-Id: <170265042524.3306004.7156643290374411600.b4-ty@linaro.org>
Date: Fri, 15 Dec 2023 15:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 15 Dec 2023 16:28:00 +0800, Xianwei Zhao wrote:
> Aliases use lowercase letters and place status in end.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/1] arm64: dts: amlogic: fix format for s4 uart node
      https://git.kernel.org/amlogic/c/f1e2e85bb06b942db86992a8a3187ffe9807939c

These changes has been applied on the intermediate git tree [1].

The v6.8/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


