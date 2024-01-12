Return-Path: <linux-kernel+bounces-24782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18682C26A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FA71F21987
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE446EB41;
	Fri, 12 Jan 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XML8ROoH"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426B6E2B7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so8777669e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705071806; x=1705676606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=toiihwgbBXQtxuvplwPZBYyqQgpc30K6w6RtC5O5hmA=;
        b=XML8ROoHt8d65P08AM15DZUPJXKIP/W0H0Ps2CLjxH2tT6iL5apC9jRDwW5uwdt/O6
         k85Z/FrfvCrB82vIL86Z5xKS8O8pc8S1QqGHIWjoyhu7bqqe7t3ftpa9NXjvmfi0vOvS
         4j8ge9FRIcsa8JvZUg84mPvL2UTpvyBB0A4K8VnNF1UYaaqE7PKrG3Sb6wnTCnoasfVO
         2PumFY0V4SDT8fhqLDfH+Hpm5JiRWqhlHWGFJf9sLChZEiGSGp4wWY97Gr3bRxTBHcPx
         kx3yA9R4cIk1jzPC+nfVUZCSPHihXuE0OKqiXMHN7lqv1290rJ9ZKR5hQfGPG7faHn0H
         YTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071806; x=1705676606;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toiihwgbBXQtxuvplwPZBYyqQgpc30K6w6RtC5O5hmA=;
        b=BFjbnNbGS4CcBjmsDbjNx+8E9WalSXdeHIKYfdT0LsL/B666vdb99RR9ioCD9nTlxc
         kaLws2CmLM/KdkHhHqK8j1/z7Mp0laQg482KvV8HP0xCW/OZ2ExyJFiFZ0VWb4foL5uq
         1r7VoV4SDVz+Z1XvME4+309P9ASceNEC9T4h8/R+p65PTCPTOkPIa96DDhYN7jjli4je
         YKEuM+y1A/jgECLgw3APyiALFFWoBDghCmPLx8oyqdUSRHyn0WgINMOWFSb3PJhy0EhT
         ILyQNQhL0EOasaWU16mgDV6v21npjjFElY+N6q4adv0BB9DBJeh9ehvDqIpmiU/ah7AN
         QPMw==
X-Gm-Message-State: AOJu0YzdA8wfHYdSKOhu7glLxJlCuPBovQKhBwEyLdYl5XGgoFDr87mK
	lcAe+cJSIHXdPs75bBTPiL2yXpY8bcokUA==
X-Google-Smtp-Source: AGHT+IHzWoBI/gw1ovzwFkaSh6dvJAdJYu8plavA7O8fbIQgYwdeuATmAxUsfd6HZf/jobqSR+6l8g==
X-Received: by 2002:a05:6512:3b0b:b0:50e:4e6b:9cd7 with SMTP id f11-20020a0565123b0b00b0050e4e6b9cd7mr1128581lfv.12.1705071806353;
        Fri, 12 Jan 2024 07:03:26 -0800 (PST)
Received: from [127.0.0.1] (85-76-114-160-nat.elisa-mobile.fi. [85.76.114.160])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b0050e7d22a9b8sm520518lfo.89.2024.01.12.07.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 07:03:25 -0800 (PST)
Date: Fri, 12 Jan 2024 17:03:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jie Luo <quic_luoj@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_soni@quicinc.com,
 quic_pavir@quicinc.com, quic_souravp@quicinc.com, quic_linchen@quicinc.com,
 quic_leiwei@quicinc.com
Subject: Re: [PATCH 1/6] arm64: dts: qcom: ipq9574: Add PPE device tree node
User-Agent: K-9 Mail for Android
In-Reply-To: <6fc9e65a-709a-4923-b0b3-7c460199417a@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com> <20240110112059.2498-2-quic_luoj@quicinc.com> <a42718a9-d0f9-47d9-9ee8-fb520ed2a7a8@linaro.org> <de0ad768-05fa-4bb1-bcbc-0adb28cb2257@quicinc.com> <CAA8EJppeQdB4W8u0ux16pxBBwF_fpt1j-5aC0f849n9_iaaYtQ@mail.gmail.com> <6fc9e65a-709a-4923-b0b3-7c460199417a@quicinc.com>
Message-ID: <1552D7D8-2D1B-4236-A5BF-02B68DC919CB@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12 January 2024 16:40:02 EET, Jie Luo <quic_luoj@quicinc=2Ecom> wrote:
>
>
>On 1/12/2024 12:06 AM, Dmitry Baryshkov wrote:
>> On Thu, 11 Jan 2024 at 17:31, Jie Luo <quic_luoj@quicinc=2Ecom> wrote:
>
>>>=20
>>>>=20
>>>>> +                    reg =3D <0x3a000000 0xb00000>;
>>>>> +                    #address-cells =3D <1>;
>>>>> +                    #size-cells =3D <1>;
>>>>> +                    ranges;
>>>>=20
>>>> Put after reg=2E
>>> Ok=2E
>>>=20
>>>>=20
>>>>> +                    status =3D "okay";
>>>>=20
>>>> Drop
>>> Ok=2E
>>>=20
>>>>=20
>>>> All of above comments apply to your entire patchset and all places=2E
>>>>=20
>>>> Looking at code further, it does not look like suitable for mainline,
>>>> but copy of downstream code=2E That's not what we expect upstream=2E =
Please
>>>> go back to your bindings first=2E Also, I really insist you reaching =
out
>>>> to other folks to help you in this process=2E
>>>>=20
>>>> Best regards,
>>>> Krzysztof
>>>>=20
>>> We will do internal review of the gaps and update the patches as per
>>> your comments=2E
>>>=20
>>> Thanks for the review comments=2E
>>=20
>>  From the first glance, the bindings do not follow upstream principles=
=2E
>> You have all the settings (tdm, port config, etc) in the DT, while
>> they should instead go to the driver=2E Well, unless you expect that th=
e
>> board might need to override them=2E
>>=20
>Hi Dmitry,
>The TDM configuration varies per SoC type, since the ethernet port capabi=
lities of the SoCs vary=2E So we will have two different TDM configurations=
 for IPQ5332 and IPQ9574 SoC=2E The driver also will
>need to support future SoC, so we choose to configure this from the DTSI=
=2E The same reason applies to the port scheduler config as well=2E

If it differs from SoC to SoC only, it goes to the driver=2E Point=2E No o=
ther options=2E Thank you=2E

>
>Thanks for review comments=2E


