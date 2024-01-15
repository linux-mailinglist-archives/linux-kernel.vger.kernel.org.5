Return-Path: <linux-kernel+bounces-25807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E582D616
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99C7282017
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F23D521;
	Mon, 15 Jan 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MY8AMHzm"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A8C8EC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4b72f2bdbdaso2136149e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705311363; x=1705916163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=MY8AMHzm0zzOfE2kr6s0KuzGxC/DQaMOpBZZ0uCIv+y0f+omuYjJVAbp9q2Z5Qp0X4
         Wrq8d6OGszExGkO9g/sXYeITWABv+L2RzYeqVg6+hhtI4mVjxwhhVktAaVh0xjdZWtTH
         EmlE4iI02mKFxVh5mvFjsB7TUhlKD2CaYhchEGFhfDAF/VmmzvUuHMR2wzGoW5L8mGgu
         buuxRdT8gUfkLNoL0ept8VwDmeGTwMsotZzxDndfJ9vtG+puIT1wLFDXBzxN6d760Fog
         rZ2vrB67ETxFvJHoF4Fm0Tp/yulVBG6Bl8Q3gbp/c6F5Ki26Tmmy+eTnpquD4GvfqzEF
         Vdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311363; x=1705916163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=qXw1/WisIfWMKEAqktBiETLSBRQY1MnKIMgKxyx4r3CGMzCIXXUm68kMMDjtrJ0t16
         haJqg5o/yUzKI665qCs/I0KMvhxdcFxyk3luvUYYFSytiAqtk/ievwk7WznYXAKOVSL/
         jWOGu7uF6LTyPw7tG6VCmMELGUUleStTT9KODAfucQFg42oKQtQz3TNLQr3xmguAe9zm
         f37zC1Vje/I0gvAzeeiVRLoPi0UcNQZdwNYnGYOlBXPBceJcmyg/KHq14e+xuMNrBt7g
         6v8v9lmXoKlTHe3FBr2pvxyR4rqnZINLsHuzCmyk0IydzVg6g7PF0WOMWLF6s9LCZPwv
         skUg==
X-Gm-Message-State: AOJu0Ywd39WVQMHy8e9gI+xZ22cKRjQ6Y7xWo/uz336e7NEYJp3r+c0J
	XNlFP05Xa94Bi+nompeQ3bxNdNL7EKkhfw==
X-Google-Smtp-Source: AGHT+IGGpV3oXR6Nk+SH5Y2vZo1QzHCDIEQux3dJgPdZlkMMXEgHJ8y5qSO2K+Y+gdoFxXcB+hnDyg==
X-Received: by 2002:ac5:cbeb:0:b0:4b6:b867:c83f with SMTP id i11-20020ac5cbeb000000b004b6b867c83fmr1922016vkn.22.1705311363678;
        Mon, 15 Jan 2024 01:36:03 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 13-20020a056122084d00b004b718a667ffsm303915vkk.32.2024.01.15.01.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:36:03 -0800 (PST)
Message-ID: <18e88ee0f8cf1d91588d79e4dd2813d0f3720aa8.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Mathieu
 Poirier <mathieu.poirier@linaro.org>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Date: Mon, 15 Jan 2024 09:36:00 +0000
In-Reply-To: <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
	 <170432630603.2042234.10993333941885772911.robh@kernel.org>
	 <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



