Return-Path: <linux-kernel+bounces-63147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB468852B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8630E285361
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900432260B;
	Tue, 13 Feb 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QthXsTwt"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1472622071
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814029; cv=none; b=cgN0IvwTn55e3mQrbkVwq1RZB10uYtmQo7pzYGvX6Maj9iwqEPxIApMJrY94zlg7zRa0xGlD9BJArUBt3W1BGN5lb3dzlyMB6vT/22P3j6Od4PhGgcVdx+oXi188J4llrMt6Vw2qR2LmjEqrfy2QAFgtT8xfuOEHqrRhOelPpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814029; c=relaxed/simple;
	bh=feHR1tLwybhlF1V/LdPQ2c9nnARvJh14IDRqudFggak=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gk65nwVb9IMhP5KvteC6rfN23bCZItDpqqqaklx/rajFyl0ZSqP2krzfzg8r6rDiXkZRZidLYZ8rc1qRGQVVM4R3pkM28TKYqyoAbuT13iq6e46mGn3JHl2kv/zJLkMOJ8IIJpG/+kWiQzSifQS7ioi/l3tsjMVPIgKIhzW4ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QthXsTwt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4108cbd92b9so20856975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707814026; x=1708418826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bMuvH0iAd1PF1SqewdYWpyy5Y0tdOMX7cQXxUHvDxE=;
        b=QthXsTwtQafPsRi3iKnw5qeo6PGq8MQs8UFIFOzMUeJw3zLrBp+EYNBU0Fjwo44J5Y
         Z45oH7LgH2R83V6Tf4YLX07aH2pc+44/H6VWLWcCwzZmuimDVyFSZ8UqMvIYHxNZqed5
         S78F79iD/XFJOUxZnD4DH3ux+LM3qTWnP5KpTQ+Dzg7RICopwDON9U0qmf/qnTghhT+0
         Ny+sl3jglAGgPSo5KOyEI/AI7gy0frfG3SBX3scAGSl9WnJUytpzrHWDrPg1GiGSJoM6
         eRUIsyalxdBRSU3wRIt7uvS+VPHiLCaolI4x6iVwEe1EqDyHaaEvUyuoPxnA/qbKv+/s
         2TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814026; x=1708418826;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bMuvH0iAd1PF1SqewdYWpyy5Y0tdOMX7cQXxUHvDxE=;
        b=Rw69q4PZtsXcPrrbfC7kpr8+ArU1xnxE+zIvefAF68fj6Fbh8GXjP5teM6oSPVEkF9
         jmD+bKuSKoOM7/dP2yVGT+cXhEHJ+TzzVjNupT/DhXUslgARmT5dt8AeEQuABvJ9/9Cm
         Z/InmVvi9vcWW7UywjvkkEibl2tnIRkkz/CgWqWnmDxQ1oba88LJ8El72/Frn6LhhxpT
         u6h/03O5FctWqYYIkeOUJqvorgxw9YefTQYrRiLGkq5ZZ2c9PknOokMXCsvfqItDUAWu
         at/PPXuUxktLwuUvLqgWuDpvpw6B8mJEW132sBVsfQf/RXO1PMgIVBJcU+U+FLxpHXa2
         f4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLjBGBu/G8wX2uUpPfLerLE61xGRawU/QpYRyJrFUOiHaDDzyq7M3Tz4w+lYuto9NKmTJgR8BPRUNJ9H/mm+nDFu1EUPJF/j76ECWH
X-Gm-Message-State: AOJu0Yzs4C6cJ5ieqpJ1rUA62I/sqFMb7lFreYEZijeq7j36oqDozddn
	QbVQ76L4/STBK257IYOEXR4IT1Nipv7W0BPQqlIiRLqlr87qFd32a2FNVoqOd6w=
X-Google-Smtp-Source: AGHT+IHvZXD6aTIXgxH0gj/o6SMcypm6Vv7aNNwbZen+YjTIa0tXzmaj5smryIRlTZy31rQVzQ3gGQ==
X-Received: by 2002:adf:e848:0:b0:33c:d9fb:2277 with SMTP id d8-20020adfe848000000b0033cd9fb2277mr547252wrn.40.1707814026377;
        Tue, 13 Feb 2024 00:47:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC1qJ7tZeYGV3VCxAPxWDpzfUgIzUvslWupu8cLCnp7RwIrBfwoDSzMKdhtqVIC5Lz+SjPJ/OBBTfCvWbIXfPWLY9Cv03a5bz85A7BxkXkF6qZDhitI/8rSX87ZIVoHC6RLEe4EVKA4TuxkswMKn7/g4X0zljBeHgL97vVvp6uu9/1px+7uK489j8KJGw0bBvwvuHR8DZ+tY6oApdCKMQpRqYT33/2lV66/k9s8KAXFCK2ayPWAYIIpM4oijGt2P62Y5BZInv/Lo9EuLpVRdS3C7tONGSUpUN3Ma7IB9X2Qam4Kw6ECH/itTPkgo2FWPdXy+mFCCXQCkT5JLE52A13q8e0HkgLHxIKI6KKhOmv0xANVo6G8KZUEwr1d8FGmikPTqlrdmPoS5Xr0iGiABs1qFrOpXSShhIa8RfShXymK41Au4JE5ksD89iWNQzQEeP90ZfW
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4708000000b0033b507b0abdsm8888707wrq.32.2024.02.13.00.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:47:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105252.128940-1-krzysztof.kozlowski@linaro.org>
References: <20240208105252.128940-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amlogic: t7: minor whitespace cleanup
Message-Id: <170781402554.1503948.12321560831974589557.b4-ty@linaro.org>
Date: Tue, 13 Feb 2024 09:47:05 +0100
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

On Thu, 08 Feb 2024 11:52:52 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.9/arm64-dt)

[1/1] arm64: dts: amlogic: t7: minor whitespace cleanup
      https://git.kernel.org/amlogic/c/9225771676d14673acd225a48eaa49ef3998af41

These changes has been applied on the intermediate git tree [1].

The v6.9/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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


